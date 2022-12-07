Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5C6460E5
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 19:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLGSKP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 13:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGSKP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 13:10:15 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F6E60B51;
        Wed,  7 Dec 2022 10:10:14 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 82so17115800pgc.0;
        Wed, 07 Dec 2022 10:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAXo1CC+DgLv8rsBENeTWCQSP6gxhN9/sRtHellAmI4=;
        b=V1arU17eo0dro0cMkfZPYd0YHgGtjRfIQwEbUUHPwbn8exlXaQdYGMQYrzdSqb+2hx
         3kkrZL685pmQA3r0JkmR+ri5O91x3EMDHlIS545Yyh8dfOUNkHEYnMS3Y9m/CeKF8ESo
         /XBAGOqVRRyxlVsBYnlruFYc/scVRL+VVjrgwO0gPBRXUEsViKzxZ1U8DMHLfzeLiGke
         5CuHJAF4PSOxoxSfrIiUe8PbJT2DO287MAkU7QVPYtmEFhxViRSNY86iSCc+807w7FMJ
         iBqNmdrZ7Idc4pzUjL8ZGTLjr0IOLuyOiFVCMBTkrtqCCZ9iIyAZOsBWA6LCZmOmFvGX
         ieTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAXo1CC+DgLv8rsBENeTWCQSP6gxhN9/sRtHellAmI4=;
        b=8QMwcpwtcUpgvKscdwzpl2+owZHHrv51O9MN/qJA+EiFOZd8G4txAtQ+f3Xd0mR5i7
         Fq4zI/cNmB/Z8NKt+rEk8F+YGHGHdSnFAAQpSY2b6Rt5saATrGIjUEZgcxk05iSMnv7o
         JKR8EVwIqBe3DvyG3DOC75mge8fc9PbhiiNm0lw/Vv15HqUKibThcSg6a03Kx1RBcvnm
         BR7lurzWO1mDSTts6O44L3da6k4rkiq7dYWOddXkBJe4zUJKFewPq/9dSSkWkEmZVkzh
         7q8EYQ73ClRASBVoDyRDg7R4xCe0xqWFEAQhXK55/hbwGxo86OpPX8XNw0mPqNdsnG2Q
         b1OQ==
X-Gm-Message-State: ANoB5pkAgCwLPXTrMIdICgDFHytojqPvw4H3m0bLN2DrU5aVIqWPJY4I
        bhFPDp7Qig7liQy/cm17irc4i/SERelWsA==
X-Google-Smtp-Source: AA0mqf7m7wuh4m5rf8Cez3jfVm/OWprGMUX0IVr1hFeuMnIv9fTJVVEUyET0IGPR7pbrif2/9j4saA==
X-Received: by 2002:a63:1e44:0:b0:478:91e1:ff60 with SMTP id p4-20020a631e44000000b0047891e1ff60mr20669074pgm.206.1670436613596;
        Wed, 07 Dec 2022 10:10:13 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id w2-20020a17090abc0200b00218f9bd50c7sm1468735pjr.50.2022.12.07.10.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 10:10:13 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH mm-unstable v2] ext4: Convert mext_page_double_lock() to mext_folio_double_lock()
Date:   Wed,  7 Dec 2022 10:10:09 -0800
Message-Id: <20221207181009.4016-1-vishal.moola@gmail.com>
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
146 bytes of kernel text. It also removes 6 calls to compound_head()
and 2 calls to folio_file_page().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

