define(["underscore", "datacontext", "plugins/router", "parse"], function (_, dc, router) {
    var viewmodel = function () {
        var username = ko.observable("");
        var name = ko.observable("");
        var actualViewmodel = ko.observable("viewmodels/availableJoblist");
        var isEmployer = ko.observable(false);
        return {
            viewUrl: "views/welcome",
            Name: name,
            ActualViewmodel:actualViewmodel,
            ClickLogout: function() {
                Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                Parse.User.logOut();
                router.navigate("/");
            },
            ClickListAvailableJobs: function() {
                actualViewmodel("viewmodels/availableJoblist");
            },
            ClickListCreatedJobs: function () {
                actualViewmodel("viewmodels/joblist");
            },
            ClickListAppliedJobs: function() {
                actualViewmodel("viewmodels/joblist");
            },
            ClickCreateJobs: function () {
                actualViewmodel("viewmodels/jobCreator");
            },
            ClickProfile: function () {
                actualViewmodel("viewmodels/profile");
            },
            attached: function () {
                $('li').click(function () {
                    $('li').removeClass('active');//remove active class from all li with class panel
                    $('li').children('ul').removeClass('in');//remove in class
                    $(this).addClass('active'); // add class active to current li
                    $(this).children('ul').addClass('in'); //add in class to the children ul
                });
            },
            activate: function () {
                Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                var currentUser = Parse.User.current();
                if (currentUser) {
                    username(currentUser.attributes.username);
                    name(currentUser.attributes.name);
                    isEmployer(currentUser.attributes.isEmployer);
                } else {
                    router.navigate("/");
                }
            }
        };
    };
    return viewmodel;
});