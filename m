Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9313C64CB86
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 14:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiLNNqV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 08:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiLNNqV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 08:46:21 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EE113F32
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 05:46:19 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NXGq90YBVz4f3mSF
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 21:46:13 +0800 (CST)
Received: from [10.174.178.134] (unknown [10.174.178.134])
        by APP4 (Coremail) with SMTP id gCh0CgDH69in05ljwUHjCA--.42616S3;
        Wed, 14 Dec 2022 21:46:16 +0800 (CST)
Subject: Re: [PATCH v2 00/12] ext4: enhance simulate fail facility
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
References: <20221110022558.7844-1-yi.zhang@huawei.com>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <56ab56ef-ea4b-e0fd-8990-5affe9d745d0@huaweicloud.com>
Date:   Wed, 14 Dec 2022 21:46:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221110022558.7844-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDH69in05ljwUHjCA--.42616S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuw15Jr4kAF1DWr4xtryfXrb_yoW7uF17pF
        y3AryfWr98X34fZrs3Ka12ka4rWa1kGr47XF9xKr18u3yxZrn3tFWktry8ZFyj9rWUA347
        X3W2y3WDW3Z5CFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello, is anybody have advice?

Thanks,
Yi.

On 2022/11/10 10:25, Zhang Yi wrote:
> Changes since v1:
>  - Fix format error in ext4_fault_ops_write().
> 
> Now we can test ext4's reliability by simulating fail facility introduced
> in commit 46f870d690fe ("ext4: simulate various I/O and checksum errors
> when reading metadata"), it can simulate checksum error or I/O error
> when reading metadata from disk. But it is functional limited, it cannot
> set failure times, probability, filters, etc. Fortunately, we already
> have common fault-injection frame in Linux, so above limitation could be
> easily supplied by using it in ext4. This patch set add ext4
> fault-injection facility to replace the old frame, supply some kinds of
> checksum error and I/O error, and also add group, inode, physical
> block and inode logical block filters. After this patch set, we could
> inject failure more precisly. The facility could be used to do fuzz
> stress test include random errors, and it also could be used to
> reprodece issues more conveniently.
> 
> Patch 1: add debugfs for preparing.
> Patch 2: introduce the fault-injection frame for ext4.
> Patch 3-11: add various kinds of faults and also do some cleanup.
> Patch 12: remove the old simulating facility.
> 
> It provides a debugfs interface in ext4/<disk>/fault_inject, besides the
> common config interfaces, we give 6 more.
>  - available_faults: present available faults we can inject.
>  - inject_faults: set faults, can set multiple at a time.
>  - inject_inode: set the inode filter, matches all inodes if not set.
>  - inject_group: set the block group filter, similar to inject_inode.
>  - inject_logical_block: set the logical block filter for one inode.
>  - inject_physical_block: set the physical block filter.
> 
> Current we add 20 available faults list below, include 8 kinds of
> metadata checksum error, 7 metadata I/O error and 5 journal error.
> After we have this facility, more other faults could be added easily
> in the future.
>  - group_desc_checksum
>  - inode_bitmap_checksum
>  - block_bitmap_checksum
>  - inode_checksum
>  - extent_block_checksum
>  - dir_block_checksum
>  - dir_index_block_checksum
>  - xattr_block_checksum
>  - inode_bitmap_eio
>  - block_bitmap_eio
>  - inode_eio
>  - extent_block_eio
>  - dir_block_eio
>  - xattr_block_eio
>  - symlink_block_eio
>  - journal_start
>  - journal_start_sb
>  - journal_get_create_access
>  - journal_get_write_access
>  - journal_dirty_metadata
> 
> For example: inject inode metadata checksum error on file 'foo'.
> 
> $ mkfs.ext4 -F /dev/pmem0
> $ mount /dev/pmem0 /mnt
> $ mkdir /mnt/dir
> $ touch /mnt/dir/foo
> $ ls -i /mnt/dir/foo
>   262146 /mnt/foo
> 
> $ echo 100 > /sys/kernel/debug/ext4/pmem0/fault_inject/probability
> $ echo 1 > /sys/kernel/debug/ext4/pmem0/fault_inject/times
> $ echo 262146 > /sys/kernel/debug/ext4/pmem0/fault_inject/inject_inode
> $ echo inode_checksum > /sys/kernel/debug/ext4/pmem0/fault_inject/inject_faults
> $ echo 1 > /sys/kernel/debug/ext4/pmem0/fault_inject/enable
> $ echo 3 > /proc/sys/vm/drop_caches ##drop cache
> $ stat /mnt/dir/foo
>   stat: cannot statx '/mnt/dir/foo': Bad message
> 
> The kmesg print the injection location.
> 
> [  461.433817] FAULT_INJECTION: forcing a failure.
> [  461.433817] name fault_inject, interval 1, probability 100, space 0, times 1
> ...
> [  461.438609] Call Trace:
> [  461.438875]  <TASK>
> [  461.439116]  ? dump_stack_lvl+0x73/0xa3
> [  461.439534]  ? dump_stack+0x13/0x1f
> [  461.439909]  ? should_fail.cold+0x4a/0x57
> [  461.440346]  ? ext4_should_fail.cold+0x11f/0x135
> [  461.440833]  ? __ext4_iget+0x407/0x1410
> [  461.441245]  ? ext4_lookup+0x1be/0x350
> [  461.441650]  ? __lookup_slow+0xb9/0x1f0
> [  461.442070]  ? lookup_slow+0x46/0x70
> [  461.442463]  ? walk_component+0x13e/0x230
> [  461.442890]  ? path_lookupat.isra.0+0x8f/0x200
> [  461.443369]  ? filename_lookup+0xd6/0x240
> [  461.443798]  ? vfs_statx+0xa6/0x200
> [  461.444186]  ? do_statx+0x48/0xc0
> [  461.444546]  ? __might_sleep+0x56/0xc0
> [  461.444950]  ? should_fail_usercopy+0x19/0x30
> [  461.445424]  ? strncpy_from_user+0x33/0x2a0
> [  461.445870]  ? getname_flags+0x95/0x330
> [  461.446288]  ? switch_fpu_return+0x27/0x1e0
> [  461.446736]  ? __x64_sys_statx+0x90/0xd0
> [  461.447160]  ? do_syscall_64+0x3b/0x90
> [  461.447563]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  461.448122]  </TASK>
> [  461.448395] EXT4-fs error (device pmem0): ext4_lookup:1840: inode #262146: comm stat: iget: checksum invalid
> 
> Thanks,
> Yi.
> 
> 
> Zhang Yi (12):
>   ext4: add debugfs interface
>   ext4: introduce fault injection facility
>   ext4: add several checksum fault injection
>   ext4: add bitmaps I/O fault injection
>   ext4: add inode I/O fault injection
>   ext4: add extent block I/O fault injection
>   ext4: add dirblock I/O fault injection
>   ext4: call ext4_xattr_get_block() when getting xattr block
>   ext4: add xattr block I/O fault injection
>   ext4: add symlink block I/O fault injection
>   ext4: add journal related fault injection
>   ext4: remove simulate fail facility
> 
>  fs/ext4/Kconfig     |   9 ++
>  fs/ext4/balloc.c    |  14 ++-
>  fs/ext4/bitmap.c    |   4 +
>  fs/ext4/dir.c       |   3 +
>  fs/ext4/ext4.h      | 181 +++++++++++++++++++++++++++++--------
>  fs/ext4/ext4_jbd2.c |  22 +++--
>  fs/ext4/ext4_jbd2.h |   5 +
>  fs/ext4/extents.c   |   7 ++
>  fs/ext4/ialloc.c    |  24 +++--
>  fs/ext4/inode.c     |  26 ++++--
>  fs/ext4/namei.c     |  14 ++-
>  fs/ext4/super.c     |   7 +-
>  fs/ext4/symlink.c   |   4 +
>  fs/ext4/sysfs.c     | 183 +++++++++++++++++++++++++++++++++++--
>  fs/ext4/xattr.c     | 216 +++++++++++++++++++-------------------------
>  15 files changed, 515 insertions(+), 204 deletions(-)
> 

