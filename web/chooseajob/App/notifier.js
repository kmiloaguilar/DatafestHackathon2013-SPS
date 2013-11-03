define(["toastrmessage"], function () {

    return {
        SuccessMessage: function (message) {
            toastr.success(message);
        },
        InformationMessage: function (message) {
            toastr.info(message);
        },
        ErrorMessage: function (message) {
            toastr.error(message);
        }
    };
});