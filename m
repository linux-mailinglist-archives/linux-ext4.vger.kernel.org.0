Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3AC12341E
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2019 19:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfLQSCK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Dec 2019 13:02:10 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42911 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfLQSCK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Dec 2019 13:02:10 -0500
Received: by mail-ed1-f50.google.com with SMTP id e10so8743092edv.9
        for <linux-ext4@vger.kernel.org>; Tue, 17 Dec 2019 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Tsb5wEU63Pjpj4+SnKPvsOmu/46Br60NYES8NumAEFM=;
        b=qWX6Y7bpteuc+QS0Un8k9NqrlhSPJYIlvtngknIUsk+sy3thOuP9uQZtlNtQUCF07j
         GpusV+lpYopryb6xihGyznUH0eQkTt6586jyHo78XT3wPB9IoEHzurdWr01T9Cetw4C1
         SsyRVPvVoXG/kfAvvyyc/L6e8IgGx/wO9DTnePj2HjtutLsWeM54qDwLpTpCldF7YG8E
         kAiF+VZqkcxwKWsboBxFdiha1aEpw8av2d8bcDwj6fe+ibLRQoitsPVr7nIXewD50shA
         iw8RDMqqZQJBME5/osm6BT03yguErNTMVo7ycI7cc9SyRZsXykoXSPuw8l+YTnxa2u0h
         aKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Tsb5wEU63Pjpj4+SnKPvsOmu/46Br60NYES8NumAEFM=;
        b=pFsctD5XnfeKcypodVqX6XxtjyjDKvhzLDr+NgTD+v+Me1V02GzZauijbkCANx+iR9
         8puAformKVCjz8g8EcrTHjLIbg7e6CIxDuPtgpJgjlOZePlP8QZBzjn0mpN0ffM3yHBu
         cHZ0lbDBUEoITdOYQdzfgzQEcz4L0dO8njrktmWJM2u3OIEMYGP4j60C1WftEsruPNjV
         j2ViiyddhlbYofNS5Nqswjjwek8RP0ylArJqPR69WXjobTvwQyaen4XblOX4lHV0WY8M
         f8OOxRALmNUuo/GU1AwnjP+IGmWCTcQ9RUEKqUPMTITVOMPZirlIrPvlqEK+Fc18gnPr
         PB4Q==
X-Gm-Message-State: APjAAAWQYLmZpsXU/e4AKktL3356N59dZgMTUC5tgxAqEPWyXm2q61pt
        lEOpZhV7jV+U/7yVh/SMuuFgeRdt7XPyHSHZpx8+U+wBMPU=
X-Google-Smtp-Source: APXvYqxGg4siWO1d4cxxWkOOx0ko0D14Vltvlmg9K3TB5pMtwFMEFeD7awXzofFrKzFg3hyzdio1Re4zbpp9QbfD/hY=
X-Received: by 2002:a17:906:b212:: with SMTP id p18mr6809943ejz.208.1576605727623;
 Tue, 17 Dec 2019 10:02:07 -0800 (PST)
MIME-Version: 1.0
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 17 Dec 2019 21:01:56 +0300
Message-ID: <CADxRZqyeaMuxoT+Rvp--bmX2-WvRs5v1yULcm3E5V4TfV5Qc2A@mail.gmail.com>
Subject: e2fsprogs.git dumpe2fs / mke2fs sigserv on sparc64
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

Getting current git e2fsprogs of dumpe2fs/mke2fs (and probably others)
segfaults (via make check) with the following backtrace:

e2fsprogs.git/tests$ dd if=/dev/zero of=/tmp/image bs=1k count=8k
8192+0 records in
8192+0 records out
8388608 bytes (8.4 MB, 8.0 MiB) copied, 0.0601931 s, 139 MB/s

e2fsprogs.git/tests$ ../misc/mke2fs -j -F -N 256 /tmp/image
mke2fs 1.46-WIP (09-Oct-2019)
Discarding device blocks: done
Creating filesystem with 8192 1k blocks and 256 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

e2fsprogs.git/tests$ file -s /tmp/image
/tmp/image: Linux rev 1.0 ext3 filesystem data,
UUID=6df2cbee-b72a-495c-b604-26a4f740ee9e (large files)

e2fsprogs.git/tests$ ../misc/dumpe2fs /tmp/image
dumpe2fs 1.46-WIP (09-Oct-2019)
Segmentation fault (core dumped)

e2fsprogs.git/tests$ file ../misc/dumpe2fs
../misc/dumpe2fs: ELF 64-bit MSB pie executable, SPARC V9, relaxed
memory ordering, version 1 (SYSV), dynamically linked, interpreter
/lib64/ld-linux.so.2,
BuildID[sha1]=6aa77fa7d29a8a4a94a2a505cb04ebc655fc01e7, for GNU/Linux
3.2.0, with debug_info, not stripped

e2fsprogs.git/tests$ gdb ../misc/dumpe2fs
GNU gdb (Debian 8.3.1-1) 8.3.1
...
Reading symbols from ../misc/dumpe2fs...
(gdb) set args /tmp/image
(gdb) run
Starting program: e2fsprogs.git/misc/dumpe2fs /tmp/image
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/sparc64-linux-gnu/libthread_db.so.1".
dumpe2fs 1.46-WIP (09-Oct-2019)

