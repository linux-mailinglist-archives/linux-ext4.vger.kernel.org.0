Return-Path: <linux-ext4+bounces-1287-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058EB85B25F
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Feb 2024 06:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61491282CC7
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Feb 2024 05:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE056B9E;
	Tue, 20 Feb 2024 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PPTx3MZl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B1445942;
	Tue, 20 Feb 2024 05:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407597; cv=none; b=abvEqHAtMayusMNbOzbO7wyvWYEogv0aNhhr8SKuqAb9E1DPUSmVMdMfuDMAdNyNhc7GV8eH1aQ80CvKFjLW6DL3VzPQ6iUOs8OZyzmyUfQ6HCTwyDv0EtGIFHCiHhFS4ruXYPCi/PHH/fJdcjH1ocsqMAW8SHh0q4027mTnJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407597; c=relaxed/simple;
	bh=j4F3GnK0WJEVQCfLjxRK3gHJtsNHBIgfItsgPBYJDOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0haeCJvIrXPMDsrA11CL28F2dB1Br6xWk1tcVgrTOr+1xZYNlto1C6u3+5vQx9X5k0lkSN6C4JrTqWjF51V5V4ma4heEDTI0953Z+1hwmAWxymq/Gd72ZJmlyAKAw6FIb7C31qBCLFgeirz1KT8jP1gervMHQac9OFAC1O4vK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PPTx3MZl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41K5Ib0j004258;
	Tue, 20 Feb 2024 05:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wh+1b4NkwIFc8fqqrUx24gGPPN326wrIGKLOXwHr89o=;
 b=PPTx3MZl03ou0l88OZOsN1kvLNCwt5LWuJJHQc0f3YbBCEPW/cdA9Oy3lZ+AzfCoUX57
 BNDI2HDtkJsPo6nS+ksPmKYhfIj+eA0ABF7EnXkpIHlND6pdn2i1O9U7wh+0jWr0jL7V
 M5I8yB5h4ZM85KttfxfNrA3XezpsMyzpBv0QiFgitNYYDT8iPIk6OIWPgdzFGjVPAqhU
 qMaXRtXhNBpVcHdbU+rIDM4CwKRaTC+YNZJ/bneoFnQavCpjiZCNUgMwYQ6voHS7qlJG
 tUhb4IBCHtmNawPZiqFuj69SdjVtN3ieJZBhfbOUdll+SVR+dH2u7SuxCKh+WYdAunrO Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcntfgaq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 05:39:42 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41K5VOVo001828;
	Tue, 20 Feb 2024 05:39:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcntfgapu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 05:39:41 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41K4RTn4013492;
	Tue, 20 Feb 2024 05:39:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h06c89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 05:39:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41K5daoJ45154842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 05:39:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1C1F20040;
	Tue, 20 Feb 2024 05:39:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB9FC20043;
	Tue, 20 Feb 2024 05:39:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 Feb 2024 05:39:34 +0000 (GMT)
Date: Tue, 20 Feb 2024 11:09:32 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH 5/7] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Message-ID: <ZdQ7FEA7KC4eAMpg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-6-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126085716.1363019-6-libaokun1@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uISKJ3kK8j0ru3Up3bEpo81VzY_ptFFM
X-Proofpoint-ORIG-GUID: 8t_E9KrAWrXNar7JdpkHkEwc5cmFAHOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_04,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200038

On Fri, Jan 26, 2024 at 04:57:14PM +0800, Baokun Li wrote:

Hey Baokun, 

Good catch! I've added some minor comments below. Other than that feel
free to add 

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

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
> At 4k block size, the length of the s_mb_avg_fragment_size list is 14, but
> an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds to be
> triggered by an attempt to access an element at index 29.
> 
> Therefore it is not allowed to set s_mb_group_prealloc to a value greater
> than s_clusters_per_group via sysfs, and to avoid returning an order from
> mb_avg_fragment_size_order() that is greater than MB_NUM_ORDERS(sb).
> 
> Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c | 2 ++
>  fs/ext4/sysfs.c   | 9 ++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f44f668e407f..1ea6491b6b00 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -832,6 +832,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
>     return 0;
>   if (order == MB_NUM_ORDERS(sb))
>     order--;
> + if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
> +   order = MB_NUM_ORDERS(sb) - 1;
>   return order;
>  }

So along with this change, I think it'll also be good to add an extra 
check in ext4_mb_choose_next_group_best_avail() as:

  if (1 << min_order < ac->ac_o_ex.fe_len)
    min_order = fls(ac->ac_o_ex.fe_len);
 
+ if (order >= MB_NUM_ORDERS(ac->ac_sb))
+   order = MB_NUM_ORDERS(ac->ac_sb) - 1;
+
  for (i = order; i >= min_order; i--) {
    int frag_order;
    /*


The reason for this is that otherwise when order is large eg 29,
we would unnecessarily loop from i=29 to i=13 while always
looking at the same avg_fragment_list[13].

Regards,
ojaswin

