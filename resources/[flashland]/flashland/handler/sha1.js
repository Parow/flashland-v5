
const sha1 = require('sha1');


onNet("sha1", (callback,msg) => {
    callback(sha1(msg))
});