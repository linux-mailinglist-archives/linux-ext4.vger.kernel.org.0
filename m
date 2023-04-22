Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5136EBA47
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Apr 2023 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjDVQRp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Apr 2023 12:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVQRo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Apr 2023 12:17:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923D619AD;
        Sat, 22 Apr 2023 09:17:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a677dffb37so28014945ad.2;
        Sat, 22 Apr 2023 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682180262; x=1684772262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J1YAcRCbPbk39pfjICicc0ZHE/bFqeSlRI1/k/iUstU=;
        b=FYUj/rSenV8vZq/OuGDkGSvzaLgEyaV0sEKsEUa3b8esEpfSffEwDrLeyGMEEPi7k1
         OCrTHuNxgubZWrmNzTdoYFixGNyYjhTDB2ZlY2GHne3NgbKr7enQq6s4jsJS/u3ylG14
         G89hLtoba4y8hEuiWJekSgAlUVLNB9lMkbagpegBD7aBZ8rBz0KUNa35abPrOvoWd/Qg
         SI9Ps4yg2joCsVdJmjYJ/q0Tpt96PGbm2ipIezEWmUvNyYkH4U/YUOauhn3Oz5Tuispp
         dhrMJMJRDDnfFC2z8rsnf8ymsTPS4PFizqmlESXH0T7TPoG4lWNo2VhviSCX783TaUqY
         /scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682180262; x=1684772262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1YAcRCbPbk39pfjICicc0ZHE/bFqeSlRI1/k/iUstU=;
        b=DyCFmj8PCkMRz5xdeAqjfOuMfixKleGzt6CbrYQd7COX1HikmuBLOnut5bQ1WMxiiv
         YEKAOZe6WcF2GLqQhoazdr+0nz14zGcEz7EuiTlQNyWWjF3n6gwDIfGpCeENyZHjRJwN
         CbK+HOBeliWnRafpUuRTq6enlQDj+3MP+tn5vsaTace65v/LoVOQSmyA5NtEPuhKJdbC
         2iUpCScF+iBQuyjYp/scbfLEEvrzJcg6DZoatGvHgn0XmeYLkckMmuTSdcblHBWue04J
         pGgOI9QqAPhlyJiKsYJi1zs7JzhOfsoR/cp3iXDVUTM3aWNczneaa/YJak7SOaTj0gFm
         aRgg==
X-Gm-Message-State: AAQBX9cJZrDPJXCsciFzBAUWg/6v3CbacK4jLyTrwgyEhW/75zy7ojFC
        ABv7N4+ALtjV/+5+HtoRVbVCEz8Aho0=
X-Google-Smtp-Source: AKy350YrtjP8ui83Stv7m5JWeskGvQdDF+yEX1bgrmrYf8JV6qEe6+wDgXBDhFIRJU9HmpAffLs5fg==
X-Received: by 2002:a17:903:22ca:b0:1a1:595a:8e3b with SMTP id y10-20020a17090322ca00b001a1595a8e3bmr11398626plg.34.1682180262435;
        Sat, 22 Apr 2023 09:17:42 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902d70f00b001a6c58e95d7sm4204688ply.269.2023.04.22.09.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 09:17:41 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 1/2] ext4/060: Regression test against dioread_nolock mount option inconsistency
Date:   Sat, 22 Apr 2023 21:47:33 +0530
Message-Id: <aa8a633b016114b94d10dd0f9f0b7a355aeb1d62.1682179372.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

During ext4_writepages, ext4 queries dioread_nolock mount option twice
and if someone remount the filesystem in between with ^dioread_nolock,
then this can cause an inconsistency causing WARN_ON() to be triggered.

This fix describes the problem in more detail -

https://lore.kernel.org/linux-ext4/20230328090534.662l7yxj2e425j7w@quack3/T/#md19c34646e8b4a816498532c298a66ecf2ae77d4

This test reproduces below warning for me w/o the fix.

