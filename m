Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786F7580C2F
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jul 2022 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiGZHKO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jul 2022 03:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiGZHKN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Jul 2022 03:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08AE3633D
        for <linux-ext4@vger.kernel.org>; Tue, 26 Jul 2022 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658819411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=226qxGSdTyQX8oveGplVYgHtXY3D1woFH/uKdQeS3vk=;
        b=W3pbiUOaPT4mN1tn7SVXuhF29G4DhgTg43pccuc32efDX5Ma4k7gaeX8wxW9vIyfddgkVN
        Gk/Y6OQBSc4QmWAN2SMsxv5aHXzaSwzPNl82HcQFgE8K5gM66irwo9Kc1NMLLZMX+TTtsd
        PTHs2Jzr2nz9ABRVA4xw/Dm+9fkV0no=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-F12_VtI7OjuCEv7o0ch-_A-1; Tue, 26 Jul 2022 03:10:05 -0400
X-MC-Unique: F12_VtI7OjuCEv7o0ch-_A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F26483816850;
        Tue, 26 Jul 2022 07:10:04 +0000 (UTC)
Received: from fedora (unknown [10.40.192.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1C5B492CA2;
        Tue, 26 Jul 2022 07:10:03 +0000 (UTC)
Date:   Tue, 26 Jul 2022 09:10:01 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, kzak@redhat.com
Subject: Re: [PATCH] ext4: unconditionally enable the i_version counter
Message-ID: <20220726071001.j3ox56jjuzltrsrg@fedora>
References: <20220725192946.330619-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725192946.330619-1-jlayton@kernel.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Hi Jeff,

the ext4 specific i_version option is deprecated and it's perfect time
to remove it as well.

As for enabling iversion by default, as I said before I am fine with
that. With this patch we're left with no means of disabling it, which
might be ok, I don't have a strong opinion.

However I don't like the fact that the noiversion mount option is going
to be just silently ignored and only on some file systems. The
inconsistency bugs me and will create confusion when things go wrong.

Shouldn't we introduce something like SB_NOIVERSION to give fs a clean
way to inform user we're ignoring it, or even change the default? Or
perhaps 'noinversion' should be removed?

-Lukas

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

