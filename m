Return-Path: <linux-ext4+bounces-7773-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC07AB01F6
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 20:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8139C7BBA77
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E060286D7D;
	Thu,  8 May 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbw6lYfg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23CC286D5F
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727178; cv=none; b=JU0vr1WQtFgrZQuRfUY+YRng8evM0Yv48GrOWlAnSWOq4pXXI1mWMuWFjvOahf4rZCmWvWHOSwI2nYDdy2D2sjGIJgdm+OrXdESzEWamRhG6LX0VU2Y/hl/osXVwaN9cbZHmiz4OgxvVM8IQpWA5vnK5k4/TcF3TIXtih12DAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727178; c=relaxed/simple;
	bh=wPm2PnFaFqJdG+tou6tHu0ps+um9SO/2Dq48HVSDnGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rn2YXI+IEZUsee2kcA14qVWm4klm3z+WE0JxwIVskcaX6iZM7xUt7C/yDkaAAff6rw1KRLChLzjEitC50d7CVL8iq+uN2jPk1gLedjX5nQlI9RjB/DQXP03h2pMp36PQ7gt1GP5ilEHVp8f+yiY+1ZkfWLPAnLRX1Ty0J0nlrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bbw6lYfg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736a7e126c7so1339964b3a.3
        for <linux-ext4@vger.kernel.org>; Thu, 08 May 2025 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746727176; x=1747331976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN7NgPynjQ2ZAvz3OmbqzXIzdZx7B5ob1vAJEalfJdo=;
        b=Bbw6lYfgkbKozeBUCvVadAKjXOH0qW9k8cC85RTU21myxJbzktDLvprTpcTigwowxi
         +EMiGPneYVhiXS2yUYqBLk/79YZ4hijIBD/AcNwoNjjmGDZqvDdVHcgvZeKyyrj+V/f/
         AtLTwt31iv3sonJZHSPLUBKgdZ8rIKywZaGpTEr8f+lzcN+C0JYtjDPNawXbVnlGRbld
         UCUa2Q0bFK3G2aGiMQEj2BPLsSCr9BBmt5a40qx5m9R1vXIrQNHeHVJyvL8DaCnJorWo
         PocbytPadJwjpHRNPbeHH8hvZzrSrFRxIDsqxGDy1ZxHHOeJS8k3fWjdcSb56/IDYAbb
         vQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727176; x=1747331976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN7NgPynjQ2ZAvz3OmbqzXIzdZx7B5ob1vAJEalfJdo=;
        b=XDkhkMd8ku+HfUzlSghU2GUL0bPmlu82iZPjwZ9Obhdezh4pz7r3I+1Ay8oYVOOrP5
         e5fyCuXD/EIhpaXpb/5kNH2f4KrXG1+otkPvNoqKyrsEXeteDas/eWnXHGcWwtzyumOS
         JYFhkRwyRCbwUGy33/za71cBK/qxAelgF6fw72sNA3LeXDldfH+HV6k1aFFnX1r+F67E
         FCkyhaQ/6nz3qrVXT/9ZvWua9Kbh/KvmpFhOFq9KIs9olkSie1Q0CL/D5/6YKtiEeGkm
         ucaTwNteU/wvu1u18dwT1mTgXv2tfzB0tc6MUdQXBS3ER3wOh1szClaRKmBZJ1rdjOc3
         6kIQ==
X-Gm-Message-State: AOJu0YxxNMqaajlowvLwkHHtwUwT3++nAyIXlG9GWyO1ZJM33cgdaXTK
	Mog6ir7g4hnPGGJdQbs0/tjtmeRDYfOmh5xO6BaIwHoTzy4nFIorp1oW9rBQv/4=
