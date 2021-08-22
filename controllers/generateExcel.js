const ExcelJS = require("exceljs");
const faker = require("faker");

const generateExcelKlienci = function (req, res) {
  let workbook = new ExcelJS.Workbook();
  let worksheet = workbook.addWorksheet("Klienci");

  faker.locale = "pl";
  const statusArray = ["Aktywny", "Zamknięty"];

  let arrayOfRows = [];
  for (let i = 1; i <= 500; i++) {
    let randomStatus = Math.floor(Math.random() * statusArray.length);
    rowOfMockData = [
      i,
      faker.company.companyName(),
      faker.date.past(),
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

  faker.locale = "pl";
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
    "AED",
    "CAD",
    "HUF",
    "CHF",
    "GBP",
    "SEK",
    "CZK",
    "RUB",
    "NOK",
  ];
  const randomHourArray = Array.from(Array(24).keys());

  let arrayOfRows = [];
  let numberOfRecords = 500;
  for (let i = 1; i <= numberOfRecords; i++) {
    let randomMonth = Math.floor(Math.random() * monthArray.length);
    let randomYear = Math.floor(Math.random() * yearArray.length);
    let randomCurrency = Math.floor(Math.random() * currencyArray.length);
    let randomHour = Math.floor(Math.random() * randomHourArray.length);

    let randomDate = new Date(
      yearArray[randomYear],
      monthArray[randomMonth],
      randomHourArray[randomHour],
      0,
      0
    );

    rowOfMockData = [
      Math.floor(Math.random() * numberOfRecords + 1),
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

  faker.locale = "pl";
  const currencyArray = [
    "PLN",
    "EUR",
    "USD",
    "AUD",
    "AED",
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
  let numberOfRecords = 500;
  for (let i = 1; i <= numberOfRecords; i++) {
    let randomCurrency = Math.floor(Math.random() * currencyArray.length);

    rowOfMockData = [
      i,
      Math.floor(Math.random() * numberOfRecords + 1),
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