------------[ cut here ]------------
WARNING: CPU: 2 PID: 26 at fs/ext4/page-io.c:231 ext4_put_io_end_defer+0xfb/0x140
Modules linked in:
CPU: 2 PID: 26 Comm: ksoftirqd/2 Not tainted 6.3.0-rc6-xfstests-00044-ga5c68786f1b1 #23
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
RIP: 0010:ext4_put_io_end_defer+0xfb/0x140
Code: 5d 41 5e 41 5f e9 a5 73 d0 00 5b 48 89 ef 5d 41 5c 41 5d 41 5e 41 5f e9 d3 fa ff ff 49 83 be a8 03 00 00 00 0f 84 7b ff fd
<...>
Call Trace:
 <TASK>
 blk_update_request+0x116/0x4c0
 ? finish_task_switch.isra.0+0xfb/0x320
 blk_mq_end_request+0x1e/0x40
 blk_complete_reqs+0x40/0x50
 __do_softirq+0xd8/0x3e1
 ? smpboot_thread_fn+0x30/0x280
 run_ksoftirqd+0x3a/0x60
 smpboot_thread_fn+0x1d8/0x280
 ? __pfx_smpboot_thread_fn+0x10/0x10
 kthread+0xf6/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>
[

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tests/ext4/060     | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/060.out |  2 ++
 2 files changed, 90 insertions(+)
 create mode 100755 tests/ext4/060
 create mode 100644 tests/ext4/060.out

diff --git a/tests/ext4/060 b/tests/ext4/060
new file mode 100755
index 00000000..d9fe1a99
--- /dev/null
+++ b/tests/ext4/060
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
+#
+# FS QA Test 060
+#
+# This is to test a ext4 regression against inconsistent values of
+# dioread_nolock mount option while in ext4_writepages path.
+# See - https://lore.kernel.org/linux-ext4/20230328090534.662l7yxj2e425j7w@quack3/T/#md19c34646e8b4a816498532c298a66ecf2ae77d4
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+PID1=""
+PIDS=""
+trap "_cleanup; exit \$status" 0 1 2 3 15
+# Override the default cleanup function.
+ _cleanup()
+{
+	{
+		kill -SIGKILL $PID1 $PIDS
+		wait $PID1 $PIDS
+	} > /dev/null 2>&1
+
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+ . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs ext4
+_require_scratch
+
+_scratch_mkfs_ext4 >> $seqres.full 2>&1
+_scratch_mount
+_scratch_remount "dioread_nolock" >> $seqres.full 2>&1
+ret=$?
+if [ $ret -ne 0 ]; then
+	_notrun "dioread_nolock mount option not supported"
+fi
+
+testfile=$SCRATCH_MNT/testfile
+
+function run_buff_io_loop()
+{
+	# add buffered io case here
+	while [ 1 ]; do
+		xfs_io -fc "truncate 0" -c "pwrite 0 200M" -c "fsync" "$testfile.$1" > /dev/null 2>&1
+		sleep 2;
+	done
+}
+
+function run_remount_loop()
+{
+	# add remount loop case here
+	while [ 1 ]; do
+		_scratch_remount "dioread_nolock" >> $seqres.full 2>&1
+		sleep 1
+		_scratch_remount "dioread_lock" >> $seqres.full 2>&1
+		sleep 1
+	done
+}
+
+run_remount_loop &
+PID1=$!
+
+for i in $(seq 1 20); do
+	run_buff_io_loop $i &
+	PID=$!
+	PIDS="${PIDS} ${PID}"
+done
+
+sleep 10
+
+{
+	kill -SIGKILL $PID1 $PIDS
+	wait $PID1 $PIDS
+} > /dev/null 2>&1
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/060.out b/tests/ext4/060.out
new file mode 100644
index 00000000..8ffce4de
--- /dev/null
+++ b/tests/ext4/060.out
@@ -0,0 +1,2 @@
+QA output created by 060
+Silence is golden
--
2.39.2

