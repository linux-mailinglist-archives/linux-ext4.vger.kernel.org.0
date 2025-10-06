Return-Path: <linux-ext4+bounces-10639-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC529BBE2AD
	for <lists+linux-ext4@lfdr.de>; Mon, 06 Oct 2025 15:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8972D4ED3B7
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Oct 2025 13:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707782C3248;
	Mon,  6 Oct 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="db5FxWEG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236A18872A;
	Mon,  6 Oct 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756826; cv=none; b=Yxc7wZg7IKdLaHEGi/+9gcGM8tnR9PxhDLH4H8x/dTJNnmuIxo5bRoAY6sgaO32efmGscFaHsgCBCklpYVYsgmJ3pdeznm9g8vsFagNTLwSgpTnqYOgReifSJs1GTP5ZFDBX4zNfqdGcicBMR4CXWbq/fV0pPtA5QkpTrggLea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756826; c=relaxed/simple;
	bh=GAN8MKxZQN3HrJZ+qCnRJUbdWuET+LWmlhK5xB5RswE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGoeW7iG/8ldQzaG1AbyVjaK9vBYROOpfDk8C3+Jm/cq60nyF4xmme8LHabH0sTN6Mv3LTfKO+QkbkkB1Swk3Bsvh+SvXo2+s6ji9pXr+BxsQpKxDrJCvISGzFwyIZe9Nw8l1784hCMGGrg2lCzptUuxt66bMoRmtGzYTiWa5QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=db5FxWEG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596AeFsP026167;
	Mon, 6 Oct 2025 13:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rPQz2Zk8MLDb5HnBtre5RW+hptJDF9
	yMlAGywrPL/7Q=; b=db5FxWEGuErTWDd9eto4iIRvnPLUkRohStZekuNVjz6tAO
	IF5f7+mjzoxYH0/iOaV4z5i8G5Bud0Nsv3d0uaGIfYQFImctVhHiaarHg9COBMpd
	45NrW3LWF8RuCcbVa1R0Attor2xeTn33C7lMbyNGM2gHzZ3qb+O3JAi9zJF2Z4xJ
	yqX6/spGLyVbtDASmMW7X5fJ3UIQqXxKjCeq9ZI3FLDSrIcfh+zhBN0LNySO791u
	SaGI5+TNOphtF63+yplb/IQ4/DDKvD9KB78kSdniVXsBh5Qsy2JBnO0uOjuKddnR
	Tg/oyBqwFa9a1KRJ+6j7Z9zcT8/aqt36Juqv6XvQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju8ah19s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 13:20:10 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 596DKAGT020248;
	Mon, 6 Oct 2025 13:20:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju8ah19n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 13:20:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5969cAaQ028443;
	Mon, 6 Oct 2025 13:20:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kewmx52y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 13:20:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 596DK7Im50594178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Oct 2025 13:20:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F2012004B;
	Mon,  6 Oct 2025 13:20:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DD2320040;
	Mon,  6 Oct 2025 13:20:05 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Oct 2025 13:20:05 +0000 (GMT)
Date: Mon, 6 Oct 2025 18:50:03 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aOPCAzx0diQy7lFN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <c3a040b249485b02b569b9269b649d02d721d995.1758264169.git.ojaswin@linux.ibm.com>
 <20250928131924.b472fjxwir7vphsr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251005153956.zofernclbbva3xt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005153956.zofernclbbva3xt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x_-iZWWAYB6ZGcdzgv673gKZ31JDN_dC
