Return-Path: <linux-ext4+bounces-10569-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5CFBB4C28
	for <lists+linux-ext4@lfdr.de>; Thu, 02 Oct 2025 19:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207EC189FD90
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Oct 2025 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C4A274658;
	Thu,  2 Oct 2025 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ddl5i3KV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01F26E71F;
	Thu,  2 Oct 2025 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427822; cv=none; b=qZ2H1F1hmdZrlsFLFwyvM2iq6ILDCQ4ylDr5Gia8SOQNe54GyM7Nj614a4VVMMU3wBKqrlq6mSGPVB/mYLQvGJRG5WbaZYKz0SJvJYHmTB1JrUlfFDcX48hZhGCPru10GRqjnnooJK4bAtf2UG49yzR463fcOJXPa4gRe7QPLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427822; c=relaxed/simple;
	bh=zQ4mVeDqGV4zDhKms9X4gPs29Ehtpz2h9/Gvpae+6cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPnMT9PKGuyJvr53x25TbAvwP2YBmzTHmYsJZM2pxw9Vzk5K1W0NHIY8c5vpU76khZSO06mYSMO7B3H08LSdfNuDWUjBGEKll9ZvnOgdf4k01MJ4x5vdz9KX0UE8wu/AbPGoN+MXcP+UzgAlbV8rOEbRWkvGK32wORc3EY4cVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ddl5i3KV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592C0JKl021005;
	Thu, 2 Oct 2025 17:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Kd5wFBfJiU+XGyk4HfneW7G/osjZ0X
	dU33ypCNYRyQw=; b=Ddl5i3KVGF7ATeGzLmU1nmvwEM61CxM6qAwlFkoqfO0AFC
	AMQMd7zSSulUgAIDSfYdjHIShM8uBfE1MCpcLA1RNiLxf2HUrDw06MsYGdm0Czuz
	fPbrJD2yJtkioAYiugTvus3hhIawuH2ubsDIi8+5ydtEBk5uDQIxmE4/vt8U0Viy
	SGXB1peLo1eAMiumxh945/aF0FIn21NIJXnPzgnBwaR5+uC0Od8bR22WATYIOQK1
	bxJtaRYeSsHvZgVTyJPLcK9iHzWtl0IsA6CEpzHwHt/QMttYbpBpmth98VD5PLbX
	zHnpOOY07Nqm/cJQf11e8/XPN3Zr5T2e30HpTLng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwwqed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 17:56:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 592HuqIP019980;
	Thu, 2 Oct 2025 17:56:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwwqe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 17:56:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592H8OGF007313;
	Thu, 2 Oct 2025 17:56:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk74tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 17:56:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 592HuoEn20906308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 17:56:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DC3820043;
	Thu,  2 Oct 2025 17:56:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C701F20040;
	Thu,  2 Oct 2025 17:56:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.59])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Oct 2025 17:56:47 +0000 (GMT)
Date: Thu, 2 Oct 2025 23:26:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <c3a040b249485b02b569b9269b649d02d721d995.1758264169.git.ojaswin@linux.ibm.com>
 <20250928131924.b472fjxwir7vphsr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928131924.b472fjxwir7vphsr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXx+ZEHbBKfsKv
 tBTC9CIL1pBm0wTJ9lGpKR9eOh/t8gdWj+FIfvuTpXpu5gIGq0WPPK5mexK5h3ZgzYS4NXGlLZs
 3KH3YrPps1to6uDRtqx/5ReYQoCwHUrE82909FAXGWr/jpV2nJflbWfDD+d+A9QqX+JojiqaUyy
 7d9LIRGL0OdrFRP+YSU7UEUuzLEJYAtEKsOZUr9MwTdaPzBRoAaqwOdEDfmkky+d4lGyDI/4+XR
 KN0G0dgNRWryb75mCEPrU35hm5a46SLcUWjeYDbzmG37Bm4rNiJ/rfqJ9GwaLbEaeB7H1zSsG8e
 zt/q+KNY9NntJDM2ISBWr/ikMyBrB3zk6880DnSFjm1updQSufpaNpMFhhs/TadOlgDkKi2taXV
 oRu0loFA14k8XC+wcesKi7OCfkJvoQ==
