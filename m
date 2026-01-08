Return-Path: <linux-ext4+bounces-12644-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6021D036BB
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 15:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA9A324D8A4
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2648C3D2FFE;
	Thu,  8 Jan 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GKHCC6kg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAADE3A89B1;
	Thu,  8 Jan 2026 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881375; cv=none; b=OfpFsdQmKLTKdYWggc6+q++++AkPwwofmjLMK0F9c6a9FWx4wTZUDZAL90Gn2jeMT7dpxo0qdi/nNKhS2e43zWSWzTEjbBXK9Z/Qzm0roMQ6CrsdbSfg4CvmzsVG7LcLVRmznMvMxRC8E49qSNuZFBlqO8HMJGH/oRj25mUMKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881375; c=relaxed/simple;
	bh=WL4+L2q9CQ3GHlb/PK4m1fROeWg4NXFAxBLPiB28MvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1Gx9PmS8cFYKE5pfab3R2NUaO5bXt30U+bspWB4rDyHcvtlc21J+AeBVHRiGF9EPoB4vfY9Upk/ungdiCaIrgFsiKW67CEA5R4HzZXTbHafxHA4+FCqqNXfwXeoLk2wtxSkoHzDTWWM0usydMGdqODJ6BH/cH7w2FIlU1QWPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GKHCC6kg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 608Avw03017255;
	Thu, 8 Jan 2026 14:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CjIzYfF08f9OHnYCD3q/6FRhXtMNBY
	NfiISR9aCUfiA=; b=GKHCC6kgp2N+yywungO+zTVS2LrJTMO2r7YRkEVIxXkpch
	HoCfsLulmRjRUlXyC2ETB+DWJcSI9MnHwfvEp7Mbwa8gBLanSNnp7EUSsRolRsIV
	A1/2PiuFaclr5HrH5LBOYk4fE8GDx8UJQnVFdNOuIkIWScxc8VDP8vQr7XA2DNe9
	rRhmyyFcr/v+9wEqJO0xj79/5w9YchTkuBwV5xuS+d4aW8lNirVnoX9ZIu+xwCST
	VMT7Pf3uNKVVZgMyCXRFcVaiE51ZK3XjebGy89rPt8CsjyDEKERBQSW6BfZbJ5LY
	pjmUgFdjgGagpuS5jNJzrUN/Phg8gf6RZP90EdlQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6ej2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 14:09:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 608E9Cfw022182;
	Thu, 8 Jan 2026 14:09:12 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6ej2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 14:09:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 608E57ph019154;
	Thu, 8 Jan 2026 14:09:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg51evyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 14:09:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 608E99ga61538606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Jan 2026 14:09:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9360520040;
	Thu,  8 Jan 2026 14:09:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C321320043;
	Thu,  8 Jan 2026 14:09:07 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.198])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Jan 2026 14:09:07 +0000 (GMT)
Date: Thu, 8 Jan 2026 19:38:29 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>,
        libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] ext4: Refactor zeroout path and handle all cases
Message-ID: <aV-6Xa56iQaH5ltX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <1ecffaf1edd7a37d90a7fcc8808b9b6e4e7a1245.1767528171.git.ojaswin@linux.ibm.com>
 <c715795a-12d7-4d52-9f44-a7abe4b9cc56@huaweicloud.com>
 <aV-mJci2dxojEFMY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <ae308d42-fd15-45e6-9cf8-fb3c8f3d0671@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae308d42-fd15-45e6-9cf8-fb3c8f3d0671@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695fba88 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=1jZnAn1vlJ8UClaysvAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: G-MHgB9bPYKovzQfw7VT4ueXX3W52YPB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA5OCBTYWx0ZWRfX5Hm73GN/YznF
 V4HkKYCNE4A/P13Dz2B0TWFjkrykqN9aDIJEPg0OKLUhR/4WPHVwUosHysEFvef/EJ/Bfvs9fOD
 sR/3RUjxSvunfeFUFI6pePIvEnV1ecGgaxqa5p4gWjbG9Ns3MwM0XBQC2ma9c0WRM0bRsZvEybL
 6DgPKyTo6fppJMkkItZkg4sWVTqeKvfAoEgHwUZRVyox3y1PKcNu/8m+ECo05DNM0p/O+5Y06TC
 TzwR4dRp2yWab+2B8J7FPmYozqhwdVVuleteYAN8DxyeLGGBbryoD+wG5SZGEtA5NkplDbpLeMO
 6/60oPUsWTel54xoh995wmF4I7XAW1qfzlDCw08FxfI7zdURjGbUNc7mNYn5Ug4+tGr46ploczd
 ZPYIi3eVDpNe24P7ntn91VqlczAyZPF1I2aiorPvD656kMlWCH6HfApsBwiJtvNG1o/kCv9ap1w
 6xIr9u9oHvY35hVQjUQ==
