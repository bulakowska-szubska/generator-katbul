const ExcelJS = require("exceljs");
const faker = require("faker");

const monthArray = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
];
const yearArray = ["2018", "2019", "2020"];
const yearArray2 = ["2018", "2019", "2020", "2021"];
const randomDayArray = Array.from(Array(24).keys());
const currencyArray = [
  "PLN",
  "EUR",
  "USD",
  "AUD",
  "DKK",
  "CAD",
  "HUF",
  "CHF",
  "GBP",
  "SEK",
  "CZK",
  "RUB",
  "NOK",
];

const statusArray = ["Active", "Inactive"];
const numberOfRecords = 10000;
const numberOfClients = 1000;
const financeAmount = 10000;

const generateExcelKlienci = function (req, res) {
  let workbook = new ExcelJS.Workbook();
  let worksheet = workbook.addWorksheet("Klienci");

  let arrayOfRows = [];
  for (let i = 1; i <= numberOfClients; i++) {
    let randomStatus = Math.floor(Math.random() * statusArray.length);
    let randomMonth = Math.floor(Math.random() * monthArray.length);
    let randomYear = Math.floor(Math.random() * yearArray.length);
    let randomDay = Math.floor(Math.random() * randomDayArray.length);

    let randomDate = new Date(
      yearArray[randomYear],
      monthArray[randomMonth],
      randomDayArray[randomDay],
      0,
      0
    );
    rowOfMockData = [
      i,
      faker.company.companyName(),
      randomDate,
      faker.address.state(),
      faker.address.cityName(),
      faker.address.streetAddress(),
      statusArray[randomStatus],
    ];
    arrayOfRows.push(rowOfMockData);
  }

  worksheet.addRows(arrayOfRows);

  fileName = "klienci.xlsx";
  // res is a Stream object
  res.setHeader(
    "Content-Type",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  );
  res.setHeader("Content-Disposition", "attachment; filename=" + fileName);

  return workbook.xlsx.write(res).then(function () {
    console.log(`Saved a Excel file - ${fileName}`);
    res.status(200).end();
  });
};

const generateExcelUmowy = function (req, res) {
  let workbook = new ExcelJS.Workbook();
  let worksheet = workbook.addWorksheet("Umowy");

  let arrayOfRows = [];

  for (let i = 1; i <= numberOfRecords; i++) {
    let randomMonth = Math.floor(Math.random() * monthArray.length);
    let randomYear = Math.floor(Math.random() * yearArray.length);
    let randomCurrency = Math.floor(Math.random() * currencyArray.length);
    let randomDay = Math.floor(Math.random() * randomDayArray.length);

    let randomDate = new Date(
      yearArray[randomYear],
      monthArray[randomMonth],
      randomDayArray[randomDay],
      0,
      0
    );

    rowOfMockData = [
      i,
      Math.floor(Math.random() * numberOfClients + 1),
      randomDate,
      monthArray[randomMonth],
      yearArray[randomYear],
      faker.finance.amount(10, financeAmount, 2),
      currencyArray[randomCurrency],
    ];
    arrayOfRows.push(rowOfMockData);
  }

  worksheet.addRows(arrayOfRows);

  fileName = "umowy.xlsx";
  // res is a Stream object
  res.setHeader(
    "Content-Type",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  );
  res.setHeader("Content-Disposition", "attachment; filename=" + fileName);

  return workbook.xlsx.write(res).then(function () {
    console.log(`Saved a Excel file - ${fileName}`);
    res.status(200).end();
  });
};

const generateExcelWplaty = function (req, res) {
  let workbook = new ExcelJS.Workbook();
  let worksheet = workbook.addWorksheet("Wplaty");

  let arrayOfRows = [];
  for (let i = 1; i <= numberOfRecords; i++) {
    let randomCurrency = Math.floor(Math.random() * currencyArray.length);
    let randomMonth = Math.floor(Math.random() * monthArray.length);
    let randomYear = Math.floor(Math.random() * yearArray2.length);
    let randomDay = Math.floor(Math.random() * randomDayArray.length);

    let randomDate = new Date(
      yearArray2[randomYear],
      monthArray[randomMonth],
      randomDayArray[randomDay],
      0,
      0
    );

    rowOfMockData = [
      i,
      Math.floor(Math.random() * numberOfClients + 1),
      randomDate,
      faker.finance.amount(10, financeAmount, 2),
      currencyArray[randomCurrency],
    ];
    arrayOfRows.push(rowOfMockData);
  }

  worksheet.addRows(arrayOfRows);

  fileName = "wplaty.xlsx";
  // res is a Stream object
  res.setHeader(
    "Content-Type",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  );
  res.setHeader("Content-Disposition", "attachment; filename=" + fileName);

  return workbook.xlsx.write(res).then(function () {
    console.log(`Saved a Excel file - ${fileName}`);
    res.status(200).end();
  });
};

exports.generateExcelKlienci = generateExcelKlienci;
exports.generateExcelUmowy = generateExcelUmowy;
exports.generateExcelWplaty = generateExcelWplaty;
