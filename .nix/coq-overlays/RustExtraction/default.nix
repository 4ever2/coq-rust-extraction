{ lib, mkCoqDerivation, which, coq
  , metacoq, version ? null }:

with lib; mkCoqDerivation {
  pname = "RustExtraction";
  repo = "coq-rust-extraction";
  owner = "AU-COBRA";
  domain = "github.com";

  inherit version;
  defaultVersion = with versions; switch [coq.coq-version metacoq.version] [
    { cases = [(range "8.17" "8.19") (range "1.3.1" "1.3.3")]; out = "0.1.0"; }
    { cases = [(range "8.20" "9.0") (range "1.3.2" "1.3.4")]; out = "0.1.1"; }
  ] null;

  release."0.1.0".sha256 = "+Of/DP2Vjsa7ASKswjlvqqhcmDhC9WrozridedNZQkY=";
  release."0.1.1".sha256 = "CPZ5J9knJ1aYoQ7RQN8YFSpxqJXjgQaxIA4F8G6X4tM=";

  releaseRev = v: "v${v}";

  propagatedBuildInputs = [ coq.ocamlPackages.findlib metacoq ];

  postPatch = ''
    patchShebangs ./process_extraction.sh
    patchShebangs ./tests/process-extraction-examples.sh
  '';

  mlPlugin = true;

  meta = {
    description = "A framework for extracting Coq programs to Rust";
    maintainers = with maintainers; [ _4ever2 ];
    license = licenses.mit;
  };
}
