const puppeteer = require("puppeteer");
const fs = require("fs");
require("dotenv").config({
  path: "./.env",
});

const islanderData = require("./islands/BonneSanteIslanders.json");

const delay = (ms) => new Promise((res) => setTimeout(res, ms));

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

      await page.waitForSelector("button[id=t3tab]");
      await page.evaluate(() => {
        document.querySelector("button[id=t3tab]").click();
      });

      if (islanderData[i].ignore) {
        console.log(
          i +
            1 +
            ". ignoring islander: " +
            islanderData[i].url.split("?id=")[1] +
            " of " +
            islanderData[i].village
        );
        continue;
      } else {
        await page.type("#chatbox", "do you have diabetes?");
        await page.keyboard.press("Enter");

        // Wait for the response message to appear
        await page.waitForSelector("#conversation .chatbot");

        // Extract the response text
        const response = await page.$eval("#conversation .chatbot", (element) =>
          element.textContent.trim()
        );

        console.log("Response: ", response);

        islanderData[i].responses = [
          {
            question: "do you have diabetes?",
            answer: response,
          },
        ];

        fs.writeFileSync(
          "islands/BonneSanteIslanders-surveyed-2.json",
          JSON.stringify(islanderData, null, 2)
        );
        // await delay(1500);
      }
    }
    console.log("All islanders surveyed!");

    browser.close();
  }, 2000);
}

(async () => {
  await surveyIslander();
})();