X-Proofpoint-GUID: mSX0mmdeOlgCIu4D9WvWQfziKJt548h3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601080098

On Thu, Jan 08, 2026 at 08:54:04PM +0800, Zhang Yi wrote:
> On 1/8/2026 8:42 PM, Ojaswin Mujoo wrote:
> > On Thu, Jan 08, 2026 at 07:58:21PM +0800, Zhang Yi wrote:
> >> On 1/4/2026 8:19 PM, Ojaswin Mujoo wrote:
> >>> Currently, zeroout is used as a fallback in case we fail to
> >>> split/convert extents in the "traditional" modify-the-extent-tree way.
> >>> This is essential to mitigate failures in critical paths like extent
> >>> splitting during endio. However, the logic is very messy and not easy to
> >>> follow. Further, the fragile use of various flags has made it prone to
> >>> errors.
> >>>
> >>> Refactor zeroout out logic by moving it up to ext4_split_extents().
> >>> Further, zeroout correctly based on the type of conversion we want, ie:
> >>> - unwritten to written: Zeroout everything around the mapped range.
> >>> - unwritten to unwritten: Zeroout everything
> >>> - written to unwritten: Zeroout only the mapped range.
> >>>
> >>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >>
> >> Hi, Ojaswin!
> >>
> >> The refactor overall looks good to me. After this series, the split
> >> logic becomes more straightforward and clear. :)
> >>
> >> I have some comments below.
> >>
> >>> ---
> >>>  fs/ext4/extents.c | 287 +++++++++++++++++++++++++++++++---------------
> >>>  1 file changed, 195 insertions(+), 92 deletions(-)
> >>>
> >>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> >>> index 460a70e6dae0..8082e1d93bbf 100644
> >>> --- a/fs/ext4/extents.c
> >>> +++ b/fs/ext4/extents.c
> >>
> >> [...]
> >>
> >>> @@ -3365,6 +3313,115 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
> >>>  	return path;
> >>>  }
> >>>  
> >>> +static struct ext4_ext_path *
> >>> +ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
> >>> +			  struct ext4_ext_path *path,
> >>> +			  struct ext4_map_blocks *map, int flags)
> >>> +{
> >>> +	struct ext4_extent *ex;
> >>> +	unsigned int ee_len, depth;
> >>> +	ext4_lblk_t ee_block;
> >>> +	uint64_t lblk, pblk, len;
> >>> +	int is_unwrit;
> >>> +	int err = 0;
> >>> +
> >>> +	depth = ext_depth(inode);
> >>> +	ex = path[depth].p_ext;
> >>> +	ee_block = le32_to_cpu(ex->ee_block);
> >>> +	ee_len = ext4_ext_get_actual_len(ex);
> >>> +	is_unwrit = ext4_ext_is_unwritten(ex);
> >>> +
> >>> +	if (flags & EXT4_GET_BLOCKS_CONVERT) {
> >>> +		/*
> >>> +		 * EXT4_GET_BLOCKS_CONVERT: Caller wants the range specified by
> >>> +		 * map to be initialized. Zeroout everything except the map
> >>> +		 * range.
> >>> +		 */
> >>> +
> >>> +		loff_t map_end = (loff_t) map->m_lblk + map->m_len;
> >>> +		loff_t ex_end = (loff_t) ee_block + ee_len;
> >>> +
> >>> +		if (!is_unwrit)
> >>> +			/* Shouldn't happen. Just exit */
> >>> +			return ERR_PTR(-EINVAL);
> >>
> >> For cases that are should not happen, I'd suggest adding a WARN_ON_ONCE or
> >> a message to facilitate future problem identification. Same as below.
> > 
> > Hi Yi,
> > 
> > Thanks for the review! Sure I can do that in v2.
> >>
> >>> +
> >>> +		/* zeroout left */
> >>> +		if (map->m_lblk > ee_block) {
> >>> +			lblk = ee_block;
> >>> +			len = map->m_lblk - ee_block;
> >>> +			pblk = ext4_ext_pblock(ex);
> >>> +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
> >>> +			if (err)
> >>> +				/* ZEROOUT failed, just return original error */
> >>> +				return ERR_PTR(err);
> >>> +		}
> >>> +
> >>> +		/* zeroout right */
> >>> +		if (map->m_lblk + map->m_len < ee_block + ee_len) {
> >>> +			lblk = map_end;
> >>> +			len = ex_end - map_end;
> >>> +			pblk = ext4_ext_pblock(ex) + (map_end - ee_block);
> >>> +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
> >>> +			if (err)
> >>> +				/* ZEROOUT failed, just return original error */
> >>> +				return ERR_PTR(err);
> >>> +		}
> >>> +	} else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
> >>> +		/*
> >>> +		 * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Caller wants the
> >>> +		 * range specified by map to be marked unwritten.
> >>> +		 * Zeroout the map range leaving rest as it is.
> >>> +		 */
> >>> +
> >>> +		if (is_unwrit)
> >>> +			/* Shouldn't happen. Just exit */
> >>> +			return ERR_PTR(-EINVAL);
> >>> +
> >>> +		lblk = map->m_lblk;
> >>> +		len = map->m_len;
> >>> +		pblk = ext4_ext_pblock(ex) + (map->m_lblk - ee_block);
> >>> +		err = ext4_issue_zeroout(inode, lblk, pblk, len);
> >>> +		if (err)
> >>> +			/* ZEROOUT failed, just return original error */
> >>> +			return ERR_PTR(err);
> >>> +	} else if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) {
> >>> +		/*
> >>> +		 * EXT4_GET_BLOCKS_UNWRIT_EXT: Today, this flag
> >>> +		 * implicitly implies that callers when wanting an
> >>> +		 * unwritten to unwritten split. So zeroout the whole
> >>> +		 * extent.
> >>> +		 *
> >>> +		 * TODO: The implicit meaning of the flag is not ideal
> >>> +		 * and eventually we should aim for a more well defined
> >>> +		 * behavior
> >>> +		 */
> >>> +
> >>
> >> I don't think we need this branch anymore. After applying my patch "ext4:
> >> don't split extent before submitting I/O", we will no longer encounter
> >> situations where doing an unwritten to unwritten split. It means that at
> >> all call sites of ext4_split_extent(), only EXT4_GET_BLOCKS_CONVERT or
> >> EXT4_GET_BLOCKS_CONVERT_UNWRITTEN flags are passed. What do you think?
> > 
> > Yes, I did notice that as well after rebasing on your changes. 
> > 
> > So the next patch enforces the behavior that if no flag is passed to
> > ext4_split_extent() -> ext4_split_extent_zeroout() then we assume a
> > split without conversion. As you mentioned, there is no remaining caller
> > that does this but I thought of handling it here so that in future if we
> > ever need to use unwrit to unwrit splits we handle it correctly.
> > 
> > Incase you still feel this makes it confusing or is uneccessary I can
> > remove the else part altoghether and add a WARN_ON.
> > 
> 
> Yes, my personal suggestion is to add this part of the logic only when it
> is really needed. :)

