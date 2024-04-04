const puppeteer = require("puppeteer");
const fs = require("fs");
require("dotenv").config({
  path: "./.env",
});

const islanderData = require("./islands/ProvidenceIslanders.json");

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
          ". surveying islander: " +
          islanderData[i].url.split("?id=")[1] +
          " of " +
          islanderData[i].village
      );
      await page.goto(islanderData[i].url);

      await page.evaluate(() => {
        document.querySelector("button[id=t2tab]").click();
      });

      // Wait for the responses to load
      await page.waitForSelector(".taskresultquestion");

      // Extract question and response pairs
      const surveyResults = await page.evaluate(() => {
        const questionElements = Array.from(
          document.querySelectorAll(".taskresultquestion")
        );
        const responseElements = Array.from(
          document.querySelectorAll(".taskresultresponse")
        );

        const uniqueQuestions = [];
        const uniqueResponses = [];

        for (let i = 0; i < questionElements.length; i++) {
          const questionText = questionElements[i].textContent.trim();
          if (!uniqueQuestions.includes(questionText)) {
            uniqueQuestions.push(questionText);
            uniqueResponses.push(responseElements[i].textContent.trim());
          }
        }

        return uniqueQuestions.map((question, index) => ({
          question,
          response: uniqueResponses[index],
        }));
      });

      islanderData[i].responses = surveyResults;

      // Write the updated data back to the JSON file
      fs.writeFileSync(
        "islands/ProvidenceIslanders-surveyed.json",
        JSON.stringify(islanderData, null, 2)
      );
    }

    console.log("All islanders responses received!");

    browser.close();
  }, 1000);
}

(async () => {
  await islanderResponses();
})();
