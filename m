Return-Path: <linux-ext4+bounces-3292-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2037893266F
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 14:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E07B22824
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA311991B0;
	Tue, 16 Jul 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m+nWf3D2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88D1E888
	for <linux-ext4@vger.kernel.org>; Tue, 16 Jul 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721132648; cv=none; b=DVQJgPwB6Jt3BR6cLQJIcAy3Ddrj1HFvp5dKgwE72UcH8jM/2kyF4Yttt3yfu0Mzh3vepVY2QJG6jiBT/0npJ0FZDPvl+lE6ag2xrjmEl+kRx/STA2u4qDLT5raVS87kMAqA38/d4tBCK2GAse89PZFnUNtD8HFkJ0WO2MiNVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721132648; c=relaxed/simple;
	bh=ZJk2ggROBt0EW+50DGGtX5sKae5Hs406vnxGrYCfuLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=bbTZhyLSM91vPumz4uV1P0d/l5kSywsECfSsyMy1EiZino+gJhzqf3O0BKlascV3NVrCDfaS9bDZ6OTlhkDHXiAtV0Y3aTonUXOsOuA5rMnECq2i5KxoQdFGd4QFSFVgrgjCWewH/KQd7PXNSnTpoi8IkGEn8t8rpyWHOYCVtoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=m+nWf3D2; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240716122357euoutp02243020f0eee3361f0e3f817ea201b00e~isQO4Ga2v0461004610euoutp02h
	for <linux-ext4@vger.kernel.org>; Tue, 16 Jul 2024 12:23:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240716122357euoutp02243020f0eee3361f0e3f817ea201b00e~isQO4Ga2v0461004610euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721132637;
	bh=vRRIK2F206KigH7+rmfglK71er81oe5izvVgAXeLS/Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=m+nWf3D2mZWM6DlHianFtnRoWfevmxH/B+PgmQsD+SZnJJYFbUtaGpipsjGmdO+cn
	 K8hA1PjuefqdGl3U0FUQV6FFEqPGv4dJ6l3uRRm93fCzyXyoCwwYQdkOI8snFFkFcq
	 tmCb2hyUgjeM4hg7esAUIyFofCU0iS4lnEmi+NLI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240716122356eucas1p17c42ecf758910b3c187475397cfac0de~isQOX9OIN3215032150eucas1p1m;
	Tue, 16 Jul 2024 12:23:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4D.8A.09875.C5666966; Tue, 16
	Jul 2024 13:23:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240716122355eucas1p2dbcfcf7425fbbd17a3ab5d5199e3e381~isQNuQ9ne2528225282eucas1p2_;
	Tue, 16 Jul 2024 12:23:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240716122355eusmtrp2ac883e6f794222dbf4472968463cd1dd~isQNtvOi-2559725597eusmtrp2v;
	Tue, 16 Jul 2024 12:23:55 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-8d-6696665cc30a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id AB.5B.09010.B5666966; Tue, 16
	Jul 2024 13:23:55 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240716122355eusmtip2141057f79f23fcf80bec329a26788078~isQNTFJM92607926079eusmtip2j;
	Tue, 16 Jul 2024 12:23:55 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 16 Jul 2024 13:23:54 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Tue, 16 Jul
	2024 13:23:54 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Zorro Lang <zlang@redhat.com>
CC: Theodore Ts'o <tytso@mit.edu>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [Bug report]: fstests g/388 crash on ext4, BUG: kernel NULL
 pointer dereference, address: 0000000000000000
Thread-Topic: [Bug report]: fstests g/388 crash on ext4, BUG: kernel NULL
	pointer dereference, address: 0000000000000000
