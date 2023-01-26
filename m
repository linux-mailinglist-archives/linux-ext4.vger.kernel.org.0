Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658E467C821
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jan 2023 11:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjAZKPC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Jan 2023 05:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbjAZKPB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Jan 2023 05:15:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9854135
        for <linux-ext4@vger.kernel.org>; Thu, 26 Jan 2023 02:14:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81EAB21C34;
        Thu, 26 Jan 2023 10:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674728097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=alaj+0IoFJuOelsZ2d13ZzOfoV8BDDIBfsJw6Gd717c=;
        b=gTDcZkyVzgGlo6vJANMvMQteiBKSXqf82u5qRuzcPkckZ6v7kdZqA4mBND4zXsJTOBoNhZ
        X+mA7UBDgPchzCsebFr7QAguXGzhpVu3Joo0SS26yTnRgNjkPAUFQLSofjq4OphQPAIpOS
        3M2/YA/2S24wI9zsOlCZRs6MHEEE8fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674728097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=alaj+0IoFJuOelsZ2d13ZzOfoV8BDDIBfsJw6Gd717c=;
        b=CRm/21+hgu/QJ75JK+5g/qKBK9zgYHnrkqPty0rFJU6AkothClInMfnwd4YmnqpPpbTnKZ
        5+jj7o0OXGIsanBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DDED13A09;
        Thu, 26 Jan 2023 10:14:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9sPTFqFS0mN3cwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 26 Jan 2023 10:14:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4F276A06B4; Thu, 26 Jan 2023 11:14:56 +0100 (CET)
Date:   Thu, 26 Jan 2023 11:14:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH 1/2] jbd2: cycled record log on clean journal logging
 area
Message-ID: <20230126101456.ptkroqvfg442ct5q@quack3>
References: <20230119034600.3431194-1-yi.zhang@huaweicloud.com>
 <20230119034600.3431194-2-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119034600.3431194-2-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Thu 19-01-23 11:45:59, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> For a newly mounted file system, the journal committing thread always
> record log from the beginning of the journal area, no matter whether the
> journal is clean or it has just been recovered. It is disadvantageous to
> analysis corrupted file system image and locate the file system
> inconsistency bugs. When we get a corrupted file system image and want
> to find out what has happened, besides lookup the system log, one
> effective may is to backtrack the journal log. But we may not always run
> e2fsck before each mount and the default fsck -a mode also cannot always
> find all inconsistencies, so it could left over some inconsistencies
> into the next mount until we detect it. Finally, the transactions in the
> journal may probably discontinuous and some relatively new transactions
> has been covered, it becomes hard to analyse. So if we could records
> transactions continuously between each mounts, we could acquire more
> useful info from the journal.
> 
>  |Previous mount checkpointed/recovered logs|Current mount logs         |
>  |{------}{---}{--------} ... {------}| ... |{======}{========}...000000|
> 
> This patch save the head blocknr in the superblock after flushing the
> journal or unmounting the file system, let the next mount could continue
> to record new transaction behind it. This change is backward compatible
> because the old kernel does not care about the head blocknr of the
> journal. It is also fine if we mount a clean old image without valid
> head blocknr, we fail back to set it to s_first just like before.
> Finally, for the case of mount an unclean file system, we could also get
> the journal head easily after scanning the journal, it will continue to
> record new transaction after the recovered transactions.

I understand the usecase although if there are multiple mounts between
the time when the corruption happened and when it got detected I suspect
the journal will be already overwritten (filled and wrapped over) and so not
too useful anyway. But still the number of blocks preserved in the journal
will be higher so I guess there is some chance there will be something
useful in there.

Do you want this mostly for debugging stuff (like fuzzer testing) or
would you really want to run with this on production machines?

Also I think we could actually implement something like this without adding
s_head field (i.e., without any on-disk format change). Setting of s_start
to 0 when the journal is empty is actually only an optimization. We could
leave it where it is (in this debug mode), just make jbd2 detect empty
journal while it is used from j_head == s_start instead of by testing
s_start == 0, and the only difference would be that jbd2_journal_recover()
would now try recovering even empty journal (but abort immediately) which
mostly should not happen on clean mount anyway because we call jbd2 to
recover the journal only if ext4_has_feature_journal_needs_recovery().

								Honza

