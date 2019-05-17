Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839EC2155E
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2019 10:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfEQI3X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 May 2019 04:29:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:49918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727825AbfEQI3X (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 17 May 2019 04:29:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55426AE3E;
        Fri, 17 May 2019 08:29:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E7E501E3ED6; Fri, 17 May 2019 10:29:18 +0200 (CEST)
Date:   Fri, 17 May 2019 10:29:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gaowei Pu <pugaowei@gmail.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: fix some print format mistakes
Message-ID: <20190517082918.GA20550@quack2.suse.cz>
References: <20190517061951.13730-1-pugaowei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517061951.13730-1-pugaowei@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 17-05-19 14:19:51, Gaowei Pu wrote:
> There are some print format mistakes in debug messages. Fix them.
> 
> Signed-off-by: Gaowei Pu <pugaowei@gmail.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 37e16d969925..565e99b67b30 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -203,7 +203,7 @@ static int kjournald2(void *arg)
>  	if (journal->j_flags & JBD2_UNMOUNT)
>  		goto end_loop;
>  
> -	jbd_debug(1, "commit_sequence=%d, commit_request=%d\n",
> +	jbd_debug(1, "commit_sequence=%u, commit_request=%u\n",
>  		journal->j_commit_sequence, journal->j_commit_request);
>  
>  	if (journal->j_commit_sequence != journal->j_commit_request) {
> @@ -324,7 +324,7 @@ static void journal_kill_thread(journal_t *journal)
>   * IO is in progress. do_get_write_access() handles this.
>   *
>   * The function returns a pointer to the buffer_head to be used for IO.
> - * 
> + *
>   *
>   * Return value:
>   *  <0: Error
> @@ -500,7 +500,7 @@ int __jbd2_log_start_commit(journal_t *journal, tid_t target)
>  		 */
>  
>  		journal->j_commit_request = target;
> -		jbd_debug(1, "JBD2: requesting commit %d/%d\n",
> +		jbd_debug(1, "JBD2: requesting commit %u/%u\n",
>  			  journal->j_commit_request,
>  			  journal->j_commit_sequence);
>  		journal->j_running_transaction->t_requested = jiffies;
> @@ -513,7 +513,7 @@ int __jbd2_log_start_commit(journal_t *journal, tid_t target)
>  		WARN_ONCE(1, "JBD2: bad log_start_commit: %u %u %u %u\n",
>  			  journal->j_commit_request,
>  			  journal->j_commit_sequence,
> -			  target, journal->j_running_transaction ? 
> +			  target, journal->j_running_transaction ?
>  			  journal->j_running_transaction->t_tid : 0);
>  	return 0;
>  }
> @@ -698,12 +698,12 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
>  #ifdef CONFIG_JBD2_DEBUG
>  	if (!tid_geq(journal->j_commit_request, tid)) {
>  		printk(KERN_ERR
> -		       "%s: error: j_commit_request=%d, tid=%d\n",
> +		       "%s: error: j_commit_request=%u, tid=%u\n",
>  		       __func__, journal->j_commit_request, tid);
>  	}
>  #endif
>  	while (tid_gt(tid, journal->j_commit_sequence)) {
> -		jbd_debug(1, "JBD2: want %d, j_commit_sequence=%d\n",
> +		jbd_debug(1, "JBD2: want %u, j_commit_sequence=%u\n",
>  				  tid, journal->j_commit_sequence);
>  		read_unlock(&journal->j_state_lock);
>  		wake_up(&journal->j_wait_commit);
> @@ -944,7 +944,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
>  
>  	trace_jbd2_update_log_tail(journal, tid, block, freed);
>  	jbd_debug(1,
> -		  "Cleaning journal tail from %d to %d (offset %lu), "
> +		  "Cleaning journal tail from %u to %u (offset %lu), "
>  		  "freeing %lu\n",
>  		  journal->j_tail_sequence, tid, block, freed);
>  
> @@ -1318,7 +1318,7 @@ static int journal_reset(journal_t *journal)
>  	 */
>  	if (sb->s_start == 0) {
>  		jbd_debug(1, "JBD2: Skipping superblock update on recovered sb "
> -			"(start %ld, seq %d, errno %d)\n",
> +			"(start %ld, seq %u, errno %d)\n",
>  			journal->j_tail, journal->j_tail_sequence,
>  			journal->j_errno);
>  		journal->j_flags |= JBD2_FLUSHED;
> @@ -1453,7 +1453,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
>  		return;
>  	}
>  
> -	jbd_debug(1, "JBD2: Marking journal as empty (seq %d)\n",
> +	jbd_debug(1, "JBD2: Marking journal as empty (seq %u)\n",
>  		  journal->j_tail_sequence);
>  
>  	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
> -- 
> 2.21.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
