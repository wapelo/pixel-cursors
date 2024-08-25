{
  lib,
  stdenv,
  hyprcursor,
}:
stdenv.mkDerivation {
  pname = "pixel-cursors";
  version = "1.0";
  src = ../.;

  nativeBuildInputs = [ hyprcursor.packages.${stdenv.hostPlatform.system}.hyprcursor ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons/
    hyprcursor-util --create $src -o $out/share/icons/

    runHook postInstall
  '';

  meta = with lib; {
    description = "A cute, simplistic pixel art cursor theme";
    license = licenses.bsd3;
    maintainers = with maintainers; [ wapelo ];
  };
}
