'use strict';
const AWS = require('aws-sdk');
const isPortReachable = require('is-port-reachable');


var response = {
		"statusCode": 200,
		"headers": {
			'Access-Control-Allow-Origin': '*',
			'Access-Control-Allow-Methods': 'GET',
			'Access-Control-Allow-Credentials': true,
		},
		"isBase64Encoded": false,
};

exports.testPort = function(request, context, callback) {
  response.body = "hello world";
  let host="mszumski.pl";
  let port=22;
  isPortReachable(port, {host: host}).then(reachable => {
      console.log(reachable);
      response.body = { reachable: reachable, port: port, host: host };
      callback(null, response);
  });
};
