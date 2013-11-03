dedefine(["underscore", "plugins/router", "datacontext", "notifier"], function (_, router, dc, notifier) {

    var viewmodel = function () {
        var currentUser = ko.observable("");
        var username = ko.observable("");
        return {
            viewUrl: 'views/viewMessage',
            ClickOnCreate: function () {
            },
            activate: function () {
                Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                currentUser = Parse.User.current();
                if (currentUser) {
                    username(currentUser.attributes.username);
                } else {
                    router.navigate("/");
                }
            },
            attached: function () {
            }
        };
    };

    return viewmodel;
})
