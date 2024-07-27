Return-Path: <linux-ext4+bounces-3483-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04A493DEBF
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 12:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074F41C21472
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08F34D8BA;
	Sat, 27 Jul 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e4oDwWd5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BBC4411;
	Sat, 27 Jul 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722076642; cv=none; b=POBsY46GygeOy5W6v8K1Rvz6qW/IjA3m3UOkcL7vDwkYk/1sYgTwLE7FMWqq6iX6RpcTw7vFY+hMa7l8eGq7yu2dN68PLRgOUfWMhoKnq+QTyc02w43mbkAbxJo6fdr7KxxJltQK3+LaqwkjuAuop0QDegSiD/0d069N1Siu2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722076642; c=relaxed/simple;
	bh=LwPTdglHxO2qSZfXyjJUgYj3jX3IjcKmliIEpTgfFMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWDCk3BaWjVL2BwVupov1ieNH739gGx4tVxk62Fr4InyhcZ+V8JeH394YeDzPy1EJYSg2pgrK1OgtxIr6P6tC3gwPxnm1e3ik1ZM2Rjkt247hMXGZZIhbCivi8R2TAgqJfiGtmk0cHIk/ce+KN+PlC6lOQyvYzc/rEIzEsoSBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e4oDwWd5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46RASjeC023795;
	Sat, 27 Jul 2024 10:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=0qH/puiIHUpi1dUdiLR4VlPnWer
	R1vlDEbJ7c7YBbIc=; b=e4oDwWd5Mqmwtn6S44BX6F+1gaFdEDkCENwmlSxiqBT
	o4zQs/0IErvBr9APeLWnv/7ZsfLBoTvVW/OEt56tWAcY3VADKyDh7jr3uR/e6AbC
	0hDkOu/UK0hwMajKb8i/9CUyvNRCR+eZiECzm9xU/3i55wGNi/d4n6YvSJr2C+Wo
	cdNn+xbGV/9IWkMKe85xY4LpiwS35RXLxMbaZIOwWr0SjdkZa062ZolrB7M4kT/N
	PyAsAKTMB2n5bU7ovVoFJzxMXeODduDeAR0ranYikvvi2GSHAcoClweSJHl0TkFD
	h0XbKGq0HiKpR5WWd2Sd5ubOOHfa5f8mvSh1VlIfSZw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40my5x00e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jul 2024 10:36:48 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46RAalQL004432;
	Sat, 27 Jul 2024 10:36:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40my5x00e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jul 2024 10:36:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46RAKBct005818;
	Sat, 27 Jul 2024 10:36:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2pysav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jul 2024 10:36:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46RAahO352167076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 10:36:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16C8920040;
	Sat, 27 Jul 2024 10:36:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A756720043;
	Sat, 27 Jul 2024 10:36:40 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.37.64])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 27 Jul 2024 10:36:40 +0000 (GMT)
Date: Sat, 27 Jul 2024 16:06:37 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>, stable@kernel.org
Subject: Re: [PATCH 05/20] ext4: fix slab-use-after-free in
 ext4_split_extent_at()
Message-ID: <ZqTNtWchBMRIVmqL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-6-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-6-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vLtH_f-AJKSKnaTXIf-TDbcm3bzG8FyC
X-Proofpoint-ORIG-GUID: drqst9qNcq1wgxxZiY3oCm_NGeQtJH_u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxlogscore=647
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407270067

