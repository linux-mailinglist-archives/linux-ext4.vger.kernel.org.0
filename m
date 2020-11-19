Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A16F2B9E5B
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 00:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgKSX2e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Nov 2020 18:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKSX2e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Nov 2020 18:28:34 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38568C0613CF
        for <linux-ext4@vger.kernel.org>; Thu, 19 Nov 2020 15:28:34 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id v5so1987303pff.10
        for <linux-ext4@vger.kernel.org>; Thu, 19 Nov 2020 15:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vb1OanQsRFdt0Z/XTLPyUnfs4/8fRzy4x7Hkc9fDEuM=;
        b=UQiv5k++ZldO75h8/b5s8WvXOjRjLEuabk30j0G1EbKaOWLdmXJpjirhqNzlIUlUOj
         FXkSTM9QCg1RE9qzCk8HPk4B5n+kOYY54p2wc89Qmn4fg8v8ve1u+qmPjme1CUa+pZt3
         rjjInV6lW9lEauQ/Zp+uxbcfQqLZvu79bAPcPS9n4fIkRvZ4u1FmaxQAWL61iLGaV19V
         oP8MqLdJFK8VNC8dixbPadXuJ8yLXJ3YpU8UAZ7w1gXeWuI2oWf4dGRDZwow14youDli
         vh2CFGOJYAr9RLaASqoRL3O0bcRTX9wCxCj1s4PxwYEi+x3kFq764MAE6+B5BZEK/aG6
         2png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vb1OanQsRFdt0Z/XTLPyUnfs4/8fRzy4x7Hkc9fDEuM=;
        b=Afi+bEHR1xSCqB5E0nojgVqN3TeiIauUng+Ej8eNrXtc1WKY5PYS1tEoYYDINf5Ysp
         u7aUABrZJciypyO943sBsIcozyTIQVom3R05cnqHk2iBWnN3I29LuUoZsSMjUnOJI2Y2
         2gUtvDBHXQNk3k/AKoHUhCX/asnf0hDNtQsUMKuxOxONVFfLBb2fmmiZM8qND/95WXD6
         4HtyI5F2MZX6oM/l7P1NYnNRsodiwevWvS0yT/Tt5tMeYgGwtzssg1onQwPNWxoE3tYl
         3q/t2TZ8N7YmVqM31J6bdwT88Zs0oHhtfyR7I0ALuyYz15uKbuHRxeVbpGJy5blqAU0f
         5PpA==
X-Gm-Message-State: AOAM533Nrm7Evx/lkai1mFWnsb08HCtqcf5Y1APhbVpMKQT7NmXlaJQ8
        gRQFHroPo+kiTqf3ZIYEyFrP5Tx62FE=
X-Google-Smtp-Source: ABdhPJyo3QHK6G2WIQTw7lmvInB+t1VNdsikGsb0lf8aV4XY2KMSxlsuoFMrMTgRhZh3jTekwEdiGw==
X-Received: by 2002:a63:4d07:: with SMTP id a7mr15249227pgb.274.1605828513092;
        Thu, 19 Nov 2020 15:28:33 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id f16sm819480pgk.48.2020.11.19.15.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:28:32 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: add docs about fast commit idempotence
Date:   Thu, 19 Nov 2020 15:28:22 -0800
Message-Id: <20201119232822.1860882-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fast commit on-disk format is designed such that the replay of these
tags can be idempotent. This patch adds documentation in the code in
form of comments and in form kernel docs that describes these
characteristics. This patch also adds a TODO item needed to ensure
kernel fast commit replay idempotence.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 Documentation/filesystems/ext4/journal.rst | 50 ++++++++++++++++++
 fs/ext4/fast_commit.c                      | 61 ++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index 849d5b119eb8..cdbfec473167 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -681,3 +681,53 @@ Here is the list of supported tags and their meanings:
      - Stores the TID of the commit, CRC of the fast commit of which this tag
        represents the end of
 
