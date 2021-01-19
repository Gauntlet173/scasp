
%% BASIC EVENT CALCULUS (BEC) THEORY

#pred terminates(E,F,T) :: 'the event @(E) caused the status @(F) to terminate at time @(T)'.
#pred initiates(E,F,T) :: 'the event @(E) caused the status @(F) to begin at time @(T)'.
#pred happens(E,T) :: 'the event @(E) happened at time @(T)'.
#pred holdsAt(F,T) :: '@(F) was true at time @(T)'.
#pred -holdsAt(F,T) :: '@(F) was not true at time @(T)'.
#pred initiallyN(F) :: '@(F) is not initially true'.
#pred initiallyP(F) :: '@(F) is true initially'.
#pred releases(E,F,T) :: 'the event @(E) caused the status @(F) to become variable at time @(T)'.

%% BEC1 - StoppedIn(t1,f,t2)
#pred stoppedIn(X,Y,Z) :: '@(Y) was terminated between time @(X) and time @(Z)'.
stoppedIn(T1, Fluent, T2) :-
    T1 .<. T, T .<. T2,
    terminates(Event, Fluent, T),
    happens(Event, T).

stoppedIn(T1, Fluent, T2) :-
    T1 .<. T, T .<. T2,
    releases(Event, Fluent, T),
    happens(Event, T).

%% BEC2 - StartedIn(t1,f,t2)
#pred startedIn(X,Y,Z) :: '@(Y) was initiated between time @(X) and time @(Z)'.
startedIn(T1, Fluent, T2) :-
    T1 .<. T, T .<. Tscasp2,
    initiates(Event, Fluent, T),
    happens(Event, T).

startedIn(T1, Fluent, T2) :-
    T1 .<. T, T .<. T2,
    releases(Event, Fluent, T),
    happens(Event, T).

%% BEC3 - HoldsAt(f,t)
holdsAt(Fluent2, T2) :-
    initiates(Event, Fluent1, T1),
    happens(Event, T1),
    trajectory(Fluent1, T1, Fluent2, T2),
    not stoppedIn(T1, Fluent1, T2).
%% BEC4 - HoldsAt(f,t)
holdsAt(Fluent, T) :-
    0 .<. T,
    initiallyP(Fluent),
    not stoppedIn(0, Fluent, T).

%% BEC5 - not HoldsAt(f,t)
-holdsAt(Fluent, T) :-
    0 .<. T,
    initiallyN(Fluent),
    not startedIn(0, Fluent, T).

%% BEC6 - HoldsAt(f,t)
holdsAt(Fluent, T) :-
    T1 .<. T,
    initiates(Event, Fluent, T1),
    happens(Event, T1),
    not stoppedIn(T1, Fluent, T).

%% BEC7 - not HoldsAt(f,t)
-holdsAt(Fluent, T) :-
    T1 .<. T,
    terminates(Event, Fluent, T1),
    happens(Event, T1),
    not startedIn(T1, Fluent, T).

%% Search for changes in the value of a Fluent.
%% We are assuming that holdsAt and -holdsAt will return models.
fluent_changed(F,T) :- holdsAt(F,T).
fluent_changed(F,T) :- -holdsAt(F,T).