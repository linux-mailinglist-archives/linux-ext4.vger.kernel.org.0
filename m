Return-Path: <linux-ext4+bounces-3613-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872719463FB
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 21:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBA12830D6
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 19:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C40A49647;
	Fri,  2 Aug 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pOZ3VEGC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8191ABEAF;
	Fri,  2 Aug 2024 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627396; cv=none; b=TFy97L8tqlodn9aPCj9pU00oH8zMTPQt2D2w07NkHVng3Z/WKsERs0t4MhWDcv3/CWWBX0K9wwLX2ceJx1vjVpXDycZ/0uC5rlKiOemWRrkXAUyAgxd1xTQqqo5qvYhu1rlpS95pK6CwfG8+LSz/X9sTbK3X6BWjG+4WsxlgQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627396; c=relaxed/simple;
	bh=tat7IrpbzGY/dRqGubQuEh5c+sIi/kaW0Q3iK0behoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qc1eMlAt2HFXkyXzKu1P7RLB1u5UkFplaaF8w9g9ReHF9PsiBzYZMFTC1Yh8RUliFjioCYiXodLO+PXX4/AylkLlpINE/6YZtuhNeJiToFdVaApG9v/i8eMXIRCW/dpS3bELv7tMM2kHYk0hw6uXi9v0XKaYyeydP74hju5U940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pOZ3VEGC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472GKJVe011741;
	Fri, 2 Aug 2024 19:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=y7OYLE7Iz7z0M0wcL1th0g8oFXT
	Lvth0t1mYUhhz9Es=; b=pOZ3VEGCn775ro+SuOj1WETH4Xp9VEqjvud9nURGDAm
	jL82qPlFHEQRM+9mCrznvrwCAvLo0U0BHNSE1STn9M+QaSq+gdZCSCX87ksWMJMq
	GHaHuuE8Bo7+borGYmu9xeMliW4ZZdGY5ZtxBaUDxWs1XC/UVVxAEPcMcIlBP7z/
	UFhyjwzwdTI8A8LMCmgg8oSAOiw8vnSnbAFJM6P/CEy+iMwIIDMeOOZi/tUgFhEf
	rrJk8x6WNIY/E28iPoQx2SDw0WRe4Asj3UWhifT0t4sHTilX6gNnpy7C7SMys0pT
	B2AzrTTScgC4fPJOEpyh/C5FK67daDBXpYvxNJHUi2A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rwqws5dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 19:36:31 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472JaV7K018087;
	Fri, 2 Aug 2024 19:36:31 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rwqws5dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 19:36:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472JUQIX003857;
	Fri, 2 Aug 2024 19:36:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nden0htu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 19:36:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472JaQCE53084418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 19:36:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D362B2004E;
	Fri,  2 Aug 2024 19:36:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7C882004B;
	Fri,  2 Aug 2024 19:36:25 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.209])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 19:36:25 +0000 (GMT)
Date: Sat, 3 Aug 2024 01:06:23 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Max Schulze <max.schulze@online.de>
Cc: linux-btrace@vger.kernel.org, axboe@kernel.dk, linux-ext4@vger.kernel.org
Subject: Re: Understanding blktrace; measuring extra writes on ext4 with
 open(...,O_DSNYC | O_TRUNC)
Message-ID: <Zq01Nx8SyhoY0/R7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <87a26aff-78b4-4e87-9c83-8239d238b381@online.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a26aff-78b4-4e87-9c83-8239d238b381@online.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mn59R4TeaFZc1WwEZ78OYOfA8Z9Qbi0p
X-Proofpoint-GUID: lWglSSAbv0cTKF1mi6FMKP4rP-JNCYvG
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_15,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=916 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408020135

