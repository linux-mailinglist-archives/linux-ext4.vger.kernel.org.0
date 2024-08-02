Return-Path: <linux-ext4+bounces-3599-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCAF9459AC
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 10:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E972826D0
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA941C0DF8;
	Fri,  2 Aug 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mfOE3KR2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3B1EB4B6;
	Fri,  2 Aug 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586373; cv=none; b=adS3vsCQ1IgAEE3bnbTWGbalXJmIaimA1yqsyzyB0/m8XCXjD6SQUw3f/Q+T882qK4nq7ANXaTtU3r8WlyczbxraC+RnX3AKNjtfmRiZ/i/aEO1dnKTkQBntixdH6h3/WhHZpASHD7KDEi/rjaDIVb4CUpAz/d+2ApWSZwOIXWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586373; c=relaxed/simple;
	bh=74TdHZpCw9oKk4b4fcMbOV2QMxETVnkAZlbyxd7RHoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIAsCNM/xyDfUnQ/yJcrclOP/ZKKhqsqTeDqNgZEkDbyEQ6uJ9+JfZrpE+2ZvYyB4ARpKdYNKMcUPwJ3mS3qUgtutASEqAH7mQXpweUoOlFNK36HIM2F0DZfjNKV54wzw4Lghj8IhrFnx/B5jsQJbTjBvudWLdk3nIXt+NrLdr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mfOE3KR2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4725vYoL003864;
	Fri, 2 Aug 2024 08:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=GL4Ag+evMWsi7ZcpKXJi8yXOSjK
	H/FqLrSaQlqvoTgw=; b=mfOE3KR2zwxH4UxtvknmLGUIpQAo+YxmvJ9cI3CGFSp
	ZP8UNvNqmPMcMmSXez+d5mJlrHcO3MgMHRCmwbmgchuQJ5gwhHS1b/45jdHWau1T
	Xx2yeEtv9VeLBD8gWQoI7wD/HbwPboFFkE8SZrraF/iLp/SBDzHtrtZqCt78iMI1
	VRI6Ph4vPKyKvs2v99U13GuGnQAu9dfkw8HaikOHOg3WQ0mQ1CqUmNr5fshfxFI5
	71DAAOQ+ac9joJRRaXSK1sXZk/dULb5BnmIE/ucT17wTYJwmnMYy8JZfjoTaJlRz
	BI2PHnckjQSE080k8l8kZl9HHqywZ1o0tp34T+Ghm5Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rr17rf0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 08:12:31 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4728CVUv024792;
	Fri, 2 Aug 2024 08:12:31 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rr17rf0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 08:12:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4727qAQP003748;
	Fri, 2 Aug 2024 08:12:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndemwyvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 08:12:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4728CQ3628049786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 08:12:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D85620040;
	Fri,  2 Aug 2024 08:12:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F03372004B;
	Fri,  2 Aug 2024 08:12:23 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.217])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 08:12:23 +0000 (GMT)
Date: Fri, 2 Aug 2024 13:42:21 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 12/20] ext4: get rid of ppath in ext4_split_extent_at()
Message-ID: <ZqyU5XLEGr1OOhzn@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-13-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-13-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jEZ-WDwG5SiPFr2vnLBDB473L1xWdC2d
X-Proofpoint-ORIG-GUID: h0fGO-pjkwF2SZdK0elxW_khAFurLxWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_04,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=623
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408020053

On Wed, Jul 10, 2024 at 12:06:46PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_split_extent_at(), the following is done
> here:
> 
>  * Free the extents path when an error is encountered.
>  * Its caller needs to update ppath if it uses ppath.
>  * Teach ext4_ext_show_leaf() to skip error pointer.
>  * Propagate ext4_find_extent() error return value in ext4_insert_range().
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Hi Baokun,

