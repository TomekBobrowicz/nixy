{
  lib,
  rustPlatform,
  fetchFromGitLab,
}:
rustPlatform.buildRustPackage rec {
  pname = "hourglass";
  version = "1.3";

  src = fetchFromGitLab {
    owner = "alxhr0";
    repo = "hourglass";
    rev = version;
    hash = "sha256-OOSLngScy/kgFuArPbxYVl5f9wIntJ0iI9GS6wkCqP8=";
  };

  cargoHash = "sha256-GMiRSVipQzhhjEgeJIjrh/B9dv736npOdzUhdZFg5M8=";

  meta = {
    description = "";
    homepage = "https://gitlab.com/alxhr0/hourglass";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [];
    mainProgram = "hourglass";
  };
}
