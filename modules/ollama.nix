{ pkgs, ... }: {
services.ollama = {
  enable = true;
  package = pkgs.ollama-cuda;
  # Optional: preload models, see https://ollama.com/library
  # loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
};

services.open-webui.enable = true;
}
