Return-Path: <linux-ext4+bounces-3616-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0862F946446
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 22:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 746FFB21E14
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70C4D8A1;
	Fri,  2 Aug 2024 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GnoLVTv9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842C1ABEAB;
	Fri,  2 Aug 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722629885; cv=none; b=D2ohyGBuj4haDztOqYCT5ymwgpMkD4loYFed5RPgfjEM5gphZtQ4rQ+BXROB3qzx4TBRtVgVKavc4OF2XFfpCgXI3byozJwaa1b2dEw1EbHG3o5NtwAsiZr4Y5Y0itU0BZpC87HxqwKtkjcQ9Uyuc7BDWNm4yR41P3lw/9m8MxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722629885; c=relaxed/simple;
	bh=fDyLjeqQv/jitF1le2J3X0IJsMVm1/Jwz5ya8aTz3nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W93tlAIZgbcd8M5tI4oGHGrLHAJkW1yD8tWmcQ0bzr0QjjgwDHET47bdGstEonftpJGlUbchfRtxO4+XjQC5CMYhbtHuVB01RjcwqHlATj6G1GanOsqfoi5WQ4mFEWkTaIC5IzpS4bPK2ME8ZVwmZSoVHv+Y7zSsnyECw2gpxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GnoLVTv9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472JuYOl027523;
	Fri, 2 Aug 2024 20:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=CxNpZmxja0FW5gkXZzXOKBxZ/sZ
	7BNMmzLEm/Z0oma0=; b=GnoLVTv9zCCE5ECMsHZNQT02HGIcTa4dlg1niLQ789E
	sjUgWW7kHwx/cmUju+Y1G+MFPhxfDIO5BXq0YApFeNAgJO60muZA24ntYE407Rb4
	0EBulNiWRnYuR7oJsdZFd6bVE1BMnXOrNCWsaMMmZ58y9vg3x+DsfVFyfdfa8B2N
	H6d0RqybVNK1rGUwY83CZmQLsdsCkdC6UDGvut+XM3PS/+dTxfiNNBDOqLCaFuIL
	Wmq5PPLgFZDpO/hHfDraF9gCahnt1kbh7lNVn0DZPexBcbTWzBKLEParfAgF/YlA
	1wW2GYQ7gOv6nOSlVW+RIbvHp+cjvlak8qbQ2qCkg5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s3vxgass-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:17:41 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472KHeL4028705;
	Fri, 2 Aug 2024 20:17:40 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s3vxgasq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:17:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472HFd1v007483;
	Fri, 2 Aug 2024 20:17:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7us8vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:17:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472KHafi51511554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 20:17:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2037420043;
	Fri,  2 Aug 2024 20:17:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EB5620040;
	Fri,  2 Aug 2024 20:17:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 20:17:33 +0000 (GMT)
Date: Sat, 3 Aug 2024 01:47:31 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 14/20] ext4: get rid of ppath in ext4_split_extent()
Message-ID: <Zq0+235GoXtmUDps@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-15-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-15-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DR1RBYqTPUqX1h9NfkVqPZ4b5AYCnuJO
X-Proofpoint-ORIG-GUID: _jyIaAHnept1L1sGMpsFhDqQ0Zh6cf2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_15,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=611 malwarescore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020138

