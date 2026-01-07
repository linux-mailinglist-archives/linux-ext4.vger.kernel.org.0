Return-Path: <linux-ext4+bounces-12605-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7745CFC4D4
	for <lists+linux-ext4@lfdr.de>; Wed, 07 Jan 2026 08:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B8D83029C30
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jan 2026 07:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D53261B8A;
	Wed,  7 Jan 2026 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tvh1e162"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B675B1FBEA8;
	Wed,  7 Jan 2026 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770381; cv=none; b=MmAwsCFPR9OCpFVlxP4Ovj5neS5aMu0udwnupp+bGdz98WlGXemHJPDGPUaSgtfVSm8tyltI2Bn34lXfD0DK3gSCoMSw1RHj/udrVLK9WW2TjWcS1miiCIufbSMIhoIXBm/jlMW6klZ3P/KbSVvweKFpyZU9zoPRXedHjo7McFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770381; c=relaxed/simple;
	bh=usXX+jbE+7tSLQxByBoByQ1yErt20JK0LjdJRBeDDZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0ganx8dskdzZZALvYyIIYe9+oOPRnH5zk9mWgSeBD/LWEz6ZbSFzk0BdmJpqPiUAtHH/TayTfUT3Qwl42//LvVzXTLChfyUwscqNaDFaYClIYGeJDnR24ZLbVZNJqI/wxM178ME3NSv5tZnXUFo7nHMVyH/cjzApHTRymsaTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tvh1e162; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606JJVEm026728;
	Wed, 7 Jan 2026 07:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=s27Ca3/t6Iy0t1ZIsERMz0fYl+Gaky
	oOMRi4ggbV98o=; b=Tvh1e162NRULN0srCRI4Fs5acVW9+jrhfPrdAyBfXXdFtN
	IPqzvTpQxCVV4+qJngbB0+qY1qFH0sgMk8pY/2fR/wpcCCjqDDuKkgjmg8SYK/07
	Ub8B2LzmzoOs9Qq+06s1VhKpBh+UStn58G3Rz0Ns1ZMHG9AZheNVM7nDbGfscSc9
	Ymru8LvR76X8ivYCY+eEf9COj+dhmGqOIg7pjmCrxagbuLX+w4k1b9veicwfHOmS
	UixOu0jeviAZk4EJz6Q0Aa7aBZIhTRzZser1nJG5cE2oOllY0reheqji2DfYC3KX
	UF3qix0iD4yrIaZGdedgWoPBPHwakRLbGcja/jng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm77jet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 07:19:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60778ble022347;
	Wed, 7 Jan 2026 07:19:28 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm77jeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 07:19:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6075EQKw019154;
	Wed, 7 Jan 2026 07:19:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg517epx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 07:19:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6077JQQw31588666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 07:19:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 211C12004B;
	Wed,  7 Jan 2026 07:19:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4610920043;
	Wed,  7 Jan 2026 07:19:24 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.31.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Jan 2026 07:19:24 +0000 (GMT)
