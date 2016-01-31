$(document).ready(function () {
  var $workouts = $('.workout');

  $('#filter_distance').on('click', function() {
    var minDistance = parseFloat($('#minimum_filter_distance').val());
    var maxDistance = parseFloat($('#maximum_filter_distance').val());
    var speeds = [];

    $workouts.each(function (index, workout) {
      var $workout = $(workout);
      var $workoutDistance = parseFloat($workout.find('.distance').text());
      var $workoutSpeed = parseFloat($workout.find('.speed').text());

      if ($workoutDistance >= minDistance && $workoutDistance <= maxDistance) {
        $workout.show();
        speeds.push($workoutSpeed);
      } else {
        $workout.hide();
      }
    });

    var total = 0;
    for(var i = 0; i < speeds.length; i++) {
        total += speeds[i];
    }
    var avg = total / speeds.length;

    $('.average_speed').html('Average Speed for this Distance: ' + avg + ' mph');
    $('.average_speed').show();
  });
});
