Return-Path: <linux-ext4+bounces-8932-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B9DB0119A
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 05:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595555C08CA
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 03:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC319C556;
	Fri, 11 Jul 2025 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzy7p8gI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E0819C54E
	for <linux-ext4@vger.kernel.org>; Fri, 11 Jul 2025 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752204047; cv=none; b=V/WI3EmLzao53+gf5kqsYdWy5Gfqd980zq06qZHvlbbR7KE9DCxvzbp4TBC+l07gILvuPswhbh7qkWWu2hfDTFJlKyl8gAoBCio7QvJcursjJR7aYsUWzO0TAclt6SfcT7UVGIHHvtP3QVQqowDDCGy/P9cKeS1Bn1nDFPIsk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752204047; c=relaxed/simple;
	bh=yrC0Hr1O2oux6pJ7z9IJt1CnbhzCJDsdbvNLpZl244A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SOLWHHNwyNdgvktumF2BW87IsBSYOJaIC/EXUN4Tl3LqufbKISl3W8OFDzHpx2AOQzYOn+JYmZ6e5tWXDq0x1YchFBHFRG6aG/LAAWIbAoXxvWcku4wXUN2bxHpAVKWyV47DM5kHrcEdJ6y1eqnFJQtd7tdqrFYaDIEW+8LYrJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fzy7p8gI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54d98aa5981so2299353e87.0
        for <linux-ext4@vger.kernel.org>; Thu, 10 Jul 2025 20:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752204043; x=1752808843; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kekF7r4ztr88Ww/9qSeMypNZTWb7k8p4YeppmRjYXoA=;
        b=Fzy7p8gIXOMu3BYp+LwI1UQ4T35ZMkwPxP7R53VF7B9V/5XOZFT5MSjw3qFVbsrpKw
         S+iXfud83XJM+gIzlQZTPWP6MGCbcyAwjlmLv//e2mdq35LeG0QAYbxjGsrP4871bXe+
         /trNJpsmejSTNj/r8wbnWJlavM5TmdCQU9twepOyExJUunO9LFKlnrvepw+HPm737hzC
         BSY1yPezZWtQkeZhw/AQRTeSXXTrhpnXrbSJz5LnnJGeyyELHXrhvozAvX2IR9sP0EiJ
         w/5HC/xOb+slwT6UreOM0x+j5kGvYt5gSefJEgXs7VG+o2zfukKKTMWT+f/n7wQXZaCt
         ZKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752204043; x=1752808843;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kekF7r4ztr88Ww/9qSeMypNZTWb7k8p4YeppmRjYXoA=;
        b=UCD+5DWxQQv8d4wRUGL0tg6l2g97cqce/7DYOYXxIb9FRTSa8npCif4DnY84nGIJOA
         JdDVW6zgVRH60FOLHEmFf3HD28t/51rPhbVfIEEl9kXpWCGZKgkFl3+jbrCqnkLaM8cB
         6M7hjlMQekXnMhumWt/2FJf95zrk2oZCPaT4qnkAM6XxnrfQHltQmRqjY+mLaAIE0pT1
         7hkis5nEekV1E4OEzN9Csmd0wFzeqpxKk/1g9D/ky9Fvz4u8ePNFAhBOWVGiTdqWih1t
         JnaysvS4ht+c3mrNRQYeTMAOP8RwEZgOoc8wd6lrBl+V7AwSV6CcbliMGUSKWtlspwmi
         U8iw==
X-Forwarded-Encrypted: i=1; AJvYcCVKJ/IBoHMjg5m69Ro30Icbw4372GhYj8p2NtMOuEhOImX8cikifYBvQnVQ1s+Jm+phDCbI6CFcSx/+@vger.kernel.org
X-Gm-Message-State: AOJu0YxlkqApja6xF5p6+dJWTkoZc0sNSbXoL/MPlUXbpOSmOwbaKd9A
	EXrgrd5bEvvAJU+nmkLhRqPK0eMLJbr7AbK4BeBYOYhQJqrYd10B5oncbLiO6/PrCo002lLRmlY
	Gq1LFrkC2d1bPvt4xK7LGbVzQ2P+g9uw=
