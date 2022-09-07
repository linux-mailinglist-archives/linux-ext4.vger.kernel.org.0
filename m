Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BE95B0ADC
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Sep 2022 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiIGRA0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Sep 2022 13:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGRA0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Sep 2022 13:00:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD036C131
        for <linux-ext4@vger.kernel.org>; Wed,  7 Sep 2022 10:00:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x14so8045006lfu.10
        for <linux-ext4@vger.kernel.org>; Wed, 07 Sep 2022 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=YxYyEpXTezQXVffhIeYXtYjNeSo7ODcPJSN5kU6n0fI=;
        b=Ocw5LCvYnCHvG4q9hOFGAfFWdx5F96sf89u08WUCVmfSueuA9NUz+/zkqvr1hLofVN
         iQDrpDsZj6jZOeuQwUX09wLVOVlO7xkqQCsnRn2Rj1yUPxLbhV72Tzx08EarJJK5Dbfi
         cb+VSr6JrtBEcOBVHXdU1ynGqjaTx97kgpCy5iKQhHnWAiWsK3JNLaSUOcswA5mSZOFE
         GNTjkIK82k1z9d9rk30cojMwjJZR1IFAfJ8WDsO5uJQC+JunqLqBvEfXUJ+hKojuFM4L
         n4GibHi4IBZR7f9hyN1RXoCLY5hbCdB+4n8xTE5i2an/kSJN0mNkqg3jsZQbJ03NRb5R
         VF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YxYyEpXTezQXVffhIeYXtYjNeSo7ODcPJSN5kU6n0fI=;
        b=2/8NrvF4mxfIZ+jlKA34Vkuk5R0AAU8SQcA8aqFcOlw0cxlQdFxx24O8Z4p4b9u/AC
         Ss/pi7eBnFZlHgjG1+VfmgZ56sf24IFGkUnylYKxeAzfiSmSRTt819c57sJCMS1zcgZd
         3CTfDiPSpkcx9HZon344VWicajkgYYOsfP5LAzeME6j6D3K78JgeMP4KZHT3PaYLC1kX
         /RgoLGxg6GILPEpxoNfWdCR4Dy2Ub7YTRtxkQLj8D2q9EVumfYaJH/APfEHO6YIc7Lln
         D0lEpxDd8qVZ2dDf4VShBTdreFsZ4+oAHetNKq1hHWf37jYAHcrKLX2ypeWIccfpuxd0
         BpLQ==
X-Gm-Message-State: ACgBeo2kYnrxvghml8vaY9rUhbiIgdvygPJTBJmqWmMo4Qan7VvwsJmX
        Fm1KXxD2vdUjtkH1sMbjRKmmstJRYwiknQ==
X-Google-Smtp-Source: AA6agR65kK61d9HWOapDo5xUChRrpvh7cdL4whnqObUwK7pfM+CAlzgnlmtfr91xO3CCgz1xq7Mgtg==
X-Received: by 2002:a05:6512:ad3:b0:492:d78f:2c09 with SMTP id n19-20020a0565120ad300b00492d78f2c09mr1319917lfu.99.1662570023192;
        Wed, 07 Sep 2022 10:00:23 -0700 (PDT)
Received: from lustre.shadowland ([46.246.26.67])
        by smtp.gmail.com with ESMTPSA id 18-20020a2eb952000000b00268335eaa8asm2781829ljs.51.2022.09.07.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:00:20 -0700 (PDT)
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     Andrew Perepechko <anserper@ya.ru>,
        Alexey Lyashkov <alexey.lyashkov@gmail.com>
Subject: [PATCH] jbd2: wake up journal waiters in FIFO order, not  LIFO
Date:   Wed,  7 Sep 2022 19:59:59 +0300
Message-Id: <20220907165959.1137482-1-alexey.lyashkov@gmail.com>
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

