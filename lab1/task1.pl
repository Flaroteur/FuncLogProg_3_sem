/* Реализация стандартных предикатов обработки списков */

/* Длина */
_length([], 0).
_length([_ | T], N) :-
    _length(T, N1),
    N is N1 + 1.

/* Проверка на включение */
_member([X | _], X) :- !.
_member([_ | T], X) :-
    _member(T, X).

/* Слияние */
_append([], List1, List1).
_append([X | List1], List2, [X | Result]) :-
    _append(List1, List2, Result).

/* Удаление */
_delete([X | WithoutX], X, WithoutX).
_delete([Other | WithX], X, [Other | WithoutX]) :-
    _delete(WithX, X, WithoutX).

/* Перестановка */
_permutation([], []).
_permutation(List, [X | Permutation]) :-
    _delete(List, X, Other),
    _permutation(Other, Permutation).

/* Подсписок */
_sublist([], _) :- !.
_sublist(Sublist, List) :-
    _append(Sublist, _, Temp),
    _append(_, Temp, List), !.

/* Удалить последние n элементов */
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

/* Вычисление позиции максимального элемента в списке */
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

