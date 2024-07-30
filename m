Return-Path: <linux-ext4+bounces-3514-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9009940E93
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 12:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC521C20D8D
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8C6194A49;
	Tue, 30 Jul 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DY9y0ObW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D263118A92A;
	Tue, 30 Jul 2024 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333867; cv=none; b=M5cS2SdGuwJaryi8dab4JkWbujiSMvSraw7ytcD0wv8LUbAApiSSWA1iRQuIKasTnWdy1psstirS6zRhR5FNEMaJf9YCk+gMX7zkqJqwzkPbNmYvboVS0d6l8HKzersA6LBhG83l+IiVIjfCubn4LfYGvPOM/wGHQd+uTj6jxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333867; c=relaxed/simple;
	bh=o94XaYoIeO3tIfl5mdSdENmQGMkwJ8TGZeWlxYsW1sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFmK9iKqIAJpDqnNzGbA8CEB9ead15tvaRm3/OfbQPyibNkXdvkYyvsDuRBE3xNXle+S0l1d4gJh5KJdnWNTOqev1RjF6Yi8yCS0ygfPlyZvimgF/znAL7vFjHJPGEA/JVEmVLQ22rk7IJq3xKTUsxAajl3D0gMwRKppDBbkxwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DY9y0ObW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U8xEKV021584;
	Tue, 30 Jul 2024 10:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=vhrIMFv4wy1GsLZoCX0z4Nxyy5E
	U+/PXGf71FJlx/Pk=; b=DY9y0ObWdGjYu+yo6UygoItTDfC3BORHOgNCwl/cUuh
	KP1XOqZ8WIvcxG70ksUqWwpNdiPJY2c19lCaqbK/7+t7LTrAGPJqVz3v0+50Tb/6
	ygt1zHqLsKbT4F5HORehzgZGI+JmVAJ2WH1W+z+1IxdxIQwpSJh1X71eQ9xi6UbL
	MoUHIva9ROJpH3IL6F7VfnRQq/jtpRvNEVXE3JMcH6v1ijwuinoJw6DmYfoAuJ4E
	HgFIIk+TzQk6hPdokxqEt4A8fr8EIcYRl++l6Hzuip3c0KWSYmsYtls0u4cAZ0ZZ
	WXfc4+htqXaVc4S4B13UYxJhEE/8pmeHxUIk0cp1GAg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pw54848e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 10:04:02 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46UA42s7008227;
	Tue, 30 Jul 2024 10:04:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pw54848b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 10:04:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46U7RNHg018863;
	Tue, 30 Jul 2024 10:04:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7pm393-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 10:04:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46UA3uRk37486906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 10:03:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C97522004B;
	Tue, 30 Jul 2024 10:03:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDC4B20043;
	Tue, 30 Jul 2024 10:03:54 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 30 Jul 2024 10:03:54 +0000 (GMT)
Date: Tue, 30 Jul 2024 15:33:52 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 08/20] ext4: get rid of ppath in ext4_find_extent()
Message-ID: <Zqi6iEBlY6WOxQM/@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-9-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-9-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4_ONlU2OrkK8wsywjYchxxasFVsSG0MJ
X-Proofpoint-ORIG-GUID: Qz7bEg2oJ8PVPrmmAERZq33K2v7xQQ2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_09,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=546 impostorscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300070

