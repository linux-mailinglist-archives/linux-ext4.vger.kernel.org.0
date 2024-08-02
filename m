Return-Path: <linux-ext4+bounces-3619-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3329946473
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 22:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EFAEB214CD
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 20:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841954EB37;
	Fri,  2 Aug 2024 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bEInBi1u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C533DF;
	Fri,  2 Aug 2024 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631125; cv=none; b=amNQBnBos73TAn6X628mim84hyzYXn+ybtb9giLbXYwdgWPjHGaRQZzcznULGxEjiX2dKsKJA2zGwAMpdYi2FXJzj2gv+B3m9VES4AmvZkWQUeAsCFDqQbcDxewM+VtKL+TqKYy/cgzKdA8OS+YKFFtNKQey1K5qYdmbO3zjKS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631125; c=relaxed/simple;
	bh=CUehoCTYbQ8Mm+3PgeJN+ILyBOqdFJjIKwqJjJx+UOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXDKJrvJTryhPlXkcSaJUyZCQ+b2FRn60EnQeyFzVUjrRykdqzBXGJN73oxhbly2/y0NJpAwwN1SutM1CfCaA+PUMY7MpCaT74UN/jrpWO7CJBe/5ZSWgdb5LSObqLKCDU0l4y/g1im30veZCXx/P9fE4CZmbwP5j636MPzhdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bEInBi1u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472ErxJ9010821;
	Fri, 2 Aug 2024 20:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=ehYGdwzUtkK6ghpNoD+pRMeh9uH
	a3nvojcbU/gnRR2s=; b=bEInBi1uHjffwzS9qOsBHSGOVHeGpeOjgV1KlDX/2+S
	ea1vUetEtDlN2CSACO29U4Lu+wLxUzVG1DOcsH7Q96/r7D30vUwJF6BZ6G6A/ctO
	jiMK5V4//7KpxntXiDTOyUOYE1AKl56gZZkXVz7Oca2Ucxm+NL3AxZrRSTyioWhQ
	DCAuU4s9bcP/JCrdyXHQpw2vnK34OeIRCOk/4lqVd7jm7zEKbqAnZyG+p2yM3kHU
	EEVWdmHssUv+kGLlys0QdiwEczdO3pjF3sxAZSPtjJQsgO+n17htj7QP666kewYX
	bHHsGiyMP14xgf0fVSXsxUBMweTVZbesFtf9sw8Kcbw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rygm934b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:38:20 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472KcJIV020461;
	Fri, 2 Aug 2024 20:38:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rygm9349-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:38:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472IPFjI011143;
	Fri, 2 Aug 2024 20:38:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn9113-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:38:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472KcEeL32047730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 20:38:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABDD720040;
	Fri,  2 Aug 2024 20:38:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7EB720043;
	Fri,  2 Aug 2024 20:38:12 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.209])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 20:38:12 +0000 (GMT)
Date: Sat, 3 Aug 2024 02:08:10 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 17/20] ext4: get rid of ppath in
 ext4_ext_convert_to_initialized()
Message-ID: <Zq1DsmzwS19Q7vJP@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-18-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-18-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d6pgwc5WSvr2jI_kovjK6Ai3whrj8gJN
X-Proofpoint-ORIG-GUID: 7v70zqh-xFKKxCfoNutXjLYVGsbHgLrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_16,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=621
 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020142

