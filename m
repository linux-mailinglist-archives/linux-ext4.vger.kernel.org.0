Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9F723AE9
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 10:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjFFIDp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 04:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjFFIDa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 04:03:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510112693
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 01:01:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1190C1FD63;
        Tue,  6 Jun 2023 08:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686038517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1PJXuqOOlfwwyeRNY+r3CTLC+Myjlw1aFQpInPH6oSE=;
        b=OpAKag3Mrds1rMv/WzpjaX3SyuN9TmbNkziuRifJDaCzA2rk2lDHzwU7QmHJz/VgmpAE4h
        Gd7U7b7w8TMDGrSov3egCo/kFPj9uioYiaR/1NT3VKx5pBUIiwIFDXvCpJsZaU2hPFuadS
        8KBkG9tVxQGM+9M3WVWQ9RV0MxztodQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686038517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1PJXuqOOlfwwyeRNY+r3CTLC+Myjlw1aFQpInPH6oSE=;
        b=CBs3SndS8Yz8myF+Kbog44lLBIIyo+VbVRrC0utdh3JtQljH97vfbPVVWbE7vlOSK+pKEv
        7uhfDd4YR5NcXSCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0374813519;
        Tue,  6 Jun 2023 08:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ce7UAPXnfmSGIQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 06 Jun 2023 08:01:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 85D85A0754; Tue,  6 Jun 2023 10:01:56 +0200 (CEST)
Date:   Tue, 6 Jun 2023 10:01:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v2 4/6] jbd2: Fix wrongly judgement for buffer head
 removing while doing checkpoint
Message-ID: <20230606080156.ha2kowvennkikvea@quack3>
References: <20230606061447.1125036-1-yi.zhang@huaweicloud.com>
 <20230606061447.1125036-5-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606061447.1125036-5-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-06-23 14:14:45, Zhang Yi wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> Following process,
> 
> jbd2_journal_commit_transaction
> // there are several dirty buffer heads in transaction->t_checkpoint_list
>           P1                   wb_workfn
> jbd2_log_do_checkpoint
>  if (buffer_locked(bh)) // false
>                             __block_write_full_page
>                              trylock_buffer(bh)
>                              test_clear_buffer_dirty(bh)
>  if (!buffer_dirty(bh))
>   __jbd2_journal_remove_checkpoint(jh)
>    if (buffer_write_io_error(bh)) // false
>                              >> bh IO error occurs <<
>  jbd2_cleanup_journal_tail
>   __jbd2_update_log_tail
>    jbd2_write_superblock
>    // The bh won't be replayed in next mount.
> , which could corrupt the ext4 image, fetch a reproducer in [Link].
> 
> Since writeback process clears buffer dirty after locking buffer head,
> we can fix it by try locking buffer and check dirtiness while buffer is
> locked, the buffer head can be removed if it is neither dirty nor locked.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217490
> Fixes: 470decc613ab ("[PATCH] jbd2: initial copy of files from jbd")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 3eb5b01a7e84..32f86bfbca69 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -204,20 +204,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  		jh = transaction->t_checkpoint_list;
>  		bh = jh2bh(jh);
>  
> -		/*
> -		 * The buffer may be writing back, or flushing out in the
> -		 * last couple of cycles, or re-adding into a new transaction,
> -		 * need to check it again until it's unlocked.
> -		 */
> -		if (buffer_locked(bh)) {
> -			get_bh(bh);
> -			spin_unlock(&journal->j_list_lock);
> -			wait_on_buffer(bh);
> -			/* the journal_head may have gone by now */
> -			BUFFER_TRACE(bh, "brelse");
> -			__brelse(bh);
> -			goto retry;
> -		}
>  		if (jh->b_transaction != NULL) {
>  			transaction_t *t = jh->b_transaction;
>  			tid_t tid = t->t_tid;
> @@ -252,7 +238,22 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  			spin_lock(&journal->j_list_lock);
>  			goto restart;
>  		}
> -		if (!buffer_dirty(bh)) {
> +		if (!trylock_buffer(bh)) {
> +			/*
> +			 * The buffer is locked, it may be writing back, or
> +			 * flushing out in the last couple of cycles, or
> +			 * re-adding into a new transaction, need to check
> +			 * it again until it's unlocked.
> +			 */
> +			get_bh(bh);
> +			spin_unlock(&journal->j_list_lock);
> +			wait_on_buffer(bh);
> +			/* the journal_head may have gone by now */
> +			BUFFER_TRACE(bh, "brelse");
> +			__brelse(bh);
> +			goto retry;
> +		} else if (!buffer_dirty(bh)) {
> +			unlock_buffer(bh);
>  			BUFFER_TRACE(bh, "remove from checkpoint");
>  			/*
>  			 * If the transaction was released or the checkpoint
> @@ -262,6 +263,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  			    !transaction->t_checkpoint_list)
>  				goto out;
>  		} else {
> +			unlock_buffer(bh);
>  			/*
>  			 * We are about to write the buffer, it could be
>  			 * raced by some other transaction shrink or buffer
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
