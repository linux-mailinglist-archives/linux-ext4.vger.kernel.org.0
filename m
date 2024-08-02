Return-Path: <linux-ext4+bounces-3620-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B56794648A
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 22:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E651F22480
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 20:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363E7A141;
	Fri,  2 Aug 2024 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lOsK0cY9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A01ABEA7;
	Fri,  2 Aug 2024 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631502; cv=none; b=rd2A0+cIA9QO8oNbP6k2CoORPgtCPPpP6T9luZOZsqm5iLbWabVSa9p1Rw1WHU8zhgClcYbHmJdYA88/pRacZ3K7KKqPr2yG0lCZBs7dHM3MtnN8MjNBjzm1oAePl+/iAk4MkoDCWUzt5bqBAyEYgXMlrZp8wZiZsRN8U6XVETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631502; c=relaxed/simple;
	bh=UG+Tf0zLIJsnEOiKcLWPdaE2Aqnq3oIrHPGa8puNC34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utC+1++a60jRnOZJjdG1M5rwy4iuVl42BTqCsAp4mLR8l55bY6SLbLTIUQ9ONxI/iQOk0sIWglvFEGRaGeK4kxdOl/nS1esKli1tcNE4PIKJ9AXVeUcpbawJpWt2igvU/56hPjAxsA1F0uFWkc0ftS73mncct1M/0QJZY4RNRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lOsK0cY9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472Jh4f5001291;
	Fri, 2 Aug 2024 20:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=Whnjxj3bSdaS7ZHVhSTnvA+kLT3
	7apGLSKbqpuygwpc=; b=lOsK0cY9ArDIAmQpYShhQWQk2TcHuByMpoh+BiGHXxD
	6WfipiMK8RTvC+pKK6FH4JM9hBtE/ZBIrplIHUgXZDc5kvn6++VEaeFlL5k8Ya+a
	9OIOvtqfRE3zpoAig+FMgbcXwssZ1tHKhguGCJQ7wbUOWiZMq3I3P4HrrC8BuknZ
	q2YZuIiywHPZ9ReKSh2MK/0NrGirFxgDiTZLLl5HO9ROxCsNR+PjuJfxRt6TS5Q8
	C9614CZ7DO3QJOnLoAXxp93OenFuzt3TZwxPGKC6+qHhAMFYMZGlN7nVReN0K0tZ
	3w6Fc0Q7rDF7heJJvneNpibe/P/IICjjglnF/8cJorw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rw9tse6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:44:47 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472KikIp011970;
	Fri, 2 Aug 2024 20:44:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rw9tse6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:44:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472IQeuw011142;
	Fri, 2 Aug 2024 20:44:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn91jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:44:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472KifIO27198048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 20:44:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 289A920043;
	Fri,  2 Aug 2024 20:44:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ACC420040;
	Fri,  2 Aug 2024 20:44:39 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 20:44:39 +0000 (GMT)
Date: Sat, 3 Aug 2024 02:14:37 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 18/20] ext4: get rid of ppath in
 ext4_ext_handle_unwritten_extents()
Message-ID: <Zq1FNdHomYwMZ3Hz@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-19-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-19-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n2ix9dLGgFrygVm2CaRL3lmaEA8jde5E
X-Proofpoint-GUID: maZHF86eXwCJzYFn_uzZEMst7s2cHLJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_16,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=702
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020142

