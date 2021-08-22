const ExcelJS = require("exceljs");
const faker = require("faker");
const axios = require("axios");

const getCurrencyRates = async (req, res) => {
    let dateFrom =  req.params.dateFrom;
    let dateTo = req.params.dateTo;

    console.log(dateFrom);
    console.log(dateTo);
    
    let currencyRatesData;
    try {
        currencyRatesData = await axios.get(
          `http://api.nbp.pl/api/exchangerates/tables/a/${dateFrom}/${dateTo}/?format=json`
        );
      } catch (err) {
        console.log('Error', err)
      }
    
      console.log(currencyRatesData.data);
      
    res.send('Pobrano dane');
  };

  exports.getCurrencyRates = getCurrencyRates;
