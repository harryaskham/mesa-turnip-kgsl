{ pkgs ? import <nixpkgs> {}}:

with pkgs.lib;

let
  pythonPkgs = (ps: with ps; [
    distutils
    mako
  ]);
  pythonEnv = pkgs.python3.withPackages pythonPkgs;
in pkgs.mkShell ({
    nativeBuildInputs = with pkgs; [
      pythonEnv
      meson
      ninja
      #gcc
      clang
      llvm
      glib
      libdrm
      # stdenv.cc.cc
      # stdenv.cc.cc.lib
      # stdenv.cc.cc.libgcc
      zlib
      zlib.dev
      dlib
      pkg-config
      vulkan-loader
      vulkan-headers
      vulkan-tools
      vulkan-tools-lunarg
      vulkan-validation-layers
      vulkan-extension-layer
      shaderc
      mesa.drivers
      bintools
      libglvnd
      bison
      byacc
      flex
      wayland-scanner
      wayland-protocols
      wayland
      xorg.libX11
      xorg.libxcb
      xorg.libXext
      xorg.libXfixes
      xorg.libxshmfence
      xorg.libXxf86vm
      xorg.libXrandr
    ];
    shellHook = ''
      export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:~/.nix-profile/lib"
      export SETUP_CMD="meson build -D platforms=x11,wayland -D gallium-drivers=swrast,virgl,zink -D vulkan-drivers=freedreno -D dri3=enabled  -D egl=enabled  -D gles2=enabled -D glvnd=true -D glx=dri  -D libunwind=disabled -D osmesa=true  -D shared-glapi=enabled -D microsoft-clc=disabled  -D valgrind=disabled --prefix $PWD/build/install -D gles1=disabled -D freedreno-kgsl=true"
      export BUILD_CMD="ninja -C build/"
    '';
  })
