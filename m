Return-Path: <linux-ext4+bounces-1436-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D086CEAF
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 17:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C58B26D01
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479AC13C9DE;
	Thu, 29 Feb 2024 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IiUWFdUI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67913442A
	for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222366; cv=none; b=YigXxOIhg6boENDniEo3X7I7vUafyLYpjx854DRgl4OuKbbFGILjvy9zamBBqLavLE2i4Pe67jIKR7bh49ivq0ipj26vyejvD0tS4BtEZCBI6GxH27mlSClSdrUNOdOIq3djD7CXoKlYpyXCKtqXjWRNIC5+N2He9ZhaNbCbdY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222366; c=relaxed/simple;
	bh=0RtrPPQH6uV3/ZSdi4SKJKAMvfYlprdOjCN/MGvlUYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkx6XcGQDkjxbrGjfW7dcC0RkPeucaJlONxni6ir8dNR+8ixmZ+TtPY9Juj0Uryv0fRKXhX8dFyAhvzBGmUs/pzczKn1JSgSkarUAlcRQe00+ewNIsxRHmRquUFVd0aLjLCi9fjvDFQCDwoHVttx7TWo0uuIfVx/Gs8iLKH68k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IiUWFdUI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41TFxH34018501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1709222359; bh=qgFpu5hLH3X5fG+WnvcvUgcHLZWicaMH23eEuUjMWmI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=IiUWFdUIzktSSp8uRIi/tMx9ioq5P3q+TMuNk76y7kqQTSn5kAZl/7rfx7TU/ILex
	 P/M8SAYmS7aWl25dWl+TNnRKACmpTOw5gnH62GQJeua54Jc2AmeKGW0eHrWuI0DUpu
	 5wxU/jhVYm2FOGrsV8wzFgaDK3S/Ja/UHdJaagXKTEz4mIHb8h8Py/phA3Vq7bugWB
	 Y4EcOq7LY1Za3vjtlEd83SKOnGLapOB/RtCeJZBHR9fWXxGVHVaHI2Qs6HcX46QRzq
	 HUgZPDQjl6MhTe95Nw1ksMua1tJtNfh325cMdnFp2FJVzLI3DDMsxYwep28Spt2ATD
	 kQPpOZf6GWDyg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8E7CD15C0336; Thu, 29 Feb 2024 10:59:17 -0500 (EST)
Date: Thu, 29 Feb 2024 10:59:17 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org,
        syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/3] ext4: Do not create EA inode under buffer lock
Message-ID: <20240229155917.GA1146088@mit.edu>
References: <20240209111418.22308-1-jack@suse.cz>
 <20240209112107.10585-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112107.10585-2-jack@suse.cz>

On Fri, Feb 09, 2024 at 12:21:00PM +0100, Jan Kara wrote:
> ext4_xattr_set_entry() creates new EA inodes while holding buffer lock
> on the external xattr block. This is problematic as it nests all the
> allocation locking (which acquires locks on other buffers) under the
> buffer lock. This can even deadlock when the filesystem is corrupted and
> e.g. quota file is setup to contain xattr block as data block. Move the
> allocation of EA inode out of ext4_xattr_set_entry() into the callers.
> 
> Reported-by: syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>

In my testing I've found that this is causing a regression for
ext4/026 in the encrypt configuration.  This can be replicated using
"kvm-xfstests -c encrypt ext4/026.   Logs follow below.

I'll try to take a closer look, but I may end up deciding to drop this
patch or possible the whole patch series until we can figure out
what's going on.

						- Ted

