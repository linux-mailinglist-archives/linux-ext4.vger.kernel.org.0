Return-Path: <linux-ext4+bounces-9204-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8978B13B92
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 15:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A3D189B993
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922A12673AF;
	Mon, 28 Jul 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NTLOSU8N"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E01E379B;
	Mon, 28 Jul 2025 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709746; cv=none; b=KXtsuFQNCZSff4CrAMjA9T8iwyDjHS0QkvhtczfeU81njdiPkNDO60UYZI5Y0rXr0otVa2k5alYYOt2GNF9JG+NAXlawu4FRZWGxpgG0VCFJ7pk18JtBeW3iNQfmPaVwHOrGfXln/agD6xFXMfx34JTigb5jC5rv3kTRZy13ePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709746; c=relaxed/simple;
	bh=N27HXBEzvQXtZkUG2ThJBE42npuQlTJWfiCf1fMZL2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa6AvX/6mb3PxhRSSyEUmH8/w53kIl0jfLl2RLOPeHez295TEijm8MsdFdX8PxNTQd+i0NEB02EdTzsqyBgS7V3jfkSAh1FYAFvUofUkIv7vlWj0TSL9/H5VdZ8aYikdLjGodvPsffXqODNUIiZ1xZD/xWa61CCDiBkuOI1e/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NTLOSU8N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S6uS4Z028623;
	Mon, 28 Jul 2025 13:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5vWPhuadNCO0vBQG5RokFgmoB0VxYq
	gq1a/XnaHMcJM=; b=NTLOSU8NaPDqMP9WIu+kBypn7u+Fz0PaLWMMiXn5u0IsVF
	RYRHtQ2PXFZP0P7lY+0PQDLMv3M/NoFNEN8tk4isE/Y2tlykw+sXp5pOkmjnLSvP
	zed8o4hy0+aKV8HT+JzeqO2xXgF2mgs6aBtgVYUNP0XBtHllO4iyBUMjq5J5HSWG
	67/7CZvXb1Tdm7NHF8eOCr7QGBX7SG4cmN/ATGemy6y6kVU3ajLJ1e4Vl931FZg5
	cjGDMLKh1/UQQ3mG5QNkUjHKorF0W77t4ogrpEKb0nQTNV4L3sIWLcrsy7U8HRZ/
	1K5d040pmW6mcf+ATIrUc1BTLLZVVOAAfDBTkZaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqh8pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 13:35:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56SDTSPB016926;
	Mon, 28 Jul 2025 13:35:37 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqh8pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 13:35:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56S9XBcZ017944;
	Mon, 28 Jul 2025 13:35:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859bte4tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 13:35:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56SDZYn240829352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 13:35:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FE882004B;
	Mon, 28 Jul 2025 13:35:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1213520040;
	Mon, 28 Jul 2025 13:35:32 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.198])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Jul 2025 13:35:31 +0000 (GMT)
Date: Mon, 28 Jul 2025 19:05:29 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aHkAJJkvaWYJu7gC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <b270bb66-721e-4433-adaf-fe5ae100ca6e@oracle.com>
 <aH9PwFm06n9KQ0mE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7fc0f04e-dcec-47a4-b522-eb5a8b90637c@oracle.com>
 <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
 <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
 <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5NyBTYWx0ZWRfX8FHSpQB0fPSe
 DW67Q79P5q7EcHq99sM0pQ+lf7QbK/9hJdAQ+WtYbQ1P+S0mL5uw9O/gHMZKqHETj4YFJ1NNFC1
 gU2qc1DK8sLOsgJTOiagm71t3Lgi04oiYl41RECaVnrcRMr9E+C2KsHPiVcfXwxJNbcx/qWkD+r
 8GleRJ8bWR/VGU5VPsmZzWfFh4YhRIHmsd9fEwDjKbbxqKJM8ZQWdB0/ICbaeX0YFT+yhf5a2Yo
 OmWvIO6i9g6UAZqS0cH+YSa8ngFdGxEoVvZGVzzPZYkntGMyO0pDjkh9SgmN7wsozGrEkcRkW20
 fq+0sVZsgcmbqJU7Re1CoGnT720bZNkPsTp4vW6RvDqBdPjnw0fe257+gotMCI+RZAe5EEIJgJ1
 aMjT9i6LDTEMVT5O6tmItMBFrjOeNm4msvO0+HyhNGsGS9kUXAwSVmxiKuA1MgV/ih4wlZif
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=68877ca9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=BC5zkRbKPiWmCkXho8YA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: eZSxbq1WPG1OrXLSjOB1sztUpmiQnvPH
X-Proofpoint-ORIG-GUID: agxN6CJ_XmFFj5Jlza3316IEkBaaMAAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280097

On Mon, Jul 28, 2025 at 10:09:47AM +0100, John Garry wrote:
> On 28/07/2025 07:43, Ojaswin Mujoo wrote:
> > > > What do you mean by not safe?
> > > Multiple threads issuing atomic writes may trample over one another.
> > > 
> > > It is due to the steps used to issue an atomic write in xfs by software
> > > method. Here we do 3x steps:
> > > a. allocate blocks for out-of-place write
> > > b. do write in those blocks
> > > c. atomically update extent mapping.
> > > 
> > > In this, threads wanting to atomic write to the same address will use the
> > > new blocks and can trample over one another before we atomically update the
> > > mapping.
> > So iiuc, w/ software fallback, a thread atomically writing to a range
> > will use a new block A. Another parallel thread trying to atomically
> > write to the same range will also use A, and there is no serialization
> > b/w the 2 so A could end up with a mix of data from both threads.
> 
> right
> 
> > 
> > If this is true, aren't we violating the atomic guarantees. Nothing
> > prevents the userspace from doing overlapping parallel atomic writes and
> > it is kernels duty to error out if the write could get torn.
> 
> Correct, but simply userspace should not do this. Direct I/O applications
> are responsible for ordering.
> 
> We guarantee that the write is committed all-or-nothing, but do rely on
> userspace not issuing racing atomic writes or racing regular writes.
> 
> I can easily change this, as I mentioned, but I am not convinced that it is
> a must.

Purely from a design point of view, I feel we are breaking atomicity and
hence we should serialize or just stop userspace from doing this (which
is a bit extreme).

I know userspace should ideally not do overwriting atomic writes but if
it is something we are allowing (which we do) then it is
kernel's responsibility to ensure atomicity. Sure we can penalize them
by serializing the writes but not by tearing it. 

With that reasoning, I don't think the test should accomodate for this
particular scenario.

Regards,
ojaswin