Program received signal SIGSEGV, Segmentation fault.
ext2fs_swap_group_desc2 (fs=0x10000149440, gdp=0x0) at swapfs.c:145
145 gdp->bg_block_bitmap = ext2fs_swab32(gdp->bg_block_bitmap);
(gdb) bt
#0 ext2fs_swap_group_desc2 (fs=0x10000149440, gdp=0x0) at swapfs.c:145
#1 0x00000100000133b4 in ext2fs_open2 (name=<optimized out>,
io_options=<optimized out>, flags=<optimized out>, superblock=1,
block_size=<optimized out>,
manager=<optimized out>, ret_fs=0x7fefffff0d0) at openfs.c:438
#2 0x0000010000013874 in ext2fs_open2 (ret_fs=0x7fefffff0d0,
manager=0x10000147138 <struct_unix_manager>, block_size=0,
superblock=0, flags=167936, io_options=0x0,
name=0x7fefffff742 "/tmp/image") at openfs.c:138
#3 ext2fs_open (name=0x7fefffff742 "/tmp/image", flags=<optimized
out>, superblock=<optimized out>, block_size=<optimized out>,
manager=0x10000147138 <struct_unix_manager>, ret_fs=0x7fefffff0d0) at
openfs.c:92
#4 0x0000010000004968 in main (argc=<optimized out>, argv=<optimized
out>) at dumpe2fs.c:684
(gdb) q


another one (same source at swapfs.c:145 ):

e2fsprogs.git/tests$ ../misc/mke2fs -j -F /tmp/image
mke2fs 1.46-WIP (09-Oct-2019)
Discarding device blocks: done
Creating filesystem with 8192 1k blocks and 2048 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

(same command on already existing fs):

e2fsprogs.git/tests$ ../misc/mke2fs -j -F /tmp/image
mke2fs 1.46-WIP (09-Oct-2019)
/tmp/image contains a ext3 file system
Segmentation fault (core dumped)

e2fsprogs.git/tests$ gdb -q ../misc/mke2fs
Reading symbols from ../misc/mke2fs...
(gdb) set args -j -F /tmp/image
(gdb) run
Starting program: e2fsprogs.git/misc/mke2fs -j -F /tmp/image
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/sparc64-linux-gnu/libthread_db.so.1".
mke2fs 1.46-WIP (09-Oct-2019)
/tmp/image contains a ext3 file system

Program received signal SIGSEGV, Segmentation fault.
ext2fs_swap_group_desc2 (fs=0x10000166580, gdp=0x0) at swapfs.c:145
145             gdp->bg_block_bitmap = ext2fs_swab32(gdp->bg_block_bitmap);
(gdb) bt
#0  ext2fs_swap_group_desc2 (fs=0x10000166580, gdp=0x0) at swapfs.c:145
#1  0x000001000002ba50 in ext2fs_open2 (name=<optimized out>,
io_options=<optimized out>, flags=<optimized out>, superblock=1,
block_size=<optimized out>,
    manager=<optimized out>, ret_fs=0x7feffffec20) at openfs.c:438
#2  0x000001000003b168 in print_ext2_info (device=0x7fefffff744
"/tmp/image") at plausible.c:255
#3  check_plausibility (device=0x7fefffff744 "/tmp/image",
flags=<optimized out>, ret_is_dev=0x7feffffee54) at plausible.c:255
#4  0x000001000000ae08 in PRS (argc=<optimized out>,
argv=0x7fefffff488) at mke2fs.c:1966
#5  0x0000010000005df4 in main (argc=<optimized out>,
argv=0x7fefffff488) at mke2fs.c:2935
(gdb)


e2fsprogs.git$ git desc
v1.45.4-57-g523219f2

e2fsprogs.git/tests$ uname -a
Linux ttip.nvglabs.local 5.5.0-rc2 #1325 SMP Mon Dec 16 12:20:39 MSK
2019 sparc64 GNU/Linux

e2fsprogs.git/tests$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/sparc64-linux-gnu/9/lto-wrapper
Target: sparc64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian
9.2.1-21' --with-bugurl=file:///usr/share/doc/gcc-9/README.Bugs
--enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++,gm2
--prefix=/usr --with-gcc-major-version-only --program-suffix=-9
--program-prefix=sparc64-linux-gnu- --enable-shared
--enable-linker-build-id --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --libdir=/usr/lib
--enable-nls --enable-bootstrap --enable-clocale=gnu
--enable-libstdcxx-debug --enable-libstdcxx-time=yes
--with-default-libstdcxx-abi=new --enable-gnu-unique-object
--disable-libquadmath --disable-libquadmath-support --enable-plugin
--enable-default-pie --with-system-zlib --disable-libphobos
--enable-objc-gc=auto --enable-multiarch --disable-werror
--with-cpu-32=ultrasparc --enable-targets=all --with-long-double-128
--enable-multilib --enable-checking=release --build=sparc64-linux-gnu
--host=sparc64-linux-gnu --target=sparc64-linux-gnu
Thread model: posix
gcc version 9.2.1 20191130 (Debian 9.2.1-21)

e2fsprogs.git/tests$ dpkg -l binutils libc6
||/ Name Version Architecture Description
+++-==============-============-============-==========================================
ii binutils 2.33.1-6 sparc64 GNU assembler, linker and binary utilities
ii libc6:sparc64 2.29-1 sparc64 GNU C Library: Shared libraries

Debian sid / unstable.

if you have access to 'gcc compile farm' you can test it yourself with
gcc202 machine.

Thanks.