X-Proofpoint-ORIG-GUID: w79IYFFsLf3HKFkgqbgF_xEYSOIoJlP_
X-Proofpoint-GUID: ooOTpfcHyLwupaL7g2xq1EmAWoRmNdsn
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68debce5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=WeWFw57fSx3zdQzyt3YA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

On Sun, Sep 28, 2025 at 09:19:24PM +0800, Zorro Lang wrote:
> On Fri, Sep 19, 2025 at 12:17:57PM +0530, Ojaswin Mujoo wrote:
> > Implement atomic write support to help fuzz atomic writes
> > with fsx.
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> 
> Hmm... this patch causes more regular fsx test cases fail on old kernel,
> (e.g. g/760, g/617, g/263 ...) except set "FSX_AVOID=-a". Is there a way
> to disable "atomic write" automatically if it's not supported by current
> system?

Hi Zorro, 
Sorry for being late, I've been on vacation this week.

Yes so by design we should be automatically disabling atomic writes when
they are not supported by the stack but seems like the issue is that
when we do disable it we print some extra messages to stdout/err which
show up in the xfstests output causing failure.

I can think of 2 ways around this:

1. Don't print anything and just silently drop atomic writes if stack
doesn't support them.

2. Make atomic writes as a default off instead of default on feature but
his loses a bit of coverage as existing tests wont get atomic write
testing free of cost any more.

Regards,
ojaswin

