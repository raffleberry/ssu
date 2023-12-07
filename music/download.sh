count=0
while read song; do
    url="https://open.spotify.com/track/`echo $song | cut -d',' -f1 | cut -d':' -f3 | cut -d'"' -f1`"
	echo "$count. $url"
    spotdl --format m4a --bitrate disable --audio youtube-music --cookie-file ~/win/cookies.txt --output "$count. {artists} - {title}.{output-ext}" download $url
	count=$((count+1))
done < $1

