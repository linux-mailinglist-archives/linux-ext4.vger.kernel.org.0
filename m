Return-Path: <linux-ext4+bounces-9488-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF49DB2F1A6
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 10:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97AAF4E573B
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF87A2EBDEA;
	Thu, 21 Aug 2025 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T2JP7HMJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706C2EBBA0;
	Thu, 21 Aug 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764943; cv=none; b=aQKo/M9rVboDF4ZjRdJCpHOyedHPv9aOBpSrp3TvI0SeovdVdnZBUeS6fG6hOq5p94bMSsplAxy4da2RpMF1NEUMgcJ9VVAqv5P+PSxzN8H6dbUsR7rOBLK6/x9kP8WGBG3KcZcCXLj5zhLgHdTMJxrDjFp3htHi4J7SMlAY8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764943; c=relaxed/simple;
	bh=a2wET9PKUBBkAgbIsRSlHzHzt68vTUrPLYGbc06TB2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiXb/MfUhZfp7SgEyppXR/bE7uYLkJmRR2ux/fgHZl/rCubl5tHaMoPnTNTZfUi3ZY6wOiFH8EFV9ZffODPtGItzdZNRX5pgcOXVZG0ZNAibu49b7nJDVulg6qElSgBZXhwWPHOh7mQY1bsXFsLTQ1mISA/Iqm+GvdoVdWvQmJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T2JP7HMJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KLGnCf026300;
	Thu, 21 Aug 2025 08:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MrhB9aZI6hJSBrwAZZOKZyzZ1FplXS
	an7urwkwv8H8s=; b=T2JP7HMJeVisp4TXiFMDezSNBGCUTsPCvh6rGR3Rm3bZEK
	T3G4QyTy/BkXBDC5C9FNtjoDwbCcNa3vNcZcItgGe/8R3BsXOAj2PWNVaZ5pySkW
	o8GpcFMdl7NPCU0Ww/6C4OXVkkIl1WpQeCKDI5KhaJ0yZSkpAefbhE2LtUXYuQ3Z
	bJ0zApLjc+kiKDnUCD+PBTl9tCirSkF7SnQfRpWKhPeF0Tpv6WAt/SqXAEhAsOX4
	zGNkHCKQM3B1U0Qb2ZSLulR5SCPlUvgLM7w4ekrFy2/oM6sui4JY11IskaWVr0eb
	bo1tLukqpYeV2C0HhGlJUpyYYSsfD6PjP+4KePjQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vfkyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:28:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57L8SsbX029878;
	Thu, 21 Aug 2025 08:28:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vfkyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:28:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6jZcK026674;
	Thu, 21 Aug 2025 08:28:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my4w7e18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:28:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57L8SpZq33817014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 08:28:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48AA020043;
	Thu, 21 Aug 2025 08:28:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0741D20040;
	Thu, 21 Aug 2025 08:28:49 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Aug 2025 08:28:48 +0000 (GMT)
Date: Thu, 21 Aug 2025 13:58:46 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 10/11] ext4: Atomic writes test for bigalloc using fio
 crc verifier on multiple files
Message-ID: <aKbYvubsS8xUG88d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <48873bdce79f491b8b8948680afe041831af08cd.1754833177.git.ojaswin@linux.ibm.com>
 <7c4824a6-8922-470d-915c-e783a4e0e9cc@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4824a6-8922-470d-915c-e783a4e0e9cc@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX72IknLTBHwEy
 DN5cNnZ7bUiSPG4dBx9mit+hyzbndGfTljI0o0sm9EXzQBZMwZKMruswqIU0PRmxjNc8Ab7OHvj
 MXrIlC2CNM4+gN8bVWzA4WQ1kezB91QaicE+Xr+1SMfA88WuUL6ynFgHRpW7epn5ClitJuDT5QD
 s00jWtWd2LL7OnAjjH1g6o2hJ3qEKPt5teMEQ1ZpmCqkX7cj5UkzGFTP04HgZ8LEXc4WZarOyBW
 VZNZ54DUPrYuuacAL+WJf038ag19rEok/gVjBrt6kq5FCRYhMDZ/yuIadV75ozL5I1NlOeoph8V
 jxy3oIcEqwg8+2vMUsUU2QIMoZijj8PoN7Bvh3K0dPgY3etkEhpKKOd9fY/fgMEaMP+ZolkWlzg
 PseJ4WuOktzhpzrw4Zlx0ixxT350+Q==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a6d8c7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gbdSB_K5HMGwtwTQacwA:9 a=CjuIK1q_8ugA:10 a=U1FKsahkfWQA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: btJPr-yflrG69WwqZbo5oNcltNwTk8nK
X-Proofpoint-ORIG-GUID: InFHawYCilDPiy8BJjsnSy5diPsjaNeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

On Wed, Aug 13, 2025 at 02:45:28PM +0100, John Garry wrote:
> On 10/08/2025 14:42, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)"<ritesh.list@gmail.com>
> > 
> > Brute force all possible blocksize clustersize combination on a bigalloc
> > filesystem for stressing atomic write using fio data crc verifier. We run
> > multiple threads in parallel with each job writing to its own file. The
> > parallel jobs running on a constrained filesystem size ensure that we
> > stress the ext4 allocator to allocate contiguous extents.
> > 
> > This test might do overlapping atomic writes but that should be okay
> > since overlapping parallel hardware atomic writes don't cause tearing as
> > long as io size is the same for all writes.
> > 
> > Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> > Reviewed-by: Darrick J. Wong<djwong@kernel.org>
> > Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>
> > ---
> >   tests/ext4/062     | 176 +++++++++++++++++++++++++++++++++++++++++++++
> >   tests/ext4/062.out |   2 +
> >   2 files changed, 178 insertions(+)
> >   create mode 100755 tests/ext4/062
> >   create mode 100644 tests/ext4/062.out
> 
> Is the only difference to 061 that we have multiple files (and not a single
> file)?

Hey John,

Yes these 2 tests are similar however 061 uses fallocate=native +
_scratch_mkfs_ext4 to test whether atomic writes on preallocated file
via multiple threads works correctly.

The 062 uses fallocate=truncate + _scratch_mkfs_sized 360MB +
'multiple jobs each writing to a different file' to ensure we are
extensively stressing the allocation logic in low space scenarios.

Regards,
ojaswin
> 
> Thanks,
> John

