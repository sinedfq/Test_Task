/*
Основная функция main. В данной функции происходит загрузка данных из JSON файла,
распределение данных в переменные для удобства.
*/
(async function main() {
  try {
    const dataObj = await getDataFromFile('./data.json');
    const passport = dataObj.passport;
    const creditHistory = dataObj.creditHistory;

    // перевод даты выдачи паспорта в удобный для работы формат
    const passDate = new Date(passport.issuedAt);

    // перевод даты рождения в удобный для работы формат
    const birthday = new Date(dataObj.birthDate);

    // получение текущей даты
    const today = new Date();

    // подсчёт возраста клиента
    const age = calculateAge(today, birthday);

    // подсчёт времени между днём рождения клиента и выдачей паспорта
    const datePassBithday = -1 * calculateAge(birthday, passDate);

    if (!checkCorrectAge(age, datePassBithday)){
      console.log("Correct Age: ", false);
      return false;
    }

    const creditHist = dataObj.creditHistory;
    if (getOverdueDays(creditHist) > 2){
      console.log("Overdue days: ", false);
      return false;
    }

    if(!checkCreditHisroty(creditHistory)){
      console.log("Credit History: ", false);
      return false;
    }
    
    console.log("Credit approved: ", true);
    return true;

  } catch (error) {
    console.error("Ошибка при обработке: ", error);
  }
})();

/* Считывание данных из JSON файла. */
async function getDataFromFile(filePath) {
  const response = await fetch(filePath);
  const data = await response.text();
  return JSON.parse(data);
}

/* Определение возраста клиента */
function calculateAge(today, bd) {

  // Вычисляем начальный возраст, вычитая год рождения из текущего года
  let age = today.getFullYear() - bd.getFullYear();
  
  // Получаем разницу в месяцах между текущей датой и датой рождения
  const m = today.getMonth() - bd.getMonth();
  
  // Проверяем, если текущий месяц меньше месяца рождения или если текущий месяц равен месяцу рождения, но текущая дата меньше даты рождения
  if (m < 0 || (m === 0 && today.getDate() < bd.getDate())) {
    age--;
  }

  return age;
}


/* Рассчёт корректонсти даты рождения и выдачи паспорта */
function checkCorrectAge(age, datePassBithday){
  // Если клиент моложе 20 лет – отказ.
  if (age < 20) { 
    return false;
  }
  //  Если возраст клиента более 20 лет и дата выдачи паспорта ранее, чем дата достижения им возраста 20 лет, то отказ
  if (age >= 20 && datePassBithday < 20) { 
    return false;
  }
  // Если возраст клиента более 45 лет и дата выдачи паспорта ранее, чем датадостижения им возраста 45 лет - отказ.
  if (age >= 45 && datePassBithday < 45) { 
    return false;
  }
  return true;
}

/* Проверка 3 условия выдачи кредита */
function getOverdueDays(obj) {

  // Счётчик дней у которых имеется задолженность > 15 дней
  let counter = 0;

  for (const key in obj) {
    if (obj[key].type == "Кредитная карта"){
      continue;
    }
    if (obj[key].numberOfDaysOnOverdue > 15) {
      counter += 1;
    }
  }
  return counter;
}

/* Проверка на соблюдение условий одобрения кредита, взятого Наличными */
function checkCredit(obj) {
  let status = obj.currentOverdueDebt == 0 ? true : false;
  if (status && obj.numberOfDaysOnOverdue < 60) {
    return true;
  }
}

/* Проверка на соблюдение условий одобрения кредита, взятого при помощи Кредитной карты */
function checkCreditCard(obj) {
  let status = obj.currentOverdueDebt == 0 ? true : false;
  if (status && obj.numberOfDaysOnOverdue < 30) {
    return true;
  }
}

/* Проверка кредитной истории на удовлетворение условиям */
function checkCreditHisroty(creditHistory){
  for (const key in creditHistory) {
    const ch = creditHistory[key];
    if (ch.type == "Кредитная карта" && !checkCreditCard(ch)) {
      return false;
    } else if (!checkCredit(ch)) {
      return false;
    }
  }
  return true;
}