On Wed, Jul 10, 2024 at 12:06:39PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> We hit the following use-after-free:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in ext4_split_extent_at+0xba8/0xcc0
> Read of size 2 at addr ffff88810548ed08 by task kworker/u20:0/40
> CPU: 0 PID: 40 Comm: kworker/u20:0 Not tainted 6.9.0-dirty #724
> Call Trace:
>  <TASK>
>  kasan_report+0x93/0xc0
>  ext4_split_extent_at+0xba8/0xcc0
>  ext4_split_extent.isra.0+0x18f/0x500
>  ext4_split_convert_extents+0x275/0x750
>  ext4_ext_handle_unwritten_extents+0x73e/0x1580
>  ext4_ext_map_blocks+0xe20/0x2dc0
>  ext4_map_blocks+0x724/0x1700
>  ext4_do_writepages+0x12d6/0x2a70
> [...]
> 
> Allocated by task 40:
>  __kmalloc_noprof+0x1ac/0x480
>  ext4_find_extent+0xf3b/0x1e70
>  ext4_ext_map_blocks+0x188/0x2dc0
>  ext4_map_blocks+0x724/0x1700
>  ext4_do_writepages+0x12d6/0x2a70
> [...]
> 
> Freed by task 40:
>  kfree+0xf1/0x2b0
>  ext4_find_extent+0xa71/0x1e70
>  ext4_ext_insert_extent+0xa22/0x3260
>  ext4_split_extent_at+0x3ef/0xcc0
>  ext4_split_extent.isra.0+0x18f/0x500
>  ext4_split_convert_extents+0x275/0x750
>  ext4_ext_handle_unwritten_extents+0x73e/0x1580
>  ext4_ext_map_blocks+0xe20/0x2dc0
>  ext4_map_blocks+0x724/0x1700
>  ext4_do_writepages+0x12d6/0x2a70
> [...]
> ==================================================================
> 
> The flow of issue triggering is as follows:
> 
> ext4_split_extent_at
>   path = *ppath
>   ext4_ext_insert_extent(ppath)
>     ext4_ext_create_new_leaf(ppath)
>       ext4_find_extent(orig_path)
>         path = *orig_path
>         read_extent_tree_block
>           // return -ENOMEM or -EIO
>         ext4_free_ext_path(path)
>           kfree(path)
>         *orig_path = NULL
>   a. If err is -ENOMEM:
>   ext4_ext_dirty(path + path->p_depth)
>   // path use-after-free !!!
>   b. If err is -EIO and we have EXT_DEBUG defined:
>   ext4_ext_show_leaf(path)
>     eh = path[depth].p_hdr
>     // path also use-after-free !!!
> 
> So when trying to zeroout or fix the extent length, call ext4_find_extent()
> to update the path.
> 
> In addition we use *ppath directly as an ext4_ext_show_leaf() input to
> avoid possible use-after-free when EXT_DEBUG is defined, and to avoid
> unnecessary path updates.
> 
> Fixes: dfe5080939ea ("ext4: drop EXT4_EX_NOFREE_ON_ERR from rest of extents handling code")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/extents.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 6e5b5baf3aa6..3a70a0739af8 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3252,6 +3252,25 @@ static int ext4_split_extent_at(handle_t *handle,
>   if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
>     goto out;
>  
> + /*
> +  * Update path is required because previous ext4_ext_insert_extent()
> +  * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
> +  * guarantees that ext4_find_extent() will not return -ENOMEM,
> +  * otherwise -ENOMEM will cause a retry in do_writepages(), and a
> +  * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
> +  * an incorrect ee_len causing the i_reserved_data_blocks exception.
> +  */
> + path = ext4_find_extent(inode, ee_block, ppath,
> +       flags | EXT4_EX_NOFAIL);
> + if (IS_ERR(path)) {
> +   EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
> +        split, PTR_ERR(path));
> +   return PTR_ERR(path);
> + }
> + depth = ext_depth(inode);
> + ex = path[depth].p_ext;
> + *ppath = path;
> +

Hi Baokun, nice catch! 

I was just wondering if it makes more sense to only update path if we
encounter an error:

  err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
  if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
    goto out;
  else if (err < 0) {
    ...
    path = ext4_find_extent(inode, ee_block, ppath, flags | EXT4_EX_NOFAIL);
  }

I believe that's the only time we'd end up with the use after free issue
and this way we can avoid the (maybe tiny) performance overhead of calling 
the extra find extent. What are your thoughts?

regards,
ojaswin

>   if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
>     if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
>       if (split_flag & EXT4_EXT_DATA_VALID1) {
> @@ -3304,7 +3323,7 @@ static int ext4_split_extent_at(handle_t *handle,
>   ext4_ext_dirty(handle, inode, path + path->p_depth);
>   return err;
>  out:
> - ext4_ext_show_leaf(inode, path);
> + ext4_ext_show_leaf(inode, *ppath);
>   return err;
>  }
>  
> -- 
> 2.39.2
> 

