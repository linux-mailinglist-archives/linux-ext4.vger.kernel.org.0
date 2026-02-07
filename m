Return-Path: <linux-ext4+bounces-13615-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CkkJTjPhmlWRAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13615-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 06:35:52 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31376105091
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 06:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68550302AD27
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Feb 2026 05:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6652FFDDE;
	Sat,  7 Feb 2026 05:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="U1bSmgCW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B722FD7BE
	for <linux-ext4@vger.kernel.org>; Sat,  7 Feb 2026 05:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770442539; cv=none; b=BsF6gbA2WPnXkQL6Y76lLOJO5ogwnH08No7ptyeGwtTIi+9OIvddf/fybjMhgMyMADg5gP6XxCPvY1DOP6TAB3xoeBZ1txR1eCbSLD2YYDfk9PqpIEPb/wit+nZbPkzHsWGE7usWDogljb9VBCwAFAqRG21DH5OgS7+Al6nsuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770442539; c=relaxed/simple;
	bh=4bYPDW9Y4S8/VlnJqEK9VMb0M9jlvKJxeBFngaj6rDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBL8H6rzYCvn79rhZIHlasG++kcT3hVgrFHzJhHb0p+DfIlI0UpPBaiFp1Mxo8advlqss5wzqO9G0j9xGFUBSXIzHAC5sT42plXdN+YsX6T8SIHC1cvHGLmGtFB+wfN+0CByM3DDEvXRa5rsSKQmFvUigJtKfHKWXavXfh8jmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=U1bSmgCW; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-115-57.bstnma.fios.verizon.net [173.48.115.57])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6175W6bA002341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 7 Feb 2026 00:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1770442329; bh=DfViGtXHp9T2tyYndTwfJCdAmeh8b/bVucJrxRoHHXU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=U1bSmgCWB9zHXXf4t24qzOiNyxT8xOf0SeBMkz3W6JfFqDgtBiX1a6pl+fU1V6N3F
	 bEW8BeO+0zzvCjpPoiG0YoNPfUm7kCyXrIwdIpWnRqCHeuSfDRB7BzAzxvEGiIP73Y
	 I2JPZZ+m+/dXJBAW/PMZeN3LF/DozGVtc8vqWKuq/waSoHusBJXOC+yL9NaU+2DSdl
	 +OAD+n1JXrK1bEq3edYLnsWBX+4lJDpEx2p8zwbEj9wfWdyNzBTmhHcYttCBLoPfQu
	 Et9YW39or9CF6A16bEkJjMep7eQWLytYYi9fYHX8j9IQMXy6f0l5aeurYs0QaHbeWd
	 j3+Ec3+xj43nw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 2B52B57904DA; Sat,  7 Feb 2026 00:31:06 -0500 (EST)
Date: Sat, 7 Feb 2026 00:31:06 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Mario Lohajner <mario_lohajner@rocketmail.com>
Cc: Baokun Li <libaokun1@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Erkun <yangerkun@huawei.com>, libaokun9@gmail.com
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
Message-ID: <20260207053106.GA87551@macsyma.lan>
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
 <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
 <069704a4-2417-470a-bf32-0ee3afd1be6a@rocketmail.com>
 <9fc3443b-0eea-4917-909b-709113f5e706@huawei.com>
 <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
 <20260206014249.GH31420@macsyma.lan>
 <26d60068-d149-4c53-a432-8b9db6b7e6a5@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26d60068-d149-4c53-a432-8b9db6b7e6a5@rocketmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13615-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[rocketmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kvm-xfstests:email,psu.edu:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31376105091
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 08:25:24PM +0100, Mario Lohajner wrote:
> What is observable in practice, however, is persistent allocation locality
> near the beginning of the LBA space under real workloads, and a
> corresponding concentration of wear in that area, interestingly it seems to
> be vendor-agnostic. = The force within is very strong :-)

This is simply not true.  Data blocks are *not* located to the
low-numbered LBA's in kind of reasonble real-world situation.  Why do
you think this is true, and what was your experiment that led you
believe this?

