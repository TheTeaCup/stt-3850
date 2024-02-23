const puppeteer = require("puppeteer");
const fs = require("fs");
require("dotenv").config({
  path: "./.env",
});

const islanderData = require("./islanderData.json");

let questions = [
    "Are you male or female?",
    "How many years old are you?",
    "How tall are you in centimetres?",
    "How many times have you married?",
    "How many siblings do you have?",
    "How many children do you have?",
];  

async function islanderResponses() {
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

      await page.evaluate(() => {
        document.querySelector("button[id=t2tab]").click();
      });

      // this gets the responses

      await page.waitForSelector(".taskresultquestion");

      // Extract question and response pairs
      const surveyResults = await page.evaluate(() => {
        const questions = Array.from(
          document.querySelectorAll(".taskresultquestion")
        ).map((question) => question.textContent.trim());
        const responses = Array.from(
          document.querySelectorAll(".taskresultresponse")
        ).map((response) => response.textContent.trim());
        return questions.map((question, index) => ({
          question,
          response: responses[index],
        }));
      });

      islanderData[i].responses = surveyResults;

      // Write the updated data back to the JSON file
      fs.writeFileSync(
        "islanderData-surveyed.json",
        JSON.stringify(islanderData, null, 2)
      );
      
    }
    console.log("All islanders responses recieved!");

    browser.close();
  }, 1000);
}

(async () => {
  await islanderResponses();
})();