X-Authority-Analysis: v=2.4 cv=BpiQAIX5 c=1 sm=1 tr=0 ts=68e3c20a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=KhzlYSSnZSZoo7An4sMA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX00xsKLkHrR6x
 m4ZW/nYCPBl5px3zrSoLD8NKuXfnfNCGTKqLHdLiwsgvE7P6+MIzx+Vhm2bCjww5OaUysP7vqmh
 RaY8pIMfO1qKjOf9y1imCXQ+hD4RLdxhD8YXEAni5c2oEzFOPcoW1hM20FEoFWE5u6Y3RrniKZa
 cjl5PUUbAWN7XtariCXBi3L3bdvmWl4G94sqJgK6oFjio5Ozf6YrzhxQeT669Am7ehxPey6PrLO
 oBAj/42qXqdeKHr+iaggOmusIfDX1DBN20h27YWXVzMaYbPGwuYV/C4lmclO1476/Or1ijcFoLp
 whXC2sLTwCDSrlxwtDSMqDNQ0HwUaop3iofhQoD0hr00y8YbacmCkSJZFh/AGv8UqQoSROUlI4n
 cfibErkAaczEZHaoqD8IbTqD5T0q9w==
X-Proofpoint-ORIG-GUID: BKVGDBmBJdBMT_GIsIc7FCYGKOKA8Gmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040022

