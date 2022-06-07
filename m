Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8927253F51B
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 06:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiFGEZp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 00:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiFGEZn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 00:25:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F9B82C1
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jun 2022 21:25:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2574PRoI005548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jun 2022 00:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1654575929; bh=olb2zX9pQG1zefZy3ob6+0mT8uvUHoxPprZoXfewOTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eYUFcmnrqvrmKiqBKckXgGRBclLAsh6zda/xiu6/vaiIE9B04Fz+cU+PRcKxn3Xo/
         hI0Bj2EkefXxZZjcN8ZUTrsWH3fyqb+WBa9Gu+ulkZM2U7ZNrpYSK7YJ/mvqXJBBN1
         V8CDWW7eDX0l10OfABKRzvDGgvZi1RurhjoyPP4lyP+8eM6gbwYp1e6IaSUeG7xSpt
         iWNEFy2Eo0/LSYg5h4VxHMSJ2mfO+AJ4qxLxGA2+j0izZtS11oR3trLVbYxWktoVrw
         gns701B1gd7ydGb6Eb5dY5u+PqkMQ6KjGiwzLEXADK0BQ++iwjDurxFleyMpB6MuEY
         Omfyj7HKxi3Vw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C0A6615C3E28; Tue,  7 Jun 2022 00:25:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Nils Bars <nils.bars@rub.de>,
        =?UTF-8?q?Moritz=20Schl=C3=B6gel?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/7] e2fsck: fix potential out-of-bounds read in inc_ea_inode_refs()
Date:   Tue,  7 Jun 2022 00:24:39 -0400
Message-Id: <20220607042444.1798015-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220607042444.1798015-1-tytso@mit.edu>
References: <20220607042444.1798015-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If there isn't enough space for a full extended attribute entry,
inc_ea_inode_refs() might end up reading beyond the allocated memory
buffer.

Reported-by: Nils Bars <nils.bars@rub.de>
Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
Reported-by: Nico Schiller <nico.schiller@rub.de>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/pass1.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index dde862a8..2a17bb8a 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -389,13 +389,13 @@ static problem_t check_large_ea_inode(e2fsck_t ctx,
 static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
 			      struct ext2_ext_attr_entry *first, void *end)
 {
-	struct ext2_ext_attr_entry *entry;
+	struct ext2_ext_attr_entry *entry = first;
+	struct ext2_ext_attr_entry *np = EXT2_EXT_ATTR_NEXT(entry);
 
-	for (entry = first;
-	     (void *)entry < end && !EXT2_EXT_IS_LAST_ENTRY(entry);
-	     entry = EXT2_EXT_ATTR_NEXT(entry)) {
+	while ((void *) entry < end && (void *) np < end &&
+	       !EXT2_EXT_IS_LAST_ENTRY(entry)) {
 		if (!entry->e_value_inum)
-			continue;
+			goto next;
 		if (!ctx->ea_inode_refs) {
 			pctx->errcode = ea_refcount_create(0,
 							   &ctx->ea_inode_refs);
@@ -408,6 +408,9 @@ static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
 		}
 		ea_refcount_increment(ctx->ea_inode_refs, entry->e_value_inum,
 				      0);
+	next:
+		entry = np;
+		np = EXT2_EXT_ATTR_NEXT(entry);
 	}
 }
 
-- 
2.31.0

