Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF31576EF43
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjHCQTL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 12:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjHCQTK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 12:19:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBA8173F
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 09:19:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A991921910;
        Thu,  3 Aug 2023 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691079547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCgpxMJK6qfcX7lCo8/CE5bDyITFpy4KXOdpFFE3GAo=;
        b=cpn59WyG+QpnjqIGr0zf85Q0BW/WGxu+AXf4xhtOMuXqZ/WjBXaf/nXDPZU3t4Nip7nmy4
        pPZFDUOtqgPVdB4RuhZzOCoUXCGBRdzUYO0PBwSBhxNiFsmjmwZKpTPiUQL46xxVXupRgG
        NgOI5t7kwvnzmBq6VravyV3k7aylL9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691079547;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCgpxMJK6qfcX7lCo8/CE5bDyITFpy4KXOdpFFE3GAo=;
        b=axKMMyUEf2Vu7zwFNxqWiXXoU4OLezHNRATxS8AyWaRTU+0zELEyRCQOUfiuLUkmjnWnUY
        qBWUBrB/QJHJBLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 973811333C;
        Thu,  3 Aug 2023 16:19:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NpbkJHvTy2RlRwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 16:19:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 23B08A076B; Thu,  3 Aug 2023 18:19:07 +0200 (CEST)
Date:   Thu, 3 Aug 2023 18:19:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 12/12] ext4: ext4_get_{dev}_journal return proper error
 value
