Return-Path: <linux-ext4+bounces-3485-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CF893DF20
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 13:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFA41F22804
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2024 11:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35EF5D8F0;
	Sat, 27 Jul 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WK+iymWp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E84CB37;
	Sat, 27 Jul 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722079163; cv=none; b=tgxZjvTfWmUW99FLvXz5gU3T3MQXjqqEPz7e/48fCvX57/AMCllPIzNFIs2+lFlohwFZ80d8DeK3SJu3VUOtoj0s4LlsG6YP5XYv5jLT8KhnRhm/IM+W3we4p+TsZ6nJs/flgHcgrxG5/gS5SrPtat1akPuZyJeE4DWgo2iY7OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722079163; c=relaxed/simple;
	bh=yniDgNp34tOrJ9OCd28Zdi6tFrmUOFGfFoYfjp0Jsxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIDt0CviDLThsQ3JYNBZwUHOSx5dTHpqYcDywmwKXgavKGZVv7Pa4Rs0M3IHD+Mj79uTrJxdJz68XUw3V+4fArFZF6mSBXLgkWTkxkUbRx8mUwGRjMfFDzSpNj3n8zjXEzBeFOECSBle1emiUudaLMJLPTl0PmX/NvYTYItGh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WK+iymWp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46RAuEej032086;
	Sat, 27 Jul 2024 11:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=p3Zam5bj3FIGCMqt2deaMDzjNPC
	tjo9u2qYWHmgvrCo=; b=WK+iymWpOiXElY8TglD85CA90l1bnYQVUpJLrVkYrRl
	oJ0wQjB8fMYpdSEu45bb8unmoZyelEmcy4D/4q3TMTzMln8Kqj4tsnuKxbmJsujU
	qgf6gQQMPsTOBmb3pILMiAMtR5aGr7ape0s8hfC+XiOtwjXTQzQQxjiTtkXM9nWF
	ddA0MuTosPvgRYTfq5dpHvOrhQx9zaMvBPkhFfMixxvT2ge63rEy4ghSgP6SFwTy
	wkJkI8Ofq7l1B/f/KV/BukgbcwNMU7OW3zWSpfVC+zxSgLGcvvknSJeaHVQZh89E
	+uNZZGxmEIPwLXwlO68KICz8sL7ATG3DJ5eSOveYnsg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mvyw87yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jul 2024 11:18:51 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46RBIoCs004130;
	Sat, 27 Jul 2024 11:18:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mvyw87yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jul 2024 11:18:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46R8cgCJ006130;
	Sat, 27 Jul 2024 11:18:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40mwht0dv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jul 2024 11:18:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46RBIkbG29622952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 11:18:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 260D820043;
	Sat, 27 Jul 2024 11:18:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1212620040;
	Sat, 27 Jul 2024 11:18:44 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.37.64])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 27 Jul 2024 11:18:43 +0000 (GMT)
Date: Sat, 27 Jul 2024 16:48:41 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>, stable@kernel.org
Subject: Re: [PATCH 07/20] ext4: drop ppath from ext4_ext_replay_update_ex()
 to avoid double-free
Message-ID: <ZqTXkQDYJpjSWn4R@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-8-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-8-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gnc2sN--EWEZgXz2uZZWGXeDDM8fjqd1
X-Proofpoint-ORIG-GUID: Yc7uEyf32ip7gFiLJNotUcNJ-D5nvG6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_08,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=784 mlxscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407270071

On Wed, Jul 10, 2024 at 12:06:41PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> When calling ext4_force_split_extent_at() in ext4_ext_replay_update_ex(),
> the 'ppath' is updated but it is the 'path' that is freed, thus potentially
> triggering a double-free in the following process:
> 
> ext4_ext_replay_update_ex
>   ppath = path
>   ext4_force_split_extent_at(&ppath)
>     ext4_split_extent_at
>       ext4_ext_insert_extent
>         ext4_ext_create_new_leaf
>           ext4_ext_grow_indepth
>             ext4_find_extent
>               if (depth > path[0].p_maxdepth)
>                 kfree(path)                 ---> path First freed
>                 *orig_path = path = NULL    ---> null ppath
>   kfree(path)                               ---> path double-free !!!
> 
> So drop the unnecessary ppath and use path directly to avoid this problem.
> And use ext4_find_extent() directly to update path, avoiding unnecessary
> memory allocation and freeing. Also, propagate the error returned by
> ext4_find_extent() instead of using strange error codes.
> 
> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Hey Baokun, 
These ppath bugs are really subtle indeed :)

Anyways, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>


> ---
>  fs/ext4/extents.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 1660434fbfc7..b1cfce5b57d2 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5920,7 +5920,7 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
>  int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
>  			      int len, int unwritten, ext4_fsblk_t pblk)
>  {
> -	struct ext4_ext_path *path = NULL, *ppath;
> +	struct ext4_ext_path *path;
>  	struct ext4_extent *ex;
>  	int ret;
>  
> @@ -5936,30 +5936,29 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
>  	if (le32_to_cpu(ex->ee_block) != start ||
>  		ext4_ext_get_actual_len(ex) != len) {
>  		/* We need to split this extent to match our extent first */
> -		ppath = path;
>  		down_write(&EXT4_I(inode)->i_data_sem);
> -		ret = ext4_force_split_extent_at(NULL, inode, &ppath, start, 1);
> +		ret = ext4_force_split_extent_at(NULL, inode, &path, start, 1);
>  		up_write(&EXT4_I(inode)->i_data_sem);
>  		if (ret)
>  			goto out;
> -		kfree(path);
> -		path = ext4_find_extent(inode, start, NULL, 0);
> +
> +		path = ext4_find_extent(inode, start, &path, 0);
>  		if (IS_ERR(path))
> -			return -1;
> -		ppath = path;
> +			return PTR_ERR(path);
>  		ex = path[path->p_depth].p_ext;
>  		WARN_ON(le32_to_cpu(ex->ee_block) != start);
> +
>  		if (ext4_ext_get_actual_len(ex) != len) {
>  			down_write(&EXT4_I(inode)->i_data_sem);
> -			ret = ext4_force_split_extent_at(NULL, inode, &ppath,
> +			ret = ext4_force_split_extent_at(NULL, inode, &path,
>  							 start + len, 1);
>  			up_write(&EXT4_I(inode)->i_data_sem);
>  			if (ret)
>  				goto out;
> -			kfree(path);
> -			path = ext4_find_extent(inode, start, NULL, 0);
> +
> +			path = ext4_find_extent(inode, start, &path, 0);
>  			if (IS_ERR(path))
> -				return -EINVAL;
> +				return PTR_ERR(path);
>  			ex = path[path->p_depth].p_ext;
>  		}
>  	}
> -- 
> 2.39.2
> 

