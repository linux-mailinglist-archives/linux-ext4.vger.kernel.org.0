Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA06F82B
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 06:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfGVECR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 00:02:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38012 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfGVECR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 00:02:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so16714749pfn.5
        for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2019 21:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJ06wLAoc93T2zJLDjet6UoqPS3jlCdAc99zjZMvBAU=;
        b=ndPpUtgcO/CePzXDJF19xZ347C8DYqBjM4C0l+JHfKfT8WnRiC9a1ckue/A1zIYJZi
         y0fTJA4trd9Rm/f3sAxXF3bOK+dAD+AqMO9jCeFg+thpuUQp8GmZCoO0ln1eWfXJOroN
         6EGIH9iMqfKiP2ri1qiYsYnY/PF1vtBZBIXWjOBMmlJpj+rUsoSm0Zojn/3JkYYohiGJ
         snZjRxuL9Pxv8Drsw/sKLMg6oiJNWRQFYe+ibC0vqLHsIaSgpw9V7Y/+HjPmQLLMnrja
         aw764l9Dct2u6F8XT3C5L+P6UtcczDuiTw1Q1dUA/WkLEU56gLrapA43b55SgR7OqhXz
         ldXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJ06wLAoc93T2zJLDjet6UoqPS3jlCdAc99zjZMvBAU=;
        b=d2Iws5RRFfL9QiomlaTDknCxK99AM6WvfiGMoL6Ke30dxGh5yED73BRECzVTme8uHF
         HgIkKLcr/ZDxPfz+XCzS7wjAc1fe9Z3qqlU16t17At2R1+HEA09VCNUQg6v58aqNbqJp
         peqCpjo8Xn8HVr6RE4iVNmKWPmd3nS9Sv0788z4675e3OTytpC9u24G2Twh8FtNyovzP
         Ar05zyMJ8qSk4DQ8+tHZV5f93nvN2pFgsBT5oGS+v59f4Pt52aoiw8bbQ1kmHWxJvQEw
         hcxiSH6IzQFrElyW0kg6Id+Da4H3l1GFG87uyAVd5J5j0Cb7XbWFr2y6Cc2VjxyJLYVD
         Lj2w==
X-Gm-Message-State: APjAAAX5Hro5b2aGJGA+ngLYIFVNF/Eq4FeDsTUqpuV6DQMgbeLSme/l
        kjzWH3UuFT08CXO90l9Vg6Qezc2S
X-Google-Smtp-Source: APXvYqzixb9rzacaS21RZ2Ku4WBo3OEuYrt3PBXwMpkekuWp+Z95bIlrZOnFCR1P97QaDiF2tmqKJA==
X-Received: by 2002:a17:90a:8a84:: with SMTP id x4mr73499664pjn.105.1563768136169;
        Sun, 21 Jul 2019 21:02:16 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f14sm37420625pfn.53.2019.07.21.21.02.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 21:02:15 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 02/11] jbd2: add fast commit fields to journal_s structure
Date:   Sun, 21 Jul 2019 21:00:02 -0700
Message-Id: <20190722040011.18892-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For fast commits, JBD2 as of now allocates a default of 128 blocks at
the end of the journalling area. Although JBD2 owns these blocks, it
doesn't control what exactly should be written in these blocks. It
just provides the right abstraction for making these blocks usable by
file systems. This patch adds necessary fields to manage these fast
commit blocks.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 include/linux/jbd2.h | 78 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index b7eed49b8ecd..6133a0cd22da 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -66,6 +66,7 @@ void __jbd2_debug(int level, const char *file, const char *func,
 extern void *jbd2_alloc(size_t size, gfp_t flags);
 extern void jbd2_free(void *ptr, size_t size);
 
+#define JBD2_FAST_COMMIT_BLOCKS 128
 #define JBD2_MIN_JOURNAL_BLOCKS 1024
 
 #ifdef __KERNEL__
@@ -918,6 +919,34 @@ struct journal_s
 	 */
 	unsigned long		j_last;
 
+	/**
+	 * @j_first_fc:
+	 *
+	 * The block number of the first fast commit block in the journal
+	 */
+	unsigned long		j_first_fc;
+
+	/**
+	 * @j_current_fc:
+	 *
+	 * Journal fc block iterator
+	 */
+	unsigned long		j_fc_off;
+
+	/**
+	 * @j_last_fc:
+	 *
+	 * The block number of the last fast commit block in the journal
+	 */
+	unsigned long		j_last_fc;
+
+	/**
+	 * @j_do_full_commit:
+	 *
+	 * Force a full commit. If this flag is set JBD2 won't try fast commits
+	 */
+	bool			j_do_full_commit;
+
 	/**
 	 * @j_dev: Device where we store the journal.
 	 */
@@ -987,6 +1016,15 @@ struct journal_s
 	 */
 	tid_t			j_transaction_sequence;
 
+	/**
+	 * @j_subtid:
+	 *
+	 * One plus the sequence number of the most recently committed fast
+	 * commit. This represents the sub transaction ID for the next fast
+	 * commit.
+	 */
+	tid_t			j_subtid;
+
 	/**
 	 * @j_commit_sequence:
 	 *
@@ -1068,6 +1106,20 @@ struct journal_s
 	 */
 	int			j_wbufsize;
 
+	/**
+	 * @j_fc_wbuf:
+	 *
+	 * Array of bhs for fast commit transactions
+	 */
+	struct buffer_head	**j_fc_wbuf;
+
+	/**
+	 * @j_fc_wbufsize:
+	 *
+	 * Size of @j_fc_wbufsize array.
+	 */
+	int			j_fc_wbufsize;
+
 	/**
 	 * @j_last_sync_writer:
 	 *
@@ -1167,6 +1219,32 @@ struct journal_s
 	 */
 	struct lockdep_map	j_trans_commit_map;
 #endif
+	/**
+	 * @j_fc_commit_callback:
+	 *
+	 * File-system specific function that performs actual fast commit
+	 * operation. Should return 0 if the fast commit was successful, in that
+	 * case, JBD2 will just increment journal->j_subtid and move on. If it
+	 * returns < 0, JBD2 will fall-back to full commit.
+	 */
+	int (*j_fc_commit_callback)(struct journal_s *journal, tid_t tid,
+				    tid_t subtid);
+	/**
+	 * @j_fc_replay_callback:
+	 *
+	 * File-system specific function that performs replay of a fast
+	 * commit. JBD2 calls this function for each fast commit block found in
+	 * the journal.
+	 */
+	int (*j_fc_replay_callback)(struct journal_s *journal,
+				    struct buffer_head *bh);
+	/**
+	 * @j_fc_cleanup_callback:
+	 *
+	 * Clean-up after fast commit or full commit. JBD2 calls this function
+	 * after every commit operation.
+	 */
+	void (*j_fc_cleanup_callback)(struct journal_s *journal);
 };
 
 #define jbd2_might_wait_for_commit(j) \
-- 
2.22.0.657.g960e92d24f-goog

