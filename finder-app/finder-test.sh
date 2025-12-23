#!/bin/sh
# Tester script for assignment 1 and assignment 2
# ... (Leave top configuration variables like NUMFILES and WRITESTR alone) ...

set -e
set -u

NUMFILES=10
WRITESTR=AELD_IS_FUN
WRITEDIR=/tmp/aeld-data
username=$(whoami)

if [ $# -lt 2 ]
then
    echo "Using default value ${NUMFILES} for number of files to write"
    if [ $# -lt 1 ]
    then
        echo "Using default value ${WRITESTR} for string to write"
    else
        WRITESTR=$1
    fi    
else
    NUMFILES=$1
    WRITESTR=$2
fi

MATCHSTR="The number of files are ${NUMFILES} and the number of matching lines are ${NUMFILES}"

echo "Writing ${NUMFILES} files of containing string ${WRITESTR} to ${WRITEDIR}"

rm -rf "${WRITEDIR}"

# ASSIGNMENT 2 MODIFICATIONS START HERE

# 1. Compile your writer application using native compilation
make clean
make

# 2. Use your "writer" utility instead of "writer.sh"
# Note: Since writer.c does not create directories, we create the path first
mkdir -p "$WRITEDIR"

if [ -d "$WRITEDIR" ]
then
    echo "$WRITEDIR created"
else
    exit 1
fi

for i in $( seq 1 $NUMFILES)
do
    # Replaced writer.sh with ./writer
    ./writer "$WRITEDIR/${username}$i.txt" "$WRITESTR"
done

# ASSIGNMENT 2 MODIFICATIONS END HERE

OUTPUTSTRING=$(./finder.sh "$WRITEDIR" "$WRITESTR")

# Remove temporary directories
rm -rf "${WRITEDIR}"

set +e
echo ${OUTPUTSTRING} | grep "${MATCHSTR}"
if [ $? -eq 0 ]; then
    echo "success"
    exit 0
else
    echo "failed: expected  ${MATCHSTR} in ${OUTPUTSTRING} but instead found"
    exit 1
fi
