Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DB217AA7
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jul 2020 23:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgGGVrG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jul 2020 17:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgGGVrG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 7 Jul 2020 17:47:06 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D630206C3;
        Tue,  7 Jul 2020 21:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594158425;
        bh=ts+rvuN68LcgbRXW9Yw4SR73tT3Wbcg4lH9/td/6Y48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dn/ov9H+jKWfQSHO9PKQyMghLVZpP06uh60KGNIw05F4fBAtK6OVlg2BHA2kOJgC8
         cwruCwGabBvlPqfXEOd6evZcfwZ18oo24jz2veoy6Vsan3QcNBqPkz/rpFJt5O1ZwV
         c5MZ4GoTQRmqe8s5X1SIFAGKGshPRXHi6mjvwfzA=
Date:   Tue, 7 Jul 2020 14:47:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Florian Schmaus <flo@geekplace.eu>, Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] e4crypt: if salt is explicitly provided to add_key,
 then use it
Message-ID: <20200707214704.GD3426938@gmail.com>
References: <20200706194727.12979-1-flo@geekplace.eu>
 <20200707082729.85058-1-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707082729.85058-1-flo@geekplace.eu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 07, 2020 at 10:27:30AM +0200, Florian Schmaus wrote:
> Providing -S and a path to 'add_key' previously exhibit an unintuitive

exhibit => exhibited

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
> ---
> 
> Notes:
>     - Clarify -S description in man page.
>     - Do not store a reference to salt_list entry, as it
>       could be reallocated causing a use-after-free.
>     - Only parse the salts of the path arguments if no
>       salt was explicitly specified.
> 
>  misc/e4crypt.8.in |  4 +++-
>  misc/e4crypt.c    | 18 ++++++++++++++----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/misc/e4crypt.8.in b/misc/e4crypt.8.in
> index 75b968a0..fe9372cf 100644
> --- a/misc/e4crypt.8.in
> +++ b/misc/e4crypt.8.in
> @@ -48,7 +48,9 @@ values are 4, 8, 16, and 32.
>  If one or more directory paths are specified, e4crypt will try to
>  set the policy of those directories to use the key just added by the
>  .B add_key
> -command.
> +command.  If a salt was explicitly specified, then it will be used
> +to derive the encryption key of those directories.  Otherwise a
> +directory-specific default salt will be used.
>  .TP
>  .B e4crypt get_policy \fIpath\fR ...
>  Print the policy for the directories specified on the command line.
> diff --git a/misc/e4crypt.c b/misc/e4crypt.c
> index 2ae6254a..67d25d88 100644
> --- a/misc/e4crypt.c
> +++ b/misc/e4crypt.c
> @@ -26,6 +26,7 @@
>  #include <getopt.h>
>  #include <dirent.h>
>  #include <errno.h>
> +#include <stdbool.h>

I'd like to use <stdbool.h> too, but I'm not sure if it's allowed in e2fsprogs;
this would be the first use.  Everywhere else seems to just use int, 0, and 1.
Ted, is stdbool.h allowed in e2fsprogs?

> +	if (!explicit_salt)
> +		for (i = optind; i < argc; i++)
> +			parse_salt(argv[i], PARSE_FLAGS_FORCE_FN);

There should be braces at the outer level (following Linux kernel coding style):

	if (!explicit_salt) {
		for (i = optind; i < argc; i++)
			parse_salt(argv[i], PARSE_FLAGS_FORCE_FN);
	}


Otherwise this patch looks fine.

Hopefully people aren't depending on this bug being present.

- Eric
