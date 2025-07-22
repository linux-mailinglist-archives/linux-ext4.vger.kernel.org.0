Return-Path: <linux-ext4+bounces-9148-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FDB0D682
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 12:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D991AA695F
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812712E11C0;
	Tue, 22 Jul 2025 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m/O49DTU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE012E03E0;
	Tue, 22 Jul 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178381; cv=none; b=VpERZmFdDGD8Nkgt4npf4dHrDN0olwyTcNv89Znnw8YGllTK+To2i54QMykYIC5FQ6i3KvyY5+vswzVBL5JPIKY+NsqYfCana8BF+51DvGA3e316n8oFso12Ul7MfzyGK4qEDmPSWp69hIjIwdp6MYE/I8mGu2MjAe4RZqBO6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178381; c=relaxed/simple;
	bh=9lAHiBwoo8jGTNinYh/ijsaneKOOiolgCjybVc2fj1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UO8k3Vl5n44oWn/pCI832ulSxn1OQoL7WXaI2+XM4xkbamEhZev8vRLm0mevlCQ8frBeRnNON9l2mqo//yvjfWzLGTuXa0CRGggrCXmB9YXYJ73qANosZEyf7gpS5yvxcRdJlr6Utv9n+jhWD0qWMjrgPssr/ZiUqqPH3dcETQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m/O49DTU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M8xTd5009164;
	Tue, 22 Jul 2025 09:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QNi9XzvfVxCwjgas+8tBNVhNwsc6Wl
	y29wriyx3/p7g=; b=m/O49DTUDdwY7AISTXrwrRvug3FDe4RCwEjkgJMjIK5f8k
	gTPyiraUNoWEe8n6MOFReNFfHX/GjX1upniWgyTpj5NPKFFqKhmXIk3U417BqDI2
	7AYPlDiJ78cvytPbXcfbJXKTMUgIzWsLc9l9pbQc7N3kpaTyOwuHiBEbj5e+ynbZ
	+so/XPY+QDg2H1ZiSbHAC+tnKDTqlvGWrocHSNkFvC0oALERZRjocTGXGiulzjmC
	Vj+42bzcmVWJL5mOr/um2ifK9WD/nkE5Rxk8W+TJCmQEwj8cMM82wlgngCuMdy2f
	CxFOWpPDFf0U+68u/BVrQbAWmzUbFl9u7GRwM90Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut5grt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:59:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56M9vwHl015887;
	Tue, 22 Jul 2025 09:59:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut5grn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:59:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6AHHd005470;
	Tue, 22 Jul 2025 09:59:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvqsfua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:59:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56M9x7gN52822374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 09:59:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C56B520043;
	Tue, 22 Jul 2025 09:59:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8760020040;
	Tue, 22 Jul 2025 09:59:05 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.18.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Jul 2025 09:59:05 +0000 (GMT)
Date: Tue, 22 Jul 2025 15:29:02 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 04/13] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aH9g5jkwnXAkQUJl@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <5bbd19e1615ca2a485b3b430c92f0260ee576f5e.1752329098.git.ojaswin@linux.ibm.com>
 <20250717161747.GG2672039@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717161747.GG2672039@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3OSBTYWx0ZWRfX1d0DcaK6nuRc
 Ykn4QE+rWz1xLNyk01nNXPFVshatEvYaqlOcrLWJGMLyRu1RUIH/8Gu09U1vTZpVggolp4Ou29q
 Zslfq1aTj8mJqCILMhvecMIZUcF3aNsH4pKz3W+zZTViYEM93jLgGFjUPSYKs1muVRTDXho61pd
 9hCg0niKlOeCzNXKgV1wVt8i1x4/fIqhe/AnJWUK6UiknngXwMseG+h8B1Eglxn+7eC0aXzVzeV
 SvAqVnH7znABNEW5aemXvsAe28E+QfVrfJau33rAqZ2POOGQUuqAqhcKJw+OBYDfEcL1S3m7Ty4
 CgEDHFuPmZRvcDUn46/67MhnaRweUfkGHBkwSm6aHQhnvtfqSRdaoU4wTk7Bz1cAiopHfUuT4fA
 CFYeu8V3M66kbub9Ck1FRWJ2xLu1+NfN0tJLaugSFDFI7Ie2rmwvI+ku7jZkwmSUfcyJZ6RO
X-Proofpoint-ORIG-GUID: xmIFSctcK-dyd90AKesi5vAaqMFHatIm
X-Authority-Analysis: v=2.4 cv=cIDgskeN c=1 sm=1 tr=0 ts=687f60ef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=IipzgdfrNufsr-TDSacA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: pLWncaHFwhK7sN5QcqX_s5BCD-TJg0qo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220079

On Thu, Jul 17, 2025 at 09:17:47AM -0700, Darrick J. Wong wrote:

<snip>

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
> 
> I don't think you should be modifying offset/size here.  Normally for
> fsx we do all the rounding of the file range in the switch statement
> after the "calculate appropriate op to run" comment statement.
> 
> --D

Yes, I noticed that but then I saw we make size/offset adjustments in
do write for writebdy and I wanted atomic writes adjustments to be done
after that.

Regads,
ojaswin

> 
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
> > @@ -1785,6 +1842,30 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
> >  }
> >  #endif
> >  
> > +int test_atomic_writes(void) {
> > +	int ret;
> > +	struct statx stx;
> > +

