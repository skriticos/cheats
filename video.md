
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

Record video of selected window:

    #! /usr/bin/env python3
    
    import subprocess
    import sys
    
    print("select window..")
    
    out = subprocess.check_output(["xwininfo"]).decode("utf-8")
    out_lines = out.split("\n")
    
    xcoord = 0
    ycoord = 0
    width = 0
    height = 0
    if len(sys.argv) < 2:
        out_file = "out"
    else:
        out_file = sys.argv[1]
    
    def extractTail(line):
        words = line.split(" ")
        tail = words[-1]
        return tail
    
    for line in out_lines:
        if "Absolute upper-left X:" in line:
            xcoord = extractTail(line)
        if "Absolute upper-left Y:" in line:
            ycoord = extractTail(line)
        if "Width:" in line:
            width = extractTail(line)
        if "Height:" in line:
            height = extractTail(line)
    
    print("xcoord:", xcoord)
    print("yccord:", ycoord)
    print("width:", width)
    print("height:", height)
    print("output:", out_file)
    
    cmd = "avconv -f alsa -i hw:1,0 " + \
          "-f x11grab -r 24 -s {width}x{height} -i :0.0+{xcoord},{ycoord} " + \
          "-map 0:a -map 1:v " + \
          "-acodec libvorbis -ab 320k -vcodec libvpx -g 24 " + \
          "-threads 4 -deadline realtime -cpu-used 0 " + \
          "-f webm -qmin 2 -qmax 5 -y {out_file}.webm"
    cmd = cmd.format(**{"height":height, "width":width, 
                        "xcoord":xcoord, "ycoord":ycoord, 
                        "out_file":out_file})
    print("cmd:", cmd)
    subprocess.call(cmd, shell=True)

Cut out part of the video with second and millisecond precision. Note that webm can only be cut at keyframes. The above listing sets the max-keyframe distance to 24 at 24 frames per second, so cutting is possible at roughly second precision. Increasing the keyframe max greatly increases the filesize:

    avconv -i in.webm -ss 00:01:02 -t 00:01:03 -c copy out.webm
    avconv -i in.webm -ss 00:01:02.500 -t 00:01:03.250 -c copy out.webm

Merge MKV containers (note: this is not possible with MP4 containers):

    mkvmerge -o test.webm test1.webm +test2.webm
  
Note how the plus sign before the second video means that it is appended to the first one instead of some other way.
