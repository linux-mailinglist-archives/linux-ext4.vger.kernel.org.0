Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98BA77759F
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 12:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjHJKVE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 06:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjHJKU7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 06:20:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CDF11F
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 03:20:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B6E3421853;
        Thu, 10 Aug 2023 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691662857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A0kfoHIncIKswhYrRLTm6m5Mwpd9PogwZifRbv7CjQU=;
        b=lfsEK/pYwLGF4oim1fbGzGZsKyzsuTIkAmseH49z8rwrxwTb/CQYZOxcYJEFIj3dln9tvq
        cyRhMICcWO9t/7zOrmCIF6ILHN+yYFw0b7fTP1atrCozAToGwUpI6oYWIz9PDgLTf822Q3
        QRB413Cdmr0Bn8ur1Akp+SVocAgYjkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691662857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A0kfoHIncIKswhYrRLTm6m5Mwpd9PogwZifRbv7CjQU=;
        b=L9d0oSpdx0IA8/LqJkYVUEm5oSa91+LpnUYq4tLOOMymHPOSctq2hfwZEqNlU0LGSqE5zi
        cmEMWhs+l8swOGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5A81138E2;
        Thu, 10 Aug 2023 10:20:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KLVuKAm61GS/FwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 10:20:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 08ACFA076F; Thu, 10 Aug 2023 12:20:57 +0200 (CEST)
Date:   Thu, 10 Aug 2023 12:20:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 11/12] ext4: cleanup ext4_get_dev_journal() and
 ext4_get_journal()
Message-ID: <20230810102056.d347mxohzc2bgft4@quack3>
References: <20230810085417.1501293-1-yi.zhang@huaweicloud.com>
 <20230810085417.1501293-12-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810085417.1501293-12-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-08-23 16:54:16, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Factor out a new helper form ext4_get_dev_journal() to get external
