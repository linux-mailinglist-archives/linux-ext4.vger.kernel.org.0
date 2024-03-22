Return-Path: <linux-ext4+bounces-1730-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610B1886839
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 09:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC5C1F245E4
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6D168A8;
	Fri, 22 Mar 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hn0WYqOz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BCB8830;
	Fri, 22 Mar 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096299; cv=none; b=D6HBMM6h9YjzmgkPalLRwlZ9sHrhOEH3NU4tRYZ9VrrRyagd1ucIXXsuAaD4hdpRzqZAuW5mJxM84VcfVaBiDYrtaxsjT2yvy/DLAEtLosG0ybOQ556TOXGsK3gULu9vIFM6WgtxcLsVUrMOP5YrdN3eWFwdTMihJVBZVb/r/n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096299; c=relaxed/simple;
	bh=eHe9zDfIr5wP83EpR+ZDJ3x9229GvW/zs00EBspiMKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu/4ujT3Y5JT6l/MMnmJ1cTi9/903SaFQ+h/kIowXF3qp8TjSu2tN40x+KwKa9E2bwEYhdclvL7Gf3eEhsZ9Fb79LbiMEDmJpaxIY4BqiO8K/RkKIst/SlnznWYP/ITOeRFslHHWxlOJOMxYZ6xfoUpL7FsifXYbjqF6/YTcXYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hn0WYqOz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7FtZi030082;
	Fri, 22 Mar 2024 08:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+q4qti6zuThwqHyOnyddfu8tq7886ArbT3m1RqvkUrs=;
 b=hn0WYqOzHa2rGTYLcjwT1rS/1/ur6GiT0I4FthlhgwVQgSiBAJIQB9IIs6KlcagybXyH
 Mjt9ukiXeG++SUwIxliVtzfZFvQgTS/CQgcXfW/MFAE/SRVk5cG4dr1QWvM69tudKWnf
 7rJhJCAOsOdXtVQqLSxeea555XjjeG8+KVGii1WJ/kaqFdsKYl5nm2cw+wbmZsmTblze
 VVF9iJUNeZx0u19ZOShJ+ztI4wR0J3QfuDReqY+le9IWutRLzU4Iu+HjdiVpA22EF72P
 7nERD6hykq8czCYpoZgIqVYm44Bsb1I68EJ+WmyNg8GuJcuSfDCP69mQdnl9Ft9Uq1JN wA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x155w067f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 08:31:28 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42M8VR1B002551;
	Fri, 22 Mar 2024 08:31:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x155w067a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 08:31:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42M5TH5g023286;
	Fri, 22 Mar 2024 08:31:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x0x14jjgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 08:31:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42M8VM8l45941242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 08:31:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39CC720049;
	Fri, 22 Mar 2024 08:31:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2704620040;
	Fri, 22 Mar 2024 08:31:20 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.0.231])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 22 Mar 2024 08:31:19 +0000 (GMT)
Date: Fri, 22 Mar 2024 14:01:17 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, glandvador@yahoo.com, bugzilla@eyal.emu.id.au,
        kernel-team@cloudflare.com
Subject: Re: [PATCH 0/1] Fix for recent bugzilla reports related to long
 halts during block allocation
Message-ID: <Zf1B1cPj/aO21pjZ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1702455010.git.ojaswin@linux.ibm.com>
 <170476879011.637731.13228432208887255974.b4-ty@mit.edu>
 <ZfsUaicHDpOtkkVv@CMGLRV3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfsUaicHDpOtkkVv@CMGLRV3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pDfVLUMb_l8o_s8_IasYDkMP05vUFJax
X-Proofpoint-GUID: XiPpAx2Lj5o9BGRQ5rb7wowVYbOfMA0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220061

On Wed, Mar 20, 2024 at 11:52:58AM -0500, Frederick Lawler wrote:
> Hi Theodore and Ojaswin,
> 
> On Mon, Jan 08, 2024 at 09:53:18PM -0500, Theodore Ts'o wrote:
> > 
> > On Fri, 15 Dec 2023 16:49:49 +0530, Ojaswin Mujoo wrote:
> > > This patch intends to fix the recent bugzilla [1] report where the
> > > kworker flush thread seemed to be taking 100% CPU utilizationa and was
> > > slowing down the whole system. The backtrace indicated that we were
> > > stuck in mballoc allocation path. The issue was only seen kernel 6.5+
> > > and when ext4 was mounted with -o stripe (or stripe option was
> > > implicitly added due us mkfs flags used).
> > > 
> > > [...]
> > 
> > Applied, thanks!
> 
> I backported this patch to at least 6.6 and tested on our fleet of
> software RAID 0 NVME SSD nodes. This change worked very nicely
> for us. We're interested in backporting this to at least 6.6.
> 
> I tried looking at xfstests, and didn't really see a good match
> (user error?) to validate the fix via that. So I'm a little unclear what
> the path forward here is.
> 
> Although we experienced this issue in 6.1, I didn't backport to 6.1 and
> test to verify this also works there, however, setting stripe to 0 did in
> the 6.1 case.
> 
> Best,
> Fred

Hi Fred,

If I understand correctly, you are looking for a test case which you
could use to confirm if the issue exists and if the backport is solving
it, right?

Actually, I was never able to replicate this at my end so I had to rely
on people hitting the bug to confirm if it works. I did set out to write
a testcase that could help us reliably replicate this issue but it needs
a very specially crafted FS that is a bit difficult to achieve from user
space. I was using debugfs to create an FS that could hit it but I kept 
running into issues where it won't mount etc. Maybe there's a better 
way to craft such an FS that I'm not aware of.

One more option is that maybe we can have KUnit test for this in the
mballoc code but I'd need to read some more about the kunit
infrastructure to see if it's possible/feasible.

Regards,
ojaswin
> 
> > 
> > [1/1] ext4: fallback to complex scan if aligned scan doesn't work
> >       commit: a26b6faf7f1c9c1ba6edb3fea9d1390201f2ed50
> > 
> > Best regards,
> > -- 
> > Theodore Ts'o <tytso@mit.edu>

