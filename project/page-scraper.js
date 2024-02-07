const puppeteer = require("puppeteer");
require('dotenv').config({
    path: './.env'
});

(async () => {
    const browser = await puppeteer.launch({
        headless: false,
        defaultViewport: null,
      });

    const page = await browser.newPage();

    await page.goto("https://islands.smp.uq.edu.au/");

    await page.type("input[name=email]", process.env.EMAIL);
    await page.type("input[name=word]", process.env.PASSWORD);
    await page.evaluate(() => {
        document.querySelector('input[type=submit]').click();
    });
    
})();