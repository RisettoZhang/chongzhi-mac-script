#!/bin/bash
# ./ncmdump -d ../网易云音乐 -o ../netease_dencm -r
# 用数组收集待转换的文件

SRC_DIR="./Music/网易云音乐"
OUT_DIR="./Music/netease_dencm"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

to_convert=()

# 遍历所有 ncm 文件
while IFS= read -r file; do
    base=$(basename "$file" .ncm)

    if [ -f "$OUT_DIR/$base.mp3" ] || [ -f "$OUT_DIR/$base.flac" ]; then
        echo "跳过已转换文件: $base"
    else
        echo "待转换: $file"
        to_convert+=("$file")
    fi
done < <(find "$SRC_DIR" -type f -name "*.ncm")

# 如果有需要转换的文件，就一次性调用 ncmdump
if [ ${#to_convert[@]} -gt 0 ]; then
    echo "开始批量转换..."
    "$SCRIPT_DIR"/ncmdump "${to_convert[@]}" -o "$OUT_DIR"
else
    echo "没有新的文件需要转换。"
fi