On Fri, Aug 02, 2024 at 10:28:47AM +0200, Max Schulze wrote:
> Hello,
> 
> so I have an embedded application with limited flash write cycles. I am writing 2 blocks to disk 5 times a second (ext4, block size 1024).
> The data written is binary and fixed size and to date I open the files with (O_CREAT | O_WRONLY | O_DSYNC | O_TRUNC).
> 
> I set out to measure whether this O_TRUNC leads to an extra write (because I might be able to do without - data is fixed size) and understand the linux tooling around for inspection.
> 
> I wrote a test script, that creates a 2MB ext4 file system on a separate block device, so I can trace with blktrace -d /dev/sdc
> 
> If somebody please could have a look if the interpretation of the traces is correct and what the missing identifiers are.
> 
> 
> Below is the output from blkparse for the moments where I write with open (DSYNC | TRUNC)
> 
> >
> >   8,32   2      152     8.831293895 22900  C RAM 2060 + 2 [0]             <-- previous _C_omplete
> >   8,32  10        2     9.245982628 14449  D   N 0 [kworker/u40:2]        <-- D =issued
> >   8,32   2      153     9.246369033 22900  C   N [0]                      <-- C_omplete
> >   8,32   0      200     9.268019255 15706  A  RM 2062 + 2 <- (8,33) 14    <-- A = remap
> >   8,32   0      201     9.268020922 15706  Q  RM 2062 + 2 [writerdt]      <-- Queued
> >   8,32   0      202     9.268034745 15706  G  RM 2062 + 2 [writerdt]      <-- Get = allocate Req.
> >   8,32   0      203     9.268051167 15706  I  RM 2062 + 2 [writerdt]      <-- I_nserted in Queue
> >   8,32   0      204     9.268107127   161  D  RM 2062 + 2 [kworker/0:1H]  <-- D issued "R"ead
> >   8,32   2      154     9.268704050 22900  C  RM 2062 + 2 [0]
> >   8,32   0      205     9.268881750 15706  A  WS 2160 + 2 <- (8,33) 112
> >   8,32   0      206     9.268882510 15706  Q  WS 2160 + 2 [writerdt]
> >   8,32   0      207     9.268890935 15706  G  WS 2160 + 2 [writerdt]
> >   8,32   0      208     9.268891685 15706  P   N [writerdt]
> >   8,32   0      209     9.268892510 15706  U   N [writerdt] 1
> >   8,32   0      210     9.268895672 15706  I  WS 2160 + 2 [writerdt]
> >   8,32   0      211     9.268913234 15706  D  WS 2160 + 2 [writerdt]      <-- D issued "W"rite "S"ynchronous
> >   8,32   2      155     9.271009859 22900  C  WS 2160 + 2 [0]
> >   8,32   0      212     9.271041534 15706  A WSM 2126 + 2 <- (8,33) 78
> >   8,32   0      213     9.271041910 15706  Q WSM 2126 + 2 [writerdt]
> >   8,32   0      214     9.271051615 15706  G WSM 2126 + 2 [writerdt]
> >   8,32   0      215     9.271053774 15706  I WSM 2126 + 2 [writerdt]
> >   8,32   0      216     9.271075678   161  D WSM 2126 + 2 [kworker/0:1H]  <-- D issued "W"rite "S"ynchronous
> >   8,32   2      156     9.273122709 22900  C WSM 2126 + 2 [0]
> >   8,32   4       67    10.277429577 13420  A  WM 2050 + 2 <- (8,33) 2
> 
> 
> -> What are M and N in the "rwbs" field? I could not find this in the manpage.

Hey Max,

I had the same confusion sometime back and had to dig in the kernel
code. All the rwbs values the latest kernel supports can be found
in this function [1].

So 'M' is added for metadata requests eg when FS is reading some
metadata blocks. 'N' is added when the request is neither
read/write/discard etc. I'm not sure what kind of IO results in N though
so maybe someone else might be able to add to this.

[1]
https://github.com/torvalds/linux/blob/master/kernel/trace/blktrace.c#L1875

(I'll try to go through the trace you provided when i find some time and
update here)

Regards,
ojaswin

