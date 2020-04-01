Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5CE19A547
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 08:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbgDAGWf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 02:22:35 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:60176 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731680AbgDAGWe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Apr 2020 02:22:34 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 6A8A02E0DA7;
        Wed,  1 Apr 2020 09:22:30 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id DekVpnocB3-MSZ8RRqQ;
        Wed, 01 Apr 2020 09:22:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585722150; bh=kpF8LGWI/9+wf/ztlAs/f3oReRcHy1E5LyqKCzCSlt0=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=y+QtHW8wN3faueb/h45mJ3nIl+EcJBuxAcsVvyKc0h2560d6kXu19oER7nLm7zZ71
         M1eyklsK4DOaS4imNFCVLbo5ae9ItbFjXu15n/qbiICDOweuwnVl+Wi+YzUrDYjJQX
         Sbt9BctvFz+0TMVi3vKKI3dzIS1LffBClsa8IXhI=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7613::1:5])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id f5nvPbjeoO-MRYeGmR7;
        Wed, 01 Apr 2020 09:22:28 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
        martin.petersen@oracle.com
Cc:     darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        hannes@cmpxchg.org, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <bb7d7604-8ee5-97d8-1563-9140cd499f15@yandex-team.ru>
Date:   Wed, 1 Apr 2020 09:22:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 29/03/2020 20.47, Chaitanya Kulkarni wrote:
> Hi,
> 
> This patch-series is based on the original RFC patch series:-
> https://www.spinics.net/lists/linux-block/msg47933.html.
> 
> I've designed a rough testcase based on the information present
> in the mailing list archive for original RFC, it may need
> some corrections from the author.
> 
> If anyone is interested, test results are at the end of this patch.
> 
> Following is the original cover-letter :-
> 
> Information about continuous extent placement may be useful
> for some block devices. Say, distributed network filesystems,
> which provide block device interface, may use this information
> for better blocks placement over the nodes in their cluster,
> and for better performance. Block devices, which map a file
> on another filesystem (loop), may request the same length extent
> on underlining filesystem for less fragmentation and for batching
> allocation requests. Also, hypervisors like QEMU may use this
> information for optimization of cluster allocations.
> 
> This patchset introduces REQ_OP_ASSIGN_RANGE, which is going
> to be used for forwarding user's fallocate(0) requests into
> block device internals. It rather similar to existing
> REQ_OP_DISCARD, REQ_OP_WRITE_ZEROES, etc. The corresponding
> exported primitive is called blkdev_issue_assign_range().

What exact semantics of that?

It may/must preserve present data or may/must discard them, or may fill range with random garbage?

Obviously I prefer weakest one - may discard data, may return garbage, may do nothing.

I.e. lower layer could reuse blocks without zeroing, for encrypted storage this is even safe.

So, this works as third type of dicasrd in addtion to REQ_OP_DISCARD and REQ_OP_SECURE_ERASE.

