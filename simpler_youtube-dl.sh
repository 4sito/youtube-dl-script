#! /bin/bash

m_quality="mp3"
v_quality="mp4"
m_location="~/Music"
v_location="~/Video"

PS3='Choose an action: '

entries=("Video Download" "Audio Download" "Playlist Download" "Set favourite Playlist" "Fav Playlist" "Config" "Quit")

	select fav in "${entries[@]}"; do
		case $fav in 
			"Video Download")
				echo input url:
					read url
			
				echo starting download...
					youtube-dl -f $v_quality $url -w -o "$v_location/%(title)s.%(ext)s" -w
				echo Thanks, you can find the downloaded file at $v_location, byee! 
				break
				;;
			"Audio Download") 
                                echo input url: 
                                        read url
                                
                                echo starting download... 
                                        youtube-dl -f $m_quality $url -w  -o "$m_location/%(title)s.%(ext)s"
                                echo Thanks, you can find the downloaded file at $m_location, byee!
				break
				;;
                        "Playlist Download")
				echo input url:
					read url
				location="~/Music" 
				echo starting playlist download...
					youtube-dl -f $m_quality $url -w -o "$m_location/%(title)s.%(ext)s"
                                echo Thanks, you can find the downloaded playlist songs at $m_location, bye bye!
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
					youtube-dl -f mp3 $url  -w -o "$m_location/%(title)s.%(ext)s" 
				echo Thanks, you can find the downloaded songs at $m_location, byee!
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
