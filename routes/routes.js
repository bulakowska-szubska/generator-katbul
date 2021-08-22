const express = require('express');

const generateExcel = require('../controllers/generateExcel');
const getCurrencyRates = require('../controllers/getCurrencyRates');

const router = express.Router();

router.get('/generateExcelKlienci', generateExcel.generateExcelKlienci);

router.get('/generateExcelUmowy', generateExcel.generateExcelUmowy);

router.get('/generateExcelWplaty', generateExcel.generateExcelWplaty);

router.get('/getCurrencyRates/:dateFrom/:dateTo', getCurrencyRates.getCurrencyRates);

module.exports = router;
