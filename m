Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02CC2C6A5A
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbgK0RBk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 12:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbgK0RBj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Nov 2020 12:01:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95217C0613D1
        for <linux-ext4@vger.kernel.org>; Fri, 27 Nov 2020 09:01:39 -0800 (PST)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:5a64:74b8:f3be:d972])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1629A1F40ED0;
        Fri, 27 Nov 2020 17:01:38 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v2 09/12] e2fsck: Detect duplicated casefolded direntries for rehash
Date:   Fri, 27 Nov 2020 18:01:13 +0100
Message-Id: <20201127170116.197901-10-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
References: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

On pass2, support casefolded directories when looking for duplicated
entries.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 e2fsck/pass2.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index b62bfcb1..b6514de8 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -344,6 +344,20 @@ static int dict_de_cmp(const void *cmp_ctx, const void *a, const void *b)
 	return memcmp(de_a->name, de_b->name, a_len);
 }
 
+static int dict_de_cf_cmp(const void *cmp_ctx, const void *a, const void *b)
+{
+	const struct ext2fs_nls_table *tbl = cmp_ctx;
+	const struct ext2_dir_entry *de_a, *de_b;
+	int	a_len, b_len;
+
+	de_a = (const struct ext2_dir_entry *) a;
+	a_len = ext2fs_dirent_name_len(de_a);
+	de_b = (const struct ext2_dir_entry *) b;
+	b_len = ext2fs_dirent_name_len(de_b);
+
+	return ext2fs_casefold_cmp(tbl, de_a->name, a_len, de_b->name, b_len);
+}
+
 /*
  * This is special sort function that makes sure that directory blocks
  * with a dirblock of zero are sorted to the beginning of the list.
@@ -1255,7 +1269,13 @@ skip_checksum:
 
 	dir_encpolicy_id = find_encryption_policy(ctx, ino);
 
-	dict_init(&de_dict, DICTCOUNT_T_MAX, dict_de_cmp);
+	if (cf_dir) {
+		dict_init(&de_dict, DICTCOUNT_T_MAX, dict_de_cf_cmp);
+		dict_set_cmp_context(&de_dict, (void *)ctx->fs->encoding);
+	} else {
+		dict_init(&de_dict, DICTCOUNT_T_MAX, dict_de_cmp);
+	}
+
 	prev = 0;
 	do {
 		dgrp_t group;
-- 
2.28.0

