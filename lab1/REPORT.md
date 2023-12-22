# Отчет по лабораторной работе №1
## Работа со списками и реляционным представлением данных
## по курсу "Логическое программирование"

### студент: Вертоградский Д. А.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*


## Введение

В Прологе списки состоят из головы (первого элемента) и хвоста (оставшейся части списка), а не хранят элементы последовательно в памяти, как в императивных языках.

Списки в Прологе могут быть переменными и использоваться для поиска и сравнения с другими списками. В императивных языках списки обычно являются константами.

Списки в Прологе похожи на связные списки или динамические массивы в традиционных языках, но имеют больше возможностей для работы с данными, таких как рекурсия и сопоставление с образцом.

## Задание 1.1: Предикат обработки списка

`remove_n_last(N, List, Result)` - удаляет последние `N` элементов из списка `List`.

Примеры использования:
```prolog
?- remove_n_last(2, [a, b, c, d, e], R).
R=[a, b, c].
?- remove_n_last(0, [a, b, c, d, e], R).
X=[a, b, c, d, e].
```

Реализация:
```prolog
remove_n_last(N, L, R):-
    remove_n_last(N, _, L, R).
remove_n_last(_, 0, [], []).
remove_n_last(N, M, [_|T], []):-
    remove_n_last(N, NN, T, _),
    M is NN + 1, M =< N.
remove_n_last(N, M, [H|T], [H|R]):-
    remove_n_last(N, NN, T, R),
    M is NN + 1, M > N.
    
remove_n_last_s(N, L, R):-
    append(R, A, L),
    length(A, N).

remove_n_last_m(N, L, R):-
    length(L, M),
    NN is M - N,
    cut(NN, L, R).

cut(0, _, []):-!.
cut(N, [H|T], [H|R]):-
    NN is N - 1,
    cut(NN, T, R).

cut_s(N, L, R):-
    append(R, _, L),
    length(R, N).
```

Если N равно 0 и список пустой, то результатом будет пустой список.
Если N равно 0 и список не пустой, то результатом будет исходный список без изменений.
Если N больше 0, то предикат рекурсивно вызывает сам себя для хвоста списка, уменьшая N на 1 и сохраняя результат во временную переменную NN.
Если M (количество элементов в хвосте списка) равно NN + 1 и M меньше или равно N, то голова списка не добавляется в результат, а хвост обрабатывается рекурсивно.
Если M больше N, то голова списка добавляется в результат, а хвост обрабатывается рекурсивно.

Таким образом, предикат remove_n_last последовательно перебирает элементы списка, уменьшая N на 1, пока N не станет равным 0, и формирует новый список без последних N элементов.

## Задание 1.2: Предикат обработки числового списка

`max_pos(List, Posotion)` - находит индекс максимального элемента из списка `List`.

Примеры использования:
```prolog
?- max_pos([5, 2, 8, 3, 6], P).
P = 2.
?- max_pos([1, 1, 1, 1], P).
P = 0.
?- max_pos([], P).
false.
```

Реализация:
```prolog
max_pos(L,P):-
    max_pos(L, 0, _, P).
max_pos([X], N, X, N).
max_pos([H|T], N, MM, P):-
    NN is N + 1,
    max_pos(T, NN, MM, P),
    H < MM, !.
max_pos([H|T], N, H, N):-
    NN is N + 1,
    max_pos(T, NN, _, _).
```

Предикат рекурсивно проходит по списку, обновляя текущий максимальный элемент и его позицию. Если голова списка больше текущего максимального элемента, то голова становится новым максимальным элементом, а текущая позиция — позицией этого элемента. Предикат возвращает позицию максимального элемента.

## Задание 2: Реляционное представление данных

Вариант реляционного представления данных, описанный в файле "two.pl", имеет свои преимущества и недостатки. 

Преимущества:
1. Простота хранения информации в виде фактов, что упрощает работу с данными.
2. Легкая обработка данных с помощью пролога, так как он может обрабатывать их как списки.

Недостатки:
1. Некоторые представления данных могут быть неудобны для обработки, что может затруднить выполнение определенных задач.

В данном представлении факты записываются в виде "grade(Group, Subject, Student, Mark)". С помощью встроенного предиката findall/3 можно легко найти, например, список студентов для определенной группы. Однако, иногда может потребоваться удаление повторяющихся элементов из списка.

Вариант 2, описанный в файле "two.pl", включает следующие задачи:
- Напечатать средний балл для каждого предмета.
- Для каждой группы, найти количество студентов, не сдавших предмет.
- Найти количество студентов, не сдавших каждый из предметов.

Задание 1:

`average_mark(Subject,X).` - выводит средний бал студентов сдававших данный предмет.
```prolog
| ?- average_mark('Informatika',X).
X = 3.9285714285714284
yes
| ?- average_mark('Logicheskoe programmirovanie',X).
X = 3.9642857142857144
yes
```
Реализация:
```prolog
get_average_mark([],0).
get_average_mark([M|Marks],Sum):-
	get_average_mark(Marks,S),
	Sum is M + S.
average_mark(Subject,X):-
	findall(Mark,grade(_,_,Subject,Mark),Marks),
	get_average_mark(Marks,M),
	length(Marks,Len),
	X is M / Len.
```
Сначала находим все оценки по данному предмету , потом считаем их сумму оценок из списка оценок , затем делим результат на длину списка оценок.

Задание 2:

`dont_pass(Group,X)` - выводит количество не сдавших студентов , для данной группы.
```prolog
| ?- dont_pass(104,X).
X = 2
yes
| ?- dont_pass(101,X).
X = 2
yes
```
Реализация:
```prolog
no_repeats([], []):-!.
no_repeats([X|Xs], Ys):-
	member(X, Xs),!,
	no_repeats(Xs, Ys).
no_repeats([X|Xs], [X|Ys]):-
	no_repeats(Xs, Ys).
	
dont_pass(Group,X):-
	findall(Student,grade(Group,Student,_,2),Students),
	no_repeats(Students,Studs),
	length(Studs,X).
```
Сначала находим всех студентов данной группы , которые не сдали тот или иной предмет , затем удаляем повторения в получившемся списке , затем считаем длину списка , что будет ответом

Задание 3:

`max_mark(Group,X).` -  выводит количество не сдавших студентов , для данного предмета.
```prolog
| ?- dont_pass_subj('Informatika',X).
X = 2
yes
| ?- dont_pass_subj('Logicheskoe programmirovanie',X).
X = 2
yes
```
Реализация:
```prolog
dont_pass_subj(Subject,X):-
	findall(Student,grade(_,Student,Subject,2),Students),
	length(Students,X).
```
Сначала находим всех студентов с двойкой по данному предмету , затем вычисляем длину получившегося списка .

## Выводы

Лабораторная работа по программированию на языке Пролог позволяет погрузиться в мир логического программирования и использования реляционных баз данных. Использование предикатов для обработки списков и числовых данных позволяет решать задачи анализа и обработки информации. Выбор представления данных о студентах добавляет вариативности и позволяет экспериментировать с разными способами представления информации. Освоение стандартных предикатов обработки списков в Прологе важно для понимания возможностей языка. Реализация собственных версий стандартных предикатов помогает понять их внутреннюю механику. Реализация специального предиката обработки списка с использованием и без использования стандартных предикатов помогает развивать навыки использования встроенных функций и написания собственных функций. Совместное использование предикатов в примере работы с данными о студентах и их оценках подчеркивает гибкость и мощь языка Пролог. Лабораторная работа также развивает навыки анализа, абстракции и логического мышления студентов, что важно для успешной карьеры в программировании и информационных технологиях.