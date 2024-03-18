Return-Path: <linux-ext4+bounces-1679-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9F87E977
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Mar 2024 13:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94691F2343C
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Mar 2024 12:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3216E31A76;
	Mon, 18 Mar 2024 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CPNYlp3l"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C0A36AE0;
	Mon, 18 Mar 2024 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765592; cv=none; b=MeT6EX78WZUwdbV1WupFCvZPhUA4/S6kpxhde5/edapkZexGBY1rf9JDuV+NkKd5hId2WLKXBFbnGdiwWFGVxhqXXByngGympn4kvaXzt0n+WniLowjQABOhC9jTiXOGGoPSWL+q3tln/hJyKrZ5pUtF4kYI58BPjanYQvzBcrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765592; c=relaxed/simple;
	bh=pcka2jixFTiIvSwXT3HN/FXCLspQmT+RIH23dSIG7w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eot8C6RM1svBir3qpe0vQfLv4v8f+DaErfgjrRqNqDSEMT81EQHP3FwyaDkI0Tl39a6wTrHMAcy3Z8qSKQsDVYj0UqmQAA+g9fLYswrSeREfLftYbcI2v2MA4DJQz+1QnBmwaBD4impO9wcZi/hCkoQA/6wYJPAqt4Kqq3aN52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CPNYlp3l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IC2NpG005886;
	Mon, 18 Mar 2024 12:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qXzz3ZG/I76LjD9owDyW9UNruR//xYZADMfKwXyR1FM=;
 b=CPNYlp3l4F6v073Ux7X21VSvUWjDc4KZdDFzrSO+5Qm4+Qp2U4g0LXDpUSSJa4YwxRXN
 wZ5NDVvvrlnOUcnZbKPuAohYAXFKGKnYkqAvvyDtnTtM0EPdPlp/OOobMgd55yMmT9Vn
 EXisojOoYvjrwK+yFdGEymYc8GB/qOd5v7veyuIbZZFZX0LZ+4A/3kIBCiw9NNVzJZVQ
 i/Vl+QgNuTZHtLNONGCDW4AdRJm/y69D8tRrKvQy0Z9acFxCPvzQZAkOh9ATcCT54JM2
 1SXAkv2iVvS158berj6Xh0sUKseZohhurIDriEoR5/SvKow2+OH4o2XdUL1peA0T444t pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxn8x8bss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 12:39:29 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42ICbUBn023821;
	Mon, 18 Mar 2024 12:39:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxn8x8bsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 12:39:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42IBeQHs015759;
	Mon, 18 Mar 2024 12:39:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp4ys299-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 12:39:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42ICdNku51380682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 12:39:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2507C20043;
	Mon, 18 Mar 2024 12:39:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE88C20040;
	Mon, 18 Mar 2024 12:39:20 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Mar 2024 12:39:20 +0000 (GMT)
Date: Mon, 18 Mar 2024 18:09:18 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/9] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Message-ID: <Zfg19s2+fn9QYnUQ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240314140906.3064072-1-libaokun1@huawei.com>
 <20240314140906.3064072-5-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314140906.3064072-5-libaokun1@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yYfOBa-sk_wv8vYMz-cCajWqfRl0KcrZ
X-Proofpoint-GUID: 5-v8cngLCtgaLAH3dsgZ6jbHgME_Xfm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_03,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180094

On Thu, Mar 14, 2024 at 10:09:01PM +0800, Baokun Li wrote:
> We can trigger a slab-out-of-bounds with the following commands:
> 
>     mkfs.ext4 -F /dev/$disk 10G
>     mount /dev/$disk /tmp/test
>     echo 2147483647 > /sys/fs/ext4/$disk/mb_group_prealloc
>     echo test > /tmp/test/file && sync
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
> Read of size 8 at addr ffff888121b9d0f0 by task kworker/u2:0/11
> CPU: 0 PID: 11 Comm: kworker/u2:0 Tainted: GL 6.7.0-next-20240118 #521
> Call Trace:
>  dump_stack_lvl+0x2c/0x50
>  kasan_report+0xb6/0xf0
>  ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
>  ext4_mb_regular_allocator+0x19e9/0x2370 [ext4]
>  ext4_mb_new_blocks+0x88a/0x1370 [ext4]
>  ext4_ext_map_blocks+0x14f7/0x2390 [ext4]
>  ext4_map_blocks+0x569/0xea0 [ext4]
>  ext4_do_writepages+0x10f6/0x1bc0 [ext4]
> [...]
> ==================================================================
> 
> The flow of issue triggering is as follows:
> 
> // Set s_mb_group_prealloc to 2147483647 via sysfs
> ext4_mb_new_blocks
>   ext4_mb_normalize_request
>     ext4_mb_normalize_group_request
>       ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc
>   ext4_mb_regular_allocator
>     ext4_mb_choose_next_group
>       ext4_mb_choose_next_group_best_avail
>         mb_avg_fragment_size_order
>           order = fls(len) - 2 = 29
>         ext4_mb_find_good_group_avg_frag_lists
>           frag_list = &sbi->s_mb_avg_fragment_size[order]
>           if (list_empty(frag_list)) // Trigger SOOB!
> 
> At 4k block size, the length of the s_mb_avg_fragment_size list is 14,
> but an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds
> to be triggered by an attempt to access an element at index 29.
> 
> Add a new attr_id attr_clusters_in_group with values in the range
> [0, sbi->s_clusters_per_group] and declare mb_group_prealloc as
> that type to fix the issue. In addition avoid returning an order
> from mb_avg_fragment_size_order() greater than MB_NUM_ORDERS(sb)
> and reduce some useless loops.
> 
> Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/mballoc.c |  4 ++++
>  fs/ext4/sysfs.c   | 13 ++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 12b3f196010b..48afe5aa228c 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
>     return 0;
>   if (order == MB_NUM_ORDERS(sb))
>     order--;
> + if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
> +   order = MB_NUM_ORDERS(sb) - 1;

