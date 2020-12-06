Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE62F2D056C
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Dec 2020 15:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgLFOPO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Dec 2020 09:15:14 -0500
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:53636 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgLFOPN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Dec 2020 09:15:13 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436564|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0634548-0.000502155-0.936043;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.J3f3sBI_1607264064;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.J3f3sBI_1607264064)
          by smtp.aliyun-inc.com(10.147.41.178);
          Sun, 06 Dec 2020 22:14:24 +0800
Date:   Sun, 6 Dec 2020 22:14:23 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        anju@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] generic: Add test to check for mounting a huge
 sparse dm device
Message-ID: <20201206141423.GX3853@desktop>
References: <cover.1607078368.git.riteshh@linux.ibm.com>
 <cc6f28972d73a50fb84a3797172ff44d396a6bef.1607078368.git.riteshh@linux.ibm.com>
 <20201206135043.GV3853@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206135043.GV3853@desktop>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Dec 06, 2020 at 09:50:43PM +0800, Eryu Guan wrote:
> On Fri, Dec 04, 2020 at 04:13:54PM +0530, Ritesh Harjani wrote:
> > Add this test to check for regression which was reported when ext4 bmap
> > aops was moved to use iomap APIs. jbd2 calls bmap() kernel function
> > from fs/inode.c which was failing since iomap_bmap() implementation earlier
> > returned 0 for block addr > INT_MAX.
> > This regression was fixed with following kernel commit [1]
> > commit b75dfde1212991b24b220c3995101c60a7b8ae74
> > ("fibmap: Warn and return an error in case of block > INT_MAX")
> > [1]: https://patchwork.ozlabs.org/patch/1279914
> > 
> > w/o the kernel fix we get below errors and mount fails
> > 
> > [ 1461.988701] run fstests generic/613 at 2020-10-27 19:57:34
> > [ 1530.406645] ------------[ cut here ]------------
> > [ 1530.407332] would truncate bmap result
> > [ 1530.408956] WARNING: CPU: 0 PID: 6401 at fs/iomap/fiemap.c:116
> > iomap_bmap_actor+0x43/0x50
> > [ 1530.410607] Modules linked in:
> > [ 1530.411024] CPU: 0 PID: 6401 Comm: mount Tainted: G        W
> > <...>
> >  1530.511978] jbd2_journal_init_inode: Cannot locate journal superblock
> >  [ 1530.513310] EXT4-fs (dm-1): Could not load journal inode
> > 
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  common/rc             | 10 +++++++
> >  tests/generic/618     | 70 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/618.out |  3 ++
> >  tests/generic/group   |  1 +
> >  4 files changed, 84 insertions(+)
> >  create mode 100755 tests/generic/618
> >  create mode 100644 tests/generic/618.out
> > 
> > diff --git a/common/rc b/common/rc
> > index b5a504e0dcb4..128d75226958 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1608,6 +1608,16 @@ _require_scratch_size()
> >  	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
> >  }
> >  
> > +# require a scratch dev of a minimum size (in kb) and should not be checked
> > +# post test
> > +_require_scratch_size_nocheck()
> > +{
> > +	[ $# -eq 1 ] || _fail "_require_scratch_size: expected size param"
> > +
> > +	_require_scratch_nocheck
> > +	local devsize=`_get_device_size $SCRATCH_DEV`
> > +	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
> > +}
> >  
> >  # this test needs a test partition - check we're ok & mount it
> >  #
> > diff --git a/tests/generic/618 b/tests/generic/618
> > new file mode 100755
> > index 000000000000..45c14da80c06
> > --- /dev/null
> > +++ b/tests/generic/618
> > @@ -0,0 +1,70 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2020 Christian Kujau. All Rights Reserved.
> > +# Copyright (c) 2020 Ritesh Harjani. All Rights Reserved.
> > +#
> > +# FS QA Test generic/618
> > +#
> > +# Since the test is not specific to ext4, hence adding it to generic.
> > +# Add this test to check for regression which was reported when ext4 bmap
> > +# aops was moved to use iomap APIs. jbd2 calls bmap() kernel function
> > +# from fs/inode.c which was failing since iomap_bmap() implementation earlier
> > +# returned 0 for block addr > INT_MAX.
> > +# This regression was fixed with following kernel commit [1]
> > +# commit b75dfde1212991b24b220c3995101c60a7b8ae74
> > +# ("fibmap: Warn and return an error in case of block > INT_MAX")
> > +# [1]: https://patchwork.ozlabs.org/patch/1279914
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	_dmhugedisk_cleanup
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/dmhugedisk
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_require_dmhugedisk
> > +_require_scratch_size_nocheck $((4 * 1024 * 1024)) #kB
> > +
> > +# For 1k bs with ext4, mkfs was failing due to size limitation and also it
> > +# becomes too slow when doing an mkfs on a huge sparse ext4 FS with 1k bs.
> > +# Hence on ext4 run only for 4K bs.
> > +if [ "$FSTYP" == "ext4" ]; then
> > +	_scratch_mkfs > /dev/null 2>&1
> > +	blksz=$(sudo debugfs -R stats $SCRATCH_DEV 2> /dev/null |grep "Block size" |cut -d ':' -f 2)
> > +	test $blksz -lt 4096 && _notrun "This test requires ext4 with minimum 4k bs"
> > +fi
> 
> As this is a generic test, the same check should be done with ext2 and
> ext3. And actually this test requires > 16T fs support. So I'd suggest
> add a new helper, maybe called _require_16T_support, to check if $FSTYP
> supports filesystem size > 16T. And for now, we could only check for
> extN.
> 
> Also, there's no need to run command with sudo in fstests, as all tests
> are required to be run by root.
> 
> And there's a helper to get fs block size called _get_block_size, no
> need to parse output of debugfs.

Maybe something like (not tested)

_require_scratch_16T_support()
{
	case $FSTYP in
	ext2|ext3)
		_notrun "$FSTYP doesn't support >16T filesystem"
	ext4)
		_scratch_mkfs >> $seqres.full 2>&1
		_scratch_mount
		local blocksize=$(_get_block_size $SCRATCH_MNT)
		if [ $blocksize -lt 4096 ]; then
			_notrun "This test requires >16T fs support"
		fi
		;;
	*)
		;;
	esac
}

Thanks,
Eryu
