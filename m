Return-Path: <linux-ext4+bounces-5648-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCE59F2565
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Dec 2024 19:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90648188556D
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Dec 2024 18:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB571B6D17;
	Sun, 15 Dec 2024 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OSocn57R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA8C154BEA
	for <linux-ext4@vger.kernel.org>; Sun, 15 Dec 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287947; cv=none; b=SPeUsuslVUUz7lOU4s9ryGkvWUQaA1oqv+0YA62mjIuEtSu8x8konGMto3+e7vHDU9Z8GlMSWj8IV3H957l5AW7jZS128s50i00qyIYn5xDQJgEKauTBrl0vNzaCBvH5qqj1DoFiFHUlpJbhP07HNbYOpnrnQUhSgV8ByHeWLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287947; c=relaxed/simple;
	bh=h5YEltNl0Pbv73b2rTpmkqCtEkjvD6IrAskFOUKG03k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/b2p6Us0Qw05Sv0X289JI8oz7gQo7qQ+QmAG1qBnWHUsL3Ru1J7K9gOGY7oTrQAMERknaw49LcsSWvAbAJhdGButU8/dQQ8PzL9DcKvEJIivCvW5WiOm4ctnIoA7OCHw1oAu5uWpyUZdzOTEsJQbTht1R9PaTdhOiv5jlyo97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OSocn57R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFEkq4i008829;
	Sun, 15 Dec 2024 18:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rZoccqN8qdsadL29VYj3rW/fI9qUGX
	3WZNDMGJzGYYg=; b=OSocn57Rw5dQvbJedbtjVvR82ik5JjoBu7i2RuM+AiepHn
	7GzHTcjctyJSgWO6AG5gTgbLGAkbCi8XhnyUnoJfK8Fl0W1R8a2akoxe/wHySTAq
	UImJgrQDqnMC0TpILo7ILjmHrfX9QOeoWzp0Wz9uMSoR2ytcOQWy5ciRmt1QB0m3
	1Sb3voVKcU1yNscI27Ccexpm3zd9lGtiWOqj2XWcTMpK15ffcpKSkpvOsLIAvHIb
	aLV26nYVwYkbX5En9FwH6aD6+D329iEsmsUTi7oWKMJbJEuZoI75hMk6CejRS0Up
	paGdkCFzM96srCHa/CK8CQ/+S9IRCMjyHCIDUPAA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43hqkb257m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 18:39:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BFId1Yk005567;
	Sun, 15 Dec 2024 18:39:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43hqkb257j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 18:39:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFEpTLs014391;
	Sun, 15 Dec 2024 18:39:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21acsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 18:39:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BFIcx9d48759160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Dec 2024 18:38:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57E232004B;
	Sun, 15 Dec 2024 18:38:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64AE320040;
	Sun, 15 Dec 2024 18:38:58 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.39.17.208])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 15 Dec 2024 18:38:58 +0000 (GMT)
Date: Mon, 16 Dec 2024 00:08:55 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Sarthak Kukreti <sarthakkukreti@google.com>
Cc: linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fallocate: Add support for fixed goal extent allocations
Message-ID: <Z18iP6I56m3SeJVr@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241212224958.62905-1-sarthakkukreti@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212224958.62905-1-sarthakkukreti@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nOfZrKyuwZeLVzPb3DyOzmzHF8Ou4KCm
X-Proofpoint-ORIG-GUID: LAIu4AMgNBK3FZqvSCgJv20Ft1rAAiNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412150160

On Thu, Dec 12, 2024 at 02:49:58PM -0800, Sarthak Kukreti wrote:
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

Hey Sarthak,

On the e2fsprogs side, the change looks straight forward enough and
irrespective of the use case having FIXED GOAL for fallocate makes sense
to me. While you are at it, I would just request you to fix the comment
above ext2fs_new_range():

 /*
  * Starting at _goal_, scan around the filesystem to find a run of free blocks
  * that's at least _len_ blocks long.  Possible flags:
- * - EXT2_NEWRANGE_EXACT_GOAL: The range of blocks must start at _goal_.
+ * - EXT2_NEWRANGE_FIXED_GOAL: The range of blocks must start at _goal_.
  * - EXT2_NEWRANGE_MIN_LENGTH: do not return a allocation shorter than _len_.
  * - EXT2_NEWRANGE_ZERO_BLOCKS: Zero blocks pblk to pblk+plen before returning.

That being said, the usecase seems interesting to me and I have a few
questions about it:

 1. So if i understand correctly, after mkfs your tool will essentially
    handcraft the FS by using lib/ext2fs helpers to fallocate the exact
    physical blocks where your files are supposed to be on disk. I believe
    you'd also need to recreate inodes/xattrs etc for the files to make sure
    they are identical after mkfs?

 2. I'm assuming you don't expect the underlying storage medium to change
    across this reset and hence using the same physical block works?

 3. I wonder if there are any other ways of doing this without having to
    handcraft the FS in this way. It just seems a bit fragile.

Regards,
ojaswin

> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
> ---
>  lib/ext2fs/ext2fs.h    |  3 ++-
>  lib/ext2fs/fallocate.c | 21 +++++++++++++++++++--
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
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
> 2.47.0.rc1.288.g06298d1525-goog