Okay sounds good, will take this out in v2.

Regards,
ojaswin

> 
> Cheers,
> Yi.
> 
> > Thanks,
> > ojaswin
> > 
> >>
> >> Thanks,
> >> Yi.
> >>
> >>> +		if (!is_unwrit)
> >>> +			/* Shouldn't happen. Just exit */
> >>> +			return ERR_PTR(-EINVAL);
> >>> +
> >>> +		lblk = ee_block;
> >>> +		len = ee_len;
> >>> +		pblk = ext4_ext_pblock(ex);
> >>> +		err = ext4_issue_zeroout(inode, lblk, pblk, len);
> >>> +		if (err)
> >>> +			/* ZEROOUT failed, just return original error */
> >>> +			return ERR_PTR(err);
> >>> +	}
> >>> +
> >>> +	err = ext4_ext_get_access(handle, inode, path + depth);
> >>> +	if (err)
> >>> +		return ERR_PTR(err);
> >>> +
> >>> +	ext4_ext_mark_initialized(ex);
> >>> +
> >>> +	ext4_ext_dirty(handle, inode, path + path->p_depth);
> >>> +	if (err)
> >>> +		return ERR_PTR(err);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  /*
> >>>   * ext4_split_extent() splits an extent and mark extent which is covered
> >>>   * by @map as split_flags indicates
> >>
> >> [...]
> >>
> 

