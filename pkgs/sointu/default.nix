# SPDX-FileCopyrightText: 2024 Mika Tammi
# SPDX-License-Identifier: MIT
{
  alsa-lib,
  buildGoModule,
  darwin,
  fetchFromGitHub,
  lib,
  libX11,
  libXcursor,
  libXfixes,
  libglvnd,
  libxkbcommon,
  pkg-config,
  stdenv,
  vulkan-headers,
  wayland,
}: let
  version = "2024-06-19";
  rev = "db2d9cac9dc938621b8bc05b540c233c78c0dde8";
in
  buildGoModule {
    name = "sointu-${version}";
    inherit version rev;

    src = fetchFromGitHub {
      inherit rev;
      owner = "vsariola";
      repo = "sointu";
      sha256 = "sha256-G+bmWcC/nkDgUDieaIX03hzHCVwZr/I1YIyIcUKVIu4=";
    };

    vendorHash = "sha256-6AUiIQYU3VSNAjhbFX/WXotfVVTDFzhdhkJWjobh8DI=";

    nativeBuildInputs = lib.optionals stdenv.isLinux [
      pkg-config
    ];

    buildInputs =
      lib.optionals stdenv.isLinux [
        alsa-lib
        libX11
        libXcursor
        libXfixes
        libglvnd
        libxkbcommon
        pkg-config
        vulkan-headers
        wayland
      ]
      ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
        AppKit
        AudioToolbox
        Metal
        UniformTypeIdentifiers
      ]);

    excludedPackages = [
      "cmd/sointu-play"
      "cmd/sointu-vsti"
      "oto"
      "vm/compiler/bridge"
    ];

    meta = {
      homepage = "https://github.com/vsariola/sointu";
      license = lib.licenses.mit;
    };
  }