X-Gm-Gg: ASbGncu/Nuw2XUF7bU14cszq3o/jTEkNxj+Or0IbMmbekwi4oX8ka41sQM+5dvx25Va
	At2O0+HjPmvacaNn+Cl2l299pL8RCJrBM1x0vFF+fLRK+0795L5zhgOSqDoGpPBPjwHsJPgCSmn
	6n80vSVBxEKxGbqtIc89LluTrL8UUDouVuGwXopjo92oy3FWYiolaSkyMvCGoTBOqaw+YuigBGV
	IM4
X-Google-Smtp-Source: AGHT+IFTESzfTcnEIBCYyAL8PkZbeJkbtrfzpOGl81OscSiITRgiUqVZxQ9/3pboE7+gK0ytMOmKCMm65AxvvNTdoCo=
X-Received: by 2002:a05:6512:3991:b0:553:ae05:9c48 with SMTP id
 2adb3069b0e04-55a046500a8mr350353e87.45.1752204043196; Thu, 10 Jul 2025
 20:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiany Wu <wujianyue000@gmail.com>
Date: Fri, 11 Jul 2025 11:20:32 +0800
X-Gm-Features: Ac12FXwRT4XQiX0Wk6SJYDoz0zDWX0hSrnmTFqcgjK5cFCWRU3PcUjPL3iHR8pE
Message-ID: <CAJxJ_jhEbHJiP-OzSpp2xqai-n=t2CGKXqkmvqf7T3i37Eki0A@mail.gmail.com>
Subject: Issue with ext4 filesystem corruption when writing to a file after
 disk exhaustion
To: yi.zhang@huawei.com, jack@suse.cz, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Recently I encountered an issue in kernel 6.1.123, when writing to a
file after disk exhaustion, it will report EFSCORRUPTED. I think it is
un-expected behavior.
Could you help clarify:
1. Why writing to file after disk exhaust will cause "Error while
async write back metadata"? Assume it might be inode or block metadata
is corrupted there?
2. Why would the file system corrupt, like "Aborting journal on device"?
Thank you~

Detailed reproduction steps are:
# 1. Create ext4 file system in mydisk
root@testbed:/tmp# touch mydisk
root@testbed:/tmp# ls -l mydisk
-rw-r--r-- 1 root root 0 Jul  8 05:36 mydisk
root@testbed:/tmp# truncate -s 128M mydisk
root@testbed:/tmp# ls -lh mydisk
-rw-r--r-- 1 root root 128M Jul  8 05:36 mydisk
root@testbed:/tmp# mkfs.ext4 mydisk
mke2fs 1.47.0 (5-Feb-2023)
Discarding device blocks: done
Creating filesystem with 131072 1k blocks and 32768 inodes
Filesystem UUID: b0b12002-d497-436e-b89d-d0e02f53b46d
Superblock backups stored on blocks:
        8193, 24577, 40961, 57345, 73729

Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

# 2. Mount mydisk to /mnt/test_fs
root@testbed:/tmp# mkdir /mnt/test_fs
root@testbed:/tmp# mount mydisk /mnt/test_fs/
root@testbed:/tmp# findmnt /mnt/test_fs
TARGET       SOURCE     FSTYPE OPTIONS
/mnt/test_fs /dev/loop2 ext4   rw,relatime

root@testbed:/mnt/test_fs# file /tmp/mydisk
/tmp/mydisk: Linux rev 1.0 ext4 filesystem data,
UUID=b0b12002-d497-436e-b89d-d0e02f53b46d (needs journal recovery)
(extents) (64bit) (large files) (huge files)

# 3. Exhaust disk in /mnt/test_fs with 32G test_file
root@testbed:/mnt/test_fs# fallocate -l 32716560K /mnt/test_fs/test_file
fallocate: fallocate failed: No space left on device
root@testbed:/mnt/test_fs# ls
lost+found  test_file
root@testbed:/mnt/test_fs# journalctl -f
Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset
9178112, length 1024.
Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset
274432, length 1024.
Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset
274432, length 1024.
Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset
274432, length 1024.
Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset
274432, length 1024.
Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset
274432, length 1024.
Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset
274432, length 1024.
Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset
274432, length 1024.
Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset
274432, length 1024.
Jul 08 05:43:07 testbed kernel: I/O error, dev loop2, sector 17926 op
0x1:(WRITE) flags 0x103000 phys_seg 1 prio class 2
Jul 08 05:43:07 testbed kernel: Buffer I/O error on dev loop2, logical
block 8963, lost async page write
Jul 08 05:43:07 testbed kernel: I/O error, dev loop2, sector 518 op
0x1:(WRITE) flags 0x103000 phys_seg 17 prio class 2
Jul 08 05:43:07 testbed kernel: Buffer I/O error on dev loop2, logical
block 259, lost async page write
Jul 08 05:43:07 testbed kernel: Buffer I/O error on dev loop2, logical
block 260, lost async page write
Jul 08 05:43:07 testbed kernel: Buffer I/O error on dev loop2, logical
block 261, lost async page write
Jul 08 05:43:07 testbed kernel: Buffer I/O error on dev loop2, logical
block 262, lost async page write