Thread-Index: AQHa1aCD6X/z3snJnkO9kuIi2wM2gLH3Ir6AgAGxwACAAGWGAA==
Date: Tue, 16 Jul 2024 12:23:53 +0000
Message-ID: <ajtv27nib7bpr7b7mf6sageqgn6rihnt4anrhckwuj3rv7i6ne@d3qxevpqtjlk>
In-Reply-To: <20240716062030.donbv4a6oytsco44@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18FB5DC26CFF6E42B6A0149B26CE1854@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7oxadPSDKYt5bK4/ITP4nTLXnaL
	mfPusFm09vxkt9h7cierA6vHplWdbB5NZ44ye7zfd5XN4/MmuQCWKC6blNSczLLUIn27BK6M
	+9PaWAoezWWsWHzvFXMD4+NGxi5GTg4JAROJXadXsncxcnEICaxglHi7cSkThPOFUeL1oyvM
	EM5nRolr35rZYVqaNj5ig0gsZ5SYOfUxK1xVy+eNjBDOGUaJbUdfs0A4KxklGjYdYgHpZxPQ
	lNh3chPYLBEBRYk1Py+CLWEW2MMo0Xx+BjNIQligUqK3fw8rRFGVxNJ1L5kgbCeJ/V3nwG5n
	EVCVeP3wNlicV8BX4sPH/2A2p0CMxLrtG9hAbEYBWYlHK3+BLWMWEJe49WQ+E8QTghKLZu9h
	hrDFJP7tesgGYetInL3+BBo2BhJbl+5jgbAVJTqO3WSDmKMjsWD3JyjbUmLesqssELa2xLKF
	r5kh7hGUODnzCdj3EgL7OSVeTbwCtcBF4vHeS6wQtrDEq+Nb2Ccw6sxCct8sJDtmIdkxC8mO
	WUh2LGBkXcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYjE7/O/5lB+PyVx/1DjEycTAe
	YpTgYFYS4Z3AOC1NiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJ
	g1OqgWmL8blapRe/37tcq1K0yUn/dzxw9svo/fEiyy4U2xv+KXM7PTsh9s6lQ5cCRO7d1LU5
	v+X19+11a5c2zPmX92/PqhO7zseybloyweWHufUN60ucW85Ydk+fMnXZl/WBvPFzGANC2gOL
	/SWaD/s/WTcxWf1XnEJCXwbbz1fH7JlrPYWs4yav3qo0R+pAev9s0anbVvqKdyjvS532Y8bU
	z8aTTIKu3pxdmGSqXfCz/VVK1pTHdxYxOvP9eO3A6hoyVb43f9I8gY/9xy4VW3afPHXF+g3/
	1E6jeS1X9yWv8SzRrQ4MfCTOe+2osvdWBZHqQ52K15ruOM+4wy3+Lvag5lVGmQfCe8r7z8Z5
	C4o5r5ijxFKckWioxVxUnAgAUpkV/rUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsVy+t/xe7rRadPSDA7sVra4/ITP4nTLXnaL
	mfPusFm09vxkt9h7cierA6vHplWdbB5NZ44ye7zfd5XN4/MmuQCWKD2bovzSklSFjPziElul
	aEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M+9PaWAoezWWsWHzvFXMD4+NG
	xi5GTg4JAROJpo2P2LoYuTiEBJYySrya85wJIiEjsfHLVVYIW1jiz7UuqKKPjBIfV3xmhHDO
	MErcfbmRFcJZyShx8MJesHY2AU2JfSc3sYPYIgKKEmt+XmQGKWIW2MMo0Xx+BjNIQligUqK3
	fw9QNwdQUZXElQ2OEPVOEvu7zoHdxyKgKvH64W2wmbwCvhIfPv5ngli2hEmiddUysDmcAjES
	67ZvYAOxGQVkJR6t/AW2mFlAXOLWk/lQ/whILNlznhnCFpV4+fgf1G86EmevP4EGhoHE1qX7
	WCBsRYmOYzfZIOboSCzY/QnKtpSYt+wqC4StLbFs4WtmiOMEJU7OfMIygVFmFpLVs5C0z0LS
	PgtJ+ywk7QsYWVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEppltx35u2cG48tVHvUOMTByM
	hxglOJiVRHgnME5LE+JNSaysSi3Kjy8qzUktPsRoCgy8icxSosn5wESXVxJvaGZgamhiZmlg
	amlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAxHSYbb1stvzro/yRc6OO7tT6aRrE2jol
	RUEzVfL8roT7FguFO7x6pjYaf42pXM0u48F24tCC1IIA2aXFRa4xdR1+En/rD6/zMo+/nHzV
	Tqal8FBqwM9WK+ErHxQDd63sV9588KLWIb2K6T+Pn3tyJsRiD1OY49Rn3/i2/f5e8l7d8O8i
	m9r7r8R/NgSdTpWsrDDN9Plx+fjH0hQZQ7FsZWHDthX85q3cJz8y102tmvzojaKTkcNClueK
	4QKudzID4l4fdyvi8VHQP/Hz0t7r/6tLa5U0I0PbNx+UaL+Ts+JwGI/j+k/2Vi8y/V+3vG6/
	brPqvdqtj/vO9i96V/Rju9rpT0ZPeA6qRCtkP5RWYinOSDTUYi4qTgQAomNsELwDAAA=
