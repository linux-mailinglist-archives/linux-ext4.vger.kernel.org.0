Return-Path: <linux-ext4+bounces-12641-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59299D02F44
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 14:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80AD5320520C
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961F466627;
	Thu,  8 Jan 2026 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JRRNJtwn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272E466225;
	Thu,  8 Jan 2026 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876203; cv=none; b=MS6zsVSozMdrCzX8vLsft3hkJOdd79iH7yEv9CnRPwEIMftObtrE1jkbeNCOl35jkoz9trIaivLJaPVG80/x3lmic+94R/Dv5V4SyFlHDXmpDt7EnrD1Aw13XsWp2tbbiSzlJraD1WnJo7G9utj/3gkjz9f750Lo1flByvEY5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876203; c=relaxed/simple;
	bh=RcLOfPLgrikgP3bVZiwLdcuSkjVzmN77DGPW9to7pYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLeEWoAPFGxiG0BPHv7dA/hrxQRC49YyxzHsyGHq2r/39T+lZ0uE2KSU/E83jKjHEZmhTnPTr9p1tpb84ovMgkhLVhwKT2xmkG+CqEiT3opCaZ9ikJ8NlsVTBrwpCkI+xP2FCwu23WXkmP+Kq7g1CtQm3y/m/PmywGkMeZyTA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JRRNJtwn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6089kK8b030679;
	Thu, 8 Jan 2026 12:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=St89B/oL7GshH2X6ujHv3bAJEs71Uw
	0IzbGGg+Qg7Ic=; b=JRRNJtwntdSNeU4cyfvNOqraca/bezNxBQs125GXxxZiOt
	ld7MGeYehkl574PeNt4EbgBkZfRknxxFbAdk9nShGx3oOt56aeLKutmjjn/YrSUA
	z3TlsU4NsQwCDjdlaDuKvm8cuGPlRIFD3wOJwgK2EfaM77ns01tqld/uQWkJqfIT
	708vGB2DKxJORngBAAH34DUijnefYX3Z4CodQYG9g40je48D0cbvG7biX0vF80LU
	T7h1PTvr+tCFquIya+7HUdpmiIJmSgCKQnyd/E4jaELW9CClzzPR8Wy2idL8VIq0
	+rtxDsvSOl2WMTKnXYPoxDUE8vPVGzu2u7eYVXMQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshf4vqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 12:42:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 608CgvtK028561;
	Thu, 8 Jan 2026 12:42:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshf4vqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 12:42:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 608Buvif023511;
	Thu, 8 Jan 2026 12:42:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bg3rmkfh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 12:42:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 608CgsxE40763660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Jan 2026 12:42:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F72320043;
	Thu,  8 Jan 2026 12:42:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83EB320040;
	Thu,  8 Jan 2026 12:42:52 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.167])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Jan 2026 12:42:52 +0000 (GMT)
Date: Thu, 8 Jan 2026 18:12:49 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>,
        libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] ext4: Refactor zeroout path and handle all cases
Message-ID: <aV-mJci2dxojEFMY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <1ecffaf1edd7a37d90a7fcc8808b9b6e4e7a1245.1767528171.git.ojaswin@linux.ibm.com>
 <c715795a-12d7-4d52-9f44-a7abe4b9cc56@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c715795a-12d7-4d52-9f44-a7abe4b9cc56@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA4NiBTYWx0ZWRfXyfbljd+E2M1E
 1ZL0B3MjjePRDaSlfRemYDFtL+LyFRNdqxaRBa+b5RigpUz7d1usWUvx+14csbZOM6OR/l/zmsc
 gUHfxWHF2qMAv5neuozW7jlBQ0mp+hPBcOni9YEheCsbewp1RujLSfv3Cj04fonCvEbaAVrkRXa
 gLLfgduGN+mbwMYz/T/dF9NO/QadG12hSOJiXWE2BAVWm9K7Ccs1+3L6MjEnCSXIHWMOG+f6kDH
 WVxNnJCXGRiCvOp+aHCEMr4gh01GnEdmYfnqWST7kKihdeT3IPBMe7FgYE3F6IrvkePOcWp07pm
 XFzBYA3Cc69N/QvHUl3nFYhjVlgUvvyHt5teckuaaEr2TpagbVuZ+rp4z9JQ6Q2W1oFJ03GKUdb
 siiX8hcrb97u8x2XmRfI83/2712X/0WiNKzS1xkApE3A8avduIh66gd08Xv+UU3M2a7nuGBa0XX
 qWj/v9AeykrDb88agaA==