Let me show you *my* experiment:

root@kvm-xfstests:~# /sbin/mkfs.ext4 -qF /dev/vdc 5g
root@kvm-xfstests:~# mount /dev/vdc /vdc
[  171.091299] EXT4-fs (vdc): mounted filesystem 06dd464f-1c3a-4a2b-b3dd-e937c1e7624f r/w with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# tar -C /vdc -xJf /vtmp/ext4-6.12.tar.xz
root@kvm-xfstests:~# ls -li /vdc
total 1080
 31018 -rw-r--r--   1 15806 15806    496 Dec 12  2024 COPYING
   347 -rw-r--r--   1 15806 15806 105095 Dec 12  2024 CREDITS
 31240 drwxr-xr-x  75 15806 15806   4096 Dec 12  2024 Documentation
 31034 -rw-r--r--   1 15806 15806   2573 Dec 12  2024 Kbuild
 31017 -rw-r--r--   1 15806 15806    555 Dec 12  2024 Kconfig
 30990 drwxr-xr-x   6 15806 15806   4096 Dec 12  2024 LICENSES
   323 -rw-r--r--   1 15806 15806 781906 Dec  1 21:34 MAINTAINERS
 19735 -rw-r--r--   1 15806 15806  68977 Dec  1 21:34 Makefile
    14 -rw-r--r--   1 15806 15806    726 Dec 12  2024 README
  1392 drwxr-xr-x  23 15806 15806   4096 Dec 12  2024 arch
   669 drwxr-xr-x   3 15806 15806   4096 Dec  1 21:34 block
131073 drwxr-xr-x   2 15806 15806   4096 Dec 12  2024 certs
 31050 drwxr-xr-x   4 15806 15806   4096 Dec  1 21:34 crypto
143839 drwxr-xr-x 143 15806 15806   4096 Dec 12  2024 drivers
140662 drwxr-xr-x  81 15806 15806   4096 Dec  1 21:34 fs
134043 drwxr-xr-x  32 15806 15806   4096 Dec 12  2024 include
 31035 drwxr-xr-x   2 15806 15806   4096 Dec  1 21:34 init
140577 drwxr-xr-x   2 15806 15806   4096 Dec  1 21:34 io_uring
140648 drwxr-xr-x   2 15806 15806   4096 Dec  1 21:34 ipc
   771 drwxr-xr-x  22 15806 15806   4096 Dec  1 21:34 kernel
143244 drwxr-xr-x  20 15806 15806  12288 Dec  1 21:34 lib
    11 drwx------   2 root  root   16384 Feb  6 16:34 lost+found
 22149 drwxr-xr-x   6 15806 15806   4096 Dec  1 21:34 mm
 19736 drwxr-xr-x  72 15806 15806   4096 Dec 12  2024 net
 42649 drwxr-xr-x   7 15806 15806   4096 Dec  1 21:34 rust
   349 drwxr-xr-x  42 15806 15806   4096 Dec 12  2024 samples
 42062 drwxr-xr-x  19 15806 15806  12288 Dec  1 21:34 scripts
    15 drwxr-xr-x  15 15806 15806   4096 Dec  1 21:34 security
131086 drwxr-xr-x  27 15806 15806   4096 Dec 12  2024 sound
 22351 drwxr-xr-x  45 15806 15806   4096 Dec 12  2024 tools
 31019 drwxr-xr-x   4 15806 15806   4096 Dec 12  2024 usr
   324 drwxr-xr-x   4 15806 15806   4096 Dec 12  2024 virt

Note how different directories have different inode numbers, which are
in different block groups.  This is how we naturally spread block
allocations across different block groups.  This is *specifically* to
spread block allocations across the entire storage device.  So for example:

