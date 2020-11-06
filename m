Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB96F2A8DDA
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgKFD7e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKFD7d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:33 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89B5C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:33 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id u4so2920140pgr.9
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dpW9aGydZxat/o5Z4t4XauKyo/y4/injR0tRIzqBBY=;
        b=Mjx5mYz2IgXj+FVjfXKbSazHlDtS6h+HoXFOnz8uJfaVtaIf+BCXYFEIjPpBi/Bcwz
         fzL5NjyysbJfPa/MtGpaxJgnTRdI1MDrwWcEzjGivsaV7raG79nXnofYBVAgQ6Uvgcky
         sgEbkEV8+EN12zOczku9B/1FOGLQbWPBPFrvtM5clH+oln7Gb+3I+kB5fHsDGLwzAzvF
         j+uXLyg1iTIzqeBrkabQEZOh7iQmpho6DWi3/2ullhsXCQXZ9MK+j1U4gJBrVQuPtzFB
         APzfuclun/dqfsFwDVG5Cjqza9dSZq31ZJUMhI45OdDWXEUFt0V2Inwk2Zy0bnbFINND
         X/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dpW9aGydZxat/o5Z4t4XauKyo/y4/injR0tRIzqBBY=;
        b=qVSNsooYs38D8hoRTYVJc98o7ns8CwyZM27rz7LzjbS/pokATxn39Q19rg4vx7s3hw
         jgpFS1odGbiFNOonpuNrn/+2busAyiIa5FaRDik8JGYke257C4ScmPwud+DXYC51JVTx
         QnV12icX/ulChahYpsVdgqWixQDfYr7nWKKSFlFf4zngko+it234BRkeM/JF3UsHvnU/
         vuj8eow96cZQhHXAVG74DZAdzC/6DjdcCTE65qnB3NTZzNIYGUS0i9kIZwv6eoVh7EjV
         gEQeglih1Qr69lfwtVl4R6lxkrxC5MVyUrGGJv2hYQFEWusIudrSg/QtT8uMVNrIGJ3Z
         zF0Q==
X-Gm-Message-State: AOAM533feknd9gLq5cY97M3f4HMW0t/unZbRirE9fqQzEJvwfigL0R5s
        M9A2TegakB5LWkprC4EG8aUY3BTQDK4=
X-Google-Smtp-Source: ABdhPJwNh4lO0E4sY0953wruH4JDVvOgkIax1VwliCwfB5PQTNMkmMjUsFA3v7gysATjb4w+cc4ggg==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr275044pju.194.1604635172993;
        Thu, 05 Nov 2020 19:59:32 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:32 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 08/22] jbd2: don't use state lock during commit path
Date:   Thu,  5 Nov 2020 19:58:57 -0800
Message-Id: <20201106035911.1942128-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Variables journal->j_fc_off, journal->j_fc_wbuf are accessed during
commit path. Since today we allow only one process to perform a fast
commit, there is no need take state lock before accessing these
variables. This patch removes these locks and adds comments to
describe this.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c    |  6 ------
 include/linux/jbd2.h | 10 ++++++----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 500152f0421a..778ea50fc8d1 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -865,7 +865,6 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	int fc_off;
 
 	*bh_out = NULL;
-	write_lock(&journal->j_state_lock);
 
 	if (journal->j_fc_off + journal->j_fc_first < journal->j_fc_last) {
 		fc_off = journal->j_fc_off;
@@ -874,7 +873,6 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	} else {
 		ret = -EINVAL;
 	}
-	write_unlock(&journal->j_state_lock);
 
 	if (ret)
 		return ret;
@@ -909,9 +907,7 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
 	struct buffer_head *bh;
 	int i, j_fc_off;
 
-	read_lock(&journal->j_state_lock);
 	j_fc_off = journal->j_fc_off;
-	read_unlock(&journal->j_state_lock);
 
 	/*
 	 * Wait in reverse order to minimize chances of us being woken up before
@@ -939,9 +935,7 @@ int jbd2_fc_release_bufs(journal_t *journal)
 	struct buffer_head *bh;
 	int i, j_fc_off;
 
-	read_lock(&journal->j_state_lock);
 	j_fc_off = journal->j_fc_off;
-	read_unlock(&journal->j_state_lock);
 
 	/*
 	 * Wait in reverse order to minimize chances of us being woken up before
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index b2caf7bbd8e5..5f0ef6380b0c 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -945,8 +945,9 @@ struct journal_s
 	/**
 	 * @j_fc_off:
 	 *
-	 * Number of fast commit blocks currently allocated.
-	 * [j_state_lock].
+	 * Number of fast commit blocks currently allocated. Accessed only
+	 * during fast commit. Currently only process can do fast commit, so
+	 * this field is not protected by any lock.
 	 */
 	unsigned long		j_fc_off;
 
@@ -1109,8 +1110,9 @@ struct journal_s
 	struct buffer_head	**j_wbuf;
 
 	/**
-	 * @j_fc_wbuf: Array of fast commit bhs for
-	 * jbd2_journal_commit_transaction.
+	 * @j_fc_wbuf: Array of fast commit bhs for fast commit. Accessed only
+	 * during a fast commit. Currently only process can do fast commit, so
+	 * this field is not protected by any lock.
 	 */
 	struct buffer_head	**j_fc_wbuf;
 
-- 
2.29.1.341.ge80a0c044ae-goog

