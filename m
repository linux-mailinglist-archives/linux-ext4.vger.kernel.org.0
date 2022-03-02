Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710A04CA10A
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Mar 2022 10:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbiCBJoa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Mar 2022 04:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240594AbiCBJoa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Mar 2022 04:44:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D174B532CE
        for <linux-ext4@vger.kernel.org>; Wed,  2 Mar 2022 01:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646214226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FvJpqgbeeAi35HuV3rEZPsIzdRu+U9/W534XXltt4NE=;
        b=SSKBTzZId6v0LdASwdJcFeCqP4mWUaldYlS1xqFam+PYEaSJHm9F1LXR5NS35u3HXnxMz7
        GM16WpbfP0aGk64DOntCUcqS0IC5hFZBGAVy3/MgQAqbKWLCGLgNwb7sWMZBXWW3/w0+CS
        GzLC52veo4pB8toCUL0+P9SVqxH824Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-7EAjVZiVPMS4t50nCbls1w-1; Wed, 02 Mar 2022 04:43:42 -0500
X-MC-Unique: 7EAjVZiVPMS4t50nCbls1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85EE21006AA6;
        Wed,  2 Mar 2022 09:43:41 +0000 (UTC)
Received: from work (unknown [10.40.194.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78EAA6EF69;
        Wed,  2 Mar 2022 09:43:40 +0000 (UTC)
Date:   Wed, 2 Mar 2022 10:43:37 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] ext4: fix remount with 'abort' option
Message-ID: <20220302094337.jv4d2vy4sldzbq6v@work>
References: <YcSYvk5DdGjjB9q/@mit.edu>
 <20220201131345.77591-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201131345.77591-1-lczerner@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

this problem is still generating warnings. Can you please take this in
when you have time?

Thanks!
-Lukas

On Tue, Feb 01, 2022 at 02:13:45PM +0100, Lukas Czerner wrote:
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
> -- 
> 2.31.1
> 

