Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE1B38DB61
	for <lists+linux-ext4@lfdr.de>; Sun, 23 May 2021 16:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEWONT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 May 2021 10:13:19 -0400
Received: from out20-39.mail.aliyun.com ([115.124.20.39]:51236 "EHLO
        out20-39.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhEWONS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 May 2021 10:13:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436283|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0512656-0.00285802-0.945876;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KHazXdk_1621779109;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KHazXdk_1621779109)
          by smtp.aliyun-inc.com(10.147.41.231);
          Sun, 23 May 2021 22:11:49 +0800
Date:   Sun, 23 May 2021 22:11:49 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4/310: test journal checkpoint ioctl
Message-ID: <YKpipecQz4vSDDtP@desktop>
References: <20210519144751.466933-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519144751.466933-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 19, 2021 at 02:47:51PM +0000, Leah Rumancik wrote:
> Test journal checkpointing and journal erasing via
> EXT4_IOC_CHECKPOINT with flag EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT set.

It seems that this ioctl is not upstreamed yet, it'd be better to
mention the titles of related patches, so people could know which kernel
patches are required to pass this test, and know the backgrounds by
reading the kernel thread.

> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  src/Makefile             |   3 +-
>  src/checkpoint_journal.c |  95 ++++++++++++++++++++++++++++++++
>  tests/ext4/310           | 114 +++++++++++++++++++++++++++++++++++++++
>  tests/ext4/310.out       |   2 +
>  tests/ext4/group         |   1 +
>  5 files changed, 214 insertions(+), 1 deletion(-)
>  create mode 100644 src/checkpoint_journal.c
>  create mode 100644 tests/ext4/310

New test file is in 0755 mode.

>  create mode 100644 tests/ext4/310.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index cc0b9579..e0e7006b 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -17,7 +17,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
>  	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
> -	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc
> +	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> +	checkpoint_journal

Missing an entry in .gitignore

>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/checkpoint_journal.c b/src/checkpoint_journal.c
> new file mode 100644
> index 00000000..0347e0c0
> --- /dev/null
> +++ b/src/checkpoint_journal.c
> @@ -0,0 +1,95 @@
> +#include <sys/ioctl.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <linux/fs.h>
> +#include <getopt.h>
> +
> +/*
> + * checkpoint_journal.c
> + *
> + * Flush journal log and checkpoint journal for ext4 file system and
> + * optionally, issue discard or zeroout for the journal log blocks.
> + *
> + * Arguments:
> + * 1) mount point for device
> + * 2) flags (optional)
> + *	set --erase=discard to enable discarding journal blocks
> + *	set --erase=zeroout to enable zero-filling journal blocks
> + *	set --dry-run flag to only perform input checking
> + */
> +
> +#if defined(__linux__) && !defined(EXT4_IOC_CHECKPOINT)
> +#define EXT4_IOC_CHECKPOINT	_IOW('f', 43, __u32)
> +#endif
> +
> +
> +#if defined(__linux__) && !defined(EXT4_IOC_CHECKPOINT_FLAG_DISCARD)
> +#define EXT4_IOC_CHECKPOINT_FLAG_DISCARD		1
> +#define EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT		2
> +#define EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN		4
> +#endif
> +
> +
> +int main(int argc, char** argv) {
> +	int fd, c, ret = 0, option_index = 0;
> +	char* rpath;
> +	unsigned int flags = 0;
> +
> +	static struct option long_options[] =
> +	{
> +		{"dry-run", no_argument, 0, 'd'},
> +		{"erase", required_argument, 0, 'e'},
> +		{0, 0, 0, 0}
> +	};
> +
> +	/* get optional flags */
> +	while ((c = getopt_long(argc, argv, "de:", long_options,
> +				&option_index)) != -1) {
> +		switch (c) {
> +		case 'd':
> +			flags |= EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN;
> +			break;
> +		case 'e':
> +			if (strcmp(optarg, "discard") == 0) {
> +				flags |= EXT4_IOC_CHECKPOINT_FLAG_DISCARD;
> +			} else if (strcmp(optarg, "zeroout") == 0) {
> +				flags |= EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT;
> +			} else {
> +				fprintf(stderr, "Error: invalid erase option\n");
> +				return 1;
> +			}
> +			break;
> +		default:
> +			return 1;
> +		}
> +	}
> +
> +	if (optind != argc - 1) {
> +		fprintf(stderr, "Error: invalid number of arguments\n");
> +		return 1;
> +	}
> +
> +	/* get fd to file system */
> +	rpath = realpath(argv[optind], NULL);
> +	fd = open(rpath, O_RDONLY);
> +	free(rpath);
> +
> +	if (fd == -1) {
> +		fprintf(stderr, "Error: unable to open device %s: %s\n",
> +			argv[optind], strerror(errno));
> +		return 1;
> +	}
> +
> +	ret = ioctl(fd, EXT4_IOC_CHECKPOINT, &flags);
> +
> +	if (ret)
> +		fprintf(stderr, "checkpoint ioctl returned error: %s\n", strerror(errno));
> +
> +	close(fd);
> +	return ret;
> +}
> +
> diff --git a/tests/ext4/310 b/tests/ext4/310
> new file mode 100644
> index 00000000..3693cb29
> --- /dev/null
> +++ b/tests/ext4/310
> @@ -0,0 +1,114 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Google, Inc. All Rights Reserved.
> +#
> +# FS QA Test No. 310
> +#
> +# Test checkpoint and zeroout of journal via ioctl EXT4_IOC_CHECKPOINT
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +status=1       # failure is the default!
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs ext4
> +
> +_require_scratch
> +_require_command "$DEBUGFS_PROG" debugfs
> +
> +checkpoint_journal=$here/src/checkpoint_journal
> +_require_test_program "checkpoint_journal"
> +
> +# convert output from stat<journal_inode> to list of block numbers
> +get_journal_extents() {
> +	inode_info=$($DEBUGFS_PROG $SCRATCH_DEV -R "stat <8>" 2>> $seqres.full)
> +	echo -e "\nJournal info:" >> $seqres.full
> +	echo "$inode_info" >> $seqres.full
> +
> +	extents_line=$(echo "$inode_info" | awk '/EXTENTS:/{ print NR; exit }')
> +	get_extents=$(echo "$inode_info" | sed -n "$(($extents_line + 1))"p)
> +
> +	# get just the physical block numbers
> +	get_extents=$(echo "$get_extents" |  perl -pe 's|\(.*?\):||g' | sed -e 's/, /\n/g' | perl -pe 's|(\d+)-(\d+)|\1 \2|g')
> +
> +	echo "$get_extents"
> +}
> +
> +
> +# checks all extents are zero'd out except for the superblock
> +# arg 1: extents (output of get_journal_extents())
> +check_extents() {
> +	echo -e "\nChecking extents:" >> $seqres.full
> +	echo "$1" >> $seqres.full
> +
> +	super_block="true"
> +	echo "$1" | while IFS= read line; do
> +		start_block=$(echo $line | cut -f1 -d' ')
> +		end_block=$(echo $line | cut -f2 -d' ' -s)
> +
> +		# if first block of journal, shouldn't be wiped
> +		if [ "$super_block" == "true" ]; then
> +			super_block="false"
> +
> +			#if super block only block in this extent, skip extent
> +			if [ -z "$end_block" ]; then
> +				continue;
> +			fi
> +			start_block=$(($start_block + 1))
> +		fi
> +
> +		if [ ! -z "$end_block" ]; then
> +			blocks=$(($end_block - $start_block + 1))
> +		else
> +			blocks=1
> +		fi
> +
> +		check=$(od $SCRATCH_DEV --skip-bytes=$(($start_block * $blocksize)) --read-bytes=$(($blocks * $blocksize)) -An -v | sed -e 's/[0 \t\n\r]//g')
> +
> +		[ ! -z "$check" ] && echo "error" && break
> +	done
> +}
> +
> +testdir="${SCRATCH_MNT}/testdir"
> +
> +_scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1

