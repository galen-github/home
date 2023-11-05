#!/bin/bash

# 源文件路径
source_dir="/Users/galen/project/home/backLinux/test/source/"
# 备份文件存放路径
backup_dir="/Users/galen/project/home/backLinux/test/backup/"
# 备份文件名格式：日期.备份
backup_file_format="%Y-%m-%d.bak"

# 获取当前日期
current_date=$(date +"$backup_file_format")

# 判断备份文件存放路径是否存在，如果不存在则创建
if [ ! -d "$backup_dir" ]; then
  mkdir -p "$backup_dir"
fi

# 备份源文件到备份文件
cp -r "$source_dir" "$backup_dir/$current_date.bak"

# 删除五天前的备份文件
#find "$backup_dir" -type f -name "*.$backup_file_format.bak" -mtime +5 -exec rm {} \;

find "$backup_dir" -type f | sort -nr | head -n 5

#tar -cvpzf /media/D/backup.tar.gz \
#--exclude=/media \
#--exclude=/media/D/backup.tar.gz \
#--exclude=/proc \
#--exclude=/tmp \
#--exclude=/mnt \
#--exclude=/dev \
#--exclude=/sys \
#--exclude=/run \
#--exclude=/var/cache/apt/archives \
#--one-file-system /