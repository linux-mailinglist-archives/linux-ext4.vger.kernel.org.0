Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39E67AC198
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Sep 2023 14:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjIWMAs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 23 Sep 2023 08:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjIWMAs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 23 Sep 2023 08:00:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D375136;
        Sat, 23 Sep 2023 05:00:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c60a514f3aso249945ad.3;
        Sat, 23 Sep 2023 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695470441; x=1696075241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdXXc+qT4ixe29aMOuCXUa7Ah3I7AYTAZ1f1/pEfbvA=;
        b=fkXefUzCxcfqdF+zLKRD8qYPLzwPeJ8ufSz/G1Zw7YEeZTkabKK6ql0Tj8G469fIRB
         OmovuEzeMbKtriyX+pr49ixoIlH0RRsijM1I6Z1LUmsot/fyWwqQpqfbSliVSRq/+pIK
         jZ1u8R47RvzX3NhxBtIU/9acBSZOlGx+QA7RiY+RufMuxTZ0kBC/kpcwgvggpvSh2asA
         6nxOCPnbz0MgusWU8BOHXEzbJDZGaENlCP9DVtzGqiE+HMIJkh0lpk2uGjL8NU7Lenbe
         NIylKr/9365q3XilhFDVGMBpxl1G4PKMlLO99caCmn+sC53DM6R65lKgHM/qC+GEgiQx
         UywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695470441; x=1696075241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdXXc+qT4ixe29aMOuCXUa7Ah3I7AYTAZ1f1/pEfbvA=;
        b=CcIwPgu5X5RMMpuSe8ZONdYJOIjxkk8hhlWjVkFEKtQwjRm36RM1BRGImDkQUsDzGi
         8EkJhd7mrEiZmRVeSn9gbXYiqKZmRT11Ig5kFgk3bvuiYHX2JllUwIm+ByIOKt7XQ+0r
         KUAigd9MhrI04VpW9nq1TWOMIV1E4cSBFc2eQKBgYZvUUBgQp9ReUB89ar15xRxUg5k1
         oqvG+7I3qnC29C4rcBzfW9uoI0LXrO1rYLTO1TB+jkQQpMf/8YvrQYT2QJC5gTb5JDhh
         moUGTvyYOC2cXW9uGVSqnVzlZ5L3Xp9VPTpjXP0fjD3/Gjolzj8l0BNNUYldbD14FmBL
         E1gQ==
X-Gm-Message-State: AOJu0YxuLeBD3e50Skh8oSTEgAZBukVObZ8+1JevArvWJX8VH8XjqVKi
        AoUVuavqZEPQiqXIj7D9Kz4b3X6gouE=
X-Google-Smtp-Source: AGHT+IH9mv4znL90H67WUwuTPrcfQvsBjZj34kUno4h2Z0wnbfHAVX6B6KO5S2Hx1nBfr8jFhomA7g==
X-Received: by 2002:a17:902:c947:b0:1c5:e060:c4d5 with SMTP id i7-20020a170902c94700b001c5e060c4d5mr2353453pla.69.1695470441196;
        Sat, 23 Sep 2023 05:00:41 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001bba669a7eesm5194981plb.52.2023.09.23.05.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 05:00:40 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCHv2 2/2] generic: Add integrity tests with synchronous directio
Date:   Sat, 23 Sep 2023 17:30:24 +0530
Message-ID: <3c21207848460ffe8aab734b32c1c2464049296c.1695469920.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <3b86ab1f1447f0b6db88d4dfafe304fd04ae2b11.1695469920.git.ritesh.list@gmail.com>
References: <3b86ab1f1447f0b6db88d4dfafe304fd04ae2b11.1695469920.git.ritesh.list@gmail.com>
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
 tests/generic/471     | 50 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/471.out | 22 +++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100755 tests/generic/471
 create mode 100644 tests/generic/471.out

diff --git a/tests/generic/471 b/tests/generic/471
new file mode 100755
index 00000000..218e6676
--- /dev/null
+++ b/tests/generic/471
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
+#
+# FS QA Test 471
+#
+# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown
+#
+. ./common/preamble
+_begin_fstest auto quick shutdown aio
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch
+_require_scratch_shutdown
+_require_odirect
+_require_aiodio aio-dio-write-verify
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount
+
+echo "T-1: Create a 1M file using buff-io & O_SYNC"
+$XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
+echo "T-1: Shutdown the fs suddenly"
+_scratch_shutdown
+echo "T-1: Cycle mount"
+_scratch_cycle_mount
+echo "T-1: File contents after cycle mount"
+_hexdump $SCRATCH_MNT/testfile.t1
+
+echo "T-2: Create a 1M file using O_DIRECT & O_SYNC"
+$XFS_IO_PROG -fsd -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t2 > /dev/null 2>&1
+echo "T-2: Shutdown the fs suddenly"
+_scratch_shutdown
+echo "T-2: Cycle mount"
+_scratch_cycle_mount
+echo "T-2: File contents after cycle mount"
+_hexdump $SCRATCH_MNT/testfile.t2
+
+echo "T-3: Create a 1M file using AIO-DIO & O_SYNC"
+$AIO_TEST -a size=1048576 -S -N $SCRATCH_MNT/testfile.t3 > /dev/null 2>&1
+echo "T-3: Shutdown the fs suddenly"
+_scratch_shutdown
+echo "T-3: Cycle mount"
+_scratch_cycle_mount
+echo "T-3: File contents after cycle mount"
+_hexdump $SCRATCH_MNT/testfile.t3
+
+status=0
+exit
diff --git a/tests/generic/471.out b/tests/generic/471.out
new file mode 100644
index 00000000..2bfb033d
--- /dev/null
+++ b/tests/generic/471.out
@@ -0,0 +1,22 @@
+QA output created by 471
+T-1: Create a 1M file using buff-io & O_SYNC
+T-1: Shutdown the fs suddenly
+T-1: Cycle mount
+T-1: File contents after cycle mount
+000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
+*
+100000
+T-2: Create a 1M file using O_DIRECT & O_SYNC
+T-2: Shutdown the fs suddenly
+T-2: Cycle mount
+T-2: File contents after cycle mount
+000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
+*
+100000
+T-3: Create a 1M file using AIO-DIO & O_SYNC
+T-3: Shutdown the fs suddenly
+T-3: Cycle mount
+T-3: File contents after cycle mount
+000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
+*
+100000
-- 
2.41.0

