Return-Path: <linux-ext4+bounces-3484-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E668B93DEC2
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 12:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CC9B218D4
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB7954BD4;
	Sat, 27 Jul 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="at5+pjQO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA14411;
	Sat, 27 Jul 2024 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077030; cv=none; b=fH05G38qjBsEdZzSBzQziZomx+RmYPH6b1r7/wDaePMqqVDZFyv8zszpOSCB+RQdwKShZbtX3/PCGQhsNrEiKthZkfGckYd+DvHRiP57brf4x27Y77MtSn3I8LgoLts6+TAdmZrEnYf+cwFTJg034N64RM1jRgbE7lwZKa56ExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077030; c=relaxed/simple;
	bh=sng6oj5ZbLfPaV/gznq0oLjeEepFBoIOpkgaQk/ZiAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPkeGfGZkAtkhW28sgDrYH+YzbLthwgcCXGoP2F6X4u5A47DN42MswjIkjU/CzPe/Tt3Nz0GipUno7HTpnxvGW/1kJDX7lExdfxvW6iEjFEW4Q6fRvSQJ0Xzvqlq9FRWRKvQTfxTO8KTH/cGRwf1pSXcoE+T9u7F9yinn74+3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=at5+pjQO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46R9KJIA024402;
	Sat, 27 Jul 2024 10:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=SI5acp+c8yf80KE2oSOe4ktTQbp
	ySqxmSxHyduEX2jc=; b=at5+pjQOc6XiN3Ir0O4tMvkutynYNLn3Py8S2Qly3oX
	bsmJbHyY8XIgkx8BfFgPRcCJSySLmKRyWpwr22iUFwaFAgwNBNcTjmfH6FFVjlqn
	Hydcx7i3/aw/pujp9MF9x/BiItb/Bsm5gEh+1qc74FYjaF9Mt7x0RMSr1PyvUFwz
	2vjPIzb6Jaf5kKNZmFMUdaEUEDYa4xu+QL5BKbmEGTo0ti5ah/CVtMv6Pn/QJLLe
	XrxCbG3VywviiD9eyiOhWPWL61X5Ix/KBs6w4t8Nqv7gsrxWJcpfg9e2q1Odboyf
	xEtv1V2nhFsbTT2W2NwBxJDF3SVEE11j1Kl3WM93hvA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mrd9rnrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jul 2024 10:43:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46RAhSqI026239;
	Sat, 27 Jul 2024 10:43:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mrd9rnrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jul 2024 10:43:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46RAQDEt005876;
	Sat, 27 Jul 2024 10:43:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2pysrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jul 2024 10:43:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46RAhMkN27656724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 10:43:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF7A520040;
	Sat, 27 Jul 2024 10:43:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE95A2004B;
	Sat, 27 Jul 2024 10:43:20 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.37.64])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 27 Jul 2024 10:43:20 +0000 (GMT)
Date: Sat, 27 Jul 2024 16:13:18 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 06/20] ext4: avoid use-after-free in ext4_ext_show_leaf()
Message-ID: <ZqTPRqA8G8/fSEi1@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-7-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-7-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YQFvFrmDfzopzTtIqr_4KBOPJqjuWeKd
X-Proofpoint-GUID: vPD80CX5vGg9HNp24EJQUwF6xSO8tLRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=921
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407270067

On Wed, Jul 10, 2024 at 12:06:40PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_find_extent(), path may be freed by error or be reallocated, so
> using a previously saved *ppath may have been freed and thus may trigger
> use-after-free, as follows:
> 
> ext4_split_extent
>   path = *ppath;
>   ext4_split_extent_at(ppath)
>   path = ext4_find_extent(ppath)
>   ext4_split_extent_at(ppath)
>     // ext4_find_extent fails to free path
>     // but zeroout succeeds
>   ext4_ext_show_leaf(inode, path)
>     eh = path[depth].p_hdr
>     // path use-after-free !!!
> 
> Similar to ext4_split_extent_at(), we use *ppath directly as an input to
> ext4_ext_show_leaf(). Fix a spelling error by the way.
> 
> Same problem in ext4_ext_handle_unwritten_extents(). Since 'path' is only
> used in ext4_ext_show_leaf(), remove 'path' and use *ppath directly.
> 
> This issue is triggered only when EXT_DEBUG is defined and therefore does
> not affect functionality.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> ---
>  fs/ext4/extents.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3a70a0739af8..1660434fbfc7 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3328,7 +3328,7 @@ static int ext4_split_extent_at(handle_t *handle,
>  }
>  
>  /*
> - * ext4_split_extents() splits an extent and mark extent which is covered
> + * ext4_split_extent() splits an extent and mark extent which is covered
>   * by @map as split_flags indicates
>   *
>   * It may result in splitting the extent into multiple extents (up to three)
> @@ -3404,7 +3404,7 @@ static int ext4_split_extent(handle_t *handle,
>  			goto out;
>  	}
>  
> -	ext4_ext_show_leaf(inode, path);
> +	ext4_ext_show_leaf(inode, *ppath);
>  out:
>  	return err ? err : allocated;
>  }
> @@ -3869,14 +3869,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  			struct ext4_ext_path **ppath, int flags,
>  			unsigned int allocated, ext4_fsblk_t newblock)
>  {
> -	struct ext4_ext_path __maybe_unused *path = *ppath;
>  	int ret = 0;
>  	int err = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
>  		  (unsigned long long)map->m_lblk, map->m_len, flags,
>  		  allocated);
> -	ext4_ext_show_leaf(inode, path);
> +	ext4_ext_show_leaf(inode, *ppath);
>  
>  	/*
>  	 * When writing into unwritten space, we should not fail to
> @@ -3973,7 +3972,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	if (allocated > map->m_len)
>  		allocated = map->m_len;
>  	map->m_len = allocated;
> -	ext4_ext_show_leaf(inode, path);
> +	ext4_ext_show_leaf(inode, *ppath);
>  out2:
>  	return err ? err : allocated;
>  }
> -- 
> 2.39.2
> 

