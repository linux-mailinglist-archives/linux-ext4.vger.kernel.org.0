Return-Path: <linux-ext4+bounces-6775-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC2CA5DEF4
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 15:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0D17AD8E5
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD9224E009;
	Wed, 12 Mar 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DxScmDzI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9D645;
	Wed, 12 Mar 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789697; cv=none; b=ewPnkHoob8wwNvQ3pzLvGSWCb0E+UAMWdu9EdVtr0aSF8zuyq6KYG4vcVRlzIYFsSfWTrRgu0C1qXeD3r4OSi3FJocFuXIl+Yp9Kl4vp/oIOiu58E/6pOEeKGURvlhCKXR5+YAvey/98Z9w+M2oSGCOW+osp3IBgr9wEZzN8coc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789697; c=relaxed/simple;
	bh=Tj20qUq8bit/VqfZHgFjjOgayyDULNQIOkxhiVTBaRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdXMi2nNvkaIEeZPBptGxvhkD5plpp4EjJ8/Meb4CA9S5WfrYrQg+6XLP4AJixCyCagWbwjk3arV3speKjS8MmjqH0cE8OiiJzlyyq7ut5F/ypzYLTeyvm4Zi6mIzeKx7gUJRa8fUNmB9wgVplrkJjhgNpFwM9NjRZ1t3VnM+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DxScmDzI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCdoaD002782;
	Wed, 12 Mar 2025 14:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=v4RhvKiukPVyZq0Mn6aqODJLsEcOHi
	w+q2IJ3sXgsN8=; b=DxScmDzIVLzg+qCSmb4aFaJlgx5ZTu1u4u4345AURyW7Up
	ceuGgoLUVdGXL/aH4vtB9eikG6iWnN0hLQp/2Ogp6DKGiVD3I2tUHS8+3B9QmavM
	3FafbDksx2wrNxQ648+u+c2DOyYeJ8EFC9D9XZOnKqUyzMI113XYYcf8DTUfg0uv
	9VYm6/NRYXfb1z5it6WlgPxN5ISa1i9JxrlVJK1MWrmA5/1lgNaNufn19nLqvhzk
	43rxvTWTt+jY6JMzK4BY1koaIAPmEMtSKKxr2llLgl/5ySQLVSCWwRESuYrOOYGj
	GjLKMANWvc+R0/fZpefWaskD2jqFJkwML2myNNmA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avbpmbfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 14:28:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52CES6gW000304;
	Wed, 12 Mar 2025 14:28:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avbpmbfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 14:28:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CDfCBQ026099;
	Wed, 12 Mar 2025 14:28:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspcj0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 14:28:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CES1F032309846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 14:28:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 371BC2004B;
	Wed, 12 Mar 2025 14:28:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CDB320040;
	Wed, 12 Mar 2025 14:27:59 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.21.67])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Mar 2025 14:27:59 +0000 (GMT)
Date: Wed, 12 Mar 2025 19:57:56 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <Z9GZ7PPWtJLSj6Ms@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
 <ad999fb3-51a5-4a76-9783-cf2053c031c1@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad999fb3-51a5-4a76-9783-cf2053c031c1@sandeen.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LisqaVmYgirQrrcfxWd2q_Cdf5ACr_vV
X-Proofpoint-GUID: ELQpwQ6OdetDghZfQnwWk4xzqf2KQD9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxlogscore=899 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120100

On Wed, Mar 12, 2025 at 08:57:34AM -0500, Eric Sandeen wrote:
> On 3/6/25 8:28 AM, Ojaswin Mujoo wrote:
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 2b7d781bfcad..d48e93bd5690 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
> >  	 */
> >  	struct work_struct s_sb_upd_work;
> >  
> > +	bool s_journal_destorying;
> 
> Just a late nitpick and noted that Jan suggested making this a flag,
> but just in case, this is a typo: s_journal_destorying -> s_journal_destroying
> 
> Thanks,
> -Eric

Thanks for pointing that Eric. We will be moving to a flag in next
version mostly so we should be okay :)

regards,
ojaswin

> 
> >  	/* Atomic write unit values in bytes */
> >  	unsigned int s_awu_min;
> >  	unsigned int s_awu_max;
> 