Date: Wed, 7 Jan 2026 12:49:21 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] ext4: propagate flags to convert_initialized_extent()
Message-ID: <aV4I-TiTi_McQ3uM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <a8078155d7d97e0fcaae1c576112033c84968aec.1767528171.git.ojaswin@linux.ibm.com>
 <dibws2hdldmuefxvotoeo2gitzxie6oc6uinfl33fh73jizh2w@t3us4sfqcb7l>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dibws2hdldmuefxvotoeo2gitzxie6oc6uinfl33fh73jizh2w@t3us4sfqcb7l>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdmVzxTY c=1 sm=1 tr=0 ts=695e0901 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=oCizLOX1Ic_CH96QbJ0A:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: HmIXUavcuGYoZfo6NuJ8GyBlZJe4GB3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA1NyBTYWx0ZWRfX6PEa/UUYt5Y/
 w4KxJzpqEzc9VBVndJ0Dv4yO6GrflEtrMwzzKonzSbUOYKCFzvgLnxH1Qf3qxCOrBdE13hx4Z2L
 mJLFGhzQZVy8Iq//tmk7YEpjHk4m2qa20DLB6GWZMFM4WyG4RElUdiFZ92ulpQvlZPfNiECJ7qM
 UveyDQPlPA9VPQXnyufw/khVmhd4/JYoIY9QMzXju1E20NIR8WxSICECIxFSW6Z32kIV1+6mVyH
 QLphz6ML/oWVF35u25AN077tR/x0kIa7XusxvgYeY31oOvEuBLn3+VQc7wAIDwnthiDw0Z7G7uZ
 WQM5zzh7W+dHp5yXPw1FP2MQSyGLQeONqYScaHrKEA+M0atgjCLMQJW3vEu1Aw3aa7lD9q2U1c+
 q72/XOCi2r8Satb49u1Fl1M3Rj+/dymNvbunyhlO3iqV3pqx9valn6nHHmb+KgmSByAVVUuX0ZJ
 7Yv3n022QqSSX9bSfCw==
X-Proofpoint-ORIG-GUID: FDvv45gaGalmWpn-LT9ufagAxC-Jyk3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601070057

On Tue, Jan 06, 2026 at 03:33:07PM +0100, Jan Kara wrote:
> On Sun 04-01-26 17:49:16, Ojaswin Mujoo wrote:
> > Currently, ext4_zero_range passes EXT4_EX_NOCACHE flag to avoid caching
> > extents however this is not respected by convert_initialized_extent().
> > Hence, modify it to accept flags from the caller and to pass the flags
> > on to other extent manipulation functions it calls. This makes
> > sure the NOCACHE flag is respected throughout the code path.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  fs/ext4/extents-test.c | 2 +-
> >  fs/ext4/extents.c      | 5 +++--
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
> > index 4fb94d3c8a1e..54aed3eabfe2 100644
> > --- a/fs/ext4/extents-test.c
> > +++ b/fs/ext4/extents-test.c
> > @@ -422,7 +422,7 @@ static void test_convert_initialized(struct kunit *test)
> >  
> >  	map.m_lblk = param->split_map.m_lblk;
> >  	map.m_len = param->split_map.m_len;
> > -	convert_initialized_extent(NULL, inode, &map, path, &allocated);
> > +	convert_initialized_extent(NULL, inode, &map, path, 0, &allocated);
> >  
> >  	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
> >  	ex = path->p_ext;
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index 0ad0a9f2e3d4..5228196f5ad4 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -3845,6 +3845,7 @@ static struct ext4_ext_path *
> >  convert_initialized_extent(handle_t *handle, struct inode *inode,
> >  			   struct ext4_map_blocks *map,
> >  			   struct ext4_ext_path *path,
> > +			   int flags,
> >  			   unsigned int *allocated)
> >  {
> >  	struct ext4_extent *ex;
> > @@ -3870,7 +3871,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
> >  
> >  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> >  		path = ext4_split_convert_extents(handle, inode, map, path,
> > -				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> > +				flags | EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> 
> No need to keep EXT4_GET_BLOCKS_CONVERT_UNWRITTEN here as the caller has
> it in flags already? Otherwise the patch looks good.

Hi Jan,

Right, I'll make this change in v2.

Thanks again!
Ojaswin

> 
> 								Honza
> 
> >  		if (IS_ERR(path))
> >  			return path;
> >  
> > @@ -4264,7 +4265,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
> >  			if ((!ext4_ext_is_unwritten(ex)) &&
> >  			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
> >  				path = convert_initialized_extent(handle,
> > -					inode, map, path, &allocated);
> > +					inode, map, path, flags, &allocated);
> >  				if (IS_ERR(path))
> >  					err = PTR_ERR(path);
> >  				goto out;
> > -- 
> > 2.51.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

