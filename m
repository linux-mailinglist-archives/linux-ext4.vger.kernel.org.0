Return-Path: <linux-ext4+bounces-9199-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A26EB1350A
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 08:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B94C18986FE
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3DA2222C2;
	Mon, 28 Jul 2025 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XRMIkPuE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21689221F38;
	Mon, 28 Jul 2025 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685020; cv=none; b=sVBcoRNjFPIU7xcxjgo3yyiMe7vLoz2XJ1FlcK/Jwj5Qk9GKJnKnB5G2ZFo427ab0mzAaZCcOUE0gaqsZdBN2Smn8LWIfUhjsL29E5mDMr/asMpXH2q4+UW1zvVrMo38F/eEvHZSfangUD3csyWsBT3wvqbKQ/0F1b3d63On2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685020; c=relaxed/simple;
	bh=D/d9L9bXCgW6TpFJoDp032l3Gste1XPEGvq0CaQ9RFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EalcuvE4/Ae6nYchqanOp/4SY8BrQu1cK1ztS8pTwl2XdP7Fv0zeiliRvZZDSCGj7ZIf0j/onlv+QwUElzuGQye9YkbCXdtGdHGr3hLutwit8ggQgTwmPyPMSX9562sLQZzKRykNX520oDfd1YqYFgAc2mfKJCE+VxKRlpWk4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XRMIkPuE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RIOp1r019519;
	Mon, 28 Jul 2025 06:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xQpnxJxh1krXVR5+57oDQtm476r2Vj
	VwCatcfjg8ohk=; b=XRMIkPuERu0eAL1rVcQwUSyRBXg/Fn/l4FOYX5Lg1kboQk
	BflEJ9Ofs0N/0682lIvW/nGWT7REFOIu/mnjCo4fgcRRvYkI6To9sOXP80PlKNKt
	A+en5T9vU64bGRKrGTl8En46knTE2boIe6xphaurDH5evbhVSIvNA3EdKaZJDy/7
	A79HUCun1Wo41G9p//2als9wl7HAJE8Zmk5epcLPyMFlUMB3JlBMA6oz44gWX/qf
	c7kIvitPrDqhZzAZnYdqJOappYor51X0+6Z6BXgYTXNQU8YA5lBE8dzcRE4SzH5o
	w1tRfG9LEEe1f93CA4Nm+u1+wQ7aDkSH8fvAkR/w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd57ddy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 06:43:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56S6hVhM013988;
	Mon, 28 Jul 2025 06:43:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd57ddv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 06:43:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4S3tT017969;
	Mon, 28 Jul 2025 06:43:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859btcs97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 06:43:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56S6hSVA57999622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 06:43:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FFF120043;
	Mon, 28 Jul 2025 06:43:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAC4720040;
	Mon, 28 Jul 2025 06:43:25 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.44])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Jul 2025 06:43:25 +0000 (GMT)
Date: Mon, 28 Jul 2025 12:13:22 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <1e6dad5f4bdc8107e670cc0bd3ce0fccd0c9037a.1752329098.git.ojaswin@linux.ibm.com>
 <5211dff7-579b-48ea-8180-72d8c6083400@oracle.com>
 <aHkAJJkvaWYJu7gC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <b270bb66-721e-4433-adaf-fe5ae100ca6e@oracle.com>
 <aH9PwFm06n9KQ0mE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7fc0f04e-dcec-47a4-b522-eb5a8b90637c@oracle.com>
 <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
 <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0NiBTYWx0ZWRfX5iGI6l6t9FKw
 EtmZ4rAphXwvvu8iQK9vBjjHcl5b8GWL9MZfsHSdZ3dxTMLSkeBcwhywouVvwN1Pa6kb+dFaVxe
 SbhomVL2eylZmC8gOa0T6AKkcBlDJ8NPZMnaLGn90wRHit5yikDI4j+F8rXKeyh3k+T8Dtn9Gzv
 c8n32QJk1xf1+24HShYhLQuUU2T9l07fpcFpKD+AZII8Lmcuuq3hEWkDvYCumcpD7eAKHknT1eA
 vhFh05I4kmmySuCyQqwqR9rpRhvK9iKFUiwtsrkp4fbIjZbnFArqc8GsiB65kyLKOIhUTEmnic/
 C2GtYnSpXPakuwacyIaaDGklVkrdXh5JzcPR31cX9GEXRH/AOytPi85HrFmYEIoHporI8/T55Mv
 WQy1NSov0DB5djvxzVHb6gQSVV8NTDcKk0pAsq+duUPanH5yOYjS+QHDt10GxO/KQC89NcQB
