#!/bin/bash

# Define the paths to the syncing and backup directories
syncing_dir=$1
backup_dir=$2

log_file=backup.log
final_log=log_file.log

# Function to log changes to the files
log_change () {
  timestamp=$(date +%F" "%T)
  echo "$timestamp $1 $2" >> $final_log
}

# Use rsync to create a backup of the syncing directory
rsync -av --delete --log-file=$log_file $syncing_dir $backup_dir

# Parse the log file to extract information about changes made to the files
while read line; do
  if [[ $line == *deleting* ]]; then
    file=$(echo $line | awk '{print $5}')
    log_change "DELETE" $file
  elif [[ $line == *f.st....* ]]; then
    file=$(echo $line | awk '{print $5}')
    log_change "MODIFY" $file
  elif [[ $line == *cd++++++++* ]]; then
    file=$(echo $line | awk '{print $5}')
    log_change "CREATE" $file
  elif [[ $line == *f++++++++* ]]; then
    file=$(echo $line | awk '{print $5}')
    log_change "CREATE" $file
  fi
done < $log_file

rm $log_file
