Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189ED3F14D5
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhHSIIm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 04:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237002AbhHSIIk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 19 Aug 2021 04:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629360484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DVuh+rKW+NNwd9FLY3ncgyo526urweKrFBIuCPmrm1k=;
        b=DNCNEcnstSaPqVck1N57DSo0r/oYH+6mN2xiKNpQ1HJdHBD6ks3L5WldsDWSw0UrgB2iHo
        qnn2I6RjRsvC7P2i88jQ1XM5zGzQDg3mZ8U0pKReirWTRAp6cIAcW1gef0LIvWK2npgq6Y
        4gAaSSPC1r2PoMw9228R9rWDq74E/rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-K8ma7o79Py2_VFnv7ycMvA-1; Thu, 19 Aug 2021 04:08:03 -0400
X-MC-Unique: K8ma7o79Py2_VFnv7ycMvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0608A107ACF5;
        Thu, 19 Aug 2021 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (bootp-73-5-251.rhts.eng.pek2.redhat.com [10.73.5.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B658969CBC;
        Thu, 19 Aug 2021 08:07:59 +0000 (UTC)
From:   bxue@redhat.com
To:     fstests@vger.kernel.org
Cc:     jack@suse.cz, zlang@redhat.com, eguan@linux.alibaba.com,
        linux-ext4@vger.kernel.org, Boyang Xue <bxue@redhat.com>
Subject: [PATCH v2] ext4: regression test for "tune2fs -l" after ext4 shutdown
Date:   Thu, 19 Aug 2021 16:07:51 +0800
Message-Id: <20210819080751.4189684-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Boyang Xue <bxue@redhat.com>

Regression test for:

e905fbe3fd0f ext4: Fix tune2fs checksum failure for mounted filesystem

This test runs "tune2fs -l" after ext4 shutdown. tune2fs reads superblock
checksum from the buffer cache. On unfixed kernels, the checksum is incorrect
until the writeout happens, so tune2fs fails with "superblock checksum does not
match" in this case.

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
Hi,

This is the v2 of the test. I have fixed various errors in this version
according to comments for v1. Hope I'm not missing anything here. Please help
review it. Thanks!


JFYI, I paste the test log here:

On good kernel
```
[root@kvm101 repo_xfstests]# ./check ext4/309
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 kvm101 4.18.0-305.el8.x86_64 #1 SMP Mon Aug 16 15:20:14 EDT 2021
MKFS_OPTIONS  -- -b 1024 /dev/vda2
MOUNT_OPTIONS -- -o rw,relatime,seclabel -o context=system_u:object_r:root_t:s0 /dev/vda2 /scratch

ext4/309 1s ...  1s
Ran: ext4/309
Passed all 1 tests

[root@kvm101 repo_xfstests]# cat results/ext4/309.out.bad
cat: results/ext4/309.out.bad: No such file or directory
[root@kvm101 repo_xfstests]# cat results/ext4/309.full
tune2fs 1.45.6 (20-Mar-2020)
Filesystem volume name:   <none>
Last mounted on:          /scratch
Filesystem UUID:          f1ffdc35-a925-4007-99ab-b8f3bdec21cd
```

On bad kerenel
```
[root@kvm102 repo_xfstests]# ./check ext4/309
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 kvm102 5.14.0-0.rc4.35.xx.x86_64 #1 SMP Tue Aug 3 13:02:44 EDT 2021
MKFS_OPTIONS  -- -b 1024 /dev/vda3
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/vda3 /scratch

ext4/309        - output mismatch (see /root/repo_xfstests/results//ext4/309.out.bad)
    --- tests/ext4/309.out      2021-08-19 05:02:40.188366781 -0400
    +++ /root/repo_xfstests/results//ext4/309.out.bad   2021-08-19 08:02:47.902366781 -0400
    @@ -1,2 +1,4 @@
     QA output created by 309
     Silence is golden
    +/usr/sbin/tune2fs: Superblock checksum does not match superblock while trying to open /dev/vda3
    +Couldn't find valid filesystem superblock.
    ...
    (Run 'diff -u /root/repo_xfstests/tests/ext4/309.out /root/repo_xfstests/results//ext4/309.out.bad'  to see the entire diff)
Ran: ext4/309
Failures: ext4/309
Failed 1 of 1 tests
[root@kvm102 repo_xfstests]# cat results/ext4/309.out.bad
QA output created by 309
Silence is golden
/usr/sbin/tune2fs: Superblock checksum does not match superblock while trying to open /dev/vda3
Couldn't find valid filesystem superblock.
[root@kvm102 repo_xfstests]# cat results/ext4/309.full
tune2fs 1.46.2 (28-Feb-2021)
```

-Boyang

 tests/ext4/309     | 29 +++++++++++++++++++++++++++++
 tests/ext4/309.out |  2 ++
 2 files changed, 31 insertions(+)
 create mode 100755 tests/ext4/309
 create mode 100644 tests/ext4/309.out

diff --git a/tests/ext4/309 b/tests/ext4/309
new file mode 100755
index 00000000..8594d264
--- /dev/null
+++ b/tests/ext4/309
@@ -0,0 +1,29 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test 309
+#
+# Test that tune2fs doesn't fail after ext4 shutdown
+# Regression test for commit:
+# e905fbe3fd0f ext4: Fix tune2fs checksum failure for mounted filesystem
+#
+. ./common/preamble
+_begin_fstest auto rw quick
+
+# real QA test starts here
+_supported_fs ext4
+_require_scratch
+_require_scratch_shutdown
+_require_command "$TUNE2FS_PROG" tune2fs
+
+echo "Silence is golden"
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+echo "This is a test" > $SCRATCH_MNT/testfile
+_scratch_shutdown
+_scratch_cycle_mount
+$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full
+status=0
+exit
diff --git a/tests/ext4/309.out b/tests/ext4/309.out
new file mode 100644
index 00000000..56330d65
--- /dev/null
+++ b/tests/ext4/309.out
@@ -0,0 +1,2 @@
+QA output created by 309
+Silence is golden
-- 
2.27.0

