<?php
    include("../conf.php");

    //Cerco i devices
    exec("lsblk -d -n -o NAME", $devices);
    $ne = count($devices);

    //Tolgo i devices non scrivibili (conf.php)
    $devices = array_diff($devices, $devices_unwritable);

    for ($x = 0; $x < $ne; $x++)
    {
        if($devices[$x] != "")
        {
            echo '<tr>';

            //Cerco la label
            $app = shell_exec("ls -l /dev/disk/by-label/ | grep ".$devices[$x]."| awk '{ print $9 }'");
            if($app != "")
                echo '<td>'.$app.'</td>';
            else
                echo '<td>'.$devices[$x].'</td>';

            //Cerco la dimensione del devices
            $dim = shell_exec("fdisk -l | grep 'Disk /dev/".$devices[$x]."' | awk '{ print $3 }'");
            echo '<td>'.$dim.'GB</td>';
    
            $app = "'".$devices[$x]."'";
            echo '<td><button class="btn btn-primary" style="padding:0px; width:100%;" onclick="writeIso('.$app.')"> Select </button></td>';

            echo '</tr>';
        }
    }
?>
