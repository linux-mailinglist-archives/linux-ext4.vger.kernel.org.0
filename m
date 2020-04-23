Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0192C1B69F3
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgDWXhQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55787 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgDWXhQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:16 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlP7-0003pP-RQ
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:13 +0000
Received: by mail-qt1-f198.google.com with SMTP id z8so8824716qtu.17
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GXL5eZnKJElFRGDCVwQEpfAqS/xKIUXtK/u+5dwtM0=;
        b=aebX6HYU0lLq2Usr55ntWNyDJOPbyNergsD0xl5oaBglCGyuPkRglDumU+JI84YXQg
         upHO6gKkRPQtNpKY57LVaXPfA315NIdyHSZyIWjrVtp0lNtGznr85OV5dwxtwSTSzdv5
         wyWeOXFogLkNvZSqBPVy1/BTKR/U+71lP7I9RKR5lhDq8quM7GP9LfllLOEqQ5nvuj3x
         AfCoWQM5TX1JNywHSjuR8mEtzq6CGAPg1sNEieV+ynCnMI2OJ2NeC/tMYo5zgovETbK7
         2awNYrfI57Kr4ffn2CHBKkRPkjvk6el9WwU1cjxi6A5Cr3DJ1e3bbSdix5/pQgEaoQOX
         ftZQ==
X-Gm-Message-State: AGi0PuZrlwukhPaCtnd8Y5zxQypsdHA9XAbJjL17u6UQrky8A8nt/XH5
        uRYEbqfI7wiCWQ2SUt4yJw5ymGkQCNmJl4z5l2ryXTgYK4i70YXRdgxukCAR33bviQAOmt7QIbg
        2pSYHKWMDv0HKflTULtspj7avkM3ShHB0+tvslkY=
X-Received: by 2002:a37:6c81:: with SMTP id h123mr6254465qkc.290.1587685032662;
        Thu, 23 Apr 2020 16:37:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypID/MWu7Ch1nxy5XeU+2fNLeuCGR1rM0Rzcpx8S66vnmuZ+wDp+mOl/rqSizw7QJJN9IGIviw==
X-Received: by 2002:a37:6c81:: with SMTP id h123mr6254447qkc.290.1587685032386;
        Thu, 23 Apr 2020 16:37:12 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:12 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 01/11] ext4: data=journal: introduce struct/kmem_cache ext4_journalled_wb_page/_cachep
Date:   Thu, 23 Apr 2020 20:36:55 -0300
Message-Id: <20200423233705.5878-2-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423233705.5878-1-mfo@canonical.com>
References: <20200423233705.5878-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The 'struct ext4_journalled_wb_page' is a journal callback entry;
use 'kmem_cache ext4_journalled_wb_page_cachep' to alloc/free it.

It will be used to end page writeback on transaction commit,
only for writeback of mmaped pagecache in data=journal mode
(i.e., ext4_writepage() -> __ext4_journalled_writepage()).

The next patch will add the associated set page writeback
and add the callback entry to the list in the transaction;
and process that list in the ext4 journal commit callback.

This builds on top of the existing journal commit callback
functions (not used anymore), using t_private_list in jbd2.
(introduced with commit 18aadd47f884 ("ext4: expand commit
callback and"), and not used in commit a015434480dc ("ext4:
send parallel discards on commit completions").)

P.S.: ext4_journal_commit_callback() does have spinlocking
with s_md_lock that is not needed for this particular case
(which seems to be the only one), as it has no concurrency
on transaction commit time/only during transaction running
time (currently only done in __ext4_journalled_writepage()).

But no changes for now, just keep it as it is/has been, so
it remains general in case other usages arise that need it.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/ext4/ext4_jbd2.h | 16 ++++++++++++++++
 fs/ext4/page-io.c   | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 4b9002f0e84c..9ea8ee583931 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -209,6 +209,22 @@ static inline bool ext4_journal_callback_try_del(handle_t *handle,
 	return deleted;
 }
 
+/* The struct ext4_journalled_wb_page is a journal callback entry to
+ * end page writeback on transaction commit in the data=journal mode.
+ *
+ * This is used for writeback of mmaped pagecache in data=journal mode
+ * (see ext4_writepage() -> __ext4_journalled_writepage() for details.)
+ */
+struct ext4_journalled_wb_page {
+	/* First member must be the journal callback entry */
+	struct ext4_journal_cb_entry ejwp_jce;
+
+	/* Pointer to page marked for writeback */
+	struct page *ejwp_page;
+};
+
+extern struct kmem_cache *ext4_journalled_wb_page_cachep;
+
 int
 ext4_mark_iloc_dirty(handle_t *handle,
 		     struct inode *inode,
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index de6fe969f773..67fabeef6bf2 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -32,6 +32,7 @@
 
 static struct kmem_cache *io_end_cachep;
 static struct kmem_cache *io_end_vec_cachep;
+struct kmem_cache *ext4_journalled_wb_page_cachep;
 
 int __init ext4_init_pageio(void)
 {
@@ -44,6 +45,15 @@ int __init ext4_init_pageio(void)
 		kmem_cache_destroy(io_end_cachep);
 		return -ENOMEM;
 	}
+
+	ext4_journalled_wb_page_cachep = KMEM_CACHE(ext4_journalled_wb_page,
+						    SLAB_RECLAIM_ACCOUNT);
+	if (ext4_journalled_wb_page_cachep == NULL) {
+		kmem_cache_destroy(io_end_cachep);
+		kmem_cache_destroy(io_end_vec_cachep);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -51,6 +61,7 @@ void ext4_exit_pageio(void)
 {
 	kmem_cache_destroy(io_end_cachep);
 	kmem_cache_destroy(io_end_vec_cachep);
+	kmem_cache_destroy(ext4_journalled_wb_page_cachep);
 }
 
 struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end)
-- 
2.20.1

