Return-Path: <linux-ext4+bounces-11015-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FFBBFAA27
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 09:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52BC550689E
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5762FD699;
	Wed, 22 Oct 2025 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nL20nwzi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B82FBE12;
	Wed, 22 Oct 2025 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118843; cv=none; b=W0PyCuERVX2ItMbk0n9P7aR8CsB4KHea1NGhmuIyGaMB9/6Ai3CP3dR3ZQclTj2HpGuyd75e2x3BqOqiVpirkBHwaXfaLNQdsa7Mr/48djn1++5nLKMXQA1ENNoL3DNbZVGPavfoRu7WO9S4jONly321GdIx+jwoS5qB1HO7+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118843; c=relaxed/simple;
	bh=1U0lNdGL0/FpqaB3FzztK9CeNF8WZq6zq+Py/c5XVKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMdyX6OEmCXm35yQMiIqTE6Wv0lux+J/Ubr5Y3xlZSYBBIyMYmNd2tMF7Wkb3gUXZSpqjHiKGKfqpuP2Q6ITKCnJ8zl9nLPpp6gPiKwF+LnIOejTez5CEl750j4tBlWOrTh+XLhrfAuApv3y87Fv1GJpDU1joB2Z7lTHF7ikGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nL20nwzi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LNwAs3030597;
	Wed, 22 Oct 2025 07:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3GYFrJKERAVY2pFGW94+A5e0n9k2u3
	52kjBW7bWgCfU=; b=nL20nwzi8WTKig979MhOOF23kkDLAZkcQWBFB4mEecDyyk
	h6dmWtz7XSelJlyXoPkhal8ZjMCblUdMS35kbDiUEzXccSt43UMpumnE2Nl1ZeCQ
	cSKf/NRr+eofvNcFubydTIc4FVZ0u9lrxmEotAS93BhPC5nta4lDgp2JA3THvtTE
	RsaCxCr9Mmolrka3W5y7yEOvFzSiaZJ1XQ5pLCI0I44Y6Dpl39JnAXpwGhOFppnA
	2jeNg+taIbpCRecdMZbbj1MocnTK02TmI/qEheStCzDIQ1f5g8icOLb+JW12Yeqj
	Sda7AlAs4CZXoeHCAPt1irYIyR7rLcWIZFz7nQ3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fbddv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 07:40:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59M7eQOF000458;
	Wed, 22 Oct 2025 07:40:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fbddk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 07:40:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7MdmY024677;
	Wed, 22 Oct 2025 07:40:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjy229-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 07:40:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59M7eNMT46203306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 07:40:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80D862004B;
	Wed, 22 Oct 2025 07:40:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E18DF20043;
	Wed, 22 Oct 2025 07:40:20 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.24.211])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Oct 2025 07:40:20 +0000 (GMT)
Date: Wed, 22 Oct 2025 13:10:18 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, John Garry <john.g.garry@oracle.com>,
        Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aPiKYvb2C-VECybc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251005153956.zofernclbbva3xt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOPCAzx0diQy7lFN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <66470caf-ec35-4f7d-adac-4a1c22a40a3e@oracle.com>
 <aPdgR5gdA3l3oTLQ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aPdu2DtLSNrI7gfp@bfoster>
 <aPd1aKVFImgXpULn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251021174406.GR6178@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021174406.GR6178@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f88a6b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=He4DAJOWH0BHP4AadrYA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: siTaPJFkLAXadaw7Sfe5FHy-1da1eEv-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX6yhGuwQVfF1a
 SZ16KmWeoSRUtcq/D3DW8QvwGVJe3/LUZCUSeEGXpSMRq9XvKKFUmjO8EMnrW2zrgtjPvMItZlZ
 aeesmMTg+Xl8O8fzNctAjVZwxD22pMwawMr7RbKSWTWnl91INmPQjAFxEGq2u1JtCoevyVFOeMl
 K5mfqG00lnldUmZATJ4xG6xnO6MZRCDEy7kPfUxoTk761H7LmeykiNgE627x4M80VXGn3AOwDzW
 /4HyspwxxWoAgr5Vgeee4Rq1TPFYYcLKf4Xeox1vgjrDMr7mYG/dpif5DcGqZ0i6YsbTEqVXJws
 MK8HjPsNJzfjufnAYrDFHSu5RP1yzzK1BiCcqc2mPxQG1qCiDp5+/+Rv0Zlg8SIFKH2heRpx6FC
 j7ZxJaOh7yMFSr1/v19ga3YAQwO0cg==
