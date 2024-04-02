const puppeteer = require("puppeteer");
const fs = require("fs");
require("dotenv").config({
  path: "./.env",
});

async function foodDiary() {
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
    await page.goto("https://islands.smp.uq.edu.au/islander.php?id=8yjtfvwddl");

    await page.evaluate(() => {
      document.querySelector("button[id=t2tab]").click();
    });

    //   await page.evaluate(() => {
    //     [...document.querySelectorAll(".task span")]
    //       .find((element) => element.textContent === "Food Diary")
    //       .click();
    //   });

    await page.waitForSelector('.taskreportcard'); // Wait for the task report card to load

    const foodItems = await page.evaluate(() => {
      const foodElements = document.querySelectorAll('.taskrfr');
      const foodList = [];
      foodElements.forEach(element => {
        const foodName = element.querySelector('.taskrfood').textContent;
        const foodWeight = element.querySelector('.taskrfoodweight').textContent;
        foodList.push({ foodName, foodWeight });
      });
      return foodList;
    });

    console.log(foodItems)


  }, 500);
}

(async () => {
  await foodDiary();
})();
