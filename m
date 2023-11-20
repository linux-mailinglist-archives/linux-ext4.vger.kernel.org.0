Return-Path: <linux-ext4+bounces-39-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9017F11CC
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 12:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7071C21816
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 11:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D2814AA8;
	Mon, 20 Nov 2023 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFlXQQ4z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1464D62;
	Mon, 20 Nov 2023 03:19:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso4387868b3a.2;
        Mon, 20 Nov 2023 03:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700479184; x=1701083984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdVx1mLPYgJ8PSK+Wh+08fLU/+3jz9bwfAobWV4CEv0=;
        b=aFlXQQ4zDFmPTxtTM9at2dxqlru5bUoo6SA1fGw+ICgRyoYEBnYlLY1vLj8pGSWEbV
         VpjDrKEVVZXIoshh2NIsfNflACa4qsUJ/BtUAIBexvEwJaCBj/YJ0F9TJMazSfYVzjK0
         wpKvtxVblCsuOCS1hvAw804tzhQtvGYGkCUUcnTwOB0aMzENWNDaF2r9p1zBYycvIWtw
         6ro41PjC55OUo6aawVn86oeNuPJjdFRONfdJn9UDOvsptRduCsZ5pUL2Catm2ln4V+mz
         biDT6ZOTqUBJJIw77Bq1eoa5ofpHM3y9I5xrygsSQbd9fEQsFeH1WwU8deYaOKIOb62i
         luCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479184; x=1701083984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdVx1mLPYgJ8PSK+Wh+08fLU/+3jz9bwfAobWV4CEv0=;
        b=TmJHf54HFaRBJnD84F0cOgK0uHlSdSLfBXW3SQmLvOfFaiB2eiv24xuvaNLmsQBxwx
         xSxTGtm7e1nMX5Md6YK8RQHVVSm3OV4plb4+/if4lEQvcwAOQQAG/bEFjgT97dKLKZSZ
         Rhd7NSnG0zPQa/jYrgieA8/LkvajQZK5p8WSSyGkazGXVHkuBzyjX3jBA5glSxs9vK/8
         KC9iud8tAQHuFvUqemAcNZHJ2BTx6e0x7e8WDh+8aDQc55XGOIKL/8I5OkOq6XYwCF6r
         HTVYSmCdPprSVdSdcS8+MX59z8pFE3V7EH4NBTD9EmWIUwgNNBV2PDzGrEWqIF3adJZZ
         l69g==
X-Gm-Message-State: AOJu0YxelfyrK/E6Iw7thvZV2rcGH0N+k1CUFwX7WqviFsrGXG6sfgZb
	xTyY+ON0I9OS7sw0hw7QZXLZKeCBIm8=
X-Google-Smtp-Source: AGHT+IHWG6AK9NZKOoLXSopNKh7P20KMrqrY/MNDq8A1GO4Fdwv6Inq0RN1xNQZsy9DfdEnSdB10PQ==
X-Received: by 2002:a05:6a00:8c5:b0:6be:4e6e:2a85 with SMTP id s5-20020a056a0008c500b006be4e6e2a85mr7898914pfu.30.1700479184601;
        Mon, 20 Nov 2023 03:19:44 -0800 (PST)
Received: from dw-tp.c4p-in.ibmmobiledemo.com ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id k10-20020aa788ca000000b006cb6ba5fe72sm3056158pff.122.2023.11.20.03.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:19:44 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 2/2] generic: Add integrity tests with synchronous directio
Date: Mon, 20 Nov 2023 16:49:34 +0530
Message-ID: <e255d8494511a705bacc5103e15dd532d2f433d0.1700478575.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <8379b5df9f70a1d75692e029a565199e98a535e8.1700478575.git.ritesh.list@gmail.com>
References: <8379b5df9f70a1d75692e029a565199e98a535e8.1700478575.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 tests/generic/733     | 54 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/733.out | 22 ++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100755 tests/generic/733
 create mode 100644 tests/generic/733.out

diff --git a/tests/generic/733 b/tests/generic/733
new file mode 100755
index 00000000..18021e8a
--- /dev/null
+++ b/tests/generic/733
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
+#
+# FS QA Test 471
+#
+# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown.
+# Based on a testcase reported by Gao Xiang <hsiangkao@linux.alibaba.com>
+#
+
+. ./common/preamble
+_begin_fstest auto quick shutdown aio
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch
+_require_scratch_shutdown
+_require_aiodio aio-dio-write-verify
+
+_fixed_by_kernel_commit 91562895f803 \
+	"ext4: properly sync file size update after O_SYNC direct IO"
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
diff --git a/tests/generic/733.out b/tests/generic/733.out
new file mode 100644
index 00000000..e0536a4e
--- /dev/null
+++ b/tests/generic/733.out
@@ -0,0 +1,22 @@
+QA output created by 733
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


