Return-Path: <linux-ext4+bounces-12915-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BFCD2C06B
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 06:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 026F03017204
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 05:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC349343207;
	Fri, 16 Jan 2026 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iUvpnjf1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7E2C0268;
	Fri, 16 Jan 2026 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768541810; cv=none; b=aU3t9ol0KcLZqnhgrq3zzKsbvgmFQu92FHCWlzsrO7cQcj8lQgJdQONme11XdjN6kd22wl1IHpS4EW2piKtzQ8eQEETJ2qNJCKonltCCvPTjTqY0Jkzn5bValbR2dC9ieL3us7kqA+KCP2ST59To01QfIZxjryk7UMxMGNUe01g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768541810; c=relaxed/simple;
	bh=UOXhRd9VX5IIOeTCP3SNlKAvIIkjHmkJF3Gt0c0RKT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnja1yjbGCJknmEZhYAp8kR3jTWrvqGbXDpuvyGivMh20YCKON2/gl70wzZ5dNMZIDYBJS6k1c1fI29vF8ympJKcpwofcBSwNZ3EC0xcCxAgyWPfIs9n9J266ejK5s44GSvr9UdogKtshzbelo3k+tJ1/jICCAV8JQ6uM/JW0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iUvpnjf1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FMnSYe022266;
	Fri, 16 Jan 2026 05:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QR4yPzrdXr3OcvHOJOuHFsJaxrEt/w
	QGuQZXl+qdjqM=; b=iUvpnjf1TVUEc7GWewg5FmxGNLLPkf/y2akOP72FlW3q5c
	XfD4GxMJV01XzYxKRjQYPnJYlqrZFlVb1u0qDBr2jn0BqceKxrOJtq01djFXP5Ai
	QH7I3OXWECcJrvnTAMCSukZu0x5hFYSSQbrHFSQcM0Iom167QARMSbXRqHIh4Kgq
	rCz2hRe1m8C1AII1nCyfRnDXxrKqJnkaBrUlVl+/76N8oyLGKTkbEtpO6A8t/1a8
	foeClV5Xc2gHEriWVL5cJmoQ35R0GtoyaQyaGgyz1xANRlaqgY0DSdnfm+uqEvq1
	0x54LrIIGvRtVi8e/V40gWp6RPQLAUP0uZQhkhog==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9bn934k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:36:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60G5OJtb019447;
	Fri, 16 Jan 2026 05:36:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9bn9349-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:36:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60G4auS3014261;
	Fri, 16 Jan 2026 05:36:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fymd4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 05:36:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60G5aaRM15335690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 05:36:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1567020043;
	Fri, 16 Jan 2026 05:36:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3045420040;
	Fri, 16 Jan 2026 05:36:34 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.218.99])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 Jan 2026 05:36:33 +0000 (GMT)
Date: Fri, 16 Jan 2026 11:05:43 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] ext4: propagate flags to
 convert_initialized_extent()
Message-ID: <aWnOLyCeAXXCNx7-@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <d2796ad80876b78ba19ed512b2eb734449bfe62e.1768402426.git.ojaswin@linux.ibm.com>
 <bycwydde47xioeeg6ot44cpf2q5kgmkn2rjehjvejoq5dm44gh@hoe4tupvdd6n>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bycwydde47xioeeg6ot44cpf2q5kgmkn2rjehjvejoq5dm44gh@hoe4tupvdd6n>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JvH8bc4C c=1 sm=1 tr=0 ts=6969ce67 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=XxVFETIMtwVJrDCmMNIA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 4LRubz_9LiKf4nIBnEbv_Ga0ceEV1qXR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA0MSBTYWx0ZWRfX0zU/be8Wb871
 z6g/o7j0FojxGja3wnHjIo/f+t2Xm4Vh0gtZRy1ULlXJmQmXq8GmARpa2lha+PKPbRY/0L/qe9v
 EP8MC/aMa35fuQv+qQkTYBCrF+nHgGlDZSPc+6dp5xxIVV2D17UNp3OXTeMJ+4wL3oUzVEPBFgm
 /w5iGMC7lVFT+QqzJVOAvYZdMvAEaOfsy0RusHgXOIFfGTEumQywNN5q0gfPmtUIIoypV5rQa9K
 +F6wLP2yNxyCP6Bw7x35GFsFlTfquzHs9SKDbNH5M5axSeCEZZqOrKOjY77tjiHBN7EZ0kLi6SM
 CBWc8Gp0gWjpHYwuwXy9KPKTxElfKZrPA1sRF8B5WFm+2bwTqTKzS6aTk11bnk1xZG/fFykQKnp
 iVix97IjDJHW3gizAonopE5kWV3jb8gphk2LztPjhBb/1F//EkPw+8W5gAAl4UAlO6Ya1T1tGIy
 IU0EAnwxOIBvC4zXBOA==
X-Proofpoint-GUID: ZMMfDSrH8GtoWv_fC2ghFZZcjhltCQxZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601160041

On Thu, Jan 15, 2026 at 11:59:56AM +0100, Jan Kara wrote:
> On Wed 14-01-26 20:27:48, Ojaswin Mujoo wrote:
> > Currently, ext4_zero_range passes EXT4_EX_NOCACHE flag to avoid caching
> > extents however this is not respected by convert_initialized_extent().
> > Hence, modify it to accept flags from the caller and to pass the flags
> > on to other extent manipulation functions it calls. This makes
> > sure the NOCACHE flag is respected throughout the code path.
> > 
> > Also, we no longer explicitly pass CONVERT_UNWRITTEN as the caller takes
> > care of this. Account this behavior in Kunit tests as well.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> I don't see any changes in tests here as the changelog states. Otherwise it
> looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 									Honza

Oh right, I changed the design a bit but fogot to update the commit.
I'll do that, thanks!

Regards,
ojaswin


