Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE005A7C92
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 13:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiHaLzV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 07:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHaLzU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 07:55:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1D356B90
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 04:55:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3590F221A7;
        Wed, 31 Aug 2022 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661946918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=al+XQ4Uhr0acH16Z0fhyPG7udGAHWRVX4OQNHySj/z4=;
        b=wURahL19Lu6k7ooOQI4p2PCWsc6c266NYOOKuJCJbFCF8HbHbBGDUapduUMlplQ3oAekoT
        dsdd2fhtAIlVRVXukwjnz6DfO+I+xw4VZLrUhvQVrCT5ncN9zX3f1pdbVEwzeqGlmUlDRU
        l1l2dDM9Y/zYBsqjciEo57W2omlXBD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661946918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=al+XQ4Uhr0acH16Z0fhyPG7udGAHWRVX4OQNHySj/z4=;
        b=cIBAn3SS8oIVRcE4eTv1pTPqm+AKbMnQgWN695xb26CllI5pqporDrJY11QEcM+XTesDA9
        4oqnD9N84b0V9vDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21F211332D;
        Wed, 31 Aug 2022 11:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mLxICCZMD2OJCwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:55:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 98C5FA067B; Wed, 31 Aug 2022 13:55:17 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:55:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 09/13] ext4: factor out ext4_compat_feature_check()
Message-ID: <20220831115517.qolsk27xh5djei7h@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-10-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-10-yanaijie@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:07, Jason Yan wrote:
> Factor out ext4_compat_feature_check(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  fs/ext4/super.c | 144 ++++++++++++++++++++++++++----------------------
>  1 file changed, 77 insertions(+), 67 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 96cf23787bba..1e7d6eb6a3aa 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4607,6 +4607,82 @@ static int ext4_handle_csum(struct super_block *sb, struct ext4_super_block *es)
>  	return 0;
>  }
>  
> +static int ext4_compat_feature_check(struct super_block *sb,
> +				     struct ext4_super_block *es,
> +				     int silent)

And here maybe ext4_check_feature_compatibility() might be a better name
because "compat_feature" is a name of a specific subset of ext4 features so
using it in function name is a bit confusing. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> +{
> +	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV &&
> +	    (ext4_has_compat_features(sb) ||
> +	     ext4_has_ro_compat_features(sb) ||
> +	     ext4_has_incompat_features(sb)))
> +		ext4_msg(sb, KERN_WARNING,
> +		       "feature flags set on rev 0 fs, "
> +		       "running e2fsck is recommended");
> +
> +	if (es->s_creator_os == cpu_to_le32(EXT4_OS_HURD)) {
> +		set_opt2(sb, HURD_COMPAT);
> +		if (ext4_has_feature_64bit(sb)) {
> +			ext4_msg(sb, KERN_ERR,
> +				 "The Hurd can't support 64-bit file systems");
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * ea_inode feature uses l_i_version field which is not
> +		 * available in HURD_COMPAT mode.
> +		 */
> +		if (ext4_has_feature_ea_inode(sb)) {
> +			ext4_msg(sb, KERN_ERR,
> +				 "ea_inode feature is not supported for Hurd");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (IS_EXT2_SB(sb)) {
> +		if (ext2_feature_set_ok(sb))
> +			ext4_msg(sb, KERN_INFO, "mounting ext2 file system "
> +				 "using the ext4 subsystem");
> +		else {
> +			/*
> +			 * If we're probing be silent, if this looks like
> +			 * it's actually an ext[34] filesystem.
> +			 */
> +			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
> +				return -EINVAL;
> +			ext4_msg(sb, KERN_ERR, "couldn't mount as ext2 due "
> +				 "to feature incompatibilities");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (IS_EXT3_SB(sb)) {
> +		if (ext3_feature_set_ok(sb))
> +			ext4_msg(sb, KERN_INFO, "mounting ext3 file system "
> +				 "using the ext4 subsystem");
> +		else {
> +			/*
> +			 * If we're probing be silent, if this looks like
> +			 * it's actually an ext4 filesystem.
> +			 */
> +			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
> +				return -EINVAL;
> +			ext4_msg(sb, KERN_ERR, "couldn't mount as ext3 due "
> +				 "to feature incompatibilities");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/*
> +	 * Check feature flags regardless of the revision level, since we
> +	 * previously didn't change the revision level when setting the flags,
> +	 * so there is a chance incompat flags are set on a rev 0 filesystem.
> +	 */
> +	if (!ext4_feature_set_ok(sb, (sb_rdonly(sb))))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct buffer_head *bh, **group_desc;
> @@ -4761,73 +4837,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
>  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
>  
> -	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV &&
> -	    (ext4_has_compat_features(sb) ||
> -	     ext4_has_ro_compat_features(sb) ||
> -	     ext4_has_incompat_features(sb)))
> -		ext4_msg(sb, KERN_WARNING,
> -		       "feature flags set on rev 0 fs, "
> -		       "running e2fsck is recommended");
> -
> -	if (es->s_creator_os == cpu_to_le32(EXT4_OS_HURD)) {
> -		set_opt2(sb, HURD_COMPAT);
> -		if (ext4_has_feature_64bit(sb)) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "The Hurd can't support 64-bit file systems");
> -			goto failed_mount;
> -		}
> -
> -		/*
> -		 * ea_inode feature uses l_i_version field which is not
> -		 * available in HURD_COMPAT mode.
> -		 */
> -		if (ext4_has_feature_ea_inode(sb)) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "ea_inode feature is not supported for Hurd");
> -			goto failed_mount;
> -		}
> -	}
> -
> -	if (IS_EXT2_SB(sb)) {
> -		if (ext2_feature_set_ok(sb))
> -			ext4_msg(sb, KERN_INFO, "mounting ext2 file system "
> -				 "using the ext4 subsystem");
> -		else {
> -			/*
> -			 * If we're probing be silent, if this looks like
> -			 * it's actually an ext[34] filesystem.
> -			 */
> -			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
> -				goto failed_mount;
> -			ext4_msg(sb, KERN_ERR, "couldn't mount as ext2 due "
> -				 "to feature incompatibilities");
> -			goto failed_mount;
> -		}
> -	}
> -
> -	if (IS_EXT3_SB(sb)) {
> -		if (ext3_feature_set_ok(sb))
> -			ext4_msg(sb, KERN_INFO, "mounting ext3 file system "
> -				 "using the ext4 subsystem");
> -		else {
> -			/*
> -			 * If we're probing be silent, if this looks like
> -			 * it's actually an ext4 filesystem.
> -			 */
> -			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
> -				goto failed_mount;
> -			ext4_msg(sb, KERN_ERR, "couldn't mount as ext3 due "
> -				 "to feature incompatibilities");
> -			goto failed_mount;
> -		}
> -	}
> -
> -	/*
> -	 * Check feature flags regardless of the revision level, since we
> -	 * previously didn't change the revision level when setting the flags,
> -	 * so there is a chance incompat flags are set on a rev 0 filesystem.
> -	 */
> -	if (!ext4_feature_set_ok(sb, (sb_rdonly(sb))))
> +	if (ext4_compat_feature_check(sb, es, silent))
>  		goto failed_mount;
>  
>  	if (le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) > (blocksize / 4)) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
