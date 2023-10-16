Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2B97CB3EE
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 22:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjJPULn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 16:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjJPUL0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 16:11:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B3CFF;
        Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=o2OXHpu4bV7SwS3QFGapfGfV2oXZOrEccMoa02Z5eig=; b=aIdJ8DKODFcr9EKo6DuRHl8Qx/
        a7MQ5FImQVq3IzIbfzG/gHhNKXtwSp4UR3tln2o2YYFkK6B4psH3ReRFmnCr+s/ySubrqjQD/hca/
        PkqHFHJ5l+c9E5QfuI5E0E2LCMcrnkTIf++fx2UuD6Jk0DLziicnDe1xeNRIqSt+EVguEA3JNB3xz
        RdwHudSubqKp0nHXmYT45sssjSnzzwxx66wNGTr7S4fR4KZLrWMKvyRJzZZUR3p3WcwVd9r+x6Od2
        nZ33RnvVvh+pojvnhSPpOlb8Sp8GXF9MA0DP5YrzbmCXKIyfjw6P/+5ETqO4M3vjlxK4p4OyDThR+
        eOK4EM9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsTvq-0085bi-Eu; Mon, 16 Oct 2023 20:11:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 16/27] nilfs2: Convert nilfs_lookup_dirty_data_buffers to use folio_create_empty_buffers
Date:   Mon, 16 Oct 2023 21:11:03 +0100
Message-Id: <20231016201114.1928083-17-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231016201114.1928083-1-willy@infradead.org>
References: <20231016201114.1928083-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This function was already using a folio, so this update to the new API
removes a single folio->page->folio conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 7ec16879756e..94388fe83cf8 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -731,10 +731,9 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 			continue;
 		}
 		head = folio_buffers(folio);
-		if (!head) {
-			create_empty_buffers(&folio->page, i_blocksize(inode), 0);
-			head = folio_buffers(folio);
-		}
+		if (!head)
+			head = folio_create_empty_buffers(folio,
+					i_blocksize(inode), 0);
 		folio_unlock(folio);
 
 		bh = head;
-- 
2.40.1

