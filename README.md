chteats
=======

collection of cheatsheets

recording
---------

Record a specific area of the desktop with a secondary microphone (external).
Recording starts with a 10 second delay.

    recordmydesktop --device=hw:1,0 --width=1920 --height=1080 --fps=15 --delay=10
    
Record desktop withouth crashing:

    avconv -f alsa -i hw:1,0 -f x11grab -s hd1080 -r 30 -i :0.0 out.mkv

laptop
------

Check battery status

    upower -i /org/freedesktop/UPower/devices/battery_BAT0
