Return-Path: <linux-ext4+bounces-12604-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BA8CFC43F
	for <lists+linux-ext4@lfdr.de>; Wed, 07 Jan 2026 08:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82AA13030211
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jan 2026 07:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D9F26C3B0;
	Wed,  7 Jan 2026 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rsWFdOAz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A962737F8;
	Wed,  7 Jan 2026 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769217; cv=none; b=FBOCtlEisHWUacNPGy9Q6O9e41ECrhVTMdlvB3yfEpv/sioQR+6Hekz28TzFNJy21b0bcYuB6oTKLqPJCM4ZPs+Wnq4ajHscjZw4kSIc7hICOhkTTjCz78pGtFY73Zp4yCzvJevlzbbwwa4nvTE74O4g6JJPwUFKE8LS6jdUvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769217; c=relaxed/simple;
	bh=ibIXJ7IaIrj9KT1ZtdVhiKQa3n3Dooh9u/Z7eOQCCpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+MacMhZsCXSDkhdY6WifHDO5xc4Fs2gnJPSTd26dqofRjx7/Frz9WW+XuKrWjczAqqAdukC38JZcmiPIjgWtK4F+wK54CwcBldgUYTr1gyRl1SR5S/WIW+Tq6AT9sCl0TSOvwSOCTVPO9pOCNuaXigRiF6+c1xvtsrNV50Vp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rsWFdOAz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606IJ39g002012;
	Wed, 7 Jan 2026 06:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fHZ/VcNsSv1SYUWmVeVBUuwRpNkUN3
	g6kMCRbpk6QZY=; b=rsWFdOAzdkOM5oHN1csYl94wh3Vo7OgTGAawKQPF8SE4kR
	o9NYaleHkigRaI9SOn97ctd8Fkx1zmUzvz4EE9EioMcCo5uO7HzMGem2Yz+q3xxb
	+03b2fYOXzQSLM2dBgKQMS0NAytBKmd5J+OUq6Gu5E6mJaQBop9oiRZkFu7J3sTj
	3GVKhjf4R6cOllW+0uiDk/UDv6yShs1/ySgpxF+nhu2SW0btTVfNZw37NTyzH7BS
	aBdqpuV6vHzb8LosIfTDc3RT6Jwb0c8KwG1O0TqzVAOG7Le0pEUB01U/whb0kP8w
	BoZnITi8rZex+28NlPgkNPf15QdTyOm45HN+6XiQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm77frf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 06:59:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6076xpZP003553;
	Wed, 7 Jan 2026 06:59:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm77frc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 06:59:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6073kAk8014523;
	Wed, 7 Jan 2026 06:59:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeemyn6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 06:59:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6076xldY31588684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 06:59:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6DAF20043;
	Wed,  7 Jan 2026 06:59:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0476220040;
	Wed,  7 Jan 2026 06:59:46 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.31.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Jan 2026 06:59:45 +0000 (GMT)
Date: Wed, 7 Jan 2026 12:29:43 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>,
        libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] ext4: propagate flags to
 ext4_convert_unwritten_extents_endio()
Message-ID: <aV4EPQoHD0BMoFnf@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <25edb28eeba7bea4610b765001d562cf402f1aba.1767528171.git.ojaswin@linux.ibm.com>
 <a80035df-1c83-4602-b831-317bc00d1ed6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80035df-1c83-4602-b831-317bc00d1ed6@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdmVzxTY c=1 sm=1 tr=0 ts=695e0467 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=RtkPMCZh_aCoSh8cWEoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: R4Trad4HALUT5LnGbEBG-aEtYuE_T9hz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA0OSBTYWx0ZWRfXzKECoJyY8ztG
 ozC9jCEhkq8XgLR/ldEFUFBg75nGup5Ii4S4UcK7qNNYfqYOHh5kXY0/4KavvOmcNhIYAuDo02G
 KWr4RCV3iaNxKZvyFBulPSEo7MCY2nG4XdxiBCfPdStrVNcITk5+P9JYm89pLUe0zZCEcyT2k+8
 Ozco1rPc4Yd6wLzB/qQtjrRhG3U2w6xUg+HZm3YaZC9HDw/0QdMgAHeVAbbhPm2caO4oJBB8oY4
 Icc/rOOHAfpyW/Fvg7FaF1Q7FrIqa/2N40S2JlvPL6WlKAVoiCrx7KQIesYBLQ9xMuLJaub/QFY
 QGOUXojyGE9h7wOfqtHYlr7v4pT+2NXH722danunTDZmj/86B9+arQc5P2XjTDPORtd2QaKDzCW
 O2PB3VRW9ye2wTWyevbsVNu6lTGQSWwLHkErE/UBzYhBbVIyvKbnE+hpe9pQ1H8Qwt71z3RYwjI
 mDOA3Wvpu3ZrBrb/gww==
X-Proofpoint-ORIG-GUID: b0nlm1R6gFkZFdLLnsfb9-q3EyUFfNpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601070049

On Wed, Jan 07, 2026 at 02:33:36PM +0800, Zhang Yi wrote:
> Hi, Ojaswin!
> 
> On 1/4/2026 8:19 PM, Ojaswin Mujoo wrote:
> > Currently, callers like ext4_convert_unwritten_extents() pass
> > EXT4_EX_NOCACHE flag to avoid caching extents however this is not
> > respected by ext4_convert_unwritten_extents_endio(). Hence, modify it to
> > accept flags from the caller and to pass the flags on to other extent
> > manipulation functions it calls. This makes sure the NOCACHE flag is
> > respected throughout the code path.
> > 
> > Also, since the caller already passes METADATA_NOFAIL and CONVERT flags
> > we don't need to explicitly pass it anymore.
> 
> Thank you for the refactor! One comment below.
> 
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  fs/ext4/extents.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index 5228196f5ad4..460a70e6dae0 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -3785,7 +3785,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
> >  static struct ext4_ext_path *
> >  ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
> >  				     struct ext4_map_blocks *map,
> > -				     struct ext4_ext_path *path)
> > +				     struct ext4_ext_path *path, int flags)
> >  {
> >  	struct ext4_extent *ex;
> >  	ext4_lblk_t ee_block;
> > @@ -3802,9 +3802,6 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
> >  		  (unsigned long long)ee_block, ee_len);
> >  
> >  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> > -		int flags = EXT4_GET_BLOCKS_CONVERT |
> > -			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
> > -
> >  		path = ext4_split_convert_extents(handle, inode, map, path,
> >  						  flags, NULL);
> >  		if (IS_ERR(path))
> 
> There is another instance of ext4_find_extent() below that does not respect
> the EXT4_EX_NOCACHE flag. I think we should pass the flag as well.
> 
> Thanks,
> Yi.

Hey Yi, thanks for the review.

Yes you are right, its removed in later commits but for completeness
I'll add it there. 

Thanks,
ojaswin

> 
> > @@ -3943,7 +3940,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
> >  	/* IO end_io complete, convert the filled extent to written */
> >  	if (flags & EXT4_GET_BLOCKS_CONVERT) {
> >  		path = ext4_convert_unwritten_extents_endio(handle, inode,
> > -							    map, path);
> > +							    map, path, flags);
> >  		if (IS_ERR(path))
> >  			return path;
> >  		ext4_update_inode_fsync_trans(handle, inode, 1);
> 

