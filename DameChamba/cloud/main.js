
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

var twilio = require("twilio");
twilio.initialize("AC55fad4fc35d02a8f96559d9ab00ceed1","f17c12b6d2fcaa3bdd8dfff92a94f1fc");
 
// Create the Cloud Function
Parse.Cloud.define("smsWithTwilio", function(request, response) {
	// Use the Twilio Cloud Module to send an SMS
	twilio.sendSMS({
		From: "+16304139351",
		To: request.params.number,
		Body: request.params.message
		}, 
		{
			success: function(httpResponse) { 
				response.success("SMS sent!"); 
			},
			error: function(httpResponse) { 
				response.error("Uh oh, something went wrong"); 
			}
		}
	);
});

Parse.Cloud.afterSave("Jobs", function(request) {
	var message = "They need this job "+request.object.get("title") + " in "+request.object.get("city") + " with this skills: "+request.object.get("skills");
	twilio.sendSMS({
		From: "+16304139351",
		To: "+50488658969",//"",
		Body: message,
		}, 
		{
			success: function(httpResponse) { 
				response.success("SMS sent!"); 
			},
			error: function(httpResponse) { 
				response.error("Uh oh, something went wrong"); 
			}
		}
	);

	var pushQuery = new Parse.Query(Parse.Installation);
	//pushQuery.equalTo('deviceType', 'ios');
	  Parse.Push.send({
	    where: pushQuery, // Set our Installation query
	    data: {
	      alert: message
	    }
	  }, {
	    success: function() {
	      // Push was successful
	    },
	    error: function(error) {
	      throw "Got an error " + error.code + " : " + error.message;
	    }
	  });


});