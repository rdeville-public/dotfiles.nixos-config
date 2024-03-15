{
  stdenv,
  fetchFromGitHub
}:
{
  sddm-theme = stdenv.mkDerivation rec {
    pname = "sddm-theme";
    version = "1.0";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src/Elegant $out/share/sddm/themes/sddm-theme
    '';
    src = fetchFromGitHub {
      owner = "surajmandalcell";
      repo = "Elegant-sddm";
      rev = "3102e880f46a1b72c929d13cd0a3fb64f973952a";
      sha256 = "sha256-yn0fTYsdZZSOcaYlPCn8BUIWeFIKcTI1oioTWqjYunQ=";
    };
  };
}

