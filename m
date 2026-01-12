Return-Path: <linux-ext4+bounces-12713-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA8BD11990
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jan 2026 10:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BF7630AB510
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jan 2026 09:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2F334A79D;
	Mon, 12 Jan 2026 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IHYjrP23"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE234A3B0;
	Mon, 12 Jan 2026 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210943; cv=none; b=rdp2H9P0lth5uWT1xT29+1bIPiU8aQatmWjFXBiKSAXWhPpPpNk4vUmf4EJ9GkY9hHWpzxmfgeKKW0/ue9gW2SJFhtiCWzp9heT0DxYXykTGZv8AUOzbQB0MW8RaUMeo9VsvUzerPzMXS53YQhKeC9JhAy0ajnrNGGYlOqsm90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210943; c=relaxed/simple;
	bh=as9QwHISbfsc9B8H7OSYTqpm6uLrlonF8xwEzXJRCNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmtOFcLywl6XVbppx5xC5vpzkjl2jmyCNKFy9C+p9CHKc6Dj7GHY5ZBerUqVSz7khdWDVgaYrqJrOnQ9M9Rbb7Xnomgn23YnPjsCd+Js0ddg8OHwJsoqTdBZRtvKK/wCvajxKCQ1EN/kZGz5vjmP8jsLnj2XdmcWjxVhf3mbbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IHYjrP23; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60C902La029019;
	Mon, 12 Jan 2026 09:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6ICrV+eItCTB5BZcPfFNyOEakQHbfM
	Wem7t+PQ7gBr0=; b=IHYjrP236iRoLkgSW7wizVFfhAGn9XEhAOxPKxivpc7E12
	U57EKOA/OyOMY67OPl+Qm9OfIbczjUUqrezc113c58MnAwzfF7vD4T/HTIs4mE2I
	shpfpgRxnNZ2HmVDPnDGWToADZxoAChlFAV9SgqXRu6MAZ2PzG00V9Cfa1o+Ndpw
	Uxow61XauaHtLAxVNuxXoJYnvQfQZWlp3IaHhIVAnTXp+iGhRAR5Fde2IQuyfTOD
	bcHcKvFyb4SP2I3UNEKH2Zvd+rlWWtOxupn/TUFWc16F4uC4J6TqA6vCkoHS21/O
	2CtA4ahjlfac/eKaFsBUxPiMZBr7AvKkDDctHDVg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsp43d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 09:42:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60C9g1O1016574;
	Mon, 12 Jan 2026 09:42:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsp43b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 09:42:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C9KrMp002511;
	Mon, 12 Jan 2026 09:42:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13sdbxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 09:42:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60C9fwSv61669718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 09:41:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89A8420040;
	Mon, 12 Jan 2026 09:41:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E24882004B;
	Mon, 12 Jan 2026 09:41:56 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Jan 2026 09:41:56 +0000 (GMT)
Date: Mon, 12 Jan 2026 15:11:54 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>,
        libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] ext4: Refactor split and convert extents
Message-ID: <aWTB4iF9urpWvRh9@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <8c318aa0eeb0c5c4ad0b5f620de3a7f4df596b82.1767528171.git.ojaswin@linux.ibm.com>
 <e93751dc-bc58-4808-b36c-40618b510d20@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93751dc-bc58-4808-b36c-40618b510d20@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA3MiBTYWx0ZWRfX1bZzMUY61Fg6
 HbXFF6b0VCCvA1ChhbKaBlm7ynsqRi5w7opu2OOgp/y5dU29NYRA3iP1TZHFYRAFxxj/m8GAxJt
 Kcabu1s5BNZzpzyJuNInI1SfXNg6gc6N5QEaiaWiDySXLtS0lhb1lQA+TRoFEL40Gd7wb/9OEhM
 na2KnfdHg1qsH5VIAPbpVM2pK8CNXG9X/YAiFNsPNiktP4M7uUN9yIWL0XtSKt1JUSDa9i3WnKN
 NiYP4Vc+7930YtGYXBcprZ8E/2xoh5Q89JFUiamhXVU4j5ic7W5VMHrjnLMSYat+2zHWlb74wOw
 BUrMcYrBkkFXJaHa1UV03e4W8KkpwISoWvld0/lVHgSIcJ8qYC4uACc5OkxilNgk1xxxwMPF3nW
 DR023tRICazQQxeWn7LJ6kJW2u0xIrudtK5frVoogj3nsEl2zKW+29PZGwDBxEMb9DxHAs5AyMe
 E5Sxb9b20xiV/U7tv4A==
