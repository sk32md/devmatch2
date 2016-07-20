/* global $ */
$(document).ready(function() {      //The .ready just means that the document will get loaded before teh JS runs
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));    //Lets grab generic meta tag contents. We can use it because we loaded the JS Stripe file
    // Watch for a form submission:
    $("#form-submit-btn").click(function(event) {  //When the user clicks on submit, we add an event listener to "next line"
        event.preventDefault();  //Dont send anything to the server just yet
        $('input[type=submit]').prop('disabled', true);  //This disables the button
        var error = false;  //establishing a variable false
        var ccNum = $('#card-number').val(),  //storing variables
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
            
        if (!error) {   //if there are no errors
            //Get the Stripe token:
            Stripe.createToken({ //Ship off the data entered to STRIPE
                number: ccNum,
                cvc: cvcNum,
                exp_month: expMonth,
                exp_year: expYear
            }, stripeResponseHandler);  //Once stripe returns TOKEN
        }
        return false;
    }); //form submission
    
    function stripeResponseHandler(status, response) {  //response coming back from server
        //Get a reference to the form:
        var f = $("#new_user"); //Lets use this form we made
        
        //Get the token from the response:
        var token = response.id;  //coming from response above and gives us card TOKEN
        
        //Add the token to the form:
        f.append('<input type="hidden" name="user[stripe_card_token]" value="' + token + '" />'); //and append the value for the field
        
        //Submit the form:
        f.get(0).submit(); //f.get(0) means we only want to the first forn incase there are multiple forms returned and submit
    }
});