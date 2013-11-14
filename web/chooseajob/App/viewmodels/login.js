define(["plugins/router", "datacontext", "notifier","cookiesManagement"], function (router, dc, notifier,cookies) {

    var viewmodel = function () {
        var name = ko.observable("");
        var email = ko.observable("");
        var forgotEmail = ko.observable("");
        var password = ko.observable("");
        var repassword = ko.observable("");
        var city = ko.observable("");
        var phone = ko.observable("");
        var loginEmail = ko.observable("");
        var loginPassword = ko.observable("");
        var isEmployer = ko.observable(false);
        
        return {
            viewUrl: "views/login",
            Name: name,
            Email: email,
            Password: password,
            Repassword : repassword,
            City: city,
            Phone: phone,
            IsEmployer: isEmployer,
            ForgotEmail: forgotEmail,
            LoginEmail: loginEmail,
            LoginPassword: loginPassword,
            activate: function () {
                Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                var currentUser = Parse.User.current();
                if (currentUser != null) {
                    router.navigate("/welcome");
                } 
            },
            attached: function() {
                jQuery("#f_elem_city").autocomplete({
                    source: function (request, response) {
                        jQuery.getJSON(
                            "http://gd.geobytes.com/AutoCompleteCity?callback=?&q="+request.term,
                                function (data) {
                                    response(data);
                                }
                        );
                    },
                    minLength: 3,
                    select: function (event, ui) {
                        var selectedObj = ui.item;
                        jQuery("#f_elem_city").val(selectedObj.value);
                        city(selectedObj.value);
                        return false;
                    },
                    open: function () {
                        jQuery(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                    },
                    close: function () {
                        jQuery(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                    }
                });
                jQuery("#f_elem_city").autocomplete("option", "delay", 100);              
            },
            ClickSignUp: function () {
                if (name() != "" && email() != "" && city()!= "" && phone() !="" && password()!="") {
                    if (password() == repassword()) {
                        dc.Login.SignUp({ name: name(), username: email(), password: password(), email: email(), city: city(), phone: phone(), isEmployer: isEmployer() }, function (user) {
                            notifier.SuccessMessage("Your registration was succeded");
                            name("");
                            email("");
                            password("");
                            repassword("");
                            city("");
                            phone("");
                            isEmployer(false);
                            cookies.SetCookie("viewmodels/availableJoblist", "first");
                            router.navigate("/welcome");
                        }, function (user, error) {
                            alert("Error: " + error.code + " " + error.message);
                        });
                    } else {
                        notifier.ErrorMessage("you need to verify your password");
                    }
                } else {
                    notifier.ErrorMessage("All the fields are required");
                }
            },
            ClickLogin: function () {
                if (loginEmail() != "" && loginPassword()!=="") {
                    dc.Login.SignIn(loginEmail(),loginPassword(), function () {
                        notifier.SuccessMessage("user authenticated");
                        loginEmail("");
                        loginPassword("");
                        cookies.SetCookie("viewmodels/availableJoblist", "first");
                        router.navigate("/welcome");
                    }, function (error) {
                        notifier.ErrorMessage("the user or password are not correct");
                    });
                }
            },
            ClickForgotPassword: function() {
                if (forgotEmail() != null) {
                    dc.Login.forgotPassword(forgotEmail(), function () {
                        notifier.SuccessMessage("Password reseted, please see your email");
                        forgotEmail("");
                        show_box('login-box');
                    }, function(error) {
                        notifier.ErrorMessage("there was an error sending the email");
                    });
                } else {
                    notifier.ErrorMessage("Please, enter a valid email");
                }                
            }
        };
    };
    return viewmodel;
});