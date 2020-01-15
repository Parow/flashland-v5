const uuid = require('uuid-with-v6');

onNet("uuid", (callback) => {
    console.log("GetUUID")
    callback(uuid.v6())
});