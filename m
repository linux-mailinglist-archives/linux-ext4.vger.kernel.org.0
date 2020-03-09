Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC3817D987
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCIHGD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34627 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgCIHGC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id 23so2608945pfj.1
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fSUx91OCD79MSnLeeD7t851nsccIfmuWdICD8nRJqeg=;
        b=Xjai41r2aioj99tgmKs/f6ipRy+dr+gv9rBAYSOoXY8/aAlDQCNcck09g659rRtsij
         /dEbq81iP0h34nO2cvbJGgoIv5FA5fP4WFjGv1Xa4yfIYOZgbFSm5YLCEQtsCbEH64d2
         NKHc7MOtst33qT31aWn0mhwdUTY1Fhn4iuXrvBQwYxODKTS3r1ezvkrhCZPijNs2BR9g
         J4OMSKLrVzb0RfFXnEoOhq2zhARtZDghJ9w8jFE451AOMWhS/e7gZGq+Hi0S15ptw/QU
         imCgjJE4ReTqFXjdjgfVYG37TFTWv8QmnOH/GR/lPtM7/QkhBTm0H7ZCBgmGefl9w2V4
         AcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSUx91OCD79MSnLeeD7t851nsccIfmuWdICD8nRJqeg=;
        b=QBQBPxuoKPBfEIHtKeQ5fWLXlF4lJrpIaQzwyT5JRPx0DiJC1U7BWmwXVJVePSMLIB
         Bm/M34DAiCOqwABjVeUOmUwyamqvO/Kc+5xDn+Llc9qQrACe0kWa5QinbawIFL3NVM5+
         3/zMWj0jzZevfTdk4QRySjl0CiGcOAUh+nFRKvvGuZYSEpGHJsBUxLcK75pRaEJjz+3p
         woddhtQ49hBBAO3fRiyEUGX+pnkZ60tWVpQneniIDFC2u7BKxnx+Eord34lAC6YAMDqy
         t5j/DRiEEtXv1T14kUL7J3+674qneihKDNSzdOqSkHf2hrtrS8J9O+RgTiMJ4GXDw51m
         +IBw==
X-Gm-Message-State: ANhLgQ0mka21RtnULO5ZwtXaN2fNIVGGYA7Fc4EIXH5OWCIrP9gSYdtN
        HmctLVwj6Pbe6eORYISU6QS90gqv
X-Google-Smtp-Source: ADFU+vtDzSioea9Q7LYZ7/KMCgZ+quBImkSu6QKtUlFJVMO0oNrbHOXo+LOwSZlAHyqhaRIRjfcfKw==
X-Received: by 2002:a62:820e:: with SMTP id w14mr16239923pfd.59.1583737559699;
        Mon, 09 Mar 2020 00:05:59 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:05:59 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 05/20] jbd2: disable fast commits if journal is empty
Date:   Mon,  9 Mar 2020 00:05:11 -0700
Message-Id: <20200309070526.218202-5-harshadshirwadkar@gmail.com>
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

If journal is empty, clear the fast commit flag from the on disk
superblock. With this optimization, chances of running into backward
compatibility issues are reduced.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 79f015f7bf54..f8f55d0814ea 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1482,6 +1482,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 {
 	journal_superblock_t *sb = journal->j_superblock;
+	bool had_fast_commit = false;
 
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	lock_buffer(journal->j_sb_buffer);
@@ -1495,9 +1496,20 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 
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
2.25.1.481.gfbce0eb801-goog

