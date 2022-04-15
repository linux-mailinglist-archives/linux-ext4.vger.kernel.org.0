Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3637502C07
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Apr 2022 16:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354587AbiDOOkB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Apr 2022 10:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349869AbiDOOkA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Apr 2022 10:40:00 -0400
Received: from mail.urbanec.net (mail.urbanec.net [218.214.117.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0770F4667A
        for <linux-ext4@vger.kernel.org>; Fri, 15 Apr 2022 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=urbanec.net
        ; s=dkim_rsa; h=Content-Transfer-Encoding:Content-Type:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1Z8nICD0zLLM7k2WwmCjJvkTuzPz1n8C4ar7SrDvWv0=; i=@urbanec.net; t=1650033452
        ; x=1650897452; b=H1GK9wj43R8DiaEZd/639SpVRboM6ogHhQFI3AX0UvFGUR7pkEVv/UARCh7
        apPgL5edr6bfhjt+p/jBEDPL4m/wdJ5PNYMcUx8mrPThZ3snYZZpP39Ki5A6JXbqk2pbQgph8bx83
        mVa42fR8yCp+dHNgeSo32pi0ShDagK7BzzWZi8bs8owwgCaWjDVu8F3IuEve0BtOMq/rUDVPgken8
        I/7rrJ0Camr/GNxlF/MpS5Wn4MMJqBHxFTQJPAwi5DAbAECt4eweZQDD+W7ztWS/gZT9Mj8iWoczr
        rTLViUT6s0DuBjlrJtlmdmS9w92uqN8hAZz2opAtJcmYlSFulYYw==;
Received: from ten.urbanec.net ([192.168.42.10])
        by mail.urbanec.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linux-ext4.vger.kernel.org@urbanec.net>)
        id 1nfN4j-0003RH-7t
        for linux-ext4@vger.kernel.org; Sat, 16 Apr 2022 00:37:29 +1000
Message-ID: <493bbaea-b0d3-4f8e-20fb-5fb330a128a3@urbanec.net>
Date:   Sat, 16 Apr 2022 00:37:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Peter Urbanec <linux-ext4.vger.kernel.org@urbanec.net>
Subject: resize2fs on ext4 leads to corruption
To:     linux-ext4@vger.kernel.org
Content-Language: en-AU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I think I may have run into a resize2fs bug that leads to data loss. I 
see this:

# mount -t ext4 /dev/md0 /mnt/RED8
mount: /mnt/RED8: wrong fs type, bad option, bad superblock on /dev/md0, 
missing codepage or helper program, or other error.

Besides reporting the issue and gathering as much information as I can 
to help debug this, I'd also like to ask for some assistance trying to 
recover
the data. I'm prepared to put in some effort. I'm on Gentoo and can 
apply git patches and rebuild the kernel or compile e2fsprogs.

The system is a *32-bit* Gentoo installation built well over a decade 
ago, but is kept reasonably up to date.

# uname -a
Linux gw 5.16.9-gentoo #2 SMP Sun Feb 13 21:19:40 AEDT 2022 i686 
Intel(R) Core(TM)2 Duo CPU E8400 @ 3.00GHz GenuineIntel GNU/Linux

sys-fs/e2fsprogs
       Installed versions:  1.46.4(11:13:09 04/01/22)(nls split-usr 
threads -cron -fuse -lto -static-libs)

sys-libs/e2fsprogs-libs
       Installed versions:  1.46.4-r1(17:26:02 02/01/22)(split-usr 
-static-libs ABI_MIPS="-n32 -n64 -o32" ABI_S390="-32 -64" ABI_X86="32 
-64 -x32")


Here is the sequence of steps that lead to data loss:

Added one 8TB disk to a md raid5 array:

# mdadm --add /dev/md0 /dev/sdi1
# mdadm --grow --raid-devices=4 
--backup-file=/root/grow_md0_20220410.bak  /dev/md0

[183222.697484] md: md0: reshape done.
[183222.866677] md0: detected capacity change from 31255572480 to 
46883358720

md0 : active raid5 sdi1[4] sda1[3] sdh1[1] sdg1[0]
        23441679360 blocks super 1.2 level 5, 512k chunk, algorithm 2 
[4/4] [UUUU]
        bitmap: 0/59 pages [0KB], 65536KB chunk

# umount /mnt/RED8

# tune2fs -E stride=128,stripe_width=384  /dev/md0

# fsck.ext4 -f -v -C 0 -D /dev/md0

# mount -t ext4 /dev/md0 /mnt/RED8

At this stage I used the system for about a week without any issues. 
Then earlier today:

# umount /mnt/RED8

# e2fsck -f /dev/md0
e2fsck 1.46.4 (18-Aug-2021)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
RED8: 11665593/488370176 files (0.6% non-contiguous), 
3434311347/3906946560 blocks

# resize2fs /dev/md0
resize2fs 1.46.4 (18-Aug-2021)
Resizing the filesystem on /dev/md0 to 5860419840 (4k) blocks.
The filesystem on /dev/md0 is now 5860419840 (4k) blocks long.

So far so good. Everything appears to be working just fine until now.

# mount -t ext4 /dev/md0 /mnt/RED8
mount: /mnt/RED8: wrong fs type, bad option, bad superblock on /dev/md0, 
missing codepage or helper program, or other error.

# dumpe2fs -h /dev/md0
dumpe2fs 1.46.4 (18-Aug-2021)
dumpe2fs: Bad magic number in super-block while trying to open /dev/md0
Couldn't find valid filesystem superblock.

# dumpe2fs -o superblock=32768  -h /dev/md0
dumpe2fs 1.46.4 (18-Aug-2021)
Filesystem volume name:   RED8
Last mounted on:          /exported/Music
Filesystem UUID:          1e999cb8-12b2-4ab7-b41b-c77fd267a102
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index 
sparse_super2 filetype extent 64bit flex_bg large_dir inline_data 
sparse_super large_file huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         not clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              732553216
Block count:              5860419840
Reserved block count:     0
Free blocks:              2410725583
Free inodes:              720887623
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         4096
Inode blocks per group:   256
RAID stride:              128
RAID stripe width:        384
Flex block group size:    16
Filesystem created:       Wed Jan  2 01:42:39 2019
Last mount time:          Mon Apr 11 00:39:58 2022
Last write time:          Fri Apr 15 17:53:06 2022
Mount count:              0
Maximum mount count:      -1
Last checked:             Fri Apr 15 17:04:07 2022
Check interval:           0 (<none>)
Lifetime writes:          9 TB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      7f7889a7-4ff4-4bbb-a7d0-5e9821e7e70b
Journal backup:           inode blocks
Backup block groups:      1 178845
Checksum type:            crc32c
Checksum:                 0x47b714d9
Journal features:         journal_incompat_revoke journal_64bit 
journal_checksum_v3
Total journal size:       1024M
Total journal blocks:     262144
Max transaction length:   262144
Fast commit length:       0
Journal sequence:         0x00064746
Journal start:            0
Journal checksum type:    crc32c
Journal checksum:         0x262ca522

# e2fsck -f -C 0 -b 32768 -z /root/20220415_2015_e2fsck-b_32768.e2undo 
/dev/md0
e2fsck 1.46.4 (18-Aug-2021)
Overwriting existing filesystem; this can be undone using the command:
      e2undo /root/20220415_2015_e2fsck-b_32768.e2undo /dev/md0

e2fsck: Undo file corrupt while trying to open /dev/md0

The superblock could not be read or does not describe a valid ext2/ext3/ext4
filesystem.  If the device is valid and it really contains an ext2/ext3/ext4
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
      e2fsck -b 8193 <device>
   or
      e2fsck -b 32768 <device>

In light of recent mailing list traffic, I suspect that the issue may be 
caused by sparse_super2 .

Any suggestions as to what I could try to recover? Unfortunately, I do 
not have an undo file for the resize2fs run (which is a bit unusual for 
me, since I usually tend to take advantage of safety features).

Thanks,

      Peter Urbanec

