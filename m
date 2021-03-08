Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203AC331639
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Mar 2021 19:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCHSg2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Mar 2021 13:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230125AbhCHSgL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 8 Mar 2021 13:36:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFA606518A;
        Mon,  8 Mar 2021 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615228570;
        bh=Hv4YcZM0nn7U1j39JmRNZJV97rBy3ZTH91LINOoGeac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fq377U7ArxzX2uhn7DRlAsaxuNPrhYLxAHo+hJ7F0bioUTajVpECNEbA6LJOQxmPl
         DyxdSpyv/E+5YtXtRnnnp/ynGZ/Is5blglCMSLb4MC/WF3TSO8Q+uGYl9JFm/v1DyF
         S2W2G07n+Jm+LZ12jerKL9rSGd40amE7stNQSqkC01STFZKb+AbJ5clMmnU1GOukgJ
         /jCAE4z90VJYB/ocSEhl/o4OdYThxkuRYPc6HrwuDZmXEfNcr0Uo85Ccu6hZpBYK1+
         Ub866LIJYyGWQDvauevuzmBOKyagywJeCQ9Eu2iblX18o1pk/WUKOqa4zDGLaNy9tJ
         hC5q+WBTRBHTg==
Date:   Mon, 8 Mar 2021 10:36:10 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, guan@eryu.me, sunke32@huawei.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] xfstests: rename RENAME_WHITEOUT test on fs no enough
 sapce
Message-ID: <20210308183610.GX3419940@magnolia>
References: <20210308134327.345579-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308134327.345579-1-zlang@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 08, 2021 at 09:43:27PM +0800, Zorro Lang wrote:
> This's a regression test for linux 6b4b8e6b4ad8 ("ext4: fix bug for
> rename with RENAME_WHITEOUT"). Rename a file with RENAME_WHITEOUT
> flag might cause corruption when there's not enough space to
> complete this renaming operation.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Seems reasonable to me; does it pass on xfs?

If so,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> 
> Hi,
> 
> Thanks for the reviewing from Eryu. V2 did below changes:
> 1) Import ./common/renameat2 and _require_renameat2 whiteout
> 2) Replace CHUNKS with NR_FILE
> 3) Reduce the number of test files from 64*64 to 4*64
> 4) Add to quick group 
> 
> More details about the reviewing history, refer to:
> https://patchwork.kernel.org/project/fstests/patch/20210218071324.50413-1-zlang@redhat.com/
> 
> Thanks,
> Zorro
> 
>  tests/generic/626     | 74 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/626.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 77 insertions(+)
>  create mode 100755 tests/generic/626
>  create mode 100644 tests/generic/626.out
> 
> diff --git a/tests/generic/626 b/tests/generic/626
> new file mode 100755
> index 00000000..1baa73f8
> --- /dev/null
> +++ b/tests/generic/626
> @@ -0,0 +1,74 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 HUAWEI.  All Rights Reserved.
> +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 626
> +#
> +# Test RENAME_WHITEOUT on filesystem without space to create one more inodes.
> +# This is a regression test for kernel commit:
> +#   6b4b8e6b4ad8 ("ext4: ext4: fix bug for rename with RENAME_WHITEOUT")
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
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/populate
> +. ./common/renameat2
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch
> +_require_renameat2 whiteout
> +
> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Create lots of files, to help to trigger the bug easily
> +NR_FILE=$((4 * 64))
> +for ((i=0; i<NR_FILE; i++));do
> +	touch $SCRATCH_MNT/srcfile$i
> +done
> +# Try to fill the whole fs
> +nr_free=$(stat -f -c '%f' $SCRATCH_MNT)
> +blksz="$(_get_block_size $SCRATCH_MNT)"
> +_fill_fs $((nr_free * blksz)) $SCRATCH_MNT/fill_space $blksz 0 >> $seqres.full 2>&1
> +# Use empty files to fill the rest
> +for ((i=0; i<10000; i++));do
> +	touch $SCRATCH_MNT/fill_file$i 2>/dev/null
> +	# Until no more files can be created
> +	if [ $? -ne 0 ];then
> +		break
> +	fi
> +done
> +# ENOSPC is expected here
> +for ((i=0; i<NR_FILE; i++));do
> +	$here/src/renameat2 -w $SCRATCH_MNT/srcfile$i $SCRATCH_MNT/dstfile$i >> $seqres.full 2>&1
> +done
> +_scratch_cycle_mount
> +# Expect no errors at here
> +for ((i=0; i<NR_FILE; i++));do
> +	ls -l $SCRATCH_MNT/srcfile$i >/dev/null
> +done
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/626.out b/tests/generic/626.out
> new file mode 100644
> index 00000000..130b2fef
> --- /dev/null
> +++ b/tests/generic/626.out
> @@ -0,0 +1,2 @@
> +QA output created by 626
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 84db3789..c3448fe3 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -628,3 +628,4 @@
>  623 auto quick shutdown
>  624 auto quick verity
>  625 auto quick verity
> +626 auto quick rename enospc
> -- 
> 2.29.2
> 
