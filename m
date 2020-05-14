Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B341B1D2BA7
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgENJmg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 05:42:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgENJmf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 May 2020 05:42:35 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E9VfMZ045618;
        Thu, 14 May 2020 05:42:33 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 310uaunaqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 05:42:32 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04E9a825025589;
        Thu, 14 May 2020 09:42:30 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3100ubhc7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 09:42:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04E9gRh365601584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 09:42:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A14E44C058;
        Thu, 14 May 2020 09:42:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67D044C040;
        Thu, 14 May 2020 09:42:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.39.201])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 May 2020 09:42:26 +0000 (GMT)
Subject: Re: [PATCH 1/2] ext4: mballoc to prefetch groups ahead of scanning
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <DF4ADFBC-BC4B-4E6A-894A-5BCED5464F42@whamcloud.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 14 May 2020 15:12:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <DF4ADFBC-BC4B-4E6A-894A-5BCED5464F42@whamcloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200514094226.67D044C040@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140082
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Alex,

Few comments to understand the patch better.

On 4/28/20 10:50 AM, Alex Zhuravlev wrote:
> Hi,
> 
> Here is a refreshed patch to improve bitmap loading.
> This should significantly improve bitmap loading, especially for flex groups as it tries
> to load all bitmaps within a flex.group instead of one by one synchronously.
> 
> Prefetching is done in 8 * flex_bg groups, so it should be 8 read-ahead
> reads for a single allocating thread. At the end of allocation the
> thread waits for read-ahead completion and initializes buddy information
> so that read-aheads are not lost in case of memory pressure.
> 
> At cr=0 the number of prefetching IOs is limited per allocation context
> to prevent a situation when mballoc loads thousands of bitmaps looking
> for a perfect group and ignoring groups with good chunks.
Not sure if I completely understand above. Care to explain a bit more
pls?


> 
> Together with the patch "ext4: limit scanning of uninitialized groups"
Where is this patch which says ^^^^^ ?

> the mount time of a 1PB filesystem is reduced significantly:
> 
>                 0% full    50%-full unpatched    patched
>    mount time       33s                9279s       563s

Looks good. Do you have perf improvement numbers with this patch alone?
Wonder if this could show improvement if I make my FS image using dm-sparse?

> 
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-12988

Not sure if this is required.

> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
> Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
> ---
>   fs/ext4/balloc.c  |  12 +++++-
>   fs/ext4/ext4.h    |   5 ++-
>   fs/ext4/mballoc.c | 106 +++++++++++++++++++++++++++++++++++++++++++++-
>   fs/ext4/mballoc.h |   2 +
>   fs/ext4/sysfs.c   |   4 ++
>   5 files changed, 125 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index a32e5f7b5385..dc6cc8c7b0f8 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -413,7 +413,8 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
>    * Return buffer_head on success or an ERR_PTR in case of failure.
>    */
>   struct buffer_head *
> -ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
> +ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
> +				 int ignore_locked)

Should make ignore_locked as boolean.

