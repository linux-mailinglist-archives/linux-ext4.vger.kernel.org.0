Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D905087043
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 05:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405165AbfHIDqb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 23:46:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44403 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405100AbfHIDqa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 23:46:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so45244535pfe.11
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2019 20:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANE5R9Yz3I1xChBILEP8gIfVAaEDzNS/uDUefRfMDfw=;
        b=QW/o9dwi1kyGhI5ACyN1p+FkiQATqbVqc4qZfagK7bzYdNRcGYVANZ5s/wvW5p51uJ
         d6qMkXH3IpxHF+vWW+7H/oeir7vpFVj+pW9NTqaPs9Dr+aitvFF8P+rAVd1gJIwiqdAu
         xM8xCIKOi18hoCCCyKuNC6OLGyDzxzzul6AuTBlkhUgDwxG0yls4lqu0WvOBy65cdMrD
         r//iRzNYFZrFoeFdbDBO0mmdHRIFEqAxjyccqS494/J3BVJhjSyBJZQ3HZz8tF85qKwR
         szYDSNKA4dH6mfQkYcKAym/1V072oAVgGDH2bHZrl3lKVX4yR1gzjV1GgsR7XSVc2Y/p
         ZWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANE5R9Yz3I1xChBILEP8gIfVAaEDzNS/uDUefRfMDfw=;
        b=EUOhZRO7wj02O0nn4mRX+pZEmPq9CA4w+KDtOpHx313PHQT5tPFhiVRBXeGfMYMfRl
         NuCASIcF+w8Xdqq0zWSptfBm2fFm6TEfj+uYccm9EVxj4YQrafCdAlnJgF1kNMlQ7/ix
         iQIN/OYPLCjy56JRhQeN83u3ctaKP+CZZCoAQZRMOEEphLBCg2+OqFq1ybyf6DfPR+ew
         30LqsGjOU5qlkquXVC8tsuM5YGombfrG8ohE8uAK2g4hh4mQ/wlJAkQeRj1b/qGUx1m6
         kPlMN5CSc9408NVozzR0Q8wlKk6lWQhM+kxHKnomcmtumqC1rgMosRfKi3vAFDMeyYAC
         wARg==
X-Gm-Message-State: APjAAAVZHqxOd0jopPLFP+Fmly/23BpbMTROTqpV+6XMgpfk4ET+m434
        KFpIf1nsbmWXOGSvd+m5OkUzx1B5
X-Google-Smtp-Source: APXvYqzOiBHVMLErsqKMt+eyeFUl8XDrNN+IbmLH+BebzWLOx41Ehl1wKz3VqZOnVEyLV8YEk7LdFQ==
X-Received: by 2002:a63:1743:: with SMTP id 3mr15226483pgx.435.1565322389571;
        Thu, 08 Aug 2019 20:46:29 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id s5sm80191085pfm.97.2019.08.08.20.46.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:46:29 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 02/12] jbd2: add fast commit fields to journal_s structure
Date:   Thu,  8 Aug 2019 20:45:42 -0700
Message-Id: <20190809034552.148629-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
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

Changelog:

V2: Added struct transaction_run_stats_s * argument to
    j_fc_commit_callback to collect stats
---
 include/linux/jbd2.h | 79 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index b7eed49b8ecd..9a750b732241 100644
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
@@ -1167,6 +1219,33 @@ struct journal_s
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
+				    tid_t subtid,
+				    struct transaction_run_stats_s *stats);
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
2.23.0.rc1.153.gdeed80330f-goog

