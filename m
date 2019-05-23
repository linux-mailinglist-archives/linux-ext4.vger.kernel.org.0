Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF53F27457
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2019 04:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfEWC0W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 May 2019 22:26:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43065 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWC0W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 May 2019 22:26:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so2261093pgv.10;
        Wed, 22 May 2019 19:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nW+e1rPCq+HaAq+HDzDlhXWHIc2ch7yv53hl57cH94s=;
        b=IBud/dDNmkb2CKyRF+qnrkLEKivpBT51NpnCSYYi+tmggo/eEmSkaVHJQbqWL3qgTY
         /TwLuTJHggUyYDL4hO9FZbJQN2Y+6FYwMHeW9A+XsR+xXH/idJtcDY2GI/C/lici8Ah+
         M7AcRtqj2PxBYGT0ScNOfwLhQ2KSJwo8mYZvtwfc8t/IAoV0hLPVw7pUab0RfgqyqZkX
         1isREY21r66/YjNMMyCM7eoMNWmL9i1B3pxQVo1e4G5vyCMndSb5GDhNYG1jzbcZ8Jq0
         CSs8EmD0mSCP9f976tkbF2VHldZ1TXTusZdvXA9vgVTqj4sqDupVGQhYXYJIcSqEBvRe
         56wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nW+e1rPCq+HaAq+HDzDlhXWHIc2ch7yv53hl57cH94s=;
        b=ki9jL79Irjau6y8bROOjN94j9M0K4TcFkzLx95c967ACF3Qxugprz7e6Co3KHM23K4
         jCqVkLaqTPe/yJUzWb+ItMp3lJZVeBaTG1jd2tTfk5wXv7rW7ybLNS7WmeqjzC8QIaR/
         PaJf4tiTJ12nLMv7E2fPJc+vCD3c/oPrspz/YTZlQP70w/f2Ek4xYIIQroJciYfLd0KR
         SUo66QNonRQbfGDi+1Auql7aBab6PlY1fTtGkbtE0rU5idYK6pMNN92MAtgIvU7WkNtX
         K4249sPj6PkHRdT5Log03kVf8b5HOBVrlTtA/br3UA/7J0nOvs03xRWcyovDDIh+MXwj
         7nsQ==
X-Gm-Message-State: APjAAAV0czfOdrMgaCLs538hOCNyZa1uDnWN4iGuZJDhQ0sbquSMjZyX
        5e5t9GwKuy4BP3F+jsDKOecPI2TdliM=
X-Google-Smtp-Source: APXvYqylHSgH8QQKsP0a66EGksd9+DgjRpa3eK8Lc0JttTx6rug9I1jSz7asAoyO6+41AqHhjuR0Ew==
X-Received: by 2002:a62:3085:: with SMTP id w127mr76542997pfw.170.1558578381777;
        Wed, 22 May 2019 19:26:21 -0700 (PDT)
Received: from localhost.localdomain ([123.139.57.214])
        by smtp.gmail.com with ESMTPSA id s198sm35554384pfs.34.2019.05.22.19.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 19:26:21 -0700 (PDT)
From:   Gaowei Pu <pugaowei@gmail.com>
To:     tytso@mit.edu
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] jbd2: fix some print format mistakes
Date:   Thu, 23 May 2019 10:26:03 +0800
Message-Id: <20190523022603.13539-1-pugaowei@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There are some print format mistakes in debug messages. Fix them.

Signed-off-by: Gaowei Pu <pugaowei@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>

V2: add Reviewed-by.
---
 fs/jbd2/journal.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 37e16d969925..565e99b67b30 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -203,7 +203,7 @@ static int kjournald2(void *arg)
 	if (journal->j_flags & JBD2_UNMOUNT)
 		goto end_loop;
 
-	jbd_debug(1, "commit_sequence=%d, commit_request=%d\n",
+	jbd_debug(1, "commit_sequence=%u, commit_request=%u\n",
 		journal->j_commit_sequence, journal->j_commit_request);
 
 	if (journal->j_commit_sequence != journal->j_commit_request) {
@@ -324,7 +324,7 @@ static void journal_kill_thread(journal_t *journal)
  * IO is in progress. do_get_write_access() handles this.
  *
  * The function returns a pointer to the buffer_head to be used for IO.
- * 
+ *
  *
  * Return value:
  *  <0: Error
@@ -500,7 +500,7 @@ int __jbd2_log_start_commit(journal_t *journal, tid_t target)
 		 */
 
 		journal->j_commit_request = target;
-		jbd_debug(1, "JBD2: requesting commit %d/%d\n",
+		jbd_debug(1, "JBD2: requesting commit %u/%u\n",
 			  journal->j_commit_request,
 			  journal->j_commit_sequence);
 		journal->j_running_transaction->t_requested = jiffies;
@@ -513,7 +513,7 @@ int __jbd2_log_start_commit(journal_t *journal, tid_t target)
 		WARN_ONCE(1, "JBD2: bad log_start_commit: %u %u %u %u\n",
 			  journal->j_commit_request,
 			  journal->j_commit_sequence,
-			  target, journal->j_running_transaction ? 
+			  target, journal->j_running_transaction ?
 			  journal->j_running_transaction->t_tid : 0);
 	return 0;
 }
@@ -698,12 +698,12 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
 #ifdef CONFIG_JBD2_DEBUG
 	if (!tid_geq(journal->j_commit_request, tid)) {
 		printk(KERN_ERR
-		       "%s: error: j_commit_request=%d, tid=%d\n",
+		       "%s: error: j_commit_request=%u, tid=%u\n",
 		       __func__, journal->j_commit_request, tid);
 	}
 #endif
 	while (tid_gt(tid, journal->j_commit_sequence)) {
-		jbd_debug(1, "JBD2: want %d, j_commit_sequence=%d\n",
+		jbd_debug(1, "JBD2: want %u, j_commit_sequence=%u\n",
 				  tid, journal->j_commit_sequence);
 		read_unlock(&journal->j_state_lock);
 		wake_up(&journal->j_wait_commit);
@@ -944,7 +944,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
 
 	trace_jbd2_update_log_tail(journal, tid, block, freed);
 	jbd_debug(1,
-		  "Cleaning journal tail from %d to %d (offset %lu), "
+		  "Cleaning journal tail from %u to %u (offset %lu), "
 		  "freeing %lu\n",
 		  journal->j_tail_sequence, tid, block, freed);
 
@@ -1318,7 +1318,7 @@ static int journal_reset(journal_t *journal)
 	 */
 	if (sb->s_start == 0) {
 		jbd_debug(1, "JBD2: Skipping superblock update on recovered sb "
-			"(start %ld, seq %d, errno %d)\n",
+			"(start %ld, seq %u, errno %d)\n",
 			journal->j_tail, journal->j_tail_sequence,
 			journal->j_errno);
 		journal->j_flags |= JBD2_FLUSHED;
@@ -1453,7 +1453,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 		return;
 	}
 
-	jbd_debug(1, "JBD2: Marking journal as empty (seq %d)\n",
+	jbd_debug(1, "JBD2: Marking journal as empty (seq %u)\n",
 		  journal->j_tail_sequence);
 
 	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
-- 
2.21.0