On Wed, Jul 10, 2024 at 12:06:42PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> Getting rid of ppath in ext4_find_extent() requires its caller to update
> ppath. These ppaths will also be dropped later. No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/ext4.h        |  2 +-
>  fs/ext4/extents.c     | 52 +++++++++++++++++++++++--------------------
>  fs/ext4/move_extent.c |  6 ++---
>  3 files changed, 32 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8007abd4972d..cbe8d6062c52 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3714,7 +3714,7 @@ extern int ext4_ext_insert_extent(handle_t *, struct inode *,
>  				  struct ext4_ext_path **,
>  				  struct ext4_extent *, int);
>  extern struct ext4_ext_path *ext4_find_extent(struct inode *, ext4_lblk_t,
> -					      struct ext4_ext_path **,
> +					      struct ext4_ext_path *,
>  					      int flags);
>  extern void ext4_free_ext_path(struct ext4_ext_path *);
>  extern int ext4_ext_check_inode(struct inode *inode);
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index b1cfce5b57d2..5217e6f53467 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -884,11 +884,10 @@ void ext4_ext_tree_init(handle_t *handle, struct inode *inode)
>  
>  struct ext4_ext_path *
>  ext4_find_extent(struct inode *inode, ext4_lblk_t block,
> -		 struct ext4_ext_path **orig_path, int flags)
> +		 struct ext4_ext_path *path, int flags)
>  {
>  	struct ext4_extent_header *eh;
>  	struct buffer_head *bh;
> -	struct ext4_ext_path *path = orig_path ? *orig_path : NULL;
>  	short int depth, i, ppos = 0;
>  	int ret;
>  	gfp_t gfp_flags = GFP_NOFS;
> @@ -909,7 +908,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>  		ext4_ext_drop_refs(path);
>  		if (depth > path[0].p_maxdepth) {
>  			kfree(path);
> -			*orig_path = path = NULL;
> +			path = NULL;
>  		}
>  	}
>  	if (!path) {
> @@ -964,8 +963,6 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>  
>  err:
>  	ext4_free_ext_path(path);
> -	if (orig_path)
> -		*orig_path = NULL;
>  	return ERR_PTR(ret);
>  }
>  
> @@ -1430,7 +1427,7 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
>  		/* refill path */
>  		path = ext4_find_extent(inode,
>  				    (ext4_lblk_t)le32_to_cpu(newext->ee_block),
> -				    ppath, gb_flags);
> +				    path, gb_flags);
>  		if (IS_ERR(path))
>  			err = PTR_ERR(path);
>  	} else {
> @@ -1442,7 +1439,7 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
>  		/* refill path */
>  		path = ext4_find_extent(inode,
>  				   (ext4_lblk_t)le32_to_cpu(newext->ee_block),
> -				    ppath, gb_flags);
> +				    path, gb_flags);
>  		if (IS_ERR(path)) {
>  			err = PTR_ERR(path);
>  			goto out;
> @@ -1458,8 +1455,8 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
>  			goto repeat;
>  		}
>  	}
> -
>  out:
> +	*ppath = IS_ERR(path) ? NULL : path;
>  	return err;
>  }
>  
> @@ -3260,11 +3257,12 @@ static int ext4_split_extent_at(handle_t *handle,
>  	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
>  	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
>  	 */
> -	path = ext4_find_extent(inode, ee_block, ppath,
> +	path = ext4_find_extent(inode, ee_block, *ppath,
>  				flags | EXT4_EX_NOFAIL);
>  	if (IS_ERR(path)) {
>  		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
>  				 split, PTR_ERR(path));
> +		*ppath = NULL;
>  		return PTR_ERR(path);
>  	}
>  	depth = ext_depth(inode);
> @@ -3379,9 +3377,12 @@ static int ext4_split_extent(handle_t *handle,
>  	 * Update path is required because previous ext4_split_extent_at() may
>  	 * result in split of original leaf or extent zeroout.
>  	 */
> -	path = ext4_find_extent(inode, map->m_lblk, ppath, flags);
> -	if (IS_ERR(path))
> +	path = ext4_find_extent(inode, map->m_lblk, *ppath, flags);
> +	if (IS_ERR(path)) {
> +		*ppath = NULL;
>  		return PTR_ERR(path);
> +	}
> +	*ppath = path;
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
>  	if (!ex) {
> @@ -3767,9 +3768,12 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
>  						 EXT4_GET_BLOCKS_CONVERT);
>  		if (err < 0)
>  			return err;
> -		path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
> -		if (IS_ERR(path))
> +		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
> +		if (IS_ERR(path)) {
> +			*ppath = NULL;
>  			return PTR_ERR(path);
> +		}
> +		*ppath = path;
>  		depth = ext_depth(inode);
>  		ex = path[depth].p_ext;
>  	}
> @@ -3825,9 +3829,12 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN);
>  		if (err < 0)
>  			return err;
> -		path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
> -		if (IS_ERR(path))
> +		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
> +		if (IS_ERR(path)) {
> +			*ppath = NULL;
>  			return PTR_ERR(path);
> +		}
> +		*ppath = path;
>  		depth = ext_depth(inode);
>  		ex = path[depth].p_ext;
>  		if (!ex) {
> @@ -5224,7 +5231,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>  	* won't be shifted beyond EXT_MAX_BLOCKS.
>  	*/
>  	if (SHIFT == SHIFT_LEFT) {
> -		path = ext4_find_extent(inode, start - 1, &path,
> +		path = ext4_find_extent(inode, start - 1, path,
>  					EXT4_EX_NOCACHE);
>  		if (IS_ERR(path))
>  			return PTR_ERR(path);
> @@ -5273,7 +5280,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>  	 * becomes NULL to indicate the end of the loop.
>  	 */
>  	while (iterator && start <= stop) {
> -		path = ext4_find_extent(inode, *iterator, &path,
> +		path = ext4_find_extent(inode, *iterator, path,
>  					EXT4_EX_NOCACHE);
>  		if (IS_ERR(path))
>  			return PTR_ERR(path);
> @@ -5854,11 +5861,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
>  
>  	/* search for the extent closest to the first block in the cluster */
>  	path = ext4_find_extent(inode, EXT4_C2B(sbi, lclu), NULL, 0);
> -	if (IS_ERR(path)) {
> -		err = PTR_ERR(path);
> -		path = NULL;
> -		goto out;
> -	}
> +	if (IS_ERR(path))
> +		return PTR_ERR(path);
>  
>  	depth = ext_depth(inode);
>  
> @@ -5942,7 +5946,7 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
>  		if (ret)
>  			goto out;
>  
> -		path = ext4_find_extent(inode, start, &path, 0);
> +		path = ext4_find_extent(inode, start, path, 0);
>  		if (IS_ERR(path))
>  			return PTR_ERR(path);
>  		ex = path[path->p_depth].p_ext;
> @@ -5956,7 +5960,7 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
>  			if (ret)
>  				goto out;
>  
> -			path = ext4_find_extent(inode, start, &path, 0);
> +			path = ext4_find_extent(inode, start, path, 0);
>  			if (IS_ERR(path))
>  				return PTR_ERR(path);
>  			ex = path[path->p_depth].p_ext;
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 204f53b23622..b0ab19a913bf 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -26,14 +26,14 @@ static inline int
>  get_ext_path(struct inode *inode, ext4_lblk_t lblock,
>  		struct ext4_ext_path **ppath)
>  {
> -	struct ext4_ext_path *path;
> +	struct ext4_ext_path *path = *ppath;
>  
> -	path = ext4_find_extent(inode, lblock, ppath, EXT4_EX_NOCACHE);
> +	*ppath = NULL;
> +	path = ext4_find_extent(inode, lblock, path, EXT4_EX_NOCACHE);
>  	if (IS_ERR(path))
>  		return PTR_ERR(path);
>  	if (path[ext_depth(inode)].p_ext == NULL) {
>  		ext4_free_ext_path(path);
> -		*ppath = NULL;
>  		return -ENODATA;
>  	}
>  	*ppath = path;
Hi Baokun,

The changes look good to me, afaict we've handled updating ppath in all
the places correctly.

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> -- 
> 2.39.2

> 

