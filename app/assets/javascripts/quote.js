function hideQuestions() {
    /* The questions have been assigned a class name based on building type */
    $(".residential, .commercial, .corporate, .hybrid, .product-line, .quote-results, #step2").hide().prop('required',false);

};

function showRelevantQuestions($building) {
    $("#building-type").on("change", function() {
        $("#step2").show();
        var $step2 = $("#intro-step2");
        var $building = $("#building-type option:selected").val();
        /* Neccessary to hide every question before showing the relevant ones to avoid */
        /* having irrelevant questions show up when the user changes his building type selection, */
        /* for exemple if a user selected one type after another just to see what was asked for each */
        $(".residential, .commercial, .corporate, .hybrid, .product-line, .quote-results").hide().prop('required',false);
        /* Reset all values to null */
        var $apartments = parseInt($("#apartment_qty").val(""));
        var $companies = parseInt($("#companies_qty").val(""));
        var $corporations = parseInt($("#corporations_qty").val(""));
        var $floors = parseInt($("#floor_qty").val(""));
        var $basements = parseInt($("#basement_qty").val(""));
        var $parking = parseInt($("#parking_qty").val(""));
        var $elevators = parseInt($("#elevator_qty").val(""));
        var $occupancy = parseInt($("#occupancy_per_floor").val(""));
        var $businessActivity = parseInt($("#daily_business_hours").val(""));
        var $line = $("input[name='product-line']:checked").val("");
        /* Shows relevant questions based on class of selected building type */
        $("." + $(this).val()).slideDown(400);
        $("#step1-intro").slideUp();
        $step2.scrollTop(0);
    });
};

function elevatorsRequired () {
    $("#calculate-elevators-needed").on("click", function() {
        var $building = $("#building-type option:selected").val();
        /* Checks that the daily business hours is not > 24 */
        if ($building == "hybrid") {
            var $businessActivity = parseInt($("#daily_business_hours").val());
            //console.log("business hours: " + $businessActivity);
            if($businessActivity > 24) {
                alert("Please enter a maximum value of 24 in the question on daily business activity");
                $("#daily_business_hours").val("");
            }
        }


        var $columnsRequired = 1;
        var $floors = parseInt($("#floor_qty").val());
        var $basements = parseInt($("#basement_qty").val());
        // console.log("building-type: " + $building);
        // console.log("floors: " + $floors); 
        // console.log("basements: " + $basements);
        if ($building == "residential") {
            var $apartments = parseInt($("#apartment_qty").val());
            //console.log("apartments: " + $apartments); 
            var $doorsPerFloor = Math.ceil($apartments / $floors);
            //console.log("apartments per floor: " + $doorsPerFloor);
            if ($floors > 20) {
                var $columnsRequired = Math.ceil($floors / 20);
                //console.log("columns required: " + $columnsRequired);
            } 
            var $elevatorsRequired = Math.ceil($columnsRequired * Math.ceil($doorsPerFloor / 6));
        } else if ($building == "commercial") {
            var $elevatorsRequired = parseInt($("#elevator_qty").val());
        } else {
            var $totalOccupants = (parseInt($("#occupancy_per_floor").val()) * $floors);
            //console.log("total occupants: " + $totalOccupants);
            var $elevatorsPerOccupancy = Math.ceil($totalOccupants / 1000);
            //console.log("elevators required based on occupancy: " + $elevatorsPerOccupancy);
            var $columnsRequired = Math.ceil(($floors + $basements) / 20);
            //console.log("columns required: " + $columnsRequired);
            var $elevatorPerColumn = Math.ceil($elevatorsPerOccupancy / $columnsRequired);
            //console.log("elevators per column, rounded up: " + $elevatorPerColumn);
            var $elevatorsRequired = $elevatorPerColumn * $columnsRequired;
        }
        //console.log("elevators required: " + $elevatorsRequired);
        $("#input-elevator-amount").text($elevatorsRequired);
        if ($building == "commercial") {
            $("#text-elevators-needed").text("As you specified, you will need " + $elevatorsRequired + " elevator(s) for your " + $building + " project.");
        } else {
            $("#text-elevators-needed").text("Based on the information you provided, we estimate that you need a total of " + $elevatorsRequired + " elevator(s) for your " + $building + " project.");
        }
        $("#step2-intro, #elevator-calc-button").hide().prop('required',false);
        $(".product-line").slideDown(200);
        var $line1 = $("input[name='product-line']:checked").prop("checked", false);
        //$("#request-new-quote").hide();
        requestQuote ();

    });
};
// #request-quote, 
function requestQuote () {
    $("#step3-row-2").on("click", function() {
        var $building = $("#building-type option:selected").val();
        //console.log("building-type: " + $building);
        var $floors = parseInt($("#floor_qty").val());
        var $line = $("input[name='product_line']:checked").val();
        //console.log("line: " + $line);
        if ($line == "standard") {
            var $elevatorUnitPrice = new Number(7565.00).toFixed(2);
            var $installationRate = 0.1;

        } else if ($line == "premium") {
            var $elevatorUnitPrice = new Number(12345.00).toFixed(2);
            var $installationRate = 0.13;
        } else {
            var $elevatorUnitPrice = new Number(15400.00).toFixed(2);
            var $installationRate = 0.16;
        }
        var $elevatorAmount = $("#input-elevator-amount").val();
        var $elevatorTotalPrice = parseFloat(($elevatorAmount * $elevatorUnitPrice).toFixed(2));
        var $installationFees = parseFloat(($elevatorTotalPrice * $installationRate).toFixed(2));
        var $finalPrice = parseFloat(($elevatorTotalPrice + $installationFees).toFixed(2));
        
        var elevatorUnitPrice = numberWithCommas($elevatorUnitPrice);
        var elevatorTotalPrice = numberWithCommas($elevatorTotalPrice);
        var installationFees = numberWithCommas($installationFees);
        var finalPrice = numberWithCommas($finalPrice);

        function numberWithCommas(x) {
            return x.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
        }

        // console.log("elevator amount: " + $elevatorAmount);
        // console.log("unit price: " + elevatorUnitPrice);
        // console.log("installlation rate: " + $installationRate);
        // console.log("elevator total price: " + elevatorTotalPrice);
        // console.log("installation fees: " + installationFees);
        // console.log("final price: " + finalPrice);
        
        $("#input-elevator-unit-price").text("$CAD " + elevatorUnitPrice);
        $("#input-elevator-total-price").text("$CAD " + elevatorTotalPrice);
        $("#input-installation-fees").text("$CAD " + installationFees);
        $("#input-final-price").text("$CAD " + finalPrice);
        
        $("#steps-to-quote, #request-quote").detach();
        $("#quote-intro").text("Here is your Rocket Elevators' quote for your " + $floors + " floors " + $building + " project.");
        $(".quote-results").slideDown().readOnly;
        $("#request-new-quote").show();
    });
};