X-CMS-MailID: 20240716122355eucas1p2dbcfcf7425fbbd17a3ab5d5199e3e381
X-Msg-Generator: CA
X-RootMTR: 20240716062043eucas1p2779dd0d0c15fcce2622f59f799fb6d77
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240716062043eucas1p2779dd0d0c15fcce2622f59f799fb6d77
References: <20240714034624.qz3l7f52pi6m27yx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
	<20240715042803.GM10452@mit.edu>
	<CGME20240716062043eucas1p2779dd0d0c15fcce2622f59f799fb6d77@eucas1p2.samsung.com>
	<20240716062030.donbv4a6oytsco44@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Tue, Jul 16, 2024 at 02:20:30PM GMT, Zorro Lang wrote:
> On Mon, Jul 15, 2024 at 12:28:03AM -0400, Theodore Ts'o wrote:
> > On Sun, Jul 14, 2024 at 11:46:24AM +0800, Zorro Lang wrote:
> > >=20
> > > A weird kernel panic on ext4 happened when I tried to test a
> > > fstests patchset:
> > > https://lore.kernel.org/fstests/20240712093341.ftesijixy2yrjlxx@dell-=
per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#med4b8d2fe14ef627519d84474b4cd1=
a25d386f75
> >=20
> > I'm confused; this patch set:
> >=20
> > Daniel Gomez (5):
> >       common/config: fix RECREATE_TEST_DEV initialization
> >       common/rc: add recreation support for tmpfs
> >       common/config: enable section parsing when recreation
> >       common/rc: read config section mount options for scratch devs
> >       common/rc: print test mount options
> >=20
> > seems to be mostly about how xfstest config section handling
> > especially for tmpfs.  Is this realy the right patch set?  If so, I'm
> > guessing that the reproducer would be very specific to the xfstests
> > config.
> >=20
> > My {kvm,gce}-xfstest setup doesn't use the config sections at
> > all, but instead uses shell script fragments, since it predates config
> > sections by three years --- and I need something that works well with
> > sharding separate configs to run on separate cloud VM's.
> >=20
> > So I'm not sure I'm going to be able to reprduce this easily using my
> > test setup.  Can you translate the stack trace to source file names /
> > line numbers?  Maybe that will give me a hint what's going on:
> >=20
> > > [35346.372867] Call Trace:
> > > [35346.375319]  <TASK>
> > > [35346.377426]  ? __die+0x20/0x70
> > > [35346.380493]  ? page_fault_oops+0x116/0x230
> > > [35346.384602]  ? __pfx_page_fault_oops+0x10/0x10
> > > [35346.389048]  ? _raw_spin_unlock+0x29/0x50
> > > [35346.393072]  ? rcu_is_watching+0x11/0xb0
> > > [35346.397006]  ? exc_page_fault+0x59/0xe0
> > > [35346.400854]  ? asm_exc_page_fault+0x22/0x30
> > > [35346.405049]  ? folio_mark_dirty+0x2a/0xf0
> > > [35346.409072]  __ext4_block_zero_page_range+0x50c/0x7b0 [ext4]
> > > [35346.414809]  ext4_truncate+0xcd3/0x1210 [ext4]
> >=20
> > Getting line numbers for these two functions would be especially
> > helpful.
>=20
> Sure, Ted. I reproduced this bug and got below things[1] on mainline linu=
x
> which HEAD=3D528dd46d0fc35c0176257a13a27d41e44fcc6cb3
>=20
> And if you need, I pushed a temporary branch "whatamess4extN" to fstests
> repo, which contains the patches trigger this bug.

I tried reproducing this issue with below steps [1] and config [2] using ab=
ove
HEAD and branch but I didn't manage to trigger it (output at [3]).

[1] steps:
mkdir -p /mnt/scratch
mkdir -p /mnt/test
pushd /var/lib/xfstests
./check -s ext4_4k_block_size -R xunit generic/388
popd