X-Proofpoint-GUID: aTLmtCnKbNiz0uonTJnzM2-V2VwpORdU
X-Proofpoint-ORIG-GUID: R15gUjOzh0CXa3-Dy_YHhL8hOmG7YQsJ
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695fa651 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=I0FLUN2nnJC_vGQjSPkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601080086

On Thu, Jan 08, 2026 at 07:58:21PM +0800, Zhang Yi wrote:
> On 1/4/2026 8:19 PM, Ojaswin Mujoo wrote:
> > Currently, zeroout is used as a fallback in case we fail to
> > split/convert extents in the "traditional" modify-the-extent-tree way.
> > This is essential to mitigate failures in critical paths like extent
> > splitting during endio. However, the logic is very messy and not easy to
> > follow. Further, the fragile use of various flags has made it prone to
> > errors.
> > 
> > Refactor zeroout out logic by moving it up to ext4_split_extents().
> > Further, zeroout correctly based on the type of conversion we want, ie:
> > - unwritten to written: Zeroout everything around the mapped range.
> > - unwritten to unwritten: Zeroout everything
> > - written to unwritten: Zeroout only the mapped range.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Hi, Ojaswin!
> 
> The refactor overall looks good to me. After this series, the split
> logic becomes more straightforward and clear. :)
> 
> I have some comments below.
> 
> > ---
> >  fs/ext4/extents.c | 287 +++++++++++++++++++++++++++++++---------------
> >  1 file changed, 195 insertions(+), 92 deletions(-)
> > 
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index 460a70e6dae0..8082e1d93bbf 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> 
> [...]
> 
> > @@ -3365,6 +3313,115 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
> >  	return path;
> >  }
> >  
> > +static struct ext4_ext_path *
> > +ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
> > +			  struct ext4_ext_path *path,
> > +			  struct ext4_map_blocks *map, int flags)
> > +{
> > +	struct ext4_extent *ex;
> > +	unsigned int ee_len, depth;
> > +	ext4_lblk_t ee_block;
> > +	uint64_t lblk, pblk, len;
> > +	int is_unwrit;
> > +	int err = 0;
> > +
> > +	depth = ext_depth(inode);
> > +	ex = path[depth].p_ext;
> > +	ee_block = le32_to_cpu(ex->ee_block);
> > +	ee_len = ext4_ext_get_actual_len(ex);
> > +	is_unwrit = ext4_ext_is_unwritten(ex);
> > +
> > +	if (flags & EXT4_GET_BLOCKS_CONVERT) {
> > +		/*
> > +		 * EXT4_GET_BLOCKS_CONVERT: Caller wants the range specified by
> > +		 * map to be initialized. Zeroout everything except the map
> > +		 * range.
> > +		 */
> > +
> > +		loff_t map_end = (loff_t) map->m_lblk + map->m_len;
> > +		loff_t ex_end = (loff_t) ee_block + ee_len;
> > +
> > +		if (!is_unwrit)
> > +			/* Shouldn't happen. Just exit */
> > +			return ERR_PTR(-EINVAL);
> 
> For cases that are should not happen, I'd suggest adding a WARN_ON_ONCE or
> a message to facilitate future problem identification. Same as below.

Hi Yi,

Thanks for the review! Sure I can do that in v2.
> 
> > +
> > +		/* zeroout left */
> > +		if (map->m_lblk > ee_block) {
> > +			lblk = ee_block;
> > +			len = map->m_lblk - ee_block;
> > +			pblk = ext4_ext_pblock(ex);
> > +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
> > +			if (err)
> > +				/* ZEROOUT failed, just return original error */
> > +				return ERR_PTR(err);
> > +		}
> > +
> > +		/* zeroout right */
> > +		if (map->m_lblk + map->m_len < ee_block + ee_len) {
> > +			lblk = map_end;
> > +			len = ex_end - map_end;
> > +			pblk = ext4_ext_pblock(ex) + (map_end - ee_block);
> > +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
> > +			if (err)
> > +				/* ZEROOUT failed, just return original error */
> > +				return ERR_PTR(err);
> > +		}
> > +	} else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
> > +		/*
> > +		 * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Caller wants the
> > +		 * range specified by map to be marked unwritten.
> > +		 * Zeroout the map range leaving rest as it is.
> > +		 */
> > +
> > +		if (is_unwrit)
> > +			/* Shouldn't happen. Just exit */
> > +			return ERR_PTR(-EINVAL);
> > +
> > +		lblk = map->m_lblk;
> > +		len = map->m_len;
> > +		pblk = ext4_ext_pblock(ex) + (map->m_lblk - ee_block);
> > +		err = ext4_issue_zeroout(inode, lblk, pblk, len);
> > +		if (err)
> > +			/* ZEROOUT failed, just return original error */
> > +			return ERR_PTR(err);
> > +	} else if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) {
> > +		/*
> > +		 * EXT4_GET_BLOCKS_UNWRIT_EXT: Today, this flag
> > +		 * implicitly implies that callers when wanting an
> > +		 * unwritten to unwritten split. So zeroout the whole
> > +		 * extent.
> > +		 *
> > +		 * TODO: The implicit meaning of the flag is not ideal
> > +		 * and eventually we should aim for a more well defined
> > +		 * behavior
> > +		 */
> > +
> 
> I don't think we need this branch anymore. After applying my patch "ext4:
> don't split extent before submitting I/O", we will no longer encounter
> situations where doing an unwritten to unwritten split. It means that at
> all call sites of ext4_split_extent(), only EXT4_GET_BLOCKS_CONVERT or
> EXT4_GET_BLOCKS_CONVERT_UNWRITTEN flags are passed. What do you think?

Yes, I did notice that as well after rebasing on your changes. 

So the next patch enforces the behavior that if no flag is passed to
ext4_split_extent() -> ext4_split_extent_zeroout() then we assume a
split without conversion. As you mentioned, there is no remaining caller
that does this but I thought of handling it here so that in future if we
ever need to use unwrit to unwrit splits we handle it correctly.

Incase you still feel this makes it confusing or is uneccessary I can
remove the else part altoghether and add a WARN_ON.

Thanks,
ojaswin

> 
> Thanks,
> Yi.
> 
> > +		if (!is_unwrit)
> > +			/* Shouldn't happen. Just exit */
> > +			return ERR_PTR(-EINVAL);
> > +
> > +		lblk = ee_block;
> > +		len = ee_len;
> > +		pblk = ext4_ext_pblock(ex);
> > +		err = ext4_issue_zeroout(inode, lblk, pblk, len);
> > +		if (err)
> > +			/* ZEROOUT failed, just return original error */
> > +			return ERR_PTR(err);
> > +	}
> > +
> > +	err = ext4_ext_get_access(handle, inode, path + depth);
> > +	if (err)
> > +		return ERR_PTR(err);
> > +
> > +	ext4_ext_mark_initialized(ex);
> > +
> > +	ext4_ext_dirty(handle, inode, path + path->p_depth);
> > +	if (err)
> > +		return ERR_PTR(err);
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * ext4_split_extent() splits an extent and mark extent which is covered
> >   * by @map as split_flags indicates
> 
> [...]
> 