>   {
>   	struct ext4_group_desc *desc;
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
> @@ -444,6 +445,13 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
>   	if (bitmap_uptodate(bh))
>   		goto verify;
>   
> +	if (ignore_locked && buffer_locked(bh)) {
> +		/* buffer under IO already, do not wait
> +		 * if called for prefetching */
> +		put_bh(bh);
> +		return NULL;
> +	}
> +
>   	lock_buffer(bh);
>   	if (bitmap_uptodate(bh)) {
>   		unlock_buffer(bh);
> @@ -534,7 +542,7 @@ ext4_read_block_bitmap(struct super_block *sb, ext4_group_t block_group)
>   	struct buffer_head *bh;
>   	int err;
>   
> -	bh = ext4_read_block_bitmap_nowait(sb, block_group);
> +	bh = ext4_read_block_bitmap_nowait(sb, block_group, 0);
>   	if (IS_ERR(bh))
>   		return bh;
>   	err = ext4_wait_block_bitmap(sb, block_group, bh);
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 91eb4381cae5..1a4afaecc967 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1483,6 +1483,8 @@ struct ext4_sb_info {
>   	/* where last allocation was done - for stream allocation */
>   	unsigned long s_mb_last_group;
>   	unsigned long s_mb_last_start;
> +	unsigned int s_mb_prefetch;
> +	unsigned int s_mb_prefetch_limit;
>   
>   	/* stats for buddy allocator */
>   	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
> @@ -2420,7 +2422,8 @@ extern struct ext4_group_desc * ext4_get_group_desc(struct super_block * sb,
>   extern int ext4_should_retry_alloc(struct super_block *sb, int *retries);
>   
>   extern struct buffer_head *ext4_read_block_bitmap_nowait(struct super_block *sb,
> -						ext4_group_t block_group);
> +						ext4_group_t block_group,
> +						int ignore_locked);
>   extern int ext4_wait_block_bitmap(struct super_block *sb,
>   				  ext4_group_t block_group,
>   				  struct buffer_head *bh);
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 30d5d97548c4..e84c298e739b 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -861,7 +861,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
>   			bh[i] = NULL;
>   			continue;
>   		}
> -		bh[i] = ext4_read_block_bitmap_nowait(sb, group);
> +		bh[i] = ext4_read_block_bitmap_nowait(sb, group, 0);
>   		if (IS_ERR(bh[i])) {
>   			err = PTR_ERR(bh[i]);
>   			bh[i] = NULL;
> @@ -2104,6 +2104,87 @@ static int ext4_mb_good_group(struct ext4_allocation_context *ac,
>   	return 0;
>   }
>   
> +/*
> + * each allocation context (i.e. a thread doing allocation) has own
> + * sliding prefetch window of @s_mb_prefetch size which starts at the
> + * very first goal and moves ahead of scaning.
> + * a side effect is that subsequent allocations will likely find
> + * the bitmaps in cache or at least in-flight.
> + */
> +static void
> +ext4_mb_prefetch(struct ext4_allocation_context *ac,
> +		    ext4_group_t start)
> +{
> +	struct super_block *sb = ac->ac_sb;
> +	ext4_group_t ngroups = ext4_get_groups_count(sb);
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_group_info *grp;
> +	ext4_group_t group = start;
> +	struct buffer_head *bh;
> +	int nr;
nr should be of type ext4_group_t.



> +
> +	/* limit prefetching at cr=0, otherwise mballoc can
> +	 * spend a lot of time loading imperfect groups */

Sorry not sure if I understand this completely. Please explain this
a bit further.


> +	if (ac->ac_criteria < 2 && ac->ac_prefetch_ios >= sbi->s_mb_prefetch_limit)
> +		return;

So, what is ac_criteria is 3? We go and prefetch in that case?
Or maybe do you mean that before even ac_critera reaches 3, the other
condition may become false?


> +
> +	/* batch prefetching to get few READs in flight */
> +	nr = ac->ac_prefetch - group;
> +	if (ac->ac_prefetch < group)
> +		/* wrapped to the first groups */
> +		nr += ngroups;
> +	if (nr > 0)
> +		return;
> +	BUG_ON(nr < 0);

Ok, so IIUC, we are doing this prefetching only once at the start of
each allocation criteria. Because only that time nr will be 0.
i.e. ac->ac_prefetch == group.
Is that the case?


> +
> +	nr = sbi->s_mb_prefetch;
> +	if (ext4_has_feature_flex_bg(sb)) {
> +		/* align to flex_bg to get more bitmas with a single IO */

/s/bitmas/bitmaps/

> +		nr = (group / sbi->s_mb_prefetch) * sbi->s_mb_prefetch;
> +		nr = nr + sbi->s_mb_prefetch - group;
> +	}
> +	while (nr-- > 0) {
> +		grp = ext4_get_group_info(sb, group);
> +		/* ignore empty groups - those will be skipped
> +		 * during the scanning as well */
> +		if (grp->bb_free > 0 && EXT4_MB_GRP_NEED_INIT(grp)) {
> +			bh = ext4_read_block_bitmap_nowait(sb, group, 1);
> +			if (bh && !IS_ERR(bh)) {
> +				if (!buffer_uptodate(bh))
> +					ac->ac_prefetch_ios++;
> +				brelse(bh);
> +			}
> +		}
> +		if (++group >= ngroups)
> +			group = 0;

So say nr = 32. and the group that you are started with has
value = (ngroups - 32). Then when we are looping for the final time,
nr will be 0, and the above check will make group = 0



> +	}
> +	ac->ac_prefetch = group;

Here we will make ac_prefetch = 0 for above case described.
Now as per the logic in ext4_mb_prefetch_fini()
you will start with this group 0 whose bitmap is not even loaded yet.
and since that loop will only be called for ac_prefetch_times,
you will miss one group whose bitmap was actually loaded.

Though this case could be a corner case, but maybe something to be
improved upon? Thoughts?


> +}
> +
> +static void
> +ext4_mb_prefetch_fini(struct ext4_allocation_context *ac)

Did you mean ext4_mb_prefetch_finish()?
Not sure if I understand the function name completely.


> +{
> +	struct ext4_group_info *grp;
> +	ext4_group_t group;
> +	int nr, rc;
> +
> +	/* initialize last window of prefetched groups */
> +	nr = ac->ac_prefetch_ios;
> +	if (nr > EXT4_SB(ac->ac_sb)->s_mb_prefetch)
> +		nr = EXT4_SB(ac->ac_sb)->s_mb_prefetch;
> +	group = ac->ac_prefetch;
> +	while (nr-- > 0) {
> +		grp = ext4_get_group_info(ac->ac_sb, group);
> +		if (grp->bb_free > 0 && EXT4_MB_GRP_NEED_INIT(grp)) {
> +			rc = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
> +			if (rc)
> +				break;
> +		}
> +		if (group-- == 0)
> +			group = ext4_get_groups_count(ac->ac_sb) - 1;

why play with an unsigned int like this in above.
below looks much simpler no?

if (group == 0)
	group = ext4_get_groups_count(ac->ac_sb);
group--;


> +	}
> +}
> +
>   static noinline_for_stack int
>   ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>   {
> @@ -2177,6 +2258,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>   		 * from the goal value specified
>   		 */
>   		group = ac->ac_g_ex.fe_group;
> +		ac->ac_prefetch = group;
>   
>   		for (i = 0; i < ngroups; group++, i++) {
>   			int ret = 0;
> @@ -2188,6 +2270,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>   			if (group >= ngroups)
>   				group = 0;
>   
> +			ext4_mb_prefetch(ac, group);
> +
>   			/* This now checks without needing the buddy page */
>   			ret = ext4_mb_good_group(ac, group, cr);
>   			if (ret <= 0) {
> @@ -2260,6 +2344,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>   out:
>   	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
>   		err = first_err;
> +	/* use prefetched bitmaps to init buddy so that read info is not lost */
> +	ext4_mb_prefetch_fini(ac);
>   	return err;
>   }
>   
> @@ -2776,6 +2862,24 @@ int ext4_mb_release(struct super_block *sb)
>   				atomic_read(&sbi->s_mb_preallocated),
>   				atomic_read(&sbi->s_mb_discarded));
>   	}
> +	if (ext4_has_feature_flex_bg(sb)) {
> +		/* a single flex group is supposed to be read by a single IO */
> +		sbi->s_mb_prefetch = 1 << sbi->s_es->s_log_groups_per_flex;
> +		sbi->s_mb_prefetch *= 8; /* 8 prefetch IOs in flight at most */
> +	} else {
> +		sbi->s_mb_prefetch = 32;
> +	}
> +	if (sbi->s_mb_prefetch > ext4_get_groups_count(sb))
> +		sbi->s_mb_prefetch = ext4_get_groups_count(sb);
> +	/* now many real IOs to prefetch within a single allocation at cr=0
> +	 * given cr=0 is an CPU-related optimization we shouldn't try to
> +	 * load too many groups, at some point we should start to use what
> +	 * we've got in memory.
> +	 * with an average random access time 5ms, it'd take a second to get
> +	 * 200 groups (* N with flex_bg), so let's make this limit 4 */
> +	sbi->s_mb_prefetch_limit = sbi->s_mb_prefetch * 4;
> +	if (sbi->s_mb_prefetch_limit > ext4_get_groups_count(sb))
> +		sbi->s_mb_prefetch_limit = ext4_get_groups_count(sb);
>   
>   	free_percpu(sbi->s_locality_groups);
>   
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 88c98f17e3d9..c96a2bd81f72 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -175,6 +175,8 @@ struct ext4_allocation_context {
>   	struct page *ac_buddy_page;
>   	struct ext4_prealloc_space *ac_pa;
>   	struct ext4_locality_group *ac_lg;
> +	ext4_group_t ac_prefetch;
> +	int ac_prefetch_ios; /* number of initialied prefetch IO */
>   };
>   
>   #define AC_STATUS_CONTINUE	1
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 04bfaf63752c..5f443f9d54b8 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -240,6 +240,8 @@ EXT4_RO_ATTR_ES_STRING(last_error_func, s_last_error_func, 32);
>   EXT4_ATTR(first_error_time, 0444, first_error_time);
>   EXT4_ATTR(last_error_time, 0444, last_error_time);
>   EXT4_ATTR(journal_task, 0444, journal_task);
> +EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
> +EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
>   
>   static unsigned int old_bump_val = 128;
>   EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> @@ -283,6 +285,8 @@ static struct attribute *ext4_attrs[] = {
>   #ifdef CONFIG_EXT4_DEBUG
>   	ATTR_LIST(simulate_fail),
>   #endif
> +	ATTR_LIST(mb_prefetch),
> +	ATTR_LIST(mb_prefetch_limit),
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(ext4);
> 
