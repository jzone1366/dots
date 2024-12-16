-- Art from here -> https://www.asciiart.eu/television/doctor-who
-- Art from here -> https://ascii.co.uk/art/drwho
--stylua: ignore start
local headers = {
  ['who_banner'] = {
    '         | |            ^     | |   []    | |  *              ',
    '         | |   [O]     [O]    | | .-==-.  | |    __DOCTOR_    ',
    '      (  | |   /#\\     /#\\    | | |[][]|  | |    \\__WHO__/  + ',
    '   __[\\  | |  || ||   || ||   | | |[][]|  | |           |     ',
    '  /__\\   | |   | |     | |    | | |[][]|  | |  *       -+-    ',
    '         | |   _ _     _ _    | | |____|  | |      *    |     ',
    '                                                              ',
    '"Master?"   "We will survive!"   "Vworp!"    "Whoopity woo..."',
  },

  ['dalek'] = {
    "           -___________-                                              ",
    "          (/     _     \\)                                             ",
    "          /_____(O)_____\\                                             ",
    "          // / / | \\ \\ \\                                             ",
    "         =================                                            ",
    "         // / | | | | \\ \\    - EXTERMINATE! EXTERMINATE!             ",
    "        ===================                                           ",
    "       //// || || || || \\\\                                          ",
    "       |||| || || || || ||||                                          ",
    "      /---___-----------,---\\                                         ",
    "      |  /   \\         -o-  |                                         ",
    "      /  \\___/          '   \\                                         ",
    "      +---------------------+                                         ",
    "     /_   __    ___    __   _\\                                        ",
    "    (__) (__)  (___)  (__) (__)                                       ",
    "    |_    __    ___    __    _|                   #     Open the      ",
    "   (__)  (__)  (___)  (__)  (__)               ------- /doors,        ",
    "   /_    ___    ___    ___    _\\               |-----|  Doctor, I     ",
    "  (__)  (___)  (___)  (___)  (__)              |II|II|  think there's ",
    "  |_     ___    ___    ___     _|              |II|II|  someone       ",
    " (__)   (___)  (___)  (___)   (__)             |II|II|  there....     ",
    " /_______________________________\\             |II|II|                ",
  },

  ['tardis'] = {
    '         ___         ',
    ' _______(_@_)_______ ',
    ' | POLICE      BOX | ',
    ' |_________________| ',
    '  | _____ | _____ |  ',
    '  | |###| | |###| |  ',
    '  | |###| | |###| |  ',
    '  | _____ | _____ |  ',
    '  | || || | || || |  ',
    '  | ||_|| | ||_|| |  ',
    '  | _____ |$_____ |  ',
    '  | || || | || || |  ',
    '  | ||_|| | ||_|| |  ',
    '  | _____ | _____ |  ',
    '  | || || | || || |  ',
    '  | ||_|| | ||_|| |  ',
    '  |       |       |  ',
    '  *****************  ',
  },

  ['tardis_large'] = {
    '                 _.--._                  ',
    '                 _|__|_                  ',
    '     _____________|__|_____________      ',
    "  .-'______________________________'-.   ",
    '  | |________POLICE___BOX__________| |   ',
    '  |  |============================|  |   ',
    '  |  | .-----------..-----------. |  |   ',
    '  |  | |  _  _  _  ||  _  _  _  | |  |   ',
    '  |  | | | || || | || | || || | | |  |   ',
    '  |  | | |_||_||_| || |_||_||_| | |  |   ',
    '  |  | | | || || | || | || || | | |  |   ',
    '  |  | | |_||_||_| || |_||_||_| | |  |   ',
    '  |  | |  _______  ||  _______  | |  |   ',
    '  |  | | |       | || |       | | |  |   ',
    '  |  | | |       | || |       | | |  |   ',
    '  |  | | |       | || |       | | |  |   ',
    '  |  | | |_______| || |_______| | |  |   ',
    '  |  | |  _______ @||@ _______  | |  |   ',
    '  |  | | |       | || |       | | |  |   ',
    '  |  | | |       | || |       | | |  |   ',
    '  |  | | |       | || |       | | |  |   ',
    '  |  | | |_______| || |_______| | |  |   ',
    '  |  | |  _______  ||  _______  | |  |   ',
    '  |  | | |       | || |       | | |  |   ',
    '  |  | | |       | || |       | | |  |   ',
    '  |  | | |       | || |       | | |  |   ',
    '  |  | | |_______| || |_______| | |  |   ',
    "  |  | '-----------''-----------' |  |   ",
    ' _|__|/__________________________\\|__|_ ',
    "----'----------------------------'----   ",
  },

  ['dog'] = {
    ' \\      oo   ',
    '  \\____|\\mm  ',
    '  //_//\\ \\_\\ ',
    ' /K-9/  \\/_/ ',
    '/___/_____\\  ',
    '-----------  ',
  },

  ['logo_sparkles'] = {
    '    *                          .                                     ',
    '               .          .                        .       |       . ',
    '                                                         --*--       ',
    '                              _________                    |         ',
    '         .               _|_ /_   _                                  ',
    '         _______       _  |  |_| |      .                            ',
    '              | \\  _  |_                                             ',
    '              |_/ |_|      .                                  .      ',
    '           _____  ____  _________    _____ _____________             ',
    '           \\    \\/    \\/         \\__/     V     ____    |            ',
    '            \\      _      /|      __      |    |____|   |         .  ',
    '    .        \\____/ \\___/  |_____|  |_____|_____________|            ',
    '                                                                     ',
    '             .                          .                            ',
    '                                                         .           ',
    '                           *       .                                 ',
    ' :                                                                   ',
    '                                .                   .             .  ',
    '               *                  .                                  ',
  },

  ['logo_large'] = {
    '          ######      #####      #####  ########  #####    #######            ',
    '          ##   ##    ##   ##    ##   ##    ##    ##   ##   ##    ##           ',
    '          ##    ##  ##     ##  ##          ##   ##     ##  ##    ##           ',
    '          ##    ##  ##     ##  ##          ##   ##     ##  ## ###             ',
    '          ##   ##    ##   ##    ##   ##    ##    ##   ##   ##    ##           ',
    '############ ########### ########################### ########    ############',
    '                                                                           ##',
    ' ############     #####     ###########     #####################         ## ',
    ' ##     #####     #####     ###########     #######################       ## ',
    '  ##     #####   #######   #####  #####     #####    ###############     ##  ',
    '  ##     #####   #######   #####  #####     #####   #####       #####    ##  ',
    '   ##     ##### ######### #####   #####     #####  #####         #####  ##   ',
    '   ##     ##### ######### #####   ###############  #####         #####  ##   ',
    '    ##     ######### #########    ###############  #####         ##### ##    ',
    '    ##     ######### #########    #####     #####  #####         ##### ##    ',
    '     ##     #######   #######     #####     #####   #####       ##### ##     ',
    '     ##     #######   #######     #####     #####    ###############  ##     ',
    '      ##     #####     #####      #####     #####     #############  ##      ',
    '      ##     #####     #####      #####     #####       #########    ##      ',
    '       ##                                                           ##       ',
    '       ###############################################################       ',
  },

  ['daak_sword'] = {
    '     .----._____.---._____                                   ',
    '     \\o   .-------. |    o/^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-.   ',
    " _____\\   '-------' |   .`                                )> ",
    "'------\\   _______  |_.`-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-`   ",
    "        \\_|='='='=|_|                                        ",
  },

  ['davros'] = {
    "       . ` ` .     ",
    "    .` <#>   O `.  ",
    "   /__ __ _ __ __\\ ",
    "   |__|__|_|__|__| ",
    "    \\           /  ",
    "     `-._____.-`   ",
    "       /o|o|o\\     ",
    "      /|o|o|o|\\    ",
    "     /o|o|o|o|o\\   ",
    "    / o|o|o|o|o \\  ",
    "    |.-.-.-.-.-.|  ",
    "    '--'-'-'-'--'  ",
  },

  ['cool_logo'] = {
    '         88                               88                      ',
    '         88                               88                      ',
    '         88                               88                      ',
    ' ,adPPYb,88 8b,dPPYba, 8b      db      d8 88,dPPYba,   ,adPPYba,  ',
    "a8\"    `Y88 88P'   \"Y8 `8b    d88b    d8' 88P'    \"8a a8\"     \"8a ",
    "8b       88 88          `8b  d8'`8b  d8'  88       88 8b       d8 ",
    '"8a,   ,d88 88           `8bd8\'  `8bd8\'   88       88 "8a,   ,a8" ',
    ' `"8bbdP"Y8 88             YP      YP     88       88  `"YbbdP"\'  ',
  },

  ['logo_shorter'] = {
    '     888                    888             ',
    '     888                    888             ',
    '     888                    888             ',
    ' .d88888888d888888  888  88888888b.  .d88b. ',
    'd88" 888888P"  888  888  888888 "88bd88""88b',
    '888  888888    888  888  888888  888888  888',
    'Y88b 888888    Y88b 888 d88P888  888Y88..88P',
    ' "Y88888888     "Y8888888P" 888  888 "Y88P" ',
  }
}
--stylua: ignore end

return setmetatable(headers, {
  __index = {
    random = function()
      local keys = {}
      for k, _ in pairs(headers) do
        table.insert(keys, k)
      end
      return headers[keys[math.random(#keys)]]
    end,
  },
})