[2] config:
[default]
FSTYP=3Dext4
TEST_DIR=3D/mnt/test
TEST_DEV=3D/dev/nvme0n1
SCRATCH_MNT=3D/mnt/scratch
SCRATCH_DEV=3D/dev/nvme0n2
RESULT_BASE=3D$PWD/results/$HOST/$(uname -r)

[ext4_4k_block_size]
MKFS_OPTIONS=3D"-q -F -b4096"

[3] output:
SECTION       -- ext4_4k_block_size
FSTYP         -- ext4
PLATFORM      -- Linux/aarch64 localhost 6.10.0-rc7 #6 SMP Tue Jul 16 14:14=
:22 CEST 2024
TEST_MKFS_OPTIONS  -- -q -F -b4096 /dev/nvme0n1
TEST_MOUNT_OPTIONS -- -o acl,user_xattr /dev/nvme0n1 /mnt/test
MKFS_OPTIONS  -- -F -q -F -b4096 /dev/nvme0n2
MOUNT_OPTIONS -- -o acl,user_xattr /dev/nvme0n2 /mnt/scratch

generic/388        59s
Ran: generic/388
Passed all 1 tests
Xunit report: /var/lib/xfstests/results/localhost/6.10.0-rc7/ext4_4k_block_=
size/result.xml

SECTION       -- ext4_4k_block_size
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Ran: generic/388
Passed all 1 tests

>=20
> Thanks,
> Zorro
>=20
> [1]
> # ./scripts/decode_stacktrace.sh vmlinux <~/calltrace.log=20
> [  912.644200] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D131891=20
> [  912.645099] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D525225=20
> [  912.894856] EXT4-fs (vda2): unmounting filesystem b9690547-c193-4a82-b=
0df-4682bd621d3f.=20
> [  912.947581] EXT4-fs (vda2): 1 truncate cleaned up=20
> [  912.947892] EXT4-fs (vda2): recovery complete=20
> [  912.950912] EXT4-fs (vda2): mounted filesystem b9690547-c193-4a82-b0df=
-4682bd621d3f r/w with ordered data mode. Quota mode: none.=20
> [  912.994565] EXT4-fs warning (device vda2): ext4_convert_unwritten_exte=
nts_endio:3720: Inode (525267) finished: extent logical block 161, len 120;=
 IO logical block 222, len 19=20
