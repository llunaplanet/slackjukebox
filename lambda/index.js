var SpotifyWebApi = require('spotify-web-api-node');


require('dotenv').config()

// credentials are optional
var spotifyApi = new SpotifyWebApi({
    clientId : process.env.SPOTIFY_CLIENT_ID,
    clientSecret : process.env.SPOTIFY_CLIENT_SECRET
});

// https://43669e62.ngrok.io
// https://jg81ngtvid.execute-api.eu-west-1.amazonaws.com/v1/slack

var express = require('express');
var app = express();

app.post('/', function(req, res){
  res.send('hello world');
});

app.listen(8080);

spotifyApi.getArtistAlbums('43ZHCT0cAZBISjO8DG9PnE')
    .then(function(data) {
        console.log('Artist albums', data.body);
    }, function(err) {
        console.error(err);
    });

    // var text = process.env.SLACK_OUTGOING === 'true' ? req.body.text.replace(req.body.trigger_word, '') : req.body.text;
    // if(text.indexOf(' - ') === -1) {
    //     var query = 'track:' + text;
    // } else {
    //     var pieces = text.split(' - ');
    //     var query = 'artist:' + pieces[0].trim() + ' track:' + pieces[1].trim();
    // }
    //
    // spotifyApi.searchTracks(query)
    //     .then(function(data) {
    //         var results = data.body.tracks.items;
    //         if (results.length === 0) {
    //           return slack(res, 'Could not find that track.');
    //         }
    //         var track = results[0];
    //         spotifyApi.addTracksToPlaylist(process.env.SPOTIFY_USERNAME, process.env.SPOTIFY_PLAYLIST_ID, ['spotify:track:' + track.id])
    //           .then(function(data) {
    //             var message = 'Track added' + (process.env.SLACK_OUTGOING === 'true' ? ' by *' + req.body.user_name + '*' : '') + ': *' + track.name + '* by *' + track.artists[0].name + '*'
    //             return slack(res, message);
    //           }, function(err) {
    //             return slack(res, err.message);
    //           });
    //       }, function(err) {
    //         return slack(res, err.message);
    //       });
    //   }, function(err) {
    //     return slack(res, 'Could not refresh access token. You probably need to re-authorise yourself from your app\'s homepage.');
    //   });
    //




// exports.handler = function(event, context, callback) {
//     console.log("value1 = " + event.key1);
//     console.log("value2 = " + event.key2);
//     return_output = {
//         "statusCode": 200,
//         // "headers": { "headerName": "headerValue", ... },
//         "body": "hello_world"
//     }
//    callback(null, return_output);
// }
