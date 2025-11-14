#!/bin/sh
if [ $# -ne 2 ]; then
    echo "Error: Parameters not specified"
    exit 1
fi
filesdir=$1
searchstr=$2
if [ ! -d "$filesdir" ]; then
    echo "Error: Directory does not exist"
    exit 1
fi
X=$(find "$filesdir" -type f | wc -l)
Y=$(grep -r "$searchstr" "$filesdir" | wc -l)
echo "The number of files are $X and the number of matching lines are $Y"
exit 0
