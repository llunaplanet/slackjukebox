exports.handler = function(event, context, callback) {
    console.log("value1 = " + event.key1);
    console.log("value2 = " + event.key2);
    return_output = {
        "statusCode": 200,
        // "headers": { "headerName": "headerValue", ... },
        "body": "hello_world"
    }
   callback(null, return_output);
}
