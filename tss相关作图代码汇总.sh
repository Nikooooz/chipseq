##TSS
##单一样本绘图，不生成bed文件：--outFileSortedRegions regions1_M-H3K4-me3_TSS_2.5K.bed
##DPI是默认200 高度默认28  颜色过渡的级数，默认为 256  --missingDataColor 1 空缺用白色替代不然是黑线 #339933 是绿色
##--missingDataAsZero 比 --missingDataColor 1 好用  --missingDataAsZero生成的热图都不会有白线

computeMatrix reference-point --referencePoint TSS -p 30 \
    --binSize 50 \
    -b 2500 -a 2500 \
    -R /media/desk16/tly5201/xys/gff/Sjap.bed \
    -S /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/M-H3K4-me3.RPKM.bw \
    --skipZeros \
    --missingDataAsZero \
    --outFileSortedRegions regions1_M-H3K4-me3_TSS_2.5K.bed \
    -o matrix1_M-H3K4-me3_TSS_2.5K.gz

plotHeatmap -m matrix1_M-H3K4-me3_TSS_2.5K.gz \
    -out M-H3K4-me3_Heatmap_2.5K.png \
    --missingDataColor 1 \
    --colorList 'white,#339933' \
    --colorNumber 512 \
    --heatmapHeight 12 \
    --dpi 720

plotHeatmap -m matrix1_M-H3K4-me3_TSS_2.5K.gz \
    -out M-H3K4-me3_Heatmap_2.5K.pdf \
    --missingDataColor 1 \
    --colorList 'white,#339933' \
    --colorNumber 512 \
    --heatmapHeight 12 \
    --dpi 720

plotProfile -m matrix1_M-H3K4-me3_TSS_2.5K.gz \
    -out M-H3K4-me3_Profile_2.5K.png \
    --dpi 720

plotProfile -m matrix1_M-H3K4-me3_TSS_2.5K.gz \
    -out M-H3K4-me3_Profile_2.5K.pdf \
    --dpi 720





###TSS 多个样本绘制到一起，可以放在一起比较信号强度

