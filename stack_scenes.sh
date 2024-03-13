function stack_vertical {
  folder=$1
  FIRST_PLANT=$(ls $folder | head -n 1)
  for f in $folder/$FIRST_PLANT/*montage*.mp4; do
    fname=$(basename $f)
    echo $fname

    sources=($folder/*/$fname)

    # ffmpeg -v quiet -stats -i ${sources[1]} -i ${sources[2]} -i ${sources[3]} \
    #    -filter_complex "[0:v][1:v][2:v]vstack=inputs=3" -y $folder/all_$fname

    ffmpeg -v quiet -stats -i ${sources[1]} -i ${sources[2]} -i ${sources[3]} \
      -filter_complex "[0:v]pad=iw:ih+10:color=white[0padded]; [1:v]pad=iw:ih+10:color=white[1padded]; [0padded][1padded][2:v]vstack=inputs=3" -y $folder/all_$fname

  done
}