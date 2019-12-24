Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBB7129ED4
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfLXIOy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:14:54 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38578 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLXIOy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:54 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so906821pje.3
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9csGTNAHv6x1ujpkNH8MiOLun9GEqbAzUqp0S6Fnps=;
        b=JdR2YH8CaNA2jqUJwbAISr3zzsOS/ayYD07RAv6P/xLtnNl2CiPC4o2Bvoqli4YI9S
         8dYHkX6SLRu0qhlMIEHzH8ib/cjdxorD3qB+fjfd4QiA1oIKxr/OIUbrIZFklysfM+Wa
         t53ApnCfzFplzv7QqpLfqIYi5hKwHs67wdBxRHDWsnrvXsFHFBqVuRsiSHxVJULYRmBL
         d3hZCdOs9787w2AYWrJalJGiOAGSAt7Ec2nrlh5TE9wC7rDEjzJWV9jGoEnfN54eG8SA
         H1WND9vbnrDEarKgd3ux76YxtFj8vZKwqxnPWLmpY15UF1ZUwXy3/gnzVMwVuFuQFi3O
         n9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9csGTNAHv6x1ujpkNH8MiOLun9GEqbAzUqp0S6Fnps=;
        b=eHTl9s5NpHuEdV3OxK5CYk/RCeivzuy6GH0MqLJB8HhBISh6GtvYJ95pHMn6WKu8zZ
         LljXnyZ0DSudZ6N7cYl/FCVETCvHObvRpWP8IDc7wSygxvGz7QNujf6RXLVL26DOVLYu
         Dnuybs3FXzRHm66CazVz80Jbo2yVaHj3beiEV2s27KFE2bpcBFiQgrL3J39+aaCgq67j
         JNntS9IvL4J1Wu0lJgwPyAkf9xMQinZbX2w40B3lLKhBHVkMoSuVy36AxGH+P/4NFibU
         cT6osK7VYMrUatZmwisZkoalK9ay9YLMuOf4llBsYQxI/sWuQi3W0X+WTsJRhcdU7HTt
         mjJw==
X-Gm-Message-State: APjAAAVLxeFqWR8rZs9wCB/80kXBekqsWzAVtYkiHj2jbQwvbZMQ9YJc
        d2Ng2VvaQNcRsCyb6fR+zpA4PkE+
X-Google-Smtp-Source: APXvYqxELk/DTYXsEdON6pAaAAMOKT3r0acIGucuOwBqKE0MQDv7jb+KDE1LPK+/tbHxiFBKuqvhgA==
X-Received: by 2002:a17:90a:a4c4:: with SMTP id l4mr4398084pjw.48.1577175292969;
        Tue, 24 Dec 2019 00:14:52 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:52 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 04/20] jbd2: add fast commit block tracker variables
Date:   Tue, 24 Dec 2019 00:13:08 -0800
Message-Id: <20191224081324.95807-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
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
index fa22bdb7d952..32f14be5065a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1163,6 +1163,11 @@ static journal_t *journal_init_common(struct block_device *bdev,
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
@@ -1303,11 +1308,20 @@ static int journal_reset(journal_t *journal)
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
@@ -1632,9 +1646,18 @@ static int load_superblock(journal_t *journal)
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
index 3495fe1e2c36..7139626992f3 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -918,6 +918,30 @@ struct journal_s
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
2.24.1.735.g03f4e72817-goog

