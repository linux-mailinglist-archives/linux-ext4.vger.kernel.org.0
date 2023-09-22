Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E947AB1DF
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Sep 2023 14:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjIVMKv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Sep 2023 08:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjIVMKv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Sep 2023 08:10:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A9792;
        Fri, 22 Sep 2023 05:10:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68bed2c786eso1848005b3a.0;
        Fri, 22 Sep 2023 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695384644; x=1695989444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPDulTQG32dEgsHx5Z26bnYKsvCd2L6FGqcW6KHfius=;
        b=IxDKV8AI2U15GgXSEo/bksHf69jRKL906eJOpx1+C7v9vBp79DJVDul2ZFjlCrIuyq
         +4QgWOxJeG8/R0NnbFUbnOHz4MBvkjUcIoPvVlz5A2ptLwJaWUqxaeh7nJChjpuSn3bd
         c2kNplqyvD9PenQeuLkAvd3aMaq0AiDwbToPCCwAt/Rh5rZkTqCIT6XOWhj4qMJMoD52
         IfasnEOORKJjvW7PdLYIT/gv7chB4VVoyQpV/7g9OYE/0N3OOV7KKFqWZ/vxmflEC7wB
         pVpy9ko/kUDvqlKl06My/msd2rk9H0eK7dGJobtPJBxe2ViFVF8zHFaVZOqpEEa90m6g
         Qd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695384644; x=1695989444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPDulTQG32dEgsHx5Z26bnYKsvCd2L6FGqcW6KHfius=;
        b=h9Rg6qaL4vZiNLfZ+C0qxr+TvtlQ48GIPQg4OrOAFuKZ6JpUx8EbcUYNWhFiQiHKv2
         o6/V+LeUsqh6S0MP5afcDSMtjHWUK4qnRCXTTTOIo9e76ybEC27CLzq7HLAA/2FOhMYV
         GJtX2+P4iESBNG/ihyDIXU/n9GsJ5oF7ZxNYd8fzz6dXATvzQfIKlbWNcffRWd7+et/q
         +moOonfWt2UZ6eIORu7nuN1xMUWlh7k3+VqZjs2AuOrUE8Yl3xuIvUmhu3osvb5RIVwM
         yBYT+YgOgxcslVYWQxY8enWmNo4qa1ErIUWszzpbtXkjVCpz0/ph5wSWTCD/DfFW96EX
         4fCg==
X-Gm-Message-State: AOJu0YwHvJSSK2FYulX4jmdPUonai2TJjVtA3HzqZxpGpzuc+8OgHXZU
        Hmi0WDAx+rqRxL5aX087rzT4VckGGd8=
X-Google-Smtp-Source: AGHT+IEjKnrh5M2TnMG3CWNSLkGC2K6tUNRhr56GE0XpOPse5DHFw5PcAs77AS8qLtIweQTd1dqV8Q==
X-Received: by 2002:a05:6a21:47ca:b0:157:b9e1:c82f with SMTP id as10-20020a056a2147ca00b00157b9e1c82fmr7412339pzc.35.1695384643788;
        Fri, 22 Sep 2023 05:10:43 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ad98e00b00274803c4c90sm3127380pjv.40.2023.09.22.05.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:10:43 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] generic: Add integrity tests with synchronous directio
Date:   Fri, 22 Sep 2023 17:40:36 +0530
Message-ID: <434beffaf18d39f898518ea9eb1cea4548e77c3a.1695383715.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <87y1gy5s9c.fsf@doe.com>
References: <87y1gy5s9c.fsf@doe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test covers data & metadata integrity check with directio with
o_sync flag and checks the file contents & size after sudden fileystem
shutdown once the directio write is completed. ext4 directio after iomap
conversion was broken in the sense that if the FS crashes after
synchronous directio write, it's file size is not properly updated.
This test adds a testcase to cover such scenario.

Man page of open says that -
O_SYNC provides synchronized I/O file integrity completion, meaning write
operations will flush data and all associated metadata to the underlying
hardware

Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tests/generic/471     | 45 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/471.out |  8 ++++++++
 2 files changed, 53 insertions(+)
 create mode 100755 tests/generic/471
 create mode 100644 tests/generic/471.out

diff --git a/tests/generic/471 b/tests/generic/471
new file mode 100755
index 00000000..6c31cff8
--- /dev/null
+++ b/tests/generic/471
@@ -0,0 +1,45 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
+#
+# FS QA Test 471
+#
+# Integrity test with DIRECT_IO & O_SYNC with sudden shutdown
+#
+. ./common/preamble
+_begin_fstest auto quick shutdown
+
+# Override the default cleanup function.
+_cleanup()
+{
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
+_supported_fs generic
+_require_scratch
+_require_scratch_shutdown
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount
+
+echo "Create a 1M file using O_DIRECT & O_SYNC"
+xfs_io -fsd -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile > /dev/null 2>&1
+
+echo "Shutdown the fs suddenly"
+_scratch_shutdown
+
+echo "Cycle mount"
+_scratch_cycle_mount
+
+echo "File contents after cycle mount"
+_hexdump $SCRATCH_MNT/testfile
+
+status=0
+exit
diff --git a/tests/generic/471.out b/tests/generic/471.out
new file mode 100644
index 00000000..ae279b79
--- /dev/null
+++ b/tests/generic/471.out
@@ -0,0 +1,8 @@
+QA output created by 471
+Create a 1M file using O_DIRECT & O_SYNC
+Shutdown the fs suddenly
+Cycle mount
+File contents after cycle mount
+000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
+*
+100000
-- 
2.41.0

