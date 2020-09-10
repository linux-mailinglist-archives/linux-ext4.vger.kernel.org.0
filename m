Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4146264AFB
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Sep 2020 19:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgIJRTx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Sep 2020 13:19:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:56282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgIJQSB (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 10 Sep 2020 12:18:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A51CB229;
        Thu, 10 Sep 2020 16:18:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7007B1E12EB; Thu, 10 Sep 2020 18:17:53 +0200 (CEST)
Date:   Thu, 10 Sep 2020 18:17:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v3] ext4: Fix dead loop in ext4_mb_new_blocks
Message-ID: <20200910161753.GB17362@quack2.suse.cz>
References: <20200910091252.525346-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910091252.525346-1-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-09-20 17:12:52, Ye Bin wrote:
> As we test disk offline/online with running fsstress, we find fsstress
> process is keeping running state.
> kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114
> ....
> kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114
> 
> ext4_mb_new_blocks
> repeat:
> 	ext4_mb_discard_preallocations_should_retry(sb, ac, &seq)
> 		freed = ext4_mb_discard_preallocations
> 			ext4_mb_discard_group_preallocations
> 				this_cpu_inc(discard_pa_seq);
> 		---> freed == 0
> 		seq_retry = ext4_get_discard_pa_seq_sum
> 			for_each_possible_cpu(__cpu)
> 				__seq += per_cpu(discard_pa_seq, __cpu);
> 		if (seq_retry != *seq) {
> 			*seq = seq_retry;
> 			ret = true;
> 		}
> 
> As we see seq_retry is sum of discard_pa_seq every cpu, if
> ext4_mb_discard_group_preallocations return zero discard_pa_seq in this
> cpu maybe increase one, so condition "seq_retry != *seq" have always
> been met.
> To Fix this problem, in ext4_mb_discard_group_preallocations function increase
> discard_pa_seq only when it found preallocation to discard.
> 
> Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks for the patch. One comment below.

> ---
>  fs/ext4/mballoc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f386fe62727d..fd55264dc3fe 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4191,7 +4191,6 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  	INIT_LIST_HEAD(&list);
>  repeat:
>  	ext4_lock_group(sb, group);
> -	this_cpu_inc(discard_pa_seq);
>  	list_for_each_entry_safe(pa, tmp,
>  				&grp->bb_prealloc_list, pa_group_list) {
>  		spin_lock(&pa->pa_lock);
> @@ -4233,6 +4232,9 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  		goto out;
>  	}
>  
> +	/* only increase when find reallocation to discard */
> +	this_cpu_inc(discard_pa_seq);
> +

This is a good place to increment the counter but I think you also need to
handle the case:

        if (free < needed && busy) {
                busy = 0;
                ext4_unlock_group(sb, group);
                cond_resched();
                goto repeat;
        }

We can unlock the group here after removing some preallocations and thus
other processes checking discard_pa_seq could miss we did this. In fact I
think the code is somewhat buggy here and we should also discard extents
accumulated on "list" so far before unlocking the group. Ritesh?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
