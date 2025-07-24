{
  lib,
  rustPlatform,
  fetchFromGitLab,
}:
rustPlatform.buildRustPackage rec {
  pname = "hourglass";
  version = "1.3.3";

  src = fetchFromGitLab {
    owner = "alxhr0";
    repo = "hourglass";
    rev = version;
    hash = "sha256-cPGZ+ZgxnDFDPWRknzunf7+RiC/r6ATstoqnCsS4Tqk=";
  };

  cargoHash = "sha256-Zvg7IsjpobklQdgPDBWeDjExjksCCSIfH6rAAQXQvC0=";

  meta = {
    description = "";
    homepage = "https://gitlab.com/alxhr0/hourglass";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [];
    mainProgram = "hourglass";
  };
}
