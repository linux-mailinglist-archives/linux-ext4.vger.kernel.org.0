Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912732BB6A2
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 21:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgKTUWl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 15:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbgKTUWl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 15:22:41 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34524C0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 12:22:41 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so8240118pgg.13
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 12:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QY0J0GMZNINU4/aWxAI75MkA7Zf0FuiwCB2mZEulcYI=;
        b=aYf9xA05JsydUMZ9uJvbbmtpRQDnf08FIgrfzdFL/C+LQY0NEE78N54ErYOwkViHWE
         4b+lMDEdfE0turG8/tvuShCOnU6uE8EGhASxh/J/A1Rk6MW7PScQlVVPseuaLSV7W0qN
         ICPWujbPHrh5aYkf0xLJ7m2rEXs3yI8wkz1sSW03I5pAUDJZixSuPNAORUp2svWUxX+i
         L/JlRlJ5z9z6BekQmBRKTU4aIQOwd4qSvAliJJ5WvJ0yLdZ0gYLaoCipR0KyFOKXYrEV
         zz8rUHySnCVWLmQe9JZVMyUYt/deWy1jeATAwH0HKY5eySRJBIZe0fdJ1OZFRRZyKYbi
         Cluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QY0J0GMZNINU4/aWxAI75MkA7Zf0FuiwCB2mZEulcYI=;
        b=E+EBZUZ5eWHqx2BqzpRakvFWlTXdQZDG4eD5Q0HI4QutCgRvJms2SNQR45QT65iyk0
         HwPf24etdy76N1I7eL9g9sVLGb4QZeU3CsagsuOwD2qqdfBf0fp8KRpQ+yvZP6VLzvt+
         pgAuj6XbGC4sc0zFuy+EQ0AOWdjBP2vtve/DxvuwkTh210YC4+romrxD6aL5YnJj2799
         JV74iDCnHrCOx40Ea+BvSNpthahCyvQZ7jmjTCBjXbkHNtIVU8PDf2JS5k+yHcoFE4me
         es5ttkg6N7+XqjUWh7WbpXE7rCA0VAi2XiqbO+EsmgOvNtWxlKsQvjOuqO2v8zAP33WB
         j1nQ==
X-Gm-Message-State: AOAM533UER9loyBHn0DixN9crExX7t1vuqAqesg78mo/V1xUxY1E0yKH
        tk2tcThC84FJ0E/1aweixahBoZvthD4=
X-Google-Smtp-Source: ABdhPJxCjEVxbsMTHk717bd/m0W/SFzOV/xsbCSvSLV/ujsS4PsLx/dxNo5TcNl9tp1G/ZCTN7n/DQ==
X-Received: by 2002:a17:90b:150c:: with SMTP id le12mr12304873pjb.139.1605903760340;
        Fri, 20 Nov 2020 12:22:40 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id p4sm4789672pjo.6.2020.11.20.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:22:39 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 2/2] jbd2: add a helper to find out number of fast commit blocks
Date:   Fri, 20 Nov 2020 12:22:32 -0800
Message-Id: <20201120202232.2240293-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120202232.2240293-1-harshadshirwadkar@gmail.com>
References: <20201120202232.2240293-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a helper to read number of fast commit blocks from jbd2 superblock
and also rename the JBD2_MIN_FC_BLKS to
JBD2_DEFAULT_FAST_COMMIT_BLOCKS since this constant is just the
default number of fast commit blocks to use in case number of fast
commit blocks isn't set in jbd2 superblock.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c    | 8 ++------
 include/linux/jbd2.h | 9 ++++++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 0c3d5e3b24b2..e6e8405b9f1a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1867,9 +1867,7 @@ static int load_superblock(journal_t *journal)
 
 	if (jbd2_has_feature_fast_commit(journal)) {
 		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
-		num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
-		if (!num_fc_blocks)
-			num_fc_blocks = JBD2_MIN_FC_BLOCKS;
+		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
 		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
 			journal->j_last = journal->j_fc_last - num_fc_blocks;
 		journal->j_fc_first = journal->j_last + 1;
@@ -2100,9 +2098,7 @@ jbd2_journal_initialize_fast_commit(journal_t *journal)
 	journal_superblock_t *sb = journal->j_superblock;
 	unsigned long long num_fc_blks;
 
-	num_fc_blks = be32_to_cpu(sb->s_num_fc_blks);
-	if (num_fc_blks == 0)
-		num_fc_blks = JBD2_MIN_FC_BLOCKS;
+	num_fc_blks = jbd2_journal_get_num_fc_blks(sb);
 	if (journal->j_last - num_fc_blks < JBD2_MIN_JOURNAL_BLOCKS)
 		return -ENOSPC;
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 1c49fd62ff2e..274919a49783 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -68,7 +68,7 @@ extern void *jbd2_alloc(size_t size, gfp_t flags);
 extern void jbd2_free(void *ptr, size_t size);
 
 #define JBD2_MIN_JOURNAL_BLOCKS 1024
-#define JBD2_MIN_FC_BLOCKS	256
+#define JBD2_DEFAULT_FAST_COMMIT_BLOCKS 256
 
 #ifdef __KERNEL__
 
@@ -1691,6 +1691,13 @@ static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
 	return journal->j_chksum_driver != NULL;
 }
 
+static inline int jbd2_journal_get_num_fc_blks(journal_superblock_t *jsb)
+{
+	int num_fc_blocks = be32_to_cpu(jsb->s_num_fc_blks);
+
+	return num_fc_blocks ? num_fc_blocks : JBD2_DEFAULT_FAST_COMMIT_BLOCKS;
+}
+
 /*
  * Return number of free blocks in the log. Must be called under j_state_lock.
  */
-- 
2.29.2.454.gaff20da3a2-goog

