Record Videos
=============

Simple
------

Grab sound from microphone and full-screen video and encode it as WebM on-the-fly. The -g argument forces maximum key-frame distance in frames (i.e. at 24fps, this value set at 24 means we get a key-frame at least every secand.) Key-frames are the only places to cut videos withouth transcoding, so having this as a low value for the raw videos is sensible. The filesize inflates dramatically though, when setting this value too small. The threads, deadline and cpu-used parameters specify the encoding performance profile, the nuber of threads used and the perentage of CPU used (0=100). The qmin/qmax arguments specify the video quality. By default this is dreadly, but this makes it all nice, though creates bigger filesizes. The -y parameter stops avconv asking for confirmation any time a file needs to be overriden.

    sleep 1
    nice -10 avconv \
        -f alsa -i hw:1,0 \
        -f x11grab -r 24 -s hd1080 -i :0.0 \
        -map 0:a -map 1:v \
        -acodec libvorbis -ab 320k \
        -vcodec libvpx -g 24 \
        -threads 3 -deadline realtime -cpu-used 0 \
        -f webm \
        -qmin 2 -qmax 5 -y $1.webm
        
Merged Dual Audio
-----------------

This is a variation of the previous command, but instead of only grabbing the microphone, it also grabs the system sounds from pulseaudio from a stereo monitor.

    http://askubuntu.com/questions/410737/record-desktop-and-microphone-audio-with-avconv
    pactl list short sinks
    pactl load-module module-loopback latency_msec=1 sink=alsa_output.pci-0000_00_1b.0.analog-stereo
    -> 20
    .. pactl unload-module module-loopback
    pactl list short modules

To make this work, a loopback module needs to be loaded for the analog-stereo output as described in the above article (the device id's are system specific). The -filter_complex amix argument tells libav to merge the two input audio streams into one. The video map parameter is also changed.

    nice -10 avconv \
        -f pulse -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
        -f alsa -i hw:1,0 \
        -filter_complex amix \
        -f x11grab -r 24 -s hd1080 -i :0.0 \
        -map 0:a -map 2:v \
        -acodec libvorbis -ab 320k \
        -vcodec libvpx -g 24 \
        -threads 4 -deadline realtime -cpu-used 0 \
        -f webm \
        -qmin 2 -qmax 5 -y $1.webm

Record video of selected window
-------------------------------

This is a variation on the simple capture, but it only captures one window that needs to be selected with the mouse. As this needs to parse the output of the xwindowinfo command, it's placed in a python3 script. It parses the window position and dimensions from the output of the command and then constructs the screen recording command and executes it.

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
          "-acodec libvorbis -ab 320k" + \
          "-vcodec libvpx -g 24 " + \
          "-threads 4 -deadline realtime -cpu-used 0 " + \
          "-f webm " + \
          "-qmin 2 -qmax 5 -y {out_file}.webm"
    cmd = cmd.format(**{"height":height, "width":width, 
                        "xcoord":xcoord, "ycoord":ycoord, 
                        "out_file":out_file})
    print("cmd:", cmd)
    subprocess.call(cmd, shell=True)

Cutting Videos
--------------

Cut out part of the video with second and millisecond precision. Note that webm can only be cut at keyframes. The above listing sets the max-keyframe distance to 24 at 24 frames per second, so cutting is possible at roughly second precision. Increasing the keyframe max greatly increases the filesize:

    avconv -i in.webm -ss 00:01:02 -t 00:01:03 -c copy out.webm
    avconv -i in.webm -ss 00:01:02.500 -t 00:01:03.250 -c copy out.webm

Merge MKV/WebM Containers
-------------------------

Merge MKV containers (note: this is not possible with MP4 containers):

    mkvmerge -o test.webm test1.webm +test2.webm
  
Note how the plus sign before the second video means that it is appended to the first one instead of some other way.
