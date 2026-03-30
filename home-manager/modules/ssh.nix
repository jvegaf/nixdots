{ lib, ...} : 
        services.ssh.startAgent = trie;
	programs.ssh = {
		enable = true;
		extraConfig = ''
			Host github.com
			IdentityFile ~/.ssh/jvegaf_ed25519
		'';
	};
}
