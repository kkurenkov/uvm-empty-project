## Introduction

Верификационный репозиторий с тестами для proj_name

# proj_name verification plan 

Verification plan for proj_name

## Introduction

Данный документ описывает функциональные возможности модуля proj_name, их приоритет и сценари проверки. Возможности разделены на логические группы.

* Приоритет :red_circle: <b>HIGH</b> - жизненно важный функционал, запуск без него невозможен.  

* Приоритет :large_blue_circle: <b>MEDIUM</b> - важный функционал, но не самый часто используемый функционал.

* Приоритет :white_circle: <b>LOW</b> - дополнительный функционал. Проверка производится в последнюю очередь.   

----

## Структура проекта

```
├── submodules               - git-сабмодули;
├── syn                      - скрипты синтеза;
└── verification             - поддиректория верификации;
    ├── <module>   - для каждого модуля структура идентична;
    ├──  ...
    └── proj_name            - поддиректория для тестирования proj_name;
        ├── docs             - документация;
        ├── jg               - формальная верификация;
        ├── uvm              - uvm окружение;
        ├── logs             - логи моделирования;
        ├── run              - рабочая директория запуска тестов;
        └── tests            - библиотека тестов;
```
----

## Критерии завершения верификации

* План верификации разработан и утвержден.
* Кодовое покрытие не ниже 85%.
* Функциональное покрытие критических характеристик согласно утвержденной версии плана верификации ~ 100%.
* Bugrate за последние 2 недели регрессионных запусков ~ 0.
* Кодовое покрытие должно быть собрано для метрик: line, condition, togle, branch, fsm.
* Кодовое покрытие должно быть проанализировано при активном участии разработчика.

----

## Используемые инструменты и методологии

* UVM, версия 1.2.
* Cadence Xcelium 19.09-s007
* Cadence IMC: 19.09-s004
* Gitlab CI/CD для организации регрессионных запусков
* <b>!!! Перечсислить используемые VIP !!!</b>

----

## Список проверяемых характеристик

|               Feature                                          |            Приоритет                        |
|----------------------------------------------------------------|---------------------------------------------|
|<b>!!! Вставить список проверяемых характеристик !!! </b>       |:red_circle: <b>HIGH</b>                     |
|<b> Пример: Проверка адресного пространства </b>                |:red_circle: <b>HIGH</b>                     |
|...............................                                 |:large_blue_circle: <b>MEDIUM</b>            |
|...............................                                 |:large_blue_circle: <b>MEDIUM</b>            |
|...............................                                 |:large_blue_circle: <b>MEDIUM</b>            |
|...............................                                 |:white_circle: <b>LOW</b>                    |

----

### Проверка адресного пространства

В качестве примера расписан один пункт. Остальные пункты необходимо заполнить по аналогии.
Проверяется доступ на чтение/запись по всем адресам. Проверка производится относительно регистровой модели, созданной на основе спецификации.

----

## Описание тестовых сценариев

----

## Структурная схема

----

### Запуск тестов
Запуск тестов осуществляется из директории `verification/<module>/run`.   

* Примеры команд для запуска тестов

```bash
    make sim TEST=<testname> [SEED=<value>] [UVM_VERB=UVM_LOW] [...]
    make check_addrspace_test_gui SEED=60 (запуск теста с определенным SEED-ом) UVM_VERB=UVM_LOW
```

