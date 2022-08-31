Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88D75A7C60
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiHaLow (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 07:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHaLov (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 07:44:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAD5B8A
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 04:44:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E3711F93E;
        Wed, 31 Aug 2022 11:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661946285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ILEgnYHbG/Q8rpLK4rcK45k5X6pLQzkDlwa5HFw0vzk=;
        b=B3gP9vX6BV54iGgQWwRTciQy60W711cnpVE0Dyi572rrV8z+nAnq7HxkbGxdVnxFw6k0a8
        dpdpoDC0osbFILqrBH1+moTyJ8N/B6YNVamIgJl2OicGYx7e9HgPozXNAK2hU95brolDlU
        zxHtn44nU9JQ4pVb8kSxdPuZnJR7X0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661946285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ILEgnYHbG/Q8rpLK4rcK45k5X6pLQzkDlwa5HFw0vzk=;
        b=zzHWf5roK7iiEFbw39P/BKsRCKDeZX8TiQAXUP0M/xsOxYJaDGe4PkMwL/7vkQJtvqc2i7
        EsCJdDIkxfun3DCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76FEA1332D;
        Wed, 31 Aug 2022 11:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yWIJHa1JD2OBBgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:44:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0DD73A067B; Wed, 31 Aug 2022 13:44:45 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:44:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 03/13] ext4: factor out ext4_set_def_opts()
Message-ID: <20220831114445.pmgwqegrr75hw2rm@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-4-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-4-yanaijie@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:01, Jason Yan wrote:
> Factor out ext4_set_def_opts(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Yeah, nice factorization. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 105 ++++++++++++++++++++++++++----------------------
>  1 file changed, 56 insertions(+), 49 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7341340e3c98..66a128e5a9c8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4311,6 +4311,61 @@ static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
>  	return NULL;
>  }
>  
> +static void ext4_set_def_opts(struct super_block *sb,
> +			      struct ext4_super_block *es)
> +{
> +	unsigned long def_mount_opts;
> +
> +	/* Set defaults before we parse the mount options */
> +	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
> +	set_opt(sb, INIT_INODE_TABLE);
> +	if (def_mount_opts & EXT4_DEFM_DEBUG)
> +		set_opt(sb, DEBUG);
> +	if (def_mount_opts & EXT4_DEFM_BSDGROUPS)
> +		set_opt(sb, GRPID);
> +	if (def_mount_opts & EXT4_DEFM_UID16)
> +		set_opt(sb, NO_UID32);
> +	/* xattr user namespace & acls are now defaulted on */
> +	set_opt(sb, XATTR_USER);
> +#ifdef CONFIG_EXT4_FS_POSIX_ACL
> +	set_opt(sb, POSIX_ACL);
> +#endif
> +	if (ext4_has_feature_fast_commit(sb))
> +		set_opt2(sb, JOURNAL_FAST_COMMIT);
> +	/* don't forget to enable journal_csum when metadata_csum is enabled. */
> +	if (ext4_has_metadata_csum(sb))
> +		set_opt(sb, JOURNAL_CHECKSUM);
> +
> +	if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_DATA)
> +		set_opt(sb, JOURNAL_DATA);
> +	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_ORDERED)
> +		set_opt(sb, ORDERED_DATA);
> +	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_WBACK)
> +		set_opt(sb, WRITEBACK_DATA);
> +
> +	if (le16_to_cpu(es->s_errors) == EXT4_ERRORS_PANIC)
> +		set_opt(sb, ERRORS_PANIC);
> +	else if (le16_to_cpu(es->s_errors) == EXT4_ERRORS_CONTINUE)
> +		set_opt(sb, ERRORS_CONT);
> +	else
> +		set_opt(sb, ERRORS_RO);
> +	/* block_validity enabled by default; disable with noblock_validity */
> +	set_opt(sb, BLOCK_VALIDITY);
> +	if (def_mount_opts & EXT4_DEFM_DISCARD)
> +		set_opt(sb, DISCARD);
> +
> +	if ((def_mount_opts & EXT4_DEFM_NOBARRIER) == 0)
> +		set_opt(sb, BARRIER);
> +
> +	/*
> +	 * enable delayed allocation by default
> +	 * Use -o nodelalloc to turn it off
> +	 */
> +	if (!IS_EXT3_SB(sb) && !IS_EXT2_SB(sb) &&
> +	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
> +		set_opt(sb, DELALLOC);
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct buffer_head *bh, **group_desc;
> @@ -4320,7 +4375,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	ext4_fsblk_t block;
>  	ext4_fsblk_t logical_sb_block;
>  	unsigned long offset = 0;
> -	unsigned long def_mount_opts;
>  	struct inode *root;
>  	int ret = -ENOMEM;
>  	int blocksize, clustersize;
> @@ -4420,43 +4474,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		sbi->s_csum_seed = ext4_chksum(sbi, ~0, es->s_uuid,
>  					       sizeof(es->s_uuid));
>  
> -	/* Set defaults before we parse the mount options */
> -	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
> -	set_opt(sb, INIT_INODE_TABLE);
> -	if (def_mount_opts & EXT4_DEFM_DEBUG)
> -		set_opt(sb, DEBUG);
> -	if (def_mount_opts & EXT4_DEFM_BSDGROUPS)
> -		set_opt(sb, GRPID);
> -	if (def_mount_opts & EXT4_DEFM_UID16)
> -		set_opt(sb, NO_UID32);
> -	/* xattr user namespace & acls are now defaulted on */
> -	set_opt(sb, XATTR_USER);
> -#ifdef CONFIG_EXT4_FS_POSIX_ACL
> -	set_opt(sb, POSIX_ACL);
> -#endif
> -	if (ext4_has_feature_fast_commit(sb))
> -		set_opt2(sb, JOURNAL_FAST_COMMIT);
> -	/* don't forget to enable journal_csum when metadata_csum is enabled. */
> -	if (ext4_has_metadata_csum(sb))
> -		set_opt(sb, JOURNAL_CHECKSUM);
> -
> -	if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_DATA)
> -		set_opt(sb, JOURNAL_DATA);
> -	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_ORDERED)
> -		set_opt(sb, ORDERED_DATA);
> -	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_WBACK)
> -		set_opt(sb, WRITEBACK_DATA);
> -
> -	if (le16_to_cpu(sbi->s_es->s_errors) == EXT4_ERRORS_PANIC)
> -		set_opt(sb, ERRORS_PANIC);
> -	else if (le16_to_cpu(sbi->s_es->s_errors) == EXT4_ERRORS_CONTINUE)
> -		set_opt(sb, ERRORS_CONT);
> -	else
> -		set_opt(sb, ERRORS_RO);
> -	/* block_validity enabled by default; disable with noblock_validity */
> -	set_opt(sb, BLOCK_VALIDITY);
> -	if (def_mount_opts & EXT4_DEFM_DISCARD)
> -		set_opt(sb, DISCARD);
> +	ext4_set_def_opts(sb, es);
>  
>  	sbi->s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
>  	sbi->s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
> @@ -4464,17 +4482,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
>  	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;
>  
> -	if ((def_mount_opts & EXT4_DEFM_NOBARRIER) == 0)
> -		set_opt(sb, BARRIER);
> -
> -	/*
> -	 * enable delayed allocation by default
> -	 * Use -o nodelalloc to turn it off
> -	 */
> -	if (!IS_EXT3_SB(sb) && !IS_EXT2_SB(sb) &&
> -	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
> -		set_opt(sb, DELALLOC);
> -
>  	/*
>  	 * set default s_li_wait_mult for lazyinit, for the case there is
>  	 * no mount option specified.
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
