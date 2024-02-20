const puppeteer = require("puppeteer");
//const {setTimeout} = require("node:timers/promises");
require("dotenv").config({
  path: "./.env",
});

const islanderData = require("./islanderData.json");

async function surveyIslander() {
  const browser = await puppeteer.launch({
    headless: false,
    defaultViewport: null,
  });

  const page = await browser.newPage();

  await page.goto("https://islands.smp.uq.edu.au/");

  await page.type("input[name=email]", process.env.EMAIL);
  await page.type("input[name=word]", process.env.PASSWORD);
  await page.evaluate(() => {
    document.querySelector("input[type=submit]").click();
  });

  setTimeout(async () => {
    for (let i = 0; i < islanderData.length; i++) {
      //console.log(islanderData[i].url)
      await page.goto(islanderData[i].url);

      // this does not work at the moment
      await page.evaluate(() => {
        [...document.querySelectorAll(".elements button")]
          .find((element) => element.textContent === "Obtain consent from ")
          .click(); // document.querySelector('button[id=t2tab]').click();
      });
    }
  }, 1000);
}

(async () => {
  await surveyIslander();
})();
