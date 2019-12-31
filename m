Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2BF312DACC
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 19:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLaSGD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Dec 2019 13:06:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfLaSGC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 31 Dec 2019 13:06:02 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81999206D9
        for <linux-ext4@vger.kernel.org>; Tue, 31 Dec 2019 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577815562;
        bh=70vBevy4J9nQlxPX3DTzGyimdtIp9FkcU7tji5hsTj4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Tv2vc96n4eFV75kyhilxPvc9cOmqdpC84WziCPqzwGyVTkiOO7YVfdzZgK4Aab7Dh
         HJurDhLEDThQTCx2+2pBqOfyfTZEbcQZSsPCrfD09jGwuaW1VZjf6ce2KZJ7rGS0QQ
         vkK7kKGlJ7i1SsIAqAXoGUW7GB1f2rQSULJ4we5s=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 5/8] ext4: fix documentation for ext4_ext_try_to_merge()
Date:   Tue, 31 Dec 2019 12:04:41 -0600
Message-Id: <20191231180444.46586-6-ebiggers@kernel.org>
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

Don't mention the nonexistent return value, and mention both types of
merges that are attempted.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/extents.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 6c3f8c0ca83b..b2dee02ed238 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1827,13 +1827,14 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
 }
 
 /*
- * This function tries to merge the @ex extent to neighbours in the tree.
- * return 1 if merge left else 0.
+ * This function tries to merge the @ex extent to neighbours in the tree, then
+ * tries to collapse the extent tree into the inode.
  */
 static void ext4_ext_try_to_merge(handle_t *handle,
 				  struct inode *inode,
 				  struct ext4_ext_path *path,
-				  struct ext4_extent *ex) {
+				  struct ext4_extent *ex)
+{
 	struct ext4_extent_header *eh;
 	unsigned int depth;
 	int merge_done = 0;
-- 
2.24.1

