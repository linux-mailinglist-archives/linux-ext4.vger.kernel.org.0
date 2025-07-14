Return-Path: <linux-ext4+bounces-8975-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F51B0377C
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 09:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDBD174CCB
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 07:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A322DA1B;
	Mon, 14 Jul 2025 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="czf7bsBo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC214A8E;
	Mon, 14 Jul 2025 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476535; cv=none; b=hmlnV04WQR/mjVepLmLUZnX4w2phYdHC4ejTKBWmAoo1w85HcolZsDdA3oe1ZmYG4OoE4DoLKGlWdojyhI7NT6FDlIZja45YaAIVHYxjWu7Cej1CO1rTv5AHxyQzuVl4UGXcvvIfYQjSfmzk0/4kZQMLtaTvCfdt59SvduVR53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476535; c=relaxed/simple;
	bh=UCsvEWsqM3vviJ2rOhhCdrBFRkQyWmeEbg0oQ2M53ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bmdic5xXfRJUvgMK+B3wcAfcJEUnRge2ZbtwyFcamPs9In4PxEjlVUk2yrFRgIgvDFljGY/H+WGCXVMt+5Xw/8WO5kBgW9rxB7DCtMtlIp1HxAkV2NhMSUPMeMwgJz6kX+bvBeoOoh1vgBBIngW50W5zx1jQbMNev9zZM25/PHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=czf7bsBo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DLuFOO015302;
	Mon, 14 Jul 2025 07:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DC7EoM0iRtwkKkE7+JaS9Fv3Wt2Npo
	tJAl9hljp90+U=; b=czf7bsBo5qqjQrDzk9IdEdH7TLOs85RvL0c2h4SZ7p/NmG
	EaxNTk4ApgaO6KwWwGVHCGImA0VCVFHof9rzS9B5XvHhlvYr5FJJO6eZYevpZ3vJ
	EI/QuRwvbSOzKZU9B1MCGKUHX8k2MKPqVQzm4MM9rh9MZdPoQXsIKxfEC6UO9LhJ
	6l3lJZE8TwD3zs5ZnTTVJmQybVMmle3pXVhtuAcfCs0Fae4yjeBWKoaA1MRkUnNC
	ZZhjnET6kLU4svX6aW/aLQ0Oii6Tp1H0468ueA+1DbyXQJ4AC/tAUoZ23Pgwi0B+
	VsHdocEOraA0LN+GZI0852xFSDmQpznkgeDxCaLw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufeer418-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 07:01:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56E41A3O008150;
	Mon, 14 Jul 2025 07:01:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e0cwht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 07:01:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56E71qvU59310516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 07:01:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC1AB20040;
	Mon, 14 Jul 2025 07:01:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 231592004B;
	Mon, 14 Jul 2025 07:01:20 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Jul 2025 07:01:15 +0000 (GMT)
Date: Mon, 14 Jul 2025 12:30:34 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 02/16] ext4: remove unnecessary s_mb_last_start
Message-ID: <aHSrEtFv0v7eVlpI@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-3-libaokun1@huawei.com>
 <3p5udvc7fgd73kruz563pi4dmc6vjxvszmnegyym2xhuuauw5j@sjudcmk7idht>
 <0bcfc7c6-003f-4b4d-ac65-e01308a74f3b@huawei.com>
 <mztj3kc4slq3j6gxfk77omt4tdphg55jophea2j2dw5vj5hixq@ppj5lfxz2svk>
 <c12d955b-d1d2-4e54-b972-8455d20ae637@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c12d955b-d1d2-4e54-b972-8455d20ae637@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzOSBTYWx0ZWRfX1AngeIb412lZ w4IsghDqedDzaifWQw+VEqc9CMxohWpnleRhLvl5gsxO/QlP+Ozfm53jIiaXjfaEov4kb3CWN6G +qSVzrZpgFm1wuRrvXh2mzoBCt5b6S6QaRt6hMpBbjjmvBLlq075OU9t1UjoR4H04tfvWnAVQqq
 UUzNxb5GcH8XsCRD94VOXhxmEfIoIX25hCByI6Iaro+LAwsg6BezqsayE19HYb5Alf9dI4VkcdI iEclPwmpeQ5lxf5ychzDsuaJ8KAJIIQzLntSz+Kc8SiHIQ+pG7E68j48HtGwA6AYqScBPOSV3pm ah+HZmXgcSmYR/k5ouKNwuBjhS17HCVuDI4fT3XNcgPEQk6qokjhpWoU0o7skM9cVtIPYO0IwMJ
 U1veNb4peHqRC4Bczg2Ll/EexwsVrgxF3v5B1warI8SP58kZX6RaRly5aP9ss2hvYwM2YWz9
