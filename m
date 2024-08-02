Return-Path: <linux-ext4+bounces-3617-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54578946455
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 22:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C867A1F2268E
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 20:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BDB50A63;
	Fri,  2 Aug 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iKww3umR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA427335C0;
	Fri,  2 Aug 2024 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630407; cv=none; b=RjwVM459PNhorUHqrbp8b/6MPGw2GYrnAnJNiVoV8Mho2joBBFEn5jyzr4i1HzaYSWnzyqh6v5Ya7ieARuvUzz8qwVcYJkoSki98qTYngYgImTNJpM51Ep4fEVJhSunoAFQYq1Bee4OAYJ/EWA/ExKsH/5Mo348yN/dCy+/7xWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630407; c=relaxed/simple;
	bh=rSGGdjpqNkEEfPvBEACkGum3TEe1wucvt0TIuivp4L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/gYroQZ7gFVAH/XXeG0QUR4uD5X1gOP0r8PVWVrdDnaMJ6TPtZEbcdGhL2ztDvsftbdom0ikt90duIraUfixbMJ7cch6buf0fDM3d7G8HuyzKMgfZKftybVtcM2xqLVJfz7JUnl5h+8KpBQtrkaABU6E1rVSQIP1d3J5oCYzc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iKww3umR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472IPb7q029138;
	Fri, 2 Aug 2024 20:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=UuthI4WUF0CJm0OYH6BAkjEylSe
	BfmYwZ9UEOuixeWE=; b=iKww3umR0u39WKzAzgsjll8lPvJIO/DjSHzppnyQIkG
	7G/sLv7qT/bfMn00QSKQD7kD2YACTJug9wRg5I3tEJyy4RMudUA3NQu9N9zNrcgJ
	8XuGEwiB5tlaAFEwPsT4nyRuB/urAZ30UBrFSg/nexGpdPb7Yj4aGttyrKYkE7gF
	5gPcyFeKYYr/mo4ILkfZ1Ffr+l5NZLREyBurZbgUbA3NyXT62s8uCn9b7+4sYvAe
	0FqFwgNvcEKgQYQGe5r+h10NxKiGdHjgCR6Y1y11RzYaV+y+IpP34ZIKfZ1xp/lA
	XGufvxAbmFpFbkd1u9SB+3skjcIheC4cqJbCmgPG0vw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rwqws93w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:26:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472KLUYU030727;
	Fri, 2 Aug 2024 20:26:17 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rwqws93t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:26:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472GlJJ1009205;
	Fri, 2 Aug 2024 20:26:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx3gq9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:26:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472KQD0a49742150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 20:26:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 151A620043;
	Fri,  2 Aug 2024 20:26:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3105D20040;
	Fri,  2 Aug 2024 20:26:11 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 20:26:11 +0000 (GMT)
Date: Sat, 3 Aug 2024 01:56:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 15/20] ext4: get rid of ppath in
 ext4_split_convert_extents()
Message-ID: <Zq1A4GpIe6fnJvFe@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-16-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-16-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zNIK6tuyJcg39DKHer35qhpEfCSjahk5
X-Proofpoint-GUID: Ir_eCRnWtrCczrfAuBx2fu3DpqK5O0zL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_16,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=909 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408020142