> [  912.997878] EXT4-fs warning (device vda2): ext4_convert_unwritten_exte=
nts_endio:3720: Inode (525267) finished: extent logical block 241, len 40; =
IO logical block 241, len 9=20
> [  914.017223] restraintd[1427]: *** Current Time: Sat Jul 13 15:03:01 20=
24  Localwatchdog at: Mon Jul 15 14:51:00 2024=20
> [  915.003343] EXT4-fs (vda2): shut down requested (2)=20
> [  915.003671] Aborting journal on device vda2-8.=20
> [  915.663314] EXT4-fs (vda2): unmounting filesystem b9690547-c193-4a82-b=
0df-4682bd621d3f.=20
> [  915.725813] EXT4-fs (vda2): INFO: recovery required on readonly filesy=
stem=20
> [  915.726249] EXT4-fs (vda2): write access will be enabled during recove=
ry=20
> [  916.035952] EXT4-fs (vda2): recovery complete=20
> [  916.038225] EXT4-fs (vda2): mounted filesystem b9690547-c193-4a82-b0df=
-4682bd621d3f ro with ordered data mode. Quota mode: none.=20
> [  916.059891] EXT4-fs (vda2): unmounting filesystem b9690547-c193-4a82-b=
0df-4682bd621d3f.=20
> [  916.159613] EXT4-fs (vda2): mounted filesystem b9690547-c193-4a82-b0df=
-4682bd621d3f r/w with ordered data mode. Quota mode: none.=20
> [  916.199256] EXT4-fs (vda2): shut down requested (2)=20
> [  916.199659] Aborting journal on device vda2-8.=20
> [  916.200912] EXT4-fs warning (device vda2): ext4_evict_inode:253: could=
n't mark inode dirty (err -5)=20
> [  916.203621] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D263200=20
> [  916.205150] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D525058=20
> [  916.205868] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D524568=20
> [  916.206610] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D656330=20
> [  916.207979] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D131080=20
> [  916.208932] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D132089=20
> [  916.209218] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D656330=20
> [  916.210157] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D262970=20
> [  916.211213] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D263204=20
> [  916.211777] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D132089=20
> [  916.212301] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D132089=20
> [  916.214649] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D131374=20
> [  916.214786] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D524568=20
> [  916.216375] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D132004=20
> [  916.216881] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D132004=20
> [  916.217401] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D132004=20
> [  916.219891] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D131876=20
> [  916.221661] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D656082=20
> [  916.221743] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D131875=20
> [  916.223237] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D131875=20
> [  916.225723] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D131875=20
> [  916.230093] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D131860=20
> [  916.232398] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D525049=20
> [  916.233901] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D131871=20
> [  916.235671] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D131886=20
> [  916.238753] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for =
dev=3Dvda2 ino=3D131891=20
> [  916.489675] EXT4-fs (vda2): unmounting filesystem b9690547-c193-4a82-b=
0df-4682bd621d3f.
> [  916.540454] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [  916.540885] #PF: supervisor instruction fetch in kernel mode
> [  916.541226] #PF: error_code(0x0010) - not-present page
> [  916.541533] PGD 0 P4D 0
> [  916.541694] Oops: Oops: 0010 [#1] PREEMPT SMP KASAN PTI
> [  916.542451] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [  916.542791] RIP: 0010:0x0
> [ 916.542958] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  916.543340] RSP: 0018:ffffc90008f0f648 EFLAGS: 00010246
> [  916.543650] RAX: 0000000000000000 RBX: ffff88818c487820 RCX: ffffffff9=
51a6fea
> [  916.544069] RDX: 1ffffffff2ec8c6f RSI: ffffea0005130dc0 RDI: ffff88818=
c487a60
> [  916.544486] RBP: ffffea0005130dc0 R08: 0000000000000000 R09: fffff9400=
0a261b8
> [  916.544903] R10: ffffea0005130dc7 R11: 0000000000000000 R12: 000000000=
0000216
> [  916.545326] R13: ffff88818c6822d0 R14: 0000000000000000 R15: 000000000=
0000000
> [  916.545743] FS:  00007ffa15285800(0000) GS:ffff8881f6600000(0000) knlG=
S:0000000000000000
> [  916.546214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  916.546556] CR2: ffffffffffffffd6 CR3: 000000013914c004 CR4: 000000000=
03706f0
> [  916.546974] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  916.547393] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  916.547810] Call Trace:
> [  916.547964]  <TASK>
> [  916.548102] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/d=
umpstack.c:434)
> [  916.548298] ? page_fault_oops (arch/x86/mm/fault.c:715)
> [  916.548547] ? __pfx_page_fault_oops (arch/x86/mm/fault.c:643)
> [  916.548815] ? _raw_spin_unlock (./arch/x86/include/asm/preempt.h:103 .=
/include/linux/spinlock_api_smp.h:143 kernel/locking/spinlock.c:186)
> [  916.549069] ? rcu_is_watching (./include/linux/context_tracking.h:122 =
kernel/rcu/tree.c:724)
> [  916.549310] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:26 ./a=
rch/x86/include/asm/irqflags.h:67 ./arch/x86/include/asm/irqflags.h:127 arc=
h/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
> [  916.549543] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:62=
3)
> [  916.549797] ? folio_mark_dirty (./arch/x86/include/asm/bitops.h:206 ./=
arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented=
-non-atomic.h:142 ./include/linux/page-flggs.h:562 mm/page-writeback.c:2880=
)
> [  916.550048] __ext4_block_zero_page_range (fs/ext4/inode.c:986 fs/ext4/=
inode.c:3679) ext4
> [  916.550453] ext4_truncate (fs/ext4/inode.c:3744 fs/ext4/inode.c:4119) =
ext4
> [  916.550779] ? ext4_process_orphan (fs/ext4/orphan.c:338 (discriminator=
 3)) ext4
