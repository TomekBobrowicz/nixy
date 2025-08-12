{
  lib,
  rustPlatform,
  fetchFromGitLab,
}:
rustPlatform.buildRustPackage rec {
  pname = "hourglass";
  version = "1.3.7";

  src = fetchFromGitLab {
    owner = "alxhr0";
    repo = "hourglass";
    rev = version;
    hash = "sha256-lYcB8K0rGYKwA4o7kWG75urfgMi6JT3b+7TSks7OiYs=";
  };

  cargoHash = "sha256-sIdUlGY/23LeXQoOYu7jYZmCr7bM1zkfw3yuOSZ5Jmw=";

  meta = {
    description = "";
    homepage = "https://gitlab.com/alxhr0/hourglass";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [];
    mainProgram = "hourglass";
  };
}
