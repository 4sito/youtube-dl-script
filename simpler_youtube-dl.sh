#! /bin/bash

PS3='Choose an action: '

entries=("Video Download" "Audio Download" "Playlist Download" "Set favourite Playlist" "Fav Playlist" "Quit")

	select fav in "${entries[@]}"; do
		case $fav in 
			"Video Download")
				echo input url:
					read url
				location="~/Video"
				echo starting download...
					youtube-dl -f mp4 $url -w -o "$location/%(title)s.%(ext)s" -w
				echo Thanks, you can find the downloaded file at $location, byee!
				break
				;;
			"Audio Download") 
                                echo input url: 
                                        read url
                                location="~/Music" 
                                echo starting download... 
                                        youtube-dl -f mp3 $url -w  -o "$location/%(title)s.%(ext)s"
                                echo Thanks, you can find the downloaded file at $location, byee!
				break
				;;
                        "Playlist Download")
				echo input url:
					read url
				location="~/Music" 
				echo starting playlist download...
					youtube-dl -f mp3 $url -w -o "$location/%(title)s.%(ext)s"
                                echo Thanks, you can find the downloaded playlist songs at $location, bye bye!
				break
				;;
			"Set favourite Playlist")
				echo Playlist url:
					read url
				if [ -e "saved_playlist" ]
					then
						rm saved_playlist
					fi
				echo $url >> saved_playlist
				
				;;				
			"Fav Playlist")
				SAVED_PLAYLIST="saved_playlist"
				url=`cat $SAVED_PLAYLIST`
				location="~/Music"
				echo Starting Download of the saved playlist at $location...
					youtube-dl -f mp3 $url  -w -o "$location/%(title)s.%(ext)s" 
				echo Thanks, you can find the downloaded songs at $location, byee!
				break
				;;
				
			"Quit")
				echo exiting...
				exit
				;;
			*) echo Hippity, Hoppity, retry with a valid option
				;;
	esac
done
