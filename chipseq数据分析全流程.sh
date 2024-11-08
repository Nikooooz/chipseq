文件名称！！！

##文件名必需是XXX-XXX-XXX_1.fq.gz 和 XXX-XXX-XXX_2.fq.gz  1和_2之前不能有_，只能是-


##MD5检验
md5sum *.fq.gz > MD5_all.txt
##后台运行
nohup md5sum *.fq.gz > MD5_all.txt &

————————————————fastqc————————————————
##fastqc加速版  -j增加并行数
mkdir -p fastqFileQC
ls *.fq.gz | parallel -j 5 fastqc -t 5 -o /media/desk16/tly5201/xys/data/20240907_xys_cuttag/fastqFileQC {}

###fastqc输出路径的优化
mkdir -p fastqFileQC
ls *.fq.gz | parallel -j 5 fastqc -t 5 -o fastqFileQC {}

##后台运行fastqc
mkdir -p fastqFileQC
nohup ls *.fq.gz | parallel -j 5 fastqc -t 5 -o fastqFileQC {} > fastq_qc.log 2>&1 &

##multiqc汇总结果
multiqc .

————————————————建立索引————————————————


###建立bowtie2对比索引
bowtie2-build PlasmoDB-45_Pfalciparum3D7_Genome.fasta pf_reference_index

##放在后台加快运行
nohup bowtie2-build --threads 30 PlasmoDB-45_Pfalciparum3D7_Genome.fasta pf_reference_index 1> bowtie2_build.log 2>&1 &


————————————————质控————————————————
##数据清洗及质控  -j 增加线程 推荐是8 大约四分钟一对
mkdir -p clean_data

dir=clean_data
for file in `ls *_1.fq.gz`

do
        read1=$file
        read2=${file%_1*}_2.fq.gz

trim_galore -q 20 -j 25 --phred33 --illumina --stringency 3 --length 20 --paired $read1 $read2 --gzip -o $dir
done



————————————————比对————————————————
##对比和转换为bam和排序一起做了  这一步很慢 -p25加线程 -@25加线程  比较慢
cd /media/desk16/tly5201/xys/data/20240907_xys_cuttag/clean_data
##遍历所有 *_1_val_1.fq.gz 文件
for file in `ls *_1_val_1.fq.gz`

do
    # 根据 R1 文件名推导出 R2
    R1=$file
    R2=${file%%_1*}_2_val_2.fq.gz
    
    # 运行 bowtie2 比对，并直接通过管道将 SAM 转换为 BAM，存储在 align 文件夹中
    # bowtie2 输出的SAM文件中不仅包含比对成功的 reads，还会包含那些没有找到匹配位置的 reads。这可能会导致输出文件更大，但也可以通过这些信息了解哪些 reads 没有成功比对。SAM文件的第二列是FLAG字段，是一个数字，表示reads的比对状态，未比对的reads会有几种值：4 没有比对上任何位置；69 read1未比对，且其 mate 对象也未比对；73 read1 未比对，mate 对象成功比对。
    # 加上 --no-unal 后，这些未比对的 reads 将不会包含在输出结果中。
    # 加上--un-conc-gz {params}选项，会输出未比对的成对 reads，文件名格式为 {params}.1 和 {params}.2，并且它们会以 gzip 格式压缩。可用于后续和其他基因组进行比对

    # samtools -bS 将SAM转换为BAM -F 0x04 排除 FLAG 中包含 0x04（即未比对）的 reads，只保留那些成功比对的 reads。
    bowtie2 --end-to-end --very-sensitive --no-mixed --no-discordant --phred33 \
        -I 10 -X 700 -p 25 \
        -x /media/desk16/tly5201/xys/index/Sj_ref/Sj_reference_index \
        -1 $R1 -2 $R2 \
        2>> ${file%%_*}_bowtie_mappingRatio.txt | \
    samtools view -@ 25 -bS -F 0x04 - | \
    samtools sort -@ 25 -o ${file%%_*}.bam

done



# 构建 BAM 文件的索引，上一部分bam文件，txt文件，bai文件 align 文件夹中  很快
for file in `ls *.bam`

do samtools index $file ${file%.*}.bai

done


##bam文件的QC，即看比对成功率，构建索引后才能做  这一步很快  但是可以不做了因为前面samtools已经把未比对上的删除掉了-F 0x04
##这里就不对bam文件进行samtools markdup 去除PCR重复了，如果要去除重复，去除重复后的rmdup.bam也需要重新建立索引，再flagstat 进行QC

for file in *.bam
do
    # 提取文件名，不带后缀
    base=$(basename $file ".bam")
    
    # 运行 samtools flagstat 并输出结果到 .txt 文件
    samtools flagstat -@ 25 $file > ${base}_flagstat_mappingRatio.txt
done



# COnvert Bam to bigwig 需要用到建立的索引 bai用的就是samtool之后 建立索引的 构建索引之后才能做
##运行的很快

for file in `ls *.bam`

do bamCoverage -b $file -o ${file%.*}.RPKM.bw --normalizeUsing RPKM -p 25 --extendReads --binSize 10 --outFileFormat bigwig

done



mkdir -p align
mv *.bai *.bam *mappingRatio.txt *flagstat_mappingRatio.txt align

mkdir -p bw
mv *.bw bw

echo "~~~~~~All~~done~~~HAHHAHAHHAAAAAAAAAAAAAA~~~~~~~~~~~~~~~~~"
