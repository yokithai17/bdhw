# Домашние задание по базам данных 2024
## [ориентеровка по решению](https://github.com/yokithai17/bdhw/blob/main/src/README.md)
## Условие
Проект (3-10 баллов)
  Для успешной сдачи проекта необходимо последовательно сдать стадии обязательной части проекта через GitHub своему семинаристу и выступить на защите обязательной части; после этого студент получает 3 балла к оценке и возможность получить положительную оценку за курс. Желающим получить более высокую оценку необходимо в любом порядке выполнить дополнительные пункты (баллы за каждый указаны) и выступить на финальной сдаче в конце семестра. В случае несдачи обязательной части проекта за курс ставится оценка “неудовлетворительно(2)”. В случае, если студент не успевает выполнить обязательную часть к дате ее защиты, он лишается права на выполнение дополнительной части, и защищает обязательную часть на финальной защите.
  ### Обязательная часть проекта (3 балла после сдачи всех)
  1. Защита темы. Тема может быть абсолютно любой, но при этом все данные и функционал над ними должен быть логичен и оправдан в рамках этой темы. Также темы не должны повторяться в рамках одной группы (или 2х групп, которые занимаются вместе). 
  2. Создание концептуальной модели. Концептуальная модель схемы представляет из себя диаграмму, состоящую из значащих таблиц и связей между ними. Нормализация на данном этапе не требуется. Необходимое условие - 5-6 значащих таблиц.
  3. Создание логической модели. Подразумевает перевод схемы в одну из нормальных форм (2 или 3, с оправданием выбора), наличие минимум одной таблицы с версионными данными (с оправданием типа версионирования).
  4. Создание физической модели. Подразумевает определение всей атрибутов всех таблиц схемы с указанием типа данных и всех ограничений.
  5. Реализация схемы посредством DDL-скриптов. 
  6. Заполнение схемы данными, с помощью DML-скриптов или прочтения CSV. Требования - не менее 15 строк в каждую значащую таблицу. Не менее 30 строк в каждую таблицу-связку (таблицу, созданную при нормализации схемы, и содержащую ссылки на несколько других, обычно значимых, таблиц). Не менее 30 строк в каждую таблицу, хранящую версионные данные.
  7. Написание 10 осмысленных (содержащих WHERE, GROUP BY, HAVING, ORDER BY, JOIN, подзапросы) запросов к схеме, со смысловым описанием желаемого вывода
  ### Дополнительная часть проекта:
  8. Создание представлений для тех таблиц, где это осмысленно (1 балл)
  9. Создание индексов для тех таблиц, где это осмысленно (1 балл)
  10. Создание 3 осмысленных хранимых процедур или функций (2 балла)
  11. Создание 3 осмысленных триггеров (2 балла)
  12. Создание тестов (при помощи pytest) для запросов из пункта 7 (2 балла)
  13. Используя любимый язык программирования и библиотеку, сгенерировать данные и с их помощью вставить данные в уже оформленную БД. Теми же инструментами извлечь данные (из таблицы на выбор), возможно, предварительно агрегированные средствами СУБД, и провести анализ (графики/heatmap - на ваше усмотрение). (3 балла)
