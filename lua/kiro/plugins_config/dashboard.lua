-- load from file
local header = {
    '[38;2;241;121;21m█[39m[38;2;243;117;23m█[39m[38;2;244;112;26m╗[39m[38;2;246;108;28m [39m[38;2;247;104;31m [39m[38;2;249;100;34m█[39m[38;2;250;96;37m█[39m[38;2;251;92;40m╗[39m[38;2;252;88;43m█[39m[38;2;253;84;46m█[39m[38;2;253;80;50m╗[39m[38;2;254;76;53m█[39m[38;2;254;72;56m█[39m[38;2;254;68;60m█[39m[38;2;254;64;64m█[39m[38;2;254;61;67m█[39m[38;2;254;57;71m█[39m[38;2;254;54;75m╗[39m[38;2;253;50;79m [39m[38;2;253;47;83m [39m[38;2;252;44;87m█[39m[38;2;251;41;91m█[39m[38;2;250;38;95m█[39m[38;2;249;35;99m█[39m[38;2;248;32;103m█[39m[38;2;246;29;107m█[39m[38;2;245;26;111m╗[39m[38;2;243;24;116m [39m[38;2;241;22;120m█[39m[38;2;239;19;124m█[39m[38;2;237;17;128m╗[39m[38;2;235;15;132m [39m[38;2;233;13;137m [39m[38;2;230;11;141m [39m[38;2;228;10;145m [39m[38;2;225;8;149m█[39m[38;2;222;7;153m█[39m[38;2;219;6;158m╗[39m[38;2;216;4;162m [39m[38;2;213;4;166m█[39m[38;2;210;3;170m█[39m[38;2;207;2;174m█[39m[38;2;204;1;178m█[39m[38;2;200;1;181m█[39m[38;2;197;1;185m╗[39m[38;2;193;1;189m [39m[38;2;189;1;193m█[39m[38;2;186;1;196m█[39m[38;2;182;1;200m█[39m[38;2;178;1;203m█[39m[38;2;174;2;207m█[39m[38;2;170;3;210m█[39m[38;2;166;3;213m█[39m[38;2;162;4;216m╗[39m[38;2;158;6;219m█[39m[38;2;154;7;222m█[39m[38;2;150;8;225m╗[39m[38;2;145;10;227m [39m[38;2;141;11;230m [39m[38;2;137;13;232m█[39m[38;2;133;15;235m█[39m[38;2;129;17;237m╗[39m[38;2;124;19;239m█[39m[38;2;120;21;241m█[39m[38;2;116;24;243m█[39m[38;2;112;26;245m█[39m[38;2;107;29;246m█[39m[38;2;103;32;248m█[39m[38;2;99;34;249m█[39m[38;2;95;37;250m╗[39m[38;2;91;40;251m█[39m[38;2;87;44;252m█[39m[38;2;83;47;253m█[39m[38;2;79;50;253m█[39m[38;2;75;53;254m█[39m[38;2;71;57;254m█[39m[38;2;68;61;254m╗[39m[38;2;64;64;254m [39m[38;2;60;68;254m█[39m[38;2;57;72;254m█[39m[38;2;53;75;254m█[39m[38;2;50;79;253m█[39m[38;2;46;83;253m█[39m[38;2;43;87;252m█[39m[38;2;40;91;251m█[39m[38;2;37;95;250m╗[39m[38;2;34;100;249m[39m',
    '[38;2;246;108;28m█[39m[38;2;247;104;31m█[39m[38;2;249;100;34m║[39m[38;2;250;96;37m [39m[38;2;251;92;40m█[39m[38;2;252;88;43m█[39m[38;2;253;84;46m╔[39m[38;2;253;80;50m╝[39m[38;2;254;76;53m█[39m[38;2;254;72;56m█[39m[38;2;254;68;60m║[39m[38;2;254;64;64m█[39m[38;2;254;61;67m█[39m[38;2;254;57;71m╔[39m[38;2;254;54;75m═[39m[38;2;253;50;79m═[39m[38;2;253;47;83m█[39m[38;2;252;44;87m█[39m[38;2;251;41;91m╗[39m[38;2;250;38;95m█[39m[38;2;249;35;99m█[39m[38;2;248;32;103m╔[39m[38;2;246;29;107m═[39m[38;2;245;26;111m═[39m[38;2;243;24;116m═[39m[38;2;241;22;120m█[39m[38;2;239;19;124m█[39m[38;2;237;17;128m╗[39m[38;2;235;15;132m█[39m[38;2;233;13;137m█[39m[38;2;230;11;141m║[39m[38;2;228;10;145m [39m[38;2;225;8;149m [39m[38;2;222;7;153m [39m[38;2;219;6;158m [39m[38;2;216;4;162m█[39m[38;2;213;4;166m█[39m[38;2;210;3;170m║[39m[38;2;207;2;174m█[39m[38;2;204;1;178m█[39m[38;2;200;1;181m╔[39m[38;2;197;1;185m═[39m[38;2;193;1;189m═[39m[38;2;189;1;193m█[39m[38;2;186;1;196m█[39m[38;2;182;1;200m╗[39m[38;2;178;1;203m█[39m[38;2;174;2;207m█[39m[38;2;170;3;210m╔[39m[38;2;166;3;213m═[39m[38;2;162;4;216m═[39m[38;2;158;6;219m═[39m[38;2;154;7;222m═[39m[38;2;150;8;225m╝[39m[38;2;145;10;227m█[39m[38;2;141;11;230m█[39m[38;2;137;13;232m║[39m[38;2;133;15;235m [39m[38;2;129;17;237m [39m[38;2;124;19;239m█[39m[38;2;120;21;241m█[39m[38;2;116;24;243m║[39m[38;2;112;26;245m█[39m[38;2;107;29;246m█[39m[38;2;103;32;248m╔[39m[38;2;99;34;249m═[39m[38;2;95;37;250m═[39m[38;2;91;40;251m═[39m[38;2;87;44;252m═[39m[38;2;83;47;253m╝[39m[38;2;79;50;253m█[39m[38;2;75;53;254m█[39m[38;2;71;57;254m╔[39m[38;2;68;61;254m═[39m[38;2;64;64;254m═[39m[38;2;60;68;254m█[39m[38;2;57;72;254m█[39m[38;2;53;75;254m╗[39m[38;2;50;79;253m█[39m[38;2;46;83;253m█[39m[38;2;43;87;252m╔[39m[38;2;40;91;251m═[39m[38;2;37;95;250m═[39m[38;2;34;100;249m═[39m[38;2;31;104;247m═[39m[38;2;29;108;246m╝[39m[38;2;26;112;244m[39m',
    '[38;2;250;96;37m█[39m[38;2;251;92;40m█[39m[38;2;252;88;43m█[39m[38;2;253;84;46m█[39m[38;2;253;80;50m█[39m[38;2;254;76;53m╔[39m[38;2;254;72;56m╝[39m[38;2;254;68;60m [39m[38;2;254;64;64m█[39m[38;2;254;61;67m█[39m[38;2;254;57;71m║[39m[38;2;254;54;75m█[39m[38;2;253;50;79m█[39m[38;2;253;47;83m█[39m[38;2;252;44;87m█[39m[38;2;251;41;91m█[39m[38;2;250;38;95m█[39m[38;2;249;35;99m╔[39m[38;2;248;32;103m╝[39m[38;2;246;29;107m█[39m[38;2;245;26;111m█[39m[38;2;243;24;116m║[39m[38;2;241;22;120m [39m[38;2;239;19;124m [39m[38;2;237;17;128m [39m[38;2;235;15;132m█[39m[38;2;233;13;137m█[39m[38;2;230;11;141m║[39m[38;2;228;10;145m█[39m[38;2;225;8;149m█[39m[38;2;222;7;153m║[39m[38;2;219;6;158m [39m[38;2;216;4;162m█[39m[38;2;213;4;166m╗[39m[38;2;210;3;170m [39m[38;2;207;2;174m█[39m[38;2;204;1;178m█[39m[38;2;200;1;181m║[39m[38;2;197;1;185m█[39m[38;2;193;1;189m█[39m[38;2;189;1;193m█[39m[38;2;186;1;196m█[39m[38;2;182;1;200m█[39m[38;2;178;1;203m█[39m[38;2;174;2;207m█[39m[38;2;170;3;210m║[39m[38;2;166;3;213m█[39m[38;2;162;4;216m█[39m[38;2;158;6;219m█[39m[38;2;154;7;222m█[39m[38;2;150;8;225m█[39m[38;2;145;10;227m█[39m[38;2;141;11;230m█[39m[38;2;137;13;232m╗[39m[38;2;133;15;235m█[39m[38;2;129;17;237m█[39m[38;2;124;19;239m█[39m[38;2;120;21;241m█[39m[38;2;116;24;243m█[39m[38;2;112;26;245m█[39m[38;2;107;29;246m█[39m[38;2;103;32;248m║[39m[38;2;99;34;249m█[39m[38;2;95;37;250m█[39m[38;2;91;40;251m█[39m[38;2;87;44;252m█[39m[38;2;83;47;253m█[39m[38;2;79;50;253m╗[39m[38;2;75;53;254m [39m[38;2;71;57;254m [39m[38;2;68;61;254m█[39m[38;2;64;64;254m█[39m[38;2;60;68;254m█[39m[38;2;57;72;254m█[39m[38;2;53;75;254m█[39m[38;2;50;79;253m█[39m[38;2;46;83;253m╔[39m[38;2;43;87;252m╝[39m[38;2;40;91;251m█[39m[38;2;37;95;250m█[39m[38;2;34;100;249m█[39m[38;2;31;104;247m█[39m[38;2;29;108;246m█[39m[38;2;26;112;244m╗[39m[38;2;24;116;243m [39m[38;2;21;120;241m [39m[38;2;19;125;239m[39m',
    '[38;2;253;84;46m█[39m[38;2;253;80;50m█[39m[38;2;254;76;53m╔[39m[38;2;254;72;56m═[39m[38;2;254;68;60m█[39m[38;2;254;64;64m█[39m[38;2;254;61;67m╗[39m[38;2;254;57;71m [39m[38;2;254;54;75m█[39m[38;2;253;50;79m█[39m[38;2;253;47;83m║[39m[38;2;252;44;87m█[39m[38;2;251;41;91m█[39m[38;2;250;38;95m╔[39m[38;2;249;35;99m═[39m[38;2;248;32;103m═[39m[38;2;246;29;107m█[39m[38;2;245;26;111m█[39m[38;2;243;24;116m╗[39m[38;2;241;22;120m█[39m[38;2;239;19;124m█[39m[38;2;237;17;128m║[39m[38;2;235;15;132m [39m[38;2;233;13;137m [39m[38;2;230;11;141m [39m[38;2;228;10;145m█[39m[38;2;225;8;149m█[39m[38;2;222;7;153m║[39m[38;2;219;6;158m█[39m[38;2;216;4;162m█[39m[38;2;213;4;166m║[39m[38;2;210;3;170m█[39m[38;2;207;2;174m█[39m[38;2;204;1;178m█[39m[38;2;200;1;181m╗[39m[38;2;197;1;185m█[39m[38;2;193;1;189m█[39m[38;2;189;1;193m║[39m[38;2;186;1;196m█[39m[38;2;182;1;200m█[39m[38;2;178;1;203m╔[39m[38;2;174;2;207m═[39m[38;2;170;3;210m═[39m[38;2;166;3;213m█[39m[38;2;162;4;216m█[39m[38;2;158;6;219m║[39m[38;2;154;7;222m╚[39m[38;2;150;8;225m═[39m[38;2;145;10;227m═[39m[38;2;141;11;230m═[39m[38;2;137;13;232m═[39m[38;2;133;15;235m█[39m[38;2;129;17;237m█[39m[38;2;124;19;239m║[39m[38;2;120;21;241m█[39m[38;2;116;24;243m█[39m[38;2;112;26;245m╔[39m[38;2;107;29;246m═[39m[38;2;103;32;248m═[39m[38;2;99;34;249m█[39m[38;2;95;37;250m█[39m[38;2;91;40;251m║[39m[38;2;87;44;252m█[39m[38;2;83;47;253m█[39m[38;2;79;50;253m╔[39m[38;2;75;53;254m═[39m[38;2;71;57;254m═[39m[38;2;68;61;254m╝[39m[38;2;64;64;254m [39m[38;2;60;68;254m [39m[38;2;57;72;254m█[39m[38;2;53;75;254m█[39m[38;2;50;79;253m╔[39m[38;2;46;83;253m═[39m[38;2;43;87;252m═[39m[38;2;40;91;251m█[39m[38;2;37;95;250m█[39m[38;2;34;100;249m╗[39m[38;2;31;104;247m█[39m[38;2;29;108;246m█[39m[38;2;26;112;244m╔[39m[38;2;24;116;243m═[39m[38;2;21;120;241m═[39m[38;2;19;125;239m╝[39m[38;2;17;129;237m [39m[38;2;15;133;235m [39m[38;2;13;137;232m[39m',
    '[38;2;254;72;56m█[39m[38;2;254;68;60m█[39m[38;2;254;64;64m║[39m[38;2;254;61;67m [39m[38;2;254;57;71m [39m[38;2;254;54;75m█[39m[38;2;253;50;79m█[39m[38;2;253;47;83m╗[39m[38;2;252;44;87m█[39m[38;2;251;41;91m█[39m[38;2;250;38;95m║[39m[38;2;249;35;99m█[39m[38;2;248;32;103m█[39m[38;2;246;29;107m║[39m[38;2;245;26;111m [39m[38;2;243;24;116m [39m[38;2;241;22;120m█[39m[38;2;239;19;124m█[39m[38;2;237;17;128m║[39m[38;2;235;15;132m╚[39m[38;2;233;13;137m█[39m[38;2;230;11;141m█[39m[38;2;228;10;145m█[39m[38;2;225;8;149m█[39m[38;2;222;7;153m█[39m[38;2;219;6;158m█[39m[38;2;216;4;162m╔[39m[38;2;213;4;166m╝[39m[38;2;210;3;170m╚[39m[38;2;207;2;174m█[39m[38;2;204;1;178m█[39m[38;2;200;1;181m█[39m[38;2;197;1;185m╔[39m[38;2;193;1;189m█[39m[38;2;189;1;193m█[39m[38;2;186;1;196m█[39m[38;2;182;1;200m╔[39m[38;2;178;1;203m╝[39m[38;2;174;2;207m█[39m[38;2;170;3;210m█[39m[38;2;166;3;213m║[39m[38;2;162;4;216m [39m[38;2;158;6;219m [39m[38;2;154;7;222m█[39m[38;2;150;8;225m█[39m[38;2;145;10;227m║[39m[38;2;141;11;230m█[39m[38;2;137;13;232m█[39m[38;2;133;15;235m█[39m[38;2;129;17;237m█[39m[38;2;124;19;239m█[39m[38;2;120;21;241m█[39m[38;2;116;24;243m█[39m[38;2;112;26;245m║[39m[38;2;107;29;246m█[39m[38;2;103;32;248m█[39m[38;2;99;34;249m║[39m[38;2;95;37;250m [39m[38;2;91;40;251m [39m[38;2;87;44;252m█[39m[38;2;83;47;253m█[39m[38;2;79;50;253m║[39m[38;2;75;53;254m█[39m[38;2;71;57;254m█[39m[38;2;68;61;254m█[39m[38;2;64;64;254m█[39m[38;2;60;68;254m█[39m[38;2;57;72;254m█[39m[38;2;53;75;254m█[39m[38;2;50;79;253m╗[39m[38;2;46;83;253m█[39m[38;2;43;87;252m█[39m[38;2;40;91;251m║[39m[38;2;37;95;250m [39m[38;2;34;100;249m [39m[38;2;31;104;247m█[39m[38;2;29;108;246m█[39m[38;2;26;112;244m║[39m[38;2;24;116;243m█[39m[38;2;21;120;241m█[39m[38;2;19;125;239m█[39m[38;2;17;129;237m█[39m[38;2;15;133;235m█[39m[38;2;13;137;232m█[39m[38;2;11;142;230m█[39m[38;2;10;146;227m╗[39m[38;2;8;150;225m[39m',
    '[38;2;254;61;67m╚[39m[38;2;254;57;71m═[39m[38;2;254;54;75m╝[39m[38;2;253;50;79m [39m[38;2;253;47;83m [39m[38;2;252;44;87m╚[39m[38;2;251;41;91m═[39m[38;2;250;38;95m╝[39m[38;2;249;35;99m╚[39m[38;2;248;32;103m═[39m[38;2;246;29;107m╝[39m[38;2;245;26;111m╚[39m[38;2;243;24;116m═[39m[38;2;241;22;120m╝[39m[38;2;239;19;124m [39m[38;2;237;17;128m [39m[38;2;235;15;132m╚[39m[38;2;233;13;137m═[39m[38;2;230;11;141m╝[39m[38;2;228;10;145m [39m[38;2;225;8;149m╚[39m[38;2;222;7;153m═[39m[38;2;219;6;158m═[39m[38;2;216;4;162m═[39m[38;2;213;4;166m═[39m[38;2;210;3;170m═[39m[38;2;207;2;174m╝[39m[38;2;204;1;178m [39m[38;2;200;1;181m [39m[38;2;197;1;185m╚[39m[38;2;193;1;189m═[39m[38;2;189;1;193m═[39m[38;2;186;1;196m╝[39m[38;2;182;1;200m╚[39m[38;2;178;1;203m═[39m[38;2;174;2;207m═[39m[38;2;170;3;210m╝[39m[38;2;166;3;213m [39m[38;2;162;4;216m╚[39m[38;2;158;6;219m═[39m[38;2;154;7;222m╝[39m[38;2;150;8;225m [39m[38;2;145;10;227m [39m[38;2;141;11;230m╚[39m[38;2;137;13;232m═[39m[38;2;133;15;235m╝[39m[38;2;129;17;237m╚[39m[38;2;124;19;239m═[39m[38;2;120;21;241m═[39m[38;2;116;24;243m═[39m[38;2;112;26;245m═[39m[38;2;107;29;246m═[39m[38;2;103;32;248m═[39m[38;2;99;34;249m╝[39m[38;2;95;37;250m╚[39m[38;2;91;40;251m═[39m[38;2;87;44;252m╝[39m[38;2;83;47;253m [39m[38;2;79;50;253m [39m[38;2;75;53;254m╚[39m[38;2;71;57;254m═[39m[38;2;68;61;254m╝[39m[38;2;64;64;254m╚[39m[38;2;60;68;254m═[39m[38;2;57;72;254m═[39m[38;2;53;75;254m═[39m[38;2;50;79;253m═[39m[38;2;46;83;253m═[39m[38;2;43;87;252m═[39m[38;2;40;91;251m╝[39m[38;2;37;95;250m╚[39m[38;2;34;100;249m═[39m[38;2;31;104;247m╝[39m[38;2;29;108;246m [39m[38;2;26;112;244m [39m[38;2;24;116;243m╚[39m[38;2;21;120;241m═[39m[38;2;19;125;239m╝[39m[38;2;17;129;237m╚[39m[38;2;15;133;235m═[39m[38;2;13;137;232m═[39m[38;2;11;142;230m═[39m[38;2;10;146;227m═[39m[38;2;8;150;225m═[39m[38;2;7;154;222m═[39m[38;2;5;158;219m╝[39m[38;2;4;162;216m[39m',
}

require('dashboard').setup({
    theme = 'hyper',
    config = {
        header = header,
        footer = { '', 'kriowashere' }
    },
    disable_move = true,
})
