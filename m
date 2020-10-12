Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE7928BE3C
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Oct 2020 18:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403880AbgJLQoc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 12:44:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403782AbgJLQoc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 12 Oct 2020 12:44:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F6B9AC19;
        Mon, 12 Oct 2020 16:44:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E75271E12F5; Mon, 12 Oct 2020 18:44:29 +0200 (CEST)
Date:   Mon, 12 Oct 2020 18:44:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Fengnan Chang <fengnanchang@gmail.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger@dilger.ca,
        linux-ext4@vger.kernel.org,
        Fengnan Chang <changfengnan@hikvision.com>
Subject: Re: [PATCH] [PATCH v5]jbd2: avoid transaction reuse after
 reformatting
Message-ID: <20201012164429.GJ23665@quack2.suse.cz>
References: <20201012134322.5956-1-changfengnan@hikvision.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012134322.5956-1-changfengnan@hikvision.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 12-10-20 21:43:22, Fengnan Chang wrote:
> When ext4 is formatted with lazy_journal_init=1 and transactions from
> the previous filesystem are still on disk, it is possible that they are
> considered during a recovery after a crash. Because the checksum seed
> has changed, the CRC check will fail, and the journal recovery fails
> with checksum error although the journal is otherwise perfectly valid.
> Fix the problem by checking commit block time stamps to determine
> whether the data in the journal block is just stale or whether it is
> indeed corrupt.
> 
> Signed-off-by: Fengnan Chang <changfengnan@hikvision.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks for the patch. Current upstream kernel actually slightly differs so
your patch will not apply. I've applied the changes to my tree and also
removed some duplication but overall the logic should be the same as in
your patch. Fstests are still running but I'll post the patch as v6 so that
Ted can pick it up.

								Honza

