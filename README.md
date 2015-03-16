# Ruby_on_Rails_Reestr_Studens
Это репозиторий с прототипом тестового задания реализованного на Ruby on Rails.

###ВАЖНО! Проект является прототипом.

Список используемых технологий/инструментов:

    Ruby 2.2
    Ruby on Rails 4.2
    Slim
    SCSS
    JS
    jQuery
    AJAJ
    Mustache
    Poirot
    Twitter Bootstrap 3
    PostgreSQL


#Предложения по общей оптимизации задач и прототипа проекта:

1. Начальная точка: количество студентов 1-2 млн. записей и имеются конкурентные запросы.
2. Вынести данные со средним балом всех студентов в отдельную таблицу.
3. Создать форму с индивидуальным редактированием баллов каждого студента.
4. Расчёт среднего значения производится в форме на стороне клиента, после чего данные полей заносятся в таблицы.
5. Добавить к таблице студентов оптимистичную блокировку.
6. Произвести оптимизацию/верификацию SQL-запросов и перевести их в синтаксис Active Record.
7. Добавить систему валидации данных вводимых пользователем на стороне сервера и клиента.

#Описание тестового задания.

Требуется разработать простую систему для работы с реестром студентов.

Система должна позволять вносить студентов в базу данных и просматривать сформированный список.

Данные, которые заполняются при добавлении студента:

* имя;
* фамилия;
* учебная группа;
* дата рождения;
* email;
* IP-адрес;
* время регистрации.

Просмотр списка студентов предполагает вывод вышеописанных данных, а также списка предметов и оценок по ним для каждого студента, средний балл по всем предметам (одно число, 2 знака после запятой), номер семестра, характеристика научного руководителя (если таковая имеется).

    Сделать отдельную сводную таблицу, в которой будут отображаться 10 студентов с наивысшим средним баллом.

Также необходимо написать интерфейсы, которые позволяют осуществлять следующие выборки:

* однокурсников со средним баллом от ... до ... и именем %name%;
* всех людей, c IP которых произошло более одной регистрации, и при этом хотя бы у одного из них должна быть написана характеристика научного руководителя.

Требования к разработке:

* все запросы к серверу должны работать асинхронно, никакие действия не должны вести к перезагрузке страницы;
* для реализации клиентской части допускается использовать jQuery и/или простой JS.

Требования и особенности, которые надо учесть при дизайне схемы данных:

* студентов будет много (порядка 1-2 млн. записей);
* запись в таблицы с данными будет вестись в конкурентом режиме доступа;
* студенты могут часто переходить из одной группы в другую;
* предполагаются частые выборки по фильтрам (включая комбинации из фамилии, группы, семестра и среднего балла).

Особенности задачи:

* Дизайном и визуальным оформлением можно пренебречь.
* Язык реализации: Ruby.
* База данных: MySQL или PostgreSQL.
* Срок выполнения: 2 дня.

#Работа с проектом:

##Подготовка базы данных:
Для Ubuntu:

        sudo su postgres
        psql
        CREATE USER rails_user WITH CREATEDB password 'Pa$$w0rd!';
        \q
        exit
        CREATEDB reestr_students_db -h localhost -U rails_user
        GRANT ALL privileges ON DATABASE reestr_students_db TO rails_user;

Для OS X:

        psql postgres
        CREATE USER rails_user WITH CREATEDB password 'Pa$$w0rd!';
        \q
        CREATEDB reestr_students_db -h localhost -U rails_user
        GRANT ALL privileges ON DATABASE reestr_students_db TO rails_user;

##Настройка среды Ruby on Rails 4.2:

    bundle install
    rake db:migrate

##Список дополнительных команд Rake:
Наподнение базы данных тестовыми данными:

    rake db:populate

##Непосредственный запуск проекта:

    rails s -b <IP-ADDRESS> -p <PORT>

##Интерфейсы для запросов:
Получить список однокурсников со средним баллом от ... до ... и именем %name%:

    Student.all.sample.max_min_classmates(name, min_score, max_score)

Получить список студентов у которых один ip-адрес и заполненная характеристика:

    Student.students_with_ip_and_characteristics

##Список методов для реализации выборки параметров студентов по фильтрам:

###ВАЖНО! Все методы реализованы в рамках модели студентов.

Метод для выборки данных по фамилии:

    by_surname

Метод для выборки данных по группе:

    by_group

Метод для выборки данных по семестру:

    by_semester

Метод для выборки данных по среднему баллу:

    average_rating

##Дополнительно:

Реализован экспериментальный приватный метод автоматической генерации характеристик для студентов:

    generate_random_characteristic
