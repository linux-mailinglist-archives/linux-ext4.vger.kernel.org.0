Return-Path: <linux-ext4+bounces-12991-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1929D3A753
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 12:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17E373024B6A
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A43318EC7;
	Mon, 19 Jan 2026 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DMxB8+xV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1027E07E;
	Mon, 19 Jan 2026 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823264; cv=none; b=MwljX+eND5i6J6E+8jtOBX4DpsWkLidYnryf2YCMC7KeqXZuOUw0qDj1NYaSkjuSOGss9vU+vZQRsQbfX8LIsz+latAsJuqyBHWvE3TXX5ZxoVmNx1UIDOrZkMlPf9odpYJVh6Nyiym2iBnnsvDMJ7Y75rHbv837eycjdIXMF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823264; c=relaxed/simple;
	bh=bGljV04+p25Kq4KIg5TCPVhRKwUVNdGZ1BL9fCzoWGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGTTPhfjhxlsBU2EgEohIWurRqe1WYfcEmVUoS6XPwZct7G6xdMhZdCA1mIdWJzHK+QlUJn61YBmLYwOUhGx8x3j0pYbLM8VDTd8qmmi9FpG7u8l+69JoHoYQVXUB/bl7mjgbvsngcrfpNmJF4MOzmnRr+i6BEUL89s2BR/KZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DMxB8+xV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60IJNmsj010632;
	Mon, 19 Jan 2026 11:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wU5Yc4FsN4lwEu1009kG6ympjZCI5c
	SW3UVkGTAoGTg=; b=DMxB8+xVaKK/Bfgo3E7rK54q7YUDzU7tl4wtE6+8zHTCRw
	KiNuTrdjenG04L2ERa8tv6fmMwikDzJ3O3438bYB3STi2sZ3R/39HsHFeW36LVX7
	jpBSaXy6ytsAw875SPaAD0pkWtiiZVpMEQ5dLVMfV6+3MaVtDt7g+WWRSxdTScKL
	jEpH81J6Bx/C5/uoGhzR8M3L1s44PY53xh9J+8NpqUVR0LpCQ99L2HTIsA4rGv1/
	wmGPDuDehzje1fwEEOufp+4igq1gO1II0GqtnI6/dAfwuwaWNy5t5o0nGMfZV5wn
	dSS6g3laICI8ZoFYaU4yPYXJd8JmZHim2JPMGsfw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br22u7b55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 11:47:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JBlWS6025363;
	Mon, 19 Jan 2026 11:47:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br22u7b52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 11:47:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JBFPxv001404;
	Mon, 19 Jan 2026 11:47:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyje7pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 11:47:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JBlTPP20840936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 11:47:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4A9F20043;
	Mon, 19 Jan 2026 11:47:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4CC820040;
	Mon, 19 Jan 2026 11:47:27 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Jan 2026 11:47:27 +0000 (GMT)
Date: Mon, 19 Jan 2026 17:17:25 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yizhang089@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] ext4: Refactor zeroout path and handle all cases
Message-ID: <aW4ZzaPM1Mb1_iwh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <3a63beac9855f41efcdb11b839b4cb6fdc9fb3a4.1768402426.git.ojaswin@linux.ibm.com>
 <7752893e-720b-4dd6-878c-1d5087057a55@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7752893e-720b-4dd6-878c-1d5087057a55@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pcA7r8szPkJIFUzeLk-vPd74N0d2tHSx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5NyBTYWx0ZWRfXxovxiyTXKvSh
 rfnyCzndDAZUa91WS9dFuTvODNCzt4EF1Tw92HTgJvahb+3ppPR/DIj6PGuEF6DTQJStQDOVIfJ
 HkRO+fZ2b3OPfSHxGkJORpKa9Fw41nchCiCjQkWx1OkslO980lVQczTSmdKTk8oV/iRDMgtgIfT
 W3U7LFfS3Ih/m4sNKhsUMIYdTTmzoVhJApJICCz1FStH/VegsbG/MlClVGo+g2ZdoYmot5hghTH
 BzQlexIXkVT3Ms5FJrLqgz0Hul2r3wnREjvU32FYL9c3eF+eQJNhAgjhJV4OT3twNOnGbSRaFCR
 xDBxcB8DDs/ukSp35WoQWg9KK7YCCazssyHJUkZhTBpiMVvBZTp/rllw9usGncwvDASv5EcsJ5K
 /wJhIcm48C4K453fYITW5GOgp6JyNkn/hYmDy8Qxmlt3zOMrfT4VkAaaDS5APND1/vGjPqqVTSd
 AI812sxm55aGDJb5ArQ==
