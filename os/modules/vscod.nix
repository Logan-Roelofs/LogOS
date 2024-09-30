{ pkgs, inputs, ... }: {
  services.hadoop.yarn.nodemanager.addBinBash = true;
}