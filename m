Return-Path: <linux-ext4+bounces-12024-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8092C8246C
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 20:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F92E3ADECB
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 19:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914372D6E61;
	Mon, 24 Nov 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MApBI3CU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84029E112
	for <linux-ext4@vger.kernel.org>; Mon, 24 Nov 2025 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011911; cv=none; b=YBq14CiTfny/eLrc5F1hZrqka5sTsQXDibmwHASbTfe/j0V8f93dcXP6BF5P1Z4w3Nve/S6BIqheSzJta6932cLyxvbYqoLQ2QnYdXRZDxaJzu6jeWG7p6LT7m2ZyGqpXfYK9HH3vUSaFsaN1eFcUxdEaehLqzYI4lUW0cUDTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011911; c=relaxed/simple;
	bh=XeFv5A1qv3Hjluc9DCtaZ5JVCCwyI6TjpAz+0TvgmW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EfUUs+2rps89FIVU2YRSt5QupVe0iQSCAUag2mcOi/HhoEQng5pDFDQqycud5f10mHztmHZ3Qt7XnWm5z1PXGZpaI0EljByYDT7sTpynGbfJx4bv0ZMvRtJ4gXZgBIXZI7RhfhVdFn7Q2kK4s7hEdQz1DtCtszK9m3aC4MMn9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MApBI3CU; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AOJIBOL022178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 14:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764011894; bh=FWuU+z9tqteR7ANOJ2Is90urzhAEwYLjoEGBOm7xxrw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=MApBI3CUCJ7yOsNwFQf/FaeOmO6y0wpdKU6JLaMIz+fXNW29HVbs4B2+42tDYAbs/
	 d7M9sSYf8ZqW3FhQsTXpJgtLBPZDu9wnIpw0pPllaiNXIb7JqOdO1jElHEPN1bVNvc
	 5pKaVdZrnQfJVzXWqT2K3AY9UXTDCzgFKi6JMbssI3TrB+f5RKpk9DE8ueJcpggPE0
	 2Guz1ZuhT47MfBGa07+hMfITa9ARWxfL7RoVB9tVIIvOfl7X1J/144DuGE8D1xYEH3
	 pxufjfti2O1KnePwOXW6YkDX4NELrvYCiDpk27KPpbFyDzF1H2oV0SPH9D5Hqk8RdG
	 GbJpJX4RLxSXQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 31EF34C85C03; Mon, 24 Nov 2025 13:18:11 -0600 (CST)
Date: Mon, 24 Nov 2025 13:18:11 -0600
From: "Theodore Tso" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-xfs@vger.kernel.org
Subject: [REGRESSION] generic/127 failure caused by "mm: Use folio_next_pos()"
Message-ID: <20251124191811.GA26781@mac.lan>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NWlW6uYnq158lPXA"
Content-Disposition: inline


--NWlW6uYnq158lPXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While testing the ext4 large blocksize patches I merged in
linux-next/fs-next to pick up the mm changes needed to prevent the
warnings when allocating larger blocks with GFP_NOFAIL, and I found
some unrelated regressions with three tests, including generic/127
(the other two regressions seem unrelated to this commit; I'll bisect
them separately).

Further testing found that regression occurred somewhere between
fs-current and fs-next, and I also found that it was failing not just
for ext4, but also for ext4.  A git bisect run localized the failure
to this commit:

commit 60a70e61430b2d568bc5e96f629c5855ee159ace
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Fri Oct 24 18:08:18 2025 +0100

    mm: Use folio_next_pos()
    
    This is one instruction more efficient than open-coding folio_pos() +
    folio_size().  It's the equivalent of (x + y) << z rather than
    x << z + y << z.
    
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
    Link: https://patch.msgid.link/20251024170822.1427218-11-willy@infradead.org

I then checked out linux-next (aka linux-next/master) and verified
that the problem was reproducible there, using

kvm-xfstests -c ext4/4k generic/127 --fail-loop-count 0 --kernel-build

And then when I reverted commit 60a70e61430b, the test passed.  I also
checked and found that this commit was also causing generic/127 to
fail for xfs:

kvm-xfstests -c xfs/4k generic/127 --fail-loop-count 0 --kernel-build

And, with the commit reverted the problem went away.

The test logs for ext4 and xfs are attached.  Willy, could you take a
look?  Many thanks!!

							- Ted


--NWlW6uYnq158lPXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ext4-generic-127.log
Content-Transfer-Encoding: quoted-printable

