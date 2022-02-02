Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D134A786B
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 20:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346833AbiBBTAl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 14:00:41 -0500
Received: from sandeen.net ([63.231.237.45]:35998 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231486AbiBBTAj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 2 Feb 2022 14:00:39 -0500
Received: from [10.0.0.147] (liberator.sandeen.net [10.0.0.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 2E04C78D1;
        Wed,  2 Feb 2022 13:00:18 -0600 (CST)
Message-ID: <789e83e5-c346-86de-3c62-f4fcf35a2bf0@sandeen.net>
Date:   Wed, 2 Feb 2022 13:00:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Content-Language: en-US
To:     Lukas Czerner <lczerner@redhat.com>, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Ye Bin <yebin10@huawei.com>
References: <YcSYvk5DdGjjB9q/@mit.edu>
 <20220201131345.77591-1-lczerner@redhat.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH] ext4: fix remount with 'abort' option
In-Reply-To: <20220201131345.77591-1-lczerner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2/1/22 7:13 AM, Lukas Czerner wrote:
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

ok thinking out loud here - reducing this to the functional change that
fixes the bug, (apologies for the surely-mangled whitespace, I'm being lazy),
it looks something like:

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index eee0d9ebfa6c..a3047b033053 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2045,8 +2045,8 @@ struct ext4_fs_context {
        unsigned int    mask_s_mount_opt;
        unsigned int    vals_s_mount_opt2;
        unsigned int    mask_s_mount_opt2;
-       unsigned int    vals_s_mount_flags;
-       unsigned int    mask_s_mount_flags;
+       unsigned long   vals_s_mount_flags;
+       unsigned long   mask_s_mount_flags;
        unsigned int    opt_flags;      /* MOPT flags */
        unsigned int    spec;
        u32             s_max_batch_time;
@@ -2165,7 +2165,13 @@ ctx_test_##name(struct ext4_fs_context *ctx, unsigned long flag) \
 EXT4_SET_CTX(flags);
 EXT4_SET_CTX(mount_opt);
 EXT4_SET_CTX(mount_opt2);
-EXT4_SET_CTX(mount_flags);
+
+/* Setting the mount_flags field is special, it takes a bit number */
+static inline void ctx_set_mount_flag(struct ext4_fs_context *ctx, int bit)
+{
+       set_bit(bit, &ctx->mask_s_mount_flags);
+       set_bit(bit, &ctx->vals_s_mount_flags);
+}
 
 static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
@@ -2235,7 +2241,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
                         param->key);
                return 0;
        case Opt_abort:
-               ctx_set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
+               ctx_set_mount_flag(ctx, EXT4_MF_FS_ABORTED);
                return 0;
        case Opt_i_version:
                ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "5.20");

and that makes sense to me. I wonder if there's any further cleanup that could
make it slightly more clear or foolproof re: which flag matches which ctx_set_*
generated function, so the wrong thing doesn't get sent to the wrong routine,
but that's a different issue, so for the patch as you sent it,

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

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
