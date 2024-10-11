Return-Path: <linux-ext4+bounces-4571-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4828899A98F
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 19:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AA91C217D0
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8981A00FE;
	Fri, 11 Oct 2024 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qojfLcBp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA619F41A
	for <linux-ext4@vger.kernel.org>; Fri, 11 Oct 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666687; cv=none; b=U4QoZRqyUMVb3NT/X/Ap/aSRV3qLbKofyOqM4KQc60+SA3cp/THhDLyxWSTi5KZcAnkoESh2gASqS4VknGXaW79Qe/AiCMR7uuRJB1iLYtq9qK31R3oxE1lDdcuzkudbaZRXqg7+Dhar3KpldfYDAvtqj1YWlUqV0mgUsq48MG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666687; c=relaxed/simple;
	bh=+gl8FSfTrHxIoJjLooG3KRpfMg0TUy/KuKeL3rUHFeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I20J1bC4Ie2hvAFKP06BE1HK3jEn/KxYp6YA8TYLKFN0FMFeXGrURhfhCk+D5sI+eV7p9/fliSUrFEVe7jmhGFtvMutsJ9ptEcy+D4Y+zyQgJgCELG3yHpIOW6QQaji2hWF74u/CQo6HIfUhUcrd21gwc9GJjyzK+xnVNvZbqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qojfLcBp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/U4Aq/5TBUtXpsxDkd1/qi+M3IKwRrAHRYW8XyrRO8M=; b=qojfLcBp3lo+SkdmxlqLcbhn89
	YE1r4ifaxbnjRvnYED7BxHZoLF2bb/4avl6zCRIN9SqFvwMul2ijQWBW3qA/SPVu7Sul81yERMcvi
	/m0K8jQD0AE7EhTBtatYPByuOpNZWvK3eyHsXn+L0jL22WW5poFbRpy4/umjc+KgcQMshqKd1ecNf
	n34SeshvsG17aOKftUxtNCWLippt0WXUjY49QGMWOIAMy/kZmQIxSr7Oa97fHNI507u6RRXoobKu5
	2qN76blVDFvSMFHaU7xNZhOI8j7svJI3tnc8SEOKiHKBlLnCVdNwhb3wTz9tV5gGHNndoEsdzeEJC
	zwcf9v4Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51254)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1szJAe-0004MH-1g;
	Fri, 11 Oct 2024 18:11:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1szJAc-0008Rw-03;
	Fri, 11 Oct 2024 18:11:18 +0100
Date: Fri, 11 Oct 2024 18:11:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: BUG: 6.10: ext4 mpage_process_page_bufs() BUG_ON triggers
Message-ID: <ZwlcNXOPTX0MVWQe@shell.armlinux.org.uk>
References: <ZtirReiX7J+MDhuh@shell.armlinux.org.uk>
 <Zti1Y5fthhgiL5Xb@shell.armlinux.org.uk>
 <Zti6G4Wq3pQHcs++@shell.armlinux.org.uk>
 <20240905131542.GS9627@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905131542.GS9627@mit.edu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 05, 2024 at 09:15:42AM -0400, Theodore Ts'o wrote:
