Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E51B6E3B3F
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Apr 2023 20:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDPScQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjDPScN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 14:32:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A36812E
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 11:32:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2472a3bfd23so443128a91.3
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681669932; x=1684261932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00mk0GNZvVOewMgATUKCXNDIHhLsHNJ2Ui4jNSOHZA8=;
        b=Br1Bm8FE2OaAxM/Urmf+U5z10r+aD2YOHLB1C5eJ8xoDtFFKIuntDfuu9tHp/5I5Nc
         V9dHUfSVYfL5g8w7dSgr6b0/SX52gMGQ0m6eaweASa/j/icBcZeFJKJY19YBViSf3sM+
         Ier1+IxlGbgHljvTX7xCT2XKbxht/Lqz9satwgZuN05Y3+wX2Q1qVqQ4TkaaQNx4XYO6
         o5ogzhSeMoS+v4ZZzRPb26wCgAe2tGzN/8+4yNKf3BxneIE9OfMMSBprqXM6A/8d091J
         Exzg/IAIUcZCLg20l0f++z86A5ffUyvOZW8+dGAWFx2yFXBGueyLNgHIJrStadXJFpAQ
         fo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669932; x=1684261932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00mk0GNZvVOewMgATUKCXNDIHhLsHNJ2Ui4jNSOHZA8=;
        b=HEz6/VKSvippfLWKyTspbwtk1Xi+q3a0qVGCbMM3SfmXDUw9HWwwXgIzjGNXHIYvC/
         5oCIxPh8oj8QZWAkPsEToJGyRHqiX9Mr1R3gp8te+kvgex96BeuP4cIETS/umquG2iBE
         6RVk1KV56RU/VHWvlorfwonsl02iXTrLY/S7xBVYPFR64b0SXrDMKWkjYrjlzCPKMExY
         a3hJkOvb3rWApfeKECC5f4dweTSpTjsPsOHvQs9Hg9GEAgL6WrocNKJHhTgbH/T6SuGS
         CpVkxS4UGNUn062Z3yxE+eP70+wuVSNBimomnhzpEg2emxsXnxa3WtMGjSt++fuGd8P9
         tung==
X-Gm-Message-State: AAQBX9ctNFy0tU5AXSuPMC6ZJwE1VDczdondyRkd0xSN5U43sGcPiTf+
        zR7Tj4ibZorqaoqxFs9Mw+Q=
X-Google-Smtp-Source: AKy350bQLGigurP3dnz7qGvKcbX/qwOwlB9ub+0GbUNQ+nwdsD/JHgO572G4IQVFrY5M7jWHX9d5Pg==
X-Received: by 2002:a05:6a00:9a2:b0:63b:8778:99f7 with SMTP id u34-20020a056a0009a200b0063b877899f7mr4480690pfg.9.1681669931820;
        Sun, 16 Apr 2023 11:32:11 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7804a000000b00639fc7124c2sm6397480pfm.148.2023.04.16.11.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 11:32:11 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 2/4] ext4: Change remaining tracepoints to use folio
Date:   Mon, 17 Apr 2023 00:01:51 +0530
Message-Id: <c9add7e988b0a64d448892da806e3b623c6cf8d3.1681669004.git.ritesh.list@gmail.com>
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

est4_readpage() is converted to ext4_read_folio() hence change the
related tracepoint from trace_ext4_readpage(page) to
trace_ext4_read_folio(folio).

Do the same for trace_ext4_releasepage(page) to
trace_ext4_release_folio(folio)

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c             |  4 ++--
 include/trace/events/ext4.h | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6d628d6c0847..5bb141288b1b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3157,7 +3157,7 @@ static int ext4_read_folio(struct file *file, struct folio *folio)
 	int ret = -EAGAIN;
 	struct inode *inode = folio->mapping->host;
 
-	trace_ext4_readpage(&folio->page);
+	trace_ext4_read_folio(folio);
 
 	if (ext4_has_inline_data(inode))
 		ret = ext4_readpage_inline(inode, folio);
@@ -3218,7 +3218,7 @@ static bool ext4_release_folio(struct folio *folio, gfp_t wait)
 {
 	journal_t *journal = EXT4_JOURNAL(folio->mapping->host);
 
-	trace_ext4_releasepage(&folio->page);
+	trace_ext4_release_folio(folio);
 
 	/* Page has dirty journalled data -> cannot release */
 	if (folio_test_checked(folio))
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index ebccf6a6aa1b..a9415f1c68ec 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -560,10 +560,10 @@ TRACE_EVENT(ext4_writepages_result,
 		  (unsigned long) __entry->writeback_index)
 );
 
-DECLARE_EVENT_CLASS(ext4__page_op,
-	TP_PROTO(struct page *page),
+DECLARE_EVENT_CLASS(ext4__folio_op,
+	TP_PROTO(struct folio *folio),
 
-	TP_ARGS(page),
+	TP_ARGS(folio),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
@@ -573,29 +573,29 @@ DECLARE_EVENT_CLASS(ext4__page_op,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= page->mapping->host->i_sb->s_dev;
-		__entry->ino	= page->mapping->host->i_ino;
-		__entry->index	= page->index;
+		__entry->dev	= folio->mapping->host->i_sb->s_dev;
+		__entry->ino	= folio->mapping->host->i_ino;
+		__entry->index	= folio->index;
 	),
 
-	TP_printk("dev %d,%d ino %lu page_index %lu",
+	TP_printk("dev %d,%d ino %lu folio_index %lu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  (unsigned long) __entry->index)
 );
 
-DEFINE_EVENT(ext4__page_op, ext4_readpage,
+DEFINE_EVENT(ext4__folio_op, ext4_read_folio,
 
-	TP_PROTO(struct page *page),
+	TP_PROTO(struct folio *folio),
 
-	TP_ARGS(page)
+	TP_ARGS(folio)
 );
 
-DEFINE_EVENT(ext4__page_op, ext4_releasepage,
+DEFINE_EVENT(ext4__folio_op, ext4_release_folio,
 
-	TP_PROTO(struct page *page),
+	TP_PROTO(struct folio *folio),
 
-	TP_ARGS(page)
+	TP_ARGS(folio)
 );
 
 DECLARE_EVENT_CLASS(ext4_invalidate_folio_op,
-- 
2.39.2

