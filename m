Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9888C1A2B7E
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgDHVzt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33510 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgDHVzt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id c138so3733742pfc.0
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nn0lXFt10mUg8QLw79Kr79Dzre7UK9mmCWBrt3nmavU=;
        b=r3mquR0Hdxfj8up8JzU/PxZ/4X58bl9OLg4somTtkwPkksHJIGc0e4thrmNOhroEyx
         MlM+GU+Rec22UfjyjkYVRPx/oIAka0xxyUnySw6fZoJkXhj6/Vi8UfOIx+I9kqsJhwM6
         w55GCZ4gKGZEaCg7xnD6SWelO6c9pMLa94JCK3YgVhyPrCGuobZ6PDsNealMv37XOEDk
         5KeBtIezHbPNy+byr7EeUOTP7ftg2tOt9OocdUhTgBo3PyNqEtSvf2WaRFhwbXmCceYv
         sbML0eJgbA+C8CWj0q7f6hagvlfvJwNbkVrlC8XMVQYxADXfj/u96c55Lvq9ACdcjWdv
         H8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nn0lXFt10mUg8QLw79Kr79Dzre7UK9mmCWBrt3nmavU=;
        b=MaDguo83vm5MntTzqLiaB7Ze95oRoO2k4Nn8k7YcBxYqKU/NnkSRhtpMuyjwGNrPrd
         R57WmPEkWXtTyXHWDQ7bAnSO3DnTiWSAN2xThoGZo5NXAj6XTkmNEO+O2Noats8rz4Td
         yWpzhh5L7qpdZuOgpB+veA7lT4KWcH6uvltw5KViOZso+T2WSpafxhqceU8QWmOVBQaH
         MWYo/bMG2EKRV6Gg3RvKkEjb6LLEKIk4bTHpBU1L6gsuPPxKeIJ6AXmSI5390MpHX7yG
         h3vrVlNO/i4t9edV5zryyWUWwuvNE9yoz6SFnYzFF7NK8mXqUTjkz9IYyTPBv8VhsjMM
         BIxA==
X-Gm-Message-State: AGi0PuaWh2Bb8ogEW9sjw6wS6gmX4PW4JKjnTTDfrThrbSgvvJxpMdG5
        Vda0pAS6A6iYRV1fczTYp7EmI8O7
X-Google-Smtp-Source: APiQypJtgngKI3YSPR2H2KAhHTcc4aqxFcfutNGOJqa5jBThzTDScVCB7ysoA5jTGBIek9eIcn16Ww==
X-Received: by 2002:a63:4463:: with SMTP id t35mr9024769pgk.412.1586382947456;
        Wed, 08 Apr 2020 14:55:47 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:47 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 04/20] jbd2: add fast commit block tracker variables
Date:   Wed,  8 Apr 2020 14:55:14 -0700
Message-Id: <20200408215530.25649-4-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

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
2.26.0.110.g2183baf09c-goog

