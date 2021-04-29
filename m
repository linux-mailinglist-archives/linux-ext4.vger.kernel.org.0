Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108E936EF0B
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 19:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbhD2Rjh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 13:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240928AbhD2Rjg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 29 Apr 2021 13:39:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A39361400
        for <linux-ext4@vger.kernel.org>; Thu, 29 Apr 2021 17:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619717929;
        bh=T6dJvDpIfZmcB9FdGpZYru5E5ydEpY7cvrayGd80Yis=;
        h=Date:From:To:Subject:From;
        b=rvRXtmyseEDn5nP7ofFDpXF2PfmuH6vVptMIU9mt9MrPH1jgM0mwE2yGts+kOHQwT
         N63z2iXp3pYh5Yu6vBTNZTHFCl5KqTJmCFQheYnInA/hXKKGWHeg8RFbOeO3vdHAz7
         ArlkoQUW/ZGu2egQINYifRxuoyXM4XRm6TS2B/RhwO7PtLiB8GW4aGtEVkMtcV7eRX
         OQnDNbnWlyVXnWUIDDMPfRko+iX/iBC2kEYMtlinNSD5WHxb8O/sdX3sZ/3bZJwIXu
         OIJrAJztKtQUB35x0vfuApBZsS2OwmEBg8fF2rD4TIxl+3zbWvts5RfQphZjhMpjKh
         UdtAV4XKtRvEw==
Date:   Thu, 29 Apr 2021 10:38:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: ext4/307 failures?
Message-ID: <20210429173848.GB3122213@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi everyone,

I've been running ext4 through fstets with the default configurations,
and I keep seeing failures in ext4/307:

mke2fs 1.46.3~WIP-2021-03-01 (1-Mar-2021)
Creating filesystem with 131072 4k blocks and 32768 inodes
Filesystem UUID: 922458a1-3a3c-4479-b8bf-33331e9c8583
Superblock backups stored on blocks: 
        32768, 98304

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

fsstress  -p4 -n999 -f setattr=1 -ffsync=0 -fsync=0 -ffdatasync=0 -d /opt/fsstress.244005
# /tmp/fstests/src/e4compact -i -v -f /opt/donor
Init donor /opt/donor off:0 len:64000 bsz:4096
do_defrag_range /opt/fsstress.244005/p2/d2/d20/d81/f91 start:0 len:171 donor [0, 64000]
process /opt/fsstress.244005/p2/d2/d20/d81/f91  it:1 start:0 len:171 donor:0,moved:171 ret:0 errno:0
do_defrag_range /opt/fsstress.244005/p2/d2/d20/d81/fad start:0 len:1257 donor [171, 63829]
process /opt/fsstress.244005/p2/d2/d20/d81/fad  it:1 start:0 len:1257 donor:171,moved:0 ret:-1 errno:61
do_defrag_range EXT4_IOC_MOVE_EXT failed err:61

This continues for quite a while, and then:

do_defrag_range /opt/fsstress.244005/p0/d1/d2b/d80/db2/d69/d74/fb7 start:0 len:349 donor [59989, 4011]
process /opt/fsstress.244005/p0/d1/d2b/d80/db2/d69/d74/fb7  it:1 start:0 len:349 donor:59989,moved:349 ret:0 errno:0
do_defrag_range /opt/fsstress.244005/p0/d1/d2b/d80/db2/d69/d74/fbe start:0 len:648 donor [60338, 3662]
process /opt/fsstress.244005/p0/d1/d2b/d80/db2/d69/d74/fbe  it:1 start:0 len:648 donor:60338,moved:648 ret:0 errno:0
do_defrag_range /opt/fsstress.244005/p0/d1/d2b/d80/db2/d69/f68 start:0 len:583 donor [60986, 3014]
process /opt/fsstress.244005/p0/d1/d2b/d80/db2/d69/f68  it:1 start:0 len:583 donor:60986,moved:583 ret:0 errno:0
do_defrag_range /opt/fsstresse4compact: e4compact.c:68: do_defrag_range: Assertion `donor->length >= len' failed.
./common/rc: line 3775: 244234 Aborted                 (core dumped) "$@" >> $seqres.full 2>&1
failed: '/tmp/fstests/src/e4compact -i -v -f /opt/donor'
failed: '/tmp/fstests/src/e4compact -i -v -f /opt/donor'
(see /var/tmp/fstests/ext4/307.full for details)

It looks like we failed inside src/e4compact.c at:

Program terminated with signal SIGABRT, Aborted.
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
50      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) where
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
#1  0x00007f9fb92e6859 in __GI_abort () at abort.c:79
#2  0x00007f9fb92e6729 in __assert_fail_base (fmt=0x7f9fb947c588 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x55dc83526010 "donor->length >= len", 
    file=0x55dc83526004 "e4compact.c", line=68, function=<optimized out>) at assert.c:92
#3  0x00007f9fb92f7f36 in __GI___assert_fail (assertion=0x55dc83526010 "donor->length >= len", file=0x55dc83526004 "e4compact.c", line=68, 
    function=0x55dc835262b0 <__PRETTY_FUNCTION__.1> "do_defrag_range") at assert.c:101
#4  0x000055dc83525b20 in do_defrag_range (fd=<optimized out>, name=0x55dc853462b0 "/opt/fsstress.244005/p0/d1/d7d/fbf", start=<optimized out>, len=<optimized out>, donor=0x7ffd6a2a39c0)
    at e4compact.c:68
#5  0x000055dc83525638 in main (argc=<optimized out>, argv=<optimized out>) at e4compact.c:279

And digging around in gdb, it looks like we have a donor file that's
much shorter than the file being compacted?

(gdb) p donor
$1 = {
  fd = 4,
  offset = 63936,
  length = 64
}
(gdb) p eof_blk
$2 = 3742
(gdb) p st
$3 = {
  st_dev = 2052,
  st_ino = 32,
  st_nlink = 3,
  st_mode = 33206,
  st_uid = 43,
  st_gid = 202,
  __pad0 = 0,
  st_rdev = 0,
  st_size = 15326354,
  st_blksize = 4096,
  st_blocks = 6936,
  st_atim = {
    tv_sec = 1619651668,
    tv_nsec = 652000000
  },
  st_mtim = {
    tv_sec = 1619651668,
    tv_nsec = 80000000
  },
  st_ctim = {
    tv_sec = 1619651668,
    tv_nsec = 80000000
  },
  __glibc_reserved = {0, 0, 0}
}

Not sure what's going on here, but if someone has spare cycles, it might
be worth taking a look.

--D
