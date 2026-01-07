Return-Path: <linux-ext4+bounces-12606-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B01FACFC510
	for <lists+linux-ext4@lfdr.de>; Wed, 07 Jan 2026 08:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58E3930249EC
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jan 2026 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73B622256F;
	Wed,  7 Jan 2026 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kHpKAKL5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81CE1FBEA8;
	Wed,  7 Jan 2026 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770484; cv=none; b=c//bUgssgZEsmbu3xxnUaMv0WdQkYT/AQ4US1T3iMHCaWujyxXNfJZjxbC2bfvdC8BgFoAtbrLMx60lSzv1CgpAn3WpKoZCscvDjxK23KgHom5TRtTDq9gi5sXuTVpAARaHGmE/7iWfsiJ9Lkgy+FF34nGqZgMwFNI4ETUQIfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770484; c=relaxed/simple;
	bh=uB5V5GLgstNloWPmLb+sP6oUkJdW9uktRHn6sdr8OGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcoSg3VBS0WyDzn5Ld5IPQg7YinAGV+GbEQJRfAQWWtDvNha1OOHGJUEifrYuZbvSZ8kWpZuIUES1DJNV4na9vtPRreoGdK2xBvgmJ6wSNr4iATD1M9WHIktm1rgkAP4WRtmzukjqZ+Hw3zcmY9e0L1cFKOPczJH3vxWbGTEuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kHpKAKL5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6075nHEx004093;
	Wed, 7 Jan 2026 07:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4vHmUUZuwLG6dYrOn8Y/rAe5equKBw
	nDxeB6tRKdyKo=; b=kHpKAKL51gh+Jz4IUsTzvj4+8MOcX/OWFSmuhcUdBDulJi
	I7uXTXGPKP/M9v9nMtLVU3dQGADn50wR9t8ufuX1usG4dV+32w9/p8qpBvZGgxYy
	SH8GEXDJg1d426fcBzDLOEUcH33LtnA7Yz+V4SbMSRKxvPaL6Nu+WSJoTY60QyLK
	rnTWzJKtGhNt1srNDbipDJz/BER0ZPCtzdXh7z3AFgZqL4rq8ln3EDEiDy2IYr2i
	EHC6M/tVDvpm92IqobhkdmE/MPcSHWrjlebJEdlzYJFp/fm8L2c+Rt39k4FjhLj0
	cOif9MriTr0xOs9kd6PZSxYKm/XRr1drMimr+Fvw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu67g4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 07:16:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6077Cex4017211;
	Wed, 7 Jan 2026 07:16:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu67g4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 07:16:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607748Ag023528;
	Wed, 7 Jan 2026 07:16:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bg3rmcc4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 07:16:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6077G3Go52691234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 07:16:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75D5320043;
	Wed,  7 Jan 2026 07:16:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6FAC20040;
	Wed,  7 Jan 2026 07:16:01 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.31.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Jan 2026 07:16:01 +0000 (GMT)
Date: Wed, 7 Jan 2026 12:45:59 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] ext4: Refactor zeroout path and handle all cases
Message-ID: <aV4IL1wP76uefmO7@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <1ecffaf1edd7a37d90a7fcc8808b9b6e4e7a1245.1767528171.git.ojaswin@linux.ibm.com>
 <berakgy2my7h2v5wfijozaucks2fykqhqaq6zdbaucy7cx5osq@gkzxv4snj2ug>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <berakgy2my7h2v5wfijozaucks2fykqhqaq6zdbaucy7cx5osq@gkzxv4snj2ug>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695e0837 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=I0FLUN2nnJC_vGQjSPkA:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: LZaOysafCAB7xi5IP0vvt4_bpsmupWl4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA0OSBTYWx0ZWRfXzuK0i5NIw2RK
 9pE240Gwf5X4tpiOhG+2el02T1Gx1IIGafCr2tLo2Ds9TZZ+/oO1O/I7AmSy6543u157f3vpSWC
 zwmqZ3rcXT2AdOBUebTlsmjBD5lniUtf5Nmgb2K3aDTAuakx0DG+uhTxjWhSbkQF3nXUunWoJ93
 K6ZqleHku06ETqKbtAgA110if6m/Eeqdo6Fnljl+XNaBQsjm+CG/eesRaxUb69YSFm5jwTqRzJX
 SmtBXTpdHawG2tyXldeBU3i7KYG8vPbTvlD4OoTbyaMkT4F6Ywr4fcAi2EwqjzXTRZJq5eEbuQc
 wYqnk6cj7XKCvfSvuOlSCL5kA9kduA1ssmeJJzTVHihKlLswm6yP+/D28YOk7970tU9A2Rxl0uh
 5iE7BJYBD0bOzsGdiC6jDDIe1dDlea9ntJDCa/Jp+ZjMtGsy/HdarXKHCkjkhC1FY3gkj/B1VzA
 Ci+TBuMzZGAb+//+ycQ==
