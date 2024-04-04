const puppeteer = require("puppeteer");
const fs = require("fs");
require("dotenv").config({
  path: "./.env",
});

const islanderData = require("./islands/BonneSanteIslanders.json");
let questions = [
  "Are you male or female?",
  "How many years old are you?",
  "How tall are you in centimetres?",
  "How many children do you have?",
  "How many times have you married?",
  "How many villages have you lived in?",
  "When is your birthday?",
  "Which village were you born in?",
  "Which year were you born in?",
  "On a scale from 1 to 10, how attractive do you think you are to members of the opposite sex?",
  "What is the predominant colour of your eyes",
  "How many hours did you sleep last night?",
  "How many minutes did you spend doing low intensity physical activity in the last seven days?",
  "How many minutes did you spend doing moderate physical activity in the last seven days?",
  "How many minutes did you spend doing vigorous physical activity in the last seven days?",
  "How much do you weigh in kilograms?",
  "What is your pulse rate while you are completing this survey?",
  "Do you eat meat?",
  "How many serves of fruit do you usually eat each day?",
  "How many serves of vegetables do you usually eat each day?",
  "Compared with one year ago, how would you rate your health in general now?",
  "Have you ever had a coronary heart event?",
  "How often do you currently smoke cigarettes?",
  "On a scale from 1 to 10, how anxious do you feel right now?",
  "On a scale from 1 to 10, how depressed do you feel right now?",
  "What is your favourite music genre?",
  "What musical instruments do you play?",
  "Are you currently breastfeeding?",
  "What do you think your IQ is on the adult intelligence scale?",
  "What is your favourite pizza topping?",
  "Which superpower would you most like to have?",
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
      const filteredData = questions
        .filter((question) =>
          surveyResults.some((result) => result.question === question)
        )
        .map((question) => ({
          question,
          response: surveyResults.find((result) => result.question === question)
            ?.response,
        }));


      islanderData[i].responses = filteredData;

      // Write the updated data back to the JSON file
      fs.writeFileSync(
        "islands/BonneSanteIslanders-surveyed.json",
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
