Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2AC12DAD0
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 19:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLaSGG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Dec 2019 13:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfLaSGE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 31 Dec 2019 13:06:04 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D30206D9
        for <linux-ext4@vger.kernel.org>; Tue, 31 Dec 2019 18:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577815563;
        bh=speQblKC3NTnG1uYbbN+xwl/PY8Y1uayarxxdq3Qk04=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=g3B83W9HjPhhczVXc2mHbUpmLqX5nLltBeteFJ7X1jUTo66ANJ6T6nJV3Sifl3UmO
         YYo39h3eoqrCVHv+W06Lg3I3+pOQsHWvgnjgopeItyUxLjeWwmEWsPbZI/OZ4JStaI
         b4JrrcWCtSrJy6Uq7xy1njlIH0b23uqzI+lNMWZw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 7/8] ext4: fix some nonstandard indentation in extents.c
Date:   Tue, 31 Dec 2019 12:04:43 -0600
Message-Id: <20191231180444.46586-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231180444.46586-1-ebiggers@kernel.org>
References: <20191231180444.46586-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Clean up some code that was using 2-character indents.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/extents.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 25e6e83cdeca..1cdcd9b0934d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -606,8 +606,9 @@ static void ext4_ext_show_path(struct inode *inode, struct ext4_ext_path *path)
 	ext_debug("path:");
 	for (k = 0; k <= l; k++, path++) {
 		if (path->p_idx) {
-		  ext_debug("  %d->%llu", le32_to_cpu(path->p_idx->ei_block),
-			    ext4_idx_pblock(path->p_idx));
+			ext_debug("  %d->%llu",
+				  le32_to_cpu(path->p_idx->ei_block),
+				  ext4_idx_pblock(path->p_idx));
 		} else if (path->p_ext) {
 			ext_debug("  %d:[%d]%d:%llu ",
 				  le32_to_cpu(path->p_ext->ee_block),
@@ -734,8 +735,8 @@ ext4_ext_binsearch_idx(struct inode *inode,
 
 		chix = ix = EXT_FIRST_INDEX(eh);
 		for (k = 0; k < le16_to_cpu(eh->eh_entries); k++, ix++) {
-		  if (k != 0 &&
-		      le32_to_cpu(ix->ei_block) <= le32_to_cpu(ix[-1].ei_block)) {
+			if (k != 0 && le32_to_cpu(ix->ei_block) <=
+			    le32_to_cpu(ix[-1].ei_block)) {
 				printk(KERN_DEBUG "k=%d, ix=0x%p, "
 				       "first=0x%p\n", k,
 				       ix, EXT_FIRST_INDEX(eh));
@@ -1589,17 +1590,16 @@ ext4_ext_next_allocated_block(struct ext4_ext_path *path)
 		return EXT_MAX_BLOCKS;
 
 	while (depth >= 0) {
+		struct ext4_ext_path *p = &path[depth];
+
 		if (depth == path->p_depth) {
 			/* leaf */
-			if (path[depth].p_ext &&
-				path[depth].p_ext !=
-					EXT_LAST_EXTENT(path[depth].p_hdr))
-			  return le32_to_cpu(path[depth].p_ext[1].ee_block);
+			if (p->p_ext && p->p_ext != EXT_LAST_EXTENT(p->p_hdr))
+				return le32_to_cpu(p->p_ext[1].ee_block);
 		} else {
 			/* index */
-			if (path[depth].p_idx !=
-					EXT_LAST_INDEX(path[depth].p_hdr))
-			  return le32_to_cpu(path[depth].p_idx[1].ei_block);
+			if (p->p_idx != EXT_LAST_INDEX(p->p_hdr))
+				return le32_to_cpu(p->p_idx[1].ei_block);
 		}
 		depth--;
 	}
-- 
2.24.1