computeMatrix reference-point --referencePoint TSS -p 30 \
    --binSize 50 \
    -b 2500 -a 2500 \
    -R /media/desk16/tly5201/xys/gff/Sjap.bed \
    -S /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/*.bw \
    --skipZeros \
    --missingDataAsZero \
    --outFileSortedRegions regions1_combine_TSS_2.5K.bed \
    -o combine_TSS_2.5K.gz

plotHeatmap -m combine_TSS_2.5K.gz \
    -out combine_Heatmap_2.5K.png \
    --missingDataColor 1 \
    --colorList 'white,#339933' \
    --colorNumber 512 \
    --heatmapHeight 12 \
    --dpi 720

plotHeatmap -m combine_TSS_2.5K.gz \
    -out combine_Heatmap_2.5K.pdf \
    --missingDataColor 1 \
    --colorList 'white,#339933' \
    --colorNumber 512 \
    --heatmapHeight 12 \
    --dpi 720

plotProfile -m combine_TSS_2.5K.gz \
    -out combine_Profile_2.5K.png \
    --dpi 720

plotProfile -m combine_TSS_2.5K.gz \
    -out combine_Profile_2.5K.pdf \
    --dpi 720










##TSS-TES  只能识别bed文件  #0066CC蓝色
##单一样本绘图

computeMatrix scale-regions -p 30 \
    --binSize 50 \
    --regionBodyLength 5000 \
    -a 2500 -b 2500 \
    -R /media/desk16/tly5201/xys/gff/Sjap.bed \
    -S /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/M-H3K4-me3.RPKM.bw \
    --skipZeros \
    --missingDataAsZero \
    --outFileSortedRegions regions1_M-H3K4me3_TSS_2.5K.bed \
    -o M-H3K4me3.gz

plotHeatmap -m M-H3K4me3.gz \
    -out M-H3K4me3.pdf \
    --missingDataColor 1 \
    --colorList 'white,#0066CC' \
    --colorNumber 512 \
    --heatmapHeight 12 \
    --dpi 720

plotHeatmap -m M-H3K4me3.gz \
    -out M-H3K4me3.png \
    --missingDataColor 1 \
    --colorList 'white,#0066CC' \
    --colorNumber 512 \
    --heatmapHeight 12 \
    --dpi 720

plotProfile -m M-H3K4me3.gz \
    -out M-H3K4me3_Profile_2.5K.png \
    --dpi 720

plotProfile -m M-H3K4me3.gz \
    -out M-H3K4me3_Profile_2.5K.pdf \
    --dpi 720

##TSS-TES  只能识别bed文件
##多样本绘图到一起比较

computeMatrix scale-regions -p 30 \
    --binSize 50 \
    --regionBodyLength 5000 \
    -a 2500 -b 2500 \
    -R /media/desk16/tly5201/xys/gff/Sjap.bed \
    -S /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/*.bw \
    --skipZeros \
    --missingDataAsZero \
    --outFileSortedRegions regions1_combine_TSS_2.5K.bed \
    -o combine.gz

plotHeatmap -m combine.gz \
    -out combine.png \
    --missingDataColor 1 \
    --colorList 'white,#0066CC' \
    --colorNumber 512 \
    --heatmapHeight 12 \
    --dpi 720

plotHeatmap -m combine.gz \
    -out combine.pdf \
    --missingDataColor 1 \
    --colorList 'white,#0066CC' \
    --colorNumber 512 \
    --heatmapHeight 12 \
    --dpi 720

plotProfile -m combine.gz \
    -out combine_Profile_2.5K.png \
    --dpi 720

plotProfile -m combine.gz \
    -out combine_Profile_2.5K.pdf \
    --dpi 720

#########################################################################################












####到bw所在文件夹进行批处理
###TSS绘图批处理

mkdir -p tss_results
cd /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/tss_results

##reference bed genome location
bed=/media/desk16/tly5201/xys/gff/Sjap.bed

## bw file location
for id in /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/*.bw; do
    echo $id
    file=$(basename $id)
    sample=${file%%.*}
    echo $sample
    ##done check  这一步之后可以down以下看看是否正确提取了文件名称

    ##生成表达矩阵 --missingDataAsZero参数是不显示0的数据，即去掉热图中的黑线
    ##computeMatrix具有两个模式:scale-region和reference-point。前者用来信号在一个区域内分布，后者查看信号相对于某一个点的分布情况。无论是那个模式，都有有两个参数是必须的，-S是提供bigwig文件，-R是提供基因的注释信息。还有更多个性化的可视化选项
    computeMatrix reference-point --referencePoint TSS -p 30 \
        --binSize 50 \
        -b 2500 -a 2500 \
        -R $bed \
        -S $id \
        --skipZeros \
        --missingDataAsZero \
        --outFileSortedRegions regions1_${sample}_TSS_2.5K.bed \
        -o matrix1_${sample}_TSS_2.5K.gz

    ## both plotHeatmap and plotProfile will use the output from computeMatrix

    plotHeatmap -m matrix1_${sample}_TSS_2.5K.gz \
        -out ${sample}_TSS_Heatmap_2.5K.png \
        --missingDataColor 1 \
        --colorList 'white,#339933' \
        --colorNumber 512 \
        --heatmapHeight 12 \
        --dpi 720

    plotHeatmap -m matrix1_${sample}_TSS_2.5K.gz \
        -out ${sample}_TSS_Heatmap_2.5K.pdf \
        --missingDataColor 1 \
        --colorList 'white,#339933' \
        --colorNumber 512 \
        --heatmapHeight 12 \
        --dpi 720

    plotProfile -m matrix1_${sample}_TSS_2.5K.gz \
        -out ${sample}_TSS_Profile_2.5K.png \
        --dpi 720

    plotProfile -m matrix1_${sample}_TSS_2.5K.gz \
        -out ${sample}_TSS_Profile_2.5K.pdf \
        --dpi 720

done



###TSS-TES绘图批处理

mkdir -p tss-tes_results
cd /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/tss-tes_results

##reference bed genome location
bed=/media/desk16/tly5201/xys/gff/Sjap.bed

## bw file location
for id in /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/*.bw; do
    echo $id
    file=$(basename $id)
    sample=${file%%.*}
    echo $sample
    ##done check  这一步之后可以down以下看看是否正确提取了文件名称

    ##生成表达矩阵 --missingDataAsZero参数是不显示0的数据，即去掉热图中的黑线
    ##computeMatrix具有两个模式:scale-region和reference-point。前者用来信号在一个区域内分布，后者查看信号相对于某一个点的分布情况。无论是那个模式，都有有两个参数是必须的，-S是提供bigwig文件，-R是提供基因的注释信息。还有更多个性化的可视化选项

    computeMatrix scale-regions -p 30 \
        --binSize 50 \
        --regionBodyLength 5000 \
        -a 2500 -b 2500 \
        -R $bed \
        -S $id \
        --skipZeros \
        --missingDataAsZero \
        --outFileSortedRegions regions1_${sample}_TSS_2.5K.bed \
        -o matrix1_${sample}_TSS-TES_2.5K.gz

    ## both plotHeatmap and plotProfile will use the output from computeMatrix

    plotHeatmap -m matrix1_${sample}_TSS-TES_2.5K.gz \
        -out ${sample}_TSS-TES_Heatmap_2.5K.png \
        --missingDataColor 1 \
        --colorList 'white,#0066CC' \
        --colorNumber 512 \
        --heatmapHeight 12 \
        --dpi 720

    plotHeatmap -m matrix1_${sample}_TSS-TES_2.5K.gz \
        -out ${sample}_TSS-TES_Heatmap_2.5K.pdf \
        --missingDataColor 1 \
        --colorList 'white,#0066CC' \
        --colorNumber 512 \
        --heatmapHeight 12 \
        --dpi 720

    plotProfile -m matrix1_${sample}_TSS-TES_2.5K.gz \
        -out ${sample}_TSS-TES_Profile_2.5K.png \
        --dpi 720

    plotProfile -m matrix1_${sample}_TSS-TES_2.5K.gz \
        -out ${sample}_TSS-TES_Profile_2.5K.pdf \
        --dpi 720

done



###############################################################################################################
##profile文件中绘制多条修饰分布 TSS
computeMatrix reference-point --referencePoint TSS -p 30 \
    --binSize 50 \
    -b 2500 -a 2500 \
    -R /media/desk16/tly5201/xys/gff/Sjap.bed \
    -S /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/M-H3K4-me3.RPKM.bw \
    /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/M-H4K16-ac.RPKM.bw \
    /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/M-H4K12-ac.RPKM.bw \
    --skipZeros \
    --missingDataAsZero \
    -o matrix1_test_TSS_2.5K.gz

##默认格式
##--perGroup   # make one image per BED file instead of per bigWig file
plotProfile -m matrix1_test_TSS_2.5K.gz \
    -out ExampleProfile2.pdf \
    --perGroup \
    --colors red yellow blue \
    --plotTitle "Test data profile" \
    --dpi 720

##更换颜色
plotProfile -m matrix1_test_TSS_2.5K.gz \
    -out ExampleProfile2.pdf \
    --perGroup \
    --colors '#339933' '#0066CC' '#CE9079' \
    --plotTitle "Test data profile" \
    --dpi 720

##热图
plotProfile -m matrix1_test_TSS_2.5K.gz \
    -out ExampleProfile2.pdf \
    --perGroup \
    --plotType heatmap \
    --plotTitle "Test data profile" \
    --dpi 720





##profile文件中绘制多条修饰分布 TSS-TES
computeMatrix scale-regions -p 30 \
    --binSize 50 \
    --regionBodyLength 5000 \
    -a 2500 -b 2500 \
    -R /media/desk16/tly5201/xys/gff/Sjap.bed \
    -S /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/M-H3K4-me3.RPKM.bw \
    /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/M-H4K16-ac.RPKM.bw \
    /media/desk16/tly5201/xys/data/20240715_xys_cuttag/clean_data/align/bw/M-H4K12-ac.RPKM.bw \
    --skipZeros \
    --missingDataAsZero \
    -o combine.gz

##--perGroup    # make one image per BED file instead of per bigWig file
plotProfile -m combine.gz \
    -out ExampleProfile2.pdf \
    --perGroup \
    --colors red yellow blue \
    --plotTitle "Test data profile" \
    --dpi 720

plotProfile -m combine.gz \
    -out ExampleProfile2.pdf \
    --perGroup \
    --colors '#339933' '#0066CC' '#CE9079' \
    --plotTitle "Test data profile" \
    --dpi 720

plotProfile -m combine.gz \
    -out ExampleProfile22.pdf \
    --perGroup \
    --plotType heatmap \
    --plotTitle "Test data profile" \
    --dpi 720
