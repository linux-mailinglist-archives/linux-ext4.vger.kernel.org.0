Return-Path: <linux-ext4+bounces-9878-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF17B4AC9D
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 13:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27C63A95CC
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB722322DA8;
	Tue,  9 Sep 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AoNor/uw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18C31CA43;
	Tue,  9 Sep 2025 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418240; cv=none; b=ma8GBLzhcUm6ZGkul7nOSR5GM80K+PSCzESK30ynnYcTsh7s1tsSpcLiUwg2C8nD0zuliQ6P7ztf3zhSeSWiYa4+D4DRJHNiHYCea3W44gXYK0WOu/0LMVB5jREmy0nIocThH5vndTZtXm4P4/zzGykXEZHKVHEemxkJBDm0lI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418240; c=relaxed/simple;
	bh=bzYW/2+6ziQYO/MhfFB8b91odp8h4JDkOKF1y8eNN/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huZreNJgPliq8oRFfQ80KrciHgh48Kw5jZ5iBtO/K0SXsBu+PBLp9nNiYPgomJ5yyM726WBGCNuwHmtVU1+Aa8spWg/8+p0JBewrG/CHk5KY3DAY6i73EuyWUs3IqMWVOfuh5sLuyTvPQVv/PpK49w9U1J8pDvBJiOhcJRg54Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AoNor/uw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58983e6L007450;
	Tue, 9 Sep 2025 11:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DDS150b9tFWsg5idldMaLWjPQsOUmj
	jRGObpNZw9oaY=; b=AoNor/uwwrRMpNedQcipDoAB5APcAEYurQ0wF//WiYT/hf
	v9ZAPyfP0apkN0gci8MYevw7nciayx991n3abwLBBVH96GWeognXlKAHUy5wgl9a
	UTTj8Labja86Fc2L+GZp4Seq8RVHjSOWDTdz0kbF6lOQp2Kfmot4lTcfeOagwI1n
	oLHjTcnXqOK1RoPYrJHrmQRzV0Xc6lpJCAFWrrTzkNgYFGmuaMpC1IzEIyMEdNn/
	SwNlaQO1aIy8MoC/cXG+jMhcqUl1XLPiiIJ33R1e3aobZ9mUbUvRr5qXjFDsOpUY
	n/ElBcfKDgep4a+xRhG/i8D6exRNTzGiKXR5YpZA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukecm5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:43:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 589BhqLs006948;
	Tue, 9 Sep 2025 11:43:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukecm5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:43:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5899vVcH010604;
	Tue, 9 Sep 2025 11:43:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smttyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:43:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589BhnZK18874694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 11:43:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 780F720043;
	Tue,  9 Sep 2025 11:43:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3245D20040;
	Tue,  9 Sep 2025 11:43:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 11:43:46 +0000 (GMT)
Date: Tue, 9 Sep 2025 17:13:44 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 09/12] generic: Add sudden shutdown tests for multi
 block atomic writes
Message-ID: <aMAS8CR3taSIpmYa@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <2b523de842ada3ac7759cedae80485ae201d7e5d.1755849134.git.ojaswin@linux.ibm.com>
 <12281f45-c42f-4d1e-bcff-f14be46483a8@oracle.com>
 <aLsYj1tqEbH5RpAu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <674aa21b-4c47-4586-abdc-5198840fcea5@oracle.com>
 <aL_M0X9Ca8LgTIR1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <ab2ff75d-12b7-472b-897d-d929518e972a@oracle.com>
 <aL_s_noWRd3rw_6m@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <d9ca22fb-f833-422d-8214-44117aecd68d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ca22fb-f833-422d-8214-44117aecd68d@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfXyU+kCtzU5VA4
 zu1yQ7pb6MByzCGXxnwwkzefzz8lfZWpVd0FR2UULbexU8II0OhxwWgnPPO00+bIfNgPVveExAn
 UPPzR7zco6JTO0S6d9lhM0qviL59CVPuZ1N0SYMURTfv9SE11yDHRKABM/uZo4sPQuUZCEExqzi
 2SbTPupTPO2yBJLojtsmkh8/ebW1Twf4DbKhfl3QmHNGk9DujkZZIAGFmOBYMkA6PfVEDZNk7lT
 NiwGEMNJXVMF5UONVanYtqc6LQuprFrhycMDmUQKb+A46OHmnot9FQwiiuxBEorw9luhFlBHbyt
 pW3SZNeewoP/HCR4HmWbQ8F8wgws/oY7Y+Sn8at9JOKIa4d61DviqpGHo2St0n+MJfO949wGNPY
 WUtT5ZcI
X-Proofpoint-ORIG-GUID: dqJzIXnISoWsGc_c-1qEQkxNDKejV1G2
X-Proofpoint-GUID: ltIWUq0aJiGhmh20SNXsNlZb1qKhRWQt
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c012f8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=tf6MFKNmIk4QXj8bDuIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

On Tue, Sep 09, 2025 at 10:04:09AM +0100, John Garry wrote:
> On 09/09/2025 10:01, Ojaswin Mujoo wrote:
> > > you could mention "shutdown" also in the print.
> > Umm, do you mean something like:
> > 
> >   "Starting shutdown data integrity tests ..."
> 
> yes :)

Sure, will do thanks!

