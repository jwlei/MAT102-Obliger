%Gruppe medlemmer:
%Joachim Leiros
%Olve Eid
%Andreas Nordang Seljeset
%Sindre Holtan

% Input: 
%       X - normalisert nxm matrise med data (Xnormaliser)
%       a - antall prinsipalkomponenter vi vil finne
                      
load('Arbeidskrav3.mat');

n = objNames1;
m = varNames1;

[n,m] = size(X1);     
                      
a = 2;                % Antall prinsipialkomponenter

meanX = mean(X1);    % Gjennomsnitter av kvar kolonne i matrisa X
stdX = std(X1);      % Standardavviket i kvar kolonne i matrisa X

for j = 1:m
    X1(:,j) = X1(:,j) - meanX(j); % Trekker gjennomsnitt frå kolonne j (:,j) -> kolon indikerer heile rekka
    if stdX(j) ~=0
        X1(:,j) = X1(:,j)/stdX(j); % Dividerer kvar kolonne med standardavviket
    end
end
Xnorm = X1;

% Oppgave 1
% Den preprosseserte matrisen:
% [-0.937164538786310,-0.937164439127988,1.87081881494888,1.68666246639376,-0.705426973753989,-1.38786918958897,-1.08385279233129,0.957465295541553,1.71354430745719,0.513241393628092]
% [-0.937164538786310,0.930144312513801,0.00351006330709350,0.662099918938220,-1.07964292681692,-0.922835237719479,-0.955941881706119,1.20240844368983,0.851609652629356,1.10544265798126]
% [-0.937164538786310,1.87081881494888,-0.937164439127988,0.115987934802961,-1.17621339355917,-0.442800249664964,-0.525695085046364,0.971461934890301,0.575071881550183,1.44431329881994]
% [0.00351023002969064,-0.937164439127988,0.930144312513801,0.468785357179581,0.507755618786664,-0.419226987073464,-0.265997037465347,-0.330235616200949,-0.107293099611423,-0.309260625984133]
% [0.00351023002969064,0.00351006330709350,0.00351006330709350,-0.173982023025557,-0.0777089507906106,0.270823197621817,0.102232091455220,-0.263751383339879,-0.272496956031425,-0.144760461574234]
% [0.00351023002969064,0.00351006330709350,0.00351006330709350,-0.173982023025557,-0.0777089507906106,0.167958910921688,-0.215607940187544,0.0546747582415044,-0.452066730256716,-0.148050534873792]
% [0.930144212106133,0.00351006330709350,-0.937164439127988,-1.09222324334381,0.930257378615392,1.29089776850383,1.17978621949412,-1.01957598276234,-0.990776052932588,-0.868561986423617]
% [1.87081871416372,-0.937164439127988,-0.937164439127988,-1.49334838791960,1.67868819830925,1.44305178699954,1.76507642578732,-1.57244745006002,-1.31759300280458,-1.59236374157352]

% Oppgave 2:
% Standarisering er viktig for å kunne sammenlikne forskjellig data fra forskjellige kilder. 
% For å kunne sammenlikne disse må vi standardisere de og sette de inn på samme "skala" 
% slik at vi kan måle disse opp mot hverandre.


% Initialiserer scores/loadingmatrisa som 0-matriser (T = scores, P =
% Loading)
T = zeros(n,a);
P = zeros(m,a);

% Bruker NIPALS-metoden for å finne dei a største eigenvektorane til X'X
% (prinsipalskomponentane).

for i = 1:a
   % t_old = random('Normal',0,1,n,1); % Randomvektor. (Fordi man må ha en til å begynne med)
    t_old = rand(n,1);                                
    p = Xnorm'*t_old;
    p = p/norm(p); % Normaliserer p til lengde 1.
    t = Xnorm*p;
    while (norm(t-t_old)>0.00001)
        p = Xnorm'*t;
        p = p/norm(p);
        t_old = t;
        t = Xnorm*p;
    end
    T(:,i) = t; % Scores
    P(:,i) = p; % Loading
    Xnorm = Xnorm - t*p';
end

% Oppgave 3
% Teikner representasjon av dei første to prinsipalkoeffisientane
figure
scatter(T(:,1), T(:,2))
text(T(:,1)+.01, T(:,2),objNames1)

% Oppgave 4:
% Forsøkene 5a og 5b er svært nære da de nesten overlapper hverandre.


% Oppgave 5:
totalVariasjon = trace(X1'*X1);
forklartVariasjon = trace(T'*T);
andelForklart = forklartVariasjon/totalVariasjon;
%Variansen blir 98.36, eller 98%.

% Oppgave 6:
figure
scatter(P(:,1), P(:,2))
text(P(:,1)+.01, P(:,2),varNames1)

% Få figuren kan vi se at Melk og sukker som blir lagt til i kaffen, 
% jo søtere smak og mer "smooth texture" får kaffen.
% Noe som tilsier at instilling 1, 2 og 3 gir ett søtere produkt.

return;