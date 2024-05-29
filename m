Return-Path: <linux-ext4+bounces-2688-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C299A8D29DE
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38ECE1F259DC
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6A615AD95;
	Wed, 29 May 2024 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdR+LMod"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D215A862
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945649; cv=none; b=dSRsvR/1AckBWTz9Zjozg71A17ARHIkBMzsT1lRdVjtsY3VnfmXTIgnI+8ZsiSVIEYWB3HuhHL18iiF46UaQgTrmFX4+AJT7wyt2WtlclbQcNuITjK2+J59j9S0TmvZX22OIBTpIXCAuzm3ZETUZ8qjs3vR2yvktKPvT6Po7kCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945649; c=relaxed/simple;
	bh=2LjMOOdwCaq2f8AXla3z/nxLp8FAHRkWrf1X1AMlyog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlxS1q2+vRNHM+7HfTKLeJ4+4yr83kFkJ4n6GSBvH/nvakY7st8lrznYo8M9vAOm/xt9mc2hDlemXM+AWFkWcHtquVkJaAHPzAvXQs/NQYmq9DEnHBqIbNB7kL1w923N5SiBtYtrDLw0Lb+6fHg1dK2Vf/4MZco9/H6DW1cocn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdR+LMod; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-701ae8698d8so1203421b3a.0
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 18:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716945647; x=1717550447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk1zOlPM5uCYCDX0J2Mswhw9r0DOdP5uOQ3TU9dpH6w=;
        b=fdR+LModQ1YQAyZR16X7qupu+P4YO1NUexX4iv3HE/l/b0kFlgWfPQ7lPQtG55+UNp
         OM6IaOnmi54IHuft/wvTQqa3aIhSpCsGI5yIr0veMKuEHBy9XSO6+1bZGlw3mJPuJ60U
         0NCRSbe6vTchgOhiWCv0UbpM7FdFVLx/w1NdkZAxkrjnJ+yp4xjSLpMCr0NNDT9GpjET
         bwg6sHkvCd4mQ95tAC/o4ZA151R87TealeLUzjKIFo/7n1Q0cvX0WUWq+oCwQDB5dDB9
         hOX1h3BqSqzhlYLHcp13PDwHSeeJG/DDYl5p5aXQGM8wNd4+G9IHtuhJPsr5JIuk+/Tk
         2p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945647; x=1717550447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zk1zOlPM5uCYCDX0J2Mswhw9r0DOdP5uOQ3TU9dpH6w=;
        b=Jv/nnhCm+dhcAaswFok5eFqFRCXA8napYDJxyXJomlqzTFOdspa3rcEhfK+RkRxGfx
         3U3Y1pWzO1Lj2asfMByGfJYLgYyZ1dykSobigMd4AFx/QhKiHuPmaGRWV5lr8Y4ith0C
         LrEapUgCmaiJYaKKpN3XWPpd0VkCdCifo9aYQmZ8ugp83zSRQiCkLSNnEsvLzAlCsM+z
         0j3w1RR25z1Z6rvrrlgOc6k3gQ5UFeGQZH1xW+Z1DLre0f3awManFTZmDPV81FKSPzg7
         BuV+NPxILV4o+xJclQ9nEixOcuoVEFXfCO91yomhMGRn+JaSeVMqMWuZq6aWgQSRtiQU
         2wsA==
X-Gm-Message-State: AOJu0Yy4RryTf9HqeJDs/4mHF307HAZ6luN+wQ4/vWt6LBZK98hfrSir
	tuRxJfkN/rBKqBEunIcUOzfVsBwgR6iUq4rxyMWWD7qUKBemAclO0RPUjnuZ
X-Google-Smtp-Source: AGHT+IEK6FmImKwsCDhJTMOSDqNtAASS6G+IU1pOAAGeOCU4xXqK7QrQi90OksOltz0ZAxGOQFMVEg==
X-Received: by 2002:a05:6a20:de14:b0:1b1:d402:a93f with SMTP id adf61e73a8af0-1b212df0551mr11647152637.37.1716945647451;
        Tue, 28 May 2024 18:20:47 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm10139388a91.53.2024.05.28.18.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:20:47 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v6 06/10] ext4: update code documentation
Date: Wed, 29 May 2024 01:19:59 +0000
Message-ID: <20240529012003.4006535-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
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
index ecbbcaf78598..b81b0292aa59 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -49,14 +49,21 @@
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
@@ -142,6 +149,13 @@
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
@@ -156,13 +170,12 @@
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
2.45.1.288.g0e0cd299f1-goog


