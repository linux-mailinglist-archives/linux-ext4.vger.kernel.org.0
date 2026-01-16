Return-Path: <linux-ext4+bounces-12914-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BCCD2C050
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 06:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB3D1300D28B
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 05:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4434320A;
	Fri, 16 Jan 2026 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="siyvtOqg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC04822CBE6;
	Fri, 16 Jan 2026 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768541768; cv=none; b=SIQITchce182y2uOexLUHAMGlJKW5Dok/DKTkpi+9BFJ8iCWqEGZ+xCpT81+6AUCb6RVcQ1s6Q+s5Z6c39XhpX28UzLqMpOiQVg49NA262lsS42E/f5RMYtP9eR5HwWNQH489deQQg+qCxmfNAjBdIvRBQrl7M8mnO8R7XjiSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768541768; c=relaxed/simple;
	bh=4d8VFlfbt01BPXMuBUZb5DWxtWQFd5YGOx/8b+tA7nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FELUobaGk1bEoqCMPhuVmAhvgQvMlEV/CgnhRRZa1m5zwnvSjtIlaL5iAH9I5jcNX7w4bdwT1hWJHEPEbg2wjf6OeDti4HvnXai8g55KZfbDsAyEz3nIWqvDXvWAtZ/w6xNXyq5uVYx0U26Vdfd2HrlqRVBZguX9I0KBXYtYflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=siyvtOqg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FMskTU012367;
	Fri, 16 Jan 2026 05:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ixWOSfthh7wRfZ17hvM9GZunR48wtm
	njrgZOCaKt9iQ=; b=siyvtOqgUjB95gcD0GABVY0g+gRQaY533V4XUI/+QycA1D
	2ocjibvldbw8byGpz6XvCNEhHoaGFgutDPLPfHoEcG7l245xa4qTrYMFEgA7LPo/
	OVW6ceT3nujr+ZQl6scc+6+SHKe+8VLWoCrJhIhDusaLN3low18dxF/wVKpGzpPc
	5PlUdg+JBCjKJ6TKOJSnhzZaoAEkgES9BMEW+C00caWqXqMIO2M7YNCKVZjhcfwL
	0AqSX2Vzkhka54vEGwcaShT4fFxZJkAX6rjDxXYlQcP8jrNDN3wZvW13jt3qrWbB
	RIcOGrhcPf7902UlWNlQpY/yqv00XrCbJelw9p7w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9ems1qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:35:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60G5YGdG022436;
	Fri, 16 Jan 2026 05:35:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9ems1q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:35:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60G3ugXJ014244;
	Fri, 16 Jan 2026 05:35:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fymd1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:35:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60G5Zoca52167008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 05:35:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F9072004E;
	Fri, 16 Jan 2026 05:35:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7AA320043;
	Fri, 16 Jan 2026 05:35:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.218.99])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 Jan 2026 05:35:47 +0000 (GMT)
Date: Fri, 16 Jan 2026 11:05:44 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] ext4: Refactor zeroout path and handle all cases
Message-ID: <aWnNvttsuSIoq3WA@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <3a63beac9855f41efcdb11b839b4cb6fdc9fb3a4.1768402426.git.ojaswin@linux.ibm.com>
 <62d5naxy5tq2gvi4vv4hhxhjfabkcr7w2qsvz7y73ihei6o7ue@oieo2mwvx344>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d5naxy5tq2gvi4vv4hhxhjfabkcr7w2qsvz7y73ihei6o7ue@oieo2mwvx344>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KvJAGGWN c=1 sm=1 tr=0 ts=6969ce39 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=cPYx2sDTU6CemQt6AfgA:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA0MSBTYWx0ZWRfXzXE1V9GDXe/H
 E9D8ftHpBzv3hX9MRr9bQgcwKrThkbCkdTnmyepfkBpo/p2eVrNWK/LbZ6ksmuNyagWo5/URnrU
 rGI8W9wDHZvcqi/VGF2t19kXB59Kc1R73p5d0/kCB/kBEJjH+bjTODeyrvh3yDFQH0IylcT9Sig
 3OA1dq7KEvL6lZNZnn4S/MyJK9YUaAG5hQylZ5FmMBM4YMUEPwRsuFTvYJa6PE2RA9zWb4ZzeSQ
 u3Uq19sl0OUixwuvFzHoBgI4+sb/kgQlfDJ5Ag1qsfqa2NqwSHIo6pP0VC5Xe1CHAuDcOzk9yhx
 QypOLi91soxtD0mjQ2DkkcMSsDNe3q/ZEeIX/9EH3K8WdZ9nMtG1AvKQ7s4e8MreIEp0Laoa53Q
 mowDvhOqYREhqkEsSEc5j7J3tEIAJd2DWSl4zUPKuervAJu8zqcCWq5thYn050u0/yumWXAJpnL
 m3nQTz3vvNvhKwck56g==
