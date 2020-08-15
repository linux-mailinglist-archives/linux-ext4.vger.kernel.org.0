Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEC5245218
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Aug 2020 23:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgHOVly (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 15 Aug 2020 17:41:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbgHOVlx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 15 Aug 2020 17:41:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07FDVYi3074708;
        Sat, 15 Aug 2020 09:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=y0HLVDPBNa5MiNnXLWKXftldk3s/XJmLXPnelNe790k=;
 b=HH40LlwYs1q2knpf1JmIPe2HuftkdmnwZAEGcKV/E49XowlqEDVE4x8O1BkIRjygzH0+
 JYtnhS62Rsx2NRIV28FhQJpggT/DCwqBZ7bHVUiDZCvnNqoIX4/yec1B4trP59mrC85k
 VGR89aWzsF/buBSqIBShw2PbiACVFOZTGbT1IQgxyVhRcl1/3wyss+EsC0U4WmxGwWeQ
 pvL7HDCj5TQC2OHTbae/V+26CBhc68qCX9D38nbSB8y2ulqF8x+pncpn4NQZ2+I262qw
 KwvT49r6TBMnKoxlTyk4nXQhEo0axQYrFqX0JBktLx41y5LDT60DOO9s/d+swv3GrAKA Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32xc82vk1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Aug 2020 09:32:19 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07FDWIoS075633;
        Sat, 15 Aug 2020 09:32:18 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32xc82vk16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Aug 2020 09:32:18 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07FDPCHM020204;
        Sat, 15 Aug 2020 13:32:16 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 32x7b80dge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Aug 2020 13:32:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07FDWDsr19923358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Aug 2020 13:32:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4704A4040;
        Sat, 15 Aug 2020 13:32:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D164A4057;
        Sat, 15 Aug 2020 13:32:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 15 Aug 2020 13:32:12 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] ext4: limit the length of per-inode prealloc list
To:     brookxu <brookxu.cn@gmail.com>, adilger.kernel@dilger.ca,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <530dadc7-7bee-6d90-38b8-3af56c428297@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 15 Aug 2020 19:02:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <530dadc7-7bee-6d90-38b8-3af56c428297@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <20200815133212.8D164A4057@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-15_07:2020-08-14,2020-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=2 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008150102
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/7/20 2:14 PM, brookxu wrote:
> In the scenario of writing sparse files, the Per-inode prealloc list may
> be very long, resulting in high overhead for ext4_mb_use_preallocated().
> To circumvent this problem, we limit the maximum length of per-inode
> prealloc list to 512 and allow users to modify it.

ok, so I looked at your algorithm again, below are few comments.

@Andreas, please let me also know if you agree?


1. On every block allocation request in ext4_mb_new_blocks()
you call for ext4_mb_trim_inode_pa() just to iterate over all the 
ei->prealloc_list to count the length of this list.
This looks a costly and also since it uses the spin_lock()/unlock()
(of pa->lock) for every pa in that list just to see if it's getting 
deleted.
So if someone else in parallel is also allocating/freeing blocks from
that pa, this could cause contention just to measure the length of list.
I think maybe the better way would be to maintain an atomic counter
instead of traversing the list every time. thoughts?

2. In ext4_mb_release_context(), I think for LRU algo, we should be 
doing it like below. Thoughts?

list_move(&pa->pa_inode_list, &ei->i_prealloc_list);

With your change I observe below behavior, and I think this is not
intended right?

<with your change i.e. list_move(&ei->i_prealloc_list, &pa->pa_inode_list)>
======================================================================
#/run/perf# sudo perf script
            a.out  5453 [000] 55399.979084: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff8889ebde4008
            a.out  5453 [000] 55405.213401: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff8889ebde47e8
            a.out  5453 [000] 55415.669280: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff8889ebde4bd8
            a.out  5453 [000] 55420.840979: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff8889ebde43f8
            a.out  5453 [000] 55420.841064: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff8889ebde4bd8
            a.out  5453 [000] 55420.841082: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff8889ebde43f8
            a.out  5453 [000] 55420.841280: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff8889ebde4200
            a.out  5453 [000] 55426.030955: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff8889ebde43f8
            a.out  5453 [000] 55426.031060: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff8889ebde4200
            a.out  5453 [000] 55426.031076: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff8889ebde43f8
            a.out  5453 [000] 55426.031334: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff8889ebde49e0
            a.out  5453 [000] 55431.279519: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff8889ebde43f8
            a.out  5453 [000] 55431.279809: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff8889ebde49e0
            a.out  5453 [000] 55431.279831: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff8889ebde43f8