> Hmm, so you can reliably reproduce this when you boot the VM into
> 6.10, but not when using 6.7?  And this is on an arm64 system,
> correct?  What is the VM doing?  Does this show up when you boot it,
> or when you kick off some kind of appliance?  What sort of devices are
> you using with the VM, and what is the VMM that you are using (e.g.,
> qemu, Oracle's Cloud, etc.)?
> 
> Is the VM image something you can share?  Or can you share the
> metadata-only image using the e2image -Q command?

Hi Ted,

I've had another instance of it, discovered today. A VM that was
running fine yesterday was dead this morning - ssh closed any
attempt to connect within a few seconds. Trying to login through
the hypervisor console resulted in a response to typing and then
nothing further. Even sysrq was dead because the console had been
closed.

I dumped the VM memory to disk - its only 128MB and set about
extracting the kernel messages, and found these as the last
messages:

EXT4-fs error (device vda1): ext4_lookup:1854: inode #32801: comm mandb: iget: checksum invalid
Aborting journal on device vda1-8.8
EXT4-fs (vda1): Remounting filesystem read-only

So, we now have the cause and inode number, and the reason (invalid
checksum). I discovered today that ext4 records details of the error
on the filesystem, accessible using tune2fs:

First error time:         Fri Oct 11 07:18:38 2024
First error function:     ext4_lookup
First error line #:       1854
First error inode #:      32801
First error err:          EFSBADCRC
Last error time:          Fri Oct 11 07:18:38 2024
Last error function:      ext4_lookup
Last error line #:        1854
Last error inode #:       32801
Last error err:           EFSBADCRC
Checksum type:            crc32c
Checksum:                 0xb71f356b

Running e2fsck -n on the filesystem reveals no checksum errors, only
two block/inode counts being wrong:

e2fsck 1.46.2 (28-Feb-2021)
Warning: skipping journal recovery because doing a read-only filesystem check.
/dev/loop0p1 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Free blocks count wrong (106574, counted=106578).
Fix? no

Free inodes count wrong (82348, counted=82353).
Fix? no

/dev/loop0p1: 48724/131072 files (1.2% non-contiguous), 417202/523776 blocks

So, I think we can conclude that the on-disk checksums are correct, and
apart from the filesystem still being mounted in the guest, albiet now
in read-only errored state with an unrecovered journal, I think e2fsck
result is healthy.

This reminded me of our previous thread where checksums were apparently
invalid, which came down to a compiler bug miscompiling the ext4
checksum code.

https://lore.kernel.org/all/20210105195004.GF1551@shell.armlinux.org.uk/

However, after having looked at the generated code, it isn't a repeat
of that (thankfully!) However, it does have the feel of something very
very subtle - a specific set of swiss cheese slices that come together
such that all the holes line up...

Let's have a look at the data for the inode on disk:

debugfs:  ncheck 32801
Inode   Pathname
32801   /usr/share/man/man3/tmpnam.3.gz
debugfs:  stat <32801>
Inode: 32801   Type: regular    Mode:  0644   Flags: 0x80000
Generation: 1819410294    Version: 0x00000000:00000004
User:     0   Group:     0   Project:     0   Size: 1623
File ACL: 0
Links: 1   Blockcount: 8
Fragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x649205ad:2957c9bc -- Tue Jun 20 21:01:49 2023
 atime: 0x64920601:4d5bb184 -- Tue Jun 20 21:03:13 2023
 mtime: 0x644e45fe:00000000 -- Sun Apr 30 11:42:06 2023
crtime: 0x649205ac:7432ceb4 -- Tue Jun 20 21:01:48 2023
Size of extra inode fields: 32
Inode checksum: 0x569f27e5
EXTENTS:
(0):59627
debugfs:  imap <32801>
Inode 32801 is part of block group 4
        located at block 2339, offset 0x0000
debugfs:  id <32801>
0000  a481 0000 5706 0000 0106 9264 ad05 9264  ....W......d...d
0020  fe45 4e64 0000 0000 0000 0100 0800 0000  .ENd............
0040  0000 0800 0400 0000 0af3 0100 0400 0000  ................
0060  0000 0000 0000 0000 0100 0000 ebe8 0000  ................
0100  0000 0000 0000 0000 0000 0000 0000 0000  ................
*
0140  0000 0000 76ff 716c 0000 0000 0000 0000  ....v.ql........
0160  0000 0000 0000 0000 0000 0000 e527 0000  .............'..
0200  2000 9f56 bcc9 5729 0000 0000 84b1 5b4d   ..V..W)......[M
0220  ac05 9264 b4ce 3274 0000 0000 0000 0000  ...d..2t........
0240  0000 0000 0000 0000 0000 0000 0000 0000  ................
*

We can see the checksum in there, so let's go searching the
memory dump for it. This is the hexdump -C offset from the start
of memory. PAGE_OFFSET=0xc0000000. The only place the bytes
corresponding to the checksum (e5, 27, ... 57, 29) appear are:

07973000  a4 c7 04 12 9b 86 ca 80  e4 21 cd 00 4f 80 3d 88  |.........!..O.=.|
07973010  fe 45 4e 64 00 00 00 00  00 00 01 00 08 00 00 00  |.ENd............|
07973020  00 00 08 00 04 00 00 00  0a f3 01 00 04 00 00 00  |................|
07973030  00 00 00 00 00 00 00 00  01 00 00 00 eb e8 00 00  |................|
07973040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
07973060  00 00 00 00 76 ff 71 6c  00 00 00 00 00 00 00 00  |....v.ql........|
07973070  00 00 00 00 00 00 00 00  00 00 00 00 e5 27 00 00  |.............'..|
07973080  20 00 9f 56 bc c9 57 29  00 00 00 00 84 b1 5b 4d  | ..V..W)......[M|
07973090  ac 05 92 64 b4 ce 32 74  00 00 00 00 00 00 00 00  |...d..2t........|
079730a0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

All other bytes correspond except for the first 16 bytes (well, the
first byte is correct but the others in that row are all different.
Note the block number for the data - 0xe8eb (59627).

To make sure that there isn't a journal entry pending on disk that
might update the inode with what I found in memory, I naievely
searched the journal blocks for the block number in the embedded
ext4 extent in the inode and found nothing. Either that isn't
sufficient, or there isn't anything outstanding. In any case, if
the timestamps had changed (bytes 8-15) then the nanosecond/epoch
parts that appear later in the ext4_inode structure should also be
different. It would be very lucky to only change the seconds part
of the timestamp!

We know that ext4_inode is looked up through a buffer head, and from
the imap command in debugfs, this inode is at block 2339 (0x923)
offset 0.

We find a pointer to 0xc7973000 only once in the entire memory dump
at offset 185af9c:

0185af80  19 00 00 00 80 af 85 c1  2c a4 fe c7 00 00 00 00  |........,.......|
0185af90  23 09 00 00 00 00 00 00  00 10 00 00 00 30 97 c7  |#............0..|
0185afa0  80 a0 80 c1 50 84 43 c0  00 00 00 00 ac af 85 c1  |....P.C.........|
0185afb0  ac af 85 c1 00 00 00 00  00 00 00 00 00 00 00 00  |................|

which appears to be the struct buffer_head.
b_state		= 0x00000019	BH_Mapped | BH_Req | BH_Uptodate
b_this_page	= 0xc185af80
b_page/b_folio	= 0xc7fea42c
b_blocknr	= 0x923 (2339) - as expected
b_size		= 0x1000 (4096) - page size
b_data		= 0xc7973000
b_bdev		= 0xc180a080
b_end_io	= 0xc0438450
b_private	= NULL
b_assoc_buffers.next = 0xc185afac \ empty
b_assoc_buffers.prev = 0xc185afac / list
b_count		= 0

Chasing this to the struct page (I don't think it's a folio because
it isn't large enough) at offset 7fea42c:

07fea420  ff ff ff ff 02 00 00 00  00 70 6f c2 24 42 00 14  |.........po.$B..|
07fea430  a0 a3 fe c7 74 a5 fe c7  20 a3 80 c1 23 09 00 00  |....t... ...#...|
07fea440  80 af 85 c1 ff ff ff ff  02 00 00 00 00 d0 d6 c2  |................|

flags		= 0x14004224, which I believe mean
		  PG_referenced | PG_lru | PG_workingset |
		  PG_private | LRU_REFS(2) | LRU_GEN(2)
lru.next	= 0xc7fea3a0
lru.prev	= 0xc7fea474
mapping		= 0xc180a320
index		= 0x923 (2339) - as expected
private		= 0xc185af80 - pointer to struct buffer_head above
_map_count	= 0xffffffff
_ref_count	= 2
memcg_data	= 0xc2d6d000

So, it looks like the page is still in use and not free. This is the
only place I can find a pointer to the struct buffer_head in the
memory dump, apart from buffer_head.b_this_page.

Now, given that the memory dump of the VM has been created hours after
it's crashed, I can't see CPU cache being an issue, because if the
data was corrupted at the time ext4 came across the error, that data
would've been evicted a hours ago.

I thought maybe something could be gleaned from the values in the
corruption, but it makes no sense to me - they don't seem to be valid
pointers:

corrupted	on-disk
0x1204c7a4	0x000081a4
0x80ca869b	0x00000657
0x00cd21e4	0x64920601
0x883d804f	0x649208ad

So I'm rather stumped at the moment. I'm now thinking that this isn't an
ext4 issue, but instead could be something really very subtle in the MM,
virtio, or even qemu. I don't see it being qemu, because 6.7 was fine.

This is the second 6.10 VM that has died on the machine - it's running
exactly the same kernel binary as the other VM that previously died.

I've saved the qcow of the filesystem, and also have the coredump of
the VM's memory in case it needs further investigation.

I'm about to throw 6.11 on at least some of these VMs (including the
two that failed) so the on-disk filesystem is going to be e2fscked
shortly. As I said above, I don't think this is an ext4 issue, but
something corrupting ext4 in-memory data structures. It could be
related to the VM having a relatively small amount of memory compared
to modern standards (maybe adding MM pressure to tickle a bug in
there). Or maybe we have another case of a tail-call optimisation
gone wrong that corrupts a pointer causing ext4 in-memory data to
be scribbled over. I'm grasping at straws at the moment though...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