# 4. Write to /mnt/test_fs/file.dat with dd cmd, I/O error appears.
root@testbed:/mnt/test_fs# dd if=/dev/zero of=/mnt/test_fs/file.dat
bs=1M count=64
root@testbed:/mnt/test_fs# journalctl -f
Jul 08 05:49:24 testbed kernel: Buffer I/O error on dev loop2, logical
block 268, lost async page write
Jul 08 05:49:26 testbed kernel: EXT4-fs error (device loop2):
ext4_check_bdev_write_error:217: comm dd: Error while async write back
metadata
Jul 08 05:49:26 testbed kernel: I/O error, dev loop2, sector 20482 op
0x1:(WRITE) flags 0x4000 phys_seg 128 prio class 2

# Can see First error function is ext4_check_bdev_write_error.
root@testbed:/mnt/test_fs# dumpe2fs -h /dev/loop2
dumpe2fs 1.47.0 (5-Feb-2023)
Filesystem volume name:   <none>
Last mounted on:          /mnt/test_fs
Filesystem UUID:          b0b12002-d497-436e-b89d-d0e02f53b46d
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index
filetype needs_recovery extent 64bit flex_bg sparse_super large_file
huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean with errors
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              32768
Block count:              131072
Reserved block count:     6553
Overhead clusters:        13869
Free blocks:              42236
Free inodes:              32754
First block:              1
Block size:               1024
Fragment size:            1024
Group descriptor size:    64
Reserved GDT blocks:      256
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         2048
Inode blocks per group:   512
Flex block group size:    16
Filesystem created:       Tue Jul  8 05:37:11 2025
Last mount time:          Tue Jul  8 05:37:37 2025
Last write time:          Tue Jul  8 05:50:36 2025
Mount count:              1
Maximum mount count:      -1
Last checked:             Tue Jul  8 05:37:11 2025
Check interval:           0 (<none>)
Lifetime writes:          74 MB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      bf9009a6-ff19-41d5-8abc-a4d9cd65eeb4
Journal backup:           inode blocks
FS Error count:           4
First error time:         Tue Jul  8 05:45:22 2025
First error function:     ext4_check_bdev_write_error
First error line #:       217
First error err:          EIO
Last error time:          Tue Jul  8 05:50:36 2025
Last error function:      ext4_check_bdev_write_error
Last error line #:        217
Last error err:           EIO
Checksum type:            crc32c
Checksum:                 0x0583faaa
Journal features:         journal_incompat_revoke journal_64bit
journal_checksum_v3
Total journal size:       4096k
Total journal blocks:     4096
Max transaction length:   4096
Fast commit length:       0
Journal sequence:         0x00000002
Journal start:            1
Journal checksum type:    crc32c
Journal checksum:         0xebf7b874

# 5. unmount the filesystem, file system became read-only, result show
EFSCORRUPTED
Jul 08 06:44:17 testbed kernel: EXT4-fs (loop2): unmounting filesystem.
Jul 08 06:44:17 testbed kernel: Aborting journal on device loop2-8.
Jul 08 06:44:17 testbed kernel: EXT4-fs error (device loop2):
ext4_put_super:1232: comm umount: Couldn't clean up the journal
Jul 08 06:44:17 testbed kernel: EXT4-fs (loop2): Remounting filesystem read-only

root@testbed:/tmp# dumpe2fs -h /dev/loop2
...
FS Error count:           9
First error time:         Tue Jul  8 05:45:22 2025
First error function:     ext4_check_bdev_write_error
First error line #:       217
First error err:          EIO
Last error time:          Tue Jul  8 06:46:30 2025
Last error function:      ext4_validate_block_bitmap
Last error line #:        420
Last error err:           EFSCORRUPTED
...

Thank you~
Best regards,
Jianyue Wu