ext4/026 1s ...  [10:51:57][    3.111475] run fstests ext4/026 at 2024-02-29 10:51:57
EXT4-fs (vdc): Test dummy encryption mode enabled
EXT4-fs (vdc): Test dummy encryption mode enabled
EXT4-fs error (device vdc): ext4_xattr_inode_iget:443: comm getfattr: error while reading EA inode 18 err=-116
EXT4-fs error (device vdc): ext4_xattr_inode_iget:443: comm getfattr: error while reading EA inode 18 err=-116
EXT4-fs error (device vdc): ext4_xattr_inode_iget:443: comm getfattr: error while reading EA inode 18 err=-116
EXT4-fs error (device vdc): ext4_xattr_inode_iget:443: comm getfattr: error while reading EA inode 18 err=-116
EXT4-fs error (device vdc): ext4_xattr_inode_iget:443: comm getfattr: error while reading EA inode 18 err=-116
EXT4-fs error (device vdc): ext4_xattr_inode_iget:443: comm getfattr: error while reading EA inode 18 err=-116
------------[ cut here ]------------
EA inode 18 ref_count=-1
WARNING: CPU: 0 PID: 2391 at fs/ext4/xattr.c:1064 ext4_xattr_inode_update_ref+0x1c0/0x230
CPU: 0 PID: 2391 Comm: setfattr Not tainted 6.8.0-rc3-xfstests-00021-gf7528aea5d49 #320
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:ext4_xattr_inode_update_ref+0x1c0/0x230
Code: 0b e9 21 ff ff ff 80 3d 13 47 5a 01 00 0f 85 14 ff ff ff 48 8b 73 40 48 c7 c7 a6 8e 5d 82 c6 05 fb 46 5a 01 01 e8 50 40 c1 ff <0f> 0b e9 f6 fe ff ff 80 3d e7 46 5a 01 00 0f 85 5d ff ff ff 48 8b
RSP: 0018:ffffc900032cb980 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880043438a8 RCX: 0000000000000027
RDX: ffff88807dc1c848 RSI: 0000000000000001 RDI: ffff88807dc1c840
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff82860e00
R10: ffffc900032cb828 R11: ffffffff828d0e48 R12: ffff888007c93150
R13: ffff888004343948 R14: 00000000ffffffff R15: ffff8880043438a8
FS:  00007fab1e02b740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e0e4fd2000 CR3: 000000000a0a6002 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? ext4_xattr_inode_update_ref+0x1c0/0x230
 ? __warn+0x7c/0x130
 ? ext4_xattr_inode_update_ref+0x1c0/0x230
 ? report_bug+0x173/0x1d0
 ? handle_bug+0x3a/0x70
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? ext4_xattr_inode_update_ref+0x1c0/0x230
 ext4_xattr_inode_dec_ref_all+0x166/0x330
 ext4_xattr_release_block+0x29e/0x300
 ext4_xattr_block_set+0x795/0xc70
 ext4_xattr_set_handle+0x468/0x680
 ext4_xattr_set+0x88/0x160
 __vfs_setxattr+0x96/0xd0
 __vfs_setxattr_noperm+0x79/0x1d0
 vfs_setxattr+0x9f/0x180
 setxattr+0x9e/0xc0
 path_setxattr+0xc9/0xf0
 __x64_sys_setxattr+0x2b/0x40
 do_syscall_64+0x52/0x120
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7fab1e12f4f9
Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 08 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007fffe7694618 EFLAGS: 00000206 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 000055e0e4fc3340 RCX: 00007fab1e12f4f9
RDX: 000055e0e4fc3340 RSI: 00007fffe7695a22 RDI: 00007fffe76a5a96
RBP: 00007fffe76a5a96 R08: 0000000000000000 R09: 00007fab1e247020
R10: 0000000000010000 R11: 0000000000000206 R12: 00007fffe7695a22
R13: 000055e0e3e8008c R14: 000055e0e3e82100 R15: 00007fab1e247020
 </TASK>
---[ end trace 0000000000000000 ]---
EXT4-fs error (device vdc): ext4_xattr_inode_iget:443: comm getfattr: error while reading EA inode 18 err=-116
EXT4-fs error (device vdc): ext4_xattr_inode_iget:443: comm getfattr: error while reading EA inode 18 err=-116
EXT4-fs error (device vdc): ext4_xattr_inode_iget:443: comm getfattr: error while reading EA inode 18 err=-116
EXT4-fs error (device vdc): ext4_xattr_inode_iget:443: comm getfattr: error while reading EA inode 18 err=-116
EXT4-fs (vdc): Test dummy encryption mode enabled
EXT4-fs (vdc): warning: mounting fs with errors, running e2fsck is recommended

