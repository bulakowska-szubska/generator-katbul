const ExcelJS = require("exceljs");
const faker = require("faker");
const axios = require("axios");

const getCurrencyRates = async (req, res) => {
  let dateFrom = req.params.dateFrom;
  let dateTo = req.params.dateTo;

  let currencyRatesData;
  try {
    currencyRatesData = await axios.get(
      `http://api.nbp.pl/api/exchangerates/tables/a/${dateFrom}/${dateTo}/?format=json`
    );
  } catch (err) {
    console.log("Error", err);
  }

  let ratesArray = [];
  for (i = 0; i < currencyRatesData.data.length; i++) {
    for (j = 0; j < currencyRatesData.data[i].rates.length; j++) {
      ratesPerCurrency = [
        currencyRatesData.data[i].effectiveDate,
        currencyRatesData.data[i].rates[j].currency,
        currencyRatesData.data[i].rates[j].code,
        currencyRatesData.data[i].rates[j].mid,
      ];
      ratesArray.push(ratesPerCurrency);
    }
  }

  let workbook = new ExcelJS.Workbook();
  let worksheet = workbook.addWorksheet("KursyWalutNBP");
  worksheet.addRows(ratesArray);

  fileName = "Kursy_NBP_" + dateFrom + "_" + dateTo + ".xlsx";
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

exports.getCurrencyRates = getCurrencyRates;
