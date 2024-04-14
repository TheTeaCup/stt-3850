var XLSX = require("xlsx");

console.log("Creating a excel sheet");

const BonneSanteIslanders = require("./islands/BonneSanteIslanders-surveyed-2.json");
const IronBardIslanders = require("./islands/IronBardIslanders-surveyed-2.json");
const ProvidenceIslanders = require("./islands/ProvidenceIslanders-surveyed-2.json");

let questions = [
  "do you have diabetes?",
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
  if (Array.isArray(islander.responses)) {
    // Map each question to its corresponding response
    questions.forEach((question) => {
      const response = islander.responses.find((r) => r.question === question);
      if (response) {
        row.push(response.answer);
      } else {
        row.push(""); // If no response found, add an empty cell
      }
    });
  } else {
    // If islander.responses is not an array, add empty cells for each question
    questions.forEach(() => {
      row.push("");
    });
  }
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

XLSX.writeFile(workbook, "islanders-2.xlsx");

console.log("Excel sheet created!");