On Wed, Jul 10, 2024 at 12:06:51PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_ext_convert_to_initialized(), the following
> is done here:
> 
>  * Free the extents path when an error is encountered.
>  * Its caller needs to update ppath if it uses ppath.
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
>  fs/ext4/extents.c | 73 +++++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index b7f443f98e9d..59e80926fe3a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3437,13 +3437,11 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>   *    that are allocated and initialized.
>   *    It is guaranteed to be >= map->m_len.
>   */
> -static int ext4_ext_convert_to_initialized(handle_t *handle,
> -					   struct inode *inode,
> -					   struct ext4_map_blocks *map,
> -					   struct ext4_ext_path **ppath,
> -					   int flags)
> +static struct ext4_ext_path *
> +ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
> +			struct ext4_map_blocks *map, struct ext4_ext_path *path,
> +			int flags, unsigned int *allocated)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	struct ext4_sb_info *sbi;
>  	struct ext4_extent_header *eh;
>  	struct ext4_map_blocks split_map;
> @@ -3453,7 +3451,6 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	unsigned int ee_len, depth, map_len = map->m_len;
>  	int err = 0;
>  	int split_flag = EXT4_EXT_DATA_VALID2;
> -	int allocated = 0;
>  	unsigned int max_zeroout = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
> @@ -3494,6 +3491,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	 *  - L2: we only attempt to merge with an extent stored in the
>  	 *    same extent tree node.
>  	 */
> +	*allocated = 0;
>  	if ((map->m_lblk == ee_block) &&
>  		/* See if we can merge left */
>  		(map_len < ee_len) &&		/*L1*/
> @@ -3523,7 +3521,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  			(prev_len < (EXT_INIT_MAX_LEN - map_len))) {	/*C4*/
>  			err = ext4_ext_get_access(handle, inode, path + depth);
>  			if (err)
> -				goto out;
> +				goto errout;
>  
>  			trace_ext4_ext_convert_to_initialized_fastpath(inode,
>  				map, ex, abut_ex);
> @@ -3538,7 +3536,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  			abut_ex->ee_len = cpu_to_le16(prev_len + map_len);
>  
>  			/* Result: number of initialized blocks past m_lblk */
> -			allocated = map_len;
> +			*allocated = map_len;
>  		}
>  	} else if (((map->m_lblk + map_len) == (ee_block + ee_len)) &&
>  		   (map_len < ee_len) &&	/*L1*/
> @@ -3569,7 +3567,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  		    (next_len < (EXT_INIT_MAX_LEN - map_len))) {	/*C4*/
>  			err = ext4_ext_get_access(handle, inode, path + depth);
>  			if (err)
> -				goto out;
> +				goto errout;
>  
>  			trace_ext4_ext_convert_to_initialized_fastpath(inode,
>  				map, ex, abut_ex);
> @@ -3584,18 +3582,20 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  			abut_ex->ee_len = cpu_to_le16(next_len + map_len);
>  
>  			/* Result: number of initialized blocks past m_lblk */
> -			allocated = map_len;
> +			*allocated = map_len;
>  		}
>  	}
> -	if (allocated) {
> +	if (*allocated) {
>  		/* Mark the block containing both extents as dirty */
>  		err = ext4_ext_dirty(handle, inode, path + depth);
>  
>  		/* Update path to point to the right extent */
>  		path[depth].p_ext = abut_ex;
> +		if (err)
> +			goto errout;
>  		goto out;
>  	} else
> -		allocated = ee_len - (map->m_lblk - ee_block);
> +		*allocated = ee_len - (map->m_lblk - ee_block);
>  
>  	WARN_ON(map->m_lblk < ee_block);
>  	/*
> @@ -3622,21 +3622,21 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	split_map.m_lblk = map->m_lblk;
>  	split_map.m_len = map->m_len;
>  
> -	if (max_zeroout && (allocated > split_map.m_len)) {
> -		if (allocated <= max_zeroout) {
> +	if (max_zeroout && (*allocated > split_map.m_len)) {
> +		if (*allocated <= max_zeroout) {
>  			/* case 3 or 5 */
>  			zero_ex1.ee_block =
>  				 cpu_to_le32(split_map.m_lblk +
>  					     split_map.m_len);
>  			zero_ex1.ee_len =
> -				cpu_to_le16(allocated - split_map.m_len);
> +				cpu_to_le16(*allocated - split_map.m_len);
>  			ext4_ext_store_pblock(&zero_ex1,
>  				ext4_ext_pblock(ex) + split_map.m_lblk +
>  				split_map.m_len - ee_block);
>  			err = ext4_ext_zeroout(inode, &zero_ex1);
>  			if (err)
>  				goto fallback;
> -			split_map.m_len = allocated;
> +			split_map.m_len = *allocated;
>  		}
>  		if (split_map.m_lblk - ee_block + split_map.m_len <
>  								max_zeroout) {
> @@ -3654,27 +3654,24 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  
>  			split_map.m_len += split_map.m_lblk - ee_block;
>  			split_map.m_lblk = ee_block;
> -			allocated = map->m_len;
> +			*allocated = map->m_len;
>  		}
>  	}
>  
>  fallback:
>  	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
>  				 flags, NULL);
> -	if (IS_ERR(path)) {
> -		err = PTR_ERR(path);
> -		*ppath = NULL;
> -		goto out;
> -	}
> -	err = 0;
> -	*ppath = path;
> +	if (IS_ERR(path))
> +		return path;
>  out:
>  	/* If we have gotten a failure, don't zero out status tree */
> -	if (!err) {
> -		ext4_zeroout_es(inode, &zero_ex1);
> -		ext4_zeroout_es(inode, &zero_ex2);
> -	}
> -	return err ? err : allocated;
> +	ext4_zeroout_es(inode, &zero_ex1);
> +	ext4_zeroout_es(inode, &zero_ex2);
> +	return path;
> +
> +errout:
> +	ext4_free_ext_path(path);
> +	return ERR_PTR(err);
>  }
>  
>  /*
> @@ -3896,7 +3893,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  			struct ext4_ext_path **ppath, int flags,
>  			unsigned int allocated, ext4_fsblk_t newblock)
>  {
> -	int ret = 0;
>  	int err = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
> @@ -3976,23 +3972,24 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	 * For buffered writes, at writepage time, etc.  Convert a
>  	 * discovered unwritten extent to written.
>  	 */
> -	ret = ext4_ext_convert_to_initialized(handle, inode, map, ppath, flags);
> -	if (ret < 0) {
> -		err = ret;
> +	*ppath = ext4_ext_convert_to_initialized(handle, inode, map, *ppath,
> +						 flags, &allocated);
> +	if (IS_ERR(*ppath)) {
> +		err = PTR_ERR(*ppath);
> +		*ppath = NULL;
>  		goto out2;
>  	}
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	/*
> -	 * shouldn't get a 0 return when converting an unwritten extent
> +	 * shouldn't get a 0 allocated when converting an unwritten extent
>  	 * unless m_len is 0 (bug) or extent has been corrupted
>  	 */
> -	if (unlikely(ret == 0)) {
> -		EXT4_ERROR_INODE(inode, "unexpected ret == 0, m_len = %u",
> +	if (unlikely(allocated == 0)) {
> +		EXT4_ERROR_INODE(inode, "unexpected allocated == 0, m_len = %u",
>  				 map->m_len);
>  		err = -EFSCORRUPTED;
>  		goto out2;
>  	}
> -	allocated = ret;
>  
>  out:
>  	map->m_flags |= EXT4_MAP_NEW;
> -- 
> 2.39.2
> 