=1Bc=1B[?7l=1B[2J=1B[0mSeaBIOS (version 1.17.0-debian-1.17.0-1)=0D
Booting from ROM..=1Bc=1B[?7l=1B[2J=1B[!p=1B]104=07=1B[?7h[=1B[0;1;31mFAILE=
D=1B[0m] Failed to start =1B[0;1;39mnbd-server.service=1B[0m - Network Bloc=
k Device server.=0D=0D
CMDLINE: "-c ext4/4k generic/127 --fail-loop-count 0"=0D
KERNEL: kernel	6.18.0-rc6-next-20251124-xfstests #20 SMP PREEMPT_DYNAMIC Mo=
n Nov 24 14:04:48 EST 2025 x86_64=0D
FSTESTVER: blktests	4badb27 (Fri, 31 Oct 2025 19:53:27 +0900)=0D
FSTESTVER: fio		fio-3.41 (Fri, 5 Sep 2025 14:21:17 -0600)=0D
FSTESTVER: fsverity	v1.7 (Tue, 4 Nov 2025 17:28:17 -0800)=0D
FSTESTVER: ima-evm-utils	v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)=0D
FSTESTVER: libaio  	libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0=
200)=0D
FSTESTVER: ltp		20250930 (Tue, 30 Sep 2025 13:53:45 +0200)=0D
FSTESTVER: quota		v4.05-77-g22ff3d9 (Tue, 2 Sep 2025 08:12:02 -0400)=0D
FSTESTVER: util-linux	v2.41.2 (Mon, 22 Sep 2025 12:56:34 +0200)=0D
FSTESTVER: xfsprogs	v6.17.0 (Mon, 20 Oct 2025 16:49:00 +0200)=0D
FSTESTVER: xfstests	v2025.11.04-12-g64e3dbda7 (Thu, 13 Nov 2025 19:58:03 -0=
500)=0D
FSTESTVER: xfstests-bld	gce-xfstests-202504292206-33-g3844cb58 (Thu, 13 Nov=
 2025 21:05:49 -0500)=0D
FSTESTVER: zz_build-distro	trixie=0D
FSTESTCFG: "ext4/4k"=0D
FSTESTSET: "generic/127"=0D
FSTESTEXC: ""=0D
FSTESTOPT: "fail_loop_count 0 aex"=0D
MNTOPTS: ""=0D
CPUS: "2"=0D
MEM: "1969.56"=0D
               total        used        free      shared  buff/cache   avai=
lable=0D
Mem:            1969         208        1749           0         143       =
 1760=0D
Swap:              0           0           0=0D
BEGIN TEST 4k (1 test): Ext4 4k block Mon Nov 24 14:05:27 EST 2025=0D
DEVICE: /dev/vdb=0D
EXT_MKFS_OPTIONS: -b 4096=0D
EXT_MOUNT_OPTIONS: -o block_validity=0D
FSTYP         -- ext4=0D
PLATFORM      -- Linux/x86_64 kvm-xfstests 6.18.0-rc6-next-20251124-xfstest=
s #20 SMP PREEMPT_DYNAMIC Mon Nov 24 14:04:48 EST 2025=0D
MKFS_OPTIONS  -- -F -q -b 4096 /dev/vdc=0D
MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc=0D
=0D
generic/127  31s ...  [14:05:28][    3.901891] run fstests generic/127 at 2=
025-11-24 14:05:28=0D
[    4.092040] EXT4-fs warning (device vdb): ext4_convert_unwritten_extents=
_endio:3774: Inode (42) finished: extent logical block 25, len 15; IO logic=
al block 25, len 8=0D
[    4.101284] EXT4-fs warning (device vdb): ext4_convert_unwritten_extents=
_endio:3774: Inode (47) finished: extent logical block 25, len 15; IO logic=
al block 25, len 8=0D
[    4.125984] EXT4-fs warning (device vdb): ext4_convert_unwritten_extents=
_endio:3774: Inode (47) finished: extent logical block 35, len 9; IO logica=
l block 39, len 1=0D
[    4.129140] EXT4-fs warning (device vdb): ext4_convert_unwritten_extents=
_endio:3774: Inode (47) finished: extent logical block 35, len 4; IO logica=
l block 36, len 3=0D
[    4.181406] EXT4-fs warning (device vdb): ext4_convert_unwritten_extents=
_endio:3774: Inode (42) finished: extent logical block 3, len 14; IO logica=
l block 8, len 9=0D
[    4.194278] EXT4-fs warning (device vdb): ext4_convert_unwritten_extents=
_endio:3774: Inode (42) finished: extent logical block 31, len 11; IO logic=
al block 31, len 10=0D
[    4.198459] EXT4-fs warning (device vdb): ext4_convert_unwritten_extents=
_endio:3774: Inode (47) finished: extent logical block 3, len 14; IO logica=
l block 8, len 9=0D
[    4.207676] EXT4-fs warning (device vdb): ext4_convert_unwritten_extents=
_endio:3774: Inode (50) finished: extent logical block 25, len 15; IO logic=
al block 25, len 8=0D
[    4.217111] EXT4-fs warning (device vdb): ext4_convert_unwritten_extents=
_endio:3774: Inode (47) finished: extent logical block 31, len 11; IO logic=
al block 31, len 10=0D
[    4.221635] EXT4-fs warning (device vdb): ext4_convert_unwritten_extents=
_endio:3774: Inode (41) finished: extent logical block 25, len 15; IO logic=
al block 25, len 8=0D
 [14:05:39]- output mismatch (see /results/ext4/results-4k/generic/127.out.=
bad)=0D
    --- tests/generic/127.out	2025-11-13 21:05:49.000000000 -0500=0D
    +++ /results/ext4/results-4k/generic/127.out.bad	2025-11-24 14:05:39.22=
5714867 -0500=0D
    @@ -1,7 +1,34117 @@=0D
     QA output created by 127=0D
    +/root/xfstests/ltp/fsx -q -l 262144 -o 65536 -S 191110531 -N 100000 -R=
 -W fsx_std_nommap=0D
    +READ BAD DATA: offset =3D 0x11303, size =3D 0xf7b0, fname =3D /vdb/fsx=
_std_nommap=0D
    +OFFSET      GOOD    BAD     RANGE=0D
    +0x14000     0x0000  0xfc9f  0x0=0D
    +operation# (mod 256) for the bad data may be 252=0D
    +0x14001     0x0000  0x9ffc  0x1=0D
    ...=0D
    (Run 'diff -u /root/xfstests/tests/generic/127.out /results/ext4/result=
s-4k/generic/127.out.bad'  to see the entire diff)=0D
Ran: generic/127=0D
Failures: generic/127=0D
Failed 1 of 1 tests=0D
Xunit report: /results/ext4/results-4k/result.xml=0D
=0D
               total        used        free      shared  buff/cache   avai=
lable=0D
Mem:            1969         206        1822           0          28       =
 1762=0D
Swap:              0           0           0=0D
END TEST: Ext4 4k block Mon Nov 24 14:05:39 EST 2025=0D

--NWlW6uYnq158lPXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xfs-generic-127.log
Content-Transfer-Encoding: quoted-printable

=1Bc=1B[?7l=1B[2J=1B[0mSeaBIOS (version 1.17.0-debian-1.17.0-1)=0D
Booting from ROM..=1Bc=1B[?7l=1B[2J=1B[!p=1B]104=07=1B[?7h[=1B[0;1;31mFAILE=
D=1B[0m] Failed to start =1B[0;1;39mnbd-server.service=1B[0m - Network Bloc=
k Device server.=0D=0D
CMDLINE: "-c xfs/4k generic/127 --fail-loop-count 0"=0D
KERNEL: kernel	6.18.0-rc6-next-20251124-xfstests #20 SMP PREEMPT_DYNAMIC Mo=
n Nov 24 14:04:48 EST 2025 x86_64=0D
FSTESTVER: blktests	4badb27 (Fri, 31 Oct 2025 19:53:27 +0900)=0D
FSTESTVER: fio		fio-3.41 (Fri, 5 Sep 2025 14:21:17 -0600)=0D
FSTESTVER: fsverity	v1.7 (Tue, 4 Nov 2025 17:28:17 -0800)=0D
FSTESTVER: ima-evm-utils	v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)=0D
FSTESTVER: libaio  	libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0=
200)=0D
FSTESTVER: ltp		20250930 (Tue, 30 Sep 2025 13:53:45 +0200)=0D
FSTESTVER: quota		v4.05-77-g22ff3d9 (Tue, 2 Sep 2025 08:12:02 -0400)=0D
FSTESTVER: util-linux	v2.41.2 (Mon, 22 Sep 2025 12:56:34 +0200)=0D
FSTESTVER: xfsprogs	v6.17.0 (Mon, 20 Oct 2025 16:49:00 +0200)=0D
FSTESTVER: xfstests	v2025.11.04-12-g64e3dbda7 (Thu, 13 Nov 2025 19:58:03 -0=
500)=0D
FSTESTVER: xfstests-bld	gce-xfstests-202504292206-33-g3844cb58 (Thu, 13 Nov=
 2025 21:05:49 -0500)=0D
FSTESTVER: zz_build-distro	trixie=0D
FSTESTCFG: "xfs/4k"=0D
FSTESTSET: "generic/127"=0D
FSTESTEXC: ""=0D
FSTESTOPT: "fail_loop_count 0 aex"=0D
MNTOPTS: ""=0D
CPUS: "2"=0D
MEM: "1969.56"=0D
               total        used        free      shared  buff/cache   avai=
lable=0D
Mem:            1969         212        1745           0         143       =
 1756=0D
Swap:              0           0           0=0D
meta-data=3D/dev/vdd               isize=3D512    agcount=3D4, agsize=3D327=
680 blks=0D
         =3D                       sectsz=3D512   attr=3D2, projid32bit=3D1=
=0D
         =3D                       crc=3D1        finobt=3D1, sparse=3D1, r=
mapbt=3D1=0D
         =3D                       reflink=3D1    bigtime=3D1 inobtcount=3D=
1 nrext64=3D1=0D
         =3D                       exchange=3D0   metadir=3D0=0D
data     =3D                       bsize=3D4096   blocks=3D1310720, imaxpct=
=3D25=0D
         =3D                       sunit=3D0      swidth=3D0 blks=0D
naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, ftype=3D1, =
parent=3D0=0D
log      =3Dinternal log           bsize=3D4096   blocks=3D16384, version=
=3D2=0D
         =3D                       sectsz=3D512   sunit=3D0 blks, lazy-coun=
t=3D1=0D
realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=3D0=
=0D
         =3D                       rgcount=3D0    rgsize=3D0 extents=0D
         =3D                       zoned=3D0      start=3D0 reserved=3D0=0D
Discarding blocks...Done.=0D
BEGIN TEST 4k (1 test): XFS 4k block Mon Nov 24 14:06:31 EST 2025=0D
DEVICE: /dev/vdd=0D
XFS_MKFS_OPTIONS: -bsize=3D4096=0D
XFS_MOUNT_OPTIONS: =0D
FSTYP         -- xfs (debug)=0D
PLATFORM      -- Linux/x86_64 kvm-xfstests 6.18.0-rc6-next-20251124-xfstest=
s #20 SMP PREEMPT_DYNAMIC Mon Nov 24 14:04:48 EST 2025=0D
MKFS_OPTIONS  -- -f -bsize=3D4096 /dev/vdc=0D
MOUNT_OPTIONS -- /dev/vdc /vdc=0D
=0D
generic/127  31s ...  [14:06:33][    6.886269] run fstests generic/127 at 2=
025-11-24 14:06:33=0D
[    7.333668] vdd: writeback error on inode 137, offset 208896, sector 262=
2528=0D
[    7.338078] XFS (vdd): Corruption of in-memory data (0x8) detected at xf=
s_trans_mod_sb+0x2b6/0x370 (fs/xfs/xfs_trans.c:353).  Shutting down filesys=
tem.=0D
[    7.341384] XFS (vdd): Please unmount the filesystem and rectify the pro=
blem(s)=0D
[    7.342570] XFS: Assertion failed: tp->t_blk_res >=3D tp->t_blk_res_used=
, file: fs/xfs/xfs_trans.c, line: 120=0D
[    7.344123] ------------[ cut here ]------------=0D
[    7.344851] WARNING: fs/xfs/xfs_message.c:104 at assfail+0x33/0x3a, CPU#=
1: kworker/1:0/23=0D
[    7.346172] CPU: 1 UID: 0 PID: 23 Comm: kworker/1:0 Not tainted 6.18.0-r=
c6-next-20251124-xfstests #20 PREEMPT(none) =0D
[    7.347861] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
7.0-debian-1.17.0-1 04/01/2014=0D
[    7.349936] Workqueue: xfs-conv/vdd xfs_end_io=0D
[    7.350759] RIP: 0010:assfail+0x33/0x3a=0D
[    7.351341] Code: 49 89 d0 41 89 c9 48 c7 c2 d8 18 a8 82 48 89 f1 48 89 =
fe 48 c7 c7 e4 0c b0 82 e8 b8 fd ff ff 80 3d 59 6d ba 01 00 74 02 0f 0b <0f=
> 0b e9 41 da ed ff 48 8d 45 10 48 89 e2 48 89 de 4c 89 34 24 48=0D
[    7.354327] RSP: 0018:ffa00000000cbc00 EFLAGS: 00010246=0D
[    7.355161] RAX: 0000000000000000 RBX: ff11000011dafbc8 RCX: 000000007ff=
fffff=0D
[    7.356328] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff82b=
00ce4=0D
[    7.357522] RBP: ff11000011dafd98 R08: 0000000000000000 R09: 00000000000=
0000a=0D
[    7.358681] R10: 000000000000000a R11: 0fffffffffffffff R12: 00000005000=
2f3f8=0D
[    7.359835] R13: 0000000000039a46 R14: ff11000011dafe68 R15: ff11000011d=
afe68=0D
[    7.361031] FS:  0000000000000000(0000) GS:ff110000fa430000(0000) knlGS:=
0000000000000000=0D
[    7.362325] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[    7.363273] CR2: 00007fbb37aaa350 CR3: 0000000002c2e003 CR4: 00000000007=
71ef0=0D
[    7.364422] PKRU: 55555554=0D
[    7.364872] Call Trace:=0D
[    7.365309]  <TASK>=0D
[    7.365671]  xfs_trans_dup+0x16e/0x1c0=0D
[    7.366287]  xfs_trans_roll+0x2e/0xd0=0D
[    7.366906]  xfs_defer_trans_roll+0x53/0x130=0D
[    7.367608]  ? srso_alias_return_thunk+0x5/0xfbef5=0D
[    7.368393]  xfs_defer_finish_noroll+0x2cd/0x500=0D
[    7.369419]  xfs_trans_commit+0x4c/0x70=0D
[    7.370486]  ? xfs_iomap_write_unwritten+0x180/0x320=0D
[    7.371227]  xfs_iomap_write_unwritten+0xce/0x320=0D
[    7.371932]  xfs_end_ioend+0x207/0x2b0=0D
[    7.372517]  xfs_end_io+0xb5/0x100=0D
[    7.373046]  process_one_work+0x18c/0x360=0D
[    7.373697]  worker_thread+0x268/0x3b0=0D
[    7.374265]  ? __pfx_worker_thread+0x10/0x10=0D
[    7.374910]  kthread+0x10a/0x230=0D
[    7.375422]  ? __pfx_kthread+0x10/0x10=0D
[    7.375989]  ? __pfx_kthread+0x10/0x10=0D
[    7.376577]  ret_from_fork+0x95/0x110=0D
[    7.377142]  ? __pfx_kthread+0x10/0x10=0D
[    7.377709]  ret_from_fork_asm+0x1a/0x30=0D
[    7.378303]  </TASK>=0D
[    7.378663] ---[ end trace 0000000000000000 ]---=0D
[    7.379365] vdd: writeback error on inode 132, offset 184320, sector 888=
=0D
_check_xfs_filesystem: filesystem on /dev/vdd has dirty log=0D
(see /results/xfs/results-4k/generic/127.full for details)=0D
_check_xfs_filesystem: filesystem on /dev/vdd is inconsistent (r)=0D
(see /results/xfs/results-4k/generic/127.full for details)=0D
Trying to repair broken TEST_DEV file system=0D
_check_dmesg: something found in dmesg (see /results/xfs/results-4k/generic=
/127.dmesg)=0D
 [14:06:34]- output mismatch (see /results/xfs/results-4k/generic/127.out.b=
ad)=0D
    --- tests/generic/127.out	2025-11-13 21:05:49.000000000 -0500=0D
    +++ /results/xfs/results-4k/generic/127.out.bad	2025-11-24 14:06:34.037=
856472 -0500=0D
    @@ -1,7 +1,25950 @@=0D
     QA output created by 127=0D
    -All 100000 operations completed A-OK!=0D
    -All 100000 operations completed A-OK!=0D
    -All 100000 operations completed A-OK!=0D
    -All 100000 operations completed A-OK!=0D
    -All 100000 operations completed A-OK!=0D
    -All 100000 operations completed A-OK!=0D
    ...=0D
    (Run 'diff -u /root/xfstests/tests/generic/127.out /results/xfs/results=
-4k/generic/127.out.bad'  to see the entire diff)=0D
Ran: generic/127=0D
Failures: generic/127=0D
Failed 1 of 1 tests=0D
Xunit report: /results/xfs/results-4k/result.xml=0D
=0D
               total        used        free      shared  buff/cache   avai=
lable=0D
Mem:            1969         309        1719           0          30       =
 1660=0D
Swap:              0           0           0=0D
END TEST: XFS 4k block Mon Nov 24 14:06:34 EST 2025=0D

--NWlW6uYnq158lPXA--

