Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569492FB92A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Jan 2021 15:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbhASOVZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Jan 2021 09:21:25 -0500
Received: from pitta.toroid.org ([136.243.148.74]:54140 "EHLO pitta.toroid.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732221AbhASJUT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 19 Jan 2021 04:20:19 -0500
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2021 04:20:17 EST
Received: from ullu.lweshal.in (unknown [10.1.1.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by pitta.toroid.org (Postfix) with ESMTPS id 1508FFA61ED
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jan 2021 10:09:30 +0100 (CET)
Received: from ams by ullu.lweshal.in with local (Exim 4.94)
        (envelope-from <ams@toroid.org>)
        id 1l1n0y-003Yj5-Bz
        for linux-ext4@vger.kernel.org; Tue, 19 Jan 2021 14:39:28 +0530
Date:   Tue, 19 Jan 2021 14:39:28 +0530
From:   Abhijit Menon-Sen <ams@toroid.org>
To:     linux-ext4@vger.kernel.org
Subject: advice on recovery from fs corruption
Message-ID: <YAahyLpaEjiNhRk+@toroid.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi.

Summary: I have an ext4 filesystem on a LUKS-encrypted device, and I
carelessly overwrote the first ~2.5GB of the underlying block device
with dd(1). While chastising myself for being so unforgivably careless,
I humbly request advice on trying to recover anything from the corrupted
filesystem, which is still mounted.

Here's the block device and filesystem in question:

    NAME           MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    sdb              8:16   0  7.2T  0 disk
    └─sdb1           8:17   0  7.2T  0 part
      └─sdb1_crypt 254:2    0  7.2T  0 crypt /media/nas/l1

    /dev/mapper/sdb1_crypt is active and is in use.
      type:    n/a
      cipher:  aes-xts-plain64
      keysize: 256 bits
      device:  /dev/sdb1
      offset:  4096 sectors
      size:    15493750784 sectors
      mode:    read/write

    Filesystem              1K-blocks       Used  Available Use% Mounted on
    /dev/mapper/sdb1_crypt 7696239772 3081218516 4615021256  41% /media/nas/l1

I ran `dd if=ubuntu.iso of=/dev/sdb bs=8M status=progress oflag=direct`,
which wrote 2715254784 bytes to /dev/sdb.

The device is still mounted, and as soon as I realised that I ran this
command on the wrong machine (it had already completed), I started to
rsync a couple of directories off onto another volume.

One rsync is still copying files, but now "ls" under /media/nas/l1 shows
nothing, not even lost+found. The cp -a I started finished successfully
(with I/O errors on a few files), but that shell also sees no other
files now. dmesg shows many errors like this:

    [1185480.158594] EXT4-fs error (device dm-2): ext4_get_branch:171: inode #81696398: block 2403213648: comm cp: invalid block
    [1185480.159125] EXT4-fs error (device dm-2): ext4_map_blocks:605: inode #81696398: block 2403213648: comm cp: lblock 13 mapped to illegal pblock 2403213648 (length 1)
    …
    [1187747.065781] EXT4-fs error (device dm-2): htree_dirblock_to_tree:1023: inode #2: block 1239: comm ls: bad entry in directory: rec_len % 4 != 0 - offset=0, inode=1002371330, rec_len=24822, name_len=20, size=4096

Along with the superblock, I guess the block group descriptors were
overwritten, and enough of the inode tables that it can't find the root
directory or lost+found any more. Definitely not the recommended way to
install Ubuntu.

Here's what `dumpe2fs -h /dev/mapper/sdb1_crypt` shows. (Is it getting
this information from one of the backup superblocks?)

    dumpe2fs 1.44.5 (15-Dec-2018)
    Filesystem volume name:   <none>
    Last mounted on:          /media/nas/l1
    Filesystem UUID:          602da5a3-9b1d-4a44-a55f-60e333b107cd
    Filesystem magic number:  0xEF53
    Filesystem revision #:    1 (dynamic)
    Filesystem features:      ext_attr resize_inode dir_index filetype sparse_super large_file
    Filesystem flags:         signed_directory_hash
    Default mount options:    user_xattr acl
    Filesystem state:         not clean with errors
    Errors behavior:          Continue
    Filesystem OS type:       Linux
    Inode count:              200480768
    Block count:              1936718848
    Reserved block count:     0
    Free blocks:              1153755314
    Free inodes:              198450506
    First block:              0
    Block size:               4096
    Fragment size:            4096
    Reserved GDT blocks:      562
    Blocks per group:         32768
    Fragments per group:      32768
    Inodes per group:         3392
    Inode blocks per group:   212
    Filesystem created:       Sun Jan 20 22:32:01 2019
    Last mount time:          Tue Jan  5 20:29:29 2021
    Last write time:          Tue Jan 19 14:05:06 2021
    Mount count:              1
    Maximum mount count:      -1
    Last checked:             Tue Jan  5 19:26:10 2021
    Check interval:           0 (<none>)
    Lifetime writes:          2744 GB
    Reserved blocks uid:      0 (user root)
    Reserved blocks gid:      0 (group root)
    First inode:              11
    Inode size:	          256
    Required extra isize:     32
    Desired extra isize:      32
    Default directory hash:   half_md4
    Directory Hash Seed:      f0788ffe-7f52-404b-8395-e6e219da154e
    FS Error count:           17307
    First error time:         Wed Jan  6 07:56:19 2021
    First error function:     ext4_write_inode
    First error line #:       5463
    First error inode #:      163541339
    First error block #:      1579843763
    Last error time:          Tue Jan 19 14:05:06 2021
    Last error function:      htree_dirblock_to_tree
    Last error line #:        1023
    Last error inode #:       2
    Last error block #:       1239
    ext2fs_read_bb_inode: Cannot iterate data blocks of an inode containing inline data

A large portion of the contents of this filesystem are, unfortunately,
irreplaceable. The data were protected only from disk failure, not from
this sort of operator error, and I certainly regret making that decision
years ago.

I'm running `dd if=/dev/mapper/sdb1_crypt of=sdb1_crypt.img bs=8M
status=progress` now to capture an image of the unencrypted blocks of
the filesystem. I can't unmount the filesystem or anything, because I'll
never be able to mount it again. I don't even have a backup of the LUKS
header, nor an e2image for this filesystem.

It'll take a couple of days to copy all of the blocks from sdb1_crypt
(assuming nothing blows up in the interim). I'm willing to go to great
lengths to try to recover some of the data (including writing code to
trawl around the filesystem image, if needed).

With sincere apologies for asking other people to spend time on my
self-inflicted problem… what is the best approach to recovering as
many of my files as possible?

Thank you.

-- ams
