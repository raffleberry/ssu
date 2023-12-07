for file in *.csv
do
    echo "$file"
    fold=`echo "$file" | cut -d'.' -f1`
    mkdir "$fold"
    mv "$file" "$fold"/
    cd "$fold"

    tail -n +2 "$file" |\
    cut -d',' -f1 | cut -d':' -f3 | cut -d'"' -f1|\
    awk '{print "https://open.spotify.com/track/"$1}'|\
    xargs spotdl --format m4a --bitrate disable --audio youtube-music --cookie-file ~/win/cookies.txt download

    cd ..
done

