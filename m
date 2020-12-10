Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A0F2D691E
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 21:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390474AbgLJUuB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 15:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404508AbgLJUtp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 15:49:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EC8C0613CF
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 12:49:04 -0800 (PST)
Received: from localhost (unknown [IPv6:2804:14c:132:242d::1000])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 11F221F448A4;
        Thu, 10 Dec 2020 20:49:02 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     linux-ext4@vger.kernel.org, drosen@google.com, ebiggers@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH RESEND v2 10/12] e2fsck: Add option to force encoded
 filename verification
Organization: Collabora
References: <20201210150353.91843-1-arnaud.ferraris@collabora.com>
        <20201210150353.91843-11-arnaud.ferraris@collabora.com>
Date:   Thu, 10 Dec 2020 17:48:57 -0300
In-Reply-To: <20201210150353.91843-11-arnaud.ferraris@collabora.com> (Arnaud
        Ferraris's message of "Thu, 10 Dec 2020 16:03:51 +0100")
Message-ID: <877dpp2xqe.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Arnaud Ferraris <arnaud.ferraris@collabora.com> writes:

> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> This is interesting for !strict filesystems as part of the encoding
> update procedure. Once the filesystem is known to not have badly encoded
> filenames, the update is trivial, thanks to the stability of assigned
> code points in the unicode specification.

Ted,

I thought of this after your comment on LSFMM 2019 that strict mode
made the update of the unicode version trivial.  I think this patch is a
dependency for ext4 to support a newer unicode version, which I'd like
to support in the near feature, such that we don't lag too much behind
the Unicode specification.

>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  e2fsck/e2fsck.h | 1 +
>  e2fsck/pass2.c  | 5 +++--
>  e2fsck/unix.c   | 4 ++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
> index dcaab0a1..f324e92c 100644
> --- a/e2fsck/e2fsck.h
> +++ b/e2fsck/e2fsck.h
> @@ -177,6 +177,7 @@ struct resource_track {
>  #define E2F_OPT_ICOUNT_FULLMAP	0x20000 /* use an array for inode counts */
>  #define E2F_OPT_UNSHARE_BLOCKS  0x40000
>  #define E2F_OPT_CLEAR_UNINIT	0x80000 /* Hack to clear the uninit bit */
> +#define E2F_OPT_CHECK_ENCODING  0x100000 /* Force verification of encoded filenames */
>  
>  /*
>   * E2fsck flags
> diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
> index b6514de8..f93e2b53 100644
> --- a/e2fsck/pass2.c
> +++ b/e2fsck/pass2.c
> @@ -1049,9 +1049,10 @@ static int check_dir_block(ext2_filsys fs,
>  	ctx = cd->ctx;
>  
>  	/* We only want filename encoding verification on strict
> -	 * mode. */
> +	 * mode or if explicitly requested by user. */
>  	if (ext2fs_test_inode_bitmap2(ctx->inode_casefold_map, ino) &&
> -	    (ctx->fs->super->s_encoding_flags & EXT4_ENC_STRICT_MODE_FL))
> +	    ((ctx->fs->super->s_encoding_flags & EXT4_ENC_STRICT_MODE_FL) ||
> +	     (ctx->options & E2F_OPT_CHECK_ENCODING)))
>  		cf_dir = 1;
>  
>  	if (ctx->flags & E2F_FLAG_RUN_RETURN)
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index 1cb51672..0a9012e5 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -753,6 +753,9 @@ static void parse_extended_opts(e2fsck_t ctx, const char *opts)
>  			ctx->options |= E2F_OPT_UNSHARE_BLOCKS;
>  			ctx->options |= E2F_OPT_FORCE;
>  			continue;
> +		} else if (strcmp(token, "check_encoding") == 0) {
> +			ctx->options |= E2F_OPT_CHECK_ENCODING;
> +			continue;
>  #ifdef CONFIG_DEVELOPER_FEATURES
>  		} else if (strcmp(token, "clear_all_uninit_bits") == 0) {
>  			ctx->options |= E2F_OPT_CLEAR_UNINIT;
> @@ -784,6 +787,7 @@ static void parse_extended_opts(e2fsck_t ctx, const char *opts)
>  		fputs("\tbmap2extent\n", stderr);
>  		fputs("\tunshare_blocks\n", stderr);
>  		fputs("\tfixes_only\n", stderr);
> +		fputs("\tcheck_encoding\n", stderr);
>  		fputc('\n', stderr);
>  		exit(1);
>  	}

-- 
Gabriel Krisman Bertazi
