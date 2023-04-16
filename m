Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D176E3B42
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Apr 2023 20:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDPScY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 14:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDPScS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 14:32:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF0026AD
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 11:32:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso933983b3a.2
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 11:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681669937; x=1684261937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbOFG8fSiRwOGb5XcEmRguhRbsdtfEatbruVd/CWl4g=;
        b=Dsa0zYSuaQyPx5GMhAh2MoaLAGc3Rc+Hf3i/VfwkAgMAim3fC7tTcRNcNpXT6UEBTp
         9ez2ZNUMPuRBpW+yYWCBFHApU44m7wDZ4P0VwMMOZyx2GxEL/ieTsyzgfv8BfMBR9urN
         twVmf2ZmRuxEbgA9I1M+vd+8dXZ6bSck1ojBuWyaIL0nhjfuJbzIu4BAb3TN+Zkg+t0T
         YOI+Qg26h7ASZI08M+O3n59wm8AHJD8OLk7fwGTeO8o/K0EqRIxhXm5WiCcBpr1EjZ5q
         IX3xtIzIMM68rg/OtpTgLdgih/LoetXT2JuO5UPN07/W4qsihN4qibm7+YGLgpbZUGWT
         ch+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669937; x=1684261937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbOFG8fSiRwOGb5XcEmRguhRbsdtfEatbruVd/CWl4g=;
        b=cg2LlroWHXuoUl7kA2LaiHJDn18WfxY6MIKkun8iXKKMEQ3QtiA635H2eE1ylCYvUR
         duA2LaeoIeM7sPyfN9v5hHFWHxZwGO6iDBLaiqGzp3OsCPfVxL0ZfJjIXs0Ay/zSSSTO
         rPgj2xeOl84Vm0uyFWP7SjGn5Hf18A7LNjhaWzkE2AR3k+OzHuIEzNoASqWq8vgQjPR0
         SZx+bQMdfQwe1tVwqQHNjKpP9fgDSCWHeHRi5MBT0jgJxYrBXJma3iiT+NohX3NSa8E4
         05PF2sDOgeI95JP2nPQuSYCDC8c9BpTH4IXDjskSGoSvuZkwO/ES4slwhSap8J+zhHx5
         Tmhg==
X-Gm-Message-State: AAQBX9drFhUmslJMDAwTdAmBIZRs2NMDYOem2t5Ag3VbquVregz2YVN/
        8z+3K7SZq1gH25SR9davMgU=
X-Google-Smtp-Source: AKy350YFijkPQp5VJPfKj0fwpNuFAtwcLY/yoJkZf3h4eoyePJyHRQvftgEOPQR0Cbtv/zlfyiC4HQ==
X-Received: by 2002:a05:6a00:1402:b0:62d:e966:ffcb with SMTP id l2-20020a056a00140200b0062de966ffcbmr18490713pfu.0.1681669936927;
        Sun, 16 Apr 2023 11:32:16 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7804a000000b00639fc7124c2sm6397480pfm.148.2023.04.16.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 11:32:16 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 4/4] ext4: Make ext4_write_inline_data_end() use folio
Date:   Mon, 17 Apr 2023 00:01:53 +0530
Message-Id: <fb2cc9faae28d1abb2694c54fb49122cb0368e9c.1681669004.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681669004.git.ritesh.list@gmail.com>
References: <cover.1681669004.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_write_inline_data_end() is completely converted to work with folio.
Also all callers of ext4_write_inline_data_end() already works on folio
except ext4_da_write_end(). Mostly for consistency and saving few
instructions maybe, this patch just converts ext4_da_write_end() to work
with folio which makes the last caller of ext4_write_inline_data_end()
also converted to work with folio.
We then make ext4_write_inline_data_end() take folio instead of page.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h   |  6 ++----
 fs/ext4/inline.c |  3 +--
 fs/ext4/inode.c  | 23 ++++++++++++++---------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b00597b41c96..081f04ea2be0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3554,10 +3554,8 @@ extern int ext4_try_to_write_inline_data(struct address_space *mapping,
 					 struct inode *inode,
 					 loff_t pos, unsigned len,
 					 struct page **pagep);
-extern int ext4_write_inline_data_end(struct inode *inode,
-				      loff_t pos, unsigned len,
-				      unsigned copied,
-				      struct page *page);
+int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
+			       unsigned copied, struct folio *folio);
 extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
 					   struct inode *inode,
 					   loff_t pos, unsigned len,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 062c7747bb40..eee78035c12d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -730,9 +730,8 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 }
 
 int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
-			       unsigned copied, struct page *page)
+			       unsigned copied, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	int no_expand;
 	void *kaddr;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3f76b06e9aa4..741e4ff63992 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1302,7 +1302,8 @@ static int ext4_write_end(struct file *file,
 
 	if (ext4_has_inline_data(inode) &&
 	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
-		return ext4_write_inline_data_end(inode, pos, len, copied, page);
+		return ext4_write_inline_data_end(inode, pos, len, copied,
+						  folio);
 
 	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
 	/*
@@ -1410,7 +1411,8 @@ static int ext4_journalled_write_end(struct file *file,
 	BUG_ON(!ext4_handle_valid(handle));
 
 	if (ext4_has_inline_data(inode))
-		return ext4_write_inline_data_end(inode, pos, len, copied, page);
+		return ext4_write_inline_data_end(inode, pos, len, copied,
+						  folio);
 
 	if (unlikely(copied < len) && !folio_test_uptodate(folio)) {
 		copied = 0;
@@ -2966,15 +2968,15 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
  * Check if we should update i_disksize
  * when write to the end of file but not require block allocation
  */
-static int ext4_da_should_update_i_disksize(struct page *page,
+static int ext4_da_should_update_i_disksize(struct folio *folio,
 					    unsigned long offset)
 {
 	struct buffer_head *bh;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	unsigned int idx;
 	int i;
 
-	bh = page_buffers(page);
+	bh = folio_buffers(folio);
 	idx = offset >> inode->i_blkbits;
 
 	for (i = 0; i < idx; i++)
@@ -2994,17 +2996,19 @@ static int ext4_da_write_end(struct file *file,
 	loff_t new_i_size;
 	unsigned long start, end;
 	int write_mode = (int)(unsigned long)fsdata;
+	struct folio *folio = page_folio(page);
 
 	if (write_mode == FALL_BACK_TO_NONDELALLOC)
 		return ext4_write_end(file, mapping, pos,
-				      len, copied, page, fsdata);
+				      len, copied, &folio->page, fsdata);
 
 	trace_ext4_da_write_end(inode, pos, len, copied);
 
 	if (write_mode != CONVERT_INLINE_DATA &&
 	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
 	    ext4_has_inline_data(inode))
-		return ext4_write_inline_data_end(inode, pos, len, copied, page);
+		return ext4_write_inline_data_end(inode, pos, len, copied,
+						  folio);
 
 	start = pos & (PAGE_SIZE - 1);
 	end = start + copied - 1;
@@ -3025,10 +3029,11 @@ static int ext4_da_write_end(struct file *file,
 	 */
 	new_i_size = pos + copied;
 	if (copied && new_i_size > inode->i_size &&
-	    ext4_da_should_update_i_disksize(page, end))
+	    ext4_da_should_update_i_disksize(folio, end))
 		ext4_update_i_disksize(inode, new_i_size);
 
-	return generic_write_end(file, mapping, pos, len, copied, page, fsdata);
+	return generic_write_end(file, mapping, pos, len, copied, &folio->page,
+				 fsdata);
 }
 
 /*
-- 
2.39.2