Hey Baokun,

Thanks for fixing this. This patch looks good to me, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

my comments after this are less about the patch and more about some
thoughts on the working of average fragment lists.

So going through the v2 and this patch got me thinking about what really
is going to happen when a user tries to allocate 32768 blocks which is also 
the maximum value we could have in say ac->ac_g_ex.fe_len.

When this happens, ext4_mb_regular_allocator() will directly set the
criteria as CR_GOAL_LEN_FAST. Now, we'll follow:

ext4_mb_choose_next_group_goal_fast()
  for (i=mb_avg_fragment_size_order(); i < MB_NUM_ORDERS; i++) { .. }

Here, mb_avg_fragment_siz_order() will do something like:

  order = fls(32768) - 2 = 14
  ...
  if (order == MB_NUM_ORDERS(sb))
    order--;

  return order;

And we'll look in the fragment list[13] and since none of the groups
there would have 32768 blocks free (since we dont track it here) we'll
unnecessarily traverse the full list before falling to CR_BEST_AVAIL_LEN
(this will become a noop due to the way order and min_order
are calculated) and eventually to CR_GOAL_LEN_SLOW where we might get
something or end up splitting.

I think something more optimal would be to:

1. Add another entry to average fragment lists for completely empty
groups. (As a sidenote i think we should use something like MB_NUM_FRAG_ORDER
instead of MB_NUM_ORDERS in calculating limits related to average
fragment lists since the NUM_ORDERS seems to be the buddy max order ie
8192 blocks only valid for CR_POWER2 and shouldn't really limit the
fragment size lists)

2. If we don't want to go with 1 (maybe there's some history for that),
then probably should exit early from CR_GOAL_LEN_FAST so that we don't
iterate there.

Would like to hear your thoughts on it Baokun, Jan. 

Regards,
ojaswin

>   return order;
>  }
>  
> @@ -1008,6 +1010,8 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
>    * goal length.
>    */
>   order = fls(ac->ac_g_ex.fe_len) - 1;
> + if (WARN_ON_ONCE(order > MB_NUM_ORDERS(ac->ac_sb) - 1))
> +   order = MB_NUM_ORDERS(ac->ac_sb) - 1;
>   min_order = order - sbi->s_mb_best_avail_max_trim_order;
>   if (min_order < 0)
>     min_order = 0;
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 7f455b5f22c0..ddd71673176c 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -29,6 +29,7 @@ typedef enum {
>   attr_trigger_test_error,
>   attr_first_error_time,
>   attr_last_error_time,
> + attr_clusters_in_group,
>   attr_feature,
>   attr_pointer_ui,
>   attr_pointer_ul,
> @@ -207,13 +208,14 @@ EXT4_ATTR_FUNC(sra_exceeded_retry_limit, 0444);
>  
>  EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
>      ext4_sb_info, s_inode_readahead_blks);
> +EXT4_ATTR_OFFSET(mb_group_prealloc, 0644, clusters_in_group,
> +    ext4_sb_info, s_mb_group_prealloc);
>  EXT4_RW_ATTR_SBI_UI(inode_goal, s_inode_goal);
>  EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
>  EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
>  EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
>  EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
>  EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
> -EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
>  EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
>  EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>  EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> @@ -376,6 +378,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
>  
>   switch (a->attr_id) {
>   case attr_inode_readahead:
> + case attr_clusters_in_group:
>   case attr_pointer_ui:
>     if (a->attr_ptr == ptr_ext4_super_block_offset)
>       return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
> @@ -455,6 +458,14 @@ static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
>     else
>       *((unsigned int *) ptr) = t;
>     return len;
> + case attr_clusters_in_group:
> +   ret = kstrtouint(skip_spaces(buf), 0, &t);
> +   if (ret)
> +     return ret;
> +   if (t > sbi->s_clusters_per_group)
> +     return -EINVAL;
> +   *((unsigned int *) ptr) = t;
> +   return len;
>   case attr_pointer_ul:
>     ret = kstrtoul(skip_spaces(buf), 0, &lt);
>     if (ret)
> -- 
> 2.31.1
> 