<with list_move(&pa->pa_inode_list, &ei->i_prealloc_list)>
======================================================================
root@qemu:/run/perf# sudo perf script
            a.out  1646 [000]  1555.975990: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff888977fab008
            a.out  1646 [000]  1563.509005: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff888977fab7e8
            a.out  1646 [000]  1568.742938: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff888977fabdd0
            a.out  1646 [000]  1573.932029: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff888977fab5f0
            a.out  1646 [000]  1573.932143: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff888977fab7e8
            a.out  1646 [000]  1573.932161: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff888977fab008
            a.out  1646 [000]  1579.289937: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff888977fab008
            a.out  1646 [000]  1584.561934: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff888977fab9e0
            a.out  1646 [000]  1584.562019: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff888977fab5f0
            a.out  1646 [000]  1584.562037: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff888977fabdd0
            a.out  1646 [000]  1589.822954: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff888977fabdd0
            a.out  1646 [000]  1595.006822: 
probe:ext4_mb_new_inode_pa: (ffffffff813c51c0) i_ino=0xe 
ac_pa=0xffff888977fab7e8
            a.out  1646 [000]  1595.006880: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff888977fab9e0
            a.out  1646 [000]  1595.006892: 
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=0xe 
pa=0xffff888977fab008



-ritesh




