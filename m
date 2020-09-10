Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B760263EF5
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Sep 2020 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIJHtG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Sep 2020 03:49:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:38818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbgIJHtD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 10 Sep 2020 03:49:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90FD8AC83;
        Thu, 10 Sep 2020 07:49:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8AA771E12EB; Thu, 10 Sep 2020 09:49:01 +0200 (CEST)
Date:   Thu, 10 Sep 2020 09:49:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: Fix dead loop in ext4_mb_new_blocks
Message-ID: <20200910074901.GD17540@quack2.suse.cz>
References: <20200910030806.223411-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910030806.223411-1-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hello!

On Thu 10-09-20 11:08:06, Ye Bin wrote:
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
> To Fix this problem, ext4_get_discard_pa_seq_sum function couldn't add
> own's cpu "discard_pa_seq" value.
> 
> Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks for the patch! I agree with your analysis but avoiding current CPU
in the sum is wrong. After all there's nothing which prevents the scheduler
from rescheduling your task among different CPUs while it is searching for
preallocations to discard. The correct fix is IMO to change
ext4_mb_discard_group_preallocations() so that it increments discard_pa_seq
only when it found preallocation to discard (and is thus guaranteed to
return value > 0).

								Honza

> ---
>  fs/ext4/mballoc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 132c118d12e1..f386fe62727d 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -372,11 +372,13 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
>  static DEFINE_PER_CPU(u64, discard_pa_seq);
>  static inline u64 ext4_get_discard_pa_seq_sum(void)
>  {
> -	int __cpu;
> +	int __cpu, this_cpu;
>  	u64 __seq = 0;
>  
> +	this_cpu = smp_processor_id();
>  	for_each_possible_cpu(__cpu)
> -		__seq += per_cpu(discard_pa_seq, __cpu);
> +		if (this_cpu != __cpu)
> +			__seq += per_cpu(discard_pa_seq, __cpu);
>  	return __seq;
>  }
>  
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
