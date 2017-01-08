cheats
======

collection of cheatsheets

dd
--

    dd bs=2M if=disk.img of=/dev/sda... status=progress iflag=direct oflag=direct

recording
---------

Record a specific area of the desktop with a secondary microphone (external).
Recording starts with a 10 second delay.

    recordmydesktop --device=hw:1,0 --width=1920 --height=1080 --fps=15 --delay=10
    
Record desktop withouth crashing:

    avconv -f alsa -i hw:1,0 -f x11grab -s hd1080 -r 30 -i :0.0 out.mkv
    
or

    avconv -f alsa -i hw:1,0 -f x11grab -s hd1080 -r 30 -i :0.0 out.mkv\
    -delay 1 -vcodec libx264 -crf 0 -preset ultrafast -acodec pcm_s16le
    
The newest incantation of avconv does realtime encoding without lag and ok quality at full hd resolution (notice how putting the output filename at the end will make this command invalid :p ):

    avconv -c:v libx264 -crf 18 -preset veryfast -c:a libmp3lame -b:a 320k \
    output.mp4 -f alsa -i hw:1,0 -f x11grab -s hd1080 -i :0.0

laptop
------

Check battery status

    upower -i /org/freedesktop/UPower/devices/battery_BAT0
