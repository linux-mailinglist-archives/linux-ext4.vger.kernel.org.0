Return-Path: <linux-ext4+bounces-5802-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3279F8D1E
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 08:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B520C188981B
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A305617C9E8;
	Fri, 20 Dec 2024 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KFskQ5hQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169D7083F
	for <linux-ext4@vger.kernel.org>; Fri, 20 Dec 2024 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679060; cv=none; b=u8UcMVeU17hZ9pu2Bp66MIPtMZQt1VxqLeMTnWaEiqVn+cGmPB2pV9VbI7VByNOaJ+jHlSpeptpIEbsWSg7t3NEexMfwnNvqWRct2PE0QYWZpAyT+k/kbM71XOGVE+FZKqZdWV7NrvGQNOk9Cf4EDTymV8pITi6hPcaC6IKSZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679060; c=relaxed/simple;
	bh=wqRzq88N5lbSzz/jKrwSNL/sEDPyaXCQbyLVscJR/aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lecKX0r2ZJNYWofPjTKoj9H4CHpKhpFTYY5UagLYzPuZxu4x68ejyr0rEB6h9KEHazdjCIh7gw4W3SIborCVjznfZNNqPbuEjvokYwFcaEyF6xHRztx+5X/OZbtaq0eEssNBY2uVS8wTJMK0exPFzrSH7IPLN448qq1kbZj+x0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KFskQ5hQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJMafLK026753;
	Fri, 20 Dec 2024 07:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rrR+pHv7hHj4vUyKHEdosPurWE0H8J
	SA3jl0tngMNx4=; b=KFskQ5hQLzuGQVbCv5faYZze5AFIUmBkowPLN76pKGNJZD
	rdKm3Vu5BjXjTAz0tZKInW0jn+YlZqtE8Tho/u1hYqfndC+OHF6B9qrm8RuKqWVH
	joo3BLlo/kThphU0j5XUwvoEpi+7mS0T/m0fkgI7+bLc+y5d3JCjZnTyXVFh1Edm
	t7dSssmpiuQw2K6fwB2QfsaS4SHARI8N7YlThPwpZQjCKs7KTnXLKvTR4/NXEbP6
	baL5J3ZHFwlALgRc0xbxyqeKA8eZAdU9HvmyEdQkeXKPKnDIa8dK9yj3e1GGBr1j
	Cx0ARYbb60mX08um7MU0ipBamgEZCncK+IiP8ZvQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mmy5bx6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 07:17:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BK78ZhP014582;
	Fri, 20 Dec 2024 07:17:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mmy5bx6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 07:17:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK3h0rl029728;
	Fri, 20 Dec 2024 07:17:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbt19g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 07:17:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BK7HQBY61145438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 07:17:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E55A62004D;
	Fri, 20 Dec 2024 07:17:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A10FC20043;
	Fri, 20 Dec 2024 07:17:24 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.39.23.234])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Dec 2024 07:17:24 +0000 (GMT)
Date: Fri, 20 Dec 2024 12:47:22 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Sarthak Kukreti <sarthakkukreti@google.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH v2] fallocate: Add support for fixed goal extent
 allocations
Message-ID: <Z2UaAn6IS5uh5plH@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241220034613.3624898-1-sarthakkukreti@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220034613.3624898-1-sarthakkukreti@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WbbbFhVIdlnj0bY7qh2s6NTjsNTXjJVi
X-Proofpoint-GUID: dZLoRyLSHsmKNc_HpqTCMaRvfihS02h-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200057

