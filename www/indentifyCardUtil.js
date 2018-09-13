var exec = require('cordova/exec');

exports.getMessage = function (arg0, success, error) {
    exec(success, error, 'indentifyCardUtil', 'getMessage', [arg0]);
};