On Sun, Oct 05, 2025 at 11:39:56PM +0800, Zorro Lang wrote:
> On Sun, Oct 05, 2025 at 06:27:24PM +0530, Ojaswin Mujoo wrote:
> > On Sat, Oct 04, 2025 at 01:19:32AM +0800, Zorro Lang wrote:
> > > On Thu, Oct 02, 2025 at 11:26:45PM +0530, Ojaswin Mujoo wrote:
> > > > On Sun, Sep 28, 2025 at 09:19:24PM +0800, Zorro Lang wrote:
> > > > > On Fri, Sep 19, 2025 at 12:17:57PM +0530, Ojaswin Mujoo wrote:
> > > > > > Implement atomic write support to help fuzz atomic writes
> > > > > > with fsx.
> > > > > > 
> > > > > > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > > > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > > > ---
> > > > > 
> > > > > Hmm... this patch causes more regular fsx test cases fail on old kernel,
> > > > > (e.g. g/760, g/617, g/263 ...) except set "FSX_AVOID=-a". Is there a way
> > > > > to disable "atomic write" automatically if it's not supported by current
> > > > > system?
> > > > 
> > > > Hi Zorro, 
> > > > Sorry for being late, I've been on vacation this week.
> > > > 
> > > > Yes so by design we should be automatically disabling atomic writes when
> > > > they are not supported by the stack but seems like the issue is that
> > > > when we do disable it we print some extra messages to stdout/err which
> > > > show up in the xfstests output causing failure.
> > > > 
> > > > I can think of 2 ways around this:
> > > > 
> > > > 1. Don't print anything and just silently drop atomic writes if stack
> > > > doesn't support them.
> > > > 
> > > > 2. Make atomic writes as a default off instead of default on feature but
> > > > his loses a bit of coverage as existing tests wont get atomic write
> > > > testing free of cost any more.
> > > 
> > > Hi Ojaswin,
> > > 
> > > Please have a nice vacation :)
> > > 
> > > It's not the "extra messages" cause failure, those "quiet" failures can be fixed
> > > by:
> > 
> > Oh okay got it.
> > 
> > > 
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index bdb87ca90..0a035b37b 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -1847,8 +1847,9 @@ int test_atomic_writes(void) {
> > >         struct statx stx;
> > >  
> > >         if (o_direct != O_DIRECT) {
> > > -               fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
> > > -                               "disabling!\n");
> > > +               if (!quiet)
> > > +                       fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
> > > +                                       "disabling!\n");
> > >                 return 0;
> > >         }
> > >  
> > > @@ -1867,8 +1868,9 @@ int test_atomic_writes(void) {
> > >                 return 1;
> > >         }
> > >  
> > > -       fprintf(stderr, "main: IO Stack does not support "
> > > -                       "atomic writes, disabling!\n");
> > > +       if (!quiet)
> > > +               fprintf(stderr, "main: IO Stack does not support "
> > > +                               "atomic writes, disabling!\n");
> > >         return 0;
> > >  }
> > 
> > > 
> > > But I hit more read or write failures e.g. [1], this failure can't be
> > > reproduced with FSX_AVOID=-a. Is it a atomic write bug or an unexpected
> > > test failure?
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > 
> > <...>
> > 
> > > +244(244 mod 256): SKIPPED (no operation)
> > > +245(245 mod 256): FALLOC   0x695c5 thru 0x6a2e6	(0xd21 bytes) INTERIOR
> > > +246(246 mod 256): MAPWRITE 0x5ac00 thru 0x5b185	(0x586 bytes)
> > > +247(247 mod 256): WRITE    0x31200 thru 0x313ff	(0x200 bytes)
> > > +248(248 mod 256): SKIPPED (no operation)
> > > +249(249 mod 256): TRUNCATE DOWN	from 0x78242 to 0xf200	******WWWW
> > > +250(250 mod 256): FALLOC   0x65000 thru 0x66f26	(0x1f26 bytes) PAST_EOF
> > > +251(251 mod 256): WRITE    0x45400 thru 0x467ff	(0x1400 bytes) HOLE	***WWWW
> > > +252(252 mod 256): SKIPPED (no operation)
> > > +253(253 mod 256): SKIPPED (no operation)
> > > +254(254 mod 256): MAPWRITE 0x4be00 thru 0x4daee	(0x1cef bytes)
> > > +255(255 mod 256): MAPREAD  0xc000 thru 0xcae9	(0xaea bytes)
> > > +256(  0 mod 256): READ     0x3e000 thru 0x3efff	(0x1000 bytes)
> > > +257(  1 mod 256): SKIPPED (no operation)
> > > +258(  2 mod 256): INSERT 0x45000 thru 0x45fff	(0x1000 bytes)
> > > +259(  3 mod 256): ZERO     0x1d7d5 thru 0x1f399	(0x1bc5 bytes)	******ZZZZ
> > > +260(  4 mod 256): TRUNCATE DOWN	from 0x4eaef to 0x11200	******WWWW
> > > +261(  5 mod 256): WRITE    0x43000 thru 0x43fff	(0x1000 bytes) HOLE	***WWWW
> > > +262(  6 mod 256): WRITE    0x2200 thru 0x31ff	(0x1000 bytes)
> > > +263(  7 mod 256): WRITE    0x15000 thru 0x15fff	(0x1000 bytes)
> > > +264(  8 mod 256): WRITE    0x2e400 thru 0x2e7ff	(0x400 bytes)
> > > +265(  9 mod 256): COPY 0xd000 thru 0xdfff	(0x1000 bytes) to 0x1d800 thru 0x1e7ff	******EEEE
> > > +266( 10 mod 256): CLONE 0x2a000 thru 0x2afff	(0x1000 bytes) to 0x21000 thru 0x21fff
> > > +267( 11 mod 256): MAPREAD  0x31000 thru 0x31d0a	(0xd0b bytes)
> > > +268( 12 mod 256): SKIPPED (no operation)
> > > +269( 13 mod 256): WRITE    0x25000 thru 0x25fff	(0x1000 bytes)
> > > +270( 14 mod 256): SKIPPED (no operation)
> > > +271( 15 mod 256): MAPREAD  0x30000 thru 0x30577	(0x578 bytes)
> > > +272( 16 mod 256): PUNCH    0x1a267 thru 0x1c093	(0x1e2d bytes)
> > > +273( 17 mod 256): MAPREAD  0x1f000 thru 0x1f9c9	(0x9ca bytes)
> > > +274( 18 mod 256): WRITE    0x40800 thru 0x40dff	(0x600 bytes)
> > > +275( 19 mod 256): SKIPPED (no operation)
> > > +276( 20 mod 256): MAPWRITE 0x20600 thru 0x22115	(0x1b16 bytes)
> > > +277( 21 mod 256): MAPWRITE 0x3d000 thru 0x3ee5a	(0x1e5b bytes)
> > > +278( 22 mod 256): WRITE    0x2ee00 thru 0x2efff	(0x200 bytes)
> > > +279( 23 mod 256): WRITE    0x76200 thru 0x769ff	(0x800 bytes) HOLE
> > > +280( 24 mod 256): SKIPPED (no operation)
> > > +281( 25 mod 256): SKIPPED (no operation)
> > > +282( 26 mod 256): MAPREAD  0xa000 thru 0xa5e7	(0x5e8 bytes)
> > > +283( 27 mod 256): SKIPPED (no operation)
> > > +284( 28 mod 256): SKIPPED (no operation)
> > > +285( 29 mod 256): SKIPPED (no operation)
> > > +286( 30 mod 256): SKIPPED (no operation)
> > > +287( 31 mod 256): COLLAPSE 0x11000 thru 0x11fff	(0x1000 bytes)
> > > +288( 32 mod 256): COPY 0x5d000 thru 0x5dfff	(0x1000 bytes) to 0x4ca00 thru 0x4d9ff
> > > +289( 33 mod 256): TRUNCATE DOWN	from 0x75a00 to 0x1e400
> > > +290( 34 mod 256): MAPREAD  0x1c000 thru 0x1d802	(0x1803 bytes)	***RRRR***
> > > +Log of operations saved to "/mnt/xfstests/test/junk.fsxops"; replay with --replay-ops
> > > +Correct content saved for comparison
> > > +(maybe hexdump "/mnt/xfstests/test/junk" vs "/mnt/xfstests/test/junk.fsxgood")
> > > 
> > > Thanks,
> > > Zorro
> > 
> > Hi Zorro, just to confirm is this on an older kernel that doesnt support
> > RWF_ATOMIC or on a kernle that does support it.
> 
> I tested on linux 6.16 and current latest linux v6.17+ (will be 6.18-rc1 later).
> About the RWF_ATOMIC flag in my system:
> 
> # grep -rsn RWF_ATOMIC /usr/include/
> /usr/include/bits/uio-ext.h:51:#define RWF_ATOMIC       0x00000040 /* Write is to be issued with torn-write
> /usr/include/linux/fs.h:424:#define RWF_ATOMIC  ((__kernel_rwf_t)0x00000040)
> /usr/include/linux/fs.h:431:                     RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
> /usr/include/xfs/linux.h:236:#ifndef RWF_ATOMIC
> /usr/include/xfs/linux.h:237:#define RWF_ATOMIC ((__kernel_rwf_t)0x00000040)

