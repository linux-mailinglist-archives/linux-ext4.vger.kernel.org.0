Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B4B62397E
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 03:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiKJCFB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 21:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiKJCEf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 21:04:35 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5CB24A
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 18:04:32 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N74rj6xZjzHvgy;
        Thu, 10 Nov 2022 10:04:05 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 10:04:30 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 00/12] ext4: enhance simulate fail facility
Date:   Thu, 10 Nov 2022 10:25:46 +0800
Message-ID: <20221110022558.7844-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Changes since v1:
 - Fix format error in ext4_fault_ops_write().

Now we can test ext4's reliability by simulating fail facility introduced
in commit 46f870d690fe ("ext4: simulate various I/O and checksum errors
when reading metadata"), it can simulate checksum error or I/O error
when reading metadata from disk. But it is functional limited, it cannot
set failure times, probability, filters, etc. Fortunately, we already
have common fault-injection frame in Linux, so above limitation could be
easily supplied by using it in ext4. This patch set add ext4
fault-injection facility to replace the old frame, supply some kinds of
checksum error and I/O error, and also add group, inode, physical
block and inode logical block filters. After this patch set, we could
inject failure more precisly. The facility could be used to do fuzz
stress test include random errors, and it also could be used to
reprodece issues more conveniently.

Patch 1: add debugfs for preparing.
Patch 2: introduce the fault-injection frame for ext4.
Patch 3-11: add various kinds of faults and also do some cleanup.
Patch 12: remove the old simulating facility.

It provides a debugfs interface in ext4/<disk>/fault_inject, besides the
common config interfaces, we give 6 more.
 - available_faults: present available faults we can inject.
 - inject_faults: set faults, can set multiple at a time.
 - inject_inode: set the inode filter, matches all inodes if not set.
 - inject_group: set the block group filter, similar to inject_inode.
 - inject_logical_block: set the logical block filter for one inode.
 - inject_physical_block: set the physical block filter.

Current we add 20 available faults list below, include 8 kinds of
metadata checksum error, 7 metadata I/O error and 5 journal error.
After we have this facility, more other faults could be added easily
in the future.
 - group_desc_checksum
 - inode_bitmap_checksum
 - block_bitmap_checksum
 - inode_checksum
 - extent_block_checksum
 - dir_block_checksum
 - dir_index_block_checksum
 - xattr_block_checksum
 - inode_bitmap_eio
 - block_bitmap_eio
 - inode_eio
 - extent_block_eio
 - dir_block_eio
 - xattr_block_eio
 - symlink_block_eio
 - journal_start
 - journal_start_sb
 - journal_get_create_access
 - journal_get_write_access
 - journal_dirty_metadata

For example: inject inode metadata checksum error on file 'foo'.

$ mkfs.ext4 -F /dev/pmem0
$ mount /dev/pmem0 /mnt
$ mkdir /mnt/dir
$ touch /mnt/dir/foo
$ ls -i /mnt/dir/foo
  262146 /mnt/foo

$ echo 100 > /sys/kernel/debug/ext4/pmem0/fault_inject/probability
$ echo 1 > /sys/kernel/debug/ext4/pmem0/fault_inject/times
$ echo 262146 > /sys/kernel/debug/ext4/pmem0/fault_inject/inject_inode
$ echo inode_checksum > /sys/kernel/debug/ext4/pmem0/fault_inject/inject_faults
$ echo 1 > /sys/kernel/debug/ext4/pmem0/fault_inject/enable
$ echo 3 > /proc/sys/vm/drop_caches ##drop cache
$ stat /mnt/dir/foo
  stat: cannot statx '/mnt/dir/foo': Bad message

The kmesg print the injection location.

[  461.433817] FAULT_INJECTION: forcing a failure.
[  461.433817] name fault_inject, interval 1, probability 100, space 0, times 1
...
[  461.438609] Call Trace:
[  461.438875]  <TASK>
[  461.439116]  ? dump_stack_lvl+0x73/0xa3
[  461.439534]  ? dump_stack+0x13/0x1f
[  461.439909]  ? should_fail.cold+0x4a/0x57
[  461.440346]  ? ext4_should_fail.cold+0x11f/0x135
[  461.440833]  ? __ext4_iget+0x407/0x1410
[  461.441245]  ? ext4_lookup+0x1be/0x350
[  461.441650]  ? __lookup_slow+0xb9/0x1f0
[  461.442070]  ? lookup_slow+0x46/0x70
[  461.442463]  ? walk_component+0x13e/0x230
[  461.442890]  ? path_lookupat.isra.0+0x8f/0x200
[  461.443369]  ? filename_lookup+0xd6/0x240
[  461.443798]  ? vfs_statx+0xa6/0x200
[  461.444186]  ? do_statx+0x48/0xc0
[  461.444546]  ? __might_sleep+0x56/0xc0
[  461.444950]  ? should_fail_usercopy+0x19/0x30
[  461.445424]  ? strncpy_from_user+0x33/0x2a0
[  461.445870]  ? getname_flags+0x95/0x330
[  461.446288]  ? switch_fpu_return+0x27/0x1e0
[  461.446736]  ? __x64_sys_statx+0x90/0xd0
[  461.447160]  ? do_syscall_64+0x3b/0x90
[  461.447563]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  461.448122]  </TASK>
[  461.448395] EXT4-fs error (device pmem0): ext4_lookup:1840: inode #262146: comm stat: iget: checksum invalid

Thanks,
Yi.


Zhang Yi (12):
  ext4: add debugfs interface
  ext4: introduce fault injection facility
  ext4: add several checksum fault injection
  ext4: add bitmaps I/O fault injection
  ext4: add inode I/O fault injection
  ext4: add extent block I/O fault injection
  ext4: add dirblock I/O fault injection
  ext4: call ext4_xattr_get_block() when getting xattr block
  ext4: add xattr block I/O fault injection
  ext4: add symlink block I/O fault injection
  ext4: add journal related fault injection
  ext4: remove simulate fail facility

 fs/ext4/Kconfig     |   9 ++
 fs/ext4/balloc.c    |  14 ++-
 fs/ext4/bitmap.c    |   4 +
 fs/ext4/dir.c       |   3 +
 fs/ext4/ext4.h      | 181 +++++++++++++++++++++++++++++--------
 fs/ext4/ext4_jbd2.c |  22 +++--
 fs/ext4/ext4_jbd2.h |   5 +
 fs/ext4/extents.c   |   7 ++
 fs/ext4/ialloc.c    |  24 +++--
 fs/ext4/inode.c     |  26 ++++--
 fs/ext4/namei.c     |  14 ++-
 fs/ext4/super.c     |   7 +-
 fs/ext4/symlink.c   |   4 +
 fs/ext4/sysfs.c     | 183 +++++++++++++++++++++++++++++++++++--
 fs/ext4/xattr.c     | 216 +++++++++++++++++++-------------------------
 15 files changed, 515 insertions(+), 204 deletions(-)

-- 
2.31.1

