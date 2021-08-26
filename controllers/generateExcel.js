const ExcelJS = require("exceljs");
const faker = require("faker");

const generateExcelKlienci = function (req, res) {
  let workbook = new ExcelJS.Workbook();
  let worksheet = workbook.addWorksheet("Klienci");

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
  const randomDayArray = Array.from(Array(24).keys());

  const statusArray = ["Aktywny", "Zamknięty"];

  let arrayOfRows = [];
  for (let i = 1; i <= 1000; i++) {
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
  const yearArray = ["2018", "2019", "2020", "2021"];
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
  const randomDayArray = Array.from(Array(24).keys());

  let arrayOfRows = [];
  let numberOfRecords = 10000;
  let numberOfClients = 1000;
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
      faker.finance.amount(10, 10000, 2),
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
  const yearArray = ["2018", "2019", "2020", "2021"];
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

  let arrayOfRows = [];
  let numberOfRecords = 2000;
  let numberOfClients = 1000;
  for (let i = 1; i <= numberOfRecords; i++) {
    let randomCurrency = Math.floor(Math.random() * currencyArray.length);
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
      Math.floor(Math.random() * numberOfClients + 1),
      randomDate,
      faker.finance.amount(10, 10000, 2),
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