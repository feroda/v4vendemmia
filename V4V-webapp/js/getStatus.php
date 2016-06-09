<?php
    include("../conf.php");

    $res = shell_exec("tail -n 1 ".$tmp_dir.$tmp_file);
    echo $res;
?>
