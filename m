Return-Path: <linux-ext4+bounces-10631-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8913DBB9670
	for <lists+linux-ext4@lfdr.de>; Sun, 05 Oct 2025 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018881895952
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Oct 2025 12:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9D628750A;
	Sun,  5 Oct 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P7HuhMFk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14826F296;
	Sun,  5 Oct 2025 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669075; cv=none; b=OcY/nK3o6Rwn+hDE3A9MYK/Heu4GYX8UhDeuBMFyNt529GE4Pr/Wl8nrD9Yrux+AW+gAIQKRMpPfqNV5NOITxiGyB3/gk8RetZyVr7qqnMacvy55DTlupqhicOiQ21fcXp4WJVv8MCmu+clhVnhcVRm0K59UQtwcIQD1PmAHOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669075; c=relaxed/simple;
	bh=JOtrgIFMA/XfbL6fHJCJRpqC1D4e4vVoAsCZGZ5+H9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYBvdZLBzEFC0rOtQhrBnc8NiBJnadbXT6xBiYiVuwjalZanNyWToQrvjaNOgfRz6zNaDsWcII21H1RHv7MGzDlOIwjjDaFjbcwhMl71qrrnIFIRQ7YI9gdQrGz5C68bodRDtsTdWd+gTRZL8vgKWQUP8sSEW+q3/C4YFuBCtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P7HuhMFk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595BG849012592;
	Sun, 5 Oct 2025 12:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Fq2MpqyxaLCZkO5uTWI87jwkjhWfjE
	x+GVMgvaCqS8E=; b=P7HuhMFksu1HfV/nDvnxpjHKiJIoNBquc2vgq/lOSkPVbw
	yKyb55fbyNHbB9nzImH39xiWVwx2+wfNZ0FNHJ7acFsiDxqhyRnZxF8QUduADrzU
	hs+opK/YTRbUn06c+NBdXi8X5RRYbRdx1m7QUcb+7nN6m+SIastxPtavcQDNBc/N
	yAp4xH9A/DOnzczcp+zzDMn6NuRqtl9yaVARk04+sdX/ree+s0FWW5ghrmqIJ1Fq
	1ZQ7FvKrpkVNGGBHd7B5NBoLzwaJdTJg4KaOmKoyT8TED10DIKKiwg79gbKK4j7n
	kgApqe1driMKI7IawbLYtMFn6YWtcVdavcFuoCWw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju8ackjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Oct 2025 12:57:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 595Cva2V031349;
	Sun, 5 Oct 2025 12:57:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju8ackjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Oct 2025 12:57:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5958pDBt013206;
	Sun, 5 Oct 2025 12:57:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kg4j9evj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Oct 2025 12:57:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 595CvYEe52494844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Oct 2025 12:57:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2559320043;
	Sun,  5 Oct 2025 12:57:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C25A220040;
	Sun,  5 Oct 2025 12:57:31 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.138])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  5 Oct 2025 12:57:31 +0000 (GMT)
Date: Sun, 5 Oct 2025 18:27:24 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <c3a040b249485b02b569b9269b649d02d721d995.1758264169.git.ojaswin@linux.ibm.com>
 <20250928131924.b472fjxwir7vphsr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E9LjcbRf2ACn-j0Otu8rlDNde32xW-yj
X-Authority-Analysis: v=2.4 cv=BpiQAIX5 c=1 sm=1 tr=0 ts=68e26b41 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=4M2DtjJ0x0aIFulMiq0A:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX3/KYNw2nye67
 RjPXL4u0mUOsmV+E4AtWRvTlKjjgACWD0905oVurAdGpWzwlTe9FXbVQlQzWV4kUEYji4dVjmlR
 BEkv3U1GAYxWAn64QYfwjQn6wRGtTOO9AYTMy2FClIu3yp7+Zjd/JLM+HXuqxj1fit6j4XVikp/
 v2aHP2KdxN8W/Fq6KOtP92pWM5h16S0JXB8PlBBLHuE2ESABVqvg9xCiAPEm0BDa2LFyx2EEIR+
 pncCMvezEO/tZznKsF2Al+7pylKt51G3g0GWw0KUdkjBe/3qWm/gWUJcM+bqubJWxnFtCMRT00Z
 s9ir35ywlW95JPeKd/1EiKznlucK29JOfMEO8JH6byOVbkczRwhVCDk5Cf+hanLs69Z9kcGsldX
 IFp67+/Ru1pmstBGvB8APNnQCcu3gg==