On Thu, Dec 19, 2024 at 07:46:13PM -0800, Sarthak Kukreti wrote:
> Add a new flag to add support for fixed goal allocations in
> ext_falloc_helper. For fixed goal allocations, omit merging extents and
> return an error unless the exact extent is found.
> 
> Use case:
> On ChromiumOS, we'd like to add the capability of resetting a filesystem
> while preserving a set of files in-place. This will be used during
> filesystem reset flows where everything apart from select files (which
> contain system applications) should be removed: the combined size of the
> files can exceed the amount of available space in other
> partitions/memory. The reset process will look something like:
> 
> 1. Reset code dumps the FIEMAP of the set of preserved files into a
> file.
> 2. Mkfs.ext4 is called on the filesystem with -E nodiscard.
> 3. Post mkfs, the reset code will utilize ext2fs_fallocate w/
> EXT2_FALLOCATE_FIXED_GOAL | EXT2_FALLOCATE_FORCE_INIT on the extent list
> created in step 1.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
> 
> Changes from v1 (https://lists.openwall.net/linux-ext4/2024/12/12/38):
> - s/EXT2_NEWRANGE_EXACT_GOAL/EXT2_NEWRANGE_FIXED_GOAL

Looks good Sarthak, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> 
> ---
>  lib/ext2fs/alloc.c     |  2 +-
>  lib/ext2fs/ext2fs.h    |  3 ++-
>  lib/ext2fs/fallocate.c | 21 +++++++++++++++++++--
>  3 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/ext2fs/alloc.c b/lib/ext2fs/alloc.c
> index 3fd92167..ba5b1c5e 100644
> --- a/lib/ext2fs/alloc.c
> +++ b/lib/ext2fs/alloc.c
> @@ -390,7 +390,7 @@ no_blocks:
>  /*
>   * Starting at _goal_, scan around the filesystem to find a run of free blocks
>   * that's at least _len_ blocks long.  Possible flags:
> - * - EXT2_NEWRANGE_EXACT_GOAL: The range of blocks must start at _goal_.
> + * - EXT2_NEWRANGE_FIXED_GOAL: The range of blocks must start at _goal_.
>   * - EXT2_NEWRANGE_MIN_LENGTH: do not return a allocation shorter than _len_.
>   * - EXT2_NEWRANGE_ZERO_BLOCKS: Zero blocks pblk to pblk+plen before returning.
>   *
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 6e87829f..313c5981 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -1446,7 +1446,8 @@ extern errcode_t ext2fs_decode_extent(struct ext2fs_extent *to, void *from,
>  #define EXT2_FALLOCATE_FORCE_INIT	(0x2)
>  #define EXT2_FALLOCATE_FORCE_UNINIT	(0x4)
>  #define EXT2_FALLOCATE_INIT_BEYOND_EOF	(0x8)
> -#define EXT2_FALLOCATE_ALL_FLAGS	(0xF)
> +#define EXT2_FALLOCATE_FIXED_GOAL	(0x10)
> +#define EXT2_FALLOCATE_ALL_FLAGS	(0x1F)
>  errcode_t ext2fs_fallocate(ext2_filsys fs, int flags, ext2_ino_t ino,
>  			   struct ext2_inode *inode, blk64_t goal,
>  			   blk64_t start, blk64_t len);
> diff --git a/lib/ext2fs/fallocate.c b/lib/ext2fs/fallocate.c
> index 5cde7d5c..20aa9c9f 100644
> --- a/lib/ext2fs/fallocate.c
> +++ b/lib/ext2fs/fallocate.c
> @@ -103,7 +103,7 @@ static errcode_t ext_falloc_helper(ext2_filsys fs,
>  				   blk64_t alloc_goal)
>  {
>  	struct ext2fs_extent	newex, ex;
> -	int			op;
> +	int			op, new_range_flags = 0;
>  	blk64_t			fillable, pblk, plen, x, y;
>  	blk64_t			eof_blk = 0, cluster_fill = 0;
>  	errcode_t		err;
> @@ -132,6 +132,9 @@ static errcode_t ext_falloc_helper(ext2_filsys fs,
>  	max_uninit_len = EXT_UNINIT_MAX_LEN & ~EXT2FS_CLUSTER_MASK(fs);
>  	max_init_len = EXT_INIT_MAX_LEN & ~EXT2FS_CLUSTER_MASK(fs);
>  
> +	if (flags & EXT2_FALLOCATE_FIXED_GOAL)
> +		goto no_implied;
> +
>  	/* We must lengthen the left extent to the end of the cluster */
>  	if (left_ext && EXT2FS_CLUSTER_RATIO(fs) > 1) {
>  		/* How many more blocks can be attached to left_ext? */
> @@ -605,12 +608,15 @@ no_implied:
>  		max_extent_len = max_uninit_len;
>  		newex.e_flags = EXT2_EXTENT_FLAGS_UNINIT;
>  	}
> +
> +	if (flags & EXT2_FALLOCATE_FIXED_GOAL)
> +		new_range_flags = EXT2_NEWRANGE_FIXED_GOAL | EXT2_NEWRANGE_MIN_LENGTH;
>  	pblk = alloc_goal;
>  	y = range_len;
>  	for (x = 0; x < y;) {
>  		cluster_fill = newex.e_lblk & EXT2FS_CLUSTER_MASK(fs);
>  		fillable = min(range_len + cluster_fill, max_extent_len);
> -		err = ext2fs_new_range(fs, 0, pblk & ~EXT2FS_CLUSTER_MASK(fs),
> +		err = ext2fs_new_range(fs, new_range_flags, pblk & ~EXT2FS_CLUSTER_MASK(fs),
>  				       fillable,
>  				       NULL, &pblk, &plen);
>  		if (err)
> @@ -681,6 +687,16 @@ static errcode_t extent_fallocate(ext2_filsys fs, int flags, ext2_ino_t ino,
>  	if (err)
>  		return err;
>  
> +	/*
> +	 * For fixed goal allocations, let the allocations fail iff we can't
> +	 * find the exact goal extent.
> +	 */
> +	if (flags & EXT2_FALLOCATE_FIXED_GOAL) {
> +		err = ext_falloc_helper(fs, flags, ino, inode, handle, NULL,
> +					NULL, start, len, goal);
> +		goto errout;
> +	}
> +
>  	/*
>  	 * Find the extent closest to the start of the alloc range.  We don't
>  	 * check the return value because _goto() sets the current node to the
> @@ -796,6 +812,7 @@ errout:
>   * - EXT2_FALLOCATE_FORCE_INIT: Create only initialized extents.
>   * - EXT2_FALLOCATE_FORCE_UNINIT: Create only uninitialized extents.
>   * - EXT2_FALLOCATE_INIT_BEYOND_EOF: Create extents beyond EOF.
> + * - EXT2_FALLOCATE_FIXED_GOAL: Ensure range starts at goal.
>   *
>   * If neither FORCE_INIT nor FORCE_UNINIT are specified, this function will
>   * try to expand any extents it finds, zeroing blocks as necessary.
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

