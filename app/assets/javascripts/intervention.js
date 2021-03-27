$(document).ready(function() {

//function that display and hide in html andbeing triggler when a use choosed something
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
        //the below methods  populate dropdown with jQuery AJAX.
        // https://stackoverflow.com/questions/30044425/populate-dropdown-via-ajax-and-automatically-select-a-value
    // https://github.com/nguyenduyphuc/How-to-Auto-populate-dropdown-with-jQuery-AJAX/blob/master/index.php
    // Each item in the Json response is looped round and used to build up the new options for the select box. As the response is an array we can call the .length method on it.(must must must not use json for the url part)
    // to detect the change in the drop down, i will used jQuery to register for the select ‘change’ event. Once caught, i then do an ajax GET to the backend to retrieve our JSON response. (must configurate the router.rb otherwise it will not work)


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
    //this methode is for refleshing and redirecting the page after the form was submited
    //document.getElementById('myform').reset() was good idea but this methose restert the form before saving data in database. so, for ajax we need a specific methode
    //https://stackoverflow.com/questions/1200266/submit-a-form-using-jquery

    $("#myform").submit(function(event){
        event.preventDefault(); //prevent default action 
        // var post_url = $(this).attr("action"); //get form action url
        // /var request_method = $(this).attr("method"); //get form GET/POST method
        var form_data = $(this).serialize(); //Encode form elements for submission

        $.ajax({
            //url : post_url,
            //  type: request_method,
            data : form_data
        }).done(function(response){ 
            // alert('intervention successfull saved ');
            window.location='/interventions';
        });
    });
    
});