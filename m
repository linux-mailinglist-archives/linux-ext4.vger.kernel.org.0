Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE526A4C4
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgIOMMw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Sep 2020 08:12:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:53378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIOMLw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Sep 2020 08:11:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 533ECB5A4;
        Tue, 15 Sep 2020 12:11:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9F78D1E12EF; Tue, 15 Sep 2020 14:11:22 +0200 (CEST)
Date:   Tue, 15 Sep 2020 14:11:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4]  ext4: Fix dead loop in ext4_mb_new_blocks
Message-ID: <20200915121122.GN4863@quack2.suse.cz>
References: <20200914104742.1745082-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <20200914104742.1745082-1-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 14-09-20 18:47:42, Ye Bin wrote:
> As we test disk offline/online with running fsstress, we find fsstress
> process is keeping running state.
> kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114
> ....
> kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114
> 
> ext4_mb_new_blocks
> repeat:
>         ext4_mb_discard_preallocations_should_retry(sb, ac, &seq)
>                 freed = ext4_mb_discard_preallocations
>                         ext4_mb_discard_group_preallocations
>                                 this_cpu_inc(discard_pa_seq);
>                 ---> freed == 0
>                 seq_retry = ext4_get_discard_pa_seq_sum
>                         for_each_possible_cpu(__cpu)
>                                 __seq += per_cpu(discard_pa_seq, __cpu);
>                 if (seq_retry != *seq) {
>                         *seq = seq_retry;
>                         ret = true;
>                 }
> 
> As we see seq_retry is sum of discard_pa_seq every cpu, if
> ext4_mb_discard_group_preallocations return zero discard_pa_seq in this
> cpu maybe increase one, so condition "seq_retry != *seq" have always
> been met.
> Ritesh Harjani suggest to in ext4_mb_discard_group_preallocations function we
> only increase discard_pa_seq when there is some PA to free.
> 
> Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

But as I mentioned in my previous reply I also think the attached patch
also needs to be merged to avoid premature ENOSPC errors (which your change
makes somewhat more likely). Ritesh do you agree?

								Honza


> ---
>  fs/ext4/mballoc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 132c118d12e1..ff47347012f4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4189,7 +4189,6 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  	INIT_LIST_HEAD(&list);
>  repeat:
>  	ext4_lock_group(sb, group);
> -	this_cpu_inc(discard_pa_seq);
>  	list_for_each_entry_safe(pa, tmp,
>  				&grp->bb_prealloc_list, pa_group_list) {
>  		spin_lock(&pa->pa_lock);
> @@ -4206,6 +4205,9 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  		/* seems this one can be freed ... */
>  		ext4_mb_mark_pa_deleted(sb, pa);
>  
> +		if (!free)
> +			this_cpu_inc(discard_pa_seq);
> +
>  		/* we can trust pa_free ... */
>  		free += pa->pa_free;
>  
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--GZVR6ND4mMseVXL/
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-ext4-Discard-preallocations-before-releasing-group-l.patch"

From ce4bb26350da47a6c07be378bf478e5a81bc96d4 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 15 Sep 2020 13:54:20 +0200
Subject: [PATCH] ext4: Discard preallocations before releasing group lock

ext4_mb_discard_group_preallocations() can be releasing group lock with
preallocations accumulated on its local list. Thus although
discard_pa_seq was incremented and concurrent allocating processes will
be retrying allocations, it can happen that premature ENOSPC error is
returned because blocks used for preallocations are not available for
reuse yet. Make sure we always free locally accumulated preallocations
before releasing group lock.

Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 132c118d12e1..0ded25d55d9b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4215,22 +4215,6 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		list_add(&pa->u.pa_tmp_list, &list);
 	}
 
-	/* if we still need more blocks and some PAs were used, try again */
-	if (free < needed && busy) {
-		busy = 0;
-		ext4_unlock_group(sb, group);
-		cond_resched();
-		goto repeat;
-	}
-
-	/* found anything to free? */
-	if (list_empty(&list)) {
-		BUG_ON(free != 0);
-		mb_debug(sb, "Someone else may have freed PA for this group %u\n",
-			 group);
-		goto out;
-	}
-
 	/* now free all selected PAs */
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 
@@ -4248,6 +4232,16 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
 	}
 
+	/* if we still need more blocks and some PAs were used, try again */
+	if (free < needed && busy) {
+		ext4_unlock_group(sb, group);
+		cond_resched();
+		busy = 0;
+		/* Make sure we increment discard_pa_seq again */
+		needed -= free;
+		free = 0;
+		goto repeat;
+	}
 out:
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
-- 
2.16.4


--GZVR6ND4mMseVXL/--
