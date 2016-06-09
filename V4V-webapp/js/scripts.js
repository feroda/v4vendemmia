var iso;

function selectIso() {
    iso = $(".item.active").children().attr("alt");
    refreshDev();
}

function refreshDev() {
    var request = $.post("js/getDev.php");

    request.done(function(msg) {
        $("#devTab").html(msg);
    });

    request.fail(function(jqXHR, textStatus) {
        console.log("Request failed: " + textStatus);
    });
}

function writeIso(dev) {
    var request = $.post("js/writeIso.php", { 
        dev, 
        iso, 
        beforeSend:function(data) {
            //Reset progress-bar
            $('.progress-bar').width('0%');
            $('.progress-bar').text('0%')

            //Close dev modal
            $('#modal-container-devs').modal('hide');

            //Open progress-bar and start status thread
            $('#modal-container-progress').modal();
            progress = setInterval(function() {
                var app = $.get("js/getStatus.php");
                app.done(function(data) { 
                    data = parseInt(data) + "%";;
                    $('.progress-bar').width(data);
                    $('.progress-bar').text(data)
                });
            },1000); 
        }
    });

    request.done(function(data) {
        clearInterval(progress);
        $('#modal-container-progress').modal('hide');
    });
    
    request.fail(function(jqXHR, textStatus) {
        clearInterval(progress);
        $('#modal-container-progress').modal('hide');
        console.log("Request failed: " + textStatus);
    });
}
