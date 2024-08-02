Return-Path: <linux-ext4+bounces-3598-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB294596B
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 10:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6321F22A61
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9831BE860;
	Fri,  2 Aug 2024 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gWXV2I/y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFF1EB4B6;
	Fri,  2 Aug 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585706; cv=none; b=vAKQ1SNSE6cgdmDtDiI+6KfMF4sRptKi+aZV3QzozDUh9eTWSgOSulW0o6Rr0qRlVxXbeBzTW5t8/2P4qOo+7Z2GR9a7bdlhWmqVIPT8c35Pprm0lNKoapS7pWcLCOHVaajuMzN9bYufY/V2Q3hBINT0CJt4deYMyprXHB20rWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585706; c=relaxed/simple;
	bh=R500Cn5B8qtFCg35mthwSk7Fv1djQKxROPouoJ/R/bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqFYHYtB+JGqX+B5vOqqN88D/95cZOBGtr5Q/yXZM65R/vQ6aw62ejVa+rUtxWks2xaw7gI6BWJhp/Hx5vqS7K0v8Wfr15puMk+GuLngzgdwFFZQJQy8Re1+Uk/RodFNQzDh9fkH+2JA2FczAY7f0Vva4e9LKvVk2iL8hgg7oz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gWXV2I/y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4727SK1e030737;
	Fri, 2 Aug 2024 08:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=Vrs80r1ZXuOkvjGKmKjbuFQ1sam
	LTpqvcC+UJ6sdk24=; b=gWXV2I/yqJnGmYoq0cglPtgk2fgqbqeDt01mGE7D75y
	nJqfQyJuNj/FulH5O0lkFfkzJKwjnAgyr1AVQ950cc/P6/SuxUVOlfEt/oBNBjdi
	yZ1q/FY7tDL7oiSxlYhUmYwZL5LTiOmmbTe81Y/lDTR4kdifLOpBjIrLHjZmLgcK
	xq1m/2LZpAu87LUpYWwxp0aEBy/r5CMQMNTCg6jF5ioebyR8dzPnj+T7PBmiHFy7
	QqkM07MFe/7jMGYRTDICGadKc0hUOjdcNVdHJT03b05m8xb1S908azcPGDrQZ9nF
	QPSqtop5Y1WiVnjLpsiPIsEWJoczAFcIC/7GZ08Q00g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ru3gr2dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 08:01:23 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4727wLGe018240;
	Fri, 2 Aug 2024 08:01:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ru3gr2da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 08:01:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47272lh4018867;
	Fri, 2 Aug 2024 08:01:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q66qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 08:01:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47281GeT30868024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 08:01:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E579C2004F;
	Fri,  2 Aug 2024 08:01:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B384520040;
	Fri,  2 Aug 2024 08:01:14 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.217])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 08:01:14 +0000 (GMT)
Date: Fri, 2 Aug 2024 13:31:12 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 11/20] ext4: get rid of ppath in ext4_ext_insert_extent()
Message-ID: <ZqySSHBweO18qJ4R@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-12-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-12-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RFZhTUECWED67WOdkR8j780ORr5ioZXc
X-Proofpoint-GUID: Buh0y4TWqBS5JXMVLs3sjbodCxgyzdga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_04,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=598
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020053

