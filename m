Return-Path: <linux-ext4+bounces-3596-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0469458E8
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 09:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7782815EA
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B43482EF;
	Fri,  2 Aug 2024 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GxRt3tVE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B514D8BD;
	Fri,  2 Aug 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584080; cv=none; b=uK8kAliTyxEub//RZ7hGRIxhZIQnv4Ky9PI7B4iirIf0kWOJ0MaDvB2Jmp6CC6VZvGTHREXkOPHUia0/BWf582OMHWCFnsX13cqzmRNzOAaEgfm0WskbKQ+XoIxxrODmzf1tnKjm3orl7+b+z3boPCUJRHeebiiOX5YaxBpvPW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584080; c=relaxed/simple;
	bh=Y7oUZFzs9JdiSCi+7GgFen9Y7E+A3M4dKqm1FlJXs5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TikC0f2a09/iw8TNROpm02/kIGwRw09L8MWUNiQ4hiy8CsRVTKMDSLsgyzOHRSvrLiI9w9d+jhxH48xLUcN3af2hUzTZe4hGyI0wjZUMKW9tIeJEFWZAFnuSKFcK85I5NehB9tQEmdY4OT8qCUWaw3Xur7TtKiye7jgXefT2wm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GxRt3tVE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4727JmT4023838;
	Fri, 2 Aug 2024 07:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=/gT1HipQeU5sVnl5LRkK8oayYcA
	U5Hy2f855m8tVuWE=; b=GxRt3tVEOLkkqoBT2A9GRCfgPCQzmwren5esbT8GDun
	X2PyZFU8ux8kZSDzx5pxjXovxrx6MkcColJVwHDmGVe4Qm0zp1mezxRzOpqiMAKB
	zs1I9QKXmJdmnUONQ8DLpVd52XlU66LR24jjg3rhxDMfilyQaLse/E7SCTpuwKuX
	F2lMH0eSyj6lTD7E2Fr+PCACcJvwaZhZ9LVwh6OLy2H7XpDstiKMYP3VaLsIcixY
	L5+EbGMudCTLF3d1x5PHPpujMznI4E2eZ3l+abNR3VsiGRHjSagssm/zCAIcY2k3
	GSYsG6ONhNdaRKX8OmtFxqLpWWM1GesBw75T4OB32Cg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rp8vghmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 07:34:11 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4727YBie017758;
	Fri, 2 Aug 2024 07:34:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rp8vghmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 07:34:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4723FXZ8018863;
	Fri, 2 Aug 2024 07:34:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q634k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 07:34:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4727Y6VC21693058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 07:34:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CE0B20067;
	Fri,  2 Aug 2024 07:34:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99AEF2005A;
	Fri,  2 Aug 2024 07:34:04 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.217])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 07:34:04 +0000 (GMT)
Date: Fri, 2 Aug 2024 13:04:02 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 10/20] ext4: get rid of ppath in
 ext4_ext_create_new_leaf()
Message-ID: <ZqyL6rmtwl6N4MWR@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-11-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-11-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wKEMLnYKOE5DL0znAtdydpP9edbY7Rdy
X-Proofpoint-ORIG-GUID: b0B-8raEEwRxqDGsz0eBhM6QQYFGNQz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_04,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=770 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020047

On Wed, Jul 10, 2024 at 12:06:44PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_ext_create_new_leaf(), the following is
> done here:
> 
>  * Free the extents path when an error is encountered.
>  * Its caller needs to update ppath if it uses ppath.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Hi Baokun,

The changes look good to me, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

That being said, IIUC i think this patchset also fixes a potential UAF
bug. Below is a sample trace with dummy values:

ext4_ext_insert_extent
  path = *ppath = 2000
  ext4_ext_create_new_leaf(ppath)
    path = *ppath = 2000
    ext4_find_extent(path = 2000)
      if (depth > path[0].p_maxdepth)
            kfree(path = 2000);
            path = NULL;
      path = kcalloc() = 3000
      ...
      return path;
  path = 3000
  *ppath = 3000;
  return;
/* here path is still 2000 *, UAF! */
eh = path[depth].p_hdr 

I'm not completely sure if we can hit (depth > path[0].p_maxdepth) in the
above codepath but I think the flow is still a bit fragile. Maybe this
should be fixed in a separate patch first. What do you think?

Regards,
ojaswin

 ---
>  fs/ext4/extents.c | 41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 6dfb5d03e197..0d6ce9e74b01 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1397,13 +1397,12 @@ static int ext4_ext_grow_indepth(handle_t *handle, struct inode *inode,
>   * finds empty index and adds new leaf.
>   * if no free index is found, then it requests in-depth growing.
>   */
> -static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
> -           unsigned int mb_flags,
> -           unsigned int gb_flags,
> -           struct ext4_ext_path **ppath,
> -           struct ext4_extent *newext)
> +static struct ext4_ext_path *
> +ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
> +      unsigned int mb_flags, unsigned int gb_flags,
> +      struct ext4_ext_path *path,
> +      struct ext4_extent *newext)
>  {
> - struct ext4_ext_path *path = *ppath;
>   struct ext4_ext_path *curp;
>   int depth, i, err = 0;
>  
> @@ -1424,28 +1423,24 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
>      * entry: create all needed subtree and add new leaf */
>     err = ext4_ext_split(handle, inode, mb_flags, path, newext, i);
>     if (err)
> -     goto out;
> +     goto errout;
>  
>     /* refill path */
>     path = ext4_find_extent(inode,
>             (ext4_lblk_t)le32_to_cpu(newext->ee_block),
>             path, gb_flags);
> -   if (IS_ERR(path))
> -     err = PTR_ERR(path);
>   } else {
>     /* tree is full, time to grow in depth */
>     err = ext4_ext_grow_indepth(handle, inode, mb_flags);
>     if (err)
> -     goto out;
> +     goto errout;
>  
>     /* refill path */
>     path = ext4_find_extent(inode,
>            (ext4_lblk_t)le32_to_cpu(newext->ee_block),
>             path, gb_flags);
> -   if (IS_ERR(path)) {
> -     err = PTR_ERR(path);
> -     goto out;
> -   }
> +   if (IS_ERR(path))
> +     return path;
>  
>     /*
>      * only first (depth 0 -> 1) produces free space;
> @@ -1457,9 +1452,11 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
>       goto repeat;
>     }
>   }
> -out:
> - *ppath = IS_ERR(path) ? NULL : path;
> - return err;
> + return path;
> +
> +errout:
> + ext4_free_ext_path(path);
> + return ERR_PTR(err);
>  }
>  
>  /*
> @@ -2112,10 +2109,14 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>    */
>   if (gb_flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
>     mb_flags |= EXT4_MB_USE_RESERVED;
> - err = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
> -              ppath, newext);
> - if (err)
> + path = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
> +         path, newext);
> + if (IS_ERR(path)) {
> +   *ppath = NULL;
> +   err = PTR_ERR(path);
>     goto cleanup;
> + }
> + *ppath = path;
>   depth = ext_depth(inode);
>   eh = path[depth].p_hdr;
>  
> -- 
> 2.39.2
> 

