Return-Path: <linux-ext4+bounces-667-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F69823C0D
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 07:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0706287D4B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 06:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D70018ECE;
	Thu,  4 Jan 2024 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iXBBL4OX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7396618B00;
	Thu,  4 Jan 2024 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40467dEv007812;
	Thu, 4 Jan 2024 06:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=70S7qYQKKcMn+scPYOA5e4JsLFPvqLitGESCI99G+ng=;
 b=iXBBL4OXEXfZkdUQzJvkicPrMmcqaEvh6soeaT9CJ7KghEgNeVu5J9/8coATBLeSWCSY
 k4vDTFjSVnZZXcXU3xa619v7IZqAvWf9/ls2L8udF0eZZDZZiBWYMVeLhrJuJNsPfOqP
 OywThZEXZC+Q5T2nhyiuW4AtFhhLvhmq1ZjFV3UWwLZwtvanoVgid+OPWysqnEaWXo3R
 LLTiYlXBlw4CFLezfoBgGVM/gM+4RCp03hMpGNnHmu6o9Y65QDtZ+oQBmhXSiNxfD2qe
 9A+i4WYOSULaM7vmHU6PvrjzCDigGHvqJTCt2u/e6fqLiAszkL7F1b6ofTPdurN7wCVr NA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdq4h00e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 06:08:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4045Vue6027266;
	Thu, 4 Jan 2024 06:08:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vawhtft3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 06:08:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40468GkD5178078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 06:08:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5002A20043;
	Thu,  4 Jan 2024 06:08:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A00C20040;
	Thu,  4 Jan 2024 06:08:15 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Jan 2024 06:08:15 +0000 (GMT)
Date: Thu, 4 Jan 2024 11:38:13 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Carlos Carvalho <carlos@fisica.ufpr.br>
Cc: linux-ext4@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: parity raid and ext4 get stuck in writes
Message-ID: <ZZZLTSTwP/e/9DCx@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <ZYX2AS8isUHtbMXe@fisica.ufpr.br>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYX2AS8isUHtbMXe@fisica.ufpr.br>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TvCBCLFLea5EwVNDudji_pKVo9iTMulm
X-Proofpoint-ORIG-GUID: TvCBCLFLea5EwVNDudji_pKVo9iTMulm
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=733 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040042

On Fri, Dec 22, 2023 at 05:48:01PM -0300, Carlos Carvalho wrote:
> This is finally a summary of a long standing problem. When lots of writes to
> many files are sent in a short time the kernel gets stuck and stops sending
> write requests to the disks. Sometimes it recovers and finally sends the
> modified pages to permanent storage, sometimes not and eventually other
> functions degrade and the machine crashes.
> 
> A simple way to reproduce: expand a kernel source tree, like
> xzcat linux-6.5.tar.xz | tar x -f -
> 
> With the default vm settings for dirty_background_ratio and dirty_ratio this
> will finish quickly with ~1.5GB of dirty pages in ram and ~100k inodes to be
> written and the kernel gets stuck.
> 
> The bug exists in all 6.* kernels; I've tested the latest release of all
> 6.[1-6]. However some conditions must exist for the problem to appear:
> 
> - there must be many inodes to be flushed; just many bytes in a few files don't
>   show the problem
> - it happens only with ext4 on a parity raid array
> 
> I've moved one of our arrays to xfs and everything works fine, so it's either
> specific to ext4 or xfs is not affected. When the lockup happens the flush
> kworker starts using 100% cpu permanently. I have not observed the bug in
> raid10, only in raid[56].
> 
> The problem is more easily triggered with 6.[56] but 6.1 is also affected.
> 
> Limiting dirty_bytes and dirty_background_bytes to low values reduce the
> probability of lockup, probably because the process generating writes is
> stopped before too many files are created.
 
 Hey Carlos,

 Thanks for sharing this. So as per your comment on the kernel bugzilla,
 it seems like the issue gets fixed for you with stripe=0 as well, so it
 might actually be the same issue. However, most of the people there are
 not able to replicate this in kernel before 6.5, so I'm interested in
 your statement that you see this in 6.1 as well.

 Would it possible to replicate this on 6.1 or any pre 6.5 kernel with
 some perf probes and share the report? I've added the steps to add the
 probes in pre 6.4 kernel here [1] (although it should hopefully work
 with 6.1 - 6.3 as well, since I don't think there'll be much change in
 the functions probed there). The probe would be helpful to confirm if
 the issue we see ion 6.5+ kernels and the one you are seeing in 6.1 is
 the same.

 Thanks,
 ojaswin

 [1] https://bugzilla.kernel.org/show_bug.cgi?id=217965#c36

