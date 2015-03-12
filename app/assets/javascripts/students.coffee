# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	students_recieved = (students_list)->
		$('#student_list').html poirot.studentsList(students_list)

	fetch_students = ->
		$.ajax
			type: "POST"
			dataType: "json"
			url: "/"
			success: students_recieved()


	fetch_students()
	setInterval(fetch_students, 5000)

	$('#submit_btn').click ->
		$.ajax
			type: "POST"
			url: "/students"
			data: $('#new_student').serialize()
			success: (students_list) ->
				students_recieved(students_list)
				alert('Student ADD success!')
				fetch_students()
			error: (e)->
				alert(e.responseText)
		false
