Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2EC1B69F4
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgDWXhU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55796 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgDWXhT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:19 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlPA-0003py-B0
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:16 +0000
Received: by mail-qk1-f200.google.com with SMTP id c140so8558403qkg.23
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8WZCTahEWXAOrLRi0F4IXhRzjuKaMF/9BHK7jOV8fs=;
        b=H6eVyPq8fOnPXhyo2t0LUiv7JCPZ0rDn3PZ91ogh+VesMoUaHmk0O5UfObHomJJMZd
         6jMBs13T60o1sL6cY8+oaHu2Pu1UPMP6FZrOseYskuGj8A98xZQeC/X+gVrreLNmaUP9
         aWDCN4cf5Wup/BpjX3zAHjJr9R7cllDEr8QgrA85ACg0M/MNtlEq9Os+qrx0gSzrOHT4
         KWzfq79kpyjQMQKUJ8eNiYVAmzncS0xkdLyM0cHEMbw5NkF8l2cbvfLcDXG0w+CT9QRY
         zz83xAzgYTzndMUy5vpMNmQ6NqnUMH5ez4dHrBlkzutGpXXpGGXcdFA/uPXHdp4lZEOf
         F5+Q==
X-Gm-Message-State: AGi0Pua77A88yhV7L7yZLS8Hsaw0HtYXkdNfsMslnbx2mKjYVefs+J2d
        cdMmwYc+14M0iSkUctUueqaBWo2b+/CmTcNvzpdiIW+sb43n60RV63xdsWWSt26XeQhxUH5sAsz
        /3kQ9Sj5y9MUXJs0b8NKNgmPekf0JwzxsDKR+ke0=
X-Received: by 2002:ac8:4b5b:: with SMTP id e27mr6604943qts.46.1587685035097;
        Thu, 23 Apr 2020 16:37:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypKzNDJEjOx8VFHHP05LpUX9yUQbkONcLqXc/p6boszSSzdhXQPd/K/z5YEGy2f0hjYIDC2qhA==
X-Received: by 2002:ac8:4b5b:: with SMTP id e27mr6604920qts.46.1587685034705;
        Thu, 23 Apr 2020 16:37:14 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:14 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 02/11] ext4: data=journal: handle page writeback in __ext4_journalled_writepage()
Date:   Thu, 23 Apr 2020 20:36:56 -0300
Message-Id: <20200423233705.5878-3-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423233705.5878-1-mfo@canonical.com>
References: <20200423233705.5878-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The idea is to have __ext4_journalled_writepage() to call
set_page_writeback(), then add the page to a page list in
the transaction (pages under data=journal writeback), and
end_page_writeback() on those pages on transaction commit.

And also wait_on_page_writeback() for data=journal after
wait_for_stable_page() and grab_cache_page_write_begin().

(The credits for understanding the problem reported and
suggesting a fix go to Ted Ts'o, on the linux-ext4 list [1])

Now __ext4_journalled_writepage() goes for new adventures.

So, upfront, do not inline it so it shows in stack traces,
not into a big ext4_writepage() function.  And remove its
forward declaration (unneeded.)

Still upfront,

Due to a couple of reasons the simple path to set_page_writeback()
before unlock_page(), then wait_on_page_writeback() where needed,
is not possible, as it might deadlock.  So there are adaptations.

1) It's not possible to set_page_writeback() before unlock_page()
(needed for ext4_journal_start())

This deadlocks with common 'lock_page(); wait_on_page_writeback();'
pattern seen in write_cache_pages()/grab_cache_page_write_begin()
for example (the latter for the case of stable pages), and more.

That happens because we have to lock_page() again in order to
end_page_writeback() later, but the other task is holding the
page lock, and waiting for this task to finish page writeback.

Therefore, our (contained) option left is set_page_writeback()
after we lock_page() after ext4_journal_start().

Unfortunately, it turns out to create another problem/deadlock
for ourselves, now for wait_on_page_writeback().

2) It's not possible to just wait_on_page_writeback() holding
a journal transaction handle.

This deadlocks with __ext4_journalled_writepage() if the same
transaction is used by the two tasks to set/wait on writeback.

That happens because if set_page_writeback() occurs then the
other task gets a transaction handle in the same transaction
and goes wait_on_page_writeback(), it still holds the handle,
which prevents transaction commit, thus end_page_writeback().

Unfortunately the options to address this problem are not at
all welcoming in all aspects, so the simplest one won: retry.

(another approach is another synchronization mechanism, e.g.,
possibly a page bit, which is overkill for a particular case;
another, a reader-writer semaphore on the inode would do too,
but it's coarse grained, as an inode/mapping maps many pages,
and not all pages could possibly be under writeback.)

This problem is addressed with more patches on each caller.
Regressions until those are applied are unlikely to happen
because data=journal is not default, thus likely debugging
or testing by someone intentionally looking at this anyway.

...

So, back to the patch:

Add the functions to initialize a 'struct ext4_journalled_wb_page'
and its callback to end_page_writeback() and free the used struct.

Change the function to allocate an entry (not failing immediately
to give the chance of successful return in case of page truncated),
set page as writeback then add it to the list in the transaction,
so to end page writeback on transaction commit.

Now pages in the mmaped pagecache that are set dirty ('checked')
and have writeback triggered (e.g., msync() or memory cleansing)
can have the writeback bit set and waited on, until the journal
commit callback entry have it clear later.

Now that we set_page_writeback(), some places need this snippet:

	if (ext4_should_journal_data(inode))
		wait_on_page_writeback(page)

But due to deadlock #2 above, most of those will be done shortly
on next patches. One place is not affected/no handle held during
wait_on_page_writeback(): ext4_page_mkwrite() so address it here.

