Return-Path: <linux-ext4+bounces-9494-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1CCB2F477
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 11:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A8E3ABBF1
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A082DCF77;
	Thu, 21 Aug 2025 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j8sHD9+r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD062DAFC9;
	Thu, 21 Aug 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769541; cv=none; b=UoTsu2/EeAPG81vb3FWW9/S3a5QnsbTd2sD0PIhWZsG7cnkvyEqmBTNREfq5X881GdRs6NZwypVHWzoLveqzRnSztcjMxGx8z7XLbwJUsXVRZDAb/PV4K8rchmeSZtB/cXtlOcqDkAP/o65XfDYS2C0PhALFjVWudyRjGEJo+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769541; c=relaxed/simple;
	bh=GHYBwVRKayplJxIt6mk36xNkPFzw+yBEuHRmZmt66SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMAxHU4lETY3XAuixIGGRTH8uyL8NP8IJluWH1nDZVBrL0ekU63x0ALEwraMcRlmUBNsE4DRVkj712E4gEDr8ug5dQQxVRfqnl4/20oXUOk0kyadToXZrgxXPkGbvGtClhzBElv/PfqGnPs3Qd1XCxmvMBZYE6s3cgvP5xua9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j8sHD9+r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KK3q03026005;
	Thu, 21 Aug 2025 09:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UhM3mEjjk5DZtBRTAhXSE7VrcYFGe6
	9UApfW9dbbB2g=; b=j8sHD9+rWWovYqh/bGy24dmh5BakWqOYdOH0Zt5Tis3qjN
	D2k+zKLA+pIWBllQfyGw7g1TikRIw5AFmFWS8AtmGEpv1sV08UxIJEnHeJn8quf4
	hHR/OTvNJNMdrgDNuAPmEISnbIHH+8ZmExpOy166BUdobY31npX91250BQVmxqdc
	ShVZTBuNP8FCQDxkyQ71w4MV+nS967JHGYclAB7qwfe5PF735tmsjtTux2cHRtCC
	FnBXdvsE3MAt48y5TRjjGUdxyzQ6oAn45ShlR1rx/Z8D2/xK3JjbNUczH1FmVn7/
	y7sfqQ2uXe/BINpyQnXavWEQ6Tw2Xgy/T4mmatXA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vfxn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 09:45:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57L9eKFL015747;
	Thu, 21 Aug 2025 09:45:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vfxmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 09:45:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6rQu2031881;
	Thu, 21 Aug 2025 09:45:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5y7pxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 09:45:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57L9jTse19530138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 09:45:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD262004E;
	Thu, 21 Aug 2025 09:45:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 235E920043;
	Thu, 21 Aug 2025 09:45:27 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Aug 2025 09:45:26 +0000 (GMT)
Date: Thu, 21 Aug 2025 15:15:24 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 03/11] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aKbqtJEfsI4iFY-E@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <8b3c42eb321b4a1a4850b7e76d53191cb20ffa41.1754833177.git.ojaswin@linux.ibm.com>
 <6cf3dc1e-919d-42b1-a8c0-cfd9bb158966@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf3dc1e-919d-42b1-a8c0-cfd9bb158966@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXxBayxs0uRmZk
 deY4eGwynkc1nnwA8HsxShYOKNPqPZKbV3H7QluKM6HcElM5JfJMx8bqTn49naiuIE9HVUi1+AW
 kWVNlS3/teDzpNG6TCevjvxmz4nle0HE4+A2qOZIMknehQCp17lAH/Zy/JmbJCX/rZekptVBmNg
 NNeOkLBd1dWf4T62aKxMFl5lqc5wJhno4hRxTxnSl6dHBvtmAGy4L03Hen1DzkV5M/LPSnldHM/
 zYmxLCskcUAltEL+KpRlUprIoEkY+54+ewyNHR02Ue3RagFoJMPWjKADOEmkiN93E4kY7bM/xCF
 dUT5JdTrWTOR1FgPmKFvyiHRGWoaQpVFMSidKuqVWuTCb+Yz2veUPdAyiAwP/J7zThYnB2AG07m
 piRVgEvjdmkFst5LNv4COwyfb/Io+w==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a6eabc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2n9UC11wNmDO3C5zd8gA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: s4kl0o4uwA3kNEyu0UkPSvtz-MZQkf0r
X-Proofpoint-ORIG-GUID: lN_wrrKj12Xe6rctE8CUqv2d05e2Q2V-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

On Wed, Aug 13, 2025 at 02:42:09PM +0100, John Garry wrote:
> On 10/08/2025 14:41, Ojaswin Mujoo wrote:
> > Implement atomic write support to help fuzz atomic writes
> > with fsx.
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> this looks ok, but I am not familiar with fsx.
> 
> BTW, you guarantee O_DIRECT with RWF_ATOMIC only, right?

