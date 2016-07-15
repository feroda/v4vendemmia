<?php
    include("conf.php");
    $first = true;

    function validateIso($iso)
    {
        global $first;
        global $counter;
        $iso_xml = simplexml_load_file("iso_list.xml");

        for ($x = 0; $x < count($iso_xml); $x++) 
        {
            if($iso == $iso_xml->iso[$x]->isoname)
            {
                if($first)
                {
                    echo '<div class="item active">';
                    $first = false;
                }
                else
                {
                    echo '<div class="item">';
                }

                echo '<div alt="'.$iso_xml->iso[$x]->isoname.'" class="isothumbnail"  
                        style="background-image: url('.$iso_xml->iso[$x]->img.')"></div>
                        <div class="carousel-caption">
                        <h2 class="col-md-6">'.$iso_xml->iso[$x]->name.'</h2>
                        <p class="col-md-6">'.$iso_xml->iso[$x]->dsc.'</p>
                        </div>
                        </div>';

                $counter++;
                break;
            }
        }
    }

    /* http://stackoverflow.com/questions/834303/startswith-and-endswith-functions-in-php */
    function endsWith($haystack, $needle)
    {
        $length = strlen($needle);
        if($length == 0) 
            return true;
        return (substr($haystack, -$length) === $needle);
    }
?>
