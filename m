Return-Path: <linux-ext4+bounces-11006-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62744BF6567
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 14:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBED419A30BC
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E7336EC3;
	Tue, 21 Oct 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EK/6Maug"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3392F28EB;
	Tue, 21 Oct 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047936; cv=none; b=Ugc1Ns0dxUjidQslbBAzQ40Sd/6IBva5uYX65cu3GFuGhEJD75bBTF8FmIm4pgdR1umP5uo4SO3Os2XN9ax6SkmFx+c7cCiBhyZzlJjEf6cpwB4IQl0CngYxhfYvguMoAXaWQHlWtJjrIvFIdPVdhTp8EoiKRw7IxrUDjzkfpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047936; c=relaxed/simple;
	bh=4vCQeUMuwJVn1liN/o0t3oAXe2FJ7036N5nvBCXIwa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ1rodMRwfAMz7hMmc22BNFa1EwuvH9xc7VAr9LVs7zpc2h9EZZJ+ePVhcv3ntAusjHlEcHvOl30r37HFvsINv/Dh5aRNS/W7XxKMjGg9Ew4xNl9T0jxLuN9lI8x1jjakh22u2Yf9wWBobMonZyG4eb8HIyLRZM+5DBN/If15Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EK/6Maug; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L76w1k011773;
	Tue, 21 Oct 2025 11:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qYyGerYvqySxQq/5Tn3/7y2ZsQeg62
	8Jw8e+LRF3p5c=; b=EK/6MaugRDHex6xYt2VxaGemmVMrZvqs46HBQ6n69RglTM
	n3Lg8ca+DQgTZb7m5a07bsYJEopWo2ZrXVwYM8mHGZUiH4+a9/hRFSENe+OZKT4C
	6Oo8cEBhgIAqTCzln/k0RpD6W5Za8bcMv4o/Ksjays4frKuAowv/b3rgaS4N8mWI
	cSCaEBN+obsm0vliQ8k0mZoaL4SAacITLZU/tRHmSMo09T0EwvcdlkmfbmNpACaN
	qaJB4EAsLlbX0U4/1hK7A/QlHyQprn8G2ThvammbE3nhnQ8Pqoj/2L1dF9qt4Dxz
	6a2aM4WgmjKbywnGDMjUvhN6WkcKqWqMXm1DBeIg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c5gp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 11:58:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LBweff019291;
	Tue, 21 Oct 2025 11:58:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c5gny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 11:58:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LBVUIM017066;
	Tue, 21 Oct 2025 11:58:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnkxtmey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 11:58:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59LBwbad34341264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 11:58:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 515F92004B;
	Tue, 21 Oct 2025 11:58:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EE4D20040;
	Tue, 21 Oct 2025 11:58:35 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.23.251])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Oct 2025 11:58:34 +0000 (GMT)
Date: Tue, 21 Oct 2025 17:28:32 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Brian Foster <bfoster@redhat.com>
Cc: John Garry <john.g.garry@oracle.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aPd1aKVFImgXpULn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <c3a040b249485b02b569b9269b649d02d721d995.1758264169.git.ojaswin@linux.ibm.com>
 <20250928131924.b472fjxwir7vphsr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251005153956.zofernclbbva3xt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOPCAzx0diQy7lFN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <66470caf-ec35-4f7d-adac-4a1c22a40a3e@oracle.com>
 <aPdgR5gdA3l3oTLQ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aPdu2DtLSNrI7gfp@bfoster>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPdu2DtLSNrI7gfp@bfoster>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Aq_ciUVYbjYLJjYrHn3ZEEs1dCFZaB1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwO+gIpKNArub
 WRbAQctQSxJAPKarFLUfkY5WXgkYkvT57PlVS5UYoxernyzQ7IEeSUGNN6vsIpNxhu04nT/zTPL
 ZmIOzbUN1ys+IkOnLPYx9wNcF8ctUO1qlVxseRc7l8R7qhWmdc6iIKmQ/F34wqE99NZKOlybqDV
 5zLfeQ4Y5wGKtZHIebeNJSRVfseS0QKozmnZvdf2A1SqxT3UfVhSDSbYedO5NNVoRXglmrwpx/A
 +Y9EvWd51O/A8m8DAVun3TZlA5Eq5gSTIdtQRGkKj4X8XLrcMnLEuz+wAOIU5jtw3xL2dshubjw
 vjhiNO9l6bC7BSonT/VFlLZ/V1yBw560aKhgZsWPbH9Bb7g4WA9IcQuP/4UZr2VFJa7QnzuGiXu
 EGGW1Zdz5xNrrel8BXPzEK5AQSCkyg==
