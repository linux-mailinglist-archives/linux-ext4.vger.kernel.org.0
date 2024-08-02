Return-Path: <linux-ext4+bounces-3615-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E66946434
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 22:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F0B283DBB
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 20:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86E0132116;
	Fri,  2 Aug 2024 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M3mtARus"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD82130AC8;
	Fri,  2 Aug 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722628911; cv=none; b=AN7VVVAT8nYBY0h5kUIi3lNAdJVsOtVxdut7yUgMpbgnUfLmGbJWUiSjWso/DEY6XQIt18nvhTeMGpfA7cudKxuUDszwLPnt8tV8mIfqFTSoa9wugqId4LZyP3njkzqrIdNQ4B5X7HcDqNd4v3n7fuaUyWxsWGn6PCkc19pPa0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722628911; c=relaxed/simple;
	bh=UPvLyhCrepzktN65I03MJX1HdEorysyQQppl7EBl/WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKe8m5+txzfYsb94XuqXi9lGf/XzwDHDzon8LU3MNUF/EAbDP8kUoVOaj5HsgsafdbHwqp96rpe//PyPChNEd2zoe7AmhSRg7mEs7Z4hgmLA1RnKuefeUV/ZcCWJeH3Vr4ZnaxjZtEyFid83ETAANFoo1TcB18T3jRhXcwYMxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M3mtARus; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472Jo2SR007371;
	Fri, 2 Aug 2024 20:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=uz+gCn6rD3TVj3Ypf2TG4NM3Drw
	jntXwJxcLnjigR+Y=; b=M3mtARushVhlilgItZ44zzBKZccYVtoX8bY0QgMfoAl
	u5sVN8W+xL3Nxz8ETOdWDPu5R5m7auEsf6EgpAu/6rNMYSOBnRY94eMwf240wLCA
	OlrRQwJi2V+1hQgxma9Th3GcvCWSFRz31lv8qTs20gTjh70HUBWydll+voU6txzS
	q+dUIttzIit5rmxJnoY11TcnqsBB4RNcPWXINdZXCk3LTokUgD4zyifVRUrZ5UMx
	fN304HGXRog8OcixaLhzGL4K5YR0i4WTjufeiBN162SdEM4tc5kQsPsFcFnjKYRk
	jwNvx6x+sH6zE+WTz2cjY5xLLQdKaLjIYZSIZJyKdGw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s4rwg5gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:01:28 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472K1SOn026283;
	Fri, 2 Aug 2024 20:01:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s4rwg5gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:01:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472JOS6B011170;
	Fri, 2 Aug 2024 20:01:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn8uvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:01:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472K1Nci54264252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 20:01:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76C9120043;
	Fri,  2 Aug 2024 20:01:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82D9320040;
	Fri,  2 Aug 2024 20:01:21 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.209])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 20:01:21 +0000 (GMT)
Date: Sat, 3 Aug 2024 01:31:19 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 13/20] ext4: get rid of ppath in
 ext4_force_split_extent_at()
Message-ID: <Zq07D/rySkSKxsw3@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-14-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-14-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wa4Jk673BSEcgLNGARvxKtzbZNF_hX6y
X-Proofpoint-GUID: x3GvETZl6xlQmyEO6etmH3WEf8TqFRNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_15,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxlogscore=821 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020138

On Wed, Jul 10, 2024 at 12:06:47PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_force_split_extent_at(), the following is
> done here:
> 
>  * The ext4_find_extent() can update the extent path so it doesn't have to
>    allocate and free path repeatedly, thus reducing the consumption of
>    memory allocation and freeing in ext4_swap_extents().
> 
> No functional changes.

Looks good Baokun, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

One small comment below..

> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/extents.c | 117 ++++++++++++++++++++++++----------------------
>  1 file changed, 60 insertions(+), 57 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c86b1bb7720f..0bd068ed324f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c

.. snip ..

