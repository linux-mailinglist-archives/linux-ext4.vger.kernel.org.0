Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B4E5806EB
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Jul 2022 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiGYVtN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Jul 2022 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGYVtM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Jul 2022 17:49:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B17721E15
        for <linux-ext4@vger.kernel.org>; Mon, 25 Jul 2022 14:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40BC4B8112D
        for <linux-ext4@vger.kernel.org>; Mon, 25 Jul 2022 21:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B26C341C6;
        Mon, 25 Jul 2022 21:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658785748;
        bh=2r5SilhtOnCqVZ96ClvpcjrJbBlPCZd0aKNu7qOn3fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W87xeuuAOXsF35Qyvjf6oMPj04mLKDET2/avMIaJGjX85AgzuheJp2aQjiOY7zNhc
         ccJ5Sde24b0jlKY2B2UrcBCv2Jri3EKir+iYq4t7q0Msla1g1yJI8a/2KNCvkGeLyQ
         YSzrZut5JJELNEAcxcgwCCAR77z7M0/2+E1qsuUy/UsBGsqnTRQ64QtHNOtcUqy/5V
         SrAQ41z4ob5RzXJlwsLNX1K69DhDD67kLiWm7mOFfV7SPQ0bzLk/lils3DOgzTFkYE
         2WmrTdpoXv/h0Nm3Kf4/15ynP1pq0gFv7HcpyK0krcHQJOzH3PwGnA1jiA8SrUxH4Q
         ntgjSXeyNq7EQ==
Date:   Mon, 25 Jul 2022 14:49:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ext4: unconditionally enable the i_version counter
Message-ID: <Yt8P1HmV//iX9XWC@magnolia>
References: <20220725192946.330619-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725192946.330619-1-jlayton@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 25, 2022 at 03:29:46PM -0400, Jeff Layton wrote:
> The original i_version implementation was pretty expensive, requiring a
> log flush on every change. Because of this, it was gated behind a mount
> option (implemented via the MS_I_VERSION mountoption flag).
> 
> Commit ae5e165d855d (fs: new API for handling inode->i_version) made the
> i_version flag much less expensive, so there is no longer a performance
> penalty from enabling it.
> 
> Have ext4 ignore the SB_I_VERSION flag, and just enable it
> unconditionally.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Lukas Czerner <lczerner@redhat.com>
> Cc: Benjamin Coddington <bcodding@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ext4/inode.c | 5 ++---
>  fs/ext4/super.c | 8 ++++----
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 84c0eb55071d..c785c0b72116 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5411,7 +5411,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  			return -EINVAL;
>  		}
>  
> -		if (IS_I_VERSION(inode) && attr->ia_size != inode->i_size)
> +		if (attr->ia_size != inode->i_size)
>  			inode_inc_iversion(inode);
>  
>  		if (shrink) {
> @@ -5717,8 +5717,7 @@ int ext4_mark_iloc_dirty(handle_t *handle,
>  	}
>  	ext4_fc_track_inode(handle, inode);
>  
> -	if (IS_I_VERSION(inode))
> -		inode_inc_iversion(inode);
> +	inode_inc_iversion(inode);
>  
>  	/* the do_update_inode consumes one bh->b_count */
>  	get_bh(iloc->bh);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 845f2f8aee5f..30645d4343b6 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2142,8 +2142,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		return 0;
>  	case Opt_i_version:
>  		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "5.20");

Perhaps it's time to kill off Opt_i_version, since we're now at 5.20?

(For that matter, noacl/nouser_xattr were supposed to be gone by 3.5 and
they're clearly still there, so either they ought to go as well?)

--D

> -		ext4_msg(NULL, KERN_WARNING, "Use iversion instead\n");
> -		ctx_set_flags(ctx, SB_I_VERSION);
> +		ext4_msg(NULL, KERN_WARNING, "i_version counter is always enabled.\n");
>  		return 0;
>  	case Opt_inlinecrypt:
>  #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
> @@ -2970,8 +2969,6 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  		SEQ_OPTS_PRINT("min_batch_time=%u", sbi->s_min_batch_time);
>  	if (nodefs || sbi->s_max_batch_time != EXT4_DEF_MAX_BATCH_TIME)
>  		SEQ_OPTS_PRINT("max_batch_time=%u", sbi->s_max_batch_time);
> -	if (sb->s_flags & SB_I_VERSION)
> -		SEQ_OPTS_PUTS("i_version");
>  	if (nodefs || sbi->s_stripe)
>  		SEQ_OPTS_PRINT("stripe=%lu", sbi->s_stripe);
>  	if (nodefs || EXT4_MOUNT_DATA_FLAGS &
> @@ -4630,6 +4627,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
>  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
>  
> +	/* i_version is always enabled now */
> +	sb->s_flags |= SB_I_VERSION;
> +
>  	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV &&
>  	    (ext4_has_compat_features(sb) ||
>  	     ext4_has_ro_compat_features(sb) ||
> -- 
> 2.37.1
> 