X-Proofpoint-ORIG-GUID: GCg6ElG18HCMGOvbNxPxKviDQ0cp9QOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Tue, Oct 21, 2025 at 10:44:06AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 21, 2025 at 05:28:32PM +0530, Ojaswin Mujoo wrote:
> > On Tue, Oct 21, 2025 at 07:30:32AM -0400, Brian Foster wrote:
> > > On Tue, Oct 21, 2025 at 03:58:23PM +0530, Ojaswin Mujoo wrote:
> > > > On Mon, Oct 20, 2025 at 11:33:40AM +0100, John Garry wrote:
> > > > > On 06/10/2025 14:20, Ojaswin Mujoo wrote:
> > > > > > Hi Zorro, thanks for checking this. So correct me if im wrong but I
> > > > > > understand that you have run this test on an atomic writes enabled
> > > > > > kernel where the stack also supports atomic writes.
> > > > > > 
> > > > > > Looking at the bad data log:
> > > > > > 
> > > > > > 	+READ BAD DATA: offset = 0x1c000, size = 0x1803, fname = /mnt/xfstests/test/junk
> > > > > > 	+OFFSET      GOOD    BAD     RANGE
> > > > > > 	+0x1c000     0x0000  0xcdcd  0x0
> > > > > > 	+operation# (mod 256) for the bad data may be 205
> > > > > > 
> > > > > > We see that 0x0000 was expected but we got 0xcdcd. Now the operation
> > > > > > that caused this is indicated to be 205, but looking at that operation:
> > > > > > 
> > > > > > +205(205 mod 256): ZERO     0x6dbe6 thru 0x6e6aa	(0xac5 bytes)
> > > > > > 
> > > > > > This doesn't even overlap the range that is bad. (0x1c000 to 0x1c00f).
> > > > > > Infact, it does seem like an unlikely coincidence that the actual data
> > > > > > in the bad range is 0xcdcd which is something xfs_io -c "pwrite" writes
> > > > > > to default (fsx writes random data in even offsets and operation num in
> > > > > > odd).
> > > > > > 
> > > > > > I am able to replicate this but only on XFS but not on ext4 (atleast not
> > > > > > in 20 runs).  I'm trying to better understand if this is a test issue or
> > > > > > not. Will keep you update.
> > > > > 
> > > > > 
> > > > > Hi Ojaswin,
> > > > > 
> > > > > Sorry for the very slow response.
> > > > > 
> > > > > Are you still checking this issue?
> > > > > 
> > > > > To replicate, should I just take latest xfs kernel and run this series on
> > > > > top of latest xfstests? Is it 100% reproducible?
> > > > > 
> > > > > Thanks,
> > > > > John
> > > > 
> > > > Hi John,
> > > > 
> > > > Yes Im looking into it but I'm now starting to run into some reflink/cow
> > > > based concepts that are taking time to understand. Let me share what I
> > > > have till now:
> > > > 
> > > > So the test.sh that I'm using can be found here [1] which just uses an
> > > > fsx replay file (which replays all operations) present in the same repo
> > > > [2]. If you see the replay file, there are a bunch of random operations
> > > > followed by the last 2 commented out operations:
> > > > 
> > > > # copy_range 0xd000 0x1000 0x1d800 0x44000   <--- # operations <start> <len> <dest of copy> <filesize (can be ignored)>
> > > > # mapread 0x1e000 0x1000 0x1e400 *
> > > > 
> > > > The copy_range here is the one which causes (or exposes) the corruption
> > > > at 0x1e800 (the end of copy range destination gets corrupted).
> > > > 
> > > > To have more control, I commented these 2 operations and am doing it by
> > > > hand in the test.sh file, with xfs_io. I'm also using a non atomic write
> > > > device so we only have S/W fallback.
> > > > 
> > > > Now some observations:
> > > > 
> > > > 1. The copy_range operations is actually copying from a hole to a hole,
> > > > so we should be reading all 0s. But What I see is the following happening:
> > > > 
> > > >   vfs_copy_file_range
> > > >    do_splice_direct
> > > >     do_splice_direct_actor
> > > >      do_splice_read
> > > >        # Adds the folio at src offset to the pipe. I confirmed this is all 0x0.
> > > >      splice_direct_to_actor
> > > >       direct_splice_actor
> > > >        do_splice_from
> > > >         iter_file_splice_write
> > > >          xfs_file_write_iter
> > > >           xfs_file_buffered_write
> > > >            iomap_file_buferred_write
> > > >             iomap_iter
> > > >              xfs_buferred_write_iomap_begin
> > > >                # Here we correctly see that there is noting at the
> > > >                # destination in data fork, but somehow we find a mapped
> > > >                # extent in cow fork which is returned to iomap.
> > > >              iomap_write_iter
> > > >               __iomap_write_begin
> > > >                 # Here we notice folio is not uptodate and call
> > > >                 # iomap_read_folio_range() to read from the cow_fork
> > > >                 # mapping we found earlier. This results in folio having
> > > >                 # incorrect data at 0x1e800 offset.
> > > > 
> > > >  So it seems like the fsx operations might be corrupting the cow fork state
> > > >  somehow leading to stale data exposure. 
> > > > 
> > > > 2. If we disable atomic writes we dont hit the issue.
> > > > 
> > > > 3. If I do a -c pread of the destination range before doing the
> > > > copy_range operation then I don't see the corruption any more.
> 
> Yeah, I stopped seeing failures after adding -X (verify data after every
> operation) to FSX_AVOID.
> 
> > > > I'm now trying to figure out why the mapping returned is not IOMAP_HOLE
> > > > as it should be. I don't know the COW path in xfs so there are some gaps
> > > > in my understanding. Let me know if you need any other information since
> > > > I'm reliably able to replicate on 6.17.0-rc4.
> > > > 
> > > 
> > > I haven't followed your issue closely, but just on this hole vs. COW
> > > thing, XFS has a bit of a quirk where speculative COW fork preallocation
> > > can expand out over holes in the data fork. If iomap lookup for buffered
> > > write sees COW fork blocks present, it reports those blocks as the
> > > primary mapping even if the data fork happens to be a hole (since
> > > there's no point in allocating blocks to the data fork when we can just
> > > remap).
> 
> That sounds like a bug -- if a sub-fsblock write to an uncached file
> range has to read data in from disk, then xfs needs to pass the data
> fork mapping to iomap even if it's a read.
> 
> Can you capture the ftrace output of the iomap_iter_*map tracepoints?