> 
> After patching, we observed that the sys ratio of cpu has dropped, and
> the system throughput has increased significantly. We created a process
> to write the sparse file, and the running time of the process on the
> fixed kernel was significantly reduced, as follows:
> 
> Running time on unfixed kernel：
> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
> real    0m2.051s
> user    0m0.008s
> sys     0m2.026s
> 
> Running time on fixed kernel：
> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
> real    0m0.471s
> user    0m0.004s
> sys     0m0.395s
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>   fs/ext4/ext4.h              |  3 ++-
>   fs/ext4/extents.c           | 10 ++++----
>   fs/ext4/file.c              |  2 +-
>   fs/ext4/indirect.c          |  2 +-
>   fs/ext4/inode.c             |  6 ++---
>   fs/ext4/ioctl.c             |  2 +-
>   fs/ext4/mballoc.c           | 57 +++++++++++++++++++++++++++++++++++++++++----
>   fs/ext4/mballoc.h           |  4 ++++
>   fs/ext4/move_extent.c       |  4 ++--
>   fs/ext4/super.c             |  2 +-
>   fs/ext4/sysfs.c             |  2 ++
>   include/trace/events/ext4.h | 14 ++++++-----
>   12 files changed, 83 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 42f5060..68e0ebe 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1501,6 +1501,7 @@ struct ext4_sb_info {
>   	unsigned int s_mb_stats;
>   	unsigned int s_mb_order2_reqs;
>   	unsigned int s_mb_group_prealloc;
> +	unsigned int s_mb_max_inode_prealloc;
>   	unsigned int s_max_dir_size_kb;
>   	/* where last allocation was done - for stream allocation */
>   	unsigned long s_mb_last_group;
> @@ -2651,7 +2652,7 @@ extern int ext4_init_inode_table(struct super_block *sb,
>   extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
>   				struct ext4_allocation_request *, int *);
>   extern int ext4_mb_reserve_blocks(struct super_block *, int);
> -extern void ext4_discard_preallocations(struct inode *);
> +extern void ext4_discard_preallocations(struct inode *, unsigned int);
>   extern int __init ext4_init_mballoc(void);
>   extern void ext4_exit_mballoc(void);
>   extern void ext4_free_blocks(handle_t *handle, struct inode *inode,
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 221f240..a40f928 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -100,7 +100,7 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>   	 * i_mutex. So we can safely drop the i_data_sem here.
>   	 */
>   	BUG_ON(EXT4_JOURNAL(inode) == NULL);
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>   	up_write(&EXT4_I(inode)->i_data_sem);
>   	*dropped = 1;
>   	return 0;
> @@ -4272,7 +4272,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   			 * not a good idea to call discard here directly,
>   			 * but otherwise we'd need to call it every free().
>   			 */
> -			ext4_discard_preallocations(inode);
> +			ext4_discard_preallocations(inode, 0);
>   			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
>   				fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
>   			ext4_free_blocks(handle, inode, NULL, newblock,
> @@ -5299,7 +5299,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>   	}
>   
>   	down_write(&EXT4_I(inode)->i_data_sem);
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>   
>   	ret = ext4_es_remove_extent(inode, punch_start,
>   				    EXT_MAX_BLOCKS - punch_start);
> @@ -5313,7 +5313,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>   		up_write(&EXT4_I(inode)->i_data_sem);
>   		goto out_stop;
>   	}
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>   
>   	ret = ext4_ext_shift_extents(inode, handle, punch_stop,
>   				     punch_stop - punch_start, SHIFT_LEFT);
> @@ -5445,7 +5445,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
>   		goto out_stop;
>   
>   	down_write(&EXT4_I(inode)->i_data_sem);
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>   
>   	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
>   	if (IS_ERR(path)) {
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2a01e31..e3ab8ea 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -148,7 +148,7 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
>   		        !EXT4_I(inode)->i_reserved_data_blocks)
>   	{
>   		down_write(&EXT4_I(inode)->i_data_sem);
> -		ext4_discard_preallocations(inode);
> +		ext4_discard_preallocations(inode, 0);
>   		up_write(&EXT4_I(inode)->i_data_sem);
>   	}
>   	if (is_dx(inode) && filp->private_data)
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index be2b66e..ec6b930 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -696,7 +696,7 @@ static int ext4_ind_trunc_restart_fn(handle_t *handle, struct inode *inode,
>   	 * i_mutex. So we can safely drop the i_data_sem here.
>   	 */
>   	BUG_ON(EXT4_JOURNAL(inode) == NULL);
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>   	up_write(&EXT4_I(inode)->i_data_sem);
>   	*dropped = 1;
>   	return 0;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 10dd470..bb9e1cd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -383,7 +383,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
>   	 */
>   	if ((ei->i_reserved_data_blocks == 0) &&
>   	    !inode_is_open_for_write(inode))
> -		ext4_discard_preallocations(inode);
> +		ext4_discard_preallocations(inode, 0);
>   }
>   
>   static int __check_block_validity(struct inode *inode, const char *func,
> @@ -4056,7 +4056,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
>   	if (stop_block > first_block) {
>   
>   		down_write(&EXT4_I(inode)->i_data_sem);
> -		ext4_discard_preallocations(inode);
> +		ext4_discard_preallocations(inode, 0);
>   
>   		ret = ext4_es_remove_extent(inode, first_block,
>   					    stop_block - first_block);
> @@ -4211,7 +4211,7 @@ int ext4_truncate(struct inode *inode)
>   
>   	down_write(&EXT4_I(inode)->i_data_sem);
>   
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>   
>   	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>   		err = ext4_ext_truncate(handle, inode);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 999cf6a..a5fcc23 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -202,7 +202,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>   	reset_inode_seed(inode);
>   	reset_inode_seed(inode_bl);
>   
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>   
>   	err = ext4_mark_inode_dirty(handle, inode);
>   	if (err < 0) {
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4f21f34..28a139f 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2736,6 +2736,7 @@ int ext4_mb_init(struct super_block *sb)
>   	sbi->s_mb_stats = MB_DEFAULT_STATS;
>   	sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
>   	sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
> +	sbi->s_mb_max_inode_prealloc = MB_DEFAULT_MAX_INODE_PREALLOC;
>   	/*
>   	 * The default group preallocation is 512, which for 4k block
>   	 * sizes translates to 2 megabytes.  However for bigalloc file
> @@ -4103,7 +4104,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>    *
>    * FIXME!! Make sure it is valid at all the call sites
>    */
> -void ext4_discard_preallocations(struct inode *inode)
> +void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>   {
>   	struct ext4_inode_info *ei = EXT4_I(inode);
>   	struct super_block *sb = inode->i_sb;
> @@ -4121,15 +4122,18 @@ void ext4_discard_preallocations(struct inode *inode)
>   
>   	mb_debug(sb, "discard preallocation for inode %lu\n",
>   		 inode->i_ino);
> -	trace_ext4_discard_preallocations(inode);
> +	trace_ext4_discard_preallocations(inode,  needed);
>   
>   	INIT_LIST_HEAD(&list);
>   
> +	if (needed == 0)
> +		needed = UINT_MAX;
> +
>   repeat:
>   	/* first, collect all pa's in the inode */
>   	spin_lock(&ei->i_prealloc_lock);
> -	while (!list_empty(&ei->i_prealloc_list)) {
> -		pa = list_entry(ei->i_prealloc_list.next,
> +	while (!list_empty(&ei->i_prealloc_list) && needed) {
> +		pa = list_entry(ei->i_prealloc_list.prev,
>   				struct ext4_prealloc_space, pa_inode_list);
>   		BUG_ON(pa->pa_obj_lock != &ei->i_prealloc_lock);
>   		spin_lock(&pa->pa_lock);
> @@ -4150,6 +4154,7 @@ void ext4_discard_preallocations(struct inode *inode)
>   			spin_unlock(&pa->pa_lock);
>   			list_del_rcu(&pa->pa_inode_list);
>   			list_add(&pa->u.pa_tmp_list, &list);
> +			needed--;
>   			continue;
>   		}
>   
> @@ -4549,10 +4554,42 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
>   }
>   
>   /*
> + * if per-inode prealloc list is too long, trim some PA
> + */
> +static void
> +ext4_mb_trim_inode_pa(struct inode *inode)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	struct ext4_prealloc_space *pa;
> +	int count = 0, delta;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
> +		spin_lock(&pa->pa_lock);
> +		if (pa->pa_deleted) {
> +			spin_unlock(&pa->pa_lock);
> +			continue;
> +		}
> +		count++;
> +		spin_unlock(&pa->pa_lock);
> +	}
> +	rcu_read_unlock();
> +
> +	delta = (sbi->s_mb_max_inode_prealloc >> 2) + 1;
> +	if (count > sbi->s_mb_max_inode_prealloc + delta) {
> +		count -= sbi->s_mb_max_inode_prealloc;
> +		ext4_discard_preallocations(inode, count);
> +	}
> +}
> +
> +/*
>    * release all resource we used in allocation
>    */
>   static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>   {
> +	struct inode *inode = ac->ac_inode;
> +	struct ext4_inode_info *ei = EXT4_I(inode);
>   	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>   	struct ext4_prealloc_space *pa = ac->ac_pa;
>   	if (pa) {
> @@ -4578,6 +4615,17 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>   				ext4_mb_add_n_trim(ac);
>   			}
>   		}
> +
> +		if (pa->pa_type == MB_INODE_PA) {
> +			/*
> +			 * treat per-inode prealloc list as a lru list, then try
> +			 * to trim the least recently used PA.
> +			 */
> +			spin_lock(pa->pa_obj_lock);
> +			list_move(&ei->i_prealloc_list, &pa->pa_inode_list);
> +			spin_unlock(pa->pa_obj_lock);
> +		}
> +
>   		ext4_mb_put_pa(ac, ac->ac_sb, pa);
>   	}
>   	if (ac->ac_bitmap_page)
> @@ -4587,6 +4635,7 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>   	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
>   		mutex_unlock(&ac->ac_lg->lg_mutex);
>   	ext4_mb_collect_stats(ac);
> +	ext4_mb_trim_inode_pa(inode);
>   	return 0;
>   }
>   
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 6b4d17c..e75b474 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -73,6 +73,10 @@
>    */
>   #define MB_DEFAULT_GROUP_PREALLOC	512
>   
> +/*
> + * maximum length of inode prealloc list
> + */
> +#define MB_DEFAULT_MAX_INODE_PREALLOC	512
>   
>   struct ext4_free_data {
>   	/* this links the free block information from sb_info */
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 1ed86fb..0d601b8 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -686,8 +686,8 @@
>   
>   out:
>   	if (*moved_len) {
> -		ext4_discard_preallocations(orig_inode);
> -		ext4_discard_preallocations(donor_inode);
> +		ext4_discard_preallocations(orig_inode, 0);
> +		ext4_discard_preallocations(donor_inode, 0);
>   	}
>   
>   	ext4_ext_drop_refs(path);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957e..8ce61f3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1216,7 +1216,7 @@ void ext4_clear_inode(struct inode *inode)
>   {
>   	invalidate_inode_buffers(inode);
>   	clear_inode(inode);
> -	ext4_discard_preallocations(inode);
> +	ext4_discard_preallocations(inode, 0);
>   	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
>   	dquot_drop(inode);
>   	if (EXT4_I(inode)->jinode) {
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 6c9fc9e..92f04e9 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -215,6 +215,7 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
>   EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
>   EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
>   EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
> +EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
>   EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>   EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
>   EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
> @@ -257,6 +258,7 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
>   	ATTR_LIST(mb_order2_req),
>   	ATTR_LIST(mb_stream_req),
>   	ATTR_LIST(mb_group_prealloc),
> +	ATTR_LIST(mb_max_inode_prealloc),
>   	ATTR_LIST(max_writeback_mb_bump),
>   	ATTR_LIST(extent_max_zeroout_kb),
>   	ATTR_LIST(trigger_fs_error),
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index cc41d69..61736d8 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -746,24 +746,26 @@
>   );
>   
>   TRACE_EVENT(ext4_discard_preallocations,
> -	TP_PROTO(struct inode *inode),
> +	TP_PROTO(struct inode *inode, unsigned int needed),
>   
> -	TP_ARGS(inode),
> +	TP_ARGS(inode, needed),
>   
>   	TP_STRUCT__entry(
> -		__field(	dev_t,	dev			)
> -		__field(	ino_t,	ino			)
> +		__field(	dev_t,		dev		)
> +		__field(	ino_t,		ino		)
> +		__field(	unsigned int,	needed		)
>   
>   	),
>   
>   	TP_fast_assign(
>   		__entry->dev	= inode->i_sb->s_dev;
>   		__entry->ino	= inode->i_ino;
> +		__entry->needed	= needed;
>   	),
>   
> -	TP_printk("dev %d,%d ino %lu",
> +	TP_printk("dev %d,%d ino %lu needed %u",
>   		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  (unsigned long) __entry->ino)
> +		  (unsigned long) __entry->ino, __entry->needed)
>   );
>   
>   TRACE_EVENT(ext4_mb_discard_preallocations,
> 
