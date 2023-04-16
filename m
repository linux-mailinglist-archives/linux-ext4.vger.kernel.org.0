Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0269D6E3B3C
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Apr 2023 20:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDPScL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 14:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDPScK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 14:32:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0598D8
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 11:32:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso9944932pjr.3
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681669929; x=1684261929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z87Kjp9YM7OzWyGAAb9IidN5ozEldR8Bb1uFBVQ+S18=;
        b=ER6Po7rsDgXSptE+6QMFV2/1+hCg27HtKeHodmFsgvPYzZFtjEXhLUc73xX4NHj8Q8
         /taBa/QhUFuEryoznritiQWp6NtPQMdRKw0fGNKQ/DweUiLtJ8lEW6S0mKX9cQ+0u9xa
         zyLoVNqzS8Tll/pwFW3XZFS5pNHciIdutMNAiu1fZfWsRTO20bLXEvI2r8wSEScqYNwm
         yDMYB+ASf3gBg1IHhQP99LMospHsJFKwgeZbTGodRse/a/pLRRmbvsz8Sul/6yOLTdV6
         hcwDmfEtSEsH5K5Vhz80C2JQ2YJD4NIt6lvqBAUddj7G5GvKhBC+MZV8S1cpZ3tBKvhF
         kT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669929; x=1684261929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z87Kjp9YM7OzWyGAAb9IidN5ozEldR8Bb1uFBVQ+S18=;
        b=gI1HNPNNWmRNwzT7p7OjRLdqEYdgfKIe+/U7gAZPh8CEnjJ9SRDnbf63T5pPLuxhOH
         diHm6i6HUhL8P+OT+WqBiniF+wNSy4YZTsWWJXjXnchzDrKyEnLtyMyxWlhHRPqLH/M/
         H5Bw9WGdlxDxVxtb8kI2EkxyHUSP6SFTKAS926VHhQx/gcEgAbcqY1RInwDlsX08kE8j
         pnbTVRuv96oBQXqcHoSQpQCjgP9CKP3y+sVMaxmYwzpCvTvn2OABFMRN1oNMK2HBm4PL
         jlORAHRn5BfuSPlLI//hi0nQV45BJWDoPlVp9VIeiRaACyWWqb1n4wVOf6SjYP0kQzoU
         nJsQ==
X-Gm-Message-State: AAQBX9eLsx0rrId0rdu+86A/mqPa09c/CtY0A6bbpTFvnJPY34f/W2ca
        6tNfyk/mt8PoWC7T7A6V41w=
X-Google-Smtp-Source: AKy350YlekDCFS7gyOs8JZ/sFVDYdQ5ovrvAT+50Uqpz5+yhtGZjLcWR+VSNNfNAsQR2gLjvCgoHSw==
X-Received: by 2002:a05:6a20:8427:b0:ee:454f:11d8 with SMTP id c39-20020a056a20842700b000ee454f11d8mr11016937pzd.40.1681669929156;
        Sun, 16 Apr 2023 11:32:09 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7804a000000b00639fc7124c2sm6397480pfm.148.2023.04.16.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 11:32:08 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 1/4] ext4: kill unused function ext4_journalled_write_inline_data
Date:   Mon, 17 Apr 2023 00:01:50 +0530
Message-Id: <672a2ebb430d05f72d36a35341ce805a8a0ea9a6.1681669004.git.ritesh.list@gmail.com>
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

Commit 3f079114bf522 ("ext4: Convert data=journal writeback to use ext4_writepages()")
Added support for writeback of journalled data into ext4_writepages()
and killed function __ext4_journalled_writepage() which used to call
ext4_journalled_write_inline_data() for inline data.
This function got left over by mistake. Hence kill it's definition as
no one uses it.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h   |  4 ----
 fs/ext4/inline.c | 24 ------------------------
 2 files changed, 28 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 83f0cc02250f..b00597b41c96 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3558,10 +3558,6 @@ extern int ext4_write_inline_data_end(struct inode *inode,
 				      loff_t pos, unsigned len,
 				      unsigned copied,
 				      struct page *page);
-extern struct buffer_head *
-ext4_journalled_write_inline_data(struct inode *inode,
-				  unsigned len,
-				  struct page *page);
 extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
 					   struct inode *inode,
 					   loff_t pos, unsigned len,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index b9fb1177fff6..062c7747bb40 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -812,30 +812,6 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 	return ret ? ret : copied;
 }
 
-struct buffer_head *
-ext4_journalled_write_inline_data(struct inode *inode,
-				  unsigned len,
-				  struct page *page)
-{
-	int ret, no_expand;
-	void *kaddr;
-	struct ext4_iloc iloc;
-
-	ret = ext4_get_inode_loc(inode, &iloc);
-	if (ret) {
-		ext4_std_error(inode->i_sb, ret);
-		return NULL;
-	}
-
-	ext4_write_lock_xattr(inode, &no_expand);
-	kaddr = kmap_atomic(page);
-	ext4_write_inline_data(inode, &iloc, kaddr, 0, len);
-	kunmap_atomic(kaddr);
-	ext4_write_unlock_xattr(inode, &no_expand);
-
-	return iloc.bh;
-}
-
 /*
  * Try to make the page cache and handle ready for the inline data case.
  * We can call this function in 2 cases:
-- 
2.39.2

