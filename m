Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2340317D986
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgCIHGC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:02 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50960 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIHGA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:00 -0400
Received: by mail-pj1-f66.google.com with SMTP id u10so2328563pjy.0
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjXfTLbEe4vVlIPWfAun+iUDqJXQNxE0BDamGQeJ3ck=;
        b=tFUO/BCtL5HL+T1tC/AoBy/jlCGwLkheTA5b4V+l2+n1Z83oB6FeGLhmQbkJKzwnZ/
         HfPliBvn9M4OkLYgUsDYDUjMerENNNQhW6bggLTtNSioIV7SK7eQ/6g4DuV9HwjeYAjH
         dU3gil3039wA5USoB4+vjaOgF0c2yVpYTDedB+Y2hWb1w2pAMbxAq+17Z5b9LFzRP1RW
         1sI2hQ8v7E0rCCWT8lqnAuwldijnpSByDDoOllaoxROPzOghgnAnhKsxa42e5CZ5mgLm
         /bGSnEzPWBZ9zYYziDkaNpGw9aG6f07dwZh+qdGvfA5ZIojbFu0pFe4JjROSaWZ3GGKA
         QMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjXfTLbEe4vVlIPWfAun+iUDqJXQNxE0BDamGQeJ3ck=;
        b=Mw1gDYavAtDepIq6/gvJ5VoNq9m251Gd3r5323dPlU8jfkObyGrke1mqk4XbTmTOYd
         m1Cuy6kL2iwvtMW0sQz6PaFSq8/sVYEtwijft2BOT/rUjbYplYm677tCceA1cVStTc2K
         pnPZIRJ8NZO8l9Af9DGsQDOXOT9fRHwLL7NCZCKCAkX30OawwfwY1vkPeVCMiYDbKGxo
         zXDge+E+kSLPtGv/cwFBZaWE1vIUYFks1Fh/qYQQz7mTlaTI3NOI9RHxtJ0GriSB7kLP
         HoU/yKOfK4lz8bnKg5vzXujYtbvQoYuX+EWrRMVJIo1ez5O/Wi1DBWUw3PlWl6/WBnJK
         0wrQ==
X-Gm-Message-State: ANhLgQ11N/cySIca+ubRmPOeCfEfGZF1CouL+0sk9eGlz5XOTuuvIMAz
        9hRzvVT7TiaItKxYDKrRWjCwBSuu
X-Google-Smtp-Source: ADFU+vv74Nf7U5rj412Q03M/BJdANLdZXWz/Ns1KatdEdZ9y3lryqDyDIEi3Ud+MU9V5FJ9PzLWumg==
X-Received: by 2002:a17:902:a711:: with SMTP id w17mr14900103plq.152.1583737559014;
        Mon, 09 Mar 2020 00:05:59 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:05:58 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 04/20] jbd2: add fast commit block tracker variables
Date:   Mon,  9 Mar 2020 00:05:10 -0700
Message-Id: <20200309070526.218202-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add j_first_fc, j_last_fc and j_fc_offset variables to track fast commit
area. j_first_fc and j_last_fc mark the start and the end of the area,
while j_fc_offset points to the last used block in the region.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c    | 33 ++++++++++++++++++++++++++++-----
 include/linux/jbd2.h | 24 ++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 4e5d41d79b24..79f015f7bf54 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1178,6 +1178,11 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	if (!journal->j_wbuf)
 		goto err_cleanup;
 
+	if (journal->j_fc_wbufsize > 0) {
+		journal->j_wbufsize = n - journal->j_fc_wbufsize;
+		journal->j_fc_wbuf = &journal->j_wbuf[journal->j_wbufsize];
+	}
+
 	bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
 	if (!bh) {
 		pr_err("%s: Cannot get buffer for journal superblock\n",
@@ -1321,11 +1326,20 @@ static int journal_reset(journal_t *journal)
 	}
 
 	journal->j_first = first;
-	journal->j_last = last;
 
-	journal->j_head = first;
-	journal->j_tail = first;
-	journal->j_free = last - first;
+	if (jbd2_has_feature_fast_commit(journal) &&
+	    journal->j_fc_wbufsize > 0) {
+		journal->j_last_fc = last;
+		journal->j_last = last - journal->j_fc_wbufsize;
+		journal->j_first_fc = journal->j_last + 1;
+		journal->j_fc_off = 0;
+	} else {
+		journal->j_last = last;
+	}
+
+	journal->j_head = journal->j_first;
+	journal->j_tail = journal->j_first;
+	journal->j_free = journal->j_last - journal->j_first;
 
 	journal->j_tail_sequence = journal->j_transaction_sequence;
 	journal->j_commit_sequence = journal->j_transaction_sequence - 1;
@@ -1667,9 +1681,18 @@ static int load_superblock(journal_t *journal)
 	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
 	journal->j_tail = be32_to_cpu(sb->s_start);
 	journal->j_first = be32_to_cpu(sb->s_first);
-	journal->j_last = be32_to_cpu(sb->s_maxlen);
 	journal->j_errno = be32_to_cpu(sb->s_errno);
 
+	if (jbd2_has_feature_fast_commit(journal) &&
+	    journal->j_fc_wbufsize > 0) {
+		journal->j_last_fc = be32_to_cpu(sb->s_maxlen);
+		journal->j_last = journal->j_last_fc - journal->j_fc_wbufsize;
+		journal->j_first_fc = journal->j_last + 1;
+		journal->j_fc_off = 0;
+	} else {
+		journal->j_last = be32_to_cpu(sb->s_maxlen);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 3bd1431cb222..1fc981cca479 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -910,6 +910,30 @@ struct journal_s
 	 */
 	unsigned long		j_last;
 
+	/**
+	 * @j_first_fc:
+	 *
+	 * The block number of the first fast commit block in the journal
+	 * [j_state_lock].
+	 */
+	unsigned long		j_first_fc;
+
+	/**
+	 * @j_fc_off:
+	 *
+	 * Number of fast commit blocks currently allocated.
+	 * [j_state_lock].
+	 */
+	unsigned long		j_fc_off;
+
+	/**
+	 * @j_last_fc:
+	 *
+	 * The block number one beyond the last fast commit block in the journal
+	 * [j_state_lock].
+	 */
+	unsigned long		j_last_fc;
+
 	/**
 	 * @j_dev: Device where we store the journal.
 	 */
-- 
2.25.1.481.gfbce0eb801-goog

