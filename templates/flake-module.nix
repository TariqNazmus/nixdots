{ ... }:
{
  flake.templates = {
    python = {
      path = ./python;
      description = "Python + uv + ruff + pyright environment";
    };
    web = {
      path = ./web;
      description = "Node 22 + pnpm + bun + TypeScript environment";
    };
  };
}