Message-ID: <20230803161907.dsug5kqmxvn25kkf@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-13-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-13-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:33, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> ext4_get_journal() and ext4_get_dev_journal() return NULL if they failed
> to init journal, making them return proper error value instead, also
> rename them to ext4_open_{inode,dev}_journal().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 51 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 25ae536a370f..ae8a964e493d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5752,18 +5752,18 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
>  	journal_inode = ext4_iget(sb, journal_inum, EXT4_IGET_SPECIAL);
>  	if (IS_ERR(journal_inode)) {
>  		ext4_msg(sb, KERN_ERR, "no journal found");
> -		return NULL;
> +		return ERR_CAST(journal_inode);
>  	}
>  	if (!journal_inode->i_nlink) {
>  		make_bad_inode(journal_inode);
>  		iput(journal_inode);
>  		ext4_msg(sb, KERN_ERR, "journal inode is deleted");
> -		return NULL;
> +		return ERR_PTR(-EFSCORRUPTED);
>  	}
>  	if (!S_ISREG(journal_inode->i_mode) || IS_ENCRYPTED(journal_inode)) {
>  		ext4_msg(sb, KERN_ERR, "invalid journal inode");
>  		iput(journal_inode);
> -		return NULL;
> +		return ERR_PTR(-EFSCORRUPTED);
>  	}
>  
>  	ext4_debug("Journal inode found at %p: %lld bytes\n",
> @@ -5793,21 +5793,21 @@ static int ext4_journal_bmap(journal_t *journal, sector_t *block)
>  	return 0;
>  }
>  
> -static journal_t *ext4_get_journal(struct super_block *sb,
> -				   unsigned int journal_inum)
> +static journal_t *ext4_open_inode_journal(struct super_block *sb,
> +					  unsigned int journal_inum)
>  {
>  	struct inode *journal_inode;
>  	journal_t *journal;
>  
>  	journal_inode = ext4_get_journal_inode(sb, journal_inum);
> -	if (!journal_inode)
> -		return NULL;
> +	if (IS_ERR(journal_inode))
> +		return ERR_CAST(journal_inode);
>  
>  	journal = jbd2_journal_init_inode(journal_inode);
>  	if (IS_ERR(journal)) {
>  		ext4_msg(sb, KERN_ERR, "Could not load journal inode");
>  		iput(journal_inode);
> -		return NULL;
> +		return ERR_CAST(journal);
>  	}
>  	journal->j_private = sb;
>  	journal->j_bmap = ext4_journal_bmap;
> @@ -5825,6 +5825,7 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
>  	ext4_fsblk_t sb_block;
>  	unsigned long offset;
>  	struct ext4_super_block *es;
> +	int errno;
>  
>  	bdev = blkdev_get_by_dev(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
>  				 &ext4_holder_ops);
> @@ -5832,7 +5833,7 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
>  		ext4_msg(sb, KERN_ERR,
>  			 "failed to open journal device unknown-block(%u,%u) %ld",
>  			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev));
> -		return NULL;
> +		return ERR_CAST(bdev);
>  	}
>  
>  	blocksize = sb->s_blocksize;
> @@ -5840,6 +5841,7 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
>  	if (blocksize < hblock) {
>  		ext4_msg(sb, KERN_ERR,
>  			"blocksize too small for journal device");
> +		errno = -EINVAL;
>  		goto out_bdev;
>  	}
>  
> @@ -5850,6 +5852,7 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
>  	if (!bh) {
>  		ext4_msg(sb, KERN_ERR, "couldn't read superblock of "
>  		       "external journal");
> +		errno = -EINVAL;
>  		goto out_bdev;
>  	}
>  
> @@ -5858,6 +5861,7 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
>  	    !(le32_to_cpu(es->s_feature_incompat) &
>  	      EXT4_FEATURE_INCOMPAT_JOURNAL_DEV)) {
>  		ext4_msg(sb, KERN_ERR, "external journal has bad superblock");
> +		errno = -EFSCORRUPTED;
>  		goto out_bh;
>  	}
>  
> @@ -5865,11 +5869,13 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
>  	     EXT4_FEATURE_RO_COMPAT_METADATA_CSUM) &&
>  	    es->s_checksum != ext4_superblock_csum(sb, es)) {
>  		ext4_msg(sb, KERN_ERR, "external journal has corrupt superblock");
> +		errno = -EFSCORRUPTED;
>  		goto out_bh;
>  	}
>  
>  	if (memcmp(EXT4_SB(sb)->s_es->s_journal_uuid, es->s_uuid, 16)) {
>  		ext4_msg(sb, KERN_ERR, "journal UUID does not match");
> +		errno = -EFSCORRUPTED;
>  		goto out_bh;
>  	}
>  
> @@ -5882,31 +5888,34 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
>  	brelse(bh);
>  out_bdev:
>  	blkdev_put(bdev, sb);
> -	return NULL;
> +	return ERR_PTR(errno);
>  }
>  
> -static journal_t *ext4_get_dev_journal(struct super_block *sb,
> -				       dev_t j_dev)
> +static journal_t *ext4_open_dev_journal(struct super_block *sb,
> +					dev_t j_dev)
>  {
>  	journal_t *journal;
>  	ext4_fsblk_t j_start;
>  	ext4_fsblk_t j_len;
>  	struct block_device *journal_bdev;
> +	int errno = 0;
>  
>  	journal_bdev = ext4_get_journal_dev(sb, j_dev, &j_start, &j_len);
> -	if (!journal_bdev)
> -		return NULL;
> +	if (IS_ERR(journal_bdev))
> +		return ERR_CAST(journal_bdev);
>  
>  	journal = jbd2_journal_init_dev(journal_bdev, sb->s_bdev, j_start,
>  					j_len, sb->s_blocksize);
>  	if (IS_ERR(journal)) {
>  		ext4_msg(sb, KERN_ERR, "failed to create device journal");
> +		errno = PTR_ERR(journal);
>  		goto out_bdev;
>  	}
>  	if (be32_to_cpu(journal->j_superblock->s_nr_users) != 1) {
>  		ext4_msg(sb, KERN_ERR, "External journal has more than one "
>  					"user (unsupported) - %d",
>  			be32_to_cpu(journal->j_superblock->s_nr_users));
> +		errno = -EINVAL;
>  		goto out_journal;
>  	}
>  	journal->j_private = sb;
> @@ -5918,7 +5927,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
>  	jbd2_journal_destroy(journal);
>  out_bdev:
>  	blkdev_put(journal_bdev, sb);
> -	return NULL;
> +	return ERR_PTR(errno);
>  }
>  
>  static int ext4_load_journal(struct super_block *sb,
> @@ -5950,13 +5959,13 @@ static int ext4_load_journal(struct super_block *sb,
>  	}
>  
>  	if (journal_inum) {
> -		journal = ext4_get_journal(sb, journal_inum);
> -		if (!journal)
> -			return -EINVAL;
> +		journal = ext4_open_inode_journal(sb, journal_inum);
> +		if (IS_ERR(journal))
> +			return PTR_ERR(journal);
>  	} else {
> -		journal = ext4_get_dev_journal(sb, journal_dev);
> -		if (!journal)
> -			return -EINVAL;
> +		journal = ext4_open_dev_journal(sb, journal_dev);
> +		if (IS_ERR(journal))
> +			return PTR_ERR(journal);
>  	}
>  
>  	journal_dev_ro = bdev_read_only(journal->j_dev);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