> [  916.551142] ? __pfx_ext4_truncate (fs/ext4/inode.c:4070) ext4
> [  916.551490] ? __pfx_down_write (kernel/locking/rwsem.c:1577)
> [  916.551732] ? ext4_inode_is_fast_symlink (./arch/x86/include/asm/bitop=
s.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/in=
strumented-non-atomic.h:142 fs/ext4/ext4.h:1939 fs/ext4/ext4.h:3603 fs/ext4=
/inode.c:152 fs/ext4/inode.c:146) ext4
> [  916.552128] ext4_process_orphan (fs/ext4/orphan.c:339 (discriminator 3=
)) ext4
> [  916.552483] ext4_orphan_cleanup (fs/ext4/orphan.c:456) ext4
> [  916.552839] ? __pfx_ext4_orphan_cleanup (fs/ext4/orphan.c:381) ext4
> [  916.553220] ? is_module_address (./arch/x86/include/asm/preempt.h:103 =
kernel/module/main.c:3283)
> [  916.553471] __ext4_fill_super (fs/ext4/ext4.h:1763 fs/ext4/super.c:555=
4) ext4
> [  916.553828] ? __pfx___ext4_fill_super (fs/ext4/super.c:5181) ext4
> [  916.554203] ? __kmalloc_large_node (mm/slub.c:4081)
> [  916.554480] ? rcu_is_watching (./include/linux/context_tracking.h:122 =
kernel/rcu/tree.c:724)
> [  916.554718] ext4_fill_super (fs/ext4/super.c:5677) ext4
> [  916.555058] get_tree_bdev (fs/super.c:1624)
> [  916.555290] ? __pfx_ext4_fill_super (fs/ext4/super.c:5657) ext4
> [  916.555651] ? __pfx_get_tree_bdev (fs/super.c:1595)
> [  916.555910] ? security_sb_eat_lsm_opts (security/security.c:1361 (disc=
riminator 13))
> [  916.556203] vfs_get_tree (fs/super.c:1789)
> [  916.556423] do_new_mount (fs/namespace.c:3352)
> [  916.556647] ? __pfx_do_new_mount (fs/namespace.c:3307)
> [  916.556897] ? security_capable (security/security.c:1036 (discriminato=
r 13))
> [  916.557142] path_mount (fs/namespace.c:3679)
> [  916.557362] ? __pfx_path_mount (fs/namespace.c:3606)
> [  916.557602] ? user_path_at_empty (fs/namei.c:2933)
> [  916.557854] __x64_sys_mount (fs/namespace.c:3693 fs/namespace.c:3898 f=
s/namespace.c:3875 fs/namespace.c:3875)
> [  916.558093] ? __pfx___x64_sys_mount (fs/namespace.c:3875)
> [  916.558364] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/c=
ommon.c:83)
> [  916.558587] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)=20
> [  916.558854] ? do_syscall_64 (arch/x86/entry/common.c:102)=20
> [  916.559090] ? from_kuid_munged (kernel/user_namespace.c:460)=20
> [  916.559338] ? rcu_is_watching (./include/linux/context_tracking.h:122 =
kernel/rcu/tree.c:724)=20
> [  916.559574] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:46=
7 kernel/locking/lockdep.c:4360)=20
> [  916.559879] ? do_syscall_64 (arch/x86/entry/common.c:102)=20
> [  916.560113] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)=20
> [  916.560377] ? do_syscall_64 (arch/x86/entry/common.c:102)=20
> [  916.560610] ? ktime_get_coarse_real_ts64 (./include/linux/seqlock.h:74=
 kernel/time/timekeeping.c:2264)=20
> [  916.560910] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)=20
> [  916.561252] ? rcu_is_watching (./include/linux/context_tracking.h:122 =
kernel/rcu/tree.c:724)=20
> [  916.561494] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:46=
7 kernel/locking/lockdep.c:4360)=20
> [  916.561802] ? do_syscall_64 (arch/x86/entry/common.c:102)=20
> [  916.562040] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)=20
> [  916.562307] ? do_syscall_64 (arch/x86/entry/common.c:102)=20
> [  916.562541] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539)=20
> [  916.562774] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539)=20
> [  916.563011] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:=
130)=20
> [  916.563314] RIP: 0033:0x7ffa1510f03e
> [ 916.563535] Code: 48 8b 0d e5 ad 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66=
 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <4=
