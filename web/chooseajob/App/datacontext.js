define(["underscore","parse"], function (_, serverImplementation) {
    var dataContext = function (server) {
        return {
            Skill: {
                getSkills: function(success) {
                    Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                    var skills= Parse.Object.extend("Skills");
                    var query = new Parse.Query(skills);
                    query.find({ success: success });
                }
            },
            Login: {
                SignUp: function (userObject, success, error) {
                    Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                    var user = new Parse.User();
                    user.set("name", userObject.name);
                    user.set("username", userObject.email);
                    user.set("password", userObject.password);
                    user.set("email", userObject.email);
                    user.set("city", userObject.city);
                    user.set("phone", userObject.phone);
                    user.set("isEmployer", userObject.isEmployer);
                    user.signUp(null, {success: success, error: error});
                },
                forgotPassword: function (email, success, error) {
                    Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                    Parse.User.requestPasswordReset(email, { success: success, error: error });
                },
                SignIn: function (email, password, success, error) {
                    Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                    Parse.User.logIn(email, password, { success: success, error: error });
                },

                updateUser:function(userName, userObject, success, error){
                    Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                    var query = new Parse.Query(Parse.User);
                    query.equalTo("username", userName);

                    query.find({
                        success: function(result){
                            for (var i = 0; i < result.length; i++) {

                                result[i].set("name", userObject.name);
                                result[i].set("skills", userObject.skills);
                                result[i].set("city", userObject.city);
                                result[i].set("phone", userObject.phone);

                                result[i].save(null, { success: success, error:error});

                            }
                        },
                        error: error
                    });
                },
                getCurrentUser:  function () {
                    Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                    var currentUser = Parse.User.current();
                    currentUser.fetch();

                    if(currentUser) {
                        return {
                            username: currentUser.attributes.username,
                            name: currentUser.attributes.name,
                            phone: currentUser.attributes.phone,
                            city: currentUser.attributes.city,
                            skills: currentUser.attributes.skills
                        };
                    }else{throw "Log in first to get the current user";}
                }
            },
            Jobs: {
                addJob: function (jobObject, succes, error){
                    Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                    var job =  Parse.Object.extend("Jobs");

                    var newJob = new job();
                    newJob.set("title", jobObject.Title);
                    newJob.set("description", jobObject.Description);
                    newJob.set("skills", jobObject.Skills);
                    newJob.set("city", jobObject.City);
                    newJob.set("closed", jobObject.Closed);
                    newJob.set("createdBy", jobObject.Name);
                    newJob.save(null, {success: succes, error: error} );
                },
                getAllJobs: function (success) {
                    Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                    var jobs = Parse.Object.extend("Jobs");
                    var query = new Parse.Query(jobs);
                    query.find({ success: success });
                },
                getJobsEmployee: function (skill, city, success) {
                    Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                    var jobs = Parse.Object.extend("Jobs");
                    var query = new Parse.Query(jobs);
                    query.equalTo("skills", skill);
                    query.equalTo("city", city);
                    query.find({ success: success });
                },
                getJobsEmployer: function (username, success, error) {
                    Parse.initialize("vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID", "q2sRm5Vs4axb0UFYm8W3p22Z679Rto3ZuT9VMmHu");
                        var jobs = Parse.Object.extend("Jobs");
                        var query = new Parse.Query(jobs);
                        query.equalTo("createdBy", username);
                        query.find({ success: success, error: error });
                },
            }
        };
    }(serverImplementation);

    return dataContext;
});