> ---
>  fs/jbd2/recovery.c | 97 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 86 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index a4967b27ffb6..4d0aff628884 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -428,6 +428,8 @@ static int do_one_pass(journal_t *journal,
>  	__u32			crc32_sum = ~0; /* Transactional Checksums */
>  	int			descr_csum_size = 0;
>  	int			block_error = 0;
> +	bool		need_check_commit_time = false;
> +	__be64		last_trans_commit_time = 0, commit_time = 0;
>  
>  	/*
>  	 * First thing is to establish what we expect to find in the log
> @@ -520,12 +522,21 @@ static int do_one_pass(journal_t *journal,
>  			if (descr_csum_size > 0 &&
>  			    !jbd2_descriptor_block_csum_verify(journal,
>  							       bh->b_data)) {
> -				printk(KERN_ERR "JBD2: Invalid checksum "
> -				       "recovering block %lu in log\n",
> -				       next_log_block);
> -				err = -EFSBADCRC;
> -				brelse(bh);
> -				goto failed;
> +				/*
> +				 * PASS_SCAN can see stale blocks due to lazy
> +				 * journal init. Don't error out on those yet.
> +				 */
> +				if (pass != PASS_SCAN) {
> +					pr_err("JBD2: Invalid checksum recovering block %lu in log\n",
> +					       next_log_block);
> +					err = -EFSBADCRC;
> +					brelse(bh);
> +					goto failed;
> +				}
> +				need_check_commit_time = true;
> +				jbd_debug(1,
> +					"invalid descriptor block found in %lu\n",
> +					next_log_block);
>  			}
>  
>  			/* If it is a valid descriptor block, replay it
> @@ -535,6 +546,7 @@ static int do_one_pass(journal_t *journal,
>  			if (pass != PASS_REPLAY) {
>  				if (pass == PASS_SCAN &&
>  				    jbd2_has_feature_checksum(journal) &&
> +				    !need_check_commit_time &&
>  				    !info->end_transaction) {
>  					if (calc_chksums(journal, bh,
>  							&next_log_block,
> @@ -683,11 +695,50 @@ static int do_one_pass(journal_t *journal,
>  			 *	 mentioned conditions. Hence assume
>  			 *	 "Interrupted Commit".)
>  			 */
> -
> +			/*
> +			 * If need_check_commit_time is set, it means
> +			 * csum verify failed before, if commit_time is
> +			 * increasing, it's same journal, otherwise it
> +			 * is stale journal block, just end this
> +			 * recovery.
> +			 */
> +			if (pass == PASS_SCAN) {
> +				struct commit_header *cbh =
> +					(struct commit_header *)bh->b_data;
> +				commit_time =
> +					be64_to_cpu(cbh->h_commit_sec);
> +				/*
> +				 * When need check commit time, it means csum
> +				 * verify failed before, if commit time is
> +				 * increasing, it's same journal, otherwise
> +				 * not same journal, just end this recovery.
> +				 */
> +				if (need_check_commit_time) {
> +					if (commit_time >=
> +						last_trans_commit_time) {
> +						pr_err("JBD2: Invalid checksum found in transaction %u\n",
> +								next_commit_ID);
> +						err = -EFSBADCRC;
> +						brelse(bh);
> +						goto failed;
> +					}
> +					/*
> +					 * It likely does not belong to same
> +					 * journal, just end this recovery with
> +					 * success.
> +					 */
> +					jbd_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
> +							next_commit_ID);
> +					err = 0;
> +					brelse(bh);
> +					goto done;
> +				}
> +			}
>  			/* Found an expected commit block: if checksums
>  			 * are present verify them in PASS_SCAN; else not
>  			 * much to do other than move on to the next sequence
> -			 * number. */
> +			 * number.
> +			 */
>  			if (pass == PASS_SCAN &&
>  			    jbd2_has_feature_checksum(journal)) {
>  				int chksum_err, chksum_seen;
> @@ -727,6 +778,13 @@ static int do_one_pass(journal_t *journal,
>  						chksum_err = 1;
>  
>  				if (chksum_err) {
> +					if (commit_time <
> +						last_trans_commit_time) {
> +						jbd_debug(1, "JBD2: Invalid commit checksum ignored in transaction %u, likely stale data\n",
> +							next_log_block);
> +						brelse(bh);
> +						goto done;
> +					}
>  					info->end_transaction = next_commit_ID;
>  
>  					if (!jbd2_has_feature_async_commit(journal)) {
> @@ -741,6 +799,12 @@ static int do_one_pass(journal_t *journal,
>  			if (pass == PASS_SCAN &&
>  			    !jbd2_commit_block_csum_verify(journal,
>  							   bh->b_data)) {
> +				if (commit_time < last_trans_commit_time) {
> +					jbd_debug(1, "JBD2: Invalid commit checksum ignored in transaction %u, likely stale data\n",
> +						next_log_block);
> +					brelse(bh);
> +					goto done;
> +				}
>  				info->end_transaction = next_commit_ID;
>  
>  				if (!jbd2_has_feature_async_commit(journal)) {
> @@ -750,11 +814,25 @@ static int do_one_pass(journal_t *journal,
>  					break;
>  				}
>  			}
> +			if (pass == PASS_SCAN)
> +				last_trans_commit_time = commit_time;
>  			brelse(bh);
>  			next_commit_ID++;
>  			continue;
>  
>  		case JBD2_REVOKE_BLOCK:
> +			/*
> +			 * Check revoke block crc in pass_scan, if csum verify
> +			 * failed, check commit block time later.
> +			 */
> +			if (pass == PASS_SCAN) {
> +				if (!jbd2_descriptor_block_csum_verify(journal,
> +						bh->b_data)) {
> +					jbd_debug(1, "invalid revoke block found in %lu\n",
> +						next_log_block);
> +					need_check_commit_time = true;
> +				}
> +			}
>  			/* If we aren't in the REVOKE pass, then we can
>  			 * just skip over this block. */
>  			if (pass != PASS_REVOKE) {
> @@ -822,9 +900,6 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
>  	offset = sizeof(jbd2_journal_revoke_header_t);
>  	rcount = be32_to_cpu(header->r_count);
>  
> -	if (!jbd2_descriptor_block_csum_verify(journal, header))
> -		return -EFSBADCRC;
> -
>  	if (jbd2_journal_has_csum_v2or3(journal))
>  		csum_size = sizeof(struct jbd2_journal_block_tail);
>  	if (rcount > journal->j_blocksize - csum_size)
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
