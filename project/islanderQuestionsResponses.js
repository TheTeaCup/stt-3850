let questions = [
  "Blood Pressure",
  "Skin Colouration",
  "Waist Circumference",
  "Blood Glucose",
  "Blood Cortisol",
  "Personality Test",
];

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
          ". collecting question responses islander: " +
          islanderData[i].url.split("?id=")[1] +
          " of " +
          islanderData[i].village
      );

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
        await page.goto(islanderData[i].url);

        await page.evaluate(() => {
          document.querySelector("button[id=t2tab]").click();
        });

        // Wait for the responses to load
        await page.waitForSelector(".taskresultquestion");

        const data = await page.evaluate((questions) => {
          const taskResults = document.querySelectorAll(".taskresult");
          const resultArray = [];
          const uniqueQuestions = new Set();

          taskResults.forEach((taskResult) => {
            const taskNameElement = taskResult.querySelector(".taskresulttask");
            if (taskNameElement) {
              const taskName = taskNameElement.textContent.trim();
              if (
                questions.includes(taskName) &&
                !uniqueQuestions.has(taskName)
              ) {
                uniqueQuestions.add(taskName);

                const taskText = taskResult.textContent.trim();
                if (taskText) {
                  // Split the taskText by newline characters to extract the answer
                  const taskLines = taskText.split("\n");
                  const answer = taskLines[2]; // Assuming the answer is always at index 2
                  if (answer) {
                    resultArray.push({ question: taskName, answer }); // Bundle question and answer together
                  }
                }
              }
            }
          });

          return resultArray;
        }, questions);

        // get the personality test results
        const personalityResults = await extractPersonalityTestResults(page);
        const formattedPersonalityResults = Object.entries(
          personalityResults
        ).map(([question, answer]) => ({
          question,
          answer,
        }));

        const combinedData = [...data, ...formattedPersonalityResults];

        islanderData[i].responses = combinedData;

        // Write the updated data back to the JSON file
        fs.writeFileSync(
          "islands/ProvidenceIslanders-surveyed-1.json",
          JSON.stringify(islanderData, null, 2)
        );
      }
    }

    console.log("All islanders responses received!");

    browser.close();
  }, 1000);
}

(async () => {
  await islanderResponses();
})();

async function extractPersonalityTestResults(page) {
  const personalityTestResults = await page.evaluate(() => {
    const resultCard = document.querySelector(".taskreportcard");
    const results = {};

    if (resultCard) {
      const testItems = resultCard.querySelectorAll(".taskrfr");

      testItems.forEach((item) => {
        const testName = item.querySelector(".taskrfood").textContent.trim();
        const testWeight = item
          .querySelector(".taskrfoodweight")
          .textContent.trim();

        results[testName] = testWeight;
      });
    }

    return results;
  });

  return personalityTestResults;
}