X-Proofpoint-GUID: MmtgRCy1yCHTe88dt1VisZ_0XJWd5zuA
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6964c1e9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=6Vay1634Jt8UHRyxsy8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: s5VIECvfopuUe_Fotxwcxh1s7ed3dW11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120072

On Thu, Jan 08, 2026 at 08:34:51PM +0800, Zhang Yi wrote:
> On 1/4/2026 8:19 PM, Ojaswin Mujoo wrote:
> > ext4_split_convert_extents() has been historically prone to subtle
> > bugs and inconsistent behavior due to the way all the various flags
> > interact with the extent split and conversion process. For example,
> > callers like ext4_convert_unwritten_extents_endio() and
> > convert_initialized_extents() needed to open code extent conversion
> > despite passing CONVERT or CONVERT_UNWRITTEN flags because
> > ext4_split_convert_extents() wasn't performing the conversion.
> > 
> > Hence, refactor ext4_split_convert_extents() to clearly enforce the
> > semantics of each flag. The major changes here are:
> > 
> >  * Clearly separate the split and convert process:
> >    * ext4_split_extent() and ext4_split_extent_at() are now only
> >      responsible to perform the split.
> >    * ext4_split_convert_extents() is now responsible to perform extent
> >      conversion after calling ext4_split_extent() for splitting.
> >    * This helps get rid of all the MARK_UNWRIT* flags.
> > 
> >  * Clearly enforce the semantics of flags passed to
> >    ext4_split_convert_extents():
> > 
> >    * EXT4_GET_BLOCKS_CONVERT: Will convert the split extent to written
> >    * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Will convert the split extent to
> >      unwritten
> >    * Passing neither of the above means we only want a split.
> >    * Modify all callers to enforce the above semantics.
> > 
> >  * Use ext4_split_convert_extents() instead of ext4_split_extents()
> >  * in ext4_ext_convert_to_initialized() for uniformity.
> > 
> >  * Cleanup all callers open coding the conversion logic.
> >  * Further, modify kuniy tests to pass flags based on the new semantics.
> > 
> > From an end user point of view, we should not see any changes in
> > behavior of ext4.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Some comments below.
> 
> > ---
> >  fs/ext4/extents-test.c |  12 +-
> >  fs/ext4/extents.c      | 299 +++++++++++++++++++----------------------
> >  2 files changed, 145 insertions(+), 166 deletions(-)
> > 
> 
> [..]
> 
> > @@ -3820,6 +3786,26 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
> >  	return ERR_PTR(err);
> >  }
> >  
> > +static bool ext4_ext_needs_conv(struct inode *inode, struct ext4_ext_path *path,
> > +				int flags)
> > +{
> > +	struct ext4_extent *ex;
> > +	bool is_unwrit;
> > +	int depth;
> > +
> > +	depth = ext_depth(inode);
> > +	ex = path[depth].p_ext;
> > +	is_unwrit = ext4_ext_is_unwritten(ex);
> > +
> > +	if (is_unwrit && (flags & EXT4_GET_BLOCKS_CONVERT))
> > +		return true;
> > +
> > +	if (!is_unwrit && (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  /*
> >   * This function is called by ext4_ext_map_blocks() from
> >   * ext4_get_blocks_dio_write() when DIO to write
> > @@ -3856,7 +3842,9 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
> >  	ext4_lblk_t ee_block;
> >  	struct ext4_extent *ex;
> >  	unsigned int ee_len;
> > -	int split_flag = 0, depth;
> > +	int split_flag = 0, depth, err = 0;
> > +	bool did_zeroout = false;
> > +	bool needs_conv = ext4_ext_needs_conv(inode, path, flags);
> 
> As I described in Patch 05, there is currently no situation where
> splitting occurs without conversion, so I don't think we need this check.
> Is it right?
 
 Hey Yi,

Yes I can get rid of this.

> 
> >  
> >  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
> >  		  (unsigned long long)map->m_lblk, map->m_len);
> > @@ -3870,19 +3858,81 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
> >  	ee_block = le32_to_cpu(ex->ee_block);
> >  	ee_len = ext4_ext_get_actual_len(ex);
> >  
> > -	if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
> > -			    EXT4_GET_BLOCKS_CONVERT)) {
> > +	/* No split needed */
> > +	if (ee_block == map->m_lblk && ee_len == map->m_len)
> > +		goto convert;
> > +
> > +	/*
> > +	 * We don't use zeroout fallback for written to unwritten conversion as
> > +	 * it is not as critical as endio and it might take unusually long.
> > +	 * Also, it is only safe to convert extent to initialized via explicit
> > +	 * zeroout only if extent is fully inside i_size or new_size.
> > +	 */
> > +	if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
> > +		split_flag |= ee_block + ee_len <= eof_block ?
> > +				      EXT4_EXT_MAY_ZEROOUT :
> > +				      0;
> > +
> > +	/*
> > +	 * pass SPLIT_NOMERGE explicitly so we don't end up merging extents we
> > +	 * just split.
> > +	 */
> > +	path = ext4_split_extent(handle, inode, path, map, split_flag,
> > +				 flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE,
> > +				 allocated, &did_zeroout);
> > +
> > +convert:
> > +	/*
> > +	 * We don't need a conversion if:
> > +	 * 1. There was an error in split.
> > +	 * 2. We split via zeroout.
> > +	 * 3. None of the convert flags were passed.
> > +	 */
> > +	if (IS_ERR(path) || did_zeroout || !needs_conv)
> > +		return path;
> > +
> > +	path = ext4_find_extent(inode, map->m_lblk, path, flags);
> > +	if (IS_ERR(path))
> > +		return path;
> > +
> > +	depth = ext_depth(inode);
> > +	ex = path[depth].p_ext;
> > +
> > +	err = ext4_ext_get_access(handle, inode, path + depth);
> > +	if (err)
> > +		goto err;
> > +
> > +	if (flags & EXT4_GET_BLOCKS_CONVERT)
> > +		ext4_ext_mark_initialized(ex);
> > +	else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)
> > +		ext4_ext_mark_unwritten(ex);
> > +
> > +	if (!(flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
> >  		/*
> > -		 * It is safe to convert extent to initialized via explicit
> > -		 * zeroout only if extent is fully inside i_size or new_size.
> > +		 * note: ext4_ext_correct_indexes() isn't needed here because
> > +		 * borders are not changed
> >  		 */
> > -		split_flag |= ee_block + ee_len <= eof_block ?
> > -			      EXT4_EXT_MAY_ZEROOUT : 0;
> > -		split_flag |= EXT4_EXT_MARK_UNWRIT2;
> > +		ext4_ext_try_to_merge(handle, inode, path, ex);
> > +
> > +	err = ext4_ext_dirty(handle, inode, path + depth);
> > +	if (err)
> > +		goto err;
> > +
> > +	/* Lets update the extent status tree after conversion */
> > +	ext4_es_insert_extent(inode, le32_to_cpu(ex->ee_block),
> > +			      ext4_ext_get_actual_len(ex), ext4_ext_pblock(ex),
> > +			      ext4_ext_is_unwritten(ex) ?
> > +				      EXTENT_STATUS_UNWRITTEN :
> > +				      EXTENT_STATUS_WRITTEN,
> > +			      false);
> 
> I think the did_zeroout case also should update the extent status tree (and
> it should be better to be added in the previous patch). Otherwise, this
> would lead to residual stale unwritten extents in the zeroed range.
> 
> We should be careful about the extent status tree. I'd suggest that pay
> close attention to the following error output when running tests,
> 
>  EXT4-fs warning (device pmem2s): ext4_es_cache_extent:1079: inode #718: comm 108573.fsstress: ES cache extent failed: add [55,22,12260,0x1] conflict with existing [75,2,12280,0x2]

Yes I did see this line during testing earlier but caching it like above
fixed all the of em. Yes I did seem to miss caching for the zeroout
case. The thing is that as long as nocache is not passed we usually end
up caching it correctly in one of the ext4_find_extent() calls and I
guess that's why I might have missed it.

Also, I think I should also check for NOCACHE flag here before
caching it here right, since many caller pass the NOCACHE flag.

I've also added es_cache support to kunit tests so hopefully we will
catch any issues there. Will add these changes in v2.

Regards,
ojaswin

> 
> or directly add a WARN_ON_ONCE(1) at the end of ext4_es_cache_extent().
> There may be other problems related to the stale extents that could
> arise.
> 
> Thanks,
> Yi.
> 
> > +
> > +err:
> > +	if (err) {
> > +		ext4_free_ext_path(path);
> > +		return ERR_PTR(err);
> >  	}
> > -	flags |= EXT4_GET_BLOCKS_SPLIT_NOMERGE;
> > -	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
> > -				 allocated);
> > +
> > +	return path;
> >  }
> >  
> >  static struct ext4_ext_path *
> > @@ -3894,7 +3944,6 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
> >  	ext4_lblk_t ee_block;
> >  	unsigned int ee_len;
> >  	int depth;
> > -	int err = 0;
> >  
> >  	depth = ext_depth(inode);
> >  	ex = path[depth].p_ext;
> > @@ -3904,41 +3953,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
> >  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
> >  		  (unsigned long long)ee_block, ee_len);
> >  
> > -	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> > -		path = ext4_split_convert_extents(handle, inode, map, path,
> > -						  flags, NULL);
> > -		if (IS_ERR(path))
> > -			return path;
> > -
> > -		path = ext4_find_extent(inode, map->m_lblk, path, 0);
> > -		if (IS_ERR(path))
> > -			return path;
> > -		depth = ext_depth(inode);
> > -		ex = path[depth].p_ext;
> > -	}
> > -
> > -	err = ext4_ext_get_access(handle, inode, path + depth);
> > -	if (err)
> > -		goto errout;
> > -	/* first mark the extent as initialized */
> > -	ext4_ext_mark_initialized(ex);
> > -
> > -	/* note: ext4_ext_correct_indexes() isn't needed here because
> > -	 * borders are not changed
> > -	 */
> > -	ext4_ext_try_to_merge(handle, inode, path, ex);
> > -
> > -	/* Mark modified extent as dirty */
> > -	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> > -	if (err)
> > -		goto errout;
> > -
> > -	ext4_ext_show_leaf(inode, path);
> > -	return path;
> > -
> > -errout:
> > -	ext4_free_ext_path(path);
> > -	return ERR_PTR(err);
> > +	return ext4_split_convert_extents(handle, inode, map, path, flags,
> > +					  NULL);
> >  }
> >  
> >  static struct ext4_ext_path *
> > @@ -3952,7 +3968,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
> >  	ext4_lblk_t ee_block;
> >  	unsigned int ee_len;
> >  	int depth;
> > -	int err = 0;
> >  
> >  	/*
> >  	 * Make sure that the extent is no bigger than we support with
> > @@ -3969,40 +3984,12 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
> >  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
> >  		  (unsigned long long)ee_block, ee_len);
> >  
> > -	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> > -		path = ext4_split_convert_extents(handle, inode, map, path,
> > -				flags | EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> > -		if (IS_ERR(path))
> > -			return path;
> > -
> > -		path = ext4_find_extent(inode, map->m_lblk, path, 0);
> > -		if (IS_ERR(path))
> > -			return path;
> > -		depth = ext_depth(inode);
> > -		ex = path[depth].p_ext;
> > -		if (!ex) {
> > -			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
> > -					 (unsigned long) map->m_lblk);
> > -			err = -EFSCORRUPTED;
> > -			goto errout;
> > -		}
> > -	}
> > -
> > -	err = ext4_ext_get_access(handle, inode, path + depth);
> > -	if (err)
> > -		goto errout;
> > -	/* first mark the extent as unwritten */
> > -	ext4_ext_mark_unwritten(ex);
> > -
> > -	/* note: ext4_ext_correct_indexes() isn't needed here because
> > -	 * borders are not changed
> > -	 */
> > -	ext4_ext_try_to_merge(handle, inode, path, ex);
> > +	path = ext4_split_convert_extents(
> > +		handle, inode, map, path,
> > +		flags | EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> > +	if (IS_ERR(path))
> > +		return path;
> >  
> > -	/* Mark modified extent as dirty */
> > -	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> > -	if (err)
> > -		goto errout;
> >  	ext4_ext_show_leaf(inode, path);
> >  
> >  	ext4_update_inode_fsync_trans(handle, inode, 1);
> > @@ -4012,10 +3999,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
> >  		*allocated = map->m_len;
> >  	map->m_len = *allocated;
> >  	return path;
> > -
> > -errout:
> > -	ext4_free_ext_path(path);
> > -	return ERR_PTR(err);
> >  }
> >  
> >  static struct ext4_ext_path *
> > @@ -5649,7 +5632,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
> >  	struct ext4_extent *extent;
> >  	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
> >  	unsigned int credits, ee_len;
> > -	int ret, depth, split_flag = 0;
> > +	int ret, depth;
> >  	loff_t start;
> >  
> >  	trace_ext4_insert_range(inode, offset, len);
> > @@ -5720,12 +5703,8 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
> >  		 */
> >  		if ((start_lblk > ee_start_lblk) &&
> >  				(start_lblk < (ee_start_lblk + ee_len))) {
> > -			if (ext4_ext_is_unwritten(extent))
> > -				split_flag = EXT4_EXT_MARK_UNWRIT1 |
> > -					EXT4_EXT_MARK_UNWRIT2;
> >  			path = ext4_split_extent_at(handle, inode, path,
> > -					start_lblk, split_flag,
> > -					EXT4_EX_NOCACHE |
> > +					start_lblk, EXT4_EX_NOCACHE |
> >  					EXT4_GET_BLOCKS_SPLIT_NOMERGE |
> >  					EXT4_GET_BLOCKS_METADATA_NOFAIL);
> >  		}
> 

