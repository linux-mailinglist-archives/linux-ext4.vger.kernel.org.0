Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D252356AF6
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Apr 2021 13:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351839AbhDGLRQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Apr 2021 07:17:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351798AbhDGLRL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Apr 2021 07:17:11 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137B3TX9008965;
        Wed, 7 Apr 2021 07:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=dlhgWl/T5Rfy50t09bgthZygC+RIKe2dm+2se+qFKgY=;
 b=TwJnv47e5WnBVowB8IQ8X+YXs3XxsloWGouqhfx7D8HKMdUEfwHpt5hABY/vT+9qrhAu
 lvNtUkiSm648NnvClOEZnbpm1hVyF6Y0oF0LflibGniADK+H4EeLrWnPIBOYx+TyqNGx
 BhNi3JuwAKeLuE3siG2hb6fHwRSMcKDuhoRTW/DUIGKn4g45LOSgLmRw2QN3l2JbmBIx
 JX1/3+bLn692RYeHRp245G27zVjXcr90zDxxCL8gJ6kBxG/Tyz7vsFDGjAcY2Qbh6D5t
 F/4HqObuhxQyON94lr6amKIoiTW+VpmpwbDcNcjJHjHh8Nv0fGL/x9XBViWHDlfYZlQl 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvn0dycv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 07:16:54 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 137B5JPq020831;
        Wed, 7 Apr 2021 07:16:53 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvn0dyc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 07:16:53 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137AvAbA018032;
        Wed, 7 Apr 2021 11:16:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37rvbu8n6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 11:16:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137BGRlv33161482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 11:16:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABDBBA405B;
        Wed,  7 Apr 2021 11:16:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 622B2A405F;
        Wed,  7 Apr 2021 11:16:48 +0000 (GMT)
Received: from localhost (unknown [9.85.69.78])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Apr 2021 11:16:48 +0000 (GMT)
Date:   Wed, 7 Apr 2021 16:46:47 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
        Wen Yang <simon.wy@alibaba-inc.com>,
        Baoyou Xie <baoyou.xie@alibaba-inc.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: add a configurable parameter to prevent endless
 loop in ext4_mb_discard_group_preallocations
