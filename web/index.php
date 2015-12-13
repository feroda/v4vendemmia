<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>V4Vendemmia</title>

    <!--
    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">
    --!>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

  </head>
  <body>

    <div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<ul class="nav nav-pills">
				<li class="active">
					<a href="#">Home</a>
				</li>
				<li>
					<a href="#">Profile</a>
				</li>
				<li class="disabled">
					<a href="#">Messages</a>
				</li>
				<li class="dropdown pull-right">
					 <a href="#" data-toggle="dropdown" class="dropdown-toggle">Dropdown<strong class="caret"></strong></a>
					<ul class="dropdown-menu">
						<li>
							<a href="#">Action</a>
						</li>
						<li>
							<a href="#">Another action</a>
						</li>
						<li>
							<a href="#">Something else here</a>
						</li>
						<li class="divider">
						</li>
						<li>
							<a href="#">Separated link</a>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="carousel slide" id="carousel-798590">
				<ol class="carousel-indicators">
					<li class="active" data-slide-to="0" data-target="#carousel-798590">
					</li>
					<li data-slide-to="1" data-target="#carousel-798590">
					</li>
					<li data-slide-to="2" data-target="#carousel-798590">
					</li>
				</ol>
				<div class="carousel-inner">
                    <?php
                        function IsoElement($iso, $active = false)
                        {
                            $iso_xml=simplexml_load_file("iso_list.xml");

                            for ($x = 0; $x < count($iso_xml); $x++)
                            {
                                if($iso == $iso_xml->iso[$x]->isoname)
                                {
                                    if ($active)
                                        echo '<div class="item active">';
                                    else
                                        echo '<div class="item">';

                                    echo '  <img alt="Dist_Img" class="isothumbnail" src="'.$iso_xml->iso[$x]->img.'">
                                            <div class = "carousel-caption">
                                                <h4>'.$iso_xml->iso[$x]->name.'</h4>
                                                <p>'.$iso_xml->iso[$x]->dsc.'</p>
                                            </div>
                                        </div>';
                                    break;
                                }
                            }
                        }

                        function endsWith($haystack, $needle)
                        {
                            $length = strlen($needle);
                            if ($length == 0)
                                return true;
                            return (substr($haystack, -$length) === $needle);
                        }

                        #TODO include "conf.php";

                        $ISO_PATH = "/srv/http/iso";
                        $isos = [];
                        $c = 0;

                        if (is_dir($ISO_PATH))
                        {
                            if ($handle = opendir($ISO_PATH))
                            {
                                while (($entry = readdir($handle)) !== false)
                                {
                                    if(EndsWith($entry, ".iso"))
                                    {
                                        if($c == 0)
                                            IsoElement($entry, true);
                                        else
                                            IsoElement($entry);

                                        array_push($isos, $entry);
                                        $c+=1;
                                    }
                                }
                                closedir($handle);
                            }
                        }
                    ?>
				</div> <a class="left carousel-control" href="#carousel-798590" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a> <a class="right carousel-control" href="#carousel-798590" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-6">
		</div>
		<div class="col-md-6">
			 
			<button type="button" class="btn btn-primary btn-block">
				Go and destroy your USB !
			</button>
		</div>
	</div>
</div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>
  </body>
</html>
