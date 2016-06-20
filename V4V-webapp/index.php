<html>
<head>
  <meta charset="utf-8">
  <title>V4Vendemmia</title>
  <link rel="icon" href="icons/logo.png" type="image/x-icon">
  <link href="css/style.css" rel="stylesheet">
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <script src="js/scripts.js"></script>
  <script src="resources/jquery.min.js"></script>
  <script src="resources/bootstrap.min.js"></script>
</head>
<body>
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-12" style="padding-right: 0px; padding-left: 0px">
        <div class="carousel slide" id="carousel-798590">
          <div class="carousel-inner">
            <?php
              include("js/functions.php");
              $counter = 0;

              if(is_dir($ISO_PATH)) 
              {
                if($handle = opendir($ISO_PATH)) 
                {
                  while(($entry = readdir($handle)) !== false) 
                    if(EndsWith($entry, ".iso")) 
                      validateIso($entry);
                
                  closedir($handle);
                }
              }
            ?>
          </div> 
          <ol class="carousel-indicators">
            <?php
              global $counter;

              for($x = 0; $x < $counter; $x++)
              {
                if($x == 0)
                  echo '<li data-slide-to='.$x.' data-target="#carousel-798590" class="active"/>';
                else
                  echo '<li data-slide-to='.$x.' data-target="#carousel-798590"/>';
              }
            ?>
          </ol>
          <!-- Left / Right Buttons -->
          <a class="left carousel-control" href="#carousel-798590" data-slide="prev">
            <img class="logo" src="icons/logo.png" style="height: 100px; width: 100px;"/>
            <span class="glyphicon glyphicon-chevron-left"/>
          </a> 
          <a class="right carousel-control" href="#carousel-798590" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"/>
          </a>

          <!-- Function Buttons -->
          <?php
            if($custom_tab)
              echo '<a id="modal-custom" href="#modal-container-custom" data-toggle="modal" class="customButton highlightit">
                      <img src="icons/calendar.png" style="width:75px"/>
                    </a>';
          ?>
          <a id="modal-devs" href="#modal-container-devs" data-toggle="modal" onclick=selectIso() class="usbButton highlightit">
            <img src="icons/usb.png" style="width:150px"/>
          </a>

          <!-- Modal Dialog -->
          <div class="modal fade" id="modal-container-devs" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                  <h4 class="modal-title">Scegli la tua chiavetta</h4>
                </div>
                <div class="modal-body">
                  <table class="table">
                    <thead><tr><th>USB</th><th>Size</th><th></th></tr></thead>
                    <tbody id="devTab"></tbody>
                  </table>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-primary" onclick=refreshDev()>Refresh</button>
                </div>
              </div>
            </div>
          </div>
          <!-- /Modal Dialog-->

          <!-- Modal Progress Bar -->
          <div class="modal fade" id="modal-container-progress" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" style="width:75%">
              <div class="modal-content">
                <div class="modal-header">
                  <h4 class="modal-title" style="text-align:center">Vendemmia in progress . . .</h4>
                </div>
                <div class="modal-body">
                    <div class="progress">
                            <div class="progress-bar progress-bar-danger"></div>
                    </div>
                </div>
              </div>
            </div>
          </div>
          <!-- /Modal Progress Bar -->

          <!-- Custom Modal -->
          <div class="modal fade" id="modal-container-custom" role="dialog" aria-hidden="true" style="overflow:hidden; top:10% !important">
            <div class="modal-dialog" style="width:65%">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                  <h4 class="modal-title">Makerspace Fabriano - Calendario Attività</h4>
                </div>
                <div class="modal-body">
                  <iframe src="https://calendar.google.com/calendar/embed?showTitle=0&amp;showPrint=0&amp;showTabs=0&amp;showCalendars=0&amp;showTz=0&amp;height=600&amp;wkst=1&amp;bgcolor=%23FFFFFF&amp;src=fen9kk7kri2e7lmdk4piiorvtg%40group.calendar.google.com&amp;color=%230F4B38&amp;ctz=Europe%2FRome" style="border-width:0" width="100%" height="600px" frameborder="0" scrolling="no"></iframe>
                </div>
              </div>
            </div>
          </div>
          <!-- /Custom Modal -->

        </div>
      </div>
    </div>
  </div>
</body>
</html>
