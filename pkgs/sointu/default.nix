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
  version = "2024-03-02";
  rev = "e488cd391b57b92591cb6ae1cf9b1d6a1a5e0229";
in
  buildGoModule {
    name = "sointu-${version}";
    inherit version rev;

    src = fetchFromGitHub {
      inherit rev;
      owner = "vsariola";
      repo = "sointu";
      sha256 = "sha256-pKM8krO9ZYKQEbzZ2r0FPoxa+WIluVE48POBfK+O4CA=";
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