+Fast Commit Replay Idempotence
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Fast commits tags are idempotent in nature provided the recovery code follows
+certain rules. The guiding principle that the commit path follows while
+committing is that it stores the result of a particular operation instead of
+storing the procedure.
+
+Let's consider this rename operation: 'mv /a /b'. Let's assume dirent '/a'
+was associated with inode 10. During fast commit, instead of storing this
+operation as a procedure "rename a to b", we store the resulting file system
+state as a "series" of outcomes:
+
+- Link dirent b to inode 10
+- Unlink dirent a
+- Inode 10 with valid refcount
+
+Now when recovery code runs, it needs "enforce" this state on the file
+system. This is what guarantees idempotence of fast commit replay.
+
+Let's take an example of a procedure that is not idempotent and see how fast
+commits make it idempotent. Consider following sequence of operations:
+
+1) rm A
+2) mv B A
+3) read A
+
+If we store this sequence of operations as is then the replay is not idempotent.
+Let's say while in replay, we crash after (2). During the second replay,
+file A (which was actually created as a result of "mv B A" operation) would get
+deleted. Thus, file named A would be absent when we try to read A. So, this
+sequence of operations is not idempotent. However, as mentioned above, instead
+of storing the procedure fast commits store the outcome of each procedure. Thus
+the fast commit log for above procedure would be as follows:
+
+(Let's assume dirent A was linked to inode 10 and dirent B was linked to
+inode 11 before the replay)
+
+1) Unlink A
+2) Link A to inode 11
+3) Unlink B
+4) Inode 11
+
+If we crash after (3) we will have file A linked to inode 11. During the second
+replay, we will remove file A (inode 11). But we will create it back and make
+it point to inode 11. We won't find B, so we'll just skip that step. At this
+point, the refcount for inode 11 is not reliable, but that gets fixed by the
+replay of last inode 11 tag. Thus, by converting a non-idempotent procedure
+into a series of idempotent outcomes, fast commits ensured idempotence during
+the replay.
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f2033e13a273..b4bc8bf307c9 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -103,8 +103,69 @@
  *
  * Replay code should thus check for all the valid tails in the FC area.
  *
+ * Fast Commit Replay Idempotence
+ * ------------------------------
+ *
+ * Fast commits tags are idempotent in nature provided the recovery code follows
+ * certain rules. The guiding principle that the commit path follows while
+ * committing is that it stores the result of a particular operation instead of
+ * storing the procedure.
+ *
+ * Let's consider this rename operation: 'mv /a /b'. Let's assume dirent '/a'
+ * was associated with inode 10. During fast commit, instead of storing this
+ * operation as a procedure "rename a to b", we store the resulting file system
+ * state as a "series" of outcomes:
+ *
+ * - Link dirent b to inode 10
+ * - Unlink dirent a
+ * - Inode <10> with valid refcount
+ *
+ * Now when recovery code runs, it needs "enforce" this state on the file
+ * system. This is what guarantees idempotence of fast commit replay.
+ *
+ * Let's take an example of a procedure that is not idempotent and see how fast
+ * commits make it idempotent. Consider following sequence of operations:
+ *
+ *     rm A;    mv B A;    read A
+ *  (x)     (y)        (z)
+ *
+ * (x), (y) and (z) are the points at which we can crash. If we store this
+ * sequence of operations as is then the replay is not idempotent. Let's say
+ * while in replay, we crash at (z). During the second replay, file A (which was
+ * actually created as a result of "mv B A" operation) would get deleted. Thus,
+ * file named A would be absent when we try to read A. So, this sequence of
+ * operations is not idempotent. However, as mentioned above, instead of storing
+ * the procedure fast commits store the outcome of each procedure. Thus the fast
+ * commit log for above procedure would be as follows:
+ *
+ * (Let's assume dirent A was linked to inode 10 and dirent B was linked to
+ * inode 11 before the replay)
+ *
+ *    [Unlink A]   [Link A to inode 11]   [Unlink B]   [Inode 11]
+ * (w)          (x)                    (y)          (z)
+ *
+ * If we crash at (z), we will have file A linked to inode 11. During the second
+ * replay, we will remove file A (inode 11). But we will create it back and make
+ * it point to inode 11. We won't find B, so we'll just skip that step. At this
+ * point, the refcount for inode 11 is not reliable, but that gets fixed by the
+ * replay of last inode 11 tag. Crashes at points (w), (x) and (y) get handled
+ * similarly. Thus, by converting a non-idempotent procedure into a series of
+ * idempotent outcomes, fast commits ensured idempotence during the replay.
+ *
  * TODOs
  * -----
+ *
+ * 0) Fast commit replay path hardening: Fast commit replay code should use
+ *    journal handles to make sure all the updates it does during the replay
+ *    path are atomic. With that if we crash during fast commit replay, after
+ *    trying to do recovery again, we will find a file system where fast commit
+ *    area is invalid (because new full commit would be found). In order to deal
+ *    with that, fast commit replay code should ensure that the "FC_REPLAY"
+ *    superblock state is persisted before starting the replay, so that after
+ *    the crash, fast commit recovery code can look at that flag and perform
+ *    fast commit recovery even if that area is invalidated by later full
+ *    commits.
+ *
  * 1) Make fast commit atomic updates more fine grained. Today, a fast commit
  *    eligible update must be protected within ext4_fc_start_update() and
  *    ext4_fc_stop_update(). These routines are called at much higher
-- 
2.29.2.454.gaff20da3a2-goog

