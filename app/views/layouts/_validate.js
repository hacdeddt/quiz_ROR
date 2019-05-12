$(document).ready(function() {
    $('.import_qbank').validate({
        // Define element for validation, pass class of form
        errorClass: 'import_qbank',

        // If invalid, show error message in below, also use insertBefore()
        errorElement: 'div',
        errorPlacement: function(error, element) {
            error.insertAfter($("p").has(element));
        },

        // Define list of rules
        rules: {
            'file': {
                required: true
            },
            'category_id': {
                required: true
            },
            'subject_id': {
                required: true
            }
        },

        // Define content of message
        messages: {
            'file': {
                required: 'Chưa chọn file',
            },
            'category_id': {
                required: 'Chưa chọn lớp',
            },
            'subject_id': {
                required: 'Chưa chọn môn học',
            }
        },
        highlight: function (element) {
            $(element).parent().addClass('error');
            $(element).parent().parent().addClass('error')
        },
        unhighlight: function (element) {
            $(element).parent().removeClass('error');
            $(element).parent().parent().removeClass('error')
        }

    });
});

// Ví dụ thêm method validate
// $.validator.addMethod("time24", function(value, element) {
//     if (!/^\d{2}:\d{2}$/.test(value)) return false;
//     var parts = value.split(':');
//     if (parts[0] > 23 || parts[1] > 59) return false;
//     return true;
// }, "時間の表記が正しくありません");