X-Proofpoint-ORIG-GUID: 7pExbhTlPZ5hfCrC55R04dqPB9GGFGOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040022

On Sat, Oct 04, 2025 at 01:19:32AM +0800, Zorro Lang wrote:
> On Thu, Oct 02, 2025 at 11:26:45PM +0530, Ojaswin Mujoo wrote:
> > On Sun, Sep 28, 2025 at 09:19:24PM +0800, Zorro Lang wrote:
> > > On Fri, Sep 19, 2025 at 12:17:57PM +0530, Ojaswin Mujoo wrote:
> > > > Implement atomic write support to help fuzz atomic writes
> > > > with fsx.
> > > > 
> > > > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > ---
> > > 
> > > Hmm... this patch causes more regular fsx test cases fail on old kernel,
> > > (e.g. g/760, g/617, g/263 ...) except set "FSX_AVOID=-a". Is there a way
> > > to disable "atomic write" automatically if it's not supported by current
> > > system?
> > 
> > Hi Zorro, 
> > Sorry for being late, I've been on vacation this week.
> > 
> > Yes so by design we should be automatically disabling atomic writes when
> > they are not supported by the stack but seems like the issue is that
> > when we do disable it we print some extra messages to stdout/err which
> > show up in the xfstests output causing failure.
> > 
> > I can think of 2 ways around this:
> > 
> > 1. Don't print anything and just silently drop atomic writes if stack
> > doesn't support them.
> > 
> > 2. Make atomic writes as a default off instead of default on feature but
> > his loses a bit of coverage as existing tests wont get atomic write
> > testing free of cost any more.
> 
> Hi Ojaswin,
> 
> Please have a nice vacation :)
> 
> It's not the "extra messages" cause failure, those "quiet" failures can be fixed
> by:

Oh okay got it.

> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index bdb87ca90..0a035b37b 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1847,8 +1847,9 @@ int test_atomic_writes(void) {
>         struct statx stx;
>  
>         if (o_direct != O_DIRECT) {
> -               fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
> -                               "disabling!\n");
> +               if (!quiet)
> +                       fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
> +                                       "disabling!\n");
>                 return 0;
>         }
>  
> @@ -1867,8 +1868,9 @@ int test_atomic_writes(void) {
>                 return 1;
>         }
>  
> -       fprintf(stderr, "main: IO Stack does not support "
> -                       "atomic writes, disabling!\n");
> +       if (!quiet)
> +               fprintf(stderr, "main: IO Stack does not support "
> +                               "atomic writes, disabling!\n");
>         return 0;
>  }

> 
> But I hit more read or write failures e.g. [1], this failure can't be
> reproduced with FSX_AVOID=-a. Is it a atomic write bug or an unexpected
> test failure?
> 
> Thanks,
> Zorro
> 

<...>

