const uuid = require('uuid-with-v6');

on("rage-reborn:uuid", (callback) => {
    console.log("o")
    callback(uuid.v6())
});

