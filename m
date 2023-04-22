Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C316EBA48
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Apr 2023 18:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDVQRw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Apr 2023 12:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjDVQRr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Apr 2023 12:17:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C01FDF;
        Sat, 22 Apr 2023 09:17:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24704a7bf34so2730367a91.1;
        Sat, 22 Apr 2023 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682180264; x=1684772264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i09eqEFp0fkOjuwtq7rmcXArU9WDRyTijzFdoLMRfcA=;
        b=MngscLLq+1OTxCWbrpxQLEtvLW3jOcopho5c7Y0Y3ho4NpUHJUY0ldYzdRQBr9CyYc
         SCsDN4Ag+d6USmfUbs+WPaQoNOHHUwhWKyLw6NuemvYauMw2t9BfCA8b4QM3m68itsEj
         elfu09uGB5UfL1AZeLpjkTWEeXsL6ndaBtLXvPrPRWCclO5/tjGV5dIyjStU1tCdRhX2
         V1QIybeFogvCzhtBx5MHnv0oysZtj9x1wELVF6O5tbZOh/sLeDdHsxZ86f1s2goCQbqx
         QuPBsw0sS7HJ4ni0vIeWs95bit1QgTChZ/1vGAsrGERbwtHJCNC6GKI1RjIWsjdK2xJd
         18Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682180264; x=1684772264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i09eqEFp0fkOjuwtq7rmcXArU9WDRyTijzFdoLMRfcA=;
        b=Y2lbhVsZrL8dKdHrRa15oFiN5tB0I5CxrtbXXRA495nbQW4v+R3CaPOBG14NUyMGw9
         dA37TdKjlTmQhRGDoAJMSmCdwmqe6fJmNXcko6etpbbFlX4OAHNjk6RPpBQSta/4DIfH
         ucP9lqPH/3UO1FCoZgD5tUuAFA2j/ABfxvuLGMtcFkA+npJlmnMP00RfGMOJAaK71YBa
         X+KJ0Thy8/MZ7TTxcXNBDV2UVhCacrZE2ZVBulsyZTtjYRJqw1OOEACmDWI695lu1gxL
         nTrhQCYTfhVedGqL7A/IqiLlKayn9hgcf52ddSA6TmK/Bm2mKv5ELGMa3PFT+XSoiHPm
         z+mQ==
X-Gm-Message-State: AAQBX9f12d8zpcSztYbzBcy3ByCtWgEYsGztSK1v8UfPUQAQ8JyrlE5a
        RaGavruSrniwhXCACy2BMPMBnAzV3+E=
X-Google-Smtp-Source: AKy350YS8fSCXgGgRDftGYZ1TjdSkGixkexa5Q6eGuH18Dl/nlGD4sbF+2B0KENDToREPNEMQGuxsQ==
X-Received: by 2002:a17:90a:c687:b0:247:54c7:1bdd with SMTP id n7-20020a17090ac68700b0024754c71bddmr8723418pjt.22.1682180264435;
        Sat, 22 Apr 2023 09:17:44 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902d70f00b001a6c58e95d7sm4204688ply.269.2023.04.22.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 09:17:44 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 2/2] ext4/061: Regression test of jbd2 journal_task race against unmount
Date:   Sat, 22 Apr 2023 21:47:34 +0530
Message-Id: <75819a20d2337c154e360c60ec53b7e519ebb97a.1682179372.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <aa8a633b016114b94d10dd0f9f0b7a355aeb1d62.1682179372.git.ritesh.list@gmail.com>
References: <aa8a633b016114b94d10dd0f9f0b7a355aeb1d62.1682179372.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test adds a testcase to catch race condition against
reading of journal_task and parallel unmount.
This patch in kernel fixes this [1]

    ext4_put_super()                cat /sys/fs/ext4/loop2/journal_task
            |                               ext4_attr_show();
    ext4_jbd2_journal_destroy();                    |
            |                                journal_task_show()
            |                                       |
            |                               task_pid_vnr(NULL);
    sbi->s_journal = NULL;

RIP: 0010:__task_pid_nr_ns+0x4d/0xe0
<...>
Call Trace:
 <TASK>
 ext4_attr_show+0x1bd/0x3e0
 sysfs_kf_seq_show+0x8e/0x110
 seq_read_iter+0x11b/0x4d0
 vfs_read+0x216/0x2e0
 ksys_read+0x69/0xf0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
[

[1]: https://lore.kernel.org/all/20200318061301.4320-1-riteshh@linux.ibm.com/
Commit: ext4: Unregister sysfs path before destroying jbd2 journal

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tests/ext4/061     | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/061.out |  2 ++
 2 files changed, 84 insertions(+)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out

diff --git a/tests/ext4/061 b/tests/ext4/061
new file mode 100755
index 00000000..88bf138a
--- /dev/null
+++ b/tests/ext4/061
@@ -0,0 +1,82 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
+#
+# FS QA Test 061
+#
+# Regression test for https://lore.kernel.org/all/20200318061301.4320-1-riteshh@linux.ibm.com/
+# ext4: Unregister sysfs path before destroying jbd2 journal
+#
+
+. ./common/preamble
+_begin_fstest auto quick
+
+pid_mloop=""
+pids_jloop=""
+trap "_cleanup; exit \$status" 0 1 2 3 15
+# Override the default cleanup function.
+_cleanup()
+{
+	{
+		kill -SIGKILL $pid_mloop $pids_jloop
+		wait $pid_mloop $pids_jloop
+	} > /dev/null 2>&1
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs ext4
+_fixed_by_kernel_commit 5e47868fb94b63c \
+	"ext4: unregister sysfs path before destroying jbd2 journal"
+_require_scratch
+_require_fs_sysfs journal_task
+
+_scratch_mkfs_ext4 >> $seqres.full 2>&1
+# mount filesystem
+_scratch_mount >> $seqres.full 2>&1
+scratch_dev=$(_short_dev $SCRATCH_DEV)
+
+function mount_loop()
+{
+	while [ 1 ]; do
+		_scratch_unmount >> $seqres.full 2>&1
+		sleep 1;
+		_scratch_mount >> $seqres.full 2>&1
+		sleep 1;
+	done
+}
+
+function read_journal_task_loop()
+{
+	while [ 1 ]; do
+		cat /sys/fs/ext4/$scratch_dev/journal_task > /dev/null 2>&1
+		sleep 1;
+	done
+}
+
+mount_loop &
+pid_mloop=$!
+
+for i in $(seq 1 100); do
+	read_journal_task_loop &
+	pid=$!
+	pids_jloop="${pids_jloop} ${pid}"
+done
+
+sleep 20
+{
+	kill -SIGKILL $pid_mloop $pids_jloop
+	wait $pid_mloop $pids_jloop
+} > /dev/null 2>&1
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/061.out b/tests/ext4/061.out
new file mode 100644
index 00000000..273be9e0
--- /dev/null
+++ b/tests/ext4/061.out
@@ -0,0 +1,2 @@
+QA output created by 061
+Silence is golden
--
2.39.2

