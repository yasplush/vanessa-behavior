﻿#Использовать v8runner
#Использовать logos

Перем Лог;

Лог = Логирование.ПолучитьЛог("behavior.build.log");

массивСервисныхБаз = Новый Массив();
массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\82\",".\distr\v82ServiceBase", "8.3"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\distr\v83ServiceBase", "8.3"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\distr\v83NoSyncServiceBase", "8.3"));

УправлениеКонфигуратором = Новый УправлениеКонфигуратором();
УправлениеКонфигуратором.КаталогСборки(".\distr\");	

Для каждого _конфигурация из массивСервисныхБаз Цикл
	
	Лог.Информация("Обрабатываю исходные файлы " + _конфигурация.ПутьКИсходникам);

	указательНаБазу = Новый Файл(_конфигурация.СоздаваемаяБаза + "\1Cv8.1cd");

	путьКПлатформе = УправлениеКонфигуратором.ПолучитьПутьКВерсииПлатформы(_конфигурация.Версия);
	УправлениеКонфигуратором.ПутьКПлатформе1С(путьКПлатформе);

	Если указательНаБазу.Существует() Тогда
		лог.Отладка("Ранее был создан каталог " + _конфигурация.СоздаваемаяБаза);
	Иначе
		лог.Отладка("Создание сервисной базы контрибьютора " + _конфигурация.СоздаваемаяБаза);
		УправлениеКонфигуратором.СоздатьФайловуюБазу(_конфигурация.СоздаваемаяБаза);
	КонецЕсли;	

	УправлениеКонфигуратором.УстановитьКонтекст("/F" + _конфигурация.СоздаваемаяБаза + "\","","");

	ПараметрыЗапуска = УправлениеКонфигуратором.ПолучитьПараметрыЗапуска();
	ПараметрыЗапуска.Добавить("/LoadConfigFiles""" + _конфигурация.ПутьКИсходникам + """"); 

	УправлениеКонфигуратором.ВыполнитьКоманду(ПараметрыЗапуска);

	УправлениеКонфигуратором.ВыполнитьСинтаксическийКонтроль();

	УправлениеКонфигуратором.ОбновитьКонфигурациюБазыДанных();

КонецЦикла;

УправлениеКонфигуратором.ЗапуститьВРежимеПредприятия("",Истина);

