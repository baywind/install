Kalendae.moment.lang('ru', {
  months: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", 
           "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"],    
    monthsShort : "янв_фев_мар_апр_май_июн_июл_авг_сен_окт_ноя_дек".split("_"),
    weekdaysShort : "вск_пнд_втр_срд_чтв_птн_сбт".split("_"),
    weekdaysMin : "вс_пн_вт_ср_чт_пт_сб".split("_"),
    week : {
        dow : 1, // Monday is the first day of the week.
    }
});

Kalendae.prototype.defaults.weekStart = 1;
Kalendae.prototype.defaults.format = 'DD.MM.YYYY';
Kalendae.prototype.defaults.useYearNav = false;
//Kalendae.prototype.defaults.dayOutOfMonthClickable = true;
Kalendae.Input.prototype.defaults.weekStart = 1;
Kalendae.Input.prototype.defaults.format = 'DD.MM.YYYY';
Kalendae.Input.prototype.defaults.useYearNav = false;
Kalendae.Input.prototype.defaults.offsetTop = 3;

Kalendae.moment.defaultFormat = 'DD.MM.YYYY';

var shortDateFormat = 'DD.MM';