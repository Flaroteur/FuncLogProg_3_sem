:- ['two.pl'].

/*Напечатать средний балл для каждого предмета*/
get_average_mark([],0).
get_average_mark([M|Marks],Sum):-
	get_average_mark(Marks,S),
	Sum is M + S.
average_mark(Subject,X):-
	findall(Mark,grade(_,_,Subject,Mark),Marks),
	get_average_mark(Marks,M),
	length(Marks,Len),
	X is M / Len.
    
/*Для каждой группы, найти количество не сдавших студентов*/
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

/*Найти количество не сдавших студентов для каждого из предметов*/
dont_pass_subj(Subject,X):-
	findall(Student,grade(_,Student,Subject,2),Students),
	length(Students,X).
