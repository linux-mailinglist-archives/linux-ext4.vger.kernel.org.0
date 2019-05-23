Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B94428134
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2019 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfEWPbN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 May 2019 11:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730760AbfEWPbM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 May 2019 11:31:12 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C08206BA
        for <linux-ext4@vger.kernel.org>; Thu, 23 May 2019 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558625472;
        bh=R6OUXHozVu/WNCgm4mjk6EqcMyrY+AYZqwiaXY3xGX0=;
        h=From:To:Subject:Date:From;
        b=ycSJAVVmMqy8Q1v8L3uc8wIc8X43ZK1bMuDOXOfV3FBZZjFhoM3acpBbtX3Svu9Mt
         vtAdcJ0x3nMZr/9t81ck+vgcU7QzE5PKifaTlZ3QCuB5/YWAgWDk4lgxYFdTNEPROg
         2ePXfLQPBTviZBK5h4aUJ1LVEBY2AYTICiFtDBak=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] e2fsck: handle verity files in scan_extent_node()
Date:   Thu, 23 May 2019 08:30:33 -0700
Message-Id: <20190523153033.22487-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Don't report PR_1_EXTENT_END_OUT_OF_BOUNDS on verity files during
scan_extent_node(), since they will have blocks stored past i_size.

This was missed during the earlier fix because this check only triggers
if the inode has enough extents to need at least one extent index node.

This bug is causing one of the fs-verity xfstests to fail with the
reworked fs-verity patchset.

Fixes: 3baafde6a8ae ("e2fsck: allow verity files to have initialized blocks past i_size")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 e2fsck/pass1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 5c413610..524577ae 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2812,8 +2812,9 @@ static void scan_extent_node(e2fsck_t ctx, struct problem_context *pctx,
 		else if (extent.e_lblk < start_block)
 			problem = PR_1_OUT_OF_ORDER_EXTENTS;
 		else if ((end_block && last_lblk > end_block) &&
-			 (!(extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT &&
-				last_lblk > eof_block)))
+			 !(last_lblk > eof_block &&
+			   ((extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT) ||
+			    (pctx->inode->i_flags & EXT4_VERITY_FL))))
 			problem = PR_1_EXTENT_END_OUT_OF_BOUNDS;
 		else if (is_leaf && extent.e_len == 0)
 			problem = PR_1_EXTENT_LENGTH_ZERO;
-- 
2.21.0

