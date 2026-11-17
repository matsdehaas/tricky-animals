% Predicaat 'omgedraaid' uit de palindroom opgave.
% Omgedraaid/2 roept omgedraaid/3 aan met een lege accumulator.
omgedraaid(L, R) :-
    omgedraaid(L, [], R).

% Basecase: als de eerste lijst leeg is, zijn de tweede en derde lijst hetzelfde. 
% De accumulator is dan gelijk aan de omgekeerde lijst.
omgedraaid([], R, R).

% Recursief: het hoofd van lijst1 wordt toegevoegd aan de accumulator. 
% Hierna wordt omgedraaid weer aangeroepen met de rest van lijst 1.
omgedraaid([X|Xs], Acc, R) :-
    omgedraaid(Xs, [X|Acc], R).

% Base case: X zit in de lijst als het gelijk is aan het hoofdelement van de lijst.
zitIn(X, [X|_]).
% Recursief: X zit in de lijst als het zit in de tail van de lijst.
zitIn(X, [_|T]) :-
    zitIn(X, T).

% Predicaat 'plak' uit de palindroom opgave.
% Basecase: Als de eerste lijst leeg is, is het resultaat van het plakken dezelfde lijst als de tweede.
plak([], X, X).

% Recursief: Het hoofd van de eerste lijst wordt toegevoegd aan de derde lijst, 
% en de rest van de lijsten worden samengevoegd.
plak([X|Rest1], L2, Result) :-
    plak(Rest1, L2, Temp),
    Result = [X|Temp].

% BFS-implementatie
% 'bfs' voert een breadth-first search uit vanaf het startknooppunt tot het doelknooppunt en geeft het pad terug.
bfs(Start, Goal, Path) :-
    bfs([[Start]], Goal, [], PathRev),
    omgedraaid(PathRev, Path).

% Base case: Als het huidige punt het doel is, is het pad gevonden.
bfs([[Node|Path]|_], Node, _, Path).

% Recursief: Zoek naar het doel door punten te verkennen vanaf de start en de paden bij te houden.
bfs([[Node|Path]|Paths], Goal, Visited, ResultPath) :-
    findall([Next, Edge|Path], 
            (action(Edge, Node, Next), 
            \+ zitIn(Next, Visited), 
            \+ zitIn(Next, Path)), 
            NewPaths),
    plak(Paths, NewPaths, UpdatedPaths),
    bfs(UpdatedPaths, Goal, [Node|Visited], ResultPath).

% actions

% Actie a verwisselt simpelweg de eerste twee elementen uit de lijst.
action(a, animals([X,Y|T]), animals([Y,X|T])).

% Actie b verwisselt de laatste twee elementen door op de omgedraaide lijst 
%actie a uit te voeren en hem daarna weer terug te draaien.
action(b, animals(List), animals(NewList)) :-
    omgedraaid(List, Reversed), % Keer de lijst om
    action(a, animals(Reversed), animals(NewReversed)), % Voer actie "a" uit op de omgekeerde lijst
    omgedraaid(NewReversed, NewList). % Keer de lijst weer terug naar de oorspronkelijke volgorde

% Ik wilde eerst deze definitie gebruiken en was hier erg trots op, 
%maar hij geeft het antwoord meerdere keren en ik mag geen "!" gebruiken 
%om dit te voorkomen.
%action(x, animals([Begin|List]), animals(NewList)) :-
%	omgedraaid(List,[Einde,Verplaats|RevMidden]),
%	invoeging(Einde,RevMidden, RevMidden2),
%	omgedraaid(RevMidden2, Midden),
%	invoeging(Verplaats, Midden, NieuwMidden),
%	invoeging(Begin,NieuwMidden,NewList).

%Dus heb ik de relatie voor elke mogelijke lengte op deze manier gedefinieerd
action(x, animals([A,B,C,D,E,F,G,H,I]),animals([A,H,B,C,D,E,F,G,I])).
action(x, animals([A,B,C,D,E,F,G,H]),animals([A,G,B,C,D,E,F,H])).
action(x, animals([A,B,C,D,E,F,G]),animals([A,F,B,C,D,E,G])).
action(x, animals([A,B,C,D,E,F]),animals([A,E,B,C,D,F])).
action(x, animals([A,B,C,D,E]),animals([A,D,B,C,E])).
action(x, animals([A,B,C,D]),animals([A,C,B,D])).
    
    
    
    
    
    
    
    
    
    
    
    