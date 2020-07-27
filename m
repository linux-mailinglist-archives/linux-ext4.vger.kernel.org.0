Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496B822E9FC
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 12:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgG0K03 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 06:26:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23399 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgG0K03 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 06:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595845587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4gWe24K7aJEBTvIByh/otMI6zRG22KpEwSyMgtS/QY=;
        b=aVlCzETgNFhxgyoDNhZmy4seP80T8N75bcwQr5K+nNekokV+nLTxn4/yE9H37QHJmUsIFH
        gdim7cPG1I8qVp4TxJ7gIvtJ0+lnyNKFRC631liYCM3XjMKOnS0sviMErmFTwD5GCCG65B
        l/dlMi/FjoDE2aBJIKnu7laG7MzhKWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-xsjwXtuiO4SLQoEnK9dj5A-1; Mon, 27 Jul 2020 06:26:23 -0400
X-MC-Unique: xsjwXtuiO4SLQoEnK9dj5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F34D91005504;
        Mon, 27 Jul 2020 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07E3B10013C0;
        Mon, 27 Jul 2020 10:26:20 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, linux-ext4@vger.kernel.org
Subject: [PATCH v2] ext4/002: Test read-only external journal device
Date:   Mon, 27 Jul 2020 12:26:18 +0200
Message-Id: <20200727102618.11695-1-lczerner@redhat.com>
In-Reply-To: <20200717105544.3201-1-lczerner@redhat.com>
References: <20200717105544.3201-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We should never be able to mount ext4 file system read-write with
read-only external journal device. Test it.

This problem has been addressed with proposed kernel patch
https://lore.kernel.org/linux-ext4/20200717090605.2612-1-lczerner@redhat.com/

The test was based on generic/050.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
v2: include link to the kernel patch, cahnge test number,
    ext4 and ext3 are only supported fs, setrw SCRATCH_DEV on exit

 tests/ext4/002     | 139 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/002.out |  32 +++++++++++
 tests/ext4/group   |   1 +
 3 files changed, 172 insertions(+)
 create mode 100755 tests/ext4/002
 create mode 100644 tests/ext4/002.out

