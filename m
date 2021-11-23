Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F8459F66
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Nov 2021 10:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhKWJoI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Nov 2021 04:44:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46470 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhKWJoH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Nov 2021 04:44:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1FF832171F;
        Tue, 23 Nov 2021 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637660459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w7dc313dal0202LofCH+BjxG2ZPhaIaRUROC0jGIafI=;
        b=GdfsDsZSs46Mll3aknM+YZPRk0XtyEgZ21rnH/QddyQl3AzUEPPoeogS3KcptOME9IDBYJ
        0kr75gD4yrIf9tGqXMh0nCGAxwxdKn/XaT6t/DhhPUC62SSARkrTYUt2N9JuOoj+VtSw5R
        f+QoQlCjmnujW7ETGxBfgxezFY4rLU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637660459;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w7dc313dal0202LofCH+BjxG2ZPhaIaRUROC0jGIafI=;
        b=olJRCCBe++eBLrag1s9akwC1PFD8DDdqRtpf455tNzBR2GLHQYQBSP4ygJ0xqs/2Qfsh0d
        YkmBUCwDvdu6KsDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1160FA3B81;
        Tue, 23 Nov 2021 09:40:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 543321E0C01; Tue, 23 Nov 2021 10:40:56 +0100 (CET)
Date:   Tue, 23 Nov 2021 10:40:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        riteshh@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: fix a possible ABBA deadlock dued to busy PA
Message-ID: <20211123094056.GB8583@quack2.suse.cz>
References: <1637630277-23496-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637630277-23496-1-git-send-email-brookxu.cn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 23-11-21 09:17:57, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> We found on older kernel (3.10) that in the scenario of insufficient
> disk space, system may trigger an ABBA deadlock problem, it seems that
> this problem still exists in latest kernel, try to fix it here. The
> main process triggered by this problem is that task A occupies the PA
> and waits for the jbd2 transaction finish, the jbd2 transaction waits
> for the completion of task B's IO (plug_list), but task B waits for
> the release of PA by task A to finish discard, which indirectly forms
> an ABBA deadlock. The related calltrace is as follows:
> 
>     Task A
>     vfs_write
>     ext4_mb_new_blocks()
>     ext4_mb_mark_diskspace_used()       JBD2
>     jbd2_journal_get_write_access()  -> jbd2_journal_commit_transaction()
>   ->schedule()                          filemap_fdatawait()
>  |                                              |
>  | Task B                                       |
>  | do_unlinkat()                                |
>  | ext4_evict_inode()                           |
>  | jbd2_journal_begin_ordered_truncate()        |
>  | filemap_fdatawrite_range()                   |
>  | ext4_mb_new_blocks()                         |
>   -ext4_mb_discard_group_preallocations() <-----
> 
> Here, try to cancel ext4_mb_discard_group_preallocations() internal
> retry due to PA busy, and do a limited number of retries inside
> ext4_mb_discard_preallocations(), which can circumvent the above
> problems, but also has some advantages:
> 
> 1. Since the PA is in a busy state, if other groups have free PAs,
>    keeping the current PA may help to reduce fragmentation.
> 2. Continue to traverse forward instead of waiting for the current
>    group PA to be released. In most scenarios, the PA discard time
>    can be reduced.
> 
> However, in the case of smaller free space, if only a few groups have
> space, then due to multiple traversals of the group, it may increase
> CPU overhead. But in contrast, I feel that the overall benefit is
> better than the cost.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> v2: reset busy to zero before goto repeat.
> v3: fix a clang-analyzer warning report by kernel test robot.

Thanks for the patch. Still looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
>  fs/ext4/mballoc.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 215b706..3dd9b9e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4814,7 +4814,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>   */
>  static noinline_for_stack int
>  ext4_mb_discard_group_preallocations(struct super_block *sb,
> -					ext4_group_t group, int needed)
> +				     ext4_group_t group, int *busy)
>  {
>  	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
>  	struct buffer_head *bitmap_bh = NULL;
> @@ -4822,8 +4822,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>  	struct list_head list;
>  	struct ext4_buddy e4b;
>  	int err;
> -	int busy = 0;
> -	int free, free_total = 0;
> +	int free = 0;
>  
>  	mb_debug(sb, "discard preallocation for group %u\n", group);
>  	if (list_empty(&grp->bb_prealloc_list))
> @@ -4846,19 +4845,14 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>  		goto out_dbg;
>  	}
>  
> -	if (needed == 0)
> -		needed = EXT4_CLUSTERS_PER_GROUP(sb) + 1;
> -
>  	INIT_LIST_HEAD(&list);
> -repeat:
> -	free = 0;
>  	ext4_lock_group(sb, group);
>  	list_for_each_entry_safe(pa, tmp,
>  				&grp->bb_prealloc_list, pa_group_list) {
>  		spin_lock(&pa->pa_lock);
>  		if (atomic_read(&pa->pa_count)) {
>  			spin_unlock(&pa->pa_lock);
> -			busy = 1;
> +			*busy = 1;
>  			continue;
>  		}
>  		if (pa->pa_deleted) {
> @@ -4898,22 +4892,13 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>  		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
>  	}
>  
> -	free_total += free;
> -
> -	/* if we still need more blocks and some PAs were used, try again */
> -	if (free_total < needed && busy) {
> -		ext4_unlock_group(sb, group);
> -		cond_resched();
> -		busy = 0;
> -		goto repeat;
> -	}
>  	ext4_unlock_group(sb, group);
>  	ext4_mb_unload_buddy(&e4b);
>  	put_bh(bitmap_bh);
>  out_dbg:
>  	mb_debug(sb, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
> -		 free_total, group, grp->bb_free);
> -	return free_total;
> +		 free, group, grp->bb_free);
> +	return free;
>  }
>  
>  /*
> @@ -5455,13 +5440,24 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
>  {
>  	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
>  	int ret;
> -	int freed = 0;
> +	int freed = 0, busy = 0;
> +	int retry = 0;
>  
>  	trace_ext4_mb_discard_preallocations(sb, needed);
> +
> +	if (needed == 0)
> +		needed = EXT4_CLUSTERS_PER_GROUP(sb) + 1;
> + repeat:
>  	for (i = 0; i < ngroups && needed > 0; i++) {
> -		ret = ext4_mb_discard_group_preallocations(sb, i, needed);
> +		ret = ext4_mb_discard_group_preallocations(sb, i, &busy);
>  		freed += ret;
>  		needed -= ret;
> +		cond_resched();
> +	}
> +
> +	if (needed > 0 && busy && ++retry < 3) {
> +		busy = 0;
> +		goto repeat;
>  	}
>  
>  	return freed;
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