X-Proofpoint-GUID: -WajRCcHJlyPpBKDWpmbdlVapByhVn0x
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f77570 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=2ed1ObRlMEeHHuHt-psA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Tue, Oct 21, 2025 at 07:30:32AM -0400, Brian Foster wrote:
> On Tue, Oct 21, 2025 at 03:58:23PM +0530, Ojaswin Mujoo wrote:
> > On Mon, Oct 20, 2025 at 11:33:40AM +0100, John Garry wrote:
> > > On 06/10/2025 14:20, Ojaswin Mujoo wrote:
> > > > Hi Zorro, thanks for checking this. So correct me if im wrong but I
> > > > understand that you have run this test on an atomic writes enabled
> > > > kernel where the stack also supports atomic writes.
> > > > 
> > > > Looking at the bad data log:
> > > > 
> > > > 	+READ BAD DATA: offset = 0x1c000, size = 0x1803, fname = /mnt/xfstests/test/junk
> > > > 	+OFFSET      GOOD    BAD     RANGE
> > > > 	+0x1c000     0x0000  0xcdcd  0x0
> > > > 	+operation# (mod 256) for the bad data may be 205
> > > > 
> > > > We see that 0x0000 was expected but we got 0xcdcd. Now the operation
> > > > that caused this is indicated to be 205, but looking at that operation:
> > > > 
> > > > +205(205 mod 256): ZERO     0x6dbe6 thru 0x6e6aa	(0xac5 bytes)
> > > > 
> > > > This doesn't even overlap the range that is bad. (0x1c000 to 0x1c00f).
> > > > Infact, it does seem like an unlikely coincidence that the actual data
> > > > in the bad range is 0xcdcd which is something xfs_io -c "pwrite" writes
> > > > to default (fsx writes random data in even offsets and operation num in
> > > > odd).
> > > > 
> > > > I am able to replicate this but only on XFS but not on ext4 (atleast not
> > > > in 20 runs).  I'm trying to better understand if this is a test issue or
> > > > not. Will keep you update.
> > > 
> > > 
> > > Hi Ojaswin,
> > > 
> > > Sorry for the very slow response.
> > > 
> > > Are you still checking this issue?
> > > 
> > > To replicate, should I just take latest xfs kernel and run this series on
> > > top of latest xfstests? Is it 100% reproducible?
> > > 
> > > Thanks,
> > > John
> > 
> > Hi John,
> > 
> > Yes Im looking into it but I'm now starting to run into some reflink/cow
> > based concepts that are taking time to understand. Let me share what I
> > have till now:
> > 
> > So the test.sh that I'm using can be found here [1] which just uses an
> > fsx replay file (which replays all operations) present in the same repo
> > [2]. If you see the replay file, there are a bunch of random operations
> > followed by the last 2 commented out operations:
> > 
> > # copy_range 0xd000 0x1000 0x1d800 0x44000   <--- # operations <start> <len> <dest of copy> <filesize (can be ignored)>
> > # mapread 0x1e000 0x1000 0x1e400 *
> > 
> > The copy_range here is the one which causes (or exposes) the corruption
> > at 0x1e800 (the end of copy range destination gets corrupted).
> > 
> > To have more control, I commented these 2 operations and am doing it by
> > hand in the test.sh file, with xfs_io. I'm also using a non atomic write
> > device so we only have S/W fallback.
> > 
> > Now some observations:
> > 
> > 1. The copy_range operations is actually copying from a hole to a hole,
> > so we should be reading all 0s. But What I see is the following happening:
> > 
> >   vfs_copy_file_range
> >    do_splice_direct
> >     do_splice_direct_actor
> >      do_splice_read
> >        # Adds the folio at src offset to the pipe. I confirmed this is all 0x0.
> >      splice_direct_to_actor
> >       direct_splice_actor
> >        do_splice_from
> >         iter_file_splice_write
> >          xfs_file_write_iter
> >           xfs_file_buffered_write
> >            iomap_file_buferred_write
> >             iomap_iter
> >              xfs_buferred_write_iomap_begin
> >                # Here we correctly see that there is noting at the
> >                # destination in data fork, but somehow we find a mapped
> >                # extent in cow fork which is returned to iomap.
> >              iomap_write_iter
> >               __iomap_write_begin
> >                 # Here we notice folio is not uptodate and call
> >                 # iomap_read_folio_range() to read from the cow_fork
> >                 # mapping we found earlier. This results in folio having
> >                 # incorrect data at 0x1e800 offset.
> > 
> >  So it seems like the fsx operations might be corrupting the cow fork state
> >  somehow leading to stale data exposure. 
> > 
> > 2. If we disable atomic writes we dont hit the issue.
> > 
> > 3. If I do a -c pread of the destination range before doing the
> > copy_range operation then I don't see the corruption any more.
> > 
> > I'm now trying to figure out why the mapping returned is not IOMAP_HOLE
> > as it should be. I don't know the COW path in xfs so there are some gaps
> > in my understanding. Let me know if you need any other information since
> > I'm reliably able to replicate on 6.17.0-rc4.
> > 
> 
> I haven't followed your issue closely, but just on this hole vs. COW
> thing, XFS has a bit of a quirk where speculative COW fork preallocation
> can expand out over holes in the data fork. If iomap lookup for buffered
> write sees COW fork blocks present, it reports those blocks as the
> primary mapping even if the data fork happens to be a hole (since
> there's no point in allocating blocks to the data fork when we can just
> remap).
> 
> Again I've no idea if this relates to your issue or what you're
> referring to as a hole (i.e. data fork only?), but just pointing it out.
> The latest iomap/xfs patches I posted a few days ago kind of dance
> around this a bit, but I was somewhat hoping that maybe the cleanups
> there would trigger some thoughts on better iomap reporting in that
> regard.

Hi Brian, Thanks for the details and yes by "hole" i did mean hole in
data fork only. The part that I'm now confused about is does this sort
of preallocation extent hold any valid data? IIUC it should not, so I
would expect it to trigger iomap_block_needs_zeroing() to write zeroes
to the folio. Instead, what I see in the issue is that we are trying to
do disk read.

Regards,
ojaswin
> 
> Brian

> 
> > [1]
> > https://github.com/OjaswinM/fsx-aw-issue/tree/master
> > 
> > [2] https://github.com/OjaswinM/fsx-aw-issue/blob/master/repro.fsxops
> > 
> > regards,
> > ojaswin
> > 
> 

