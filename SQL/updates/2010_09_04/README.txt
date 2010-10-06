Перед обновлением не забудьте сделать резервные копии всех обновляемых баз данных

Сначала запустите скрипты обновления для годовых баз RujelYear20??
тех учебных лет, которые у Вас есть.

В последнюю очередь (!!!) - скрипт RujelStatic

mysql -u root -p < RujelYear2009.sql
mysql -u root -p < RujelYear2010.sql
mysql -u root -p < RujelStatic.sql