function quoteAgain () {
    $("#request-new-quote").on("click", function() {
        var $building = $("#building-type").val("");
        var $apartments = parseInt($("#apartment_qty").val(""));
        var $companies = parseInt($("#companies_qty").val(""));
        var $corporations = parseInt($("#corporations_qty").val(""));
        var $floors = parseInt($("#floor_qty").val(""));
        var $basements = parseInt($("#basement_qty").val(""));
        var $parking = parseInt($("#parking_qty").val(""));
        var $elevators = parseInt($("#elevator_qty").val(""));
        var $occupancy = parseInt($("#occupancy_per_floor").val(""));
        var $businessActivity = parseInt($("#daily_business_hours").val(""));
        var $line1 = $("input[name='product-line']:checked").prop("checked", false);
        $("#steps-to-quote").show();
        hideQuestions();
        showRelevantQuestions();
        elevatorsRequired();
        $("#request-quote").show();
        requestQuote();
    });
};
//"#step3-options-1, #step3-options-2, #step3-options-3"
//$0.checked=false
// this.checked = false;
//<input type=button value="Uncheck" onclick="document.getElementById('foo').checked = false">
/*$(document).on("click", "input[name='radioBtn']", function(){
    thisRadio = $(this);
    if (thisRadio.hasClass("imChecked")) {
        thisRadio.removeClass("imChecked");
        thisRadio.prop('checked', false);
    } else { 
        thisRadio.prop('checked', true);
        thisRadio.addClass("imChecked");
    };

    <textarea id="input-elevator-total-price">$CAD 121,040.00</textarea>
})*/
function calculUpdate() {
    $("#step3-options-1, #step3-options-2, #step3-options-3").on("change, keyUp", function()  {
        //console.log("hello----------------------------------------");
        var $inputElevator = parseInt($("#input-elevator-total-price").val(""));

        var $apartments = parseInt($("#apartment_qty").val(""));
        var $companies = parseInt($("#companies_qty").val(""));
        var $corporations = parseInt($("#corporations_qty").val(""));
        var $floors = parseInt($("#floor_qty").val(""));
        var $basements = parseInt($("#basement_qty").val(""));
        var $parking = parseInt($("#parking_qty").val(""));
        var $elevators = parseInt($("#elevator_qty").val(""));
        var $occupancy = parseInt($("#occupancy_per_floor").val(""));
        var $businessActivity = parseInt($("#daily_business_hours").val(""));
        var $line = $("input[name='product_line']:checked").val("");
        
    });
};

function sendQuote() {
    $("#send-quote").on("click", function() {
        let companyName = $('#company').val();
        let email = $('#email').val();

        if (companyName == "" || email == ""){
            alert("Please fill all mandatory (*) fields before sending your quote.");
        } else {

            alert("Your message was sent succesfully. Thank you. We will return to you shorly.");
            $('#apartment_qty').removeAttr('required');
            $('#floor_qty').removeAttr('required');
            $('#basement_qty').removeAttr('required');
        }

    });
    
};