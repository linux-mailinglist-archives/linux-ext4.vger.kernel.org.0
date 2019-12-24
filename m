Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C043F129ED5
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfLXIOz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:14:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40833 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXIOy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id s21so5459001plr.7
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xIaUDO/osK5V8HM+We208YSUhdc9ksUHY6OeVddeY4o=;
        b=YmdUhhoDJv1eGKgplQzh2+NGZYmWBCp5uDO3bkbR5lxKDRH7l5PLhWtfWKpm54wVKS
         mlL0tXOXij/ACdAPJn058+3OV3VnHlo7xMJcOliGAYlVhfWM9yfY6vHT0ZtDpVd4K7Ds
         /diglJef5Qja475FvvzF86/Inwbg2DPU3tgOq0Q0H5KXtbAjJQNMjRvwM+C8emGwhH9U
         QEkE8MBx3oCKHgPczTcD20GGpoXMZjaDjk9Qe0ei+MJMp+12p+eOn6WpahTkC6Rz9O+e
         LWP9h6yeyy23H9R/72tcgyuP20RXuSgrJ1ZFrze/CdhnFkh31+qYy8PBYoYwo+qDYPqu
         snPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xIaUDO/osK5V8HM+We208YSUhdc9ksUHY6OeVddeY4o=;
        b=M51m0Unj2+d/nSW2lWGhPjTx5mpEUheN2AxMaiF4hygTykjjvorpWTH1PTlX7l4brF
         7nKGdNZ9q9AU1/1E/mGSvSvGX32esIjhiCy+4y+iWE4N2XBcRE7CNQEnI8SMqfM3HHI0
         nwYXcWZIFLfilAJpSZ2WmcpCP8ZDsete/KfJMX/5/mACmJF3jzxRFQBE2e6fCkYpHIUk
         woJtRZT4uLGnZDuhxnIdUG8pOaZ7w0mEs0HTZGQgr6oiVN4NnUPT5vFB0ukxq21IDYhd
         Rk53IUu6DMw6V6PehbZ7qze2YD7RrRjvro+JrRbw671I4n24Zb6spK4Ca8c/ij+76LTo
         u3cg==
X-Gm-Message-State: APjAAAWeJZo/nOw4e2jiUke3041v5UpnwtHbf3NLrU3qUlSa1AFABZIb
        DdLMgi95zfRwGLrDsFCpxFdtEsLH
X-Google-Smtp-Source: APXvYqwLHCoFaKMXjK5UqrQgEw/77UusI1ALFdlFPPeDWIARw4fvEkDD/ah/AIBrwmHGufzOwa3NyQ==
X-Received: by 2002:a17:90a:17e5:: with SMTP id q92mr4502304pja.28.1577175293636;
        Tue, 24 Dec 2019 00:14:53 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:53 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 05/20] jbd2: disable fast commits if journal is empty
Date:   Tue, 24 Dec 2019 00:13:09 -0800
Message-Id: <20191224081324.95807-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If journal is empty, clear the fast commit flag from the on disk
superblock. With this optimization, chances of running into backward
compatibility issues are reduced.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 32f14be5065a..7d91f5204366 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1464,6 +1464,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 {
 	journal_superblock_t *sb = journal->j_superblock;
+	bool had_fast_commit = false;
 
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	lock_buffer(journal->j_sb_buffer);
@@ -1477,9 +1478,20 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 
 	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
 	sb->s_start    = cpu_to_be32(0);
+	if (jbd2_has_feature_fast_commit(journal)) {
+		/*
+		 * When journal is clean, no need to commit fast commit flag and
+		 * make file system incompatible with older kernels.
+		 */
+		jbd2_clear_feature_fast_commit(journal);
+		had_fast_commit = true;
+	}
 
 	jbd2_write_superblock(journal, write_op);
 
+	if (had_fast_commit)
+		jbd2_set_feature_fast_commit(journal);
+
 	/* Log is no longer empty */
 	write_lock(&journal->j_state_lock);
 	journal->j_flags |= JBD2_FLUSHED;
-- 
2.24.1.735.g03f4e72817-goog