Hi Zorro, thanks for checking this. So correct me if im wrong but I
understand that you have run this test on an atomic writes enabled 
kernel where the stack also supports atomic writes.

Looking at the bad data log:

	+READ BAD DATA: offset = 0x1c000, size = 0x1803, fname = /mnt/xfstests/test/junk
	+OFFSET      GOOD    BAD     RANGE
	+0x1c000     0x0000  0xcdcd  0x0
	+operation# (mod 256) for the bad data may be 205

We see that 0x0000 was expected but we got 0xcdcd. Now the operation
that caused this is indicated to be 205, but looking at that operation:

+205(205 mod 256): ZERO     0x6dbe6 thru 0x6e6aa	(0xac5 bytes)

This doesn't even overlap the range that is bad. (0x1c000 to 0x1c00f).
Infact, it does seem like an unlikely coincidence that the actual data
in the bad range is 0xcdcd which is something xfs_io -c "pwrite" writes
to default (fsx writes random data in even offsets and operation num in
odd).

I am able to replicate this but only on XFS but not on ext4 (atleast not
in 20 runs).  I'm trying to better understand if this is a test issue or
not. Will keep you update.

I'm not sure how this will affect the upcoming release, if you want
shall I send a small patch to make the atomic writes feature default off
instead of default on till we root cause this?

Regards,
Ojaswin

> 
> Thanks,
> Zorro
> 
> > 
> > Regards,
> > ojaswin
> > 
> 

