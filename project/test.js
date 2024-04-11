const puppeteer = require("puppeteer");
const fs = require("fs");
require("dotenv").config({
  path: "./.env",
});

const questions = [
  "Blood Pressure",
  "Skin Colouration",
  "Waist Circumference",
  "Blood Glucose",
  "Blood Cortisol",
  "Personality Test",
];

async function islanderResponses() {
  const browser = await puppeteer.launch({
    headless: false, // Set to true for production
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
    await page.goto("https://islands.smp.uq.edu.au/islander.php?id=w7p6348bhx");

    await page.evaluate(() => {
      document.querySelector("button[id=t2tab]").click();
    });

    await page.waitForSelector(".taskresult");

    const data = await page.evaluate((questions) => {
      const taskResults = document.querySelectorAll(".taskresult");
      const resultArray = [];
      const uniqueQuestions = new Set();

      taskResults.forEach((taskResult) => {
        const taskNameElement = taskResult.querySelector(".taskresulttask");
        if (taskNameElement) {
          const taskName = taskNameElement.textContent.trim();
          if (questions.includes(taskName) && !uniqueQuestions.has(taskName)) {
            uniqueQuestions.add(taskName);

            const taskText = taskResult.textContent.trim();
            if (taskText) {
              // Split the taskText by newline characters to extract the answer
              const taskLines = taskText.split("\n");
              const answer = taskLines[2]; // Assuming the answer is always at index 2
              if (answer) {
                resultArray.push({ question: taskName, answer }); // Bundle question and answer together
              }

              if (taskName === "Personality Test") {
                const personalityResults = taskResult.querySelectorAll(".taskrfr");
                personalityResults.forEach((personality) => {
                  const traitName = personality.querySelector(".taskrfood").textContent.trim();
                  const traitWeight = personality.querySelector(".taskrfoodweight").textContent.trim();
                  resultArray.push({ question: traitName, answer: traitWeight });
                });
              }
            }
          }
        }
      });

      return resultArray;
    }, questions);

    console.log(data);
  }, 1000);
}

// (async () => {
//   await islanderResponses();
// })();

async function extractPersonalityTest() {
  const browser = await puppeteer.launch({
    headless: false, // Set to true for production
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
  // Navigate to the page
  await page.goto("https://islands.smp.uq.edu.au/islander.php?id=w7p6348bhx");

  // Wait for the page to load
  await page.waitForSelector(".taskresult");

  const personalityData = await page.evaluate(() => {
    const personalityResults = document.querySelectorAll(".taskresult.taskreportcard");

    const personalityTraits = [];
    personalityResults.forEach((personalityResult) => {
      const traitElements = personalityResult.querySelectorAll(".taskrfr");
      const traitData = {};
      traitElements.forEach((traitElement) => {
        const traitName = traitElement.querySelector(".taskrfood").textContent.trim();
        const traitWeight = traitElement.querySelector(".taskrfoodweight").textContent.trim();
        traitData[traitName] = traitWeight;
      });
      personalityTraits.push(traitData);
    });

    return personalityTraits;
  });

  console.log(personalityData);

  await browser.close();
}, 1000);
}

extractPersonalityTest();
