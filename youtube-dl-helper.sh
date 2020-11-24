#! /bin/bash


#creating new configuration if it doesn't exist

	if [ ! -e y_config ]
		then

			touch y_config

			 standard_audio="m4a"
			 standard_video="mp4"
			 m_location="~/Music"
			 v_location="~/Video"

			printf "$standard_audio"    >> y_config
		  printf "\n$standard_video"  >> y_config
			printf "\n$m_location"      >> y_config
			printf "\n$v_location"		  >> y_config
	fi


# standard configuration
	standard_audio=`sed -n 1p y_config`
	standard_video=`sed -n 2p y_config`

	m_location=`sed -n 3p y_config`
	v_location=`sed -n 4p y_config`


# menu

PS3='Choose an action: '

entries=("Video Download" "Audio Download" "Playlist Download" "Set favourite Playlist" "Fav Playlist" "Config" "Quit")

	select fav in "${entries[@]}"; do
		case $fav in
			"Video Download")
				echo input url:
					read url


				echo starting download...
					youtube-dl -f $standard_video $url -w -o "$v_location/%(title)s.%(ext)s" -w
				echo Thanks, you can find the downloaded file at $v_location, byee!
				break
				;;
			"Audio Download")
                                echo input url:
                                        read url


                                echo starting download...
                                        youtube-dl -f $standard_audio $url -w  -o "$m_location/%(title)s.%(ext)s"
                                echo Thanks, you can find the downloaded file at $m_location, byee!
				break
				;;
                        "Playlist Download")
				echo input url:
					read url

				echo starting playlist download...
					youtube-dl --yes-playlist -f $standard_audio $url -w -o "$m_location/%(title)s.%(ext)s"
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

				echo Starting Download of the saved playlist at $m_location...
					youtube-dl -f $standard_audio $url  -w -o "$m_location/%(title)s.%(ext)s"
				echo Thanks, you can find the downloaded songs at $m_location, byee!
				break
				;;

			"Config")

											#creating temporary file
												touch y_config.tmp

					 					 printf "\n\nCurrent settings are:\n\n"
										 printf "audio format:$standard_audio, audio location:$m_location\n\n"
										 printf "video format:$standard_video, video location:$v_location\n\n"


											PS3='Modify Audio Format: '
												audio_quality=("Keep Current" "Best" "m4a" "flac" "mp3" "wav" "ogg")
													select fav in "${audio_quality[@]}"; do
															case $fav in
																	"Keep Current")
																		printf "$standard_audio\n" >> y_config.tmp
																		break
																		;;
																	"Best")
																		standard_audio_tmp="bestaudio"

																		printf "$standard_audio_tmp\n" >> y_config.tmp

																		break
																		;;
																	"m4a")
																		standard_audio_tmp="m4a"

																		printf "$standard_audio_tmp\n" >> y_config.tmp
																		break
																		;;
																	"flac")
																		standard_audio_tmp="flac"

																		printf "$standard_audio_tmp\n" >> y_config.tmp

																		break
																		;;
																	"mp3")
																		standard_audio_tmp="mp3"

																		printf "$standard_audio_tmp\n" >> y_config.tmp

																		break
																		;;
																  "wav")
																		standard_audio_tmp="wav"

																		printf "$standard_audio_tmp\n" >> y_config.tmp

																		break
																		;;
																  "ogg")
																		standard_audio_tmp="ogg"

																		printf "$standard_audio_tmp\n" >> y_config.tmp

																		break
																		;;
																	*)
                                   echo Hippity, Hoppity, retry with a valid option
                                   ;;
																esac
															done



														printf "\n\n\n"

														PS3='Modify video format: '
																			video_quality=("Keep Current" "Best" "mp4" "bestvideo+m4a" "mp4+bestaudio")
																				select fav in "${video_quality[@]}"; do
																						case $fav in
																								"Keep Current")

																									printf "$standard_video\n" >> y_config.tmp

																									break
																									;;
																								"Best")
																									standard_video_tmp="bestvideo+bestaudio"

																									printf "$standard_video_tmp\n" >> y_config.tmp

																									break
																									;;
										 														"mp4")
																									standard_video_tmp="mp4"

																									printf "$standard_video_tmp\n" >> y_config.tmp

																									break
 																								  ;;

																								"bestvideo+m4a")
																									standard_video_tmp="bestvideo+m4a"

																									printf "$standard_video_tmp\n" >> y_config.tmp

																									break
																									;;

																							 "mp4+bestaudio")
																							 standard_video_tmp="mp4+bestaudio"

																							printf "$standard_video_tmp\n" >> y_config.tmp

																							break
																							;;

                                              *)
                                              echo Hippity, Hoppity, retry with a valid option
                                              ;;

																						esac
																				done

																printf "\n\n\n"
																PS3='Songs location: '
																			temp_location=("Keep Current" "Default" "Custom")
																			select fav in "${temp_location[@]}"; do
																					case $fav in
																							"Keep Current")

																							printf "$m_location\n" >> y_config.tmp
																							break
																							;;

																							"Default")
																							printf "~/Music\n" >> y_config.tmp

																							break
																							;;
																							"Custom")
																							printf "Custom Location:\n"
																							read m_location_tmp

																							printf "$m_location_tmp\n" >> y_config.tmp

																							break
																							;;

                                              *)
                                              echo Hippity, Hoppity, retry with a valid option
                                              ;;

																					esac
																		  done
															printf "\n\n\n"
																			PS3='Videos location: '
																						tempp_location=("Keep Current" "Default" "Custom")
																						select fav in "${tempp_location[@]}"; do
																								case $fav in
																										"Keep Current")
																										printf "$v_location\n" >> y_config.tmp
																										break
																										;;

																										"Default")
																										printf "~/Video\n" >> y_config.tmp

																										break
																										;;
																										"Custom")
																										printf "Custom Location:\n"
																										read v_location_tmp

																										printf "$v_location_tmp\n" >> y_config.tmp

																										break
																										;;

                                                    *)
                                                    echo Hippity, Hoppity, retry with a valid option
                                                    ;;
																								esac
																					  done
															clear

														  printf "Saving new Settings...\n\n"


															#replacing main file with temporary one

															rm y_config

															printf "1/3\n"
															cp y_config.tmp y_config

															printf "2/3\n"
															rm y_config.tmp

															printf "3/3\nDone!\n\n"

															printf "New settings saved\n\n"

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
