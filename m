Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1703176EEC9
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbjHCP46 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 11:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjHCP45 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 11:56:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87A3A97
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 08:56:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C89321906;
        Thu,  3 Aug 2023 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691078214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kuUYY48oYe6pWWovt/Mjl1O4tIsQoWU04grVUjqHFeo=;
        b=sQjC0XWXUNfM2Te2av2XUffZjZnnq8gwvcuMt+kTfU8ECS+E1CGAErUKH1eNJ4Xfhp+flT
        AzipFqVobuHnTIGuXIYmIIfC/VtJ+uEKCXmVx3tcplWl5LOCGSv4c+/mXg1jOVnpLAYzWv
        /MHb43JP/bNYoY9O0a82BINCTJAmp0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691078214;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kuUYY48oYe6pWWovt/Mjl1O4tIsQoWU04grVUjqHFeo=;
        b=TrvD1noLsc34GIxyMyxLfxYn+k1aEQRjt3av7inEyFdrj9yugKALyHU5BRYvxoaoacm9ut
        GkVORV73RCCG9OAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F168F134B0;
        Thu,  3 Aug 2023 15:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bITrOkXOy2T9PAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 15:56:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8534EA076B; Thu,  3 Aug 2023 17:56:53 +0200 (CEST)
Date:   Thu, 3 Aug 2023 17:56:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 10/12] jbd2: jbd2_journal_init_{dev,inode} return proper
 error return value
Message-ID: <20230803155653.tzqcnpia3ksb7xsq@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-11-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-11-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:31, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current jbd2_journal_init_{dev,inode} return NULL if some error
> happens, make them to pass out proper error return value.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c    |  4 ++--
>  fs/jbd2/journal.c  | 19 +++++++++----------
>  fs/ocfs2/journal.c |  8 ++++----
>  3 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c94ebf704616..ce2e02b139af 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5827,7 +5827,7 @@ static journal_t *ext4_get_journal(struct super_block *sb,
>  		return NULL;
>  
>  	journal = jbd2_journal_init_inode(journal_inode);
> -	if (!journal) {
> +	if (IS_ERR(journal)) {
>  		ext4_msg(sb, KERN_ERR, "Could not load journal inode");
>  		iput(journal_inode);
>  		return NULL;
> @@ -5906,7 +5906,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
>  
>  	journal = jbd2_journal_init_dev(bdev, sb->s_bdev,
>  					start, len, blocksize);
> -	if (!journal) {
> +	if (IS_ERR(journal)) {
>  		ext4_msg(sb, KERN_ERR, "failed to create device journal");
>  		goto out_bdev;
>  	}
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index cc344b8d7476..34dd65aa9f61 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1539,7 +1539,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  
>  	journal = kzalloc(sizeof(*journal), GFP_KERNEL);
>  	if (!journal)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	journal->j_blocksize = blocksize;
>  	journal->j_dev = bdev;
> @@ -1584,6 +1584,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	 * journal descriptor can store up to n blocks, we need enough
>  	 * buffers to write out full descriptor block.
>  	 */
> +	err = -ENOMEM;
>  	n = journal->j_blocksize / jbd2_min_tag_size();
>  	journal->j_wbufsize = n;
>  	journal->j_fc_wbuf = NULL;
> @@ -1615,7 +1616,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	jbd2_journal_destroy_revoke(journal);
>  	journal_fail_superblock(journal);
>  	kfree(journal);
> -	return NULL;
> +	return ERR_PTR(err);
>  }
>  
>  /* jbd2_journal_init_dev and jbd2_journal_init_inode:
> @@ -1648,8 +1649,8 @@ journal_t *jbd2_journal_init_dev(struct block_device *bdev,
>  	journal_t *journal;
>  
>  	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
> -	if (!journal)
> -		return NULL;
> +	if (IS_ERR(journal))
> +		return ERR_CAST(journal);
>  
>  	snprintf(journal->j_devname, sizeof(journal->j_devname),
>  		 "%pg", journal->j_dev);
> @@ -1675,11 +1676,9 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>  
>  	blocknr = 0;
>  	err = bmap(inode, &blocknr);
> -
>  	if (err || !blocknr) {
> -		pr_err("%s: Cannot locate journal superblock\n",
> -			__func__);
> -		return NULL;
> +		pr_err("%s: Cannot locate journal superblock\n", __func__);
> +		return err ? ERR_PTR(err) : ERR_PTR(-EINVAL);
>  	}
>  
>  	jbd2_debug(1, "JBD2: inode %s/%ld, size %lld, bits %d, blksize %ld\n",
> @@ -1689,8 +1688,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>  	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
>  			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
>  			inode->i_sb->s_blocksize);
> -	if (!journal)
> -		return NULL;
> +	if (IS_ERR(journal))
> +		return ERR_CAST(journal);
>  
>  	journal->j_inode = inode;
>  	snprintf(journal->j_devname, sizeof(journal->j_devname),
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 25d8072ccfce..f35a1bbf52e2 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -911,9 +911,9 @@ int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
>  
>  	/* call the kernels journal init function now */
>  	j_journal = jbd2_journal_init_inode(inode);
> -	if (j_journal == NULL) {
> +	if (IS_ERR(j_journal)) {
>  		mlog(ML_ERROR, "Linux journal layer error\n");
> -		status = -EINVAL;
> +		status = PTR_ERR(journal);
>  		goto done;
>  	}
>  
> @@ -1687,9 +1687,9 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
>  	}
>  
>  	journal = jbd2_journal_init_inode(inode);
> -	if (journal == NULL) {
> +	if (IS_ERR(journal)) {
>  		mlog(ML_ERROR, "Linux journal layer error\n");
> -		status = -EIO;
> +		status = PTR_ERR(journal);
>  		goto done;
>  	}
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