On Wed, Jul 10, 2024 at 12:06:52PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_ext_handle_unwritten_extents(), the
> following is done here:
> 
>  * Free the extents path when an error is encountered.
>  * The 'allocated' is changed from passing a value to passing an address.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good Baokun, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/extents.c | 82 +++++++++++++++++++++--------------------------
>  1 file changed, 37 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 59e80926fe3a..badadcd64e66 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3887,18 +3887,18 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	return 0;
>  }
>  
> -static int
> +static struct ext4_ext_path *
>  ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  			struct ext4_map_blocks *map,
> -			struct ext4_ext_path **ppath, int flags,
> -			unsigned int allocated, ext4_fsblk_t newblock)
> +			struct ext4_ext_path *path, int flags,
> +			unsigned int *allocated, ext4_fsblk_t newblock)
>  {
>  	int err = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
>  		  (unsigned long long)map->m_lblk, map->m_len, flags,
> -		  allocated);
> -	ext4_ext_show_leaf(inode, *ppath);
> +		  *allocated);
> +	ext4_ext_show_leaf(inode, path);
>  
>  	/*
>  	 * When writing into unwritten space, we should not fail to
> @@ -3907,40 +3907,34 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL;
>  
>  	trace_ext4_ext_handle_unwritten_extents(inode, map, flags,
> -						    allocated, newblock);
> +						*allocated, newblock);
>  
>  	/* get_block() before submitting IO, split the extent */
>  	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
> -		*ppath = ext4_split_convert_extents(handle, inode, map, *ppath,
> -				flags | EXT4_GET_BLOCKS_CONVERT, &allocated);
> -		if (IS_ERR(*ppath)) {
> -			err = PTR_ERR(*ppath);
> -			*ppath = NULL;
> -			goto out2;
> -		}
> +		path = ext4_split_convert_extents(handle, inode, map, path,
> +				flags | EXT4_GET_BLOCKS_CONVERT, allocated);
> +		if (IS_ERR(path))
> +			return path;
>  		/*
>  		 * shouldn't get a 0 allocated when splitting an extent unless
>  		 * m_len is 0 (bug) or extent has been corrupted
>  		 */
> -		if (unlikely(allocated == 0)) {
> +		if (unlikely(*allocated == 0)) {
>  			EXT4_ERROR_INODE(inode,
>  					 "unexpected allocated == 0, m_len = %u",
>  					 map->m_len);
>  			err = -EFSCORRUPTED;
> -			goto out2;
> +			goto errout;
>  		}
>  		map->m_flags |= EXT4_MAP_UNWRITTEN;
>  		goto out;
>  	}
>  	/* IO end_io complete, convert the filled extent to written */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT) {
> -		*ppath = ext4_convert_unwritten_extents_endio(handle, inode,
> -							      map, *ppath);
> -		if (IS_ERR(*ppath)) {
> -			err = PTR_ERR(*ppath);
> -			*ppath = NULL;
> -			goto out2;
> -		}
> +		path = ext4_convert_unwritten_extents_endio(handle, inode,
> +							    map, path);
> +		if (IS_ERR(path))
> +			return path;
>  		ext4_update_inode_fsync_trans(handle, inode, 1);
>  		goto map_out;
>  	}
> @@ -3972,23 +3966,20 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	 * For buffered writes, at writepage time, etc.  Convert a
>  	 * discovered unwritten extent to written.
>  	 */
> -	*ppath = ext4_ext_convert_to_initialized(handle, inode, map, *ppath,
> -						 flags, &allocated);
> -	if (IS_ERR(*ppath)) {
> -		err = PTR_ERR(*ppath);
> -		*ppath = NULL;
> -		goto out2;
> -	}
> +	path = ext4_ext_convert_to_initialized(handle, inode, map, path,
> +					       flags, allocated);
> +	if (IS_ERR(path))
> +		return path;
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	/*
>  	 * shouldn't get a 0 allocated when converting an unwritten extent
>  	 * unless m_len is 0 (bug) or extent has been corrupted
>  	 */
> -	if (unlikely(allocated == 0)) {
> +	if (unlikely(*allocated == 0)) {
>  		EXT4_ERROR_INODE(inode, "unexpected allocated == 0, m_len = %u",
>  				 map->m_len);
>  		err = -EFSCORRUPTED;
> -		goto out2;
> +		goto errout;
>  	}
>  
>  out:
> @@ -3997,12 +3988,15 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	map->m_flags |= EXT4_MAP_MAPPED;
>  out1:
>  	map->m_pblk = newblock;
> -	if (allocated > map->m_len)
> -		allocated = map->m_len;
> -	map->m_len = allocated;
> -	ext4_ext_show_leaf(inode, *ppath);
> -out2:
> -	return err ? err : allocated;
> +	if (*allocated > map->m_len)
> +		*allocated = map->m_len;
> +	map->m_len = *allocated;
> +	ext4_ext_show_leaf(inode, path);
> +	return path;
> +
> +errout:
> +	ext4_free_ext_path(path);
> +	return ERR_PTR(err);
>  }
>  
>  /*
> @@ -4199,7 +4193,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	struct ext4_extent newex, *ex, ex2;
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	ext4_fsblk_t newblock = 0, pblk;
> -	int err = 0, depth, ret;
> +	int err = 0, depth;
>  	unsigned int allocated = 0, offset = 0;
>  	unsigned int allocated_clusters = 0;
>  	struct ext4_allocation_request ar;
> @@ -4273,13 +4267,11 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  				goto out;
>  			}
>  
> -			ret = ext4_ext_handle_unwritten_extents(
> -				handle, inode, map, &path, flags,
> -				allocated, newblock);
> -			if (ret < 0)
> -				err = ret;
> -			else
> -				allocated = ret;
> +			path = ext4_ext_handle_unwritten_extents(
> +				handle, inode, map, path, flags,
> +				&allocated, newblock);
> +			if (IS_ERR(path))
> +				err = PTR_ERR(path);
>  			goto out;
>  		}
>  	}
> -- 
> 2.39.2
> 