> journal bdev and check validation of this device, drop ext4_blkdev_get()
> helper, and also remove duplicate check of journal feature. It makes
> ext4_get_dev_journal() more clear than before.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Just one nit: We have ext4_get_dev_journal() function and now you create
ext4_get_journal_dev() helper. These are confusingly similar names. So I
suggest you rename the new helper to something like
ext4_get_journal_blkdev() to make the difference clearer. Otherwise feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/super.c | 109 ++++++++++++++++++++++--------------------------
>  1 file changed, 49 insertions(+), 60 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ce2e02b139af..2f71076f678a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1105,26 +1105,6 @@ static const struct blk_holder_ops ext4_holder_ops = {
>  	.mark_dead		= ext4_bdev_mark_dead,
>  };
>  
> -/*
> - * Open the external journal device
> - */
> -static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
> -{
> -	struct block_device *bdev;
> -
> -	bdev = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
> -				 &ext4_holder_ops);
> -	if (IS_ERR(bdev))
> -		goto fail;
> -	return bdev;
> -
> -fail:
> -	ext4_msg(sb, KERN_ERR,
> -		 "failed to open journal device unknown-block(%u,%u) %ld",
> -		 MAJOR(dev), MINOR(dev), PTR_ERR(bdev));
> -	return NULL;
> -}
> -
>  /*
>   * Release the journal device
>   */
> @@ -5780,14 +5760,14 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
>  		ext4_msg(sb, KERN_ERR, "journal inode is deleted");
>  		return NULL;
>  	}
> -
> -	ext4_debug("Journal inode found at %p: %lld bytes\n",
> -		  journal_inode, journal_inode->i_size);
>  	if (!S_ISREG(journal_inode->i_mode) || IS_ENCRYPTED(journal_inode)) {
>  		ext4_msg(sb, KERN_ERR, "invalid journal inode");
>  		iput(journal_inode);
>  		return NULL;
>  	}
> +
> +	ext4_debug("Journal inode found at %p: %lld bytes\n",
> +		  journal_inode, journal_inode->i_size);
>  	return journal_inode;
>  }
>  
> @@ -5819,9 +5799,6 @@ static journal_t *ext4_get_journal(struct super_block *sb,
>  	struct inode *journal_inode;
>  	journal_t *journal;
>  
> -	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> -		return NULL;
> -
>  	journal_inode = ext4_get_journal_inode(sb, journal_inum);
>  	if (!journal_inode)
>  		return NULL;
> @@ -5838,25 +5815,25 @@ static journal_t *ext4_get_journal(struct super_block *sb,
>  	return journal;
>  }
>  
> -static journal_t *ext4_get_dev_journal(struct super_block *sb,
> -				       dev_t j_dev)
> +static struct block_device *ext4_get_journal_dev(struct super_block *sb,
> +					dev_t j_dev, ext4_fsblk_t *j_start,
> +					ext4_fsblk_t *j_len)
>  {
>  	struct buffer_head *bh;
> -	journal_t *journal;
> -	ext4_fsblk_t start;
> -	ext4_fsblk_t len;
> +	struct block_device *bdev;
>  	int hblock, blocksize;
>  	ext4_fsblk_t sb_block;
>  	unsigned long offset;
>  	struct ext4_super_block *es;
> -	struct block_device *bdev;
>  
> -	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> -		return NULL;
> -
> -	bdev = ext4_blkdev_get(j_dev, sb);
> -	if (bdev == NULL)
> +	bdev = blkdev_get_by_dev(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
> +				 &ext4_holder_ops);
> +	if (IS_ERR(bdev)) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "failed to open journal device unknown-block(%u,%u) %ld",
> +			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev));
>  		return NULL;
> +	}
>  
>  	blocksize = sb->s_blocksize;
>  	hblock = bdev_logical_block_size(bdev);
> @@ -5869,7 +5846,8 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
>  	sb_block = EXT4_MIN_BLOCK_SIZE / blocksize;
>  	offset = EXT4_MIN_BLOCK_SIZE % blocksize;
>  	set_blocksize(bdev, blocksize);
> -	if (!(bh = __bread(bdev, sb_block, blocksize))) {
> +	bh = __bread(bdev, sb_block, blocksize);
> +	if (!bh) {
>  		ext4_msg(sb, KERN_ERR, "couldn't read superblock of "
>  		       "external journal");
>  		goto out_bdev;
> @@ -5879,56 +5857,67 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
>  	if ((le16_to_cpu(es->s_magic) != EXT4_SUPER_MAGIC) ||
>  	    !(le32_to_cpu(es->s_feature_incompat) &
>  	      EXT4_FEATURE_INCOMPAT_JOURNAL_DEV)) {
> -		ext4_msg(sb, KERN_ERR, "external journal has "
> -					"bad superblock");
> -		brelse(bh);
> -		goto out_bdev;
> +		ext4_msg(sb, KERN_ERR, "external journal has bad superblock");
> +		goto out_bh;
>  	}
>  
>  	if ((le32_to_cpu(es->s_feature_ro_compat) &
>  	     EXT4_FEATURE_RO_COMPAT_METADATA_CSUM) &&
>  	    es->s_checksum != ext4_superblock_csum(sb, es)) {
> -		ext4_msg(sb, KERN_ERR, "external journal has "
> -				       "corrupt superblock");
> -		brelse(bh);
> -		goto out_bdev;
> +		ext4_msg(sb, KERN_ERR, "external journal has corrupt superblock");
> +		goto out_bh;
>  	}
>  
>  	if (memcmp(EXT4_SB(sb)->s_es->s_journal_uuid, es->s_uuid, 16)) {
>  		ext4_msg(sb, KERN_ERR, "journal UUID does not match");
> -		brelse(bh);
> -		goto out_bdev;
> +		goto out_bh;
>  	}
>  
> -	len = ext4_blocks_count(es);
> -	start = sb_block + 1;
> -	brelse(bh);	/* we're done with the superblock */
> +	*j_start = sb_block + 1;
> +	*j_len = ext4_blocks_count(es);
> +	brelse(bh);
> +	return bdev;
> +
> +out_bh:
> +	brelse(bh);
> +out_bdev:
> +	blkdev_put(bdev, sb);
> +	return NULL;
> +}
> +
> +static journal_t *ext4_get_dev_journal(struct super_block *sb,
> +				       dev_t j_dev)
> +{
> +	journal_t *journal;
> +	ext4_fsblk_t j_start;
> +	ext4_fsblk_t j_len;
> +	struct block_device *journal_bdev;
> +
> +	journal_bdev = ext4_get_journal_dev(sb, j_dev, &j_start, &j_len);
> +	if (!journal_bdev)
> +		return NULL;
>  
> -	journal = jbd2_journal_init_dev(bdev, sb->s_bdev,
> -					start, len, blocksize);
> +	journal = jbd2_journal_init_dev(journal_bdev, sb->s_bdev, j_start,
> +					j_len, sb->s_blocksize);
>  	if (IS_ERR(journal)) {
>  		ext4_msg(sb, KERN_ERR, "failed to create device journal");
>  		goto out_bdev;
>  	}
> -	journal->j_private = sb;
> -	if (ext4_read_bh_lock(journal->j_sb_buffer, REQ_META | REQ_PRIO, true)) {
> -		ext4_msg(sb, KERN_ERR, "I/O error on journal device");
> -		goto out_journal;
> -	}
>  	if (be32_to_cpu(journal->j_superblock->s_nr_users) != 1) {
>  		ext4_msg(sb, KERN_ERR, "External journal has more than one "
>  					"user (unsupported) - %d",
>  			be32_to_cpu(journal->j_superblock->s_nr_users));
>  		goto out_journal;
>  	}
> -	EXT4_SB(sb)->s_journal_bdev = bdev;
> +	journal->j_private = sb;
> +	EXT4_SB(sb)->s_journal_bdev = journal_bdev;
>  	ext4_init_journal_params(sb, journal);
>  	return journal;
>  
>  out_journal:
>  	jbd2_journal_destroy(journal);
>  out_bdev:
> -	blkdev_put(bdev, sb);
> +	blkdev_put(journal_bdev, sb);
>  	return NULL;
>  }
>  
> -- 
> 2.34.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
