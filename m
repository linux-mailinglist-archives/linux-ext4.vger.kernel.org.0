Return-Path: <linux-ext4+bounces-3765-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C0D955ABE
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4E3B21264
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A51DDA9;
	Sun, 18 Aug 2024 04:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTZroTTU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF59D515
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953864; cv=none; b=sLLYPwHlu6Dks+8FDHcNnyFU0/5OlMjskSyWNw0gKOY3+Ezyu0zxj6XqsCPFAjImIf05/fw8dW2pJMelEpZcFKVR5nUIvJQB89A5lJwkk8QjtuSicYTx3H2U1enSrgwpPFyVqdsJMCQdTPJ9GhB8qkDnN2vmqbB+xTw679eg6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953864; c=relaxed/simple;
	bh=8tdJs2mMI3ljQoBFdPnJKmaY27rz9tET5lPYVfQagK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZrR7++tBoCFcjIPuUshiOsd7d9kKfLHzQ+vEyzIaxi/UmmBFfgfRgUKWaPCZC84RpvpX16Nr26voAKUR4A6+qcqdHGV5uhfE7fLahd8TFzOuMj4PC31zLe/fwpfOuKLRFOF/2OoSmCvysYLxxrdDtCSziE+SbrKHxbQz//eRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTZroTTU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-202146e9538so13512075ad.3
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723953862; x=1724558662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/wXtHe34xmeXiVBZICuTMggCRLRWfylgOdo5P2lMI4=;
        b=cTZroTTU3s+UdfNNIWfyQtwcr+uUNI4rCAjyuJm4GmHBEKB3EVEOhewpDzmSrfpzVd
         ftO09U3n1hce5AerlssQZuecarKUTKeUQLqDzpjxUintdr2g6SEihgilgp+ozzBVO71j
         lmyb09ER+45kJmji52qkHf4bF83CoA5auiuWS2bxluwLpiH25Rhtik2AeelJNXtEI7qq
         caHXAH/J+oRuHGGH1O2KdUSE1GiQL0T+kCJnVI0mY0RmdppRfY9x4bl4qEL1+7vqQKdU
         I/AMv8gLUc0yiydsEGvZwIG5JbfflHotZhl6AOH4mcm0RAv6VaFUyS0MBbIeyhy88ctS
         URvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723953862; x=1724558662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/wXtHe34xmeXiVBZICuTMggCRLRWfylgOdo5P2lMI4=;
        b=Mz4eS4T4rnSslBnRe+N6yz3+IZs/1UzDZhZILGx+EeHVDRXy6ZdDP3Lhs5yqnKKsDR
         4aD28e7Y3n5C2Sq/QHz/n7Ycx03kxILxRP2jijXvY7qZ+BbuVWkogIwWTcWuRL82UufA
         L9V5AcmBvYMiE3vJrOcLgzoz3B5cPKpdNxEk2R5Gw0sBT0J1oOnUzb02l7IcdTrnxMJM
         LU8ivgcUmEC/JYTXG5j9jTFPgK+v1DBiXrS47LyP67NnsQsMFYZFsX6bwncC+7SunGtZ
         XZOsFA0287kMBtAHS1Um4SWEdU4I5zffjWf1m2dqVUIubVnJCUFooPNNUIWyKaOY647U
         UjkA==
X-Gm-Message-State: AOJu0YzaTDSZZBYEDowBS+VaARarc2hFUAL44ZbWBc4jfgjznudCMXs7
	74KXWkjwps3SnSUPLgpiEeN3Wvs3YMfv/Khrz0lXsPnS2x71llxHZo2c/OcMeC8=
X-Google-Smtp-Source: AGHT+IH1qOKHIAiR3vmCxpWuFvbpzxainKjUj+VdyRBhrc9q03opX0WbtzGDANH3VjS/v7Fub5FOVw==
X-Received: by 2002:a17:902:d4c9:b0:1fb:31c7:857b with SMTP id d9443c01a7336-20203e4c4c8mr86631485ad.1.1723953861348;
        Sat, 17 Aug 2024 21:04:21 -0700 (PDT)
Received: from harshads.c.googlers.com.com (27.179.83.34.bc.googleusercontent.com. [34.83.179.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375649sm45138235ad.124.2024.08.17.21.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:04:20 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 6/9] ext4: update code documentation
Date: Sun, 18 Aug 2024 04:03:53 +0000
Message-ID: <20240818040356.241684-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates code documentation to reflect the commit path changes
made in this series.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 1b0540f13..71cf8dc8a 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -50,14 +50,21 @@
  * that need to be committed during a fast commit in another in memory queue of
  * inodes. During the commit operation, we commit in the following order:
  *
- * [1] Lock inodes for any further data updates by setting COMMITTING state
- * [2] Submit data buffers of all the inodes
- * [3] Wait for [2] to complete
- * [4] Commit all the directory entry updates in the fast commit space
- * [5] Commit all the changed inode structures
- * [6] Write tail tag (this tag ensures the atomicity, please read the following
+ * [1] Lock the journal by calling jbd2_journal_lock_updates. This ensures that
+ *     all the exsiting handles finish and no new handles can start.
+ * [2] Mark all the fast commit eligible inodes as undergoing fast commit
+ *     by setting "EXT4_STATE_FC_COMMITTING" state.
+ * [3] Unlock the journal by calling jbd2_journal_unlock_updates. This allows
+ *     starting of new handles. If new handles try to start an update on
+ *     any of the inodes that are being committed, ext4_fc_track_inode()
+ *     will block until those inodes have finished the fast commit.
+ * [4] Submit data buffers of all the committing inodes.
+ * [5] Wait for [4] to complete.
+ * [6] Commit all the directory entry updates in the fast commit space.
+ * [7] Commit all the changed inodes in the fast commit space and clear
+ *     "EXT4_STATE_FC_COMMITTING" for these inodes.
+ * [8] Write tail tag (this tag ensures the atomicity, please read the following
  *     section for more details).
- * [7] Wait for [4], [5] and [6] to complete.
  *
  * All the inode updates must call ext4_fc_start_update() before starting an
  * update. If such an ongoing update is present, fast commit waits for it to
@@ -143,6 +150,13 @@
  * similarly. Thus, by converting a non-idempotent procedure into a series of
  * idempotent outcomes, fast commits ensured idempotence during the replay.
  *
+ * Locking
+ * -------
+ * sbi->s_fc_lock protects the fast commit inodes queue and the fast commit
+ * dentry queue. ei->i_fc_lock protects the fast commit related info in a given
+ * inode. Most of the code avoids acquiring both the locks, but if one must do
+ * that then sbi->s_fc_lock must be acquired before ei->i_fc_lock.
+ *
  * TODOs
  * -----
  *
@@ -157,13 +171,12 @@
  *    fast commit recovery even if that area is invalidated by later full
  *    commits.
  *
- * 1) Fast commit's commit path locks the entire file system during fast
- *    commit. This has significant performance penalty. Instead of that, we
- *    should use ext4_fc_start/stop_update functions to start inode level
- *    updates from ext4_journal_start/stop. Once we do that we can drop file
- *    system locking during commit path.
+ * 1) Handle more ineligible cases.
  *
- * 2) Handle more ineligible cases.
+ * 2) Change ext4_fc_commit() to lookup logical to physical mapping using extent
+ *    status tree. This would get rid of the need to call ext4_fc_track_inode()
+ *    before acquiring i_data_sem. To do that we would need to ensure that
+ *    modified extents from the extent status tree are not evicted from memory.
  */
 
 #include <trace/events/ext4.h>
-- 
2.46.0.184.g6999bdac58-goog


