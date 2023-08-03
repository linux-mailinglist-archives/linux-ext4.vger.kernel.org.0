Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1859E76EE99
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjHCPsj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 11:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjHCPsi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 11:48:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09353E6B
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 08:48:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABEE121906;
        Thu,  3 Aug 2023 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691077714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2f6E7fwg3CFZ7EsE9jK0KjSGrSyhmAffZqQnumpPQuA=;
        b=RHXNMJGQK7vInNE67raDYaRUKyhRUtygCqjlEyUSF86pQOzhoqNzFjY/TZ8159EYd6TFtC
        myWblezjtMB8dXDGTYwH4k/0C9K8Cy4y1CsEX7iAI/lmD785TEpHG1fmyc4X68tVRQXwCI
        twSn8YcZiwFS3yioDInZrr9hNT2EcQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691077714;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2f6E7fwg3CFZ7EsE9jK0KjSGrSyhmAffZqQnumpPQuA=;
        b=UVO13Hp4UwDTsKKQ8IIG7R9+F9dhUMR99fwyqnJ5u31HgwGKQfSdanSxrIZ3vVBir6ttFM
        tDsHebd15P6NPqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E160134B0;
        Thu,  3 Aug 2023 15:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ztWJJlLMy2Q7OQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 15:48:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2E7D0A076B; Thu,  3 Aug 2023 17:48:34 +0200 (CEST)
Date:   Thu, 3 Aug 2023 17:48:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 08/12] jbd2: cleanup journal_init_common()
Message-ID: <20230803154834.ttovbgx24gzzuiab@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-9-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-9-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:29, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Adjust the initialization sequence and error handle of journal_t, moving
> load superblock to the begin, and classify others initialization.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 45 ++++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 210b532a3673..065b5e789299 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1541,6 +1541,16 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	if (!journal)
>  		return NULL;
>  
> +	journal->j_blocksize = blocksize;
> +	journal->j_dev = bdev;
> +	journal->j_fs_dev = fs_dev;
> +	journal->j_blk_offset = start;
> +	journal->j_total_len = len;
> +
> +	err = journal_load_superblock(journal);
> +	if (err)
> +		goto err_cleanup;
> +
>  	init_waitqueue_head(&journal->j_wait_transaction_locked);
>  	init_waitqueue_head(&journal->j_wait_done_commit);
>  	init_waitqueue_head(&journal->j_wait_commit);
> @@ -1552,12 +1562,15 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	mutex_init(&journal->j_checkpoint_mutex);
>  	spin_lock_init(&journal->j_revoke_lock);
>  	spin_lock_init(&journal->j_list_lock);
> +	spin_lock_init(&journal->j_history_lock);
>  	rwlock_init(&journal->j_state_lock);
>  
>  	journal->j_commit_interval = (HZ * JBD2_DEFAULT_MAX_COMMIT_AGE);
>  	journal->j_min_batch_time = 0;
>  	journal->j_max_batch_time = 15000; /* 15ms */
>  	atomic_set(&journal->j_reserved_credits, 0);
> +	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
> +			 &jbd2_trans_commit_key, 0);
>  
>  	/* The journal is marked for error until we succeed with recovery! */
>  	journal->j_flags = JBD2_ABORT;
> @@ -1567,18 +1580,10 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	if (err)
>  		goto err_cleanup;
>  
> -	spin_lock_init(&journal->j_history_lock);
> -
> -	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
> -			 &jbd2_trans_commit_key, 0);
> -
> -	/* journal descriptor can store up to n blocks -bzzz */
> -	journal->j_blocksize = blocksize;
> -	journal->j_dev = bdev;
> -	journal->j_fs_dev = fs_dev;
> -	journal->j_blk_offset = start;
> -	journal->j_total_len = len;
> -	/* We need enough buffers to write out full descriptor block. */
> +	/*
> +	 * journal descriptor can store up to n blocks, we need enough
> +	 * buffers to write out full descriptor block.
> +	 */
>  	n = journal->j_blocksize / jbd2_min_tag_size();
>  	journal->j_wbufsize = n;
>  	journal->j_fc_wbuf = NULL;
> @@ -1587,7 +1592,8 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	if (!journal->j_wbuf)
>  		goto err_cleanup;
>  
> -	err = journal_load_superblock(journal);
> +	err = percpu_counter_init(&journal->j_checkpoint_jh_count, 0,
> +				  GFP_KERNEL);
>  	if (err)
>  		goto err_cleanup;
>  
> @@ -1596,21 +1602,18 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
>  	journal->j_shrinker.seeks = DEFAULT_SEEKS;
>  	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
> -
> -	if (percpu_counter_init(&journal->j_checkpoint_jh_count, 0, GFP_KERNEL))
> +	err = register_shrinker(&journal->j_shrinker, "jbd2-journal:(%u:%u)",
> +				MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
> +	if (err)
>  		goto err_cleanup;
>  
> -	if (register_shrinker(&journal->j_shrinker, "jbd2-journal:(%u:%u)",
> -			      MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev))) {
> -		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
> -		goto err_cleanup;
> -	}
>  	return journal;
>  
>  err_cleanup:
> -	brelse(journal->j_sb_buffer);
> +	percpu_counter_destroy(&journal->j_checkpoint_jh_count);
>  	kfree(journal->j_wbuf);
>  	jbd2_journal_destroy_revoke(journal);
> +	journal_fail_superblock(journal);
>  	kfree(journal);
>  	return NULL;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