Hey Darrick, below are the details:

Command:
	sudo ./xfstests-dev/ltp/fsx -N 10000 -o 8192 -l 500000 -r 4096 -t 512 -w 512 -Z -FKuHzI -g B --replay-ops prep.fsxops /mnt/test/junk
	sudo perf record -e 'iomap:iomap_iter_*map' xfs_io -c 'copy_range -s 0xd000 -d 0x1d800 -l 0x1000 /mnt/test/junk' -c 'pread -v 0x1e7f0 0x20' /mnt/test/junk

	(prep.fsxops is here: https://github.com/OjaswinM/fsx-aw-issue/blob/master/repro.fsxops)

stdout:
	Seed set to 1
	main: filesystem does not support exchange range, disabling!
	truncating to largest ever: 0x50e00
	truncating to largest ever: 0x70e00
	All 136 operations completed A-OK!

	0001e7f0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0001e800:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
	read 16/16 bytes at offset 124927
	16.000000 bytes, 1 ops; 0.0000 sec (339.674 KiB/sec and 21739.1304 ops/sec)
	[ perf record: Woken up 1 times to write data ]
	[ perf record: Captured and wrote 0.003 MB perf.data (1 samples) ]

perf output:
	xfs_io     981 [000]   254.331537: iomap:iomap_iter_dstmap: dev 254:32 ino 0x83 bdev 254:32 addr 0xb8000 offset 0x1d000 length 0x23000 type MAPPED (0x2) flags DIRTY|SHARED (0x6)


perf output if I call -c pread before -c copy_range:

	xfs_io    1098 [000]   911.542373: iomap:iomap_iter_dstmap: dev 254:32 ino 0x83 bdev 254:32 addr 0xffffffffffffffff offset 0x1e000 length 0x1000 type HOLE (0x0) flags DIRTY (0x2)
	xfs_io    1098 [000]   911.542776: iomap:iomap_iter_dstmap: dev 254:32 ino 0x83 bdev 254:32 addr 0xb8000 offset 0x1d000 length 0x23000 type MAPPED (0x2) flags DIRTY|SHARED (0x6)

	(The first event is from -c pread)


Fiemap before and after output incase it helps:

	$ xfs_io -c 'fiemap -v' -c 'copy_range -s 0xd000 -d 0x1d800 -l 0x1000 /mnt/test/junk' -c 'pread -v 0x1e7f0 0x20' -c 'fiemap -v' /mnt/test/junk

	/mnt/test/junk:
	 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
		 0: [0..7]:          408..415             8   0x0
		 1: [8..31]:         520..543            24   0x0
		 2: [32..167]:       hole               136
		 3: [168..175]:      1408..1415           8   0x0
		 4: [176..367]:      hole               192
		 5: [368..375]:      1608..1615           8   0x0
		 6: [376..535]:      hole               160
		 7: [536..543]:      1048..1055           8   0x1
	0001e7f0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0001e800:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
	read 32/32 bytes at offset 124912
	32.000000 bytes, 1 ops; 0.0000 sec (325.521 KiB/sec and 10416.6667 ops/sec)
	/mnt/test/junk:
	 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
		 0: [0..7]:          408..415             8   0x0
		 1: [8..31]:         520..543            24   0x0
		 2: [32..167]:       hole               136
		 3: [168..175]:      1408..1415           8   0x0
		 4: [176..231]:      hole                56
		 5: [232..247]:      1472..1487          16   0x0
		 6: [248..367]:      hole               120
		 7: [368..375]:      1608..1615           8   0x0
		 8: [376..535]:      hole               160
		 9: [536..543]:      1048..1055           8   0x1

> 
> > > Again I've no idea if this relates to your issue or what you're
> > > referring to as a hole (i.e. data fork only?), but just pointing it out.
> > > The latest iomap/xfs patches I posted a few days ago kind of dance
> > > around this a bit, but I was somewhat hoping that maybe the cleanups
> > > there would trigger some thoughts on better iomap reporting in that
> > > regard.
> > 
> > Hi Brian, Thanks for the details and yes by "hole" i did mean hole in
> > data fork only. The part that I'm now confused about is does this sort
> > of preallocation extent hold any valid data? IIUC it should not, so I
> 
> No.  Mappings in the cow fork are not fully written and should never be
> used for reads.
> 
> > would expect it to trigger iomap_block_needs_zeroing() to write zeroes
> > to the folio. Instead, what I see in the issue is that we are trying to
> > do disk read.
> 
> Hrm.  Part of the problem here might be that iomap_read_folio_range
> ignores iomap_iter::srcmap if it's type IOMAP_HOLE (see
> iomap_iter_srcmap), even if the filesystem actually *set* the srcmap to
> a hole.
> 
> FWIW I see a somewhat different failure -- not data corruption, but
> pwrite returning failure:

