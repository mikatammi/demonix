# SPDX-FileCopyrightText: 2024 Mika Tammi
# SPDX-License-Identifier: MIT
_: {
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      name = "devShell mostly for convenience during Github Actions";
      packages = with pkgs; [
        reuse
      ];
    };
  };
}
