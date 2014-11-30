
Record video:

    nice -10 avconv -c:v libx264 -crf 18 -preset veryfast \
      -c:a libmp3lame -b:a 320k "{filename}" \
      -f alsa -i hw:1,0 -f x11grab -s hd1080 -i :0.0

Cut out part of the video with second and millisecond precision:

  avconv -i in.mkv -ss 00:01:02 -t 00:01:03 -c copy out.mkv
  avconv -i in.mkv -ss 00:01:02.500 -t 00:01:03.250 -c copy out.mkv

Merge MKV containers (note: this is not possible with MP4 containers):

  mkvmerge -o test.mkv test1.mkv +test2.mkv
  
Note how the plus sign before the second video means that it is appended to the first one instead of some other way.
