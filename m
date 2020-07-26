Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496AB22DFCB
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jul 2020 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgGZPCR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Jul 2020 11:02:17 -0400
Received: from out20-27.mail.aliyun.com ([115.124.20.27]:47957 "EHLO
        out20-27.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGZPCR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Jul 2020 11:02:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436284|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.395271-0.000302238-0.604427;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.I7peU4V_1595775728;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.I7peU4V_1595775728)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sun, 26 Jul 2020 23:02:08 +0800
Date:   Sun, 26 Jul 2020 23:02:08 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4/309: Test read-only external journal device
Message-ID: <20200726150208.GI2557159@desktop>
References: <20200717105544.3201-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717105544.3201-1-lczerner@redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[cc ext4 list for ext4 specific test]

On Fri, Jul 17, 2020 at 12:55:44PM +0200, Lukas Czerner wrote:
> We should never be able to mount ext4 file system read-write with
> read-only external journal device. Test it.
> 
> The test was based on generic/050.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Is there a patch or kernel commit that fixes this test failure? I'd be
better to mention the patch in either commit log or test description, so
others could know where is the fix easily.

> ---
>  tests/ext4/309     | 135 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/309.out |  32 +++++++++++

And use next available seq slot under ext4 dir, use
"./tools/nextid ext4" to get the next available slot, which is 002 at
this point.

