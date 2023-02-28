Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD746A528F
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 06:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjB1FNd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 00:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1FNb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 00:13:31 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9B1BBA5
        for <linux-ext4@vger.kernel.org>; Mon, 27 Feb 2023 21:13:30 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31S5DOAY002525
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 00:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677561205; bh=rBBZSoCDvMuLWkaKBet1mvvvsZ/dWrLwbRHOOSZSVnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NAk78NUVeMqEorr13Y6Jc4ZcQUMZdzhA6XeCghk6GEQMIXB9BIbpxJCls/nahFNSC
         z+17pjG1ZE9imXEuwcLucMneuqTM0RTXFZEYMc15B43PoZ+E9c/29G1kHqRnWiN+Vu
         qA2suBgu7UjitEubqaF/BNc3EnqVLsyJtFMYwMnx94MRDcN8LvpdqM9SFMtS50NxWg
         z/csgxkzh75O3JVIsD9AavxKLcQoyzVI7b5xVLlxJbexuVLCeeX74BM4x/9ST3uem6
         RxMSWL83sEw+V9o1BGmO6Bc/49wrjQdKbpQpZ7jAxCcHQmLkwIqsjHKTVTg49308iE
         WgB2MOGrO824A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2F6F815C5826; Tue, 28 Feb 2023 00:13:24 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/7] ext4: Mark page for delayed dirtying only if it is pinned
Date:   Tue, 28 Feb 2023 00:13:15 -0500
Message-Id: <20230228051319.4085470-4-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230228051319.4085470-1-tytso@mit.edu>
References: <20230228051319.4085470-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara <jack@suse.cz>

In data=journal mode, page should be dirtied only when it has buffers
for checkpoint or it is writeably mapped. In the first case, we don't
need to do anything special. In the second case, page was already added
to the journal by ext4_page_mkwrite() and since transaction commit
writeprotects mapped pages again, page should be writeable (and thus
dirtied) only while it is part of the running transaction. So nothing
needs to be done either. The only special case is when someone pins the
page and uses this pin for modifying page data. So recognize this
special case and only then mark the page as having data that needs
adding to the journal.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 98dd50d7e72a..5c1d1b0bf5ee 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3669,24 +3669,26 @@ const struct iomap_ops ext4_iomap_report_ops = {
 };
 
 /*
- * Whenever the folio is being dirtied, corresponding buffers should already
- * be attached to the transaction (we take care of this in ext4_page_mkwrite()
- * and ext4_write_begin()). However we cannot move buffers to dirty transaction
- * lists here because ->dirty_folio is called under VFS locks and the folio
- * is not necessarily locked.
- *
- * We cannot just dirty the folio and leave attached buffers clean, because the
- * buffers' dirty state is "definitive".  We cannot just set the buffers dirty
- * or jbddirty because all the journalling code will explode.
- *
- * So what we do is to mark the folio "pending dirty" and next time writepage
- * is called, propagate that into the buffers appropriately.
+ * For data=journal mode, folio should be marked dirty only when it was
+ * writeably mapped. When that happens, it was already attached to the
+ * transaction and marked as jbddirty (we take care of this in
+ * ext4_page_mkwrite()). On transaction commit, we writeprotect page mappings
+ * so we should have nothing to do here, except for the case when someone
+ * had the page pinned and dirtied the page through this pin (e.g. by doing
+ * direct IO to it). In that case we'd need to attach buffers here to the
+ * transaction but we cannot due to lock ordering.  We cannot just dirty the
+ * folio and leave attached buffers clean, because the buffers' dirty state is
+ * "definitive".  We cannot just set the buffers dirty or jbddirty because all
+ * the journalling code will explode.  So what we do is to mark the folio
+ * "pending dirty" and next time ext4_writepages() is called, attach buffers
+ * to the transaction appropriately.
  */
 static bool ext4_journalled_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
 	WARN_ON_ONCE(!folio_buffers(folio));
-	folio_set_checked(folio);
+	if (folio_maybe_dma_pinned(folio))
+		folio_set_checked(folio);
 	return filemap_dirty_folio(mapping, folio);
 }
 
-- 
2.31.0