This test requires ext4 is created with a journal, so we need

_require_metadata_journaling $SCRATCH_DEV

here after creating filesystem on $SCRATCH_DEV

> +_scratch_mount >> $seqres.full 2>&1
> +blocksize=$(_get_block_size $SCRATCH_MNT)
> +mkdir $testdir
> +
> +# check if ioctl present, skip test if not present
> +$checkpoint_journal $SCRATCH_MNT --dry-run || _notrun "journal checkpoint ioctl not present on device"
> +
> +# create some files to add some entries to journal
> +for i in {1..100}; do
> +	touch $testdir/$i

	echo > $testdir/$i

might be faster.

> +done
> +
> +# make sure these files get to the journal
> +sync --file-system $testdir/1
> +
> +# call ioctl to checkpoint and zero-fill journal blocks
> +$checkpoint_journal $SCRATCH_MNT --erase=zeroout || _fail "ioctl returned error"
> +
> +extents=$(get_journal_extents)
> +
> +# check journal blocks zeroed out
> +ret=$(check_extents "$extents")
> +[ "$ret" = "error" ] && _fail "Journal was not zero-filled"
> +
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +echo "Done."

fstests use "Silence is golden" :)

Thanks,
Eryu

> +
> +status=0
> +exit
> diff --git a/tests/ext4/310.out b/tests/ext4/310.out
> new file mode 100644
> index 00000000..e52f7345
> --- /dev/null
> +++ b/tests/ext4/310.out
> @@ -0,0 +1,2 @@
> +QA output created by 310
> +Done.
> diff --git a/tests/ext4/group b/tests/ext4/group
> index e7ad3c24..622590a9 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -60,3 +60,4 @@
>  307 auto ioctl rw defrag
>  308 auto ioctl rw prealloc quick defrag
>  309 auto quick dir
> +310 auto ioctl quick
> -- 
> 2.31.1.751.gd2f1c929bd-goog
