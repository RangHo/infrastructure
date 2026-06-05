let
  githubKeysFile = builtins.fetchurl {
    url = "https://github.com/RangHo.keys";
    sha256 = "sha256:1zzya497d4myjc18lblmrlk58qp2vzikyqljawd2m46n4n6m7ffn";
  };
  githubKeys = builtins.readFile githubKeysFile;
in
{
  yirgacheffe = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICBkYuM3vYz+OnY3Afrm+nLQhldBg4FL8N8MeKIB/7+6"
  ];

  github = builtins.filter builtins.isString (
    builtins.split "\n" githubKeys
  );
}
