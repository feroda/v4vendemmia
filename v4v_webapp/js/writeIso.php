<?php
    include("../conf.php");
    
    //Creo il file temporaneo
    mkdir($tmp_dir, 0777);
    fopen($tmp_dir.$tmp_file, "w+");

    //Eseguo il comando
    $cmd = "pv -n ".$ISO_PATH.$_POST['iso']." 2>".$tmp_dir.$tmp_file." | /bin/dd of=/dev/".$_POST['dev'];
    shell_exec($cmd);

    //Elimino il file temporaneo
    unlink($tmp_dir.$tmp_file);
    rmdir($tmp_dir);
?>
