Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C754F72B765
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 07:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjFLFhf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jun 2023 01:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjFLFhe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jun 2023 01:37:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29F0E57
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 22:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MquovsiA29WnbmRrIhf27B+9waioevT6KCGe7+isMDo=; b=Wr9d9RcWPUiyN79HDUsXr0iLyy
        DqmYhDSGWTgwJDZpdspFnF29MV4oRzmUN9YN/nTnSoCU7Gd+Hj/7tbW3IMDjaJw6oGzjXWrCchuDe
        8iRDHyTHIx3YnJlt88mjY6eeiJRV45gHyObfK55lASwK2os2yclFP9dMp+dA0yiF0SKLhUXWJWBbi
        exhrMdIxe4B1oc/g4wYF5rvOTC3oaNwHN7mYnYvHFKxy3q6Zbi+aZspwoTkqteZwGselUbKSNR//n
        4zYi5qJcQVFI7TjZRYyXXa7S7YFDh3HNepluRgVIAknGCpDaTuW5y2kKSOPxS1OJRxriixlJE+jFZ
        6S5+sHnQ==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8aFB-002fJP-18;
        Mon, 12 Jun 2023 05:37:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
Date:   Mon, 12 Jun 2023 07:37:31 +0200
Message-Id: <20230612053731.585947-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
wiring up a dummy direct_IO method to indicate support for direct I/O.

Do that for ext4 so that noop_direct_IO can eventually be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/file.c  | 2 +-
 fs/ext4/inode.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index d101b3b0c7dad8..a1d8ffbf571274 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -900,7 +900,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 	}
 
 	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC |
-			FMODE_DIO_PARALLEL_WRITE;
+			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
 	return dquot_file_open(inode, filp);
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 02de439bf1f04e..b9c1cfa1864779 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3539,7 +3539,6 @@ static const struct address_space_operations ext4_aops = {
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
 	.release_folio		= ext4_release_folio,
-	.direct_IO		= noop_direct_IO,
 	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
@@ -3556,7 +3555,6 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_journalled_invalidate_folio,
 	.release_folio		= ext4_release_folio,
-	.direct_IO		= noop_direct_IO,
 	.migrate_folio		= buffer_migrate_folio_norefs,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
@@ -3573,7 +3571,6 @@ static const struct address_space_operations ext4_da_aops = {
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
 	.release_folio		= ext4_release_folio,
-	.direct_IO		= noop_direct_IO,
 	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
@@ -3582,7 +3579,6 @@ static const struct address_space_operations ext4_da_aops = {
 
 static const struct address_space_operations ext4_dax_aops = {
 	.writepages		= ext4_dax_writepages,
-	.direct_IO		= noop_direct_IO,
 	.dirty_folio		= noop_dirty_folio,
 	.bmap			= ext4_bmap,
 	.swap_activate		= ext4_iomap_swap_activate,
-- 
2.39.2

