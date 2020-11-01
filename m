Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB92A1F7E
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Nov 2020 17:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgKAQYk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 1 Nov 2020 11:24:40 -0500
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:44653 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgKAQYj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 1 Nov 2020 11:24:39 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07438824|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0365477-0.00737177-0.95608;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.IrDrt1W_1604247868;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IrDrt1W_1604247868)
          by smtp.aliyun-inc.com(10.147.40.2);
          Mon, 02 Nov 2020 00:24:28 +0800
Date:   Mon, 2 Nov 2020 00:24:27 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, Jan Kara <jack@suse.cz>,
        anju@linux.vnet.ibm.com, Christian Kujau <lists@nerdbynature.de>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] generic: Add test to check for mounting a huge
 sparse dm device
Message-ID: <20201101162427.GF3853@desktop>
References: <daec44e9f2e3ce483b7845065db3bf148ff5cd2c.1603864280.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daec44e9f2e3ce483b7845065db3bf148ff5cd2c.1603864280.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 28, 2020 at 12:14:52PM +0530, Ritesh Harjani wrote:
> Add this test (which Christian Kujau reported) to check for regression
> caused due to ext4 bmap aops implementation was moved to use iomap APIs.
> jbd2 calls bmap() kernel function from fs/inode.c which was failing since
> iomap_bmap() implementation earlier returned 0 for block addr > INT_MAX.
> This regression was fixed with following kernel commit [1]
> commit b75dfde1212991b24b220c3995101c60a7b8ae74
> ("fibmap: Warn and return an error in case of block > INT_MAX")
> [1]: https://patchwork.ozlabs.org/patch/1279914
> 
> w/o the kernel fix we get below error and mount fails
> 
> [ 1461.988701] run fstests generic/613 at 2020-10-27 19:57:34
> [ 1530.511978] jbd2_journal_init_inode: Cannot locate journal superblock
> [ 1530.513310] EXT4-fs (dm-1): Could not load journal inode
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  common/rc             | 10 +++++++
>  tests/generic/613     | 66 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/613.out |  3 ++
>  tests/generic/group   |  1 +
>  4 files changed, 80 insertions(+)
>  create mode 100755 tests/generic/613
>  create mode 100644 tests/generic/613.out
> 
> diff --git a/common/rc b/common/rc
> index 27a27ea36f75..b0c353c4c107 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1607,6 +1607,16 @@ _require_scratch_size()
>  	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
>  }
> 
> +# require a scratch dev of a minimum size (in kb) and should not be checked
> +# post test
> +_require_scratch_size_nocheck()
> +{
> +	[ $# -eq 1 ] || _fail "_require_scratch_size: expected size param"
> +
> +	_require_scratch_nocheck
> +	local devsize=`_get_device_size $SCRATCH_DEV`
> +	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
> +}

Seems there's no need to introduce this new helper, just open-coded

# comments on why we use _nocheck here
_require_scratch_nocheck
_require_scratch_size $size

> 
>  # this test needs a test partition - check we're ok & mount it
>  #
> diff --git a/tests/generic/613 b/tests/generic/613
> new file mode 100755
> index 000000000000..b426ef91cacf
> --- /dev/null
> +++ b/tests/generic/613
> @@ -0,0 +1,66 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Christian Kujau. All Rights Reserved.
> +# Copyright (c) 2020 Ritesh Harjani. All Rights Reserved.
> +#
> +# FS QA Test generic/613
> +#
> +# Since the test is not specific to ext4, hence adding it to generic.
> +# Add this test to check for regression which was reported when ext4 bmap
> +# aops was moved to use iomap APIs. jbd2 calls bmap() kernel function
> +# from fs/inode.c which was failing since iomap_bmap() implementation earlier
> +# returned 0 for block addr > INT_MAX.
> +# This regression was fixed with following kernel commit [1]
> +# commit b75dfde1212991b24b220c3995101c60a7b8ae74
> +# ("fibmap: Warn and return an error in case of block > INT_MAX")
> +# [1]: https://patchwork.ozlabs.org/patch/1279914
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	_dmhugedisk_cleanup
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmhugedisk
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_dmhugedisk
> +_require_scratch_size_nocheck $((4 * 1024 * 1024)) #kB
> +
> +# For 1k bs with ext4, mkfs was failing maybe due to size limitation.

I think that's because only 4k blocksize ext4 supports filesystems
greater than 16T.

> +if [ "$FSTYP" = "ext4" ]; then
> +	export MKFS_OPTIONS="-F -b 4096"
> +fi

I'd check for fs block size after mkfs and _notrun if it's ext4 and
block_size < 4k. So we don't have to overwrite MKFS_OPTIONS and run the
test multiple times forcely in, for example ext4-1k config & ext4-4k
config.

Thanks,
Eryu

> +
> +# 17TB dm huge-test-zer0 device
> +# (in terms of 512 sectors)
> +sectors=$((2*1024*1024*1024*17))
> +chunk_size=128
> +
> +_dmhugedisk_init $sectors $chunk_size
> +_mkfs_dev $DMHUGEDISK_DEV
> +_mount $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for $DMHUGEDISK_DEV $SCRATCH_MNT"
> +testfile=$SCRATCH_MNT/testfile-$seq
> +
> +$XFS_IO_PROG -fc "pwrite -S 0xaa 0 1m" -c "fsync" $testfile | _filter_xfs_io
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/613.out b/tests/generic/613.out
> new file mode 100644
> index 000000000000..4747b7596499
> --- /dev/null
> +++ b/tests/generic/613.out
> @@ -0,0 +1,3 @@
> +QA output created by 613
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/generic/group b/tests/generic/group
> index 8054d874f005..360d145d2036 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -615,3 +615,4 @@
>  610 auto quick prealloc zero
>  611 auto quick attr
>  612 auto quick clone
> +613 auto mount quick
> --
> 2.26.2
