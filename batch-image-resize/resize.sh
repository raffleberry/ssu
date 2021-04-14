#no of files to be converted at a time
PROCESSES=12

#max width of the image to be resized
MAXWIDTH=1080

#working directory
current_dir=$(pwd)

ls -R | grep ":$" | awk -F":" '{printf("\"%s\"\n", $1)}' >dir.txt
mkdir resized
mv dir.txt ./resized/
cd resized
xargs mkdir -p <dir.txt
find ../ | grep ".jpg$" | awk '{printf("\"%s\"\n", $0)}' >files.txt

input_count=$(wc -l files.txt | cut -d\  -f 1 )
cnt=input_count

while read f; do
    input_file=$(echo $f | sed "s|^...|\"$current_dir|")
    output_file=$(echo $f | sed "s|^...|\"$current_dir/resized|")
    echo "convert image $input_file -resize $MAXWIDTH $output_file &" >> run.sh
    if [ $((cnt % PROCESSES)) -eq "0" ]; then
        echo "wait" >> run.sh
        echo "echo \"$cnt/$input_count\"" >> run.sh
    fi
    cnt=$((cnt - 1))
done <files.txt

echo "wait" >> run.sh

./run.sh
