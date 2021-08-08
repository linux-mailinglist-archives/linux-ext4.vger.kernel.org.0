Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E63E3AB4
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Aug 2021 15:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhHHN5q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Aug 2021 09:57:46 -0400
Received: from out20-38.mail.aliyun.com ([115.124.20.38]:60582 "EHLO
        out20-38.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHHN5p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Aug 2021 09:57:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07477473|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0205998-0.00153276-0.977867;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Kx1a3wy_1628431044;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Kx1a3wy_1628431044)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sun, 08 Aug 2021 21:57:25 +0800
Date:   Sun, 8 Aug 2021 21:57:24 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, artem.blagodarenko@gmail.com,
        denis@voxelsoft.com,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: add test to validate the large_dir feature
Message-ID: <YQ/ixFR3Q4ucAFP3@desktop>
References: <20210805144016.3556979-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805144016.3556979-1-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 05, 2021 at 10:40:16AM -0400, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

I think it'd be better to explain large_dir feature a bit, and describe
the test, how it's supposed to test this feature.

> ---
>  src/dirstress.c    |  7 +++++-
>  tests/ext4/051     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/051.out |  2 ++
>  3 files changed, 70 insertions(+), 1 deletion(-)
>  create mode 100755 tests/ext4/051
>  create mode 100644 tests/ext4/051.out
> 
> diff --git a/src/dirstress.c b/src/dirstress.c
> index 615cb6e3..ec28d643 100644
> --- a/src/dirstress.c
> +++ b/src/dirstress.c
> @@ -16,6 +16,7 @@ int verbose;
>  int pid;
>  
>  int checkflag=0;
> +int create_only=0;
>  
>  #define MKNOD_DEV 0
>  
> @@ -51,7 +52,7 @@ main(
>  	nprocs_per_dir = 1;
>  	keep = 0;
>          verbose = 0;
> -	while ((c = getopt(argc, argv, "d:p:f:s:n:kvc")) != EOF) {
> +	while ((c = getopt(argc, argv, "d:p:f:s:n:kvcC")) != EOF) {
>  		switch(c) {
>  			case 'p':
>  				nprocs = atoi(optarg);
> @@ -80,6 +81,9 @@ main(
>  			case 'c':
>                                  checkflag++;
>                                  break;
> +			case 'C':
> +				create_only++;
> +				break;
>  		}
>  	}
>  	if (errflg || (dirname == NULL)) {
> @@ -170,6 +174,7 @@ dirstress(
>  	if (create_entries(nfiles)) {
>              printf("!! [%d] create failed\n", pid);
>          } else {
> +	    if (create_only) return 0;
>              if (verbose) fprintf(stderr,"** [%d] scramble entries\n", pid);
>  	    if (scramble_entries(nfiles)) {
>                  printf("!! [%d] scramble failed\n", pid);
> diff --git a/tests/ext4/051 b/tests/ext4/051
> new file mode 100755
> index 00000000..387e2518
> --- /dev/null
> +++ b/tests/ext4/051
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test 051
> +#
> +# Test ext4's large_dir feature
> +#
> +. ./common/preamble
> +_begin_fstest auto quick dir
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	if [ ! -z "$loop_mnt" ]; then
> +		$UMOUNT_PROG $loop_mnt
> +		rm -rf $loop_mnt
> +	fi
> +	[ ! -z "$fs_img" ] && rm -rf $fs_img
> +}
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs ext4
> +_require_test
> +_require_loop
> +_require_scratch_ext4_feature "large_dir"
> +
> +echo "Silence is golden"
> +
> +loop_mnt=$TEST_DIR/$seq.mnt
> +fs_img=$TEST_DIR/$seq.img
> +status=0
> +
> +cp /dev/null $fs_img

Just a nit, we usually do

$XFS_IO_PROG -f -c "truncate 40G" $fs_img >>$seqres.full 2>&1

> +${MKFS_PROG} -t ${FSTYP} -b 1024 -N 600020 -O large_dir,^has_journal \
> +	     $fs_img 40G >> $seqres.full 2>&1 || _fail "mkfs failed"

Better to describe the mkfs options used here, e.g. why using 1k
blocksize, 600020 inodes, and without journal.

> +
> +mkdir -p $loop_mnt
> +_mount -o loop $fs_img $loop_mnt > /dev/null  2>&1 || \
> +	_fail "Couldn't do initial mount"
> +
> +/root/xfstests/src/dirstress -c -d /tmpmnt -p 1 -f 400000 -C \
> +	>> $seqres.full 2>&1

Use $here/src/dirstress as below. And /tmpmnt is not used elsewhere. Is
this a debug line that should be removed?

> +
> +if ! $here/src/dirstress -c -d $loop_mnt -p 1 -f 400000 -C >$tmp.out 2>&1
> +then
> +    echo "    dirstress failed"
> +    cat $tmp.out >> $seqres.full
> +    echo "    dirstress failed" >> $seqres.full
> +    status=1
> +fi
> +
> +$UMOUNT_PROG $loop_mnt || _fail "umount failed"
> +loop_mnt=
> +
> +$E2FSCK_PROG -fn $fs_img >> $seqres.full 2>&1 || _fail "file system corrupted"

Better to have an explicit "exit" at the end of test, like all other
tests do.

Thanks,
Eryu

> diff --git a/tests/ext4/051.out b/tests/ext4/051.out
> new file mode 100644
> index 00000000..32f74d89
> --- /dev/null
> +++ b/tests/ext4/051.out
> @@ -0,0 +1,2 @@
> +QA output created by 051
> +Silence is golden
> -- 
> 2.31.0
