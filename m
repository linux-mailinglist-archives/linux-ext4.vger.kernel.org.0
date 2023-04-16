Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6936E3B41
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Apr 2023 20:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDPScR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 14:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjDPScP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 14:32:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DAD26AE
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 11:32:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51b603b3442so584196a12.3
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681669934; x=1684261934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOtbC0r36Zp4pJlCpOnapY4nEskpGw8qxR2Qca3pKVg=;
        b=KFynZPXxcVZm/nw+bQwa20sU0rvqFMXjuLCsytbvQ4Xv0SMDomU6/HMY0DNRqCHCRc
         e8VKbsyjylfPnJSLqJnoEvRCzRu4L5mB7X6V4qXPAiOAf7v9UTrgkho0i5AY7z3/QyD8
         KYvDTmZDjRsY3G8/QzIIQXxsZ530xrAhhd6Psm6D5+ua/srgWFVrEQoPs6C9TWsTqO9p
         HQD9skDcgQtPxqDjMN3NyL3hsvNbN5ENEyFBXHwKFc/1LUhIbiDm65/Y+ZaTdsMsGi/F
         k5AXIwdylTPCgTxnxj2mI4V9jgFJYvkH3bW2vyZiRtB9oKPx6zim+i/kOiCTVTcAhGlz
         pLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669934; x=1684261934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOtbC0r36Zp4pJlCpOnapY4nEskpGw8qxR2Qca3pKVg=;
        b=ilDh2Xx/c9Jv1BAAWf7PXuzve9jxbqAZzSvHdIZv/sStm46dFXzExiSNAx93V1TacF
         WD4wAO/SekXmVV/tE521OVYFiGYpljgZQM67VPpbA1XjmexmQ9VZNkTxV9OA9ZftzcQL
         XCn9L3YBZ6RLgdk1o2K7O/aUEciuMqFbiWdf8s43gWozep+g/0IoP0qYoa7Tr+jsQRV2
         EwpCjlsVch28/1oimwr2ED/1T3bdXY8GCw688YstOPyr70Uq4lICHbCppUDpe/bYcU9X
         INsffXcrxpn2Z7YBsE5i9cgc5yQdiVmJmKGe7T9dERejFsCZoNZARR11s/NW73nDLBu5
         1urA==
X-Gm-Message-State: AAQBX9dPc6xeBCb7XbC1G8q8YrB54n3x3dpES3LKkoqvgMagBSVX6Ko+
        Dy81S6qrGvxS2w0bhb1cHmT1vwDa7QQ=
X-Google-Smtp-Source: AKy350aUCixRNqk48qdMpD/x7qUbam9QXgOTrnNBEZzq+QjFY6358Kyd0+ddtrrQqbRCB7FaUwxPbA==
X-Received: by 2002:a05:6a00:14cc:b0:63b:6933:a30d with SMTP id w12-20020a056a0014cc00b0063b6933a30dmr12465703pfu.25.1681669934284;
        Sun, 16 Apr 2023 11:32:14 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7804a000000b00639fc7124c2sm6397480pfm.148.2023.04.16.11.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 11:32:13 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 3/4] ext4: Make mpage_journal_page_buffers use folio
Date:   Mon, 17 Apr 2023 00:01:52 +0530
Message-Id: <9d0fe99d45e88fd0446df745c31b561fefab898e.1681669004.git.ritesh.list@gmail.com>
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

This patch converts mpage_journal_page_buffers() to use folio and also
removes the PAGE_SIZE assumption.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5bb141288b1b..3f76b06e9aa4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2349,11 +2349,11 @@ static bool ext4_folio_nomap_can_writeout(struct folio *folio)
 	return false;
 }
 
-static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
-				     int len)
+static int ext4_journal_page_buffers(handle_t *handle, struct folio *folio,
+				     size_t len)
 {
-	struct buffer_head *page_bufs = page_buffers(page);
-	struct inode *inode = page->mapping->host;
+	struct buffer_head *page_bufs = folio_buffers(folio);
+	struct inode *inode = folio->mapping->host;
 	int ret, err;
 
 	ret = ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
@@ -2362,7 +2362,7 @@ static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
 				     NULL, write_end_fn);
 	if (ret == 0)
 		ret = err;
-	err = ext4_jbd2_inode_add_write(handle, inode, page_offset(page), len);
+	err = ext4_jbd2_inode_add_write(handle, inode, folio_pos(folio), len);
 	if (ret == 0)
 		ret = err;
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
@@ -2374,23 +2374,21 @@ static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
 
 static int mpage_journal_page_buffers(handle_t *handle,
 				      struct mpage_da_data *mpd,
-				      struct page *page)
+				      struct folio *folio)
 {
 	struct inode *inode = mpd->inode;
 	loff_t size = i_size_read(inode);
-	int len;
+	size_t len = folio_size(folio);
 
-	ClearPageChecked(page);
-	clear_page_dirty_for_io(page);
+	folio_clear_checked(folio);
+	folio_clear_dirty_for_io(folio);
 	mpd->wbc->nr_to_write--;
 
-	if (page->index == size >> PAGE_SHIFT &&
+	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(inode))
-		len = size & ~PAGE_MASK;
-	else
-		len = PAGE_SIZE;
+		len = size - folio_pos(folio);
 
-	return ext4_journal_page_buffers(handle, page, len);
+	return ext4_journal_page_buffers(handle, folio, len);
 }
 
 /*
@@ -2546,7 +2544,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 					WARN_ON_ONCE(sb->s_writers.frozen >=
 						     SB_FREEZE_FS);
 					err = mpage_journal_page_buffers(handle,
-						mpd, &folio->page);
+						mpd, folio);
 					if (err < 0)
 						goto out;
 				}
@@ -6184,7 +6182,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		err = __block_write_begin(&folio->page, 0, len, ext4_get_block);
 		if (!err) {
 			ret = VM_FAULT_SIGBUS;
-			if (ext4_journal_page_buffers(handle, &folio->page, len))
+			if (ext4_journal_page_buffers(handle, folio, len))
 				goto out_error;
 		} else {
 			folio_unlock(folio);
-- 
2.39.2

