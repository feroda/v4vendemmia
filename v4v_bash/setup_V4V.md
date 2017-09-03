## How to config an old PC to be a V4Vendemmia (Distro Jukebox) ##

* Install Debian 9.1 (tested)

* Edit `/etc/apt/source.list`

        deb http://deb.debian.org/debian stretch main
        deb http://deb.debian.org/debian stretch-updates main
        deb http://security.debian.org stretch/updates main

* `apt update `

* Install dependecies

        `apt install git pv espeak`

* `git clone https://github.com/feroda/v4vendemmia.git`

* Edit `/lib/systemd/system/getty@.service`

        ExecStart=-/sbin/agetty --noclear %I $TERM

    to

        ExecStart=-/sbin/agetty --noclear -a root %I $TERM

* Edit `.bashrc`
    
        setterm -blank 0
        /src/v4vendemmia/v4v_bash/V4V.sh /mnt/iso

* Create a suspend script (like `/usr/bin/go_to_sleep.sh`)

        #!/bin/bash
        /usr/sbin/rtcwake -m disk -s 60

>  -s X seconds

* Give execute permission `chmod +x /usr/bin/go_to_sleep.sh`

* Add it to cron with `crontab -e`

        0 19 * * * /usr/bin/go_to_sleep.sh