> Thanks,
> Zorro
> 
> >  ltp/fsx.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 110 insertions(+), 5 deletions(-)
> > 
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 163b9453..bdb87ca9 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -40,6 +40,7 @@
> >  #include <liburing.h>
> >  #endif
> >  #include <sys/syscall.h>
> > +#include "statx.h"
> >  
> >  #ifndef MAP_FILE
> >  # define MAP_FILE 0
> > @@ -49,6 +50,10 @@
> >  #define RWF_DONTCACHE	0x80
> >  #endif
> >  
> > +#ifndef RWF_ATOMIC
> > +#define RWF_ATOMIC	0x40
> > +#endif
> > +
> >  #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
> >  
> >  /* Operation flags (bitmask) */
> > @@ -110,6 +115,7 @@ enum {
> >  	OP_READ_DONTCACHE,
> >  	OP_WRITE,
> >  	OP_WRITE_DONTCACHE,
> > +	OP_WRITE_ATOMIC,
> >  	OP_MAPREAD,
> >  	OP_MAPWRITE,
> >  	OP_MAX_LITE,
> > @@ -200,6 +206,11 @@ int	uring = 0;
> >  int	mark_nr = 0;
> >  int	dontcache_io = 1;
> >  int	hugepages = 0;                  /* -h flag */
> > +int	do_atomic_writes = 1;		/* -a flag disables */
> > +
> > +/* User for atomic writes */
> > +int awu_min = 0;
> > +int awu_max = 0;
> >  
> >  /* Stores info needed to periodically collapse hugepages */
> >  struct hugepages_collapse_info {
> > @@ -288,6 +299,7 @@ static const char *op_names[] = {
> >  	[OP_READ_DONTCACHE] = "read_dontcache",
> >  	[OP_WRITE] = "write",
> >  	[OP_WRITE_DONTCACHE] = "write_dontcache",
> > +	[OP_WRITE_ATOMIC] = "write_atomic",
> >  	[OP_MAPREAD] = "mapread",
> >  	[OP_MAPWRITE] = "mapwrite",
> >  	[OP_TRUNCATE] = "truncate",
> > @@ -422,6 +434,7 @@ logdump(void)
> >  				prt("\t***RRRR***");
> >  			break;
> >  		case OP_WRITE_DONTCACHE:
> > +		case OP_WRITE_ATOMIC:
> >  		case OP_WRITE:
> >  			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
> >  			    lp->args[0], lp->args[0] + lp->args[1] - 1,
> > @@ -1073,6 +1086,25 @@ update_file_size(unsigned offset, unsigned size)
> >  	file_size = offset + size;
> >  }
> >  
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
> >  void
> >  dowrite(unsigned offset, unsigned size, int flags)
> >  {
> > @@ -1081,6 +1113,27 @@ dowrite(unsigned offset, unsigned size, int flags)
> >  	offset -= offset % writebdy;
> >  	if (o_direct)
> >  		size -= size % writebdy;
> > +	if (flags & RWF_ATOMIC) {
> > +		/* atomic write len must be between awu_min and awu_max */
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
> >  	if (size == 0) {
> >  		if (!quiet && testcalls > simulatedopcount && !o_direct)
> >  			prt("skipping zero size write\n");
> > @@ -1088,7 +1141,10 @@ dowrite(unsigned offset, unsigned size, int flags)
> >  		return;
> >  	}
> >  
> > -	log4(OP_WRITE, offset, size, FL_NONE);
> > +	if (flags & RWF_ATOMIC)
> > +		log4(OP_WRITE_ATOMIC, offset, size, FL_NONE);
> > +	else
> > +		log4(OP_WRITE, offset, size, FL_NONE);
> >  
> >  	gendata(original_buf, good_buf, offset, size);
> >  	if (offset + size > file_size) {
> > @@ -1108,8 +1164,9 @@ dowrite(unsigned offset, unsigned size, int flags)
> >  		       (monitorstart == -1 ||
> >  			(offset + size > monitorstart &&
> >  			(monitorend == -1 || offset <= monitorend))))))
> > -		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d\n", testcalls,
> > -		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0);
> > +		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d atomic_wr=%d\n", testcalls,
> > +		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0,
> > +		    (flags & RWF_ATOMIC) != 0);
> >  	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
> >  	if (iret != size) {
> >  		if (iret == -1)
> > @@ -1785,6 +1842,36 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
> >  }
> >  #endif
> >  
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
> > +	return 0;
> > +}
> > +
> >  #ifdef HAVE_COPY_FILE_RANGE
> >  int
> >  test_copy_range(void)
> > @@ -2356,6 +2443,12 @@ have_op:
> >  			goto out;
> >  		}
> >  		break;
> > +	case OP_WRITE_ATOMIC:
> > +		if (!do_atomic_writes) {
> > +			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
> > +			goto out;
> > +		}
> > +		break;
> >  	}
> >  
> >  	switch (op) {
> > @@ -2385,6 +2478,11 @@ have_op:
> >  			dowrite(offset, size, 0);
> >  		break;
> >  
> > +	case OP_WRITE_ATOMIC:
> > +		TRIM_OFF_LEN(offset, size, maxfilelen);
> > +		dowrite(offset, size, RWF_ATOMIC);
> > +		break;
> > +
> >  	case OP_MAPREAD:
> >  		TRIM_OFF_LEN(offset, size, file_size);
> >  		domapread(offset, size);
> > @@ -2511,13 +2609,14 @@ void
> >  usage(void)
> >  {
> >  	fprintf(stdout, "usage: %s",
> > -		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > +		"fsx [-adfhknqxyzBEFHIJKLORWXZ0]\n\
> >  	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> >  	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> >  	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> >  	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
> >  	   [--replay-ops=opsfile] [--record-ops[=opsfile]] [--duration=seconds]\n\
> >  	   ... fname\n\
> > +	-a: disable atomic writes\n\
> >  	-b opnum: beginning operation number (default 1)\n\
> >  	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
> >  	-d: debug output for all operations\n\
> > @@ -3059,9 +3158,13 @@ main(int argc, char **argv)
> >  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> >  
> >  	while ((ch = getopt_long(argc, argv,
> > -				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > +				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> >  				 longopts, NULL)) != EOF)
> >  		switch (ch) {
> > +		case 'a':
> > +			prt("main(): Atomic writes disabled\n");
> > +			do_atomic_writes = 0;
> > +			break;
> >  		case 'b':
> >  			simulatedopcount = getnum(optarg, &endp);
> >  			if (!quiet)
> > @@ -3475,6 +3578,8 @@ main(int argc, char **argv)
> >  		exchange_range_calls = test_exchange_range();
> >  	if (dontcache_io)
> >  		dontcache_io = test_dontcache_io();
> > +	if (do_atomic_writes)
> > +		do_atomic_writes = test_atomic_writes();
> >  
> >  	while (keep_running())
> >  		if (!test())
> > -- 
> > 2.49.0
> > 
> 

