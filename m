Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981E73302B2
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Mar 2021 16:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhCGPbH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Mar 2021 10:31:07 -0500
Received: from out20-98.mail.aliyun.com ([115.124.20.98]:56189 "EHLO
        out20-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhCGPa4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Mar 2021 10:30:56 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0743673|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.260236-0.00399315-0.735771;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.JhdEwGg_1615131049;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JhdEwGg_1615131049)
          by smtp.aliyun-inc.com(10.147.41.143);
          Sun, 07 Mar 2021 23:30:50 +0800
Date:   Sun, 7 Mar 2021 23:30:49 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, sunke32@huawei.com
Subject: Re: [PATCH] xfstests: rename RENAME_WHITEOUT test on fs no enough
 sapce
Message-ID: <YETxqYdhNQwT+aZE@desktop>
References: <20210218071324.50413-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218071324.50413-1-zlang@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 18, 2021 at 03:13:24PM +0800, Zorro Lang wrote:
> This's a regression test for linux 6b4b8e6b4ad8 ("ext4: fix bug for
> rename with RENAME_WHITEOUT"). Rename a file with RENAME_WHITEOUT
> flag might cause corruption when there's not enough space to
> complete this renaming operation.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
> 
> Hi,
> 
> As the request of Sun Ke, I rewrite his test case as this patch.
> The history of reviewing as below:
> https://patchwork.kernel.org/project/fstests/patch/20210128061202.210074-1-sunke32@huawei.com/
> https://patchwork.kernel.org/project/fstests/patch/20210202123956.3146761-1-sunke32@huawei.com/
> 
> At last, I decide to create several chunks of files to do this testing, help to
> get more chance to trigger ENOSPC when does rename(RENAME_WHITEOUT).
> 
> From my testing, it can reproduce this bug on linux 5.10[1], and test passed on
> linux 5.11-rc5+ [2]. And it works on XFS too. Hope to get more review from fs-devel.

Thanks a lot for the revision!

> 
> [1]
> # ./check generic/623
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 ibm-xxxxxxx-xx 5.10.0-rc5+ #4 SMP Tue Jan 5 20:12:45 CST 2021
> MKFS_OPTIONS  -- /dev/mapper/testvg-scratchdev
> MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev /mnt/scratch
> 
> generic/623     _check_generic_filesystem: filesystem on /dev/mapper/testvg-scratchdev is inconsistent                                                                                        
> (see /root/git/xfstests-zlang/results//generic/623.full for details)
> - output mismatch (see /root/git/xfstests-zlang/results//generic/623.out.bad)
>     --- tests/generic/623.out   2021-02-18 13:26:35.953071523 +0800
>     +++ /root/git/xfstests-zlang/results//generic/623.out.bad   2021-02-18 13:28:10.450733088 +0800                                                                                           
>     @@ -1,2 +1,232 @@
>      QA output created by 623
>     +ls: cannot access '/mnt/scratch/srcfile3866': Structure needs cleaning
>     +ls: cannot access '/mnt/scratch/srcfile3867': Structure needs cleaning
>     +ls: cannot access '/mnt/scratch/srcfile3868': Structure needs cleaning
>     +ls: cannot access '/mnt/scratch/srcfile3869': Structure needs cleaning
>     +ls: cannot access '/mnt/scratch/srcfile3870': Structure needs cleaning
>     +ls: cannot access '/mnt/scratch/srcfile3871': Structure needs cleaning
>     ...
>     (Run 'diff -u /root/git/xfstests-zlang/tests/generic/623.out /root/git/xfstests-zlang/results//generic/623.out.bad'  to see the entire diff)                                              
> Ran: generic/623
> Failures: generic/623
> Failed 1 of 1 tests
> 
> [2]
> # ./check generic/623
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 localhost 5.11.0-0.rc5.20210128git76c057c84d28.137.fc34.x86_64 #1 SMP Thu Jan 28 21:10:47 UTC 2021
> MKFS_OPTIONS  -- /dev/mapper/testvg-scratchdev
> MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev /mnt/scratch
> 
> generic/623 4s ...  86s
> Ran: generic/623
> Passed all 1 tests
> 
> [3]
> # ./check generic/623
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 localhost 5.11.0-0.rc5.20210128git76c057c84d28.137.fc34.x86_64 #1 SMP Thu Jan 28 21:10:47 UTC 2021
> MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/testvg-scratchdev
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev /mnt/scratch
> 
> generic/623 86s ...  99s
> Ran: generic/623
> Passed all 1 tests
> 
> Thanks,
> Zorro
> 
>  tests/generic/623     | 72 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/623.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 75 insertions(+)
>  create mode 100755 tests/generic/623
>  create mode 100644 tests/generic/623.out
> 
> diff --git a/tests/generic/623 b/tests/generic/623
> new file mode 100755
> index 00000000..56358ca6
> --- /dev/null
> +++ b/tests/generic/623
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 HUAWEI.  All Rights Reserved.
> +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test 623
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

. ./common/renameat2

then ...

> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch

Need "_require_renameat2 whiteout" here.

> +
> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Create several chunks of file, to help to trigger the bug easily
> +CHUNKS=$((64 * 64))

Rename CHUNKS to NR_FILE? I tried 128 and could trigger the failure
quickly as well, and test passwd within 5 seconds on v5.11 kernel. So I
think 128 files should be fine? It's not required to be 100%
reproducible, as long as the possiblity is high enough.

> +for ((i=0; i<CHUNKS; i++));do
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
> +for ((i=0; i<CHUNKS; i++));do
> +	$here/src/renameat2 -w $SCRATCH_MNT/srcfile$i $SCRATCH_MNT/dstfile$i >> $seqres.full 2>&1
> +done
> +_scratch_cycle_mount
> +# Expect no errors at here
> +for ((i=0; i<CHUNKS; i++));do
> +	ls -l $SCRATCH_MNT/srcfile$i >/dev/null
> +done
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/623.out b/tests/generic/623.out
> new file mode 100644
> index 00000000..6f774f19
> --- /dev/null
> +++ b/tests/generic/623.out
> @@ -0,0 +1,2 @@
> +QA output created by 623
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index b10fdea4..72136075 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -625,3 +625,4 @@
>  620 auto mount quick
>  621 auto quick encrypt
>  622 auto shutdown metadata atime
> +623 auto rename enospc

If we reduce the iterations, and test would pass quickly, we could add
'quick' group too.

Thanks,
Eryu

> -- 
> 2.29.2