Change looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> ---
>  fs/ext4/extents.c | 86 ++++++++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index fc75390d591a..c86b1bb7720f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -84,12 +84,11 @@ static void ext4_extent_block_csum_set(struct inode *inode,
>  	et->et_checksum = ext4_extent_block_csum(inode, eh);
>  }
>  
> -static int ext4_split_extent_at(handle_t *handle,
> -			     struct inode *inode,
> -			     struct ext4_ext_path **ppath,
> -			     ext4_lblk_t split,
> -			     int split_flag,
> -			     int flags);
> +static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
> +						  struct inode *inode,
> +						  struct ext4_ext_path *path,
> +						  ext4_lblk_t split,
> +						  int split_flag, int flags);
>  
>  static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>  {
> @@ -341,9 +340,15 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
>  	if (nofail)
>  		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
>  
> -	return ext4_split_extent_at(handle, inode, ppath, lblk, unwritten ?
> +	path = ext4_split_extent_at(handle, inode, path, lblk, unwritten ?
>  			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
>  			flags);
> +	if (IS_ERR(path)) {
> +		*ppath = NULL;
> +		return PTR_ERR(path);
> +	}
> +	*ppath = path;
> +	return 0;
>  }
>  
>  static int
> @@ -694,7 +699,7 @@ static void ext4_ext_show_leaf(struct inode *inode, struct ext4_ext_path *path)
>  	struct ext4_extent *ex;
>  	int i;
>  
> -	if (!path)
> +	if (IS_ERR_OR_NULL(path))
>  		return;
>  
>  	eh = path[depth].p_hdr;
> @@ -3174,16 +3179,14 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
>   *  a> the extent are splitted into two extent.
>   *  b> split is not needed, and just mark the extent.
>   *
> - * return 0 on success.
> + * Return an extent path pointer on success, or an error pointer on failure.
>   */
> -static int ext4_split_extent_at(handle_t *handle,
> -			     struct inode *inode,
> -			     struct ext4_ext_path **ppath,
> -			     ext4_lblk_t split,
> -			     int split_flag,
> -			     int flags)
> +static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
> +						  struct inode *inode,
> +						  struct ext4_ext_path *path,
> +						  ext4_lblk_t split,
> +						  int split_flag, int flags)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	ext4_fsblk_t newblock;
>  	ext4_lblk_t ee_block;
>  	struct ext4_extent *ex, newex, orig_ex, zero_ex;
> @@ -3254,14 +3257,12 @@ static int ext4_split_extent_at(handle_t *handle,
>  		ext4_ext_mark_unwritten(ex2);
>  
>  	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
> -	if (!IS_ERR(path)) {
> -		*ppath = path;
> +	if (!IS_ERR(path))
>  		goto out;
> -	}
> -	*ppath = NULL;
> +
>  	err = PTR_ERR(path);
>  	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> -		return err;
> +		return path;
>  
>  	/*
>  	 * Get a new path to try to zeroout or fix the extent length.
> @@ -3271,16 +3272,14 @@ static int ext4_split_extent_at(handle_t *handle,
>  	 * in ext4_da_update_reserve_space() due to an incorrect
>  	 * ee_len causing the i_reserved_data_blocks exception.
>  	 */
> -	path = ext4_find_extent(inode, ee_block, NULL,
> -				flags | EXT4_EX_NOFAIL);
> +	path = ext4_find_extent(inode, ee_block, NULL, flags | EXT4_EX_NOFAIL);
>  	if (IS_ERR(path)) {
>  		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
>  				 split, PTR_ERR(path));
> -		return PTR_ERR(path);
> +		return path;
>  	}
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
> -	*ppath = path;
>  
>  	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
>  		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
> @@ -3332,10 +3331,13 @@ static int ext4_split_extent_at(handle_t *handle,
>  	 * and err is a non-zero error code.
>  	 */
>  	ext4_ext_dirty(handle, inode, path + path->p_depth);
> -	return err;
>  out:
> +	if (err) {
> +		ext4_free_ext_path(path);
> +		path = ERR_PTR(err);
> +	}
>  	ext4_ext_show_leaf(inode, path);
> -	return err;
> +	return path;
>  }
>  
>  /*
> @@ -3379,10 +3381,14 @@ static int ext4_split_extent(handle_t *handle,
>  				       EXT4_EXT_MARK_UNWRIT2;
>  		if (split_flag & EXT4_EXT_DATA_VALID2)
>  			split_flag1 |= EXT4_EXT_DATA_VALID1;
> -		err = ext4_split_extent_at(handle, inode, ppath,
> +		path = ext4_split_extent_at(handle, inode, path,
>  				map->m_lblk + map->m_len, split_flag1, flags1);
> -		if (err)
> +		if (IS_ERR(path)) {
> +			err = PTR_ERR(path);
> +			*ppath = NULL;
>  			goto out;
> +		}
> +		*ppath = path;
>  	} else {
>  		allocated = ee_len - (map->m_lblk - ee_block);
>  	}
> @@ -3390,7 +3396,7 @@ static int ext4_split_extent(handle_t *handle,
>  	 * Update path is required because previous ext4_split_extent_at() may
>  	 * result in split of original leaf or extent zeroout.
>  	 */
> -	path = ext4_find_extent(inode, map->m_lblk, *ppath, flags);
> +	path = ext4_find_extent(inode, map->m_lblk, path, flags);
>  	if (IS_ERR(path)) {
>  		*ppath = NULL;
>  		return PTR_ERR(path);
> @@ -3412,13 +3418,17 @@ static int ext4_split_extent(handle_t *handle,
>  			split_flag1 |= split_flag & (EXT4_EXT_MAY_ZEROOUT |
>  						     EXT4_EXT_MARK_UNWRIT2);
>  		}
> -		err = ext4_split_extent_at(handle, inode, ppath,
> +		path = ext4_split_extent_at(handle, inode, path,
>  				map->m_lblk, split_flag1, flags);
> -		if (err)
> +		if (IS_ERR(path)) {
> +			err = PTR_ERR(path);
> +			*ppath = NULL;
>  			goto out;
> +		}
> +		*ppath = path;
>  	}
>  
> -	ext4_ext_show_leaf(inode, *ppath);
> +	ext4_ext_show_leaf(inode, path);
>  out:
>  	return err ? err : allocated;
>  }
> @@ -5596,6 +5606,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
>  	if (IS_ERR(path)) {
>  		up_write(&EXT4_I(inode)->i_data_sem);
> +		ret = PTR_ERR(path);
>  		goto out_stop;
>  	}
>  
> @@ -5614,22 +5625,21 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  			if (ext4_ext_is_unwritten(extent))
>  				split_flag = EXT4_EXT_MARK_UNWRIT1 |
>  					EXT4_EXT_MARK_UNWRIT2;
> -			ret = ext4_split_extent_at(handle, inode, &path,
> +			path = ext4_split_extent_at(handle, inode, path,
>  					offset_lblk, split_flag,
>  					EXT4_EX_NOCACHE |
>  					EXT4_GET_BLOCKS_PRE_IO |
>  					EXT4_GET_BLOCKS_METADATA_NOFAIL);
>  		}
>  
> -		ext4_free_ext_path(path);
> -		if (ret < 0) {
> +		if (IS_ERR(path)) {
>  			up_write(&EXT4_I(inode)->i_data_sem);
> +			ret = PTR_ERR(path);
>  			goto out_stop;
>  		}
> -	} else {
> -		ext4_free_ext_path(path);
>  	}
>  
> +	ext4_free_ext_path(path);
>  	ext4_es_remove_extent(inode, offset_lblk, EXT_MAX_BLOCKS - offset_lblk);
>  
>  	/*
> -- 
> 2.39.2
> 