X-Proofpoint-ORIG-GUID: OLGgox4940RIIgE3urFUhmEM1zABp3xu
X-Authority-Analysis: v=2.4 cv=Sp2dKfO0 c=1 sm=1 tr=0 ts=696e19d4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8 a=_FY4MzJn5W3a-V7J89sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190097

On Sat, Jan 17, 2026 at 04:00:30PM +0800, Zhang Yi wrote:
> On 1/14/2026 10:57 PM, Ojaswin Mujoo wrote:
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
> > - written to unwritten: Zeroout only the mapped range.
> > 
> > Also, ext4_ext_convert_to_initialized() now passes
> > EXT4_GET_BLOCKS_CONVERT to make the intention clear.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Overall looks good to me besides one comment below. Feel free to add after
> fixing it:
> 
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> 
> > ---
> >   fs/ext4/extents.c | 286 ++++++++++++++++++++++++++++++----------------
> >   1 file changed, 188 insertions(+), 98 deletions(-)
> > 
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index 54f45b40fe73..70d85f007dc7 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -44,14 +44,6 @@
> >   #define EXT4_EXT_MARK_UNWRIT1	0x2  /* mark first half unwritten */
> >   #define EXT4_EXT_MARK_UNWRIT2	0x4  /* mark second half unwritten */

<...>

> > -			split_flag1 |= map->m_lblk > ee_block ?
> > -				       EXT4_EXT_DATA_PARTIAL_VALID1 :
> > -				       EXT4_EXT_DATA_ENTIRE_VALID1;
> >   		path = ext4_split_extent_at(handle, inode, path,
> >   				map->m_lblk + map->m_len, split_flag1, flags1);
> >   		if (IS_ERR(path))
> > -			return path;
> > +			goto try_zeroout;
> > +
> >   		/*
> >   		 * Update path is required because previous ext4_split_extent_at
> >   		 * may result in split of original leaf or extent zeroout.
> >   		 */
> >   		path = ext4_find_extent(inode, map->m_lblk, path, flags);
> >   		if (IS_ERR(path))
> > -			return path;
> > +			goto try_zeroout;
> > +
> >   		depth = ext_depth(inode);
> >   		ex = path[depth].p_ext;
> >   		if (!ex) {
> > @@ -3426,22 +3475,64 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
> >   			ext4_free_ext_path(path);
> >   			return ERR_PTR(-EFSCORRUPTED);
> >   		}
> > -		unwritten = ext4_ext_is_unwritten(ex);
> 
> We need to update the 'orig_ee_len' parameter here, otherwise
> it would trigger WARN_ON(ee_len != orig_ee_len) below.
> 
> Thanks,
> Yi.

Hi Yi, thanks for the reviews! 

Yes thats a nice catch, I'll change it in v3.

Regards,
ojaswin

> 
> >   	}
> >   	if (map->m_lblk >= ee_block) {
> > -		split_flag1 = split_flag & EXT4_EXT_DATA_VALID2;
> > +		split_flag1 = 0;
> >   		if (unwritten) {
> >   			split_flag1 |= EXT4_EXT_MARK_UNWRIT1;
> > -			split_flag1 |= split_flag & (EXT4_EXT_MAY_ZEROOUT |
> > -						     EXT4_EXT_MARK_UNWRIT2);
> > +			split_flag1 |= split_flag & EXT4_EXT_MARK_UNWRIT2;
> >   		}

<...>

