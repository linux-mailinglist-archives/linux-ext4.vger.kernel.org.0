Return-Path: <linux-ext4+bounces-6717-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE96A577A1
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 03:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07AB1891200
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 02:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E601465AE;
	Sat,  8 Mar 2025 02:26:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0B14AA9;
	Sat,  8 Mar 2025 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741400761; cv=none; b=Sl5FvC2Ynt3JFNDBgyfQFH95jyg6z9du8qPecjxOtlt1F+0Ntl6FflLJL5aG3vKt+71M9IKho3FoaTPUPlE3nJ+mJEVnIGKfYfmh9w+Euh49ZRLjyXiLhTp0bziknqp3PjcCZ3XgJ2+TZEVuIzWFy9GcCK4Lbrxt394QUYrL37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741400761; c=relaxed/simple;
	bh=BbyM1FMugdVrT11eiLsPsPBr3Y8rT+rtxvAokEU7dNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GWv25dyjYtYQM6XbP0MZysyxNXr+YIgvtgdDS2ym2sSm928RDLGg3g6EqlY/y+la9yj/+J8TFH0Rz8GMKxGhpk3JL84bLJc3WIA6piVtTc30ycY4r4EWJCYEwGMpX+YPyhZevgJgBRE7s7jh6PBI8Bqfy7ZFp6+SSltOHgCVZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z8n4Q1LsWz9wP9;
	Sat,  8 Mar 2025 10:22:46 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 50E00140380;
	Sat,  8 Mar 2025 10:25:55 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Mar
 2025 10:25:54 +0800
Message-ID: <6ab6dba8-c15e-49e8-966f-63a6e2df0590@huawei.com>
Date: Sat, 8 Mar 2025 10:25:53 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ext4: Make sb update interval tunable
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, "Ritesh Harjani (IBM)"
	<ritesh.list@gmail.com>, Yang Erkun <yangerkun@huawei.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <4c89be10ad8c8937048148bce1fc9ca882d060c6.1741270780.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <4c89be10ad8c8937048148bce1fc9ca882d060c6.1741270780.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/3/6 22:28, Ojaswin Mujoo wrote:
> Currently, outside error paths, we auto commit the super block after 1
> hour has passed and 16MB worth of updates have been written since last
> commit. This is a policy decision so make this tunable while keeping the
> defaults same. This is useful if user wants to tweak the superblock
> behavior or for debugging the codepath by allowing to trigger it more
> frequently.
>
> We can now tweak the super block update using sb_update_sec and
> sb_update_kb files in /sys/fs/ext4/<dev>/
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Looks good.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/ext4.h  |  9 +++++++++
>   fs/ext4/super.c | 15 ++++++++-------
>   fs/ext4/sysfs.c |  4 ++++
>   3 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index d48e93bd5690..82c902ed86f3 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1608,6 +1608,8 @@ struct ext4_sb_info {
>   	unsigned int s_mb_prefetch;
>   	unsigned int s_mb_prefetch_limit;
>   	unsigned int s_mb_best_avail_max_trim_order;
> +	unsigned int s_sb_update_sec;
> +	unsigned int s_sb_update_kb;
>   
>   	/* stats for buddy allocator */
>   	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
> @@ -2281,6 +2283,13 @@ static inline int ext4_forced_shutdown(struct super_block *sb)
>   #define EXT4_DEF_MIN_BATCH_TIME	0
>   #define EXT4_DEF_MAX_BATCH_TIME	15000 /* 15ms */
>   
> +/*
> + * Default values for superblock update
> + */
> +#define EXT4_DEF_SB_UPDATE_INTERVAL_SEC (3600) /* seconds (1 hour) */
> +#define EXT4_DEF_SB_UPDATE_INTERVAL_KB (16384) /* kilobytes (16MB) */
> +
> +
>   /*
>    * Minimum number of groups in a flexgroup before we separate out
>    * directories into the first block group of a flexgroup
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 31552cf0519a..1b47b111c583 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -447,9 +447,6 @@ static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
>   #define ext4_get_tstamp(es, tstamp) \
>   	__ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
>   
> -#define EXT4_SB_REFRESH_INTERVAL_SEC (3600) /* seconds (1 hour) */
> -#define EXT4_SB_REFRESH_INTERVAL_KB (16384) /* kilobytes (16MB) */
> -
>   /*
>    * The ext4_maybe_update_superblock() function checks and updates the
>    * superblock if needed.
> @@ -457,8 +454,10 @@ static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
>    * This function is designed to update the on-disk superblock only under
>    * certain conditions to prevent excessive disk writes and unnecessary
>    * waking of the disk from sleep. The superblock will be updated if:
> - * 1. More than an hour has passed since the last superblock update, and
> - * 2. More than 16MB have been written since the last superblock update.
> + * 1. More than sbi->s_sb_update_sec (def: 1 hour) has passed since the last
> + *    superblock update
> + * 2. More than sbi->s_sb_update_kb (def: 16MB) kbs have been written since the
> + *    last superblock update.
>    *
>    * @sb: The superblock
>    */
> @@ -479,7 +478,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
>   	now = ktime_get_real_seconds();
>   	last_update = ext4_get_tstamp(es, s_wtime);
>   
> -	if (likely(now - last_update < EXT4_SB_REFRESH_INTERVAL_SEC))
> +	if (likely(now - last_update < sbi->s_sb_update_sec))
>   		return;
>   
>   	lifetime_write_kbytes = sbi->s_kbytes_written +
> @@ -494,7 +493,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
>   	 */
>   	diff_size = lifetime_write_kbytes - le64_to_cpu(es->s_kbytes_written);
>   
> -	if (diff_size > EXT4_SB_REFRESH_INTERVAL_KB)
> +	if (diff_size > sbi->s_sb_update_kb)
>   		schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
>   }
>   
> @@ -5246,6 +5245,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>   	sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
>   	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
>   	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;
> +	sbi->s_sb_update_kb = EXT4_DEF_SB_UPDATE_INTERVAL_KB;
> +	sbi->s_sb_update_sec = EXT4_DEF_SB_UPDATE_INTERVAL_SEC;
>   
>   	/*
>   	 * set default s_li_wait_mult for lazyinit, for the case there is
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index ddb54608ca2e..987bd00f916a 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -254,6 +254,8 @@ EXT4_ATTR(journal_task, 0444, journal_task);
>   EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
>   EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
>   EXT4_RW_ATTR_SBI_UL(last_trim_minblks, s_last_trim_minblks);
> +EXT4_RW_ATTR_SBI_UI(sb_update_sec, s_sb_update_sec);
> +EXT4_RW_ATTR_SBI_UI(sb_update_kb, s_sb_update_kb);
>   
>   static unsigned int old_bump_val = 128;
>   EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> @@ -305,6 +307,8 @@ static struct attribute *ext4_attrs[] = {
>   	ATTR_LIST(mb_prefetch),
>   	ATTR_LIST(mb_prefetch_limit),
>   	ATTR_LIST(last_trim_minblks),
> +	ATTR_LIST(sb_update_sec),
> +	ATTR_LIST(sb_update_kb),
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(ext4);