> @@ -5707,25 +5701,21 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  		int e1_len, e2_len, len;
>  		int split = 0;
>  
> -		path1 = ext4_find_extent(inode1, lblk1, NULL, EXT4_EX_NOCACHE);
> +		path1 = ext4_find_extent(inode1, lblk1, path1, EXT4_EX_NOCACHE);
>  		if (IS_ERR(path1)) {
>  			*erp = PTR_ERR(path1);
> -			path1 = NULL;
> -		finish:
> -			count = 0;
> -			goto repeat;
> +			goto errout;
>  		}
> -		path2 = ext4_find_extent(inode2, lblk2, NULL, EXT4_EX_NOCACHE);
> +		path2 = ext4_find_extent(inode2, lblk2, path2, EXT4_EX_NOCACHE);
>  		if (IS_ERR(path2)) {
>  			*erp = PTR_ERR(path2);
> -			path2 = NULL;
> -			goto finish;
> +			goto errout;
>  		}
>  		ex1 = path1[path1->p_depth].p_ext;
>  		ex2 = path2[path2->p_depth].p_ext;
>  		/* Do we have something to swap ? */
>  		if (unlikely(!ex2 || !ex1))
> -			goto finish;
> +			goto errout;
>  
>  		e1_blk = le32_to_cpu(ex1->ee_block);
>  		e2_blk = le32_to_cpu(ex2->ee_block);
> @@ -5747,7 +5737,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  				next2 = e2_blk;
>  			/* Do we have something to swap */
>  			if (next1 == EXT_MAX_BLOCKS || next2 == EXT_MAX_BLOCKS)
> -				goto finish;
> +				goto errout;
>  			/* Move to the rightest boundary */
>  			len = next1 - lblk1;
>  			if (len < next2 - lblk2)
> @@ -5757,28 +5747,32 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  			lblk1 += len;
>  			lblk2 += len;
>  			count -= len;
> -			goto repeat;
> +			continue;
>  		}
>  
>  		/* Prepare left boundary */
>  		if (e1_blk < lblk1) {
>  			split = 1;
> -			*erp = ext4_force_split_extent_at(handle, inode1,
> -						&path1, lblk1, 0);
> -			if (unlikely(*erp))
> -				goto finish;
> +			path1 = ext4_force_split_extent_at(handle, inode1,
> +							   path1, lblk1, 0);
> +			if (IS_ERR(path1)) {
> +				*erp = PTR_ERR(path1);
> +				goto errout;
> +			}
>  		}
>  		if (e2_blk < lblk2) {
>  			split = 1;
> -			*erp = ext4_force_split_extent_at(handle, inode2,
> -						&path2,  lblk2, 0);
> -			if (unlikely(*erp))
> -				goto finish;
> +			path2 = ext4_force_split_extent_at(handle, inode2,
> +							   path2, lblk2, 0);
> +			if (IS_ERR(path2)) {
> +				*erp = PTR_ERR(path2);
> +				goto errout;
> +			}
>  		}
>  		/* ext4_split_extent_at() may result in leaf extent split,
>  		 * path must to be revalidated. */
>  		if (split)
> -			goto repeat;
> +			continue;
>  
>  		/* Prepare right boundary */
>  		len = count;
> @@ -5789,30 +5783,34 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  
>  		if (len != e1_len) {
>  			split = 1;
> -			*erp = ext4_force_split_extent_at(handle, inode1,
> -						&path1, lblk1 + len, 0);
> -			if (unlikely(*erp))
> -				goto finish;
> +			path1 = ext4_force_split_extent_at(handle, inode1,
> +							path1, lblk1 + len, 0);
> +			if (IS_ERR(path1)) {
> +				*erp = PTR_ERR(path1);
> +				goto errout;
> +			}
>  		}
>  		if (len != e2_len) {
>  			split = 1;
> -			*erp = ext4_force_split_extent_at(handle, inode2,
> -						&path2, lblk2 + len, 0);
> -			if (*erp)
> -				goto finish;
> +			path2 = ext4_force_split_extent_at(handle, inode2,
> +							path2, lblk2 + len, 0);
> +			if (IS_ERR(path2)) {
> +				*erp = PTR_ERR(path2);
> +				goto errout;
> +			}
>  		}
>  		/* ext4_split_extent_at() may result in leaf extent split,
>  		 * path must to be revalidated. */
>  		if (split)
> -			goto repeat;
> +			continue;
>  
>  		BUG_ON(e2_len != e1_len);
>  		*erp = ext4_ext_get_access(handle, inode1, path1 + path1->p_depth);
>  		if (unlikely(*erp))
> -			goto finish;
> +			goto errout;
>  		*erp = ext4_ext_get_access(handle, inode2, path2 + path2->p_depth);
>  		if (unlikely(*erp))
> -			goto finish;
> +			goto errout;
>  
>  		/* Both extents are fully inside boundaries. Swap it now */
>  		tmp_ex = *ex1;
> @@ -5830,7 +5828,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  		*erp = ext4_ext_dirty(handle, inode2, path2 +
>  				      path2->p_depth);
>  		if (unlikely(*erp))
> -			goto finish;
> +			goto errout;
>  		*erp = ext4_ext_dirty(handle, inode1, path1 +
>  				      path1->p_depth);
>  		/*
> @@ -5840,17 +5838,17 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  		 * aborted anyway.
>  		 */
>  		if (unlikely(*erp))
> -			goto finish;
> +			goto errout;
> +
>  		lblk1 += len;
>  		lblk2 += len;
>  		replaced_count += len;
>  		count -= len;
> -
> -	repeat:
> -		ext4_free_ext_path(path1);
> -		ext4_free_ext_path(path2);
> -		path1 = path2 = NULL;
>  	}
> +
> +errout:
> +	ext4_free_ext_path(path1);
> +	ext4_free_ext_path(path2);
>  	return replaced_count;
>  }
>  

In ext4_swap_extents, maybe we should keep the refactoring to a separate
patch than the changes needed to get rid of ppath in
ext4_force_split_extent_at(), the commits would look a bit cleaner and
easier to read that way. I don't feel too strongly about it tho and 
I'll let you take a call.

Regards,
ojaswin