> 
> --- /run/fstests/bin/tests/generic/521.out      2025-07-15 14:45:15.100315255 -0700
> +++ /var/tmp/fstests/generic/521.out.bad        2025-10-21 10:33:39.032263811 -0700
> @@ -1,2 +1,668 @@
>  QA output created by 521
> +dowrite: write: Input/output error

Hmm that's strange. Can you try running the above command with
prep.fsxops that I've shared. You'll need to pull the fsx atomic write
changes in this patch for it to work. I've been running on non atomic
write device btw.

> +LOG DUMP (661 total operations):
> +1(  1 mod 256): TRUNCATE UP    from 0x0 to 0x1d000
> +2(  2 mod 256): DEDUPE 0x19000 thru 0x1bfff    (0x3000 bytes) to 0x13000 thru 0x15fff
> +3(  3 mod 256): SKIPPED (no operation)
> +4(  4 mod 256): PUNCH    0x5167 thru 0x12d1c   (0xdbb6 bytes)
> +5(  5 mod 256): WRITE    0x79000 thru 0x86fff  (0xe000 bytes) HOLE
> +6(  6 mod 256): PUNCH    0x32344 thru 0x36faf  (0x4c6c bytes)
> +7(  7 mod 256): READ     0x0 thru 0xfff        (0x1000 bytes)
> +8(  8 mod 256): WRITE    0xe000 thru 0x11fff   (0x4000 bytes)
> +9(  9 mod 256): PUNCH    0x71324 thru 0x86fff  (0x15cdc bytes)
> +10( 10 mod 256): MAPREAD  0x5b000 thru 0x6d218 (0x12219 bytes)
> +11( 11 mod 256): COLLAPSE 0x70000 thru 0x79fff (0xa000 bytes)
> +12( 12 mod 256): WRITE    0x41000 thru 0x50fff (0x10000 bytes)
> +13( 13 mod 256): INSERT 0x39000 thru 0x4dfff   (0x15000 bytes)
> +14( 14 mod 256): WRITE    0x34000 thru 0x37fff (0x4000 bytes)
> +15( 15 mod 256): MAPREAD  0x55000 thru 0x6ee44 (0x19e45 bytes)
> +16( 16 mod 256): READ     0x46000 thru 0x55fff (0x10000 bytes)
> +17( 17 mod 256): PUNCH    0x1ccea thru 0x23b2e (0x6e45 bytes)
> +18( 18 mod 256): COPY 0x2a000 thru 0x35fff     (0xc000 bytes) to 0x52000 thru 0x5dfff
> +19( 19 mod 256): SKIPPED (no operation)
> +20( 20 mod 256): WRITE    0x10000 thru 0x1ffff (0x10000 bytes)
> <snip>
> +645(133 mod 256): READ     0x5000 thru 0x16fff (0x12000 bytes)
> +646(134 mod 256): PUNCH    0x3a51d thru 0x41978        (0x745c bytes)
> +647(135 mod 256): FALLOC   0x47f4c thru 0x54867        (0xc91b bytes) INTERIOR
> +648(136 mod 256): WRITE    0xa000 thru 0x1dfff (0x14000 bytes)
> +649(137 mod 256): CLONE 0x83000 thru 0x89fff   (0x7000 bytes) to 0x4b000 thru 0x51fff
> +650(138 mod 256): TRUNCATE DOWN        from 0x8bac4 to 0x7e000
> +651(139 mod 256): MAPWRITE 0x13000 thru 0x170e6        (0x40e7 bytes)
> +652(140 mod 256): XCHG 0x6a000 thru 0x7cfff    (0x13000 bytes) to 0x8000 thru 0x1afff
> +653(141 mod 256): XCHG 0x35000 thru 0x3cfff    (0x8000 bytes) to 0x1b000 thru 0x22fff
> +654(142 mod 256): CLONE 0x47000 thru 0x60fff   (0x1a000 bytes) to 0x65000 thru 0x7efff
> +655(143 mod 256): DEDUPE 0x79000 thru 0x7dfff  (0x5000 bytes) to 0x6e000 thru 0x72fff
> +656(144 mod 256): XCHG 0x4d000 thru 0x5ffff    (0x13000 bytes) to 0x8000 thru 0x1afff
> +657(145 mod 256): PUNCH    0x7194f thru 0x7efff        (0xd6b1 bytes)
> +658(146 mod 256): PUNCH    0x7af7e thru 0x7efff        (0x4082 bytes)
> +659(147 mod 256): MAPREAD  0x77000 thru 0x7e55d        (0x755e bytes)
> +660(148 mod 256): READ     0x58000 thru 0x64fff        (0xd000 bytes)
> +661(149 mod 256): WRITE    0x88000 thru 0x8bfff        (0x4000 bytes) HOLE
> +Log of operations saved to "/mnt/junk.fsxops"; replay with --replay-ops
> +Correct content saved for comparison
> +(maybe hexdump "/mnt/junk" vs "/mnt/junk.fsxgood")
> 
> Curiously there are no EIO errors logged in dmesg.
> 
> --D
> 
> > Regards,
> > ojaswin
> > > 
> > > Brian
> > 
> > > 
> > > > [1]
> > > > https://github.com/OjaswinM/fsx-aw-issue/tree/master
> > > > 
> > > > [2] https://github.com/OjaswinM/fsx-aw-issue/blob/master/repro.fsxops
> > > > 
> > > > regards,
> > > > ojaswin
> > > > 
> > > 
> > 