diff --git a/tests/ext4/002 b/tests/ext4/002
new file mode 100755
index 00000000..00e6dff1
--- /dev/null
+++ b/tests/ext4/002
@@ -0,0 +1,139 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2009 Christoph Hellwig.
+# Copyright (c) 2020 Lukas Czerner.
+#
+# FS QA Test No. 002
+#
+# Copied from tests generic/050 and adjusted to support testing
+# read-only external journal device on ext4.
+#
+# Check out various mount/remount/unmount scenarious on a read-only
+# logdev blockdev.
+#
+# This problem has been addressed with proposed kernel patch
+# https://lore.kernel.org/linux-ext4/20200717090605.2612-1-lczerner@redhat.com/
+#
+seqfull=$0
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+
+_cleanup()
+{
+	cd /
+	blockdev --setrw $SCRATCH_LOGDEV
+	blockdev --setrw $SCRATCH_DEV
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs ext4 ext3
+_supported_os Linux
+
+_require_scratch_nocheck
+_require_scratch_shutdown
+_require_logdev
+_require_local_device $SCRATCH_DEV
+_require_local_device $SCRATCH_LOGDEV
+_require_norecovery
+
+_scratch_mkfs >/dev/null 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+
+#
+# Mark the log device read-only
+#
+echo "setting log device read-only"
+blockdev --setro $SCRATCH_LOGDEV
+
+#
+# Mount it, and make sure we can't write to it, and we can unmount it again
+#
+echo "mounting with read-only log device:"
+_try_scratch_mount 2>&1 | _filter_ro_mount | _filter_scratch
+if [ "${PIPESTATUS[0]}" -eq 0 ]; then
+	echo "touching file on read-only filesystem (should fail)"
+	touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
+fi
+
+echo "unmounting read-only filesystem"
+_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
+
+echo "setting log device read-write"
+blockdev --setrw $SCRATCH_LOGDEV
+
+echo "mounting with read-write log device:"
+_try_scratch_mount 2>&1 | _filter_scratch
+
+echo "touch files"
+touch $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
+
+echo "going down:"
+_scratch_shutdown -f
+
+echo "unmounting shutdown filesystem:"
+_scratch_unmount 2>&1 | _filter_scratch
+
+echo "setting log device read-only"
+blockdev --setro $SCRATCH_LOGDEV
+
+#
+# Mounting a filesystem that requires log-recovery fails even with
+# -o norecovery unless the fs device is read only or it's mounted
+# read only
+#
+echo "mounting filesystem that needs recovery with a read-only log device:"
+_try_scratch_mount 2>&1 | _filter_ro_mount | _filter_scratch
+
+echo "unmounting read-only filesystem"
+_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
+
+
+echo "mounting filesystem with -o norecovery with a read-only log device:"
+_try_scratch_mount -o norecovery 2>&1 | _filter_ro_mount | _filter_scratch
+echo "unmounting read-only filesystem"
+_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
+
+#
+# This is the way out if the log device really is read-only.
+# Doesn't mean it's a good idea in practice, more a last resort
+# data recovery hack. Either the underlying fs device needs
+# to be read only as well, or we mount the file system read only
+#
+echo "setting fs device read-only"
+blockdev --setro $SCRATCH_DEV
+echo "mounting filesystem with -o norecovery with a read-only fs and log device:"
+_try_scratch_mount -o norecovery 2>&1 | _filter_ro_mount | _filter_scratch
+echo "unmounting read-only filesystem"
+_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
+echo "setting fs device read-write"
+blockdev --setrw $SCRATCH_DEV
+
+echo "mounting filesystem with -o norecovery,ro with a read-only log device:"
+_try_scratch_mount -o norecovery,ro 2>&1 | _filter_ro_mount | _filter_scratch
+echo "unmounting read-only filesystem"
+_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
+
+echo "setting log device read-write"
+blockdev --setrw $SCRATCH_LOGDEV
+
+#
+# But log recovery is performed when mount with -o ro as long as
+# the underlying device is not write protected.
+#
+echo "mounting filesystem that needs recovery with -o ro:"
+_try_scratch_mount -o ro 2>&1 | _filter_scratch
+
+# success, all done
+echo "*** done"
+rm -f $seqres.full
+status=0
diff --git a/tests/ext4/002.out b/tests/ext4/002.out
new file mode 100644
index 00000000..579bc7e0
--- /dev/null
+++ b/tests/ext4/002.out
@@ -0,0 +1,32 @@
+QA output created by 002
+setting log device read-only
+mounting with read-only log device:
+mount: device write-protected, mounting read-only
+touching file on read-only filesystem (should fail)
+touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system
+unmounting read-only filesystem
+setting log device read-write
+mounting with read-write log device:
+touch files
+going down:
+unmounting shutdown filesystem:
+setting log device read-only
+mounting filesystem that needs recovery with a read-only log device:
+mount: device write-protected, mounting read-only
+mount: cannot mount device read-only
+unmounting read-only filesystem
+umount: SCRATCH_DEV: not mounted
+mounting filesystem with -o norecovery with a read-only log device:
+mount: SCRATCH_MNT: wrong fs type, bad option, bad superblock on SCRATCH_DEV, missing codepage or helper program, or other error
+unmounting read-only filesystem
+umount: SCRATCH_DEV: not mounted
+setting fs device read-only
+mounting filesystem with -o norecovery with a read-only fs and log device:
+mount: device write-protected, mounting read-only
+unmounting read-only filesystem
+setting fs device read-write
+mounting filesystem with -o norecovery,ro with a read-only log device:
+unmounting read-only filesystem
+setting log device read-write
+mounting filesystem that needs recovery with -o ro:
+*** done
diff --git a/tests/ext4/group b/tests/ext4/group
index a1adc553..40351fd9 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -4,6 +4,7 @@
 # - comment line before each group is "new" description
 #
 001 auto prealloc quick zero
+002 shutdown mount auto quick
 003 auto quick
 004 auto dump
 005 auto quick metadata ioctl rw
-- 
2.21.3

