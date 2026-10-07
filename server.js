const express = require("express");

const app = express();

const PORT = process.env.PORT || 3000;
const DB_NAME = process.env.DB_NAME || "toy_default";
const BANNER = process.env.BANNER || "DEV";

app.use(express.static("public"));

app.get("/api/config", (req, res) => {
    res.json({
        banner: BANNER,
        dbName: DB_NAME,
        port: PORT
    });
});

app.listen(PORT, () => {
    console.log(`Toy App running on port ${PORT}`);
    console.log(`Environment: ${BANNER}`);
    console.log(`Database: ${DB_NAME}`);
});
