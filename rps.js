
window.onload = function() {
    $('#rock').click(handle);
    $('#paper').click(handle);
    $('#scissors').click(handle);

    var d = {
        1: 'rock',
        2: 'paper',
        3: 'scissors'
    };

    function handle(e) {
        console.log(e);

        var a = d[(Math.floor(Math.random() * 3) + 1)];
        var b = e.target.id;
        var r = '';

        if (b == 'rock') {
            if (a == 'rock') {
                r = 'Draw';
            } else if (a == 'paper') {
                r = 'Loss';
            } else {
                r = 'Win';
            }
        } else if (b == 'paper') {
            if (a == 'rock') {
                r = 'Win';
            } else if (a == 'paper') {
                r = 'Draw';
            } else {
                r = 'Loss';
            }
        } else {
            if (a == 'rock') {
                r = 'Loss';
            } else if (a == 'paper') {
                r = 'Win';
            } else {
                r = 'Draw';
            }
        }

        $('#a').html('<i class="fa fa-hand-'+a+'-o"></i>');
        $('#b').html('<i class="fa fa-hand-'+b+'-o"></i>');
        $('#r').html(r);

        $('#myModal').modal('show');
    }
};
