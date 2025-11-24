{ ... }:
{
  services.sanoid = {
    enable = true;
    interval = "hourly";

    templates.myDefault = {
      hourly = 10;
      daily = 7;
      monthly = 2;
      autosnap = true;
      autoprune = true;
    };

    datasets = {
      "zroot/root/home" = {
        useTemplate = [ "myDefault" ];
      };
    };

  };
}
