$(document).ready(function() {


console.log("jquery")
    
    $(document).ready(function(){
        $(".display_building").hide();
        $(".display_elevator").hide();
        $(".display_battery").hide();
        $(".display_column").hide();
        $("#building").hide()
        $("#battery").hide()
        $("#column").hide()
        $("#elevator").hide()

    })

    $("#building").prop("disabled", true); 
    
    $("#customer").change(function(){
        var customer = $(this).val();
        if(customer == ''){
            $("#building").prop("disabled", true);
        }else{
            $("#building").show()
            $("#building").prop("disabled", false);
        }
      $(".display_building").show();
        $.ajax({
            url: "/interventions/building",
            method: "GET",  
            dataType: "json",
            data: {customer: customer},
            error: function (xhr, status, error) {
                console.error('AJAX Error: ' + status + error);
            },
            success: function (response) {
                console.log(response);
                var building = response["building"];
                $("#building").empty();

                $("#building").append('<option> Select Building </option>');
                for(var i = 0; i < building.length; i++){
                    $("#building").append('<option value="' + building[i]["id"] + '">' + building[i]["id"] + ". " + building[i]["full_name_administrator"] + '</option>');
                }
            }
        });
    });
//  building && battery filled in   ==> we only want to save the battery_id to the database
// - building && battery && column filled in   ==> we only want to save the column_id to the database
// - building && battery && column && elevator filled in ==> we only want to save the elevator_id to the database


    $("#battery").prop("disabled", true); 
    $("#building").change(function(){
        var building = $(this).val();
        if(building == ''){
            $("#battery").prop("disabled", true);
        }else{
            $("#battery").show()
            $("#battery").prop("disabled", false);
          }
       $(".display_battery").show();
        $.ajax({
            url: "/interventions/battery",
            method: "GET",  
            dataType: "json",
            data: {building: building},
            error: function (xhr, status, error) {
                console.error('AJAX Error: ' + status + error);
            },
            success: function (response) {
                console.log(response);
                var battery = response["battery"];
                $("#battery").empty();

                $("#battery").append('<option> Select Battery </option>');
                for(var i = 0; i < battery.length; i++){
                    $("#battery").append('<option value="' + battery[i]["id"] + '">' + battery[i]["id"] + '</option>');
                }
            }
        });
    });

  
    $("#column").prop("disabled", true); 
    $("#battery").change(function(){
        var battery = $(this).val();
        if(battery == ''){
            $("#column").prop("disabled", true);
        }else{
            $("#column").show()
            $("#column").prop("disabled", false);
        }
        $(".display_column").show();
    
        $.ajax({
            url: "/interventions/column",
            method: "GET",  
            dataType: "json",
            data: {battery: battery},
            error: function (xhr, status, error) {
                console.error('AJAX Error: ' + status + error);
            },
            success: function (response) {
                console.log(response);
                var column = response["column"];
                $("#column").empty();

                $("#column").append('<option> None </option>');

               {
                for(var i = 0; i < column.length; i++){
                    $("#column").append('<option value="' + column[i]["id"] + '">' + column[i]["id"] + '</option>');
                }
                }
            }
        });
    });

   
    $("#elevator").prop("disabled", true); 
    $("#column").change(function(){
        var column = $(this).val();
        if(column == ''){
            $("#elevator").prop("disabled", true);
        }else{
            $("#elevator").show()
            $("#elevator").prop("disabled", false);
        }
        $(".display_elevator").show();
        $.ajax({
            url: "/interventions/elevator",
            method: "GET",  
            dataType: "json",
            data: {column: column},
            error: function (xhr, status, error) {
                console.error('AJAX Error: ' + status + error);
            },
            success: function (response) {
                console.log(response);
               
                var elevator = response["elevator"];
                $("#elevator").empty();

                $("#elevator").append('<option> None </option>');
                for(var i = 0; i < column.length; i++){

                    $("#elevator").append('<option value="' + elevator[i]["id"] + '">' + elevator[i]["id"] + '</option>');

                }
            },

        //     complete:function(){
        //         $('#myform').each(function(){
        //             this.reset();   //Here form fields will be cleared.
        //         });
        //    }
        });
    });
    //document.getElementById('myform').reset()
    //$("#myform").reset();
    $("#myform").submit(function(event){
        event.preventDefault(); //prevent default action 
        var post_url = $(this).attr("action"); //get form action url
        var request_method = $(this).attr("method"); //get form GET/POST method
        var form_data = $(this).serialize(); //Encode form elements for submission

        $.ajax({
            url : post_url,
            type: request_method,
            data : form_data
        }).done(function(response){ //
            alert('intervention successfull saved ');
            window.location='/interventions';
        });
    });
    
});