>  tests/ext4/group   |   1 +
>  3 files changed, 168 insertions(+)
>  create mode 100755 tests/ext4/309
>  create mode 100644 tests/ext4/309.out
> 
> diff --git a/tests/ext4/309 b/tests/ext4/309
> new file mode 100755
> index 00000000..356044c4
> --- /dev/null
> +++ b/tests/ext4/309
> @@ -0,0 +1,135 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2009 Christoph Hellwig.
> +# Copyright (c) 2020 Lukas Czerner.
> +#
> +# FS QA Test No. 309
> +#
> +# Copied from tests generic/050 and adjusted to support testing
> +# read-only external journal device on ext4.
> +#
> +# Check out various mount/remount/unmount scenarious on a read-only
> +# logdev blockdev.
> +#
> +seqfull=$0
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +
> +_cleanup()
> +{
> +	cd /
> +	blockdev --setrw $SCRATCH_LOGDEV

Do 'blockdev --setrw $SCRATCH_DEV' here as well to make sure both LOGDEV
and SCRATCH_DEV are set back to rw mode.

> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs generic

_supported_fs ext4

Otherwise looks fine to me.

Thanks,
Eryu

> +_supported_os Linux
> +
> +_require_scratch_nocheck
> +_require_scratch_shutdown
> +_require_logdev
> +_require_local_device $SCRATCH_DEV
> +_require_local_device $SCRATCH_LOGDEV
> +_require_norecovery
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +
> +#
> +# Mark the log device read-only
> +#
> +echo "setting log device read-only"
> +blockdev --setro $SCRATCH_LOGDEV
> +
> +#
> +# Mount it, and make sure we can't write to it, and we can unmount it again
> +#
> +echo "mounting with read-only log device:"
> +_try_scratch_mount 2>&1 | _filter_ro_mount | _filter_scratch
> +if [ "${PIPESTATUS[0]}" -eq 0 ]; then
> +	echo "touching file on read-only filesystem (should fail)"
> +	touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
> +fi
> +
> +echo "unmounting read-only filesystem"
> +_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
> +
> +echo "setting log device read-write"
> +blockdev --setrw $SCRATCH_LOGDEV
> +
> +echo "mounting with read-write log device:"
> +_try_scratch_mount 2>&1 | _filter_scratch
> +
> +echo "touch files"
> +touch $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
> +
> +echo "going down:"
> +_scratch_shutdown -f
> +
> +echo "unmounting shutdown filesystem:"
> +_scratch_unmount 2>&1 | _filter_scratch
> +
> +echo "setting log device read-only"
> +blockdev --setro $SCRATCH_LOGDEV
> +
> +#
> +# Mounting a filesystem that requires log-recovery fails even with
> +# -o norecovery unless the fs device is read only or it's mounted
> +# read only
> +#
> +echo "mounting filesystem that needs recovery with a read-only log device:"
> +_try_scratch_mount 2>&1 | _filter_ro_mount | _filter_scratch
> +
> +echo "unmounting read-only filesystem"
> +_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
> +
> +
> +echo "mounting filesystem with -o norecovery with a read-only log device:"
> +_try_scratch_mount -o norecovery 2>&1 | _filter_ro_mount | _filter_scratch
> +echo "unmounting read-only filesystem"
> +_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
> +
> +#
> +# This is the way out if the log device really is read-only.
> +# Doesn't mean it's a good idea in practice, more a last resort
> +# data recovery hack. Either the underlying fs device needs
> +# to be read only as well, or we mount the file system read only
> +#
> +echo "setting fs device read-only"
> +blockdev --setro $SCRATCH_DEV
> +echo "mounting filesystem with -o norecovery with a read-only fs and log device:"
> +_try_scratch_mount -o norecovery 2>&1 | _filter_ro_mount | _filter_scratch
> +echo "unmounting read-only filesystem"
> +_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
> +echo "setting fs device read-write"
> +blockdev --setrw $SCRATCH_DEV
> +
> +echo "mounting filesystem with -o norecovery,ro with a read-only log device:"
> +_try_scratch_mount -o norecovery,ro 2>&1 | _filter_ro_mount | _filter_scratch
> +echo "unmounting read-only filesystem"
> +_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
> +
> +echo "setting log device read-write"
> +blockdev --setrw $SCRATCH_LOGDEV
> +
> +#
> +# But log recovery is performed when mount with -o ro as long as
> +# the underlying device is not write protected.
> +#
> +echo "mounting filesystem that needs recovery with -o ro:"
> +_try_scratch_mount -o ro 2>&1 | _filter_scratch
> +
> +# success, all done
> +echo "*** done"
> +rm -f $seqres.full
> +status=0
> diff --git a/tests/ext4/309.out b/tests/ext4/309.out
> new file mode 100644
> index 00000000..4b7e136a
> --- /dev/null
> +++ b/tests/ext4/309.out
> @@ -0,0 +1,32 @@
> +QA output created by 309
> +setting log device read-only
> +mounting with read-only log device:
> +mount: device write-protected, mounting read-only
> +touching file on read-only filesystem (should fail)
> +touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system
> +unmounting read-only filesystem
> +setting log device read-write
> +mounting with read-write log device:
> +touch files
> +going down:
> +unmounting shutdown filesystem:
> +setting log device read-only
> +mounting filesystem that needs recovery with a read-only log device:
> +mount: device write-protected, mounting read-only
> +mount: cannot mount device read-only
> +unmounting read-only filesystem
> +umount: SCRATCH_DEV: not mounted
> +mounting filesystem with -o norecovery with a read-only log device:
> +mount: SCRATCH_MNT: wrong fs type, bad option, bad superblock on SCRATCH_DEV, missing codepage or helper program, or other error
> +unmounting read-only filesystem
> +umount: SCRATCH_DEV: not mounted
> +setting fs device read-only
> +mounting filesystem with -o norecovery with a read-only fs and log device:
> +mount: device write-protected, mounting read-only
> +unmounting read-only filesystem
> +setting fs device read-write
> +mounting filesystem with -o norecovery,ro with a read-only log device:
> +unmounting read-only filesystem
> +setting log device read-write
> +mounting filesystem that needs recovery with -o ro:
> +*** done
> diff --git a/tests/ext4/group b/tests/ext4/group
> index a1adc553..5e80e480 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -56,3 +56,4 @@
>  306 auto rw resize quick
>  307 auto ioctl rw defrag
>  308 auto ioctl rw prealloc quick defrag
> +309 shutdown mount auto quick
> -- 
> 2.21.3
