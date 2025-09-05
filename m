Return-Path: <linux-ext4+bounces-9829-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7239B45E27
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 18:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE6B5C828E
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0322F306B00;
	Fri,  5 Sep 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dU2DT1XD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB472C0274;
	Fri,  5 Sep 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089788; cv=none; b=Nv9DaVUalcsMZPP4kkcENF/94cAWFTEOh+jxla8x1dsuuvvbzAQO9HxBjO5E2rLXmYTrZ+Fk3TPa+KmIN7+DVoK8TiGjVwp3iouaiMK+X1hOlh5gIRg1Ja/Tf9yRTHMkkULX9wfMD5nJRnRT1USNh4ykCKkN4nDiMFdNpprNOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089788; c=relaxed/simple;
	bh=I72TsF5sC0CuW+sthf9h8Lnzhh7kJPjoLXaSKi8gao4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgU9PYh07trd1/iv1x/OdgKkWblquFrCzvP6gOO+Jk5fbh1HuyMoHprBNSKTX6qYeTl/fiJvK7Tc9Kt4JXvWEOp96PVUBGgpjhFTze6IDg6qFEry3PqiPCpPxzMyCvhtXcyyoaAG+d1dzdJlr4isP3l1Nb2vl1zWP9hIKEyAkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dU2DT1XD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585DsN9O000426;
	Fri, 5 Sep 2025 16:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BjoAGHms3LXIS587axNMSJ45tB0iBg
	QdkT6hK0WldTY=; b=dU2DT1XDSnuL9rPqjNamsK6k16/ZPqNxDGY0OH62j0L+68
	zebJNR9ZNImJxw4O68u3N0mh5LcOY4Yhs9nNq9xAS9wgVP/DbKVBfwP6zQuJNm+j
	iew0xDBN8U0hE1ZoD/J6yVmUVjLs0Ia+UG8wxweyOnkvpZdNjrII9/u1/sMJsMXx
	yA6bVZ+ZQMPEYb3kwZeWreVvbooVyubhoi58Ks7VPn9bqd64tWzVc4GH7xx2zdxp
	lyV+Z6kFQt4UXCGdBL0m04CdyYYsK6AK6jIVJVZJYWyjHh/e2+EAw2vuJhcit08l
	Yx49yGnxJiTzM4mKq3OMSjK4BROntHV5emhVYGaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshfcwh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:29:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585GTbYZ004126;
	Fri, 5 Sep 2025 16:29:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshfcwgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:29:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585D9uJu019363;
	Fri, 5 Sep 2025 16:29:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4na61p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:29:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585GTYfU56492498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 16:29:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABD0820043;
	Fri,  5 Sep 2025 16:29:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B5D020040;
	Fri,  5 Sep 2025 16:29:32 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.13])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 16:29:32 +0000 (GMT)
Date: Fri, 5 Sep 2025 21:59:29 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aLsP6ROqLqhdbLZz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <8b7e007fd87918a0c3976ca7d06c089ed9b0070c.1755849134.git.ojaswin@linux.ibm.com>
 <e2892851-5426-43d3-a25e-be9d9c7f860a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2892851-5426-43d3-a25e-be9d9c7f860a@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: flG36158ODFCZ2sof7yDFud8S2W_zUlA
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68bb0ff2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=S1LBiFWvAxLIuGqWplsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: DUi0YfKJ_lFTUKwLGZVr4mZAz99Qyav6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX3hl0DCDtkMMw
 QpvYLK/8uuz+aVDIFZacr9pCPcYpLXJuywZ+1/+FeGyjdBtPt0BgbSX1+ijz+FNtQGRL29gU7Bm
 yza3I0Q7PHyvh5Gt7AwtFjTEyx/v5xSSDiRUd4j5oqYS4eSZPRobbLeTXqb/GbkA94gT+JLjKdK
 VGum5hXJ1rBd0qxh4V5jWssb7a46XBDkL/rlWjf9j5QNf5y/uUZkz+7f7FfOmUhA952c5KBbdrQ
 asJ9qqFs/k7lFAjvgMCVrED4rZ3ZZc1eah6CoeQgi//0dT15UTCCXaBA9MXnyLr/TBqOg4ADylO
 owiErvTsy86b/IgPIb+AcxTRs9Dp/n5n3CBChCGKTp0cLEEBDfBPwta4ZyJIXSvzGSxAA4rAsBJ
 fXrvGQ//
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040

