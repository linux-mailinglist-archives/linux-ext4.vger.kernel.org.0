Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60D213A8
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2019 08:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfEQGT7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 May 2019 02:19:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39453 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfEQGT7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 May 2019 02:19:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so2786139pgi.6;
        Thu, 16 May 2019 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuFZm74Z9l79xdJ/4Cl+h92bWI5KTm3zMpzIFt8UcTc=;
        b=Fox3LYtQlUW/RHf9SwWPrSo2GXNwyu9Zt552dBGMs0u8IBCNHNEjr36P5WBXBvEOKR
         kPdgF4gEFz+qFGTGbp4v3lLawdbOB1fRL6XwN/HC8zQ7S2gcLiCum3/gOWz0wJtZn9O9
         0i+3fl6v+4hJKaNC280xfAbCRB/SNAIdYqY0t6npcXjwRbb1NY/GcgXhg6ClniKITqYQ
         /Ridv2I8OcNoMfeeaAKWjraeIjgmdSFhQIWJPzjHWjdShIMHKzLtSQZ0PRG79ZCVXZZZ
         3UO+W/LQL9LJpX+awK373z5wSX3DPG/Lm1A4VnBm+assU0qPFozAwNkwiXPcYsGt/zyl
         ThmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuFZm74Z9l79xdJ/4Cl+h92bWI5KTm3zMpzIFt8UcTc=;
        b=PXWcpGGX23SXqj0+DVWsZUu3XQMUVE8HZLCU3PBDzA3TRXj6/xLDnD53sZTbjDxW9F
         LStKOLDGaCh/zNqJzjX0sKsDqb9kxPiB9apWq4LORlCedfS7DSnHBoj8bjzOVGf63vTm
         Fz2rtSwto5DQi4pPmVavlaP1WTMobnebKXKAvbH3tG9NAn6w9amBI53hEukIcjl6IMwM
         TSsCeq6hPmqusY1sqWMHhHvU/Lhm2VQxd7uMXzAqXb44g+QtEqg2BfzTFLqHvjkA/eIg
         /aoQAf+cl4yTzgBbyxxh2yX5dRA+rdLpHHxpPTwaVqRgICwzfFIN6rua6g2f9GVSh4Hf
         7kGg==
X-Gm-Message-State: APjAAAV91KF3wkWv92AHDu7jXLHzvI19MnVEtLznCitFSXsbIj+xMw2M
        Y2hteielsEf2UYR6g6B/9wU5SHTYf7DEhA==
X-Google-Smtp-Source: APXvYqw+WA3bfurFok2ai8+oJuWkBrHiGtx4UAn3M/gDpJbWNusoI2ceJp9Piqiguu8FH3vSKiv1lg==
X-Received: by 2002:a63:7:: with SMTP id 7mr55679570pga.108.1558073998643;
        Thu, 16 May 2019 23:19:58 -0700 (PDT)
Received: from localhost.localdomain ([123.139.57.210])
        by smtp.gmail.com with ESMTPSA id 63sm9412858pfu.95.2019.05.16.23.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 23:19:58 -0700 (PDT)
From:   Gaowei Pu <pugaowei@gmail.com>
To:     tytso@mit.edu
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] jbd2: fix some print format mistakes
Date:   Fri, 17 May 2019 14:19:51 +0800
Message-Id: <20190517061951.13730-1-pugaowei@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There are some print format mistakes in debug messages. Fix them.

Signed-off-by: Gaowei Pu <pugaowei@gmail.com>
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

