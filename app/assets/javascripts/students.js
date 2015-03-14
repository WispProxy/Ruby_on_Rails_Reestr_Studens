(function() {
    $(function() {
        var _fetch_students;

        _fetch_students = function() {
            return $.ajax({
                type: 'GET',
                dataType: 'json',
                url: '/',
                data: { get_param: 'value' },
                success: function(students_list) {
                    return $('table#students_list').html(poirot.studentsList(students_list));
                }
            });
        };

        _fetch_students();
        setInterval(_fetch_students, 15000);

        return $('#submit_btn').click(function() {
            $.ajax({
                type: 'POST',
                url: '/students',
                data: $('#new_student').serialize(),
                success: function(students_list) {
                    $('table#students_list').html(poirot.studentsList(students_list));
                    alert('Student ADD success!');
                    return _fetch_students();
                },
                error: function(e) {
                    return alert(e.responseText);
                }
            });
            return false;
        });
    });
}).call(this);

//var response = '[{"rank":"9","content":"Alon","UID":"5"},{"rank":"6","content":"Tala","UID":"6"}]';
//
//response = $.parseJSON(response);
//
//$(function() {
//    $.each(response, function(i, item) {
//        var $tr = $('<tr>').append(
//            $('<td>').text(item.rank),
//            $('<td>').text(item.content),
//            $('<td>').text(item.UID)
//        ).appendTo('h1');
//    });
//});