> ---
>  fs/jbd2/journal.c    | 18 ++++++++++++++++--
>  fs/jbd2/recovery.c   | 22 +++++++++++++++++-----
>  include/linux/jbd2.h |  9 +++++++--
>  3 files changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 2696f43e7239..41f0f5625e7c 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1557,8 +1557,21 @@ static int journal_reset(journal_t *journal)
>  	journal->j_first = first;
>  	journal->j_last = last;
>  
> -	journal->j_head = journal->j_first;
> -	journal->j_tail = journal->j_first;
> +	if (journal->j_flags & JBD2_CYCLE_RECORD) {
> +		/*
> +		 * Disable the cycled recording mode if the journal head block
> +		 * number is not correct.
> +		 */
> +		if (journal->j_head < first || journal->j_head >= last) {
> +			printk(KERN_WARNING "JBD2: Incorrect Journal head block %lu, "
> +			       "disable journal_cycle_record\n",
> +			       journal->j_head);
> +			journal->j_head = journal->j_first;
> +		}
> +	} else {
> +		journal->j_head = journal->j_first;
> +	}
> +	journal->j_tail = journal->j_head;
>  	journal->j_free = journal->j_last - journal->j_first;
>  
>  	journal->j_tail_sequence = journal->j_transaction_sequence;
> @@ -1730,6 +1743,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, blk_opf_t write_flags)
>  
>  	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
>  	sb->s_start    = cpu_to_be32(0);
> +	sb->s_head     = cpu_to_be32(journal->j_head);
>  	if (jbd2_has_feature_fast_commit(journal)) {
>  		/*
>  		 * When journal is clean, no need to commit fast commit flag and
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 8286a9ec122f..6f6bcb75fffe 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -29,6 +29,7 @@ struct recovery_info
>  {
>  	tid_t		start_transaction;
>  	tid_t		end_transaction;
> +	unsigned long	head_block;
>  
>  	int		nr_replays;
>  	int		nr_revokes;
> @@ -301,11 +302,11 @@ int jbd2_journal_recover(journal_t *journal)
>  	 * is always zero if, and only if, the journal was cleanly
>  	 * unmounted.
>  	 */
> -
>  	if (!sb->s_start) {
> -		jbd2_debug(1, "No recovery required, last transaction %d\n",
> -			  be32_to_cpu(sb->s_sequence));
> +		jbd2_debug(1, "No recovery required, last transaction %d, head block %u\n",
> +			  be32_to_cpu(sb->s_sequence), be32_to_cpu(sb->s_head));
>  		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
> +		journal->j_head = be32_to_cpu(sb->s_head);
>  		return 0;
>  	}
>  
> @@ -324,6 +325,9 @@ int jbd2_journal_recover(journal_t *journal)
>  	/* Restart the log at the next transaction ID, thus invalidating
>  	 * any existing commit records in the log. */
>  	journal->j_transaction_sequence = ++info.end_transaction;
> +	journal->j_head = info.head_block;
> +	jbd2_debug(1, "JBD2: last transaction %d, head block %u\n",
> +		  journal->j_transaction_sequence, journal->j_head);
>  
>  	jbd2_journal_clear_revoke(journal);
>  	err2 = sync_blockdev(journal->j_fs_dev);
> @@ -364,6 +368,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
>  	if (err) {
>  		printk(KERN_ERR "JBD2: error %d scanning journal\n", err);
>  		++journal->j_transaction_sequence;
> +		journal->j_head = journal->j_first;
>  	} else {
>  #ifdef CONFIG_JBD2_DEBUG
>  		int dropped = info.end_transaction - 
> @@ -373,6 +378,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
>  			  dropped, (dropped == 1) ? "" : "s");
>  #endif
>  		journal->j_transaction_sequence = ++info.end_transaction;
> +		journal->j_head = info.head_block;
>  	}
>  
>  	journal->j_tail = 0;
> @@ -462,7 +468,7 @@ static int do_one_pass(journal_t *journal,
>  			struct recovery_info *info, enum passtype pass)
>  {
>  	unsigned int		first_commit_ID, next_commit_ID;
> -	unsigned long		next_log_block;
> +	unsigned long		next_log_block, head_block;
>  	int			err, success = 0;
>  	journal_superblock_t *	sb;
>  	journal_header_t *	tmp;
> @@ -485,6 +491,7 @@ static int do_one_pass(journal_t *journal,
>  	sb = journal->j_superblock;
>  	next_commit_ID = be32_to_cpu(sb->s_sequence);
>  	next_log_block = be32_to_cpu(sb->s_start);
> +	head_block = next_log_block;
>  
>  	first_commit_ID = next_commit_ID;
>  	if (pass == PASS_SCAN)
> @@ -809,6 +816,7 @@ static int do_one_pass(journal_t *journal,
>  				if (commit_time < last_trans_commit_time)
>  					goto ignore_crc_mismatch;
>  				info->end_transaction = next_commit_ID;
> +				info->head_block = head_block;
>  
>  				if (!jbd2_has_feature_async_commit(journal)) {
>  					journal->j_failed_commit =
> @@ -817,8 +825,10 @@ static int do_one_pass(journal_t *journal,
>  					break;
>  				}
>  			}
> -			if (pass == PASS_SCAN)
> +			if (pass == PASS_SCAN) {
>  				last_trans_commit_time = commit_time;
> +				head_block = next_log_block;
> +			}
>  			brelse(bh);
>  			next_commit_ID++;
>  			continue;
> @@ -868,6 +878,8 @@ static int do_one_pass(journal_t *journal,
>  	if (pass == PASS_SCAN) {
>  		if (!info->end_transaction)
>  			info->end_transaction = next_commit_ID;
> +		if (!info->head_block)
> +			info->head_block = head_block;
>  	} else {
>  		/* It's really bad news if different passes end up at
>  		 * different places (but possible due to IO errors). */
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 2170e0cc279d..d5843ebfa6ed 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -265,8 +265,10 @@ typedef struct journal_superblock_s
>  	__u8	s_padding2[3];
>  /* 0x0054 */
>  	__be32	s_num_fc_blks;		/* Number of fast commit blocks */
> -/* 0x0058 */
> -	__u32	s_padding[41];
> +	__be32	s_head;			/* blocknr of head of log, only uptodate
> +					 * while the filesystem is clean */
> +/* 0x005C */
> +	__u32	s_padding[40];
>  	__be32	s_checksum;		/* crc32c(superblock) */
>  
>  /* 0x0100 */
> @@ -1392,6 +1394,9 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
>  #define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
>  						 * data write error in ordered
>  						 * mode */
> +#define JBD2_CYCLE_RECORD		0x080	/* Journal cycled record log on
> +						 * clean and empty filesystem
> +						 * logging area */
>  #define JBD2_FAST_COMMIT_ONGOING	0x100	/* Fast commit is ongoing */
>  #define JBD2_FULL_COMMIT_ONGOING	0x200	/* Full commit is ongoing */
>  #define JBD2_JOURNAL_FLUSH_DISCARD	0x0001
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
