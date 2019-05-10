Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A221A382
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2019 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfEJTvA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 May 2019 15:51:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47015 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727769AbfEJTvA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 May 2019 15:51:00 -0400
Received: from callcc.thunk.org (75-104-86-93.mobility.exede.net [75.104.86.93] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4AJocBM011808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 May 2019 15:50:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BD1CB420024; Fri, 10 May 2019 15:50:37 -0400 (EDT)
Date:   Fri, 10 May 2019 15:50:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Denys Vlasenko <dvlasenk@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fix "fsck -A" failure on a completely clean fs
Message-ID: <20190510195037.GA2534@mit.edu>
References: <1462601e-eca2-0270-075b-4738e4cebfed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462601e-eca2-0270-075b-4738e4cebfed@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've replied on the bug:

	https://bugzilla.redhat.com/show_bug.cgi?id=1702342#c9

TL;DR: NACK

In theory you might be able to patch up e2fsck so that fsck -A
actually would work for ext[234].  It is not obvious to me that it
will work for other file systems, however --- due to some very subtle
issues such as the ones I pointed out in my reply.

Cheers,

					- Ted


On Fri, May 10, 2019 at 04:19:47PM +0200, Denys Vlasenko wrote:
> Before remounting root fs and mounting local filesystems
> in /etc/fstab, my boot scripts check them for errors with:
> 
> if ! fsck -A; then
>         echo "fsck exit code: $?. Boot will not continue."
>         while true; do sleep 9999; done
> fi
> mount -o remount,rw /
> mount -a
> 
> Looks like something very straightforward, right?
> 
> I have two filesystems in /etc/fstab:
> /dev/sda2 /                       ext4    defaults        1 1
> /dev/sda1 /boot                   ext4    defaults        1 2
> 
> If I use fsck from util-linux-2.33.2-1.fc31.x86_64 (IOW: rather recent code),
> it starts two instances of fsck.ext4 (all is fine with it).
> 
> The second one's stdio is redirected (probably to /dev/null),
> it is no longer the tty. (Which is fine too).
> 
> But now we hit a problem. Second fsck.ext4 flat out refuses to do its job,
> even before it looks at the filesystem.
> 
> Therefore, this condition does not trigger:
>         if (getenv("E2FSCK_FORCE_INTERACTIVE") || (isatty(0) && isatty(1))) {
>                 ctx->interactive = 1;
>         }
> and ctx->interactive stays 0.
> Therefore, later in main() fsck.ext4 dies with this message:
>         if (!(ctx->options & E2F_OPT_PREEN) &&
>             !(ctx->options & E2F_OPT_NO) &&
>             !(ctx->options & E2F_OPT_YES)) {
>                 if (!ctx->interactive)
>                         fatal_error(ctx,
>                                     _("need terminal for interactive repairs"));
>         }
> 
> This happens BEFORE any repairs are deemed necessary, IOW: it happens ALWAYS,
> even if filesystem is completely fine.
> 
> IOW: "fsck -A" is *completely unusable* in this scenario.
> I believe this is wrong. It is intended to be the generic, fs-agnostic way
> to run fsck's on all /etc/fstab filesystems.
> 
> I propose to change the code so that this abort happens only if we
> indeed need to interactively ask something.
> 
> Tested patch attached.
> 
> Fedora BZ: https://bugzilla.redhat.com/show_bug.cgi?id=1702342
> 

> diff -uprN e2fsprogs-1.44.4.orig/e2fsck/unix.c e2fsprogs-1.44.4/e2fsck/unix.c
> --- e2fsprogs-1.44.4.orig/e2fsck/unix.c	2018-08-19 04:26:58.000000000 +0200
> +++ e2fsprogs-1.44.4/e2fsck/unix.c	2019-04-23 15:38:55.890507270 +0200
> @@ -1439,13 +1439,6 @@ int main (int argc, char *argv[])
>  
>  	check_mount(ctx);
>  
> -	if (!(ctx->options & E2F_OPT_PREEN) &&
> -	    !(ctx->options & E2F_OPT_NO) &&
> -	    !(ctx->options & E2F_OPT_YES)) {
> -		if (!ctx->interactive)
> -			fatal_error(ctx,
> -				    _("need terminal for interactive repairs"));
> -	}
>  	ctx->superblock = ctx->use_superblock;
>  
>  	flags = EXT2_FLAG_SKIP_MMP;
> diff -uprN e2fsprogs-1.44.4.orig/e2fsck/util.c e2fsprogs-1.44.4/e2fsck/util.c
> --- e2fsprogs-1.44.4.orig/e2fsck/util.c	2018-08-19 04:26:58.000000000 +0200
> +++ e2fsprogs-1.44.4/e2fsck/util.c	2019-04-23 15:39:27.571448855 +0200
> @@ -203,6 +203,14 @@ int ask_yn(e2fsck_t ctx, const char * st
>  	const char	*extra_prompt = "";
>  	static int	yes_answers;
>  
> +	if (!(ctx->options & E2F_OPT_PREEN) &&
> +	    !(ctx->options & E2F_OPT_NO) &&
> +	    !(ctx->options & E2F_OPT_YES)) {
> +		if (!ctx->interactive)
> +			fatal_error(ctx,
> +				    _("need terminal for interactive repairs"));
> +	}
> +
>  #ifdef HAVE_TERMIOS_H
>  	struct termios	termios, tmp;
>  

