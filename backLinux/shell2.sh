#!/bin/bash

# 源文件路径
#source_dir="/Users/galen/project/home/backLinux/test/source"
# 备份文件存放路径
#backup_dir="/Users/galen/project/home/backLinux/test/backup"
backup_dir=""

number=5

while getopts n:p: opt; do
  case "${opt}" in
  n) number=${OPTARG} ;;
  p) backup_dir=${OPTARG} ;;
  esac
done

if [ "$backup_dir" == "" ]; then
  echo '请输入备份文件地址'
  exit 0
fi

# 设置文件名
backup_file="backup_$(date +%Y%m%d%H%M%S).tar.gz"

echo "$backup_dir/$backup_file"

# 压缩指定目录的文件
tar -cvpzf "$backup_dir/$backup_file" \
  --exclude=/media \
  --exclude=/media/D/backup.tar.gz \
  --exclude=/proc \
  --exclude=/tmp \
  --exclude=/mnt \
  --exclude=/dev \
  --exclude=/sys \
  --exclude=/run \
  --exclude=/boot \
  --exclude=/var/cache/apt/archives \
  --one-file-system /

echo "备份完成 $backup_file"

# 获取备份目录下的所有备份文件，并按修改时间排序
backup_files=$(ls -t $backup_dir/backup_*.tar.gz)

# 如果备份文件数量大于五个，则删除最旧的备份文件
if [ ${#backup_files[@]} -gt $number ]; then
  for ((i = $number; i < ${#backup_files[@]}; i++)); do
    echo "删除备份文件 ${backup_files[$i]}"
    rm "${backup_files[$i]}"
  done
fi
