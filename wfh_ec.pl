% Implementation of Work From Home rules using basic event calculus
% "working from home is mandatory unless the employer requires a physical presence for operational effectivness."

#include 'bec'.

% Whether a person is required to work from home is a fluent.
#pred holdsAt(wfh_required,T) :: 'you are required to work from home at time @(T)'.
#pred -holdsAt(wfh_required,T) :: 'you are not required to work from home at time @(T)'.
#pred fluent_changed(wfh_required,T) :: 'your work from home requirement changed at time @(T)'.

% The events are wfh_order and presence_required
#pred initiates(wfh_order,wfh_required,T) :: 'a work from home order makes working from home mandatory'.
initiates(wfh_order,wfh_required,T).

#pred terminates(presence_required,wfh_required,T) :: 'being advised that your presence is required terminates the requirement to work from home'.
terminates(presence_required,wfh_required,T).


#pred initiallyN(wfh_required) :: 'you were not required to work from home'.
initiallyN(wfh_required).

#pred happens(wfh_order,T) :: 'a work from home order was issued at time @(T)'.
happens(wfh_order, 1).

#pred happens(presence_required,T) :: 'you were advised your presence was required at work at time @(T)'.
happens(presence_required, 3).

?- fluent_changed(wfh_required,T).