X-Proofpoint-ORIG-GUID: PNNte2esEmtSIruJ5eTeWwSHJmqpaUjV
X-Authority-Analysis: v=2.4 cv=B9q50PtM c=1 sm=1 tr=0 ts=68871c13 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=-OdOtWGfYfkQm_KkuHIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: aCCOUDraQ5Jm2OhXwQ-BkDAf5wMzq-29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280046

On Fri, Jul 25, 2025 at 09:14:25AM +0100, John Garry wrote:
> On 25/07/2025 07:27, Ojaswin Mujoo wrote:
> > On Wed, Jul 23, 2025 at 05:25:41PM +0100, John Garry wrote:
> > > On 23/07/2025 14:51, Ojaswin Mujoo wrote:
> > > > > > No, its just something i hardcoded for that particular run. This patch
> > > > > > doesn't enforce hardware only atomic writes
> > > > > If we are to test this for XFS then we need to ensure that HW atomics are
> > > > > available.
> > > > Why is that? Now with the verification step happening after writes,
> > > > software atomic writes should also pass this test since there are no
> > > > racing writes to the verify reads.
> > > Sure, but racing software atomic writes against other software atomic writes
> > > is not safe.
> > > 
> > > Thanks,
> > > John
> > What do you mean by not safe?
> 
> Multiple threads issuing atomic writes may trample over one another.
> 
> It is due to the steps used to issue an atomic write in xfs by software
> method. Here we do 3x steps:
> a. allocate blocks for out-of-place write
> b. do write in those blocks
> c. atomically update extent mapping.
> 
> In this, threads wanting to atomic write to the same address will use the
> new blocks and can trample over one another before we atomically update the
> mapping.

So iiuc, w/ software fallback, a thread atomically writing to a range
will use a new block A. Another parallel thread trying to atomically
write to the same range will also use A, and there is no serialization
b/w the 2 so A could end up with a mix of data from both threads.

If this is true, aren't we violating the atomic guarantees. Nothing
prevents the userspace from doing overlapping parallel atomic writes and
it is kernels duty to error out if the write could get torn.
> 
> So we do not guarantee serialization of atomic writes vs atomic writes. And
> this is why I said that this test is never totally safe for xfs.
> 
> We could change this simply to have serialization of software-based atomic
> writes against all other dio, like follows:
> 
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -747,6 +747,7 @@ xfs_file_dio_write_atomic(
>        unsigned int            iolock = XFS_IOLOCK_SHARED;
>        ssize_t                 ret, ocount = iov_iter_count(from);
>        const struct iomap_ops  *dops;
> +       unsigned int            dio_flags = 0;
> 
>        /*
>         * HW offload should be faster, so try that first if it is already
> @@ -766,15 +767,12 @@ xfs_file_dio_write_atomic(
>        if (ret)
>                goto out_unlock;
> 
> -       /* Demote similar to xfs_file_dio_write_aligned() */
> -       if (iolock == XFS_IOLOCK_EXCL) {
> -               xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
> -               iolock = XFS_IOLOCK_SHARED;
> -       }
> +       if (dio_flags & IOMAP_DIO_FORCE_WAIT)
> +               inode_dio_wait(VFS_I(ip));
> 
>        trace_xfs_file_direct_write(iocb, from);
>        ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
> -                       0, NULL, 0);
> +                       dio_flags, NULL, 0);
> 
>        /*
>         * The retry mechanism is based on the ->iomap_begin method returning
> @@ -785,6 +783,8 @@ xfs_file_dio_write_atomic(
>        if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
>                xfs_iunlock(ip, iolock);
>                dops = &xfs_atomic_write_cow_iomap_ops;
> +               iolock = XFS_IOLOCK_EXCL;
> +               dio_flags = IOMAP_DIO_FORCE_WAIT;
>                goto retry;
>        }
> 
> 
> But it may affect performance.
> 
> > Does it mean the test can fail?
> 
> Yes, but it is unlikely if we have HW atomics available. That is because we
> will rarely be using software-based atomic method, as HW method should often
> be possible.

Yes, but having a chance to tear the write when it is not possible is
not the right behavior.
> 

