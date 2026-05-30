{ pkgs ? import <nixpkgs> {} }:

let
  # Extraemos el contenido del AppImage oficial usando la URL exacta de CrealityOfficial
  extracted = pkgs.appimageTools.extractType2 {
    pname = "creality-print-extracted";
    version = "7.1.0"; 
    src = pkgs.fetchurl {
      url = "https://github.com/CrealityOfficial/CrealityPrint/releases/download/v7.1.0/CrealityPrint_ubuntu2404-V7.1.0.4414-x86_64-Release.AppImage";
      sha256 = "sha256-AQG1V4smqBEHyyDOINJkd5uVuNYw4ELQ9tNjOuN/7Y8=";
    };
  };
in
pkgs.buildFHSEnv {
  name = "creality-print";
  
  targetPkgs = pkgs: with pkgs; [
    # Sistema base, hardware y comunicación por red local
    udev
    alsa-lib
    gtk3
    webkitgtk_4_1
    libsecret
    libnotify
    xdg-utils
    nss
    nspr
    at-spi2-atk
    dbus
    libglvnd
    libGL
    libGLU
    
    # Renderizado de texto y fuentes
    fontconfig
    freetype
    pango        
    harfbuzz     
    gdk-pixbuf   
    
    # Códecs de imagen y texturas gráficas
    lerc         
    libtiff      
    
    # Soporte nativo para Wayland
    wayland      
    
    # Servidor gráfico de ventanas X11 / XWayland
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXi
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXfixes
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXtst
    xorg.libSM
    xorg.libICE
    
    # Stack de compresión interna que exige el binario de Ubuntu 24.04
    bzip2
    zlib
    libdeflate
    brotli
    libmspack
  ];

  # SOLUCIÓN INVENTARIO: Obligamos al entorno FHS a meter el enlace en el PATH de carga
  profile = ''
    # Creamos un directorio de links temporales dentro del entorno del usuario
    mkdir -p /tmp/creality-libs
    ln -sf ${pkgs.bzip2.out}/lib/libbz2.so.1 /tmp/creality-libs/libbz2.so.1.0
    
    # Le decimos al binario que busque prioritariamente en nuestra carpeta de parches
    export LD_LIBRARY_PATH=/tmp/creality-libs:$LD_LIBRARY_PATH
  '';

  # Ejecutamos el binario principal dentro del entorno virtual clásico simulado
  runScript = "${extracted}/bin/CrealityPrint";
}
