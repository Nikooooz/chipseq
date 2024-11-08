uropa \
  --bed /media/desk16/tly5201/xys/data/241105_all_bam/callpeak_q0.05/tail-Sirt1_peaks.narrowPeak \
  --gtf /media/desk16/tly5201/xys/R_draw/xys/cuttag_annotion/uropa_final.evm.gtf \
  --feature gene \
  --feature-anchor start center \
  --distance 10000 10000 \
  --relative-location Upstream OverlapStart PeakInsideFeature FeatureInsidePeak \
  --show-attributes ID=evm. \
  --outdir 4tail_Sirt1_peak_annotation




##批处理
# 设置输入文件的目录和输出目录
input_dir="/media/desk16/tly5201/xys/data/241105_all_bam/callpeak_q0.05"
output_dir="/media/desk16/tly5201/xys/data/241105_all_bam/callpeak_q0.05/uropa"
gtf_file="/media/desk16/tly5201/xys/R_draw/xys/cuttag_annotion/uropa_final.evm.gtf"

# 确保输出目录存在
mkdir -p "$output_dir"

# 遍历目录下所有以 .narrowPeak 结尾的文件
for peak_file in "$input_dir"/*.narrowPeak; do
    # 提取文件名作为 id
    id=$(basename "$peak_file" .narrowPeak)
    
    # 运行 uropa 命令
    uropa --bed "$peak_file" \
           --gtf "$gtf_file" \
           --feature gene \
           --feature-anchor start center \
           --distance 10000 10000 \
           --relative-location Upstream OverlapStart PeakInsideFeature FeatureInsidePeak \
           --show-attributes ID=evm. \
           --outdir "$output_dir/$id"
    echo "Finished processing $id"
done

/media/desk16/tly5201/xys/
├── data/
│   └── 241105_all_bam/
│       └── callpeak_q0.05/
│           ├── uropa/   # 输出目录
│           └── *.narrowPeak  # 输入文件
└── R_draw/
    └── xys/
        └── cuttag_annotion/
            └── uropa_final.evm.gtf  # GTF 文件