On Wed, Jul 10, 2024 at 12:06:45PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_ext_insert_extent(), the following is done
> here:
> 
>  * Free the extents path when an error is encountered.
>  * Its caller needs to update ppath if it uses ppath.
>  * Free path when npath is used, free npath when it is not used.
>  * The got_allocated_blocks label in ext4_ext_map_blocks() does not
>    update err now, so err is updated to 0 if the err returned by
>    ext4_ext_search_right() is greater than 0 and is about to enter
>    got_allocated_blocks.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> ---
>  fs/ext4/ext4.h        |  7 ++--
>  fs/ext4/extents.c     | 88 ++++++++++++++++++++++++-------------------
>  fs/ext4/fast_commit.c |  8 ++--
>  fs/ext4/migrate.c     |  5 ++-
>  4 files changed, 61 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index cbe8d6062c52..53b4c1f454e6 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3710,9 +3710,10 @@ extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
>  						   int num,
>  						   struct ext4_ext_path *path);
> -extern int ext4_ext_insert_extent(handle_t *, struct inode *,
> -				  struct ext4_ext_path **,
> -				  struct ext4_extent *, int);
> +extern struct ext4_ext_path *ext4_ext_insert_extent(
> +				handle_t *handle, struct inode *inode,
> +				struct ext4_ext_path *path,
> +				struct ext4_extent *newext, int gb_flags);
>  extern struct ext4_ext_path *ext4_find_extent(struct inode *, ext4_lblk_t,
>  					      struct ext4_ext_path *,
>  					      int flags);
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0d6ce9e74b01..fc75390d591a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1974,16 +1974,15 @@ static unsigned int ext4_ext_check_overlap(struct ext4_sb_info *sbi,
>   * inserts requested extent as new one into the tree,
>   * creating new leaf in the no-space case.
>   */
> -int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
> -				struct ext4_ext_path **ppath,
> -				struct ext4_extent *newext, int gb_flags)
> +struct ext4_ext_path *
> +ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
> +		       struct ext4_ext_path *path,
> +		       struct ext4_extent *newext, int gb_flags)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	struct ext4_extent_header *eh;
>  	struct ext4_extent *ex, *fex;
>  	struct ext4_extent *nearex; /* nearest extent */
> -	struct ext4_ext_path *npath = NULL;
> -	int depth, len, err;
> +	int depth, len, err = 0;
>  	ext4_lblk_t next;
>  	int mb_flags = 0, unwritten;
>  
> @@ -1991,14 +1990,16 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  		mb_flags |= EXT4_MB_DELALLOC_RESERVED;
>  	if (unlikely(ext4_ext_get_actual_len(newext) == 0)) {
>  		EXT4_ERROR_INODE(inode, "ext4_ext_get_actual_len(newext) == 0");
> -		return -EFSCORRUPTED;
> +		err = -EFSCORRUPTED;
> +		goto errout;
>  	}
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
>  	eh = path[depth].p_hdr;
>  	if (unlikely(path[depth].p_hdr == NULL)) {
>  		EXT4_ERROR_INODE(inode, "path[%d].p_hdr == NULL", depth);
> -		return -EFSCORRUPTED;
> +		err = -EFSCORRUPTED;
> +		goto errout;
>  	}
>  
>  	/* try to insert block into found extent and return */
> @@ -2036,7 +2037,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  			err = ext4_ext_get_access(handle, inode,
>  						  path + depth);
>  			if (err)
> -				return err;
> +				goto errout;
>  			unwritten = ext4_ext_is_unwritten(ex);
>  			ex->ee_len = cpu_to_le16(ext4_ext_get_actual_len(ex)
>  					+ ext4_ext_get_actual_len(newext));
> @@ -2061,7 +2062,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  			err = ext4_ext_get_access(handle, inode,
>  						  path + depth);
>  			if (err)
> -				return err;
> +				goto errout;
>  
>  			unwritten = ext4_ext_is_unwritten(ex);
>  			ex->ee_block = newext->ee_block;
> @@ -2086,21 +2087,26 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  	if (le32_to_cpu(newext->ee_block) > le32_to_cpu(fex->ee_block))
>  		next = ext4_ext_next_leaf_block(path);
>  	if (next != EXT_MAX_BLOCKS) {
> +		struct ext4_ext_path *npath;
> +
>  		ext_debug(inode, "next leaf block - %u\n", next);
> -		BUG_ON(npath != NULL);
>  		npath = ext4_find_extent(inode, next, NULL, gb_flags);
> -		if (IS_ERR(npath))
> -			return PTR_ERR(npath);
> +		if (IS_ERR(npath)) {
> +			err = PTR_ERR(npath);
> +			goto errout;
> +		}
>  		BUG_ON(npath->p_depth != path->p_depth);
>  		eh = npath[depth].p_hdr;
>  		if (le16_to_cpu(eh->eh_entries) < le16_to_cpu(eh->eh_max)) {
>  			ext_debug(inode, "next leaf isn't full(%d)\n",
>  				  le16_to_cpu(eh->eh_entries));
> +			ext4_free_ext_path(path);
>  			path = npath;
>  			goto has_space;
>  		}
>  		ext_debug(inode, "next leaf has no free space(%d,%d)\n",
>  			  le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
> +		ext4_free_ext_path(npath);
>  	}
>  
>  	/*
> @@ -2111,12 +2117,8 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  		mb_flags |= EXT4_MB_USE_RESERVED;
>  	path = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
>  					path, newext);
> -	if (IS_ERR(path)) {
> -		*ppath = NULL;
> -		err = PTR_ERR(path);
> -		goto cleanup;
> -	}
> -	*ppath = path;
> +	if (IS_ERR(path))
> +		return path;
>  	depth = ext_depth(inode);
>  	eh = path[depth].p_hdr;
>  
> @@ -2125,7 +2127,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  
>  	err = ext4_ext_get_access(handle, inode, path + depth);
>  	if (err)
> -		goto cleanup;
> +		goto errout;
>  
>  	if (!nearex) {
>  		/* there is no extent in this leaf, create first one */
> @@ -2183,17 +2185,20 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  	if (!(gb_flags & EXT4_GET_BLOCKS_PRE_IO))
>  		ext4_ext_try_to_merge(handle, inode, path, nearex);
>  
> -
>  	/* time to correct all indexes above */
>  	err = ext4_ext_correct_indexes(handle, inode, path);
>  	if (err)
> -		goto cleanup;
> +		goto errout;
>  
>  	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> +	if (err)
> +		goto errout;
>  
> -cleanup:
> -	ext4_free_ext_path(npath);
> -	return err;
> +	return path;
> +
> +errout:
> +	ext4_free_ext_path(path);
> +	return ERR_PTR(err);
>  }
>  
>  static int ext4_fill_es_cache_info(struct inode *inode,
> @@ -3248,24 +3253,29 @@ static int ext4_split_extent_at(handle_t *handle,
>  	if (split_flag & EXT4_EXT_MARK_UNWRIT2)
>  		ext4_ext_mark_unwritten(ex2);
>  
> -	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
> -	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> +	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
> +	if (!IS_ERR(path)) {
> +		*ppath = path;
>  		goto out;
> +	}
> +	*ppath = NULL;
> +	err = PTR_ERR(path);
> +	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> +		return err;
>  
>  	/*
> -	 * Update path is required because previous ext4_ext_insert_extent()
> -	 * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
> -	 * guarantees that ext4_find_extent() will not return -ENOMEM,
> -	 * otherwise -ENOMEM will cause a retry in do_writepages(), and a
> -	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
> -	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
> +	 * Get a new path to try to zeroout or fix the extent length.
> +	 * Using EXT4_EX_NOFAIL guarantees that ext4_find_extent()
> +	 * will not return -ENOMEM, otherwise -ENOMEM will cause a
> +	 * retry in do_writepages(), and a WARN_ON may be triggered
> +	 * in ext4_da_update_reserve_space() due to an incorrect
> +	 * ee_len causing the i_reserved_data_blocks exception.
>  	 */
> -	path = ext4_find_extent(inode, ee_block, *ppath,
> +	path = ext4_find_extent(inode, ee_block, NULL,
>  				flags | EXT4_EX_NOFAIL);
>  	if (IS_ERR(path)) {
>  		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
>  				 split, PTR_ERR(path));
> -		*ppath = NULL;
>  		return PTR_ERR(path);
>  	}
>  	depth = ext_depth(inode);
> @@ -3324,7 +3334,7 @@ static int ext4_split_extent_at(handle_t *handle,
>  	ext4_ext_dirty(handle, inode, path + path->p_depth);
>  	return err;
>  out:
> -	ext4_ext_show_leaf(inode, *ppath);
> +	ext4_ext_show_leaf(inode, path);
>  	return err;
>  }
>  
> @@ -4313,6 +4323,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	    get_implied_cluster_alloc(inode->i_sb, map, &ex2, path)) {
>  		ar.len = allocated = map->m_len;
>  		newblock = map->m_pblk;
> +		err = 0;
>  		goto got_allocated_blocks;
>  	}
>  
> @@ -4385,8 +4396,9 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  		map->m_flags |= EXT4_MAP_UNWRITTEN;
>  	}
>  
> -	err = ext4_ext_insert_extent(handle, inode, &path, &newex, flags);
> -	if (err) {
> +	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
> +	if (IS_ERR(path)) {
> +		err = PTR_ERR(path);
>  		if (allocated_clusters) {
>  			int fb_flags = 0;
>  
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 87c009e0c59a..1dee40477727 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1777,12 +1777,12 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  			if (ext4_ext_is_unwritten(ex))
>  				ext4_ext_mark_unwritten(&newex);
>  			down_write(&EXT4_I(inode)->i_data_sem);
> -			ret = ext4_ext_insert_extent(
> -				NULL, inode, &path, &newex, 0);
> +			path = ext4_ext_insert_extent(NULL, inode,
> +						      path, &newex, 0);
>  			up_write((&EXT4_I(inode)->i_data_sem));
> -			ext4_free_ext_path(path);
> -			if (ret)
> +			if (IS_ERR(path))
>  				goto out;
> +			ext4_free_ext_path(path);
>  			goto next;
>  		}
>  
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index d98ac2af8199..0f68b8a14560 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -37,7 +37,6 @@ static int finish_range(handle_t *handle, struct inode *inode,
>  	path = ext4_find_extent(inode, lb->first_block, NULL, 0);
>  	if (IS_ERR(path)) {
>  		retval = PTR_ERR(path);
> -		path = NULL;
>  		goto err_out;
>  	}
>  
> @@ -53,7 +52,9 @@ static int finish_range(handle_t *handle, struct inode *inode,
>  	retval = ext4_datasem_ensure_credits(handle, inode, needed, needed, 0);
>  	if (retval < 0)
>  		goto err_out;
> -	retval = ext4_ext_insert_extent(handle, inode, &path, &newext, 0);
> +	path = ext4_ext_insert_extent(handle, inode, path, &newext, 0);
> +	if (IS_ERR(path))
> +		retval = PTR_ERR(path);
>  err_out:
>  	up_write((&EXT4_I(inode)->i_data_sem));
>  	ext4_free_ext_path(path);
> -- 
> 2.39.2
> 

