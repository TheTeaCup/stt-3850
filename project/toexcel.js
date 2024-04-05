var XLSX = require("xlsx");

console.log("Creating a excel sheet");

const BonneSanteIslanders = require("./islands/BonneSanteIslanders-surveyed.json");
const IronBardIslanders = require("./islands/IronBardIslanders-surveyed.json");
const ProvidenceIslanders = require("./islands/ProvidenceIslanders-surveyed.json");

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
    "What is the predominant colour of your eyes?",
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

let header = [
    "Person",
    "Island",
    "Village",
    ...questions, // Spread the questions array to include in the header
  ];

var workbook = XLSX.utils.book_new();
var ws_data = [header];

// Function to add a row for each islander
function addIslanderRow(islander, islandName) {
    let row = [];
    row.push(islander.url);
    row.push(islandName);
    row.push(islander.village);
  
    // Map each question to its corresponding response
    questions.forEach((question) => {
      const response = islander.responses.find((r) => r.question === question);
      if (response) {
        row.push(response.response);
      } else {
        row.push(""); // If no response found, add an empty cell
      }
    });
  ws_data.push(row);
}

BonneSanteIslanders.forEach((islander) => {
  addIslanderRow(islander, "Bonne Sante");
});

IronBardIslanders.forEach((islander) => {
  addIslanderRow(islander, "Iron Bard");
});

ProvidenceIslanders.forEach((islander) => {
  addIslanderRow(islander, "Providence");
});

var ws = XLSX.utils.aoa_to_sheet(ws_data);
XLSX.utils.book_append_sheet(workbook, ws, "Islanders");

XLSX.writeFile(workbook, "islanders.xlsx");

console.log("Excel sheet created!");