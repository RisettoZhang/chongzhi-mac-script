#!/bin/bash

# 获取脚本所在的路径
DIR="/Volumes"

# 找到所有 .lrf 文件（忽略大小写）并保存到一个临时文件
find "$DIR" -type f \( -iname "*.lrf" \) > /tmp/deleted_lrf_files.txt

# 统计文件数量
FILE_COUNT=$(wc -l < /tmp/deleted_lrf_files.txt)

# 检查是否有要删除的文件
if [ "$FILE_COUNT" -gt 0 ]; then
    # 删除文件
    while IFS= read -r file; do
        echo "Deleting: $file"
        rm -f "$file"
    done < /tmp/deleted_lrf_files.txt

    # 在通知中显示删除的文件数量
    echo $FILE_COUNT files deleted!
else
    # 没有找到 .lrf 文件时的提示
    echo "No .lrf files found!"
fi

# 清理临时文件
rm -f /tmp/deleted_lrf_files.txt

