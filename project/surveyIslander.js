const puppeteer = require("puppeteer");
const fs = require("fs");
require("dotenv").config({
  path: "./.env",
});

const islanderData = require("./islands/BonneSanteIslanders.json");

async function delay(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

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
      console.log(
        i +
          1 +
          ". surverying islander: " +
          islanderData[i].url.split("?id=")[1] +
          " of " +
          islanderData[i].village
      );
      await page.goto(islanderData[i].url);

      await page.waitForSelector("button[id=t2tab]");
      await page.evaluate(() => {
        document.querySelector("button[id=t2tab]").click();
      });

      // await delay(1000);

      // this runs the survey
      await page.evaluate(() => {
        [...document.querySelectorAll(".task span")]
          .find((element) => element.textContent === "Complete Survey")
          .click();
      });
    }
    console.log("All islanders surveyed!");

    browser.close();
  }, 2000);
}

(async () => {
  await surveyIslander();
})();
