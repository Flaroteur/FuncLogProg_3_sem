/* Предикаты для проверки условий прогнозов */
condition1(Peshkin, _, _, _) :- Peshkin \= 1.
condition1(_, _, _, _).

condition2(_, _, Peshkin, Slonov) :- Peshkin > Slonov.
condition2(_, _, _, _).

condition3(_, Ladeynikov, _, _) :- Ladeynikov \= 1.
condition3(_, _, Korolev, _) :- Korolev \= 2.
condition3(_, _, _, _).

condition4(_, _, Korolev, Slonov) :- Korolev = 1, Slonov = 2.
condition4(_, _, _, _).
condition4(_, _, _, Slonov) :- Slonov \= 2.

/* Порядок занятия мест участниками */
places(Peshkin, Ladeynikov, Korolev, Slonov) :-
    permutation([1, 2, 3, 4], [Ladeynikov, Peshkin, Slonov, Korolev]),
    condition1(Peshkin, Ladeynikov, Korolev, Slonov),
    condition2(Peshkin, Ladeynikov, Korolev, Slonov),
    condition3(Peshkin, Ladeynikov, Korolev, Slonov),
    condition4(Peshkin, Ladeynikov, Korolev, Slonov).