X-Proofpoint-ORIG-GUID: oSgfntRuCE8nkZ7zUH6ZZlOk-57GnCcg
X-Authority-Analysis: v=2.4 cv=C9/pyRP+ c=1 sm=1 tr=0 ts=6874ab64 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=a7Qa-i8okvxnLpxX3EwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: oSgfntRuCE8nkZ7zUH6ZZlOk-57GnCcg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140039

On Mon, Jun 30, 2025 at 03:52:58PM +0800, Baokun Li wrote:
> On 2025/6/30 15:31, Jan Kara wrote:
> > On Mon 30-06-25 11:32:16, Baokun Li wrote:
> > > On 2025/6/28 2:15, Jan Kara wrote:
> > > > On Mon 23-06-25 15:32:50, Baokun Li wrote:
> > > > > ac->ac_g_ex.fe_start is only used in ext4_mb_find_by_goal(), but STREAM
> > > > > ALLOC is activated after ext4_mb_find_by_goal() fails, so there's no need
> > > > > to update ac->ac_g_ex.fe_start, remove the unnecessary s_mb_last_start.
> > > > > 
> > > > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > > I'd just note that ac->ac_g_ex.fe_start is also used in
> > > > ext4_mb_collect_stats() so this change may impact the statistics gathered
> > > > there. OTOH it is questionable whether we even want to account streaming
> > > > allocation as a goal hit... Anyway, I'm fine with this, I'd just mention it
> > > > in the changelog.
> > > Yes, I missed ext4_mb_collect_stats(). However, instead of explaining
> > > it in the changelog, I think it would be better to move the current
> > > s_bal_goals update to inside or after ext4_mb_find_by_goal().
> > > 
> > > Then, we could add another variable, such as s_bal_stream_goals, to
> > > represent the hit count for global goals. This kind of statistic would
> > > help us fine-tune the logic for optimizing inode goals and global goals.
> > > 
> > > What are your thoughts on this?
> > Sure that sounds good to me.
> 
> Ok, I will add a patch to implement that logic in the next version.
> 
> > 
> > > > > @@ -2849,7 +2848,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> > > > >    		/* TBD: may be hot point */
> > > > >    		spin_lock(&sbi->s_md_lock);
> > > > >    		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
> > > > > -		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
> > > > Maybe reset ac->ac_g_ex.fe_start to 0 instead of leaving it at some random
> > > > value? Just for the sake of defensive programming...
> > > > 
> > > ac->ac_g_ex.fe_start holds the inode goal's start position, not a random
> > > value. It's unused after ext4_mb_find_by_goal() (if s_bal_stream_goals is
> > > added). Thus, I see no need for further modification. We can always re-add
> > > it if future requirements change.
> > Yeah, I was imprecise. It is not a random value. But it is not an offset in
> > the group we are now setting. Therefore I'd still prefer to reset fe_start
> > to 0 (or some invalid value like -1 to catch unexpected use).
> > 
> > 								Honza
> 
> When ext4_mb_regular_allocator() fails, it might retry and get called
> again. In this scenario, we can't reliably determine if ac_g_ex has
> already been modified. Therefore, it might be more appropriate to set
> ac_g_ex.fe_start to -1 after ext4_mb_find_by_goal() fails. We can then
> skip ext4_mb_find_by_goal() when ac_g_ex.fe_start < 0.

Hmm idk if giving a sort of one-off special meaning to -1 would be right. 

How about resetting the original goal group and goal start in the retry
logic of ext4_mb_new_blocks()? Since we drop preallocations before
retrying, this way we might actually find our goal during the retry
(slim chance though but still).

Regards,
ojaswin
> 
> 
> Cheers,
> Baokun
> 

