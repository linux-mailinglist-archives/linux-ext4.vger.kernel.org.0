Return-Path: <linux-ext4+bounces-9861-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7EB4A667
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 11:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0293A62DF
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED3274B4B;
	Tue,  9 Sep 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hnWBLFof"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6682367D3;
	Tue,  9 Sep 2025 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408533; cv=none; b=dAzYvU+tci+OvPSWY5lkBB0A034q6iJCjULo2NA6aozAdSvAUedBiFpNS6HkxYtY3TN5cEYQ+Y7V3HJiqoBIcvdq7lwTcM0N3UuTru/K/3t7/eLwDnt6bDQiVoGkZDlJmFRZrwQKIXg58+E0E7gI7ojCk4ULJRqZnkD3okVNIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408533; c=relaxed/simple;
	bh=b4quO5Jk3pO06FjGjvovrv6kHUZe0GWVXnMZHNKiQyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUePq7BIO6V/2/XieoT4ALLfy8cpJ17oo49nQVAaVtJHZFpvgj5j8MA1eCuXRd08wB/ZdOrum8ebPUrHiwkiq+ZClfiPNY7Baa+UYqac+/Mu/YMfBJlpNQ95Z97B0W0lqeqozJIvGqlzoqn+Keuy/3QvIwTznUjsLqbktDpBJno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hnWBLFof; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5891fIaL022908;
	Tue, 9 Sep 2025 09:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pSBwm3oYPmHXCDubKK+UDZAUcMJZjb
	c0hdRwesmkLHM=; b=hnWBLFofQDhV8zyYem4h1Zx3rlEwyvjnkdkYwuIqKz5Ef5
	PjjDaTx/Oj1DWJ+T0hAwWCbxiJYEbbPIv44oj3PvZofBx32Bv+qbFfzEAiRNyh2D
	LpHt/1b9t681Dcr/XNNDpuHN3PqYe6Gr1IQcvAlyrkrQJUkNsMvOtliOkq7oi7Gz
	in8MOhIOzlYyNBBtV3SntjXmXLUxBOC4crztQoRIgZ7LrRpiRawtY6xx0HZSQ3OD
	yUlj/hOwScN9qA4COZq0UhKsCcMfW6rRyyKtsz2IiPMhADUN8AjLDyyA1GnriZdq
	PsKRpFS2J+vlEZiH+s1fgBC9UT4mcl1DtP+r+ouw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff6q2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:01:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5898o3bl026346;
	Tue, 9 Sep 2025 09:01:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff6q2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:01:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5896fDHb010671;
	Tue, 9 Sep 2025 09:01:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smt7m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:01:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58991tac49218014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 09:01:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DD0120040;
	Tue,  9 Sep 2025 09:01:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB01D20043;
	Tue,  9 Sep 2025 09:01:52 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 09:01:52 +0000 (GMT)
Date: Tue, 9 Sep 2025 14:31:50 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 09/12] generic: Add sudden shutdown tests for multi
 block atomic writes
Message-ID: <aL_s_noWRd3rw_6m@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <2b523de842ada3ac7759cedae80485ae201d7e5d.1755849134.git.ojaswin@linux.ibm.com>
 <12281f45-c42f-4d1e-bcff-f14be46483a8@oracle.com>
 <aLsYj1tqEbH5RpAu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <674aa21b-4c47-4586-abdc-5198840fcea5@oracle.com>
 <aL_M0X9Ca8LgTIR1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <ab2ff75d-12b7-472b-897d-d929518e972a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2ff75d-12b7-472b-897d-d929518e972a@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L3AD_9JSrR1AUb2PKTQga9CSV1TzQQoB
X-Proofpoint-GUID: 0ApR6RbSs7Ew9qvd1rBXpjvC12Z1w5KL
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68bfed07 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=YvaPRFQKQf53w_G-LoUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX6CKjROy8/j24
 CteQOzaeOk05MlWiSzX5g/qdwU1d0ArcfSzMRKeHcxtwSo7gyLxshKPXR8XQJTJ8ILhUz2GJhrT
 sCoFReVISWANuZkSqjGLOUfGrYsuuPnwlez5QsfquGx0M5SELyB6Tz1KkGTKVaDxBjAOKK0nxja
 TMoogXxf/5hspezZ/TmmZSB22XkQNUD1cBC6hDXso8AoB3K6FJFzFd0uMf60FkHuSBestvbyWCg
 qfbH2mTMLMFrPnHMH+UA+rWIKkLwovDqslOQavZp9r9d2aiFbmAzBt3nmaF8IJM0NpLM2YEscmY
 KmLRhuMQp/KCPucQ5Ea8v68ytKfCzA3UnxN5tae340ccNl3Z9mTyIrklg9EbdvvNqP23PteDU4X
 Khp05I5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

On Tue, Sep 09, 2025 at 08:49:18AM +0100, John Garry wrote:
> On 09/09/2025 07:44, Ojaswin Mujoo wrote:
> > > > > > +create_mixed_mappings() {
> > > > > Is this same as patch 08/12?
> > > > I believe you mean the [D]SYNC tests, yes it is the same.
> > > then maybe factor out the test, if possible. I assume that this sort of
> > > approach is taken for xfstests.
> > > 
> > I'm not sure what you mean by factor out the*test*. We are testing
> > different things there and the only thing common in the tests is
> > creation of mixed mapping files and the check to ensure we didn't tear
> > data.
> > 
> > In case you mean to factor out the create_mixed_mappings() helper into
> > common/rc, sure I can do that but I'm unsure if at this point it would
> > be very useful for other tests.
> 
> above it was mentioned that the code in create_mixed_mappings was common, so
> that is why I suggested to factor it out. If it does not make sense, then
> fine (and don't).

Yes I mean Im unsure it will be useful for tests other than the two
tests in this patchset.

> 
> > 
> > > > > > +	local file=$1
> > > > > > +	local size_bytes=$2
> > > > > > +
> > > > > > +	echo "# Filling file $file with alternate mappings till size $size_bytes" >> $seqres.full
> > > > > > +	#Fill the file with alternate written and unwritten blocks
> > > > > > +	local off=0
> > > > > > +	local operations=("W" "U")
> > > > > > +
> > > > > > +	for ((i=0; i<$((size_bytes / blksz )); i++)); do
> > > > > > +		index=$(($i % ${#operations[@]}))
> > > > > > +		map="${operations[$index]}"
> > > > > > +
> > <...>
> 
> 
> > > > > > +	echo >> $seqres.full
> > > > > > +	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full
> > > > > what does "Starting filesize integrity test" mean?
> > > > Basically other tests already truncate the file to a higher value and
> > > > then perform the shut down test. Here we actually do append atomic
> > > > writes since we want to also stress the i_size update paths during
> > > > shutdown to ensure that doesn't cause any tearing with atomic writes.
> > > > 
> > > > I can maybe rename it to:
> > > > 
> > > > 
> > > > echo "# Starting data integrity test for atomic append writes" >> $seqres.full
> > > > 
> > > > Thanks for the review!
> > > > 
> > > It's just the name "integrity" that throws me a bit..
> > So I mean integrity as in writes are not tearing after the shutdown.
> > That's how we have worded the other sub-tests above.
> 
> you could mention "shutdown" also in the print.

Umm, do you mean something like:

 "Starting shutdown data integrity tests ..."

 Regards,
 ojaswin
> 
> Thanks!
> 