[1] https://lore.kernel.org/linux-ext4/20190830012236.GC10779@mit.edu/

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/ext4/inode.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a4aae6acdcb..d385a11ba31e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -137,7 +137,6 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 
 static void ext4_invalidatepage(struct page *page, unsigned int offset,
 				unsigned int length);
-static int __ext4_journalled_writepage(struct page *page, unsigned int len);
 static int ext4_bh_delay_or_unwritten(handle_t *handle, struct buffer_head *bh);
 static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
@@ -1839,8 +1838,27 @@ static int bput_one(handle_t *handle, struct buffer_head *bh)
 	return 0;
 }
 
-static int __ext4_journalled_writepage(struct page *page,
-				       unsigned int len)
+static void __ext4_journalled_wb_page_init(struct ext4_journalled_wb_page *ejwp,
+					   struct page *page)
+{
+	INIT_LIST_HEAD(&ejwp->ejwp_jce.jce_list);
+	ejwp->ejwp_page = page;
+}
+
+static void __ext4_journalled_wb_end(struct super_block *sb,
+				     struct ext4_journal_cb_entry *jce,
+				     int error)
+{
+	struct ext4_journalled_wb_page *ejwp =
+		(struct ext4_journalled_wb_page *) jce;
+
+	end_page_writeback(ejwp->ejwp_page);
+	kmem_cache_free(ext4_journalled_wb_page_cachep, ejwp);
+}
+
+static noinline int __ext4_journalled_writepage(struct page *page,
+						unsigned int len,
+						struct writeback_control *wbc)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
@@ -1849,6 +1867,7 @@ static int __ext4_journalled_writepage(struct page *page,
 	int ret = 0, err = 0;
 	int inline_data = ext4_has_inline_data(inode);
 	struct buffer_head *inode_bh = NULL;
+	struct ext4_journalled_wb_page *ejwp = NULL;
 
 	ClearPageChecked(page);
 
@@ -1873,8 +1892,24 @@ static int __ext4_journalled_writepage(struct page *page,
 	 * out from under us.
 	 */
 	get_page(page);
+
+	/*
+	 * Do not set_page_writeback() before first unlocking the page, or
+	 * we can deadlock with any "lock_page(); wait_on_page_writeback();"
+	 * (example: write_cache_pages() and grab_cache_page_write_begin())
+	 * because we need to lock_page() again so to end_page_writeback().
+	 */
 	unlock_page(page);
 
+	/*
+	 * Allocate callback entry before we start the journal.
+	 *
+	 * Don't return immediately on error, because the case
+	 * of page got truncated does not need this allocation
+	 * (but is checked after we start the journal.)
+	 */
+	ejwp = kmem_cache_alloc(ext4_journalled_wb_page_cachep,	GFP_KERNEL);
+
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
 				    ext4_writepage_trans_blocks(inode));
 	if (IS_ERR(handle)) {
@@ -1891,8 +1926,42 @@ static int __ext4_journalled_writepage(struct page *page,
 		ext4_journal_stop(handle);
 		ret = 0;
 		goto out;
+	} else if (!ejwp) {
+		/* Or ejwp alloc failed */
+		ext4_journal_stop(handle);
+		ret = -ENOMEM;
+		goto out;
 	}
 
+	/*
+	 * In case writeback began while the page was unlocked.
+	 *
+	 * This can happen if another writeback task has locked
+	 * the page in the window between we unlocked/locked it
+	 * again, and made it to set_page_writeback() before us.
+	 */
+	if (PageWriteback(page)) {
+		/* Memory cleansing writeback; just let them do it. */
+		if (wbc->sync_mode == WB_SYNC_NONE) {
+			ext4_journal_stop(handle);
+			ret = 0;
+			goto out;
+		}
+
+		/* Data integrity writeback; have to wait and do it. */
+		wait_on_page_writeback(page);
+	}
+
+	/*
+	 * Add page to journalled writeback page list in transaction.
+	 * The commit callback will end_page_writeback() and free ejwp.
+	 */
+	set_page_writeback(page);
+	__ext4_journalled_wb_page_init(ejwp, page);
+	ext4_journal_callback_add(handle, __ext4_journalled_wb_end,
+				  (struct ext4_journal_cb_entry *) ejwp);
+	ejwp = NULL;
+
 	if (inline_data) {
 		ret = ext4_mark_inode_dirty(handle, inode);
 	} else {
@@ -1916,6 +1985,8 @@ static int __ext4_journalled_writepage(struct page *page,
 out:
 	unlock_page(page);
 out_no_pagelock:
+	if (ejwp)
+		kmem_cache_free(ext4_journalled_wb_page_cachep, ejwp);
 	brelse(inode_bh);
 	return ret;
 }
@@ -2027,7 +2098,7 @@ static int ext4_writepage(struct page *page,
 		 * It's mmapped pagecache.  Add buffers and journal it.  There
 		 * doesn't seem much point in redirtying the page here.
 		 */
-		return __ext4_journalled_writepage(page, len);
+		return __ext4_journalled_writepage(page, len, wbc);
 
 	ext4_io_submit_init(&io_submit, wbc);
 	io_submit.io_end = ext4_init_io_end(inode, GFP_NOFS);
@@ -5985,6 +6056,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 					    ext4_bh_unmapped)) {
 			/* Wait so that we don't change page under IO */
 			wait_for_stable_page(page);
+			if (ext4_should_journal_data(inode))
+				wait_on_page_writeback(page);
 			ret = VM_FAULT_LOCKED;
 			goto out;
 		}
-- 
2.20.1

