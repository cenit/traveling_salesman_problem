% to use global constraints
include "globals.mzn";




%%% WITHOUT ENUMS
%% Number of cities
%int: N=4;
%% String constants, for output purposes
%array[int] of string: city_names = [
%"Tokyo", "Moscow", "Berlin", "Nairobi"
%];

%% WITH ENUMS
enum Cities = {Tokyo, Moscow, Berlin, Nairobi};
int: N = card(Cities);



% Maximum allowed distance
int: M=50000;

% Distance Matrix
array[1..N,1..N] of int: D = [|
%Tokyo, Moscow, Berlin, Nairobi
     0,   7481,   8918,   11255 | %Tokyo
  7481,      0,   1609,    6344 | %Berlin
  8918,   1609,      0,    6372 | %Moscow
 11255,   6344,   6372,       0 | %Nairobi
|];


% variables and constraints
array[1..N] of var 1..N: Visited;
var 0..M: tourLength = sum(i in 2..N)(D[Visited[i-1],Visited[i]]) + D[Visited[N],Visited[1]];

constraint all_different(Visited);

% solve item
solve satisfy;               % find one solution (it's enough that tourLength is < M to win the solution)
%solve minimize tourLength;   % find the best solution

%%% WITHOUT ENUMS
% output specification
%output  [city_names[fix(Visited[i])] ++ " => " | i in 1..N]
%     ++ [city_names[fix(Visited[1])]] ++ ["\nTotal length: " ++ show(tourLength)]


%% WITH ENUMS
output  [format(Cities[Visited[i]]) ++ " => " | i in 1..N]
     ++ [format(Cities[Visited[1]])] ++ ["\nTotal length: " ++ show(tourLength)]
     