So right now the user will have to pass in -Z to enable O_DIRECT.

So if the underlying stack has atomic support, fsx will try to do atomic
IO but if -Z is not passed it will fail the writes.

I think I will change this to switch atomic writes off if -Z is not
passed for convinience right now. Later if we have buffered support we
can lift this off. That's what you were asking about right?

Regards,
ojaswin

> 
> Thanks,
> John
> 
> > ---
> >   ltp/fsx.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 104 insertions(+), 5 deletions(-)
> > 
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 163b9453..ea39ca29 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -40,6 +40,7 @@
> >   #include <liburing.h>
> >   #endif
> >   #include <sys/syscall.h>
> > +#include "statx.h"
> >   #ifndef MAP_FILE
> >   # define MAP_FILE 0
> > @@ -49,6 +50,10 @@
> >   #define RWF_DONTCACHE	0x80
> >   #endif
> > +#ifndef RWF_ATOMIC
> > +#define RWF_ATOMIC	0x40
> > +#endif
> > +
> >   #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
> >   /* Operation flags (bitmask) */
> > @@ -110,6 +115,7 @@ enum {
> >   	OP_READ_DONTCACHE,
> >   	OP_WRITE,
> >   	OP_WRITE_DONTCACHE,
> > +	OP_WRITE_ATOMIC,
> >   	OP_MAPREAD,
> >   	OP_MAPWRITE,
> >   	OP_MAX_LITE,
> > @@ -200,6 +206,11 @@ int	uring = 0;
> >   int	mark_nr = 0;
> >   int	dontcache_io = 1;
> >   int	hugepages = 0;                  /* -h flag */
> > +int	do_atomic_writes = 1;		/* -a flag disables */
> > +
> > +/* User for atomic writes */
> > +int awu_min = 0;
> > +int awu_max = 0;
> >   /* Stores info needed to periodically collapse hugepages */
> >   struct hugepages_collapse_info {
> > @@ -288,6 +299,7 @@ static const char *op_names[] = {
> >   	[OP_READ_DONTCACHE] = "read_dontcache",
> >   	[OP_WRITE] = "write",
> >   	[OP_WRITE_DONTCACHE] = "write_dontcache",
> > +	[OP_WRITE_ATOMIC] = "write_atomic",
> >   	[OP_MAPREAD] = "mapread",
> >   	[OP_MAPWRITE] = "mapwrite",
> >   	[OP_TRUNCATE] = "truncate",
> > @@ -422,6 +434,7 @@ logdump(void)
> >   				prt("\t***RRRR***");
> >   			break;
> >   		case OP_WRITE_DONTCACHE:
> > +		case OP_WRITE_ATOMIC:
> >   		case OP_WRITE:
> >   			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
> >   			    lp->args[0], lp->args[0] + lp->args[1] - 1,
> > @@ -1073,6 +1086,25 @@ update_file_size(unsigned offset, unsigned size)
> >   	file_size = offset + size;
> >   }
> > +static int is_power_of_2(unsigned n) {
> > +	return ((n & (n - 1)) == 0);
> > +}
> > +
> > +/*
> > + * Round down n to nearest power of 2.
> > + * If n is already a power of 2, return n;
> > + */
> > +static int rounddown_pow_of_2(int n) {
> > +	int i = 0;
> > +
> > +	if (is_power_of_2(n))
> > +		return n;
> > +
> > +	for (; (1 << i) < n; i++);
> > +
> > +	return 1 << (i - 1);
> > +}
> > +
> >   void
> >   dowrite(unsigned offset, unsigned size, int flags)
> >   {
> > @@ -1081,6 +1113,27 @@ dowrite(unsigned offset, unsigned size, int flags)
> >   	offset -= offset % writebdy;
> >   	if (o_direct)
> >   		size -= size % writebdy;
> > +	if (flags & RWF_ATOMIC) {
> > +		/* atomic write len must be inbetween awu_min and awu_max */
> > +		if (size < awu_min)
> > +			size = awu_min;
> > +		if (size > awu_max)
> > +			size = awu_max;
> > +
> > +		/* atomic writes need power-of-2 sizes */
> > +		size = rounddown_pow_of_2(size);
> > +
> > +		/* atomic writes need naturally aligned offsets */
> > +		offset -= offset % size;
> > +
> > +		/* Skip the write if we are crossing max filesize */
> > +		if ((offset + size) > maxfilelen) {
> > +			if (!quiet && testcalls > simulatedopcount)
> > +				prt("skipping atomic write past maxfilelen\n");
> > +			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
> > +			return;
> > +		}
> > +	}
> >   	if (size == 0) {
> >   		if (!quiet && testcalls > simulatedopcount && !o_direct)
> >   			prt("skipping zero size write\n");
> > @@ -1088,7 +1141,10 @@ dowrite(unsigned offset, unsigned size, int flags)
> >   		return;
> >   	}
> > -	log4(OP_WRITE, offset, size, FL_NONE);
> > +	if (flags & RWF_ATOMIC)
> > +		log4(OP_WRITE_ATOMIC, offset, size, FL_NONE);
> > +	else
> > +		log4(OP_WRITE, offset, size, FL_NONE);
> >   	gendata(original_buf, good_buf, offset, size);
> >   	if (offset + size > file_size) {
> > @@ -1108,8 +1164,9 @@ dowrite(unsigned offset, unsigned size, int flags)
> >   		       (monitorstart == -1 ||
> >   			(offset + size > monitorstart &&
> >   			(monitorend == -1 || offset <= monitorend))))))
> > -		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d\n", testcalls,
> > -		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0);
> > +		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d atomic_wr=%d\n", testcalls,
> > +		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0,
> > +		    (flags & RWF_ATOMIC) != 0);
> >   	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
> >   	if (iret != size) {
> >   		if (iret == -1)
> > @@ -1785,6 +1842,30 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
> >   }
> >   #endif
> > +int test_atomic_writes(void) {
> > +	int ret;
> > +	struct statx stx;
> > +
> > +	ret = xfstests_statx(AT_FDCWD, fname, 0, STATX_WRITE_ATOMIC, &stx);
> > +	if (ret < 0) {
> > +		fprintf(stderr, "main: Statx failed with %d."
> > +			" Failed to determine atomic write limits, "
> > +			" disabling!\n", ret);
> > +		return 0;
> > +	}
> > +
> > +	if (stx.stx_attributes & STATX_ATTR_WRITE_ATOMIC &&
> > +	    stx.stx_atomic_write_unit_min > 0) {
> > +		awu_min = stx.stx_atomic_write_unit_min;
> > +		awu_max = stx.stx_atomic_write_unit_max;
> > +		return 1;
> > +	}
> > +
> > +	fprintf(stderr, "main: IO Stack does not support "
> > +			"atomic writes, disabling!\n");
> > +	return 0;
> > +}
> > +
> >   #ifdef HAVE_COPY_FILE_RANGE
> >   int
> >   test_copy_range(void)
> > @@ -2356,6 +2437,12 @@ have_op:
> >   			goto out;
> >   		}
> >   		break;
> > +	case OP_WRITE_ATOMIC:
> > +		if (!do_atomic_writes) {
> > +			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
> > +			goto out;
> > +		}
> > +		break;
> >   	}
> >   	switch (op) {
> > @@ -2385,6 +2472,11 @@ have_op:
> >   			dowrite(offset, size, 0);
> >   		break;
> > +	case OP_WRITE_ATOMIC:
> > +		TRIM_OFF_LEN(offset, size, maxfilelen);
> > +		dowrite(offset, size, RWF_ATOMIC);
> > +		break;
> > +
> >   	case OP_MAPREAD:
> >   		TRIM_OFF_LEN(offset, size, file_size);
> >   		domapread(offset, size);
> > @@ -2511,13 +2603,14 @@ void
> >   usage(void)
> >   {
> >   	fprintf(stdout, "usage: %s",
> > -		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > +		"fsx [-adfhknqxyzBEFHIJKLORWXZ0]\n\
> >   	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> >   	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> >   	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> >   	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
> >   	   [--replay-ops=opsfile] [--record-ops[=opsfile]] [--duration=seconds]\n\
> >   	   ... fname\n\
> > +	-a: disable atomic writes\n\
> >   	-b opnum: beginning operation number (default 1)\n\
> >   	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
> >   	-d: debug output for all operations\n\
> > @@ -3059,9 +3152,13 @@ main(int argc, char **argv)
> >   	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> >   	while ((ch = getopt_long(argc, argv,
> > -				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > +				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> >   				 longopts, NULL)) != EOF)
> >   		switch (ch) {
> > +		case 'a':
> > +			prt("main(): Atomic writes disabled\n");
> > +			do_atomic_writes = 0;
> > +			break;
> >   		case 'b':
> >   			simulatedopcount = getnum(optarg, &endp);
> >   			if (!quiet)
> > @@ -3475,6 +3572,8 @@ main(int argc, char **argv)
> >   		exchange_range_calls = test_exchange_range();
> >   	if (dontcache_io)
> >   		dontcache_io = test_dontcache_io();
> > +	if (do_atomic_writes)
> > +		do_atomic_writes = test_atomic_writes();
> >   	while (keep_running())
> >   		if (!test())
> 

