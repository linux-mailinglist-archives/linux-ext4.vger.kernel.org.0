Return-Path: <linux-ext4+bounces-9497-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF9B2F7BF
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 14:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E03BA26973
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 12:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ADE2E0916;
	Thu, 21 Aug 2025 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fEm2R/rs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13265275B05;
	Thu, 21 Aug 2025 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778787; cv=none; b=o+67mkouvoTHA6Ru+gVVcO0oLveu92Zzpz98vYgSiJNZyBHpJovYW6r/l5Jwl8PrZ1k1+v6hgtqf+RO9Uo92CtnckD4SFHDMVpHspg27HzNJ+gS3WnRcZIISSpon9ez38tVI9wS3/v4qKsBeosNfYLf7CQVdVl5wXfpugfvMc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778787; c=relaxed/simple;
	bh=9nrwNazOC064iJN5DaK4WKws0OYdf/Neuy1zVI88R2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLkY113MFGen/PjWJ9H4MrS1T6w+/Czk6DpInNkYUShMzFDLbFdrh1eyEB6OYflOwMgBkcA8r2op7y0vmpoIhQ7BgxBs83l3mgAmOJDdB+Z0ixhdLpAFZ5k40rIFtdNww2uxPD8sZ95gYqen0rSPFEXQa4gHWKv12ySg1eMuUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fEm2R/rs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0SOVG014376;
	Thu, 21 Aug 2025 12:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jabod7imMIYKgTg5L+VE3q6C2cbhQL
	J3Zp4FnaW2Ujw=; b=fEm2R/rs7fC1k1UeOaQJNYy4J1+LGLELXKz7ofcGqBuPRB
	BV0wn+T9cQE7PTOE3BJJXSdCAxKNx4EYCujlFDSoPvckaap1f3mGBKSAbMt1Rk3A
	2Yr25yX3xI3gXJVM9A3cEU+prefBRKKc2C4DABmAb7+x8NpJxvycnV4B5O57J2z8
	yzAyv08Ydro0dZDviUVRd2rDYzolEXyDyAbJOHpxaGs0y6XPxuKBu4ul50TQJH1U
	6SK/zFqxrV6IKtPN0R0DnUJINgHkeRiwMhtLC7wxg6vW15yiIKrZUKs6kBnzznt1
	T6LdgA+oDIu6/3bVR0YalzV2If7evaAHlSwK77jg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w0dfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:19:39 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57LCIwgv021533;
	Thu, 21 Aug 2025 12:19:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w0df4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:19:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAnwNN026916;
	Thu, 21 Aug 2025 12:19:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my4w87jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:19:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LCJa1x34013696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 12:19:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71E222004B;
	Thu, 21 Aug 2025 12:19:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CE2F20043;
	Thu, 21 Aug 2025 12:19:34 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Aug 2025 12:19:34 +0000 (GMT)
Date: Thu, 21 Aug 2025 17:49:23 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 10/11] ext4: Atomic writes test for bigalloc using fio
 crc verifier on multiple files
Message-ID: <aKcOy9xCfdC_skbZ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <48873bdce79f491b8b8948680afe041831af08cd.1754833177.git.ojaswin@linux.ibm.com>
 <7c4824a6-8922-470d-915c-e783a4e0e9cc@oracle.com>
 <aKbYvubsS8xUG88d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8b39d392-0a10-47fd-ac3c-b73a1e341e86@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b39d392-0a10-47fd-ac3c-b73a1e341e86@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dyZJ_10eRNb3lcZEqCzJXfu4Awl0VyMi
X-Proofpoint-GUID: bDxMBs5j8jVRMbRC-yHjsSbFMMcf2KGS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX7oE01YfJtAi2
 BK0BlrEHM4S0h7WvRrMykrZW34ljFdFsBiadvTNEEN+55qkNg6RIYR9vrA6LpYFQWK4fPofZl53
 vt+8/bFhvEzlmHQeeLOBA4fdh5rjB2IuE3DZ+8JygOYpY02IS3VZSuk+IU1aUiYnLo3k29d6qF2
 8z3fhJ0SBvcq05vn1VM98UBjDdIcHNtVoJolYLXRhrElo47nh5G+G8flVstrsa5uSMM5o4wRgbt
 XieN1l322X3mUEfwGQvrUg3mkUvx4vGEoLHtfzkhY30bMl/WvRzQvgsJ2WTekKAtLY3PGbwvPTD
 ZWCd7TDJazFLQ0ibUimqPn03jm2Ymjjpy7cNKRSurXOoGWhAveWYp5qUsgRb+9sgvJ0dKRPMfGw
 eRkeg4X+0KlVx0XqD7mgrn56DPGYcw==
X-Authority-Analysis: v=2.4 cv=a9dpNUSF c=1 sm=1 tr=0 ts=68a70edb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=tBZCFxjrRziQfJ6o_zoA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

On Thu, Aug 21, 2025 at 10:28:56AM +0100, John Garry wrote:
> On 21/08/2025 09:28, Ojaswin Mujoo wrote:
> > Yes these 2 tests are similar however 061 uses fallocate=native +
> > _scratch_mkfs_ext4 to test whether atomic writes on preallocated file
> > via multiple threads works correctly.
> > 
> > The 062 uses fallocate=truncate + _scratch_mkfs_sized 360MB +
> > 'multiple jobs each writing to a different file' to ensure we are
> > extensively stressing the allocation logic in low space scenarios.
> 
> I see, please at least fully document this in the commit messages.
> 
> Thanks

Will do.

Regards,
ojaswin

