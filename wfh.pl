#pred worker(X) :: '@(X) is a worker'.
worker(jason). % jason is a worker.

% jane and john are workers, and john's presence is required.
worker(jane).
worker(john).
presence_required(john).

#pred presence_required(X) :: '@(X)\'s presence is required at work'.

#pred wfh_mandatory(X) :: '@(X) must work from home'.

% working from home is mandatory unless the employer requires a physical presence for operational effectivness.
wfh_mandatory(X) :-
    worker(X),
    not presence_required(X).

?- not wfh_mandatory(john).