> See [1/3] for the details.
> 
> Patch [2/3] teaches loop driver to handle REQ_OP_ASSIGN_RANGE
> requests by calling fallocate(0).
> 
> Patch [3/3] makes ext4 to notify a block device about fallocate(0).
> 
> Here is a simple test I did:
> https://gist.github.com/tkhai/5b788651cdb74c1dbff3500745878856
> 
> I attached a file on ext4 to loop. Then, created ext4 partition
> on loop device and started the test in the partition. Direct-io
> is enabled on loop.
> 
> The test fallocates 4G file and writes from some offset with
> given step, then it chooses another offset and repeats. After
> the test all the blocks in the file become written.
> 
> The results shows that batching extents-assigning requests improves
> the performance:
> 
> Before patchset: real ~ 1min 27sec
> After patchset:  real ~ 1min 16sec (18% better)
> 
> Ordinary fallocate() before writes improves the performance
> by batching the requests. These results just show, the same
> is in case of forwarding extents information to underlining
> filesystem.
> 
> Regards,
> Chaitanya
> 
> Changes from RFC:-
> 
> 1. Add missing plumbing for REQ_OP_ASSIGN_RANGE similar to write-zeores.
> 2. Add a prep patch to create a helper to submit payloadless bios.
> 3. Design a testcases around the description present in the
>     cover-letter.
> 
> Chaitanya Kulkarni (1):
>    block: create payloadless issue bio helper
> 
> Kirill Tkhai (3):
>    block: Add support for REQ_OP_ASSIGN_RANGE
>    loop: Forward REQ_OP_ASSIGN_RANGE into fallocate(0)
>    ext4: Notify block device about alloc-assigned blk
> 
>   block/blk-core.c          |   5 ++
>   block/blk-lib.c           | 115 +++++++++++++++++++++++++++++++-------
>   block/blk-merge.c         |  21 +++++++
>   block/blk-settings.c      |  19 +++++++
>   block/blk-zoned.c         |   1 +
>   block/bounce.c            |   1 +
>   drivers/block/loop.c      |   5 ++
>   fs/ext4/ext4.h            |   2 +
>   fs/ext4/extents.c         |  12 +++-
>   include/linux/bio.h       |   9 ++-
>   include/linux/blk_types.h |   2 +
>   include/linux/blkdev.h    |  34 +++++++++++
>   12 files changed, 201 insertions(+), 25 deletions(-)
> 
> 1. Setup :-
> -----------
> # git log --oneline -5
> c64a4c781915 (HEAD -> req-op-assign-range) ext4: Notify block device about alloc-assigned blk
> 000cbc6720a4 loop: Forward REQ_OP_ASSIGN_RANGE into fallocate(0)
> 89ceed8cac80 block: Add support for REQ_OP_ASSIGN_RANGE
> a798743e87e7 block: create payloadless issue bio helper
> b53df2e7442c (tag: block-5.6-2020-03-13) block: Fix partition support for host aware zoned block devices
> 
> # cat /proc/kallsyms | grep -i blkdev_issue_assign_range
> ffffffffa3264a80 T blkdev_issue_assign_range
> ffffffffa4027184 r __ksymtab_blkdev_issue_assign_range
> ffffffffa40524be r __kstrtabns_blkdev_issue_assign_range
> ffffffffa405a8eb r __kstrtab_blkdev_issue_assign_range
> 
> 2. Test program, will be moved to blktest once code is upstream :-
> -----------------
> #define _GNU_SOURCE
> #include <sys/types.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <fcntl.h>
> #include <errno.h>
> 
> #define BLOCK_SIZE 4096
> #define STEP (BLOCK_SIZE * 16)
> #define SIZE (1024 * 1024 * 1024ULL)
> 
> int main(int argc, char *argv[])
> {
> 	int fd, step, ret = 0;
> 	unsigned long i;
> 	void *buf;
> 
> 	if (posix_memalign(&buf, BLOCK_SIZE, SIZE)) {
> 		perror("alloc");
> 		exit(1);
> 	}
> 
> 	fd = open("/mnt/loop0/file.img", O_RDWR | O_CREAT | O_DIRECT);
> 	if (fd < 0) {
> 		perror("open");
> 		exit(1);
> 	}
> 
> 	if (ftruncate(fd, SIZE)) {
> 		perror("ftruncate");
> 		exit(1);
> 	}
> 
> 	ret = fallocate(fd, 0, 0, SIZE);
> 	if (ret) {
> 		perror("fallocate");
> 		exit(1);
> 	}
> 	
> 	for (step = STEP - BLOCK_SIZE; step >= 0; step -= BLOCK_SIZE) {
> 		printf("step=%u\n", step);
> 		for (i = step; i < SIZE; i += STEP) {
> 			errno = 0;
> 			if (pwrite(fd, buf, BLOCK_SIZE, i) != BLOCK_SIZE) {
> 				perror("pwrite");
> 				exit(1);
> 			}
> 		}
> 
> 		if (fsync(fd)) {
> 			perror("fsync");
> 			exit(1);
> 		}
> 	}
> 	return 0;
> }
> 
> 3. Test script, will be moved to blktests once code is upstream :-
> ------------------------------------------------------------------
> # cat req_op_assign_test.sh
> #!/bin/bash -x
> 
> NULLB_FILE="/mnt/backend/data"
> NULLB_MNT="/mnt/backend"
> LOOP_MNT="/mnt/loop0"
> 
> delete_loop()
> {
> 	umount ${LOOP_MNT}
> 	losetup -D
> 	sleep 3
> }
> 
> delete_nullb()
> {
> 	umount ${NULLB_MNT}
> 	echo 1 > config/nullb/nullb0/power
> 	rmdir config/nullb/nullb0
> 	sleep 3
> }
> 
> unload_modules()
> {
> 	rmmod drivers/block/loop.ko
> 	rmmod fs/ext4/ext4.ko
> 	rmmod drivers/block/null_blk.ko
> 	lsmod | grep -e ext4 -e loop -e null_blk
> }
> 
> unload()
> {
> 	delete_loop
> 	delete_nullb
> 	unload_modules
> }
> 
> load_ext4()
> {
> 	make -j $(nproc) M=fs/ext4 modules
> 	local src=fs/ext4/
> 	local dest=/lib/modules/`uname -r`/kernel/fs/ext4
> 	\cp ${src}/ext4.ko ${dest}/
> 
> 	modprobe mbcache
> 	modprobe jbd2
> 	sleep 1
> 	insmod fs/ext4/ext4.ko
> 	sleep 1
> }
> 
> load_nullb()
> {
> 	local src=drivers/block/
> 	local dest=/lib/modules/`uname -r`/kernel/drivers/block
> 	\cp ${src}/null_blk.ko ${dest}/
> 
> 	modprobe null_blk nr_devices=0
> 	sleep 1
> 
> 	mkdir config/nullb/nullb0
> 	tree config/nullb/nullb0
> 
> 	echo 1 > config/nullb/nullb0/memory_backed
> 	echo 512 > config/nullb/nullb0/blocksize
> 
> 	# 20 GB
> 	echo 20480 > config/nullb/nullb0/size
> 	echo 1 > config/nullb/nullb0/power
> 	sleep 2
> 	IDX=`cat config/nullb/nullb0/index`
> 	lsblk | grep null${IDX}
> 	sleep 1
> 
> 	mkfs.ext4 /dev/nullb0
> 	mount /dev/nullb0 ${NULLB_MNT}
> 	sleep 1
> 	mount | grep nullb
> 
> 	# 10 GB
> 	dd if=/dev/zero of=${NULLB_FILE} count=2621440 bs=4096
> }
> 
> load_loop()
> {
> 	local src=drivers/block/
> 	local dest=/lib/modules/`uname -r`/kernel/drivers/block
> 	\cp ${src}/loop.ko ${dest}/
> 
> 	insmod drivers/block/loop.ko max_loop=1
> 	sleep 3
> 	/root/util-linux/losetup --direct-io=off /dev/loop0 ${NULLB_FILE}
> 	sleep 3
> 	/root/util-linux/losetup
> 	ls -l /dev/loop*
> 	dmesg -c
> 	mkfs.ext4 /dev/loop0
> 	mount /dev/loop0 ${LOOP_MNT}
> 	mount | grep loop0
> }
> 
> load()
> {
> 	make -j $(nproc) M=drivers/block modules
> 
> 	load_ext4
> 	load_nullb
> 	load_loop
> 	sleep 1
> 	sync
> 	sync
> 	sync
> }
> 
> unload
> load
> time ./test
> 
> 4. Test Results :-
> ------------------
> 
> # ./req_op_assign_test.sh
> + NULLB_FILE=/mnt/backend/data
> + NULLB_MNT=/mnt/backend
> + LOOP_MNT=/mnt/loop0
> + unload
> + delete_loop
> + umount /mnt/loop0
> + losetup -D
> + sleep 3
> + delete_nullb
> + umount /mnt/backend
> + echo 1
> + rmdir config/nullb/nullb0
> + sleep 3
> + unload_modules
> + rmmod drivers/block/loop.ko
> + rmmod fs/ext4/ext4.ko
> + rmmod drivers/block/null_blk.ko
> + lsmod
> + grep -e ext4 -e loop -e null_blk
> + load
> ++ nproc
> + make -j 32 M=drivers/block modules
>    CC [M]  drivers/block/loop.o
>    MODPOST 11 modules
>    CC [M]  drivers/block/loop.mod.o
>    LD [M]  drivers/block/loop.ko
> + load_ext4
> ++ nproc
> + make -j 32 M=fs/ext4 modules
>    CC [M]  fs/ext4/balloc.o
>    CC [M]  fs/ext4/bitmap.o
>    CC [M]  fs/ext4/block_validity.o
>    CC [M]  fs/ext4/dir.o
>    CC [M]  fs/ext4/ext4_jbd2.o
>    CC [M]  fs/ext4/extents.o
>    CC [M]  fs/ext4/extents_status.o
>    CC [M]  fs/ext4/file.o
>    CC [M]  fs/ext4/fsmap.o
>    CC [M]  fs/ext4/fsync.o
>    CC [M]  fs/ext4/hash.o
>    CC [M]  fs/ext4/ialloc.o
>    CC [M]  fs/ext4/indirect.o
>    CC [M]  fs/ext4/inline.o
>    CC [M]  fs/ext4/inode.o
>    CC [M]  fs/ext4/ioctl.o
>    CC [M]  fs/ext4/mballoc.o
>    CC [M]  fs/ext4/migrate.o
>    CC [M]  fs/ext4/mmp.o
>    CC [M]  fs/ext4/move_extent.o
>    CC [M]  fs/ext4/namei.o
>    CC [M]  fs/ext4/page-io.o
>    CC [M]  fs/ext4/readpage.o
>    CC [M]  fs/ext4/resize.o
>    CC [M]  fs/ext4/super.o
>    CC [M]  fs/ext4/symlink.o
>    CC [M]  fs/ext4/sysfs.o
>    CC [M]  fs/ext4/xattr.o
>    CC [M]  fs/ext4/xattr_trusted.o
>    CC [M]  fs/ext4/xattr_user.o
>    CC [M]  fs/ext4/acl.o
>    CC [M]  fs/ext4/xattr_security.o
>    LD [M]  fs/ext4/ext4.o
>    MODPOST 1 modules
>    LD [M]  fs/ext4/ext4.ko
> + local src=fs/ext4/
> ++ uname -r
> + local dest=/lib/modules/5.6.0-rc3lbk+/kernel/fs/ext4
> + cp fs/ext4//ext4.ko /lib/modules/5.6.0-rc3lbk+/kernel/fs/ext4/
> + modprobe mbcache
> + modprobe jbd2
> + sleep 1
> + insmod fs/ext4/ext4.ko
> + sleep 1
> + load_nullb
> + local src=drivers/block/
> ++ uname -r
> + local dest=/lib/modules/5.6.0-rc3lbk+/kernel/drivers/block
> + cp drivers/block//null_blk.ko /lib/modules/5.6.0-rc3lbk+/kernel/drivers/block/
> + modprobe null_blk nr_devices=0
> + sleep 1
> + mkdir config/nullb/nullb0
> + tree config/nullb/nullb0
> config/nullb/nullb0
> ├── badblocks
> ├── blocking
> ├── blocksize
> ├── cache_size
> ├── completion_nsec
> ├── discard
> ├── home_node
> ├── hw_queue_depth
> ├── index
> ├── irqmode
> ├── mbps
> ├── memory_backed
> ├── power
> ├── queue_mode
> ├── size
> ├── submit_queues
> ├── use_per_node_hctx
> ├── zoned
> ├── zone_nr_conv
> └── zone_size
> 
> 0 directories, 20 files
> + echo 1
> + echo 512
> + echo 20480
> + echo 1
> + sleep 2
> ++ cat config/nullb/nullb0/index
> + IDX=0
> + lsblk
> + grep null0
> + sleep 1
> + mkfs.ext4 /dev/nullb0
> mke2fs 1.42.9 (28-Dec-2013)
> Filesystem label=
> OS type: Linux
> Block size=4096 (log=2)
> Fragment size=4096 (log=2)
> Stride=0 blocks, Stripe width=0 blocks
> 1310720 inodes, 5242880 blocks
> 262144 blocks (5.00%) reserved for the super user
> First data block=0
> Maximum filesystem blocks=2153775104
> 160 block groups
> 32768 blocks per group, 32768 fragments per group
> 8192 inodes per group
> Superblock backups stored on blocks:
> 	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> 	4096000
> 
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (32768 blocks): done
> Writing superblocks and filesystem accounting information: done
> 
> + mount /dev/nullb0 /mnt/backend
> + sleep 1
> + mount
> + grep nullb
> /dev/nullb0 on /mnt/backend type ext4 (rw,relatime,seclabel)
> + dd if=/dev/zero of=/mnt/backend/data count=2621440 bs=4096
> 2621440+0 records in
> 2621440+0 records out
> 10737418240 bytes (11 GB) copied, 27.4579 s, 391 MB/s
> + load_loop
> + local src=drivers/block/
> ++ uname -r
> + local dest=/lib/modules/5.6.0-rc3lbk+/kernel/drivers/block
> + cp drivers/block//loop.ko /lib/modules/5.6.0-rc3lbk+/kernel/drivers/block/
> + insmod drivers/block/loop.ko max_loop=1
> + sleep 3
> + /root/util-linux/losetup --direct-io=off /dev/loop0 /mnt/backend/data
> + sleep 3
> + /root/util-linux/losetup
> NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE         DIO LOG-SEC
> /dev/loop0         0      0         0  0 /mnt/backend/data   0     512
> + ls -l /dev/loop0 /dev/loop-control
> brw-rw----. 1 root disk  7,   0 Mar 29 10:28 /dev/loop0
> crw-rw----. 1 root disk 10, 237 Mar 29 10:28 /dev/loop-control
> + dmesg -c
> [42963.967060] null_blk: module loaded
> [42968.419481] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Opts: (null)
> [42996.928141] loop: module loaded
> + mkfs.ext4 /dev/loop0
> mke2fs 1.42.9 (28-Dec-2013)
> Discarding device blocks: done
> Filesystem label=
> OS type: Linux
> Block size=4096 (log=2)
> Fragment size=4096 (log=2)
> Stride=0 blocks, Stripe width=0 blocks
> 655360 inodes, 2621440 blocks
> 131072 blocks (5.00%) reserved for the super user
> First data block=0
> Maximum filesystem blocks=2151677952
> 80 block groups
> 32768 blocks per group, 32768 fragments per group
> 8192 inodes per group
> Superblock backups stored on blocks:
> 	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632
> 
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (32768 blocks): done
> Writing superblocks and filesystem accounting information: done
> 
> + mount /dev/loop0 /mnt/loop0
> + mount
> + grep loop0
> /dev/loop0 on /mnt/loop0 type ext4 (rw,relatime,seclabel)
> + sleep 1
> + sync
> + sync
> + sync
> + ./test
> step=61440
> step=57344
> step=53248
> step=49152
> step=45056
> step=40960
> step=36864
> step=32768
> step=28672
> step=24576
> step=20480
> step=16384
> step=12288
> step=8192
> step=4096
> step=0
> 
> real	9m34.472s
> user	0m0.062s
> sys	0m5.783s
> 
