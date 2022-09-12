Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560975B5FBB
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Sep 2022 20:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiILSB4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Sep 2022 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiILSBy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Sep 2022 14:01:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4683FA06
        for <linux-ext4@vger.kernel.org>; Mon, 12 Sep 2022 11:01:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f14so15196780lfg.5
        for <linux-ext4@vger.kernel.org>; Mon, 12 Sep 2022 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Z86qpq+XFA5fzWvLRUHop8PV1aJcTMRXZA4n/cCWbVY=;
        b=U9YR/T0LU3zxxD0ezbpN0n+uVneoQjdynRjcGg33t14xn5vTelFtx+hOrRBPjRSrR+
         YyIQFdlkgHUhHUTClw1nCTcJUFjwhgKdNIqIKlfB03WAJNWk5AqVgwDOvIs92ESlTT4o
         iPhQz6qySxnZKQ1C8qiblGA0kmHeVuMcXP6CmE0gv9VCTJwVQHhRTA9ssehnM9ZZp45F
         wicfa2ugC98j0UHEPjYaIWIoueP1N+WA99t4tyo4w4X7RWuTbujRh/qQWDkIDboKQiy+
         lbppZCiTWSA6S1u2L0MCVCa4tCMisxMyJbhWJHIRqTdrF4lFNfUFOn1kgHdfJgLXWPtx
         G9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Z86qpq+XFA5fzWvLRUHop8PV1aJcTMRXZA4n/cCWbVY=;
        b=NRLIjDwTibTlyuoxv2q9j8bwmbaMelJ4Kqo27aaGEXi9HousBD1YvVyPuwuLt9L1vv
         fl3of8AU27TXjdNZnyhErYQNiiEg1m+z0khdAcVK5bdD0NQNZ0pSByJ2YdmDiuaKkGKC
         1pQr8r5yL+8rUDLvsSf2WJaCnnVHVHqpNwGZ6zukbzrTilqb71v2Ly2BP3RtJ894gdzN
         JWUzXXP8rIFbVSRhF1KCoIHPe6rnf1qBF/Rw+b2JPfpp6ywyJhnKgFrNI3mqXWCzRG7F
         IdPtBH7NqrrJ6uu0zsTX/dh2oW8xKuxhuq7Yqi4qNKdeeyEptoO26ZRVImdvAoIP1jU9
         AISA==
X-Gm-Message-State: ACgBeo0+XwNHoKkLF0tT4kvC0NVvj/TRHGL7VOjJQpqO0T+0YJHo5bcx
        8UKMYyQIy5L8PPQs/qOCirTUpOnK/OhYy1d8
X-Google-Smtp-Source: AA6agR6ZzNOxdJ1jV/BwHOhCuuxCC486cdGgMGArbZY5B7EhVZyE7eoliLxu4F7qgZ5af48pxTjDag==
X-Received: by 2002:a05:6512:3a8e:b0:49a:e5ed:d6aa with SMTP id q14-20020a0565123a8e00b0049ae5edd6aamr1331054lfu.271.1663005711563;
        Mon, 12 Sep 2022 11:01:51 -0700 (PDT)
Received: from lustre.shadowland ([46.246.26.67])
        by smtp.gmail.com with ESMTPSA id cf11-20020a056512280b00b00499b232875dsm1101749lfb.171.2022.09.12.11.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:01:51 -0700 (PDT)
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     Andrew Perepechko <anserper@ya.ru>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Alexey Lyashkov <alexey.lyashkov@gmail.com>
Subject: [PATCH] jbd2: wake up journal waiters in FIFO order, not  LIFO
Date:   Mon, 12 Sep 2022 21:01:37 +0300
Message-Id: <20220912180137.2308900-1-alexey.lyashkov@gmail.com>
X-Mailer: git-send-email 2.31.1
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

From: Andrew Perepechko <anserper@ya.ru>

LIFO wakeup order is unfair and sometimes leads to a journal
user not being able to get a journal handle for hundreds of
transactions in a row.

FIFO wakeup can make things more fair.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Alexey Lyashkov <alexey.lyashkov@gmail.com>
---
 fs/jbd2/commit.c      | 2 +-
 fs/jbd2/transaction.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index b2b2bc9b88d9..ec2b55879e3a 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -570,7 +570,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	journal->j_running_transaction = NULL;
 	start_time = ktime_get();
 	commit_transaction->t_log_start = journal->j_head;
-	wake_up(&journal->j_wait_transaction_locked);
+	wake_up_all(&journal->j_wait_transaction_locked);
 	write_unlock(&journal->j_state_lock);
 
 	jbd2_debug(3, "JBD2: commit phase 2a\n");
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index e1be93ccd81c..6a404ac1c178 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -168,7 +168,7 @@ static void wait_transaction_locked(journal_t *journal)
 	int need_to_start;
 	tid_t tid = journal->j_running_transaction->t_tid;
 
-	prepare_to_wait(&journal->j_wait_transaction_locked, &wait,
+	prepare_to_wait_exclusive(&journal->j_wait_transaction_locked, &wait,
 			TASK_UNINTERRUPTIBLE);
 	need_to_start = !tid_geq(journal->j_commit_request, tid);
 	read_unlock(&journal->j_state_lock);
@@ -194,7 +194,7 @@ static void wait_transaction_switching(journal_t *journal)
 		read_unlock(&journal->j_state_lock);
 		return;
 	}
-	prepare_to_wait(&journal->j_wait_transaction_locked, &wait,
+	prepare_to_wait_exclusive(&journal->j_wait_transaction_locked, &wait,
 			TASK_UNINTERRUPTIBLE);
 	read_unlock(&journal->j_state_lock);
 	/*
@@ -920,7 +920,7 @@ void jbd2_journal_unlock_updates (journal_t *journal)
 	write_lock(&journal->j_state_lock);
 	--journal->j_barrier_count;
 	write_unlock(&journal->j_state_lock);
-	wake_up(&journal->j_wait_transaction_locked);
+	wake_up_all(&journal->j_wait_transaction_locked);
 }
 
 static void warn_dirty_buffer(struct buffer_head *bh)
-- 
2.31.1

