Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3981B69F6
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgDWXhX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55809 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgDWXhX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:23 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlPE-0003qy-KC
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:20 +0000
Received: by mail-qk1-f197.google.com with SMTP id y64so8612235qkb.12
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqQWZEIIgc5b556g6djoXFwJn1Do1hJ5d68nmsXBxzU=;
        b=Qun/uFrcgSUl6wIjtKHIyrkcY33IB0xFrA6NU6UaQk8/Wf1wi6KwjWc0cxsS6CJXM4
         s0h3vI0o+r0Z78t8Am8qDOfT10eFH60C/I2uRZ77Qr4pSwlfwzopZ8AAxkXWBHg03P1G
         dYo5BA/xNnmvPoK9jRsd7N4mbnb07CNyNwH8meFePk/8wb6Mc8kq+YsVeefJsoQScIXO
         IpR08XalRP+sPKDlbsvxQp2a+A6hFJdKNEVfDJrhavwpMhwI5C5P3dfnGZ8vQmfn+atZ
         ni2E5LeQN5Qrt5IhYbuP4fZ4zHdH1qearOoPy6XmZXT09pCuVu4/jp1u6WJ+Qha5ahgs
         ZUJg==
X-Gm-Message-State: AGi0PuZlzqWAOjWsIyBr8fxk6BTaPkZ75RG0tqrK/fYe6DIEGVb3RHG2
        ENtP75X1R5CGCuLcC1uHvyujPgCKcrncT9/LqO3kPOdUe4RhL+VGPPhtgG1JNoHfTCchE7nLAM6
        fAmPRJ6SN2sRb1N+CCc8m9aTMC3YeJdapcJfHQ0c=
X-Received: by 2002:a05:620a:812:: with SMTP id s18mr6479761qks.64.1587685039453;
        Thu, 23 Apr 2020 16:37:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypKOOqPguVlYLrhwsHuQPyS/hQylkZ7D2hTH60O0YWgKG5P9bI4eNvReBuSasKcGdB6tvoOMkQ==
X-Received: by 2002:a05:620a:812:: with SMTP id s18mr6479749qks.64.1587685039166;
        Thu, 23 Apr 2020 16:37:19 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:18 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 04/11] ext4: data=journal: introduce helpers for journalled writeback deadlock
Date:   Thu, 23 Apr 2020 20:36:58 -0300
Message-Id: <20200423233705.5878-5-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423233705.5878-1-mfo@canonical.com>
References: <20200423233705.5878-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch introduces the helper functions ext4_check_journalled_writeback(),
and ext4_start_commit_datasync(), to check for, and prevent the deadlock #2
(detailed in a previous commit.)

The former checks the transaction associated with the handle (parameter)
is also the transaction stored in the inode for datasync'ing operations
(set by __ext4_journalled_writepage()) if the page (parameter) is under
writeback (set by that function too.)

This patch also documents the steps to prevent the deadlock, if needed
(i.e., helper function returns true) which consist in a retry strategy,
using the latter helper.

The check may return false positives: i_datasync_tid and PageWriteback
are set by other functions than __ext4_journalled_writepage(); but not
false negatives.

So the code may unnecessarily stop/commit/start on false-positives,
but it does prevent deadlocks so it's reasonable cost-benefit case.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/ext4/ext4_jbd2.h | 72 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 9ea8ee583931..fca6551dbf09 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -225,6 +225,78 @@ struct ext4_journalled_wb_page {
 
 extern struct kmem_cache *ext4_journalled_wb_page_cachep;
 
+/*
+ * ext4_check_journalled_writeback(handle, page).
+ * See __ext4_journalled_writepage().
+ *
+ * This function can be used to check for a potential deadlock if this task has
+ * a handle on a transaction and has to wait_on_page_writeback() when it's held.
+ * (NOTE: this affects grab_cache_page_write_begin() after ext4_journal_start())
+ *
+ * The deadlock occurs if another task has set_page_writeback() for the _same_
+ * page on the _same_ transaction, and this task calls wait_on_page_writeback().
+ *
+ * The held handle blocks the transaction commit, and thus end_page_writeback(),
+ * blocking this task in wait_on_page_writeback(); and only ext4_journal_stop()
+ * could unblock the commit, but it is not reached.
+ *
+ * If the function returns true, prevent the deadlock:
+ *
+ * 1) Stop handle to safely wait_on_page_writeback()
+ * 2) Start commiting the transaction (non-blocking)
+ *    saved in inode by __ext4_journalled_writepage()
+ * 3) Call wait_on_page_writeback()
+ * 4) Retry
+ *
+ * For example,
+ *
+ * retry:
+ *         // done before ext4_journal_start()
+ *         page = grab_cache_page_write_begin(mapping, ...);
+ *         if (ext4_should_journal_data(inode))
+ *                 wait_on_page_writeback(page);
+ *         unlock_page(page);
+ *
+ *         handle = ext4_journal_start(inode, ...);
+ *
+ *         lock_page(page);
+ *
+ *         // new code
+ *         if (ext4_check_journalled_writeback(handle, page) {
+ *                 unlock_page(page);
+ *                 put_page(page);
+ *                 ext4_journal_stop(handle);
+ *                 ext4_start_commit_datasync(inode);
+ *                 goto retry;
+ *         }
+ *
+ * Unfortunately the check may return false positives (e.g., non-mmaped/buffered
+ * pagecache that is under writeback that turned out to have same i_datasync_tid)
+ * and thus stop/commit/start unnecessarily.  But since it can prevent deadlocks
+ * and only affects the data=journal mode, it seems a reasonable cost/benefit.
+ */
+static inline int ext4_should_journal_data(struct inode *inode);
+
+static inline bool ext4_check_journalled_writeback(handle_t *handle,
+						   struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+
+	BUG_ON(!ext4_should_journal_data(inode));
+
+	return (PageWriteback(page) &&
+		handle->h_transaction->t_tid == EXT4_I(inode)->i_datasync_tid);
+}
+
+static inline int ext4_start_commit_datasync(struct inode *inode)
+{
+	BUG_ON(!ext4_should_journal_data(inode));
+
+	/* Start commit associated with datasync transaction (non-blocking.) */
+	return jbd2_log_start_commit(EXT4_JOURNAL(inode),
+				     EXT4_I(inode)->i_datasync_tid);
+}
+
 int
 ext4_mark_iloc_dirty(handle_t *handle,
 		     struct inode *inode,
-- 
2.20.1

