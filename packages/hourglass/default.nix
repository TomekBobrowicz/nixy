{
  lib,
  rustPlatform,
  fetchFromGitLab,
}:
rustPlatform.buildRustPackage rec {
  pname = "hourglass";
  version = "1.3.4";

  src = fetchFromGitLab {
    owner = "alxhr0";
    repo = "hourglass";
    rev = version;
    hash = "sha256-BBkluS9hsNRh1/weXBJbzwjL8y2GvUHRqZKHqN52bo4=";
  };

  cargoHash = "sha256-4SB6gBNOsImHYDDqv39+G9fdiwCtjXUHXIa4ylYDvlE=";

  meta = {
    description = "";
    homepage = "https://gitlab.com/alxhr0/hourglass";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [];
    mainProgram = "hourglass";
  };
}
