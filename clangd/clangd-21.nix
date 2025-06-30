{ lib, stdenv, fetchzip, autoPatchelfHook }:

let
  sources = {
    x86_64-linux = {
      url =
        "https://github.com/clangd/clangd/releases/download/snapshot_20250621/clangd-linux-snapshot_20250621.zip";
      hash = "sha256-UC+Em6FUkkEL7zh2L7rEZbeN0UVIhbrx5gnJ+mgwJU4=";
    };
    x86_64-darwin = {
      url =
        "https://github.com/clangd/clangd/releases/download/snapshot_20250621/clangd-mac-snapshot_20250621.zip";
      hash = "sha256-a3fBlrsuURUGW86rxYM84Y4BOGI52TcUE+HtEdLDazI=";
    };
    aarch64-darwin = {
      url =
        "https://github.com/clangd/clangd/releases/download/snapshot_20250621/clangd-mac-snapshot_20250621.zip";
      hash = "sha256-a3fBlrsuURUGW86rxYM84Y4BOGI52TcUE+HtEdLDazI=";
    };
  };
in stdenv.mkDerivation {
  pname = "clangd";
  version = "21-init";

  src = fetchzip sources.${stdenv.hostPlatform.system};

  nativeBuildInputs = [ autoPatchelfHook ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp bin/clangd $out/bin/clangd
    chmod +x $out/bin/clangd

    runHook postInstall
  '';

  meta = with lib; {
    description =
      "A language server for C/C++/Objective-C (pre-release snapshot)";
    longDescription = ''
      clangd is a language server that provides IDE-like features to editors.
      This package only contains clangd in its pre-release snapshot version.
      This can be used for embedded applications where you need the new
        CompileFlags:
          BuiltinHeaders: QueryDriver
      feature to ignore system headers from the build host.
    '';
    homepage = "https://clangd.llvm.org/";
    license = licenses.llvm-exception;
    maintainers = "Lasse Krarup";
    platforms = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
    mainProgram = "clangd";
  };
}
