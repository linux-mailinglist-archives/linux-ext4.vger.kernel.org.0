Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ED24A7621
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiBBQma (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 11:42:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60906 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiBBQm3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Feb 2022 11:42:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 188E31F44775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643820148;
        bh=ePKsvf8LYF6sWzqMH2gZiIQaddlDXUl8cTU9BukJsMc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KA3MwDjCh2MN3wV8W9Xmkg+8EernrJXvAtSQAekoYk99MU7sGDn0cgj3kgdKcVt7q
         2JPCVVsLWo1oM7rwOOngVuZDkdd/eu1tt0qYmsEZz9M9r795qB+EGcYAwAXP+FcuY2
         E4zQIxAILmtVVWovdUSHTOULxIEMCzJ7efSccdUzKad7ERYPrVKbtD99mtn0T9vw46
         qgRYyD7SqSnyz84zft9FjLJaOBv/cQxKqseQ0T7I3M7Jk+fChUNN7OWa8eIYogvjmX
         kY1MD1x3uBkgHCRbW5OA0rTmmJp9cRQee6lT7tO79OHpSWMGYmCH9+ad46dD8GXEYq
         MHhhLNWYOo6rw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] ext4: fix remount with 'abort' option
Organization: Collabora
References: <YcSYvk5DdGjjB9q/@mit.edu>
        <20220201131345.77591-1-lczerner@redhat.com>
Date:   Wed, 02 Feb 2022 11:42:24 -0500
In-Reply-To: <20220201131345.77591-1-lczerner@redhat.com> (Lukas Czerner's
        message of "Tue, 1 Feb 2022 14:13:45 +0100")
Message-ID: <87a6f9gqz3.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Lukas Czerner <lczerner@redhat.com> writes:

> After commit 6e47a3cc68fc ("ext4: get rid of super block and sbi from
> handle_mount_ops()") the 'abort' options stopped working. This is
> because we're using ctx_set_mount_flags() helper that's expecting an
> argument with the appropriate bit set, but instead got
> EXT4_MF_FS_ABORTED which is a bit position. ext4_set_mount_flag() is
> using set_bit() while ctx_set_mount_flags() was using bitwise OR.
>
> Create a separate helper ctx_set_mount_flag() to handle setting the
> mount_flags correctly.
>
> While we're at it clean up the EXT4_SET_CTX macros so that we're only
> creating helpers that we actually use to avoid warnings.
>
> Fixes: 6e47a3cc68fc ("ext4: get rid of super block and sbi from handle_mount_ops()")
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Cc: Ye Bin <yebin10@huawei.com>

We also observed this abort issue as a regression of an fanotify LTP
test (fanotify22).  This patch fixes that test case for me.

Tested-by: Gabriel Krisman Bertazi <krisman@collabora.com>

> ---
>  fs/ext4/super.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index eee0d9ebfa6c..6f74cd51df2e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2045,8 +2045,8 @@ struct ext4_fs_context {
>  	unsigned int	mask_s_mount_opt;
>  	unsigned int	vals_s_mount_opt2;
>  	unsigned int	mask_s_mount_opt2;
> -	unsigned int	vals_s_mount_flags;
> -	unsigned int	mask_s_mount_flags;
> +	unsigned long	vals_s_mount_flags;
> +	unsigned long	mask_s_mount_flags;
>  	unsigned int	opt_flags;	/* MOPT flags */
>  	unsigned int	spec;
>  	u32		s_max_batch_time;
> @@ -2149,23 +2149,36 @@ static inline void ctx_set_##name(struct ext4_fs_context *ctx,		\
>  {									\
>  	ctx->mask_s_##name |= flag;					\
>  	ctx->vals_s_##name |= flag;					\
> -}									\
> +}
> +
> +#define EXT4_CLEAR_CTX(name)						\
>  static inline void ctx_clear_##name(struct ext4_fs_context *ctx,	\
>  				    unsigned long flag)			\
>  {									\
>  	ctx->mask_s_##name |= flag;					\
>  	ctx->vals_s_##name &= ~flag;					\
> -}									\
> +}
> +
> +#define EXT4_TEST_CTX(name)						\
>  static inline unsigned long						\
>  ctx_test_##name(struct ext4_fs_context *ctx, unsigned long flag)	\
>  {									\
>  	return (ctx->vals_s_##name & flag);				\
> -}									\
> +}
>  
> -EXT4_SET_CTX(flags);
> +EXT4_SET_CTX(flags); /* set only */
>  EXT4_SET_CTX(mount_opt);
> +EXT4_CLEAR_CTX(mount_opt);
> +EXT4_TEST_CTX(mount_opt);
>  EXT4_SET_CTX(mount_opt2);
> -EXT4_SET_CTX(mount_flags);
> +EXT4_CLEAR_CTX(mount_opt2);
> +EXT4_TEST_CTX(mount_opt2);
> +
> +static inline void ctx_set_mount_flag(struct ext4_fs_context *ctx, int bit)
> +{
> +	set_bit(bit, &ctx->mask_s_mount_flags);
> +	set_bit(bit, &ctx->vals_s_mount_flags);
> +}
>  
>  static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
> @@ -2235,7 +2248,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  			 param->key);
>  		return 0;
>  	case Opt_abort:
> -		ctx_set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
> +		ctx_set_mount_flag(ctx, EXT4_MF_FS_ABORTED);
>  		return 0;
>  	case Opt_i_version:
>  		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "5.20");

-- 
Gabriel Krisman Bertazi
