#! /bin/bash
#Hi there, This scripts will make your life easier for downloading videos/songs with youtube-dl

if [ ! -e "default_playlist.txt" ]
 then
echo Playlist URl:
	read URL

	SAVED_PLAYLIST="default_playlist.txt"


echo $URL >> default_playlist.txt

playlist_url=`cat $SAVED_PLAYLIST`

#echo -n $playlist_url

fi

	printf "Insert the video Url that you want to download:\n"
	read video_url

		printf "What do you want to download?\n"
		printf "1| AUDIO\n"
		printf "2| VIDEO\n"
	read format_ver
	if [ $format_ver -eq 1 ];
		then 
		 
		 type="song"
		 location="~/Music"
		 
                 printf "Do you want the default quality (best available) or do you prefer set it on your own?\n"
		 printf "1| Default (Best)\n"
		 printf "2| your own choice\n"
			read audio_choice
		if [ $audio_choice -eq 2 ]
		then
		 echo choose the file format: 
		 printf "1| best\n"
   	         printf "2| m4a\n" 
                 printf "3| mp3\n" 
                 printf "4| flac\n" 
                 printf "5| wav\n" 
                 read quality
			if [ $quality -eq 1 ]
			   then quality="bestaudio"
                        elif [ $quality -eq 2 ]
                           then quality="m4a"
			elif [ $quality -eq 3 ]
    			   then quality="mp3"
			elif [ $quality -eq 4 ]
			   then quality="flac"
			elif [ $quality -eq 5 ]
			   then quality="wav"
			else 
				echo wrong input, download will start with best quality available...
			fi
	     else quality="bestaudio"
	     fi


	elif [ $format_ver -eq 2 ]
		then 
		type="video"
		location="~/Video"
		 
                printf "Do you want to chhose which file format to download or prefer to download the best available?"
		printf "\n1| Best"
		printf "\n2| List all types(not recommended for whole playlists)\n"
                read video_choice
			if [ $video_choice -eq 2 ] 
			then
                		pritnf  "the formats available for your video are:" 
                		youtube-dl -F $video_url
				printf "\ndecide which file format to download:"
				read  quality
			else quality="bestvideo+bestaudio"
                	fi
       else
       printf "hippity hoppity! That's not what I asked..."
	pkill -f super_youtube
       fi

printf "Do you want your $type to be saved to\n1| default location ("$location")\n or\n2|choose your own?\n"
	read location_choice

	if [ $location_choice -eq 2 ]
        then 
		echo be aware that the location must be writeable therefore not owned by root but by your user
		echo Custom Location:
		read location
	fi

echo starting your download in 3,
echo 2, 
echo 1...
clear
		
	youtube-dl -f $quality $video_url -w -o "$location/%(title)s.%(ext)s"

echo Thank you, you can find the downloaded $type at $location, bye bye!
 
