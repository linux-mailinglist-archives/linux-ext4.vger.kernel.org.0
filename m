Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BCB217A98
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jul 2020 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGGVkv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jul 2020 17:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgGGVkv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 7 Jul 2020 17:40:51 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8A8E206C3;
        Tue,  7 Jul 2020 21:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594158051;
        bh=vxv5qBPVuy9ahyBiVFV0ubwCh9vE0K1so/fgKi2bNpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iOXPHanlrH3Mpti8/g1vHm1fc5rBxiE3bhsAHMgkplD0NDku6SVe4y08hWX4IQhN0
         XIKwTsna5dsR4tJwDU4+qiXJxvE7pOAITHxqxDZpkqX7/qNkoxjM3yHfqx0iy8vJBh
         KLUNovlLwY+ynjUMlih1jX8JIUEv414C9e6Hiqc4=
Date:   Tue, 7 Jul 2020 14:40:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Florian Schmaus <flo@geekplace.eu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] e4crypt: if salt is explicitly provided to add_key,
 then use it
Message-ID: <20200707214049.GC3426938@gmail.com>
References: <20200706194727.12979-1-flo@geekplace.eu>
 <20200706215719.GA827691@gmail.com>
 <16765dd5-3686-6083-7f9b-261b51953d32@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16765dd5-3686-6083-7f9b-261b51953d32@geekplace.eu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 07, 2020 at 10:36:12AM +0200, Florian Schmaus wrote:
> On 7/6/20 11:57 PM, Eric Biggers wrote:
> > On Mon, Jul 06, 2020 at 09:47:25PM +0200, Florian Schmaus wrote:
> >> Providing -S and a path to 'add_key' previously exhibit an unintuitive
> >> behavior: instead of using the salt explicitly provided by the user,
> >> e4crypt would use the salt obtained via EXT4_IOC_GET_ENCRYPTION_PWSALT
> >> on the path. This was because set_policy() was still called with NULL
> >> as salt.
> >>
> >> With this change we now remember the explicitly provided salt (if any)
> >> and use it as argument for set_policy().
> >>
> >> Eventually
> >>
> >> e4crypt add_key -S s:my-spicy-salt /foo
> >>
> >> will now actually use 'my-spicy-salt' and not something else as salt
> >> for the policy set on /foo.
> >>
> >> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> > 
> > Thanks for these patches for e4crypt.
> 
> Thanks for your feedback.
> 
> 
> > Note that e4crypt is in maintenance mode, and it hasn't been updated to follow
> > recommended security practices (e.g. using Argon2), to support the new
> > encryption API which fixes a lot of problems with the original one, or to
> > support the other filesystems that share the same encryption API.
> > 
> > Instead you should use the 'fscrypt' tool: https://github.com/google/fscrypt
> > 
> > What is your use case for still using e4crypt?
> 
> This sounds like 'fsscrypt' is an alternative to e4crypt. If so, then I
> guess I have no use case for e4crypt, but simply use it because it is
> available. Sadly there is no fscrypt package for my distribution
> (Gentoo) available. Guess I have to look into that. :)
> 
> Besides that, my use case is to have a e4crytped directory accessible
> after PAM authentication. For that I recently looked into pam_e4crypt
> [1]. In fact, pam_e4crypt's README mentions fscrypt. But the small size
> of pam_e4crypt made it look more appealing to me than fscrypt.
> 

'fscrypt' comes with a PAM module pam_fscrypt which auto-unlocks directories at
login as well.

See the README (https://github.com/google/fscrypt/blob/master/README.md) and
also the Arch Linux Wiki article (https://wiki.archlinux.org/index.php/Fscrypt).

Can you get it packaged for Gentoo?

I don't have time to work on multiple redundant tools, so I've been focusing on
improving 'fscrypt'.

> > And why do you want to explicitly specify a salt?
> 
> For some reason pam_e4crypt removed support for the
> EXT4_IOC_GET_ENCRYPTION_PWSALT ioctl and only supports a file as source
> for the salt. It took me a while to figure out that
> 
> e4crypt add_key -S s:my-spicy-salt /foo
> 
> would not use 'my-spicy-salt' for /foo. This is an attempt to fix that.
> 

I'm guessing the developer of pam_e4crypt did that because pam_e4crypt doesn't
know on what filesystem(s) the encrypted directories are located when it unlocks
them.  Note that that design only works with the deprecated encryption API, not
the new one in Linux v5.4+ that's recommended and 'fscrypt' uses by default.

'fscrypt' works a bit differently; it stores metadata files (policies and
protectors) in the ".fscrypt" directory at the root of each filesystem.
Passphrase protectors have a random salt generated and stored along with them.
So there's no need for users to explicitly specify a salt.

> > Moreover it appears the above code should just be removed, since
> > get_default_salts() already handles adding salts for all ext4 filesystems.
> 
> I think only for the ones declared in /etc/mtab? Hence for filesystems
> that are not in mtab it appears sensible to keep the code.

/etc/mtab is supposed to list all mounted filesystems.  Traditionally it could
become outdated, but now it's usually linked to /proc/mounts which is populated
by the kernel and thus is never outdated.

- Eric
