Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AD676EF31
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 18:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjHCQOu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 12:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjHCQOt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 12:14:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B38F173F
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 09:14:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D1D51F45A;
        Thu,  3 Aug 2023 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691079287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SMNpeMZmMVIW71E7YRszaXD/aoj9T3kZyKL7OsD/nl0=;
        b=I3cEUJrnV/Ap8Sq9L9lERg1h3ENyCBtVnWdQcscl3a/AxNTQa8/OfZKcdqXv3bwoPrlDBH
        xjTcaNWN/HrjAUCdi0FAaSB8HZzyJXYFLqN0AvtwfDImqx1xsqMoP3oEl4LqjtQZpUnOii
        7mCVMjnZdvuyML2CNpnESApx4IwnmYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691079287;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SMNpeMZmMVIW71E7YRszaXD/aoj9T3kZyKL7OsD/nl0=;
        b=W/389JwgJKs9qi0lJ+apGMcIk+stDYlEJD/stIfJUiCzgEEeJD69lC101c2LKewLaF4VWM
        +h4PyDaLyblVREBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CB871333C;
        Thu,  3 Aug 2023 16:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 34TlCnfSy2RcRQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 16:14:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AC852A076B; Thu,  3 Aug 2023 18:14:46 +0200 (CEST)
Date:   Thu, 3 Aug 2023 18:14:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 11/12] ext4: cleanup ext4_get_dev_journal() and
 ext4_get_journal()
Message-ID: <20230803161446.6ac3ffhvfihmpyr6@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-12-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-12-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:32, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Factor out a new helper form ext4_get_dev_journal() to get external
> journal bdev and check validation of this device, drop ext4_blkdev_get()
> helper, and also remove duplicate check of journal feature. It makes
> ext4_get_dev_journal() more clear than before.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

One comment below:

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
> +	brelse(bh);
> +	*j_start = sb_block + 1;
> +	*j_len = ext4_blocks_count(es);

Here the ext4_blocks_count() is a use-after-free since you've released the
bh a few lines above.

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
