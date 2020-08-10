Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4402400A0
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 03:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHJBCZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Aug 2020 21:02:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36773 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgHJBCY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Aug 2020 21:02:24 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1k4wCj-00070X-L0
        for linux-ext4@vger.kernel.org; Mon, 10 Aug 2020 01:02:21 +0000
Received: by mail-qt1-f200.google.com with SMTP id b18so6472292qte.18
        for <linux-ext4@vger.kernel.org>; Sun, 09 Aug 2020 18:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEfAzSWNZQaASNwjhatmjvzHZB2T4xTmTgYYKkfWqIQ=;
        b=mwzDvLiq/rKYZMvAf18fh6Impj1wkeY+tfOthnsr2c8qOMUT4o9toFg3HpxIWrOBxh
         9S6so/sEpYS63wEtg5pmUv8Qa3oXakvtqjFPKaa1M0NCtYoDgdseqpIdKazqVxATiPEp
         vvy+4RB79GlZwPl4ssis1aW9P6+1+dMH1PU8/Z2uyEpXXkhq5I+05xpSkTXr2FgKBIb8
         I4UcUEELmtc3U3+InH4M71Red7N2N/hbNupIVjA1v3MYxh3Ir2aVN2PfozNDytb7Nxlv
         0BsN5jRZ481r/BqAko9juba07GjC7zlhpSsnzlwk4IQKhTDZK88DCly+p2Zd0reewY79
         v6sw==
X-Gm-Message-State: AOAM53046Go/JrcTGBrAw6c1vT07vaSiupH/V5wKhRm81WuNch7hnS0V
        WGkn9Xmd4bDPJC015bZ0nYSkkpdKQ/g3uwVegacHsyUEHZav0boUrAYwQzRO0c64wlMQXKKxC8f
        eKxZGZdGh7qyWmSNgPAMx1twJYInvz9WDxyOt9Ng=
X-Received: by 2002:a05:620a:21c1:: with SMTP id h1mr23384890qka.178.1597021340620;
        Sun, 09 Aug 2020 18:02:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/gNL1NLIKY9GhTzgTs03cLkaKtYowVsvbffBNA7OF+unNlfZkYequJe4anyU7u2lg8rTxkQ==
X-Received: by 2002:a05:620a:21c1:: with SMTP id h1mr23384864qka.178.1597021340263;
        Sun, 09 Aug 2020 18:02:20 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id 95sm44815qtc.29.2020.08.09.18.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 18:02:19 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: [RFC PATCH v2 2/5] jbd2: introduce journal callbacks j_submit|finish_inode_data_buffers
Date:   Sun,  9 Aug 2020 22:02:05 -0300
Message-Id: <20200810010210.3305322-3-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810010210.3305322-1-mfo@canonical.com>
References: <20200810010210.3305322-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add the callbacks as opt-in to override the default behavior for
the transaction's inode list, instead of moving that code around.

This is important as not only ext4 uses the inode list: ocfs2 too,
via jbd2_journal_inode_ranged_write(), and maybe out-of-tree code.

To opt-out of the default behavior (i.e., to do nothing), one has
to opt-in with a no-op function.
---
 fs/jbd2/commit.c     | 21 ++++++++++++++++-----
 include/linux/jbd2.h | 21 ++++++++++++++++++++-
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 51f713089e35..b98d227b50d8 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -237,10 +237,14 @@ static int journal_submit_data_buffers(journal_t *journal,
 		 * instead of writepages. Because writepages can do
 		 * block allocation  with delalloc. We need to write
 		 * only allocated blocks here.
+		 * This can be overriden with a custom callback.
 		 */
 		trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
-		err = journal_submit_inode_data_buffers(mapping, dirty_start,
-				dirty_end);
+		if (journal->j_submit_inode_data_buffers)
+			err = journal->j_submit_inode_data_buffers(jinode);
+		else
+			err = journal_submit_inode_data_buffers(mapping,
+					dirty_start, dirty_end);
 		if (!ret)
 			ret = err;
 		spin_lock(&journal->j_list_lock);
@@ -274,9 +278,16 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 			continue;
 		jinode->i_flags |= JI_COMMIT_RUNNING;
 		spin_unlock(&journal->j_list_lock);
-		err = filemap_fdatawait_range_keep_errors(
-				jinode->i_vfs_inode->i_mapping, dirty_start,
-				dirty_end);
+		/*
+		 * Wait for the inode data buffers writeout.
+		 * This can be overriden with a custom callback.
+		 */
+		if (journal->j_finish_inode_data_buffers)
+			err = journal->j_finish_inode_data_buffers(jinode);
+		else
+			err = filemap_fdatawait_range_keep_errors(
+					jinode->i_vfs_inode->i_mapping,
+					dirty_start, dirty_end);
 		if (!ret)
 			ret = err;
 		spin_lock(&journal->j_list_lock);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index d56128df2aff..24efe88eda1b 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -628,7 +628,8 @@ struct transaction_s
 	struct journal_head	*t_shadow_list;
 
 	/*
-	 * List of inodes whose data we've modified in data=ordered mode.
+	 * List of inodes whose data we've modified in data=ordered mode
+	 * or whose pages we should write-protect in data=journaled mode.
 	 * [j_list_lock]
 	 */
 	struct list_head	t_inode_list;
@@ -1110,6 +1111,24 @@ struct journal_s
 	void			(*j_commit_callback)(journal_t *,
 						     transaction_t *);
 
+	/**
+	 * @j_submit_inode_data_buffers:
+	 *
+	 * This function is called before flushing metadata buffers.
+	 * This overrides the default behavior (writeout data buffers.)
+	 */
+	int			(*j_submit_inode_data_buffers)
+					(struct jbd2_inode *);
+
+	/**
+	 * @j_finish_inode_data_buffers:
+	 *
+	 * This function is called after flushing metadata buffers.
+	 * This overrides the default behavior (wait writeout.)
+	 */
+	int			(*j_finish_inode_data_buffers)
+					(struct jbd2_inode *);
+
 	/*
 	 * Journal statistics
 	 */
-- 
2.17.1

