Return-Path: <linux-ext4+bounces-9164-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1955B0F490
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 15:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34F55803AC
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261252E8DED;
	Wed, 23 Jul 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HBiN9DQ0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF42E8895;
	Wed, 23 Jul 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278718; cv=none; b=jEGk6lrqKNrRSHffg3OcFxk5uiFKSHwfmtYbaiOap74DYvC1YaeZ0BTlIunuYT8LXBERJXOnm8ufTP1/JU7mw0EYCRYFVd4n4+pKRivyRGVwPn/id6oS7fkQ5JI0i7od2HMQ3DPsE/0RDF133UrFehYu1Zl/QDTA68rpvcfNK2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278718; c=relaxed/simple;
	bh=8KNCwUsdYcAafh9ORfLqKTBj0WUYg+Mx1qZ64FNHitc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQRPOsbsCkz2XzUKpc1KzfMQWMD0xMc7SV4bXvctXVadQFEAfSpgTibDtz/JN9F+T1CBF919PkegxF+YaEI8FAfsFdUx8M9i1XAXi3wjr48Ncl4kwyesriYHZX0wYr/lpZ21DhI6dANiWoFjHUU/5+GNKWyLCrgndUaOM1rEzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HBiN9DQ0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NB1pYj030352;
	Wed, 23 Jul 2025 13:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=OoLQgwHCwYVfc9EEWEeZn1CU5S18sg
	mBYtINjB3Z/ag=; b=HBiN9DQ0Lo7YoeuF16jPBNM8FbrHvY9HFA3wkYdgA5enU/
	D+ptjXw6YzFbNaXE51wZlFAP+n/e/7CwwFWTd34Ro052Z9MQWThsI12+HQLzEgU7
	uqEk5eHOYaR1yELI5CO4e20Jmj2tNE0ElzDW6OORiLkIUZyE9lwnjCuiRYNRNSFg
	Zk3c5E8mGH2cwIS9VIkXqB9SjmBO05rc24vkp6Ye/jDjEqSD4RvH7LHi/dM24wB+
	QIhqlc+SSnpoJbQrYqmSFqYQ6AySwidtobNdK9lFzqUu//mOoupkbY6kLc4hd8Py
	oD/xi5H93H8Wb0f9e2WeBs8Uescwpo9YTt2HlOgw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdykuy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:51:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56NDl84s006324;
	Wed, 23 Jul 2025 13:51:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdykuy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:51:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56NCTQd6005057;
	Wed, 23 Jul 2025 13:51:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8fy7f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:51:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56NDpj4n12190086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 13:51:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0AF52005A;
	Wed, 23 Jul 2025 13:51:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6497F2004B;
	Wed, 23 Jul 2025 13:51:43 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.19.8])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Jul 2025 13:51:43 +0000 (GMT)
Date: Wed, 23 Jul 2025 19:21:40 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <1e6dad5f4bdc8107e670cc0bd3ce0fccd0c9037a.1752329098.git.ojaswin@linux.ibm.com>
 <5211dff7-579b-48ea-8180-72d8c6083400@oracle.com>
 <aHkAJJkvaWYJu7gC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <b270bb66-721e-4433-adaf-fe5ae100ca6e@oracle.com>
 <aH9PwFm06n9KQ0mE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7fc0f04e-dcec-47a4-b522-eb5a8b90637c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fc0f04e-dcec-47a4-b522-eb5a8b90637c@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ce7xF2DtL-Xgt5mwwVAaUqwG3nK_9UgH
X-Authority-Analysis: v=2.4 cv=XP0wSRhE c=1 sm=1 tr=0 ts=6880e8f5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=1TsAVJmRfjqj6DXqSPIA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: KSMiHbF58cSUPyjk3QgnQvlZGS7R0a6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfX7xg42erhnv9g
 Jtub26aql13gnvL8ram/8rIWQiaKRbEeQAhYqTXkM8VfumcOkvTJjZUOeFrLywfuIYUICG/5lfq
 ft17HdmZAMteatGstujh1Ce3zP1AdLNG26FTRkXG7i5ujk/EPthasnWqeBylB1Q8LijEOJDjSIi
 4L5n2JLYA/A0zN4MsVn5+qB8yC3W6f/zqxiaPLV+s5dQ0S2DYT+9g3pJZh+lzYm5dg5ddZcotLh
 tXuglfmQiDbCCXNT70JOScRzkaHw3tNENrTej562KmQeojXmxR7WqDH1AsL8vge7yYoC2YFXJ2b
 cPV+3sc1hWXvV/yPgql6xe34tLMLFxQX4CVvUxuco28TorqZIoWNyuXcyqogohp5wUeDuu3rXA5
 FvO/nUbe8hAnS7eijNdk0wFPA2Z8VUeWiJ2Zt2OK3EwEAxXt7vw2dzPhQrF8Dl6cG6wo2IRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=510 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230117

On Wed, Jul 23, 2025 at 12:33:27PM +0100, John Garry wrote:
> On 22/07/2025 09:47, Ojaswin Mujoo wrote:
> > > > Yes, I've tested with XFS with software fallback as well. Also, tested
> > > > xfs while keeping io size as 16kb so we stress the hw paths too.
> > > so is that requirement implemented with the _require_scratch_write_atomic
> > > check?
> > No, its just something i hardcoded for that particular run. This patch
> > doesn't enforce hardware only atomic writes
> 
> If we are to test this for XFS then we need to ensure that HW atomics are
> available.

Why is that? Now with the verification step happening after writes,
software atomic writes should also pass this test since there are no
racing writes to the verify reads.

Regards,
ojaswin
> 
> Thanks,
> John

