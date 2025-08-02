Return-Path: <linux-ext4+bounces-9254-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98155B18AEF
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Aug 2025 08:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E887D188CDF8
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Aug 2025 06:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3371DDA1E;
	Sat,  2 Aug 2025 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n6m4bs4f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743CF17A30A;
	Sat,  2 Aug 2025 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754117368; cv=none; b=DdWDSE4sBDpLrkH9rW86CyD0hnqA5P6a49EhSeqtqpKqgFZHCkTdbq+BmdlYAlDig1ulY755RgIwoKD+OhVK1hVo1fG2WmWck3DyWHB8LFRTvYuYeoPeBEsV0zujUrYYhOR1dX2hLS+7TPU21NcznLRYiVg2PkikE9J2QChP4yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754117368; c=relaxed/simple;
	bh=V1YpHzZqr/JZLEnYNM01rkbOEf3tC/T7wDWkpa1ppzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoBRPH9Cq3BHw3m/Ugu5grecci9XyQxTl2q7wwl67rXojQaR7EJqVPrOK+AaZ8ExZCp4iixcf6DHn402hP6fcOOn/HYUUdJM1CTXgB0i+/dl9424+g2Aj8tHHCcPR8ZyrX/MPiApvqDEJ8DBUr1ULrlg8mmhdd683qxUat+0SsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n6m4bs4f; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5723k4JF022005;
	Sat, 2 Aug 2025 06:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iG8H/C1N4lMlgdeXB1lassnTUx/2rU
	RASJICgpfdVp8=; b=n6m4bs4fWZxY6nJjJnQ0+oEW38liPCSG22dVni4IJCc3tA
	F3z8peh5KQTlQcKY11lH+gsW3RSC2FdXPpur9Nl+J8j6/C/pUDWPGZ7yHvYBe4Ng
	N2V/V/Ihdn+Vbn+Mut3DHd3f3t9Exkr9IUUvjoEimmOIaAPmgEAWJ6G372Vxznid
	9ZPZzimYjkKJpWN/uYaL9lKrddIUo6VPDQfA6XICotwz9fDxv/OekepSJzsE2P0w
	pWUI0ngh16Y/oeaZ9utnVjwMxajygZZ7wJivNEVsU3iwAWv6sLg6+z1N1Dhc36SQ
	pVI/Qe6lODqNx0akjSn27G2B7FjN3cMbYeIpST6A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48983srve5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Aug 2025 06:49:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5726nH3N015508;
	Sat, 2 Aug 2025 06:49:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48983srve3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Aug 2025 06:49:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5723g4dL032450;
	Sat, 2 Aug 2025 06:49:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489b0j0eqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Aug 2025 06:49:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5726nENc52101410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Aug 2025 06:49:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 467B62004B;
	Sat,  2 Aug 2025 06:49:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42B0E20040;
	Sat,  2 Aug 2025 06:49:12 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.139])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  2 Aug 2025 06:49:12 +0000 (GMT)
Date: Sat, 2 Aug 2025 12:19:09 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aI205U8Afi7tALyr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
 <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <3a4854ac-75ad-4783-acbd-048fe7c7fdb0@oracle.com>
 <aIhmG-l4nWOAzz2I@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250729144526.GB2672049@frogsfrogsfrogs>
 <aIrun9794W0eZA8d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <22ccfefc-1be8-4942-ac27-c01706ef843e@oracle.com>
 <aIxhsV8heTrSH537@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <76974111-88f6-4de8-96bc-9806c6317d19@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76974111-88f6-4de8-96bc-9806c6317d19@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA1MyBTYWx0ZWRfX8CMkxRSQv68l
 8XEMTs+ID43snzHJI/6rrIvXt7rMmB2n9mnP8/pPzZlr+x5weIqjS5+jXqt55ET6xZnJAG9Zd0E
 WgCIzTeSv8om2ZeDsJQxc5b3uTSVP6ZB96+yt6ck8x4p3IjSXG826cEsv/W1qUy1mSJcrrS7ivb
 xkZY/ci5Gjbq+b/7rRAiy7zq3YauM8D6ETIFdR/ko8CZBZMW043x9PnEvz8IzTERBrTYHav3vEd
 2nglOtyF1oIrGWOfXAh0N99IpYgIbeFn7urEfY6vaiTXB8SH2OdDRYRu42+PQhIGzaVdBhUm04m
 DiLWp13ldjs6+hKPDVAqFuacPV97DJqKGS+H6zh9on2qEY7hPe0DnRSghd6jZnvZ19l0Y6/MRjP
 UwEenxRBKyJ0AxRoN32ZPz+9KpGSqf42bavTpHJGcqwxoplvurNyTn7J7qHTcvaiimHfIUNo
X-Proofpoint-GUID: 8FveycUg9qHZs-eZteskl3CHibgBl4BO
X-Proofpoint-ORIG-GUID: eJ59yteqryUWi-nSwAY09znim4LOkcCw
X-Authority-Analysis: v=2.4 cv=AZSxH2XG c=1 sm=1 tr=0 ts=688db4ed cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=sVsNyQL_5Ag_R6nxsGUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508020053

On Fri, Aug 01, 2025 at 09:23:46AM +0100, John Garry wrote:
> On 01/08/2025 07:41, Ojaswin Mujoo wrote:
> > Got it, I think I can make this test work for ext4 only but then it might
> > be more appropriate to run the fio tests directly on atomic blkdev and
> > skip the FS, since we anyways want to focus on the storage stack.
> > 
> 
> testing on ext4 will prove also that the FS and iomap behave correctly in
> that they generate a single bio per atomic write (as well as testing the
> block stack and below).

Okay, I think we are already testing those in the ext4/061 ext4/062
tests of this patchset. Just thought blkdev test might be useful to keep
in generic. Do you see a value in that or shall I just drop the generic
overlapping write tests?

Also, just for the records, ext4 passes the fio tests ONLY because we use
the same io size for all threads. If we happen to start overlapping
RWF_ATOMIC writes with different sizes that can get torn due to racing
unwritten conversion. 

> 
> > > > I'll try to check if we can modify the tests to write on non-overlapping
> > > > ranges in a file.
> > > JFYI, for testing SW-based atomic writes on XFS, I do something like this. I
> > > have multiple threads each writing to separate regions of a file or writing
> > > to separate files. I use this for power-fail testing with my RPI. Indeed, I
> > > have also being using this sort of test in qemu for shutting down the VM
> > > when fio is running - I would like to automate this, but I am not sure how
> > > yet.
> > > 
> > > Please let me know if you want further info on the fio script.
> > Got it, thanks for the insights. I was thinking of something similar now
> > where I can modify the fio files of this test to write on non
> > overlapping ranges in the same file. The only doubt i have right now is
> > that when I have eg, numjobs=10 filesize=1G, how do i ensure each job
> > writes to its own separate range and not overlap with each other.
> > 
> > I saw the offset_increment= fio options which might help, yet to try it
> > out though. If you know any better way please do share.
> 
> Yeah, so I use something like:
> --numjobs=2 --offset_align=0 --offset_increment=1M --size=1M

Got it, thanks!
ojaswin

> 
> Thanks,
> John
> 