On Wed, Jul 10, 2024 at 12:06:48PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_split_extent(), the following is done here:
> 
>  * The 'allocated' is changed from passing a value to passing an address.
>  * Its caller needs to update ppath if it uses ppath.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good Baokun, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> ---
>  fs/ext4/extents.c | 97 ++++++++++++++++++++++++-----------------------
>  1 file changed, 50 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0bd068ed324f..2a4f6c89858c 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3345,21 +3345,18 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>   *   c> Splits in three extents: Somone is splitting in middle of the extent
>   *
>   */
> -static int ext4_split_extent(handle_t *handle,
> -			      struct inode *inode,
> -			      struct ext4_ext_path **ppath,
> -			      struct ext4_map_blocks *map,
> -			      int split_flag,
> -			      int flags)
> +static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
> +					       struct inode *inode,
> +					       struct ext4_ext_path *path,
> +					       struct ext4_map_blocks *map,
> +					       int split_flag, int flags,
> +					       unsigned int *allocated)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	ext4_lblk_t ee_block;
>  	struct ext4_extent *ex;
>  	unsigned int ee_len, depth;
> -	int err = 0;
>  	int unwritten;
>  	int split_flag1, flags1;
> -	int allocated = map->m_len;
>  
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
> @@ -3377,33 +3374,25 @@ static int ext4_split_extent(handle_t *handle,
>  			split_flag1 |= EXT4_EXT_DATA_VALID1;
>  		path = ext4_split_extent_at(handle, inode, path,
>  				map->m_lblk + map->m_len, split_flag1, flags1);
> -		if (IS_ERR(path)) {
> -			err = PTR_ERR(path);
> -			*ppath = NULL;
> -			goto out;
> +		if (IS_ERR(path))
> +			return path;
> +		/*
> +		 * Update path is required because previous ext4_split_extent_at
> +		 * may result in split of original leaf or extent zeroout.
> +		 */
> +		path = ext4_find_extent(inode, map->m_lblk, path, flags);
> +		if (IS_ERR(path))
> +			return path;
> +		depth = ext_depth(inode);
> +		ex = path[depth].p_ext;
> +		if (!ex) {
> +			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
> +					(unsigned long) map->m_lblk);
> +			ext4_free_ext_path(path);
> +			return ERR_PTR(-EFSCORRUPTED);
>  		}
> -		*ppath = path;
> -	} else {
> -		allocated = ee_len - (map->m_lblk - ee_block);
> -	}
> -	/*
> -	 * Update path is required because previous ext4_split_extent_at() may
> -	 * result in split of original leaf or extent zeroout.
> -	 */
> -	path = ext4_find_extent(inode, map->m_lblk, path, flags);
> -	if (IS_ERR(path)) {
> -		*ppath = NULL;
> -		return PTR_ERR(path);
> -	}
> -	*ppath = path;
> -	depth = ext_depth(inode);
> -	ex = path[depth].p_ext;
> -	if (!ex) {
> -		EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
> -				 (unsigned long) map->m_lblk);
> -		return -EFSCORRUPTED;
> +		unwritten = ext4_ext_is_unwritten(ex);
>  	}
> -	unwritten = ext4_ext_is_unwritten(ex);
>  
>  	if (map->m_lblk >= ee_block) {
>  		split_flag1 = split_flag & EXT4_EXT_DATA_VALID2;
> @@ -3414,17 +3403,18 @@ static int ext4_split_extent(handle_t *handle,
>  		}
>  		path = ext4_split_extent_at(handle, inode, path,
>  				map->m_lblk, split_flag1, flags);
> -		if (IS_ERR(path)) {
> -			err = PTR_ERR(path);
> -			*ppath = NULL;
> -			goto out;
> -		}
> -		*ppath = path;
> +		if (IS_ERR(path))
> +			return path;
>  	}
>  
> +	if (allocated) {
> +		if (map->m_lblk + map->m_len > ee_block + ee_len)
> +			*allocated = ee_len - (map->m_lblk - ee_block);
> +		else
> +			*allocated = map->m_len;
> +	}
>  	ext4_ext_show_leaf(inode, path);
> -out:
> -	return err ? err : allocated;
> +	return path;
>  }
>  
>  /*
> @@ -3669,10 +3659,15 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	}
>  
>  fallback:
> -	err = ext4_split_extent(handle, inode, ppath, &split_map, split_flag,
> -				flags);
> -	if (err > 0)
> -		err = 0;
> +	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
> +				 flags, NULL);
> +	if (IS_ERR(path)) {
> +		err = PTR_ERR(path);
> +		*ppath = NULL;
> +		goto out;
> +	}
> +	err = 0;
> +	*ppath = path;
>  out:
>  	/* If we have gotten a failure, don't zero out status tree */
>  	if (!err) {
> @@ -3718,6 +3713,7 @@ static int ext4_split_convert_extents(handle_t *handle,
>  	struct ext4_extent *ex;
>  	unsigned int ee_len;
>  	int split_flag = 0, depth;
> +	unsigned int allocated = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)map->m_lblk, map->m_len);
> @@ -3745,7 +3741,14 @@ static int ext4_split_convert_extents(handle_t *handle,
>  		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
>  	}
>  	flags |= EXT4_GET_BLOCKS_PRE_IO;
> -	return ext4_split_extent(handle, inode, ppath, map, split_flag, flags);
> +	path = ext4_split_extent(handle, inode, path, map, split_flag, flags,
> +				 &allocated);
> +	if (IS_ERR(path)) {
> +		*ppath = NULL;
> +		return PTR_ERR(path);
> +	}
> +	*ppath = path;
> +	return allocated;
>  }
>  
>  static int ext4_convert_unwritten_extents_endio(handle_t *handle,
> -- 
> 2.39.2
> 