X-Proofpoint-GUID: _kTFjQKruaT1edyB3gPAiKm698mbXdAJ
X-Proofpoint-ORIG-GUID: pXnflHowPLJvZXHZmYYQLmNmGMPEyyzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601160041

On Thu, Jan 15, 2026 at 01:01:14PM +0100, Jan Kara wrote:
> On Wed 14-01-26 20:27:50, Ojaswin Mujoo wrote:
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
> Overall looks nice. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for the review Jan, I'll make the changes you suggested in v3.

Regards,
ojaswin
> 
> A few nits below:
> 
> > +static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
> > +				     struct ext4_ext_path *path,
> > +				     struct ext4_map_blocks *map, int flags)
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
> >  
> > +	if (flags & EXT4_GET_BLOCKS_CONVERT) {
> >  		/*
> > -		 * The first half contains partially valid data, the splitting
> > -		 * of this extent has not been completed, fix extent length
> > -		 * and ext4_split_extent() split will the first half again.
> > +		 * EXT4_GET_BLOCKS_CONVERT: Caller wants the range specified by
> > +		 * map to be initialized. Zeroout everything except the map
> > +		 * range.
> >  		 */
> > -		if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1) {
> > -			/*
> > -			 * Drop extent cache to prevent stale unwritten
> > -			 * extents remaining after zeroing out.
> > -			 */
> > -			ext4_es_remove_extent(inode,
> > -					le32_to_cpu(zero_ex.ee_block),
> > -					ext4_ext_get_actual_len(&zero_ex));
> > -			goto fix_extent_len;
> > +
> > +		loff_t map_end = (loff_t) map->m_lblk + map->m_len;
> > +		loff_t ex_end = (loff_t) ee_block + ee_len;
> > +
> > +		if (!is_unwrit)
> > +			/* Shouldn't happen. Just exit */
> > +			return -EINVAL;
> > +
> > +		/* zeroout left */
> > +		if (map->m_lblk > ee_block) {
> > +			lblk = ee_block;
> > +			len = map->m_lblk - ee_block;
> > +			pblk = ext4_ext_pblock(ex);
> > +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
> > +			if (err)
> > +				/* ZEROOUT failed, just return original error */
> > +				return err;
> >  		}
> >  
> > -		/* update the extent length and mark as initialized */
> > -		ex->ee_len = cpu_to_le16(ee_len);
> > -		ext4_ext_try_to_merge(handle, inode, path, ex);
> > -		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> > -		if (!err)
> > -			/* update extent status tree */
> > -			ext4_zeroout_es(inode, &zero_ex);
> > +		/* zeroout right */
> > +		if (map->m_lblk + map->m_len < ee_block + ee_len) {
> 
> Use map_end and ex_end in the above condition when we have it?
> 
> ...
> > @@ -3382,11 +3428,13 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
> >  					       int split_flag, int flags,
> >  					       unsigned int *allocated)
> >  {
> > -	ext4_lblk_t ee_block;
> > +	ext4_lblk_t ee_block, orig_ee_block;
> >  	struct ext4_extent *ex;
> > -	unsigned int ee_len, depth;
> > -	int unwritten;
> > -	int split_flag1, flags1;
> > +	unsigned int ee_len, orig_ee_len, depth;
> > +	int unwritten, orig_unwritten;
> > +	int split_flag1 = 0, flags1 = 0;
> > +	int  orig_err = 0;
> 	   ^^ extra space
> 
> > +	int orig_flags = flags;
> >  
> >  	depth = ext_depth(inode);
> >  	ex = path[depth].p_ext;
> > @@ -3394,30 +3442,31 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
> >  	ee_len = ext4_ext_get_actual_len(ex);
> >  	unwritten = ext4_ext_is_unwritten(ex);
> >  
> > +	orig_ee_block = ee_block;
> > +	orig_ee_len = ee_len;
> > +	orig_unwritten = unwritten;
> > +
> >  	/* Do not cache extents that are in the process of being modified. */
> >  	flags |= EXT4_EX_NOCACHE;
> >  
> >  	if (map->m_lblk + map->m_len < ee_block + ee_len) {
> > -		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
> >  		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
> >  		if (unwritten)
> >  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
> >  				       EXT4_EXT_MARK_UNWRIT2;
> > -		if (split_flag & EXT4_EXT_DATA_VALID2)
> > -			split_flag1 |= map->m_lblk > ee_block ?
> > -				       EXT4_EXT_DATA_PARTIAL_VALID1 :
> > -				       EXT4_EXT_DATA_ENTIRE_VALID1;
> >  		path = ext4_split_extent_at(handle, inode, path,
> >  				map->m_lblk + map->m_len, split_flag1, flags1);
> >  		if (IS_ERR(path))
> > -			return path;
> > +			goto try_zeroout;
> > +
> >  		/*
> >  		 * Update path is required because previous ext4_split_extent_at
> >  		 * may result in split of original leaf or extent zeroout.
> >  		 */
> >  		path = ext4_find_extent(inode, map->m_lblk, path, flags);
> >  		if (IS_ERR(path))
> > -			return path;
> > +			goto try_zeroout;
> > +
> >  		depth = ext_depth(inode);
> >  		ex = path[depth].p_ext;
> >  		if (!ex) {
> > @@ -3426,22 +3475,64 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
> >  			ext4_free_ext_path(path);
> >  			return ERR_PTR(-EFSCORRUPTED);
> >  		}
> > -		unwritten = ext4_ext_is_unwritten(ex);
> >  	}
> >  
> >  	if (map->m_lblk >= ee_block) {
> > -		split_flag1 = split_flag & EXT4_EXT_DATA_VALID2;
> > +		split_flag1 = 0;
> >  		if (unwritten) {
> >  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1;
> > -			split_flag1 |= split_flag & (EXT4_EXT_MAY_ZEROOUT |
> > -						     EXT4_EXT_MARK_UNWRIT2);
> > +			split_flag1 |= split_flag & EXT4_EXT_MARK_UNWRIT2;
> >  		}
> > -		path = ext4_split_extent_at(handle, inode, path,
> > -				map->m_lblk, split_flag1, flags);
> > +		path = ext4_split_extent_at(handle, inode, path, map->m_lblk,
> > +					    split_flag1, flags);
> >  		if (IS_ERR(path))
> > -			return path;
> > +			goto try_zeroout;
> >  	}
> >  
> > +	goto success;
> > +
> > +try_zeroout:
> > +	/*
> > +	 * There was an error in splitting the extent. So instead, just zeroout
> > +	 * unwritten portions and convert it to initialize as a last resort. If
> > +	 * there is any failure here we just return the original error
> > +	 */
> > +
> > +	orig_err = PTR_ERR(path);
> > +	if (orig_err != -ENOSPC && orig_err != -EDQUOT && orig_err != -ENOMEM)
> > +		goto out_orig_err;
> > +
> > +	if (!(split_flag & EXT4_EXT_MAY_ZEROOUT))
> > +		/* There's an error and we can't zeroout, just return the
> > +		 * original err
> > +		 */
> 
> I'd put this before if and just write:
> 
> 	/* We can't zeroout? Just return the original error */
> 
> so that the comment fits on a single line :)
> 
> > +		goto out_orig_err;
> > +
> > +	path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
> > +	if (IS_ERR(path))
> > +		goto out_orig_err;
> > +
> > +	depth = ext_depth(inode);
> > +	ex = path[depth].p_ext;
> > +	ee_block = le32_to_cpu(ex->ee_block);
> > +	ee_len = ext4_ext_get_actual_len(ex);
> > +	unwritten = ext4_ext_is_unwritten(ex);
> > +
> > +	if (WARN_ON(ee_block != orig_ee_block || ee_len != orig_ee_len ||
> > +		    unwritten != orig_unwritten))
> > +		/*
> > +		 * The extent to zeroout should have been unchanged
> > +		 * but its not.
> > +		 */
> > +		goto out_free_path;
> > +
> > +	if (ext4_split_extent_zeroout(handle, inode, path, map, orig_flags))
> > +		/*
> > +		 * Something went wrong in zeroout
> > +		 */
> 
> I think this comment isn't really useful...
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

