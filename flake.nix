{
  description = "Simple discord bot for getting info about the author";

  inputs      = {
    bot.url         = "github:indypaige/bot";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs        = { self, flake-utils, bot }:
    let system = "x86_64-linux";
        global = {
          email = "pan@indypaige.gay";
          name  = "Indy Paige";
        };

        lib    = bot.lib.${system};
        mk     = bot.mk.${system};

        purple = x: lib.embed x // {
          color = lib.colors.purple;
        };
    in {
      packages.${system}.default = mk {
        name = "inf";
        bot  = {
          command = {
            email.response = {
              tag   = "ResponseEmbed";
              embed = purple {
                description  = global.email;
              };
            };

            name.response = {
              tag   = "ResponseEmbed";
              embed = purple {
                description = global.name;
              };

            };
          };

          prefix  = "inf:";

          catch   = {
            tag   = "ResponseText";
            text  = "Unknown command";
          };
        };
      };
    };
}