> +244(244 mod 256): SKIPPED (no operation)
> +245(245 mod 256): FALLOC   0x695c5 thru 0x6a2e6	(0xd21 bytes) INTERIOR
> +246(246 mod 256): MAPWRITE 0x5ac00 thru 0x5b185	(0x586 bytes)
> +247(247 mod 256): WRITE    0x31200 thru 0x313ff	(0x200 bytes)
> +248(248 mod 256): SKIPPED (no operation)
> +249(249 mod 256): TRUNCATE DOWN	from 0x78242 to 0xf200	******WWWW
> +250(250 mod 256): FALLOC   0x65000 thru 0x66f26	(0x1f26 bytes) PAST_EOF
> +251(251 mod 256): WRITE    0x45400 thru 0x467ff	(0x1400 bytes) HOLE	***WWWW
> +252(252 mod 256): SKIPPED (no operation)
> +253(253 mod 256): SKIPPED (no operation)
> +254(254 mod 256): MAPWRITE 0x4be00 thru 0x4daee	(0x1cef bytes)
> +255(255 mod 256): MAPREAD  0xc000 thru 0xcae9	(0xaea bytes)
> +256(  0 mod 256): READ     0x3e000 thru 0x3efff	(0x1000 bytes)
> +257(  1 mod 256): SKIPPED (no operation)
> +258(  2 mod 256): INSERT 0x45000 thru 0x45fff	(0x1000 bytes)
> +259(  3 mod 256): ZERO     0x1d7d5 thru 0x1f399	(0x1bc5 bytes)	******ZZZZ
> +260(  4 mod 256): TRUNCATE DOWN	from 0x4eaef to 0x11200	******WWWW
> +261(  5 mod 256): WRITE    0x43000 thru 0x43fff	(0x1000 bytes) HOLE	***WWWW
> +262(  6 mod 256): WRITE    0x2200 thru 0x31ff	(0x1000 bytes)
> +263(  7 mod 256): WRITE    0x15000 thru 0x15fff	(0x1000 bytes)
> +264(  8 mod 256): WRITE    0x2e400 thru 0x2e7ff	(0x400 bytes)
> +265(  9 mod 256): COPY 0xd000 thru 0xdfff	(0x1000 bytes) to 0x1d800 thru 0x1e7ff	******EEEE
> +266( 10 mod 256): CLONE 0x2a000 thru 0x2afff	(0x1000 bytes) to 0x21000 thru 0x21fff
> +267( 11 mod 256): MAPREAD  0x31000 thru 0x31d0a	(0xd0b bytes)
> +268( 12 mod 256): SKIPPED (no operation)
> +269( 13 mod 256): WRITE    0x25000 thru 0x25fff	(0x1000 bytes)
> +270( 14 mod 256): SKIPPED (no operation)
> +271( 15 mod 256): MAPREAD  0x30000 thru 0x30577	(0x578 bytes)
> +272( 16 mod 256): PUNCH    0x1a267 thru 0x1c093	(0x1e2d bytes)
> +273( 17 mod 256): MAPREAD  0x1f000 thru 0x1f9c9	(0x9ca bytes)
> +274( 18 mod 256): WRITE    0x40800 thru 0x40dff	(0x600 bytes)
> +275( 19 mod 256): SKIPPED (no operation)
> +276( 20 mod 256): MAPWRITE 0x20600 thru 0x22115	(0x1b16 bytes)
> +277( 21 mod 256): MAPWRITE 0x3d000 thru 0x3ee5a	(0x1e5b bytes)
> +278( 22 mod 256): WRITE    0x2ee00 thru 0x2efff	(0x200 bytes)
> +279( 23 mod 256): WRITE    0x76200 thru 0x769ff	(0x800 bytes) HOLE
> +280( 24 mod 256): SKIPPED (no operation)
> +281( 25 mod 256): SKIPPED (no operation)
> +282( 26 mod 256): MAPREAD  0xa000 thru 0xa5e7	(0x5e8 bytes)
> +283( 27 mod 256): SKIPPED (no operation)
> +284( 28 mod 256): SKIPPED (no operation)
> +285( 29 mod 256): SKIPPED (no operation)
> +286( 30 mod 256): SKIPPED (no operation)
> +287( 31 mod 256): COLLAPSE 0x11000 thru 0x11fff	(0x1000 bytes)
> +288( 32 mod 256): COPY 0x5d000 thru 0x5dfff	(0x1000 bytes) to 0x4ca00 thru 0x4d9ff
> +289( 33 mod 256): TRUNCATE DOWN	from 0x75a00 to 0x1e400
> +290( 34 mod 256): MAPREAD  0x1c000 thru 0x1d802	(0x1803 bytes)	***RRRR***
> +Log of operations saved to "/mnt/xfstests/test/junk.fsxops"; replay with --replay-ops
> +Correct content saved for comparison
> +(maybe hexdump "/mnt/xfstests/test/junk" vs "/mnt/xfstests/test/junk.fsxgood")
> 
> Thanks,
> Zorro

Hi Zorro, just to confirm is this on an older kernel that doesnt support
RWF_ATOMIC or on a kernle that does support it.

Regards,
ojaswin

