Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E0421612F
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jul 2020 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGFV5V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jul 2020 17:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgGFV5V (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 6 Jul 2020 17:57:21 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E81A20674;
        Mon,  6 Jul 2020 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594072640;
        bh=L8dMxNCRNgMTPM9Eln7zmR1a9xzBvMqAIGbCEBcPACo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOE/A9Gy3RWz1WYyVlO0wRIKcMJbJc3P2or8uM5++fWfnITNwhMpYbP+7DfykHooL
         ejuV/mTS6fkIczACHCDrX7vL/grCJaeH2g36bmIHb+5cNYQ4hoNT90bCy21ru7Hbbn
         fHhCuRKTi3BR1HZZZBHij0NQnf5LW9/VrdE9a8tA=
Date:   Mon, 6 Jul 2020 14:57:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Florian Schmaus <flo@geekplace.eu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] e4crypt: if salt is explicitly provided to add_key,
 then use it
Message-ID: <20200706215719.GA827691@gmail.com>
References: <20200706194727.12979-1-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706194727.12979-1-flo@geekplace.eu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 06, 2020 at 09:47:25PM +0200, Florian Schmaus wrote:
> Providing -S and a path to 'add_key' previously exhibit an unintuitive
> behavior: instead of using the salt explicitly provided by the user,
> e4crypt would use the salt obtained via EXT4_IOC_GET_ENCRYPTION_PWSALT
> on the path. This was because set_policy() was still called with NULL
> as salt.
> 
> With this change we now remember the explicitly provided salt (if any)
> and use it as argument for set_policy().
> 
> Eventually
> 
> e4crypt add_key -S s:my-spicy-salt /foo
> 
> will now actually use 'my-spicy-salt' and not something else as salt
> for the policy set on /foo.
> 
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>

Thanks for these patches for e4crypt.

Note that e4crypt is in maintenance mode, and it hasn't been updated to follow
recommended security practices (e.g. using Argon2), to support the new
encryption API which fixes a lot of problems with the original one, or to
support the other filesystems that share the same encryption API.

Instead you should use the 'fscrypt' tool: https://github.com/google/fscrypt

What is your use case for still using e4crypt?  And why do you want to
explicitly specify a salt?

> ---
>  misc/e4crypt.8.in | 4 +++-
>  misc/e4crypt.c    | 8 +++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/misc/e4crypt.8.in b/misc/e4crypt.8.in
> index 75b968a0..32fbd444 100644
> --- a/misc/e4crypt.8.in
> +++ b/misc/e4crypt.8.in
> @@ -48,7 +48,9 @@ values are 4, 8, 16, and 32.
>  If one or more directory paths are specified, e4crypt will try to
>  set the policy of those directories to use the key just added by the
>  .B add_key
> -command.
> +command.  If a salt was explicitly specified, then it will be used
> +by the policy of those directories.  Otherwise a directory-specific
> +default salt will be used.

This description isn't quite correct.  The salt is a value used to derive the
encryption key; it's not part of the encryption policy itself.

>  .TP
>  .B e4crypt get_policy \fIpath\fR ...
>  Print the policy for the directories specified on the command line.
> diff --git a/misc/e4crypt.c b/misc/e4crypt.c
> index 2ae6254a..c82c6f8f 100644
> --- a/misc/e4crypt.c
> +++ b/misc/e4crypt.c
> @@ -652,6 +652,7 @@ static void do_help(int argc, char **argv, const struct cmd_desc *cmd);
>  static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
>  {
>  	struct salt *salt;
> +	struct salt *explicit_salt = NULL;
>  	char *keyring = NULL;
>  	int i, opt, pad = 4;
>  	unsigned j;
> @@ -666,8 +667,13 @@ static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
>  			pad = atoi(optarg);
>  			break;
>  		case 'S':
> +			if (explicit_salt) {
> +				fputs("May only provide -S once\n", stderr);
> +				exit(1);
> +			}
>  			/* Salt value for passphrase. */
>  			parse_salt(optarg, 0);
> +			explicit_salt = salt_list;
>  			break;
>  		case 'v':
>  			options |= OPT_VERBOSE;
> @@ -703,7 +709,7 @@ static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
>  		insert_key_into_keyring(keyring, salt);
>  	}
>  	if (optind != argc)
> -		set_policy(NULL, pad, argc, argv, optind);
> +		set_policy(explicit_salt, pad, argc, argv, optind);

This causes a use-after-free because the memory pointed to by 'explicit_salt'
can be reallocated by add_salt(), called from parse_salt():

        for (i = optind; i < argc; i++)
                parse_salt(argv[i], PARSE_FLAGS_FORCE_FN);

I think we shouldn't add these extra salts when a salt was explicitly specified.

Moreover it appears the above code should just be removed, since
get_default_salts() already handles adding salts for all ext4 filesystems.

- Eric