On Wed, Jul 10, 2024 at 12:06:49PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_split_convert_extents(), the following is
> done here:
> 
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
>  fs/ext4/extents.c | 65 ++++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2a4f6c89858c..a41cbb8c4475 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3699,21 +3699,21 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>   * being filled will be convert to initialized by the end_io callback function
>   * via ext4_convert_unwritten_extents().
>   *
> - * Returns the size of unwritten extent to be written on success.
> + * The size of unwritten extent to be written is passed to the caller via the
> + * allocated pointer. Return an extent path pointer on success, or an error
> + * pointer on failure.
>   */
> -static int ext4_split_convert_extents(handle_t *handle,
> +static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  					struct inode *inode,
>  					struct ext4_map_blocks *map,
> -					struct ext4_ext_path **ppath,
> -					int flags)
> +					struct ext4_ext_path *path,
> +					int flags, unsigned int *allocated)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	ext4_lblk_t eof_block;
>  	ext4_lblk_t ee_block;
>  	struct ext4_extent *ex;
>  	unsigned int ee_len;
>  	int split_flag = 0, depth;
> -	unsigned int allocated = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)map->m_lblk, map->m_len);
> @@ -3741,14 +3741,8 @@ static int ext4_split_convert_extents(handle_t *handle,
>  		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
>  	}
>  	flags |= EXT4_GET_BLOCKS_PRE_IO;
> -	path = ext4_split_extent(handle, inode, path, map, split_flag, flags,
> -				 &allocated);
> -	if (IS_ERR(path)) {
> -		*ppath = NULL;
> -		return PTR_ERR(path);
> -	}
> -	*ppath = path;
> -	return allocated;
> +	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
> +				 allocated);
>  }
>  
>  static int ext4_convert_unwritten_extents_endio(handle_t *handle,
> @@ -3784,11 +3778,14 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
>  			     inode->i_ino, (unsigned long long)ee_block, ee_len,
>  			     (unsigned long long)map->m_lblk, map->m_len);
>  #endif
> -		err = ext4_split_convert_extents(handle, inode, map, ppath,
> -						 EXT4_GET_BLOCKS_CONVERT);
> -		if (err < 0)
> -			return err;
> -		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
> +		path = ext4_split_convert_extents(handle, inode, map, path,
> +						EXT4_GET_BLOCKS_CONVERT, NULL);
> +		if (IS_ERR(path)) {
> +			*ppath = NULL;
> +			return PTR_ERR(path);
> +		}
> +
> +		path = ext4_find_extent(inode, map->m_lblk, path, 0);
>  		if (IS_ERR(path)) {
>  			*ppath = NULL;
>  			return PTR_ERR(path);
> @@ -3845,11 +3842,14 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  		  (unsigned long long)ee_block, ee_len);
>  
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> -		err = ext4_split_convert_extents(handle, inode, map, ppath,
> -				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN);
> -		if (err < 0)
> -			return err;
> -		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
> +		path = ext4_split_convert_extents(handle, inode, map, path,
> +				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> +		if (IS_ERR(path)) {
> +			*ppath = NULL;
> +			return PTR_ERR(path);
> +		}
> +
> +		path = ext4_find_extent(inode, map->m_lblk, path, 0);
>  		if (IS_ERR(path)) {
>  			*ppath = NULL;
>  			return PTR_ERR(path);
> @@ -3915,19 +3915,20 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  
>  	/* get_block() before submitting IO, split the extent */
>  	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
> -		ret = ext4_split_convert_extents(handle, inode, map, ppath,
> -					 flags | EXT4_GET_BLOCKS_CONVERT);
> -		if (ret < 0) {
> -			err = ret;
> +		*ppath = ext4_split_convert_extents(handle, inode, map, *ppath,
> +				flags | EXT4_GET_BLOCKS_CONVERT, &allocated);
> +		if (IS_ERR(*ppath)) {
> +			err = PTR_ERR(*ppath);
> +			*ppath = NULL;
>  			goto out2;
>  		}
>  		/*
> -		 * shouldn't get a 0 return when splitting an extent unless
> +		 * shouldn't get a 0 allocated when splitting an extent unless
>  		 * m_len is 0 (bug) or extent has been corrupted
>  		 */
> -		if (unlikely(ret == 0)) {
> +		if (unlikely(allocated == 0)) {
>  			EXT4_ERROR_INODE(inode,
> -					 "unexpected ret == 0, m_len = %u",
> +					 "unexpected allocated == 0, m_len = %u",
>  					 map->m_len);
>  			err = -EFSCORRUPTED;
>  			goto out2;
> @@ -3988,9 +3989,9 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  		err = -EFSCORRUPTED;
>  		goto out2;
>  	}
> +	allocated = ret;
>  
>  out:
> -	allocated = ret;
>  	map->m_flags |= EXT4_MAP_NEW;
>  map_out:
>  	map->m_flags |= EXT4_MAP_MAPPED;
> -- 
> 2.39.2
> 

