%% Constants
epsilon = [2.69 5 6 7 8 9]
tandelta = [0.012 0.01 0.02 0.03 0.04 0.05]
h = [3 0.1 0.1 0.1 0.1 0.1]

%% Calculation of DL(dB)
dl_temp = sum(sqrt(epsilon).*tandelta)

DL = 8.686*pi*77*10^9/(3*10^8*10^3)*sum(sqrt(epsilon).*tandelta)


%% Calculation of tandelta and epsilon
epsilon_eff = sum(epsilon.*h) / sum(h)
tandelta_eff = (1 / epsilon_eff) * sum((epsilon .* tandelta) .* h) / sum(h)

%% Calculation of ML
theta = linspace(-pi*87/180, pi*87/180, 175);

epsilon_air = 1;
tandelta_air = 0;

y_num = sqrt(epsilon_air) * (1 - 1j * tandelta_air/2) * sin(theta).^ 2;
y_den = sqrt(epsilon_eff) * (1 - 1j * tandelta_eff/2);
y = sqrt(1 - (y_num/y_den));

taup_num = sqrt(epsilon_air) * (1 - 1j * tandelta_air/2) * y - sqrt(epsilon_eff) * (1 - 1j * tandelta_eff/2) * cos(theta);
taup_den = sqrt(epsilon_air) * (1 - 1j * tandelta_air/2) * y + sqrt(epsilon_eff) * (1 - 1j * tandelta_eff/2) * cos(theta);
taup = taup_num ./ taup_den;
abs(taup)

ML = -10*log10(1 - abs(taup).^2)

%%Calculation of Effect of Bumper Shape (Got from excel sheet)
BumperShapeLoss = [1.574037047	1.414117997	1.272725606	1.246443642	1.365154295	1.599465825	1.872492254	2.096924354	2.237886964	2.345053455	2.519988382	2.853848623	3.386197979	4.093769444	4.899962043	5.703875179	6.418336234	6.991618783	7.401676824	7.635936047	7.674637262	7.49645466	7.085110346	6.474606115	5.759316142	5.051352328	4.433557636	3.937151194	3.551287181	3.249429082	3.030154513	2.931257574	2.990563961	3.195987045	3.471382155	3.709256339	3.844867936	3.898026346	3.907946535	3.890751239	3.889248308	3.936455445	4.002756181	4.032167897	4.006732815	3.971216601	3.939499301	3.859608962	3.749140522	3.686374369	3.709517821	3.826400806	3.980346259	4.036770761	3.901225501	3.653393389	3.449296184	3.333609975	3.298853312	3.346500465	3.485534147	3.737863618	4.063686365	4.325254229	4.462156287	4.56825679	4.655543217	4.715599847	4.773812988	4.659739059	4.237793792	3.639683474	3.031162615	2.543512618	2.226028933	1.968100759	1.654409735	1.315480488	1.063513433	0.944209716	0.9043562223	0.8951946601	0.9520184417	1.115867195	1.36142161	1.620406326	1.827033	2.015379258	2.212683374	2.359933135	2.427533135	2.423497344	2.370034112	2.330611684	2.289689585	2.246777045	2.296672142	2.418857416	2.511449685	2.554537479	2.627366505	2.830610732	3.15448548	3.496018857	3.80131117	4.049076157	4.201946412	4.333123623	4.457296629	4.439557019	4.293980557	4.159728058	4.091049552	4.063184307	4.006424468	3.890791843	3.770805994	3.714032681	3.741880696	3.873513554	4.078619118	4.225705621	4.224903475	4.087042233	3.868974816	3.643613491	3.481018325	3.423147911	3.458194774	3.564935944	3.716466082	3.835178718	3.854765756	3.800912636	3.742977385	3.704741912	3.672419319	3.653300922	3.645834197	3.598378697	3.47204981	3.303806659	3.186497005	3.194588486	3.327434983	3.536161001	3.799719319	4.148188878	4.622707216	5.233477517	5.943007918	6.667346064	7.298596927	7.735671138	7.921408086	7.86672423	7.61178334	7.173368676	6.558630232	5.803157565	4.992697355	4.242785508	3.641017705	3.216510278	2.944551664	2.753821071	2.558592291	2.30996515	2.022615175	1.755342261	1.562929517	1.464469289	1.431166719	1.397399187	1.301328704
    ]
%{
Plotting Dielectric Loss 
x = [-87 : 1 : 87]
y = 2*DL 
plot(x, y, 'blue -o', 'LineWidth', 1); 
ylabel('Dielectric Loss (dB)');
xlabel('Azimuth Angle (degree)');
%}

%{
Plotting Mismatch Loss
x = [-87 : 1 : 87]
y = 2*ML 
plot(x, y, 'green -o', 'LineWidth', 1); 
ylabel('Mismatch Loss (dB)');
xlabel('Azimuth Angle (degree)');
%}

%{
Plotting Bumper Shape Loss
x = [-87 : 1 : 87]
y = BumperShapeLoss
plot(x, y, 'magenta -o', 'LineWidth', 1); 
ylabel('Bumper Shape Loss (dB)');
xlabel('Azimuth Angle (degree)');
%}


x = [-87 : 1 : 87]
y = 2*(DL+ML) 
plot(x, y, 'red -o', 'LineWidth', 1); 
ylabel('Bi-directional Loss (dB)');
xlabel('Azimuth Angle (degree)');
hold on
z = 2*(DL+ML) + BumperShapeLoss
plot(x, z, 'black -o', 'LineWidth', 1);
legend('2*(DL+ML)','2*(DL+ML) + effect of bumper shape');