8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b2 ad 0e 00 f7 d8 64 89 01 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   48 8b 0d e5 ad 0e 00    mov    0xeade5(%rip),%rcx        # 0xeade=
c
>    7:   f7 d8                   neg    %eax
>    9:   64 89 01                mov    %eax,%fs:(%rcx)
>    c:   48 83 c8 ff             or     $0xffffffffffffffff,%rax
>   10:   c3                      retq  =20
>   11:   66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
>   18:   00 00 00=20
>   1b:   90                      nop
>   1c:   f3 0f 1e fa             endbr64=20
>   20:   49 89 ca                mov    %rcx,%r10
>   23:   b8 a5 00 00 00          mov    $0xa5,%eax
>   28:   0f 05                   syscall=20
>   2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax         <=
-- trapping instruction
>   30:   73 01                   jae    0x33
>   32:   c3                      retq  =20
>   33:   48 8b 0d b2 ad 0e 00    mov    0xeadb2(%rip),%rcx        # 0xeade=
c
>   3a:   f7 d8                   neg    %eax
>   3c:   64 89 01                mov    %eax,%fs:(%rcx)
>   3f:   48                      rex.W
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
>    6:   73 01                   jae    0x9
>    8:   c3                      retq  =20
>    9:   48 8b 0d b2 ad 0e 00    mov    0xeadb2(%rip),%rcx        # 0xeadc=
2
>   10:   f7 d8                   neg    %eax
>   12:   64 89 01                mov    %eax,%fs:(%rcx)
>   15:   48                      rex.W
> [  916.564607] RSP: 002b:00007ffc1e936e28 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000a5
> [  916.565054] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffa1=
510f03e
> [  916.565473] RDX: 00005555d6678630 RSI: 00005555d66786b0 RDI: 00005555d=
6678690
> [  916.565893] RBP: 00005555d6678400 R08: 00005555d6678650 R09: 00007ffc1=
e935b50
> [  916.566314] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000000
> [  916.566733] R13: 00005555d6678630 R14: 00005555d6678690 R15: 00005555d=
6678400
> [  916.567160]  </TASK>
> [  916.567301] Modules linked in: tls ext4 mbcache jbd2 rfkill snd_hda_co=
dec_generic snd_hda_intel intel_rapl_msr snd_intel_dspcfg intel_rapl_common=
 snd_intel_sdw_acpi snd_hda_codec snd_hda_core sunrpc intel_uncore_frequenc=
y_common snd_hwdep snd_seq intel_pmc_core snd_seq_device intel_vsec pmt_tel=
emetry pmt_class snd_pcm qxl snd_timer pcspkr drm_ttm_helper ttm virtio_bal=
loon snd soundcore drm_kms_helper i2c_piix4 joydev drm fuse xfs libcrc32c a=
ta_generic virtio_net crct10dif_pclmul crc32_pclmul net_failover crc32c_int=
el failover ghash_clmulni_intel dimlib ata_piix virtio_console virtio_blk l=
ibata serio_raw
> [  916.570389] CR2: 0000000000000000
> [  916.570597] ---[ end trace 0000000000000000 ]---
> [  916.570876] RIP: 0010:0x0
> [ 916.571045] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  916.571428] RSP: 0018:ffffc90008f0f648 EFLAGS: 00010246
> [  916.571740] RAX: 0000000000000000 RBX: ffff88818c487820 RCX: ffffffff9=
51a6fea
> [  916.572163] RDX: 1ffffffff2ec8c6f RSI: ffffea0005130dc0 RDI: ffff88818=
c487a60
> [  916.572583] RBP: ffffea0005130dc0 R08: 0000000000000000 R09: fffff9400=
0a261b8
> [  916.573005] R10: ffffea0005130dc7 R11: 0000000000000000 R12: 000000000=
0000216
> [  916.573425] R13: ffff88818c6822d0 R14: 0000000000000000 R15: 000000000=
0000000
> [  916.573848] FS:  00007ffa15285800(0000) GS:ffff8881f6600000(0000) knlG=
S:0000000000000000
> [  916.574321] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  916.574664] CR2: ffffffffffffffd6 CR3: 000000013914c004 CR4: 000000000=
03706f0
> [  916.575087] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  916.575508] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  916.575928] note: mount[99339] exited with irqs disabled
> [  916.638225] EXT4-fs (vda3): unmounting filesystem 92fe26f7-76ab-4251-b=
ac6-305c3e2ef932.
> [  916.816486] EXT4-fs (vda3): mounted filesystem 92fe26f7-76ab-4251-bac6=
-305c3e2ef932 r/w with ordered data mode. Quota mode: none.
>=20
>=20
> >=20
> > Thanks,
> >=20
> > 					- Ted
> >=20
> =