Message-ID: <20210407111647.5cmknwltwl2rfvmu@riteshh-domain>
References: <20210407070141.49253-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407070141.49253-1-wenyang@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SXJZoYt-mC_tuicfZZS7U4e4GKbWb9pd
X-Proofpoint-ORIG-GUID: B5Da8p3WuObiC06NDCP-ib7l4FONW9Eg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_07:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070076
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/04/07 03:01PM, Wen Yang wrote:
> From: Wen Yang <simon.wy@alibaba-inc.com>
>
> The kworker has occupied 100% of the CPU for several days:
> PID USER  PR  NI VIRT RES SHR S  %CPU  %MEM TIME+  COMMAND
> 68086 root 20 0  0    0   0   R  100.0 0.0  9718:18 kworker/u64:11
>
> And the stack obtained through sysrq is as follows:
> [20613144.850426] task: ffff8800b5e08000 task.stack: ffffc9001342c000
> [20613144.850427] RIP: 0010:[<ffffffffa0240743>] ^Ac
> [<ffffffffa0240743>] ext4_mb_discard_group_preallocations+0x1b3/0x480
> [ext4]
> [20613144.850428] RSP: 0018:ffffc9001342f740  EFLAGS: 00000246
> [20613144.850428] RAX: 0000000000000000 RBX: ffff8813bb5f72f0 RCX:
> 0000000000000000
> [20613144.850429] RDX: 0000000000000001 RSI: ffff880268291d78 RDI:
> ffff880268291d98
> [20613144.850430] RBP: ffffc9001342f7e8 R08: 00493b8bc070da84 R09:
> 0000000000000000
> [20613144.850430] R10: 0000000000001800 R11: ffff880155e7c380 R12:
> ffff880268291d98
> [20613144.850431] R13: ffff8813bb5f72e0 R14: ffff880268291d78 R15:
> ffff880268291d68
> [20613144.850432] FS:  0000000000000000(0000) GS:ffff881fbf080000(0000)
> knlGS:0000000000000000
> [20613144.850432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [20613144.850433] CR2: 000000c000823010 CR3: 0000000001c08000 CR4:
> 00000000003606f0
> [20613144.850434] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [20613144.850434] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [20613144.850435] Stack:
> [20613144.850435]  ffff881942d6a6e8^Ac ffff8813bb5f72d0^Ac 00000001a02427cf^Ac 0000000000000140^Ac
> [20613144.850436]  ffff880f80618000^Ac 0000000000000000^Ac ffffc9001342f770^Ac ffffc9001342f770^Ac
> [20613144.850437]  ffffea0056360dc0^Ac ffff88158d837000^Ac ffffea0045155f80^Ac ffff88114557e000^Ac
> [20613144.850438] Call Trace:
> [20613144.850439]  [<ffffffffa0244209>] ext4_mb_new_blocks+0x429/0x550 [ext4]
> [20613144.850439]  [<ffffffffa02389ae>] ext4_ext_map_blocks+0xb5e/0xf30 [ext4]
> [20613144.850440]  [<ffffffff811c0001>] ? numa_zonelist_order_handler+0xa1/0x1c0
> [20613144.850441]  [<ffffffffa0204b52>] ext4_map_blocks+0x172/0x620 [ext4]
> [20613144.850441]  [<ffffffffa020835d>] ? ext4_writepages+0x4cd/0xf00 [ext4]
> [20613144.850442]  [<ffffffffa0208675>] ext4_writepages+0x7e5/0xf00 [ext4]
> [20613144.850442]  [<ffffffff811c1410>] ? wb_position_ratio+0x1f0/0x1f0
> [20613144.850443]  [<ffffffff811c487e>] do_writepages+0x1e/0x30
> [20613144.850444]  [<ffffffff81280265>] __writeback_single_inode+0x45/0x320
> [20613144.850444]  [<ffffffff81280ab2>] writeback_sb_inodes+0x272/0x600
> [20613144.850445]  [<ffffffff81280ed2>] __writeback_inodes_wb+0x92/0xc0
> [20613144.850445]  [<ffffffff81281238>] wb_writeback+0x268/0x300
> [20613144.850446]  [<ffffffff812819f4>] wb_workfn+0xb4/0x380
> [20613144.850447]  [<ffffffff810a5dc9>] process_one_work+0x189/0x420
> [20613144.850447]  [<ffffffff810a60ae>] worker_thread+0x4e/0x4b0
> [20613144.850448]  [<ffffffff810a6060>] ? process_one_work+0x420/0x420
> [20613144.850448]  [<ffffffff810ac696>] kthread+0xe6/0x100
> [20613144.850449]  [<ffffffff810ac5b0>] ? kthread_park+0x60/0x60
> [20613144.850450]  [<ffffffff81741dd9>] ret_from_fork+0x39/0x50
>
> The cpu resources of the cloud server are precious, and the server
> cannot be restarted after running for a long time, so a configuration
> parameter is added to prevent this endless loop.

Strange, if there is a endless loop here. Then I would definitely see
if there is any accounting problem in pa->pa_count. Otherwise busy=1
should not be set everytime. ext4_mb_show_pa() function may help debug this.

If yes, then that means there always exists either a file preallocation
or a group preallocation. Maybe it is possible, in some use case.
Others may know of such use case, if any.

>
>
>
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: Baoyou Xie <baoyou.xie@alibaba-inc.com>
> Cc: linux-ext4@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/ext4/ext4.h    |  1 +
>  fs/ext4/mballoc.c | 19 +++++++++++++++----
>  fs/ext4/mballoc.h |  2 ++
>  fs/ext4/sysfs.c   |  2 ++
>  4 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2866d24..c238fec 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1543,6 +1543,7 @@ struct ext4_sb_info {
>  	unsigned long s_mb_last_start;
>  	unsigned int s_mb_prefetch;
>  	unsigned int s_mb_prefetch_limit;
> +	unsigned long s_mb_max_retries_per_group;

unsigned int should be enuf no?
>
>  	/* stats for buddy allocator */
>  	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 99bf091..c126b15 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2853,6 +2853,8 @@ int ext4_mb_init(struct super_block *sb)
>  	sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
>  	sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
>  	sbi->s_mb_max_inode_prealloc = MB_DEFAULT_MAX_INODE_PREALLOC;
> +	sbi->s_mb_max_retries_per_group = MB_DISCARD_RETRIES_FOREVER;
> +
>  	/*
>  	 * The default group preallocation is 512, which for 4k block
>  	 * sizes translates to 2 megabytes.  However for bigalloc file
> @@ -4206,6 +4208,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>  					ext4_group_t group, int needed)
>  {
>  	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct buffer_head *bitmap_bh = NULL;
>  	struct ext4_prealloc_space *pa, *tmp;
>  	struct list_head list;
> @@ -4213,6 +4216,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>  	int err;
>  	int busy = 0;
>  	int free, free_total = 0;
> +	int discard_retries = 0;
unsigned int would be better for comparison too.

>
>  	mb_debug(sb, "discard preallocation for group %u\n", group);
>  	if (list_empty(&grp->bb_prealloc_list))
> @@ -4291,11 +4295,18 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>
>  	/* if we still need more blocks and some PAs were used, try again */
>  	if (free_total < needed && busy) {
> -		ext4_unlock_group(sb, group);
> -		cond_resched();
> -		busy = 0;
> -		goto repeat;
> +		++discard_retries;
> +		if (sbi && sbi->s_mb_max_retries_per_group < discard_retries) {
> +			ext4_warning(sb, "The retry count has exceeded the limit: %lu",
> +					sbi->s_mb_max_retries_per_group);

I guess it won't hurt if we do add ext4_mb_show_pa() too.
It is anyways enabled only if CONFIG_EXT4_DEBUG is set.

> +		} else  {
> +			ext4_unlock_group(sb, group);
> +			cond_resched();
> +			busy = 0;
> +			goto repeat;
> +		}
>  	}
> +
>  	ext4_unlock_group(sb, group);
>  	ext4_mb_unload_buddy(&e4b);
>  	put_bh(bitmap_bh);
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index e75b474..fa5b5a3 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -78,6 +78,8 @@
>   */
>  #define MB_DEFAULT_MAX_INODE_PREALLOC	512
>
> +#define MB_DISCARD_RETRIES_FOREVER	(-1UL)

Depending upon if this issue can actually happen normally too, then maybe
we need a this value to be pre-configured.
Again others may have a better suggestion here.

> +
>  struct ext4_free_data {
>  	/* this links the free block information from sb_info */
>  	struct list_head		efd_list;
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 075aa3a..3549520 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -213,6 +213,7 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
>  EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
>  EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
>  EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
> +EXT4_RW_ATTR_SBI_UL(mb_max_retries_per_group, s_mb_max_retries_per_group);
>  EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>  EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
>  EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
> @@ -260,6 +261,7 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
>  	ATTR_LIST(mb_stream_req),
>  	ATTR_LIST(mb_group_prealloc),
>  	ATTR_LIST(mb_max_inode_prealloc),
> +	ATTR_LIST(mb_max_retries_per_group),
>  	ATTR_LIST(max_writeback_mb_bump),
>  	ATTR_LIST(extent_max_zeroout_kb),
>  	ATTR_LIST(trigger_fs_error),
> --
> 1.8.3.1
>
