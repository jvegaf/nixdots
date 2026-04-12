{ lib, ...} : 
{
	programs.ssh = {
		enable = true;
		# startAgent = true;
		extraConfig = ''
			Host github.com
			IdentityFile ~/.ssh/jvegaf_ed25519
		'';
	};
}
