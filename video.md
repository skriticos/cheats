
Record video:

    sleep 1
    nice -10 avconv \
        -f alsa -i hw:1,0 \
        -f x11grab -r 24 -s hd1080 -i :0.0 \
        -map 0:a -map 1:v \
        -acodec libvorbis -ab 160k \
        -vcodec libvpx -g 24 \
        -threads 4 -deadline realtime -cpu-used 0 \
        -f webm \
        -qmin 2 -qmax 5 -y $1.webm

Cut out part of the video with second and millisecond precision. Note that webm can only be cut at keyframes. The above listing sets the max-keyframe distance to 24 at 24 frames per second, so cutting is possible at roughly second precision. Increasing the keyframe max greatly increases the filesize:

    avconv -i in.webm -ss 00:01:02 -t 00:01:03 -c copy out.webm
    avconv -i in.webm -ss 00:01:02.500 -t 00:01:03.250 -c copy out.webm

Merge MKV containers (note: this is not possible with MP4 containers):

    mkvmerge -w -o test.webm test1.webm +test2.webm
  
Note how the plus sign before the second video means that it is appended to the first one instead of some other way.