On Tue, Sep 02, 2025 at 04:06:08PM +0100, John Garry wrote:
> On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> > Implement atomic write support to help fuzz atomic writes
> > with fsx.
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Generally this looks ok, but I do have some comments, so please check them:
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
> > ---
> >   ltp/fsx.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 110 insertions(+), 5 deletions(-)
> > 
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 163b9453..1582f6d1 100644
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
> 
> Is this the neatest way to do this?

Well it is a straigforward o(logn) way. Do you have something else in
mind?

> 
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
> 
> in between
> 
> > +		if (size < awu_min)
> > +			size = awu_min;
> > +		if (size > awu_max)
> > +			size = awu_max;
> > +
> > +		/* atomic writes need power-of-2 sizes */
> > +		size = rounddown_pow_of_2(size);
> 
> you could have:
> 
> if (size < awu_min)
> 	size = awu_min;
> else if (size > awu_max)
> 	size = awu_max;
> else
> 	size = rounddown_pow_of_2(size);

sure I can do that

> 
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
> 
> nit:
> 
> 	!!(flags & RWF_ATOMIC)
> 
> I find that a bit neater, but I suppose you are following the example for
> RWF_DONTCACHE

Yep.

> 
> >   	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
> >   	if (iret != size) {
> >   		if (iret == -1)
> > @@ -1785,6 +1842,36 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
> >   }
> >   #endif
> > +int test_atomic_writes(void) {
> > +	int ret;
> > +	struct statx stx;
> > +
> > +	if (o_direct != O_DIRECT) {
> > +		fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
> > +				"disabling!\n");
> > +		return 0;
> > +	}
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
> 
> Do we really need to spread this over multiple lines?
> 
> Maybe that is the coding standard - I don't know.

Yea, I wouldve liked to keep it on the same but looking at above
fprintf()s seems like we break the strings.
> 
> > +	return 0;
> > +}
> > +
> >   #ifdef HAVE_COPY_FILE_RANGE
> >   int
> >   test_copy_range(void)
> > @@ -2356,6 +2443,12 @@ have_op:
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
> > @@ -2385,6 +2478,11 @@ have_op:
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
> > @@ -2511,13 +2609,14 @@ void
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
> > @@ -3059,9 +3158,13 @@ main(int argc, char **argv)
> >   	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> >   	while ((ch = getopt_long(argc, argv,
> > -				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > +				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> >   				 longopts, NULL)) != EOF)
> >   		switch (ch) {
> > +		case 'a':
> > +			prt("main(): Atomic writes disabled\n");
> > +			do_atomic_writes = 0;
> 
> why an opt-out (and not opt-in)?

That's something Darrick suggested a few iterations back so we
automatically get the testing if the stack supports it.

Thanks for the review. I'll incorporate the minor changes in next version.

Regards,
ojaswin
> 
> > +			break;
> >   		case 'b':
> >   			simulatedopcount = getnum(optarg, &endp);
> >   			if (!quiet)
> > @@ -3475,6 +3578,8 @@ main(int argc, char **argv)
> >   		exchange_range_calls = test_exchange_range();
> >   	if (dontcache_io)
> >   		dontcache_io = test_dontcache_io();
> > +	if (do_atomic_writes)
> > +		do_atomic_writes = test_atomic_writes();
> >   	while (keep_running())
> >   		if (!test())
> 