X-Gm-Gg: ASbGnctflFTAdthThcq3fLyYTlIz24nt6KS6lMPknl7k8zzuc+mreNGGdQBasUggRn5
	4h+1GhZnLDKb5cOSUdm2sOQ3elPbsw7H+Ix2sWA6xxDIfyjkFx/1bx0jExcbZTlNfZalZV2JMoG
	7nVWYIGKmCv4EqPpItuHMDs8PTS9PjDwnlyRJlrs4/LBJsrdZw+PgFCd2iB6RThpDQJrS0ARCwu
	fnt/TtJpa89dyPNkwKxjLZQrMhgDf8QHwOGGrLweRuQDnQ83/dCbY2oHy4d+ShH697OQx5jGQtg
	iErlsPjp384eNPvXuRC2GnvA5I119XJ1j8aUa+NsfSVjwsJChlMpSU/QkjVfj2Xs0OZMUFE7Xsc
	Aga7t+37bbHLXp0B2mltW0aLOXXnXMogigjB8gZO4rwVyAJc=
X-Google-Smtp-Source: AGHT+IFO8fgUYaNrBt+19U8pJ21LpsMDzZm2fTdI/ktB0rbRIa6Cj3au11ga075UbbxsDXg3Sc+mkA==
X-Received: by 2002:a17:903:2351:b0:223:2cae:4a96 with SMTP id d9443c01a7336-22fc918c11emr3575515ad.42.1746727175587;
        Thu, 08 May 2025 10:59:35 -0700 (PDT)
Received: from harshads.c.googlers.com.com (156.242.82.34.bc.googleusercontent.com. [34.82.242.156])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22fc828939asm2153535ad.164.2025.05.08.10.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:59:35 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 6/9] ext4: update code documentation
Date: Thu,  8 May 2025 17:59:05 +0000
Message-ID: <20250508175908.1004880-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
In-Reply-To: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
References: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
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

code docs
---
 fs/ext4/fast_commit.c | 48 ++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f2e8a5f22..06dda3932 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -50,19 +50,27 @@
  * that need to be committed during a fast commit in another in memory queue of
  * inodes. During the commit operation, we commit in the following order:
  *
- * [1] Lock inodes for any further data updates by setting COMMITTING state
- * [2] Submit data buffers of all the inodes
- * [3] Wait for [2] to complete
- * [4] Commit all the directory entry updates in the fast commit space
- * [5] Commit all the changed inode structures
- * [6] Write tail tag (this tag ensures the atomicity, please read the following
+ * [1] Prepare all the inodes to write out their data by setting
+ *     "EXT4_STATE_FC_FLUSHING_DATA". This ensures that inode cannot be
+ *     deleted while it is being flushed.
+ * [2] Flush data buffers to disk and clear "EXT4_STATE_FC_FLUSHING_DATA"
+ *     state.
+ * [3] Lock the journal by calling jbd2_journal_lock_updates. This ensures that
+ *     all the exsiting handles finish and no new handles can start.
+ * [4] Mark all the fast commit eligible inodes as undergoing fast commit
+ *     by setting "EXT4_STATE_FC_COMMITTING" state.
+ * [5] Unlock the journal by calling jbd2_journal_unlock_updates. This allows
+ *     starting of new handles. If new handles try to start an update on
+ *     any of the inodes that are being committed, ext4_fc_track_inode()
+ *     will block until those inodes have finished the fast commit.
+ * [6] Commit all the directory entry updates in the fast commit space.
+ * [7] Commit all the changed inodes in the fast commit space and clear
+ *     "EXT4_STATE_FC_COMMITTING" for these inodes.
+ * [8] Write tail tag (this tag ensures the atomicity, please read the following
  *     section for more details).
- * [7] Wait for [4], [5] and [6] to complete.
  *
- * All the inode updates must call ext4_fc_start_update() before starting an
- * update. If such an ongoing update is present, fast commit waits for it to
- * complete. The completion of such an update is marked by
- * ext4_fc_stop_update().
+ * All the inode updates must be enclosed within jbd2_jounrnal_start()
+ * and jbd2_journal_stop() similar to JBD2 journaling.
  *
  * Fast Commit Ineligibility
  * -------------------------
@@ -143,6 +151,13 @@
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
@@ -157,13 +172,12 @@
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
2.49.0.1045.g170613ef41-goog


