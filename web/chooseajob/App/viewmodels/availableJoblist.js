define(["underscore", "datacontext", "plugins/router"], function (_, dc, router) {
    var viewmodel = function () {
        var username = ko.observable("");
        var name = ko.observable("");
        var isEmployer = ko.observable(false);
        var jobs = ko.observableArray("");
        var title = ko.observable("");
        var currentUser = ko.observable("");
        return {
            viewUrl: "views/joblist",
            Jobs: jobs,
            Title: title,
            JobListTitle: ko.observable("Available Jobs"),
            attached: function () {
                if (currentUser) {
                    _.each(currentUser.attributes.skills, function (skill) {
                        dc.Jobs.getJobsEmployee(skill, currentUser.attributes.city, function (jobsFromParse) {
                            _.each(jobsFromParse, function (item, index) {
                                var dd = item.createdAt.getDate();
                                var mm = item.createdAt.getMonth();
                                var yyyy = item.createdAt.getFullYear();
                                if (dd < 10) {dd = '0' + dd;}
                                if (mm < 10) {mm = '0' + mm;}
                                var date = dd + '/' + mm + '/' + yyyy;
                                var skillsobject = "";
                                if (item.attributes.skills != undefined) {
                                    _.each(item.attributes.skills, function (skillObject) {
                                        skillsobject += skillObject + ", ";
                                    });
                                    skillsobject = skillsobject.substring(0, skillsobject.length - 2);
                                }

                                var job = { city: item.attributes.city, title: item.attributes.title, date: date, skills: skillsobject };
                                var canPush = true;
                                _.each(jobs(), function(jobInArray) {
                                    if (jobInArray.title == job.title && jobInArray.city == job.city && jobInArray.skills == job.skills && jobInArray.date == job.date) {
                                        canPush = false;
                                    }
                                });
                                if (canPush) {
                                    jobs.push(job);
                                    title("You have " + jobs().length + " Jobs that match with your city and skills");
                                }
                            });
                        });
                    });
                        
                }
            },
            activate: function () {
                Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                currentUser = Parse.User.current();
                if (currentUser) {
                    currentUser.fetch();
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