X-Proofpoint-GUID: QMQqj7DDq506HP2T1a4EubvRzNgFx6GF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070049

On Tue, Jan 06, 2026 at 04:31:23PM +0100, Jan Kara wrote:
> On Sun 04-01-26 17:49:18, Ojaswin Mujoo wrote:
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
> ...
> 
> > @@ -3383,11 +3440,12 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
> > +	int err = 0, orig_err;
> 
> Cannot orig_err be used uninitialized in this function? At least it isn't
> obvious to me some of the branches setting it is always taken.

Hi Jan, thanks for the reviews. Yes orig_err is always initialized
before it is used (initialized on error and used in zeroout path which
is only taked on error), but I agree that we can just init it to 0.

> 
> > @@ -3395,23 +3453,29 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
> > -		if (IS_ERR(path))
> > -			return path;
> > +
> > +		if (IS_ERR(path)) {
> > +			orig_err = PTR_ERR(path);
> > +			if (orig_err != -ENOSPC && orig_err != -EDQUOT &&
> > +			    orig_err != -ENOMEM)
> > +				return path;
> > +
> > +			goto try_zeroout;
> > +		}
> >  		/*
> >  		 * Update path is required because previous ext4_split_extent_at
> >  		 * may result in split of original leaf or extent zeroout.
> > @@ -3427,22 +3491,68 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
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
> > +
> > +		if (IS_ERR(path)) {
> > +			orig_err = PTR_ERR(path);
> > +			if (orig_err != -ENOSPC && orig_err != -EDQUOT &&
> > +			    orig_err != -ENOMEM)
> > +				return path;
> > +
> > +			goto try_zeroout;
> > +		}
> > +	}
> > +
> > +	if (!err)
> 
> Nothing touches 'err' in this function...

Yes :), I'll remove this.

> 
> > +		goto out;
> > +
> > +try_zeroout:
> > +	/*
> > +	 * There was an error in splitting the extent, just zeroout and convert
> > +	 * to initialize as a last resort
> > +	 */
> > +	if (split_flag & EXT4_EXT_MAY_ZEROOUT) {
> > +		path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
> >  		if (IS_ERR(path))
> >  			return path;
> > +
> > +		depth = ext_depth(inode);
> > +		ex = path[depth].p_ext;
> > +		ee_block = le32_to_cpu(ex->ee_block);
> > +		ee_len = ext4_ext_get_actual_len(ex);
> > +		unwritten = ext4_ext_is_unwritten(ex);
> > +
> > +		/*
> > +		 * The extent to zeroout should have been unchanged
> > +		 * but its not, just return error to caller
> > +		 */
> > +		if (WARN_ON(ee_block != orig_ee_block ||
> > +			    ee_len != orig_ee_len ||
> > +			    unwritten != orig_unwritten))
> > +			return ERR_PTR(orig_err);
> > +
> > +		/*
> > +		 * Something went wrong in zeroout, just return the
> > +		 * original error
> > +		 */
> > +		if (ext4_split_extent_zeroout(handle, inode, path, map, flags))
> > +			return ERR_PTR(orig_err);
> >  	}
> 
> Also nothing seems to zero out orig_err in case zero out above succeeded.
> What am I missing?

So if zeroout here succeeds we just goto out and return path, we never
use orig_err.  Not the best practice and admittedly, I seem to have
complicated the error handling a bit. I will streamline it in v2. 

Thanks for pointing this out.
Ojaswin.
> 
> 								Honza
> 
> >  
> > +	/* There's an error and we can't zeroout, just return the err */
> > +	return ERR_PTR(orig_err);
> > +
> > +out:
> > +
> >  	if (allocated) {
> >  		if (map->m_lblk + map->m_len > ee_block + ee_len)
> >  			*allocated = ee_len - (map->m_lblk - ee_block);
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

