{ ... }:
{
  age.secrets = {
    gmail-aerc = {
      file = ../../../secrets/gmail-aerc.age;   
      owner = "nikola";
      mode = "0400";
    };

    gmail-2-aerc = {
      file = ../../../secrets/gmail-2-aerc.age;   
      owner = "nikola";
      mode = "0400";
    };

    gmail-3-aerc = {
      file = ../../../secrets/gmail-3-aerc.age;   
      owner = "nikola";
      mode = "0400";
    };

    alas-aerc = {
      file = ../../../secrets/alas-aerc.age;   
      owner = "nikola";
      mode = "0400";
    };
  };
  
}
