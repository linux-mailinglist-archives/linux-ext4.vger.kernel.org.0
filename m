Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A67644D62
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 21:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLFUlZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 15:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLFUlY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 15:41:24 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF7C140CE;
        Tue,  6 Dec 2022 12:41:24 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 6so14419972pgm.6;
        Tue, 06 Dec 2022 12:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eqWyNBxC7NJydI2Uy3WCSu1/x0WVl3HUjLnH2tKSHz0=;
        b=WhvZ48cWD9H2UdGKE8MTubyz082b8vFSiHI4fwwvNgXWTH0/Yhz/GJSekQ5KZ6ULlP
         qoEciX4aSmGMxRoRQTuoluXKlSzaO0fgZK8Umc7JVibYozGKBmJe2w3yoyopt+q6XADD
         1buET3PVsu8NEgKnY77RQw72M1hxzNos1UTrgoYYKYeTzYBPw7qqruUv2C2/KyU7Mg7/
         CgtV8jxlo8cEMTq3RqEnjkLltIabVYQ7bzJmqSJNlIjrD8bZrNquop+HVYxIMuKIGOLU
         v2hrgFp6sSGJXYvqo251qfOXkG4p0UcPmQF0c67kWiRYTP6YvcdLl+l/2KSiWmS8Fq5h
         GJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqWyNBxC7NJydI2Uy3WCSu1/x0WVl3HUjLnH2tKSHz0=;
        b=NbuNrB9MyGoT/7B5iaa0f8/b21lzxUyZ+3JG3mO4o88Dt+OPM15Nb46WYCA096sdDg
         ByHvNUaNIikp3pNq1ysQ80LxoBjcnjdxlQ6hdqJqkwMcK6kpaW3XRgnqySC7fVN/4olA
         vEhiAhOk+t8UTivc70BDv6/YAkE/CQnwgmlPSFWRrO39lWFjWCa6w0R2C5pZ6r7/t/Gb
         XDbdKo5InvJMgVqPSoiJZmLhLfUy30j27RylqkMld8Dxuin7KgMm+YpzoFFeGUtyuMzr
         FZk/3OV3ypzUUUZSJw6IxewR1fB9qMOlzEwBDRIehAWh46iOvam6momgW0FwpOrcV8IN
         f3Uw==
X-Gm-Message-State: ANoB5pn/3ib0uN5ISoCer6cq6NgVIjtz/CvQzP0dK6MIPnprh1zBvDn5
        EeUydd+LtOigbzBlsYTtMcs=
X-Google-Smtp-Source: AA0mqf56Zz5d5PLS0OHSiNp/sFuA+5x82yz9SW00LlPfe7Jo3yPXXLB0jApKcQmEVksgRJ2TiKy2nQ==
X-Received: by 2002:aa7:982b:0:b0:577:391e:16ac with SMTP id q11-20020aa7982b000000b00577391e16acmr5304762pfl.38.1670359283372;
        Tue, 06 Dec 2022 12:41:23 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id o25-20020aa79799000000b005769b244c2fsm6599295pfp.40.2022.12.06.12.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 12:41:22 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable] ext4: Convert mext_page_double_lock() to mext_folio_double_lock()
Date:   Tue,  6 Dec 2022 12:41:15 -0800
Message-Id: <20221206204115.35258-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Converts mext_page_double_lock() to use folios. This change saves
146 bytes of kernel text and removes 3 calls to compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/ext4/move_extent.c | 46 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 8dbb87edf24c..2de9829aed63 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -110,22 +110,23 @@ mext_check_coverage(struct inode *inode, ext4_lblk_t from, ext4_lblk_t count,
 }
 
 /**
- * mext_page_double_lock - Grab and lock pages on both @inode1 and @inode2
+ * mext_folio_double_lock - Grab and lock folio on both @inode1 and @inode2
  *
  * @inode1:	the inode structure
  * @inode2:	the inode structure
- * @index1:	page index
- * @index2:	page index
- * @page:	result page vector
+ * @index1:	folio index
+ * @index2:	folio index
+ * @folio:	result folio vector
  *
- * Grab two locked pages for inode's by inode order
+ * Grab two locked folio for inode's by inode order
  */
 static int
-mext_page_double_lock(struct inode *inode1, struct inode *inode2,
-		      pgoff_t index1, pgoff_t index2, struct page *page[2])
+mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
+		      pgoff_t index1, pgoff_t index2, struct folio *folio[2])
 {
 	struct address_space *mapping[2];
 	unsigned int flags;
+	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
 
 	BUG_ON(!inode1 || !inode2);
 	if (inode1 < inode2) {
@@ -138,28 +139,30 @@ mext_page_double_lock(struct inode *inode1, struct inode *inode2,
 	}
 
 	flags = memalloc_nofs_save();
-	page[0] = grab_cache_page_write_begin(mapping[0], index1);
-	if (!page[0]) {
+	folio[0] = __filemap_get_folio(mapping[0], index1, fgp_flags,
+			mapping_gfp_mask(mapping[0]));
+	if (!folio[0]) {
 		memalloc_nofs_restore(flags);
 		return -ENOMEM;
 	}
 
-	page[1] = grab_cache_page_write_begin(mapping[1], index2);
+	folio[1] = __filemap_get_folio(mapping[1], index2, fgp_flags,
+			mapping_gfp_mask(mapping[1]));
 	memalloc_nofs_restore(flags);
-	if (!page[1]) {
-		unlock_page(page[0]);
-		put_page(page[0]);
+	if (!folio[1]) {
+		folio_unlock(folio[0]);
+		folio_put(folio[0]);
 		return -ENOMEM;
 	}
 	/*
-	 * grab_cache_page_write_begin() may not wait on page's writeback if
+	 * __filemap_get_folio() may not wait on folio's writeback if
 	 * BDI not demand that. But it is reasonable to be very conservative
-	 * here and explicitly wait on page's writeback
+	 * here and explicitly wait on folio's writeback
 	 */
-	wait_on_page_writeback(page[0]);
-	wait_on_page_writeback(page[1]);
+	folio_wait_writeback(folio[0]);
+	folio_wait_writeback(folio[1]);
 	if (inode1 > inode2)
-		swap(page[0], page[1]);
+		swap(folio[0], folio[1]);
 
 	return 0;
 }
@@ -252,7 +255,6 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		     int block_len_in_page, int unwritten, int *err)
 {
 	struct inode *orig_inode = file_inode(o_filp);
-	struct page *pagep[2] = {NULL, NULL};
 	struct folio *folio[2] = {NULL, NULL};
 	handle_t *handle;
 	ext4_lblk_t orig_blk_offset, donor_blk_offset;
@@ -303,8 +305,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 
 	replaced_size = data_size;
 
-	*err = mext_page_double_lock(orig_inode, donor_inode, orig_page_offset,
-				     donor_page_offset, pagep);
+	*err = mext_folio_double_lock(orig_inode, donor_inode, orig_page_offset,
+				     donor_page_offset, folio);
 	if (unlikely(*err < 0))
 		goto stop_journal;
 	/*
@@ -314,8 +316,6 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	 * hold page's lock, if it is still the case data copy is not
 	 * necessary, just swap data blocks between orig and donor.
 	 */
-	folio[0] = page_folio(pagep[0]);
-	folio[1] = page_folio(pagep[1]);
 
 	VM_BUG_ON_FOLIO(folio_test_large(folio[0]), folio[0]);
 	VM_BUG_ON_FOLIO(folio_test_large(folio[1]), folio[1]);
-- 
2.38.1

