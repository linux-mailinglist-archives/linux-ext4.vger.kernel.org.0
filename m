Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFBB733228
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbjFPN1w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 09:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345403AbjFPN1s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 09:27:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B22721
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 06:27:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F13021AEA;
        Fri, 16 Jun 2023 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686922066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RQG9SvLCYT5CdQHbsIt/j1559mVkDuYjYOnXa/ktwp8=;
        b=gVzaRLDyVe2g0d7M3W0ZDf5dxnGMt815C/DBNrs1VXnWMRPYJ378rHD+iw01aoLCSzuH5t
        D52oBQ7upCXvZBFYKDAlYs0pV2QDR6hp7QygWYbIkBetorsU7UVKhQLbFL78KTKDGdN9cs
        4OgTzRJlkxaS8LrJoQumK4f/cUp1EBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686922066;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RQG9SvLCYT5CdQHbsIt/j1559mVkDuYjYOnXa/ktwp8=;
        b=NTtBIgyOaxkcpsCTYkvN+cOeIRhyyg5sD0MmH86705V8iHTl6brCQEellN1fc1fKGyH+uD
        ThgUqXOchwNjEVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A766138E8;
        Fri, 16 Jun 2023 13:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1pb7GVJjjGQPRwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 13:27:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CC862A0755; Fri, 16 Jun 2023 15:27:45 +0200 (CEST)
Date:   Fri, 16 Jun 2023 15:27:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2] jbd2: skip reading super block if it has been verified
Message-ID: <20230616132745.d3enqs4uni55abrj@quack3>
References: <20230616015547.3155195-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616015547.3155195-1-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 16-06-23 09:55:47, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> We got a NULL pointer dereference issue below while running generic/475
> I/O failure pressure test.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  PGD 0 P4D 0
>  Oops: 0002 [#1] PREEMPT SMP PTI
>  CPU: 1 PID: 15600 Comm: fsstress Not tainted 6.4.0-rc5-xfstests-00055-gd3ab1bca26b4 #190
>  RIP: 0010:jbd2_journal_set_features+0x13d/0x430
>  ...
>  Call Trace:
>   <TASK>
>   ? __die+0x23/0x60
>   ? page_fault_oops+0xa4/0x170
>   ? exc_page_fault+0x67/0x170
>   ? asm_exc_page_fault+0x26/0x30
>   ? jbd2_journal_set_features+0x13d/0x430
>   jbd2_journal_revoke+0x47/0x1e0
>   __ext4_forget+0xc3/0x1b0
>   ext4_free_blocks+0x214/0x2f0
>   ext4_free_branches+0xeb/0x270
>   ext4_ind_truncate+0x2bf/0x320
>   ext4_truncate+0x1e4/0x490
>   ext4_handle_inode_extension+0x1bd/0x2a0
>   ? iomap_dio_complete+0xaf/0x1d0
> 
> The root cause is the journal super block had been failed to write out
> due to I/O fault injection, it's uptodate bit was cleared by
> end_buffer_write_sync() and didn't reset yet in jbd2_write_superblock().
> And it raced by journal_get_superblock()->bh_read(), unfortunately, the
> read IO is also failed, so the error handling in
> journal_fail_superblock() unexpectedly clear the journal->j_sb_buffer,
> finally lead to above NULL pointer dereference issue.
> 
> If the journal super block had been read and verified, there is no need
> to call bh_read() read it again even if it has been failed to written
> out. So the fix could be simply move buffer_verified(bh) in front of
> bh_read(). Also remove a stale comment left in
> jbd2_journal_check_used_features().
> 
> Fixes: 51bacdba23d8 ("jbd2: factor out journal initialization from journal_get_superblock()")
> Reported-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

This works as a workaround. It is a bit kludgy but for now I guess it is
good enough. Thanks for the fix and feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
> v1->v2:
>  - Remove a stale comment left in jbd2_journal_check_used_features().
> 
>  fs/jbd2/journal.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index b5e57735ab3f..559242df0f9a 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1919,6 +1919,9 @@ static int journal_get_superblock(journal_t *journal)
>  	bh = journal->j_sb_buffer;
>  
>  	J_ASSERT(bh != NULL);
> +	if (buffer_verified(bh))
> +		return 0;
> +
>  	err = bh_read(bh, 0);
>  	if (err < 0) {
>  		printk(KERN_ERR
> @@ -1926,9 +1929,6 @@ static int journal_get_superblock(journal_t *journal)
>  		goto out;
>  	}
>  
> -	if (buffer_verified(bh))
> -		return 0;
> -
>  	sb = journal->j_superblock;
>  
>  	err = -EINVAL;
> @@ -2229,7 +2229,6 @@ int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
>  
>  	if (!compat && !ro && !incompat)
>  		return 1;
> -	/* Load journal superblock if it is not loaded yet. */
>  	if (journal_get_superblock(journal))
>  		return 0;
>  	if (!jbd2_format_support_feature(journal))
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