root@kvm-xfstests:~# filefrag -v /vdc/arch/Kconfig
Filesystem type is: ef53
File size of /vdc/arch/Kconfig is 51709 (13 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      12:      67551..     67563:     13:             last,eof
/vdc/arch/Kconfig: 1 extent found

root@kvm-xfstests:~# filefrag -v /vdc/sound/Makefile
Filesystem type is: ef53
File size of /vdc/sound/Makefile is 562 (1 block of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       0:     574197..    574197:      1:             last,eof
/vdc/sound/Makefile: 1 extent found

See?  The are not spread across LBA's.  Quod Erat Demonstratum.

By the way, spreading block allocations across LBA's was not done
because of a concern about flash storage.  The ext2, ext3, and ewxt4
filesysetm has had this support going over a quarter of a century,
because spreading the blocks across file system avoids file
fragmentation.  It's a technique that we took from BSD's Fast File
System, called the Orlov algorithm.  For more inforamtion, see [1], or
in the ext4 sources[2].

[1] https://en.wikipedia.org/wiki/Orlov_block_allocator
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/tree/fs/ext4/ialloc.c#n398

> My concern is a potential policy interaction: filesystem locality
> policies tend to concentrate hot metadata and early allocations. During
> deallocation, we naturally discard/trim those blocks ASAP to make them
> ready for write, thus optimizing for speed, while at the same time signaling
> them as free. Meanwhile, an underlying WL policy (if present) tries to
> consume free blocks opportunistically.
> If these two interact poorly, the result can be a sustained bias toward
> low-LBA hot regions (as observable in practice).
> The elephant is in the room and is called “wear” / hotspots at the LBA
> start.

First of all, most of the "sustained bias towards low-LBA regions" is
not because where data blocks are located, but because of the location
of static metadata blocks in particular, the superblock, block group
descriptors, and the allocation bitmaps.  Having static metadata is
not unique to ext2/ext3/ext4.  The FAT file system has the File
Allocation Table in low numbered LBA's, which are constantly updated
whenever blocks are allocated.  Even log structured file systems, such
as btrfs, f2fs, and ZFS have a superblock at a static location which
gets rewriten at every file system commit.

Secondly, *because* all file systems rewrite certain LBA's, and how
flash erase blocks work, pretty much all flash translation layers for
the past two decades are *designed* to be able to deal with it.
Because of Digital Cameras and the FAT file systems, pretty much all
flash storage do *not* have a static mapping between a particular LBA
and a specific set of flash cells.  The fact that you keep asserting
that "hotspots at the LBA start" is a problem indicates to me that you
don't understand how SSD's work in real life.

So I commend to you these two articles:

https://flashdba.com/2014/06/20/understanding-flash-blocks-pages-and-program-erases/
https://flashdba.com/2014/09/17/understanding-flash-the-flash-translation-layer/

These web pages date from 12 years ago, because SSD technology is in
2026, very old technology in an industry where two years == infinity.

For a more academic perspective, there's the paper from the
conference: 2009 First International Conference on Advances in System
Simulation, published by researchers from Pennsylvania State
University:

    https://www.cse.psu.edu/~buu1/papers/ps/flashsim.pdf

The FlashSim is available as open source, and has since been used by
many other researchers to explore improvements in Flash Translation
Layer.  And even the most basic FTL algorithms mean that your proposed
RotAlloc is ***pointless***.  If you think otherwise, you're going to
need to provide convincing evidence.

> Again, we’re not focusing solely on wear leveling here, but since we
> can’t influence the WL implementation itself, the only lever we have is
> our own allocation policy.

You claim that you're not focusing on wear leveling, but every single
justification for your changes reference "wear / hotspotting".  I'm
trying to tell you that it's not an issue.  If you think it *could* be
an issue, *ever*, you need to provide *proof* --- at the very least,
proof that you understand things like how flash erase blocks work, how
flash translation layers work, and how the orlov block allocation
algorithm works.  Because with all due respect, it appears that you
are profoundly ignorant, and it's not clear why we should be
respecting your opinion and your arguments.  If you think we should,
you really need to up your game.

Regards,

					- Ted

