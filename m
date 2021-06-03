Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C166539978F
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jun 2021 03:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFCBgW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Jun 2021 21:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhFCBgV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 2 Jun 2021 21:36:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA40A6100A;
        Thu,  3 Jun 2021 01:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622684077;
        bh=acyAtkOhTgoC8MgipkYpnDZwNJLYFT5L3Y3Y9QzoA8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnV3Gjj0H5/XpR7Y16JjHlZumVz7DB69sjWj4dPBFoN0sGZ7g0ycLSq5T7m+YZ21G
         D3EumuwWQDazCokbo9kkQZQv5wDbYCpdPqQBen5D+ri+uWUpyH83OunjwESGI00Moa
         b8cC5BoWa7SlBJR9ueSLsakqvOKProBP04JlveErROuIIe7tYgnmL/Ml+CNRDNICHa
         vqnL9rh6r0WOVVw6sa5S/SpuVgt0SVCj8BC+r1paFMznnpkeXisz8fdNnpkn1Y7/Dv
         O/3uOAmXjxhJ5AAHn/ijCMY8TMkfcjrneOdW1m6KDdfqzjzYuRKJLDC9+14Gl5Muvl
         2fybXU8wuS3EA==
Date:   Wed, 2 Jun 2021 18:34:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [v2] ext4/310: test journal checkpoint ioctl
Message-ID: <20210603013437.GA26324@locust>
References: <20210602221704.2312894-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602221704.2312894-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Nit: the subject line still needs "PATCH", e.g.

[PATCH v2] ext4/310: test journal checkpoint ioctl

On Wed, Jun 02, 2021 at 10:17:04PM +0000, Leah Rumancik wrote:
> Test for commit "ext4: add ioctl EXT4_IOC_CHECKPOINT". Tests journal
> checkpointing and journal erasing via EXT4_IOC_CHECKPOINT with flag
> EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT set.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  .gitignore               |   1 +
>  src/Makefile             |   3 +-
>  src/checkpoint_journal.c |  95 ++++++++++++++++++++++++++++++++
>  tests/ext4/310           | 115 +++++++++++++++++++++++++++++++++++++++
>  tests/ext4/310.out       |   2 +
>  tests/ext4/group         |   1 +
>  6 files changed, 216 insertions(+), 1 deletion(-)
>  create mode 100644 src/checkpoint_journal.c
>  create mode 100755 tests/ext4/310
>  create mode 100644 tests/ext4/310.out
> 
> diff --git a/.gitignore b/.gitignore
> index 4cc9c807..cb7e17bf 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -182,6 +182,7 @@
>  /src/idmapped-mounts/mount-idmapped
>  /src/log-writes/replay-log
>  /src/perf/*.pyc
> +/src/checkpoint_journal
>  
>  # Symlinked files
>  /tests/generic/035.out
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

New file needs a SPDX header.

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

fstests doesn't support anything other than Linux.

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
> new file mode 100755
> index 00000000..dd30c782
> --- /dev/null
> +++ b/tests/ext4/310
> @@ -0,0 +1,115 @@
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

I don't really like seeing long lines of pipe commands chained together
since it sort of suggests that it's time for a helper function.  Ah
well, that's just my style preference. :P

The logic of the shell script part looks reasonable to me though.

--D

> +
> +		[ ! -z "$check" ] && echo "error" && break
> +	done
> +}
> +
> +testdir="${SCRATCH_MNT}/testdir"
> +
> +_scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_scratch_mount >> $seqres.full 2>&1
> +blocksize=$(_get_block_size $SCRATCH_MNT)
> +mkdir $testdir
> +
> +# check if ioctl present, skip test if not present
> +$checkpoint_journal $SCRATCH_MNT --dry-run || _notrun "journal checkpoint ioctl not present on device"
> +
> +# create some files to add some entries to journal
> +for i in {1..100}; do
> +	echo > $testdir/$i
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
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/ext4/310.out b/tests/ext4/310.out
> new file mode 100644
> index 00000000..7b9eaf78
> --- /dev/null
> +++ b/tests/ext4/310.out
> @@ -0,0 +1,2 @@
> +QA output created by 310
> +Silence is golden
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
> 2.32.0.rc1.229.g3e70b5a671-goog
> 
