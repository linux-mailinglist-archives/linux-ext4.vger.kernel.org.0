Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1627841B69
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2019 07:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfFLE6T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 12 Jun 2019 00:58:19 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25371 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725372AbfFLE6T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jun 2019 00:58:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560315493; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=fBLO06TDypYXLfcYm323I942j8Jfz3p+/0h1DUO3dEgvatFjGuPG4Z0ZVp3rv50MtLXDXNIX8JnIxT3cXWTgYuWC26D89bVr99QKAFRyhbfsucyZECVbWy9qintQ//qoaVMnx+GHFIE9A9DRst2u6vv+ERbiXJrzlK6mK5JFhbI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1560315493; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=5j9Ro3QjWnqVOxaE5e9lIDfdmIh9OML0i83wpjzoywE=; 
        b=LSP5qZLtkZmfFPQl1YvBS7JF7xTPgi2EfEP/L2gD4mijgcMy5OzUJCk/c4rbggjvuKbNmGhG0dDUMtFRgEOYdnGUHPZK6PV5lwelxVhGlwuS9KqHqhKzIWL02yCkNhs3Hlo+0Xulf8CJYGVOXKyzJSBrv7JKeUgkbs5iMD8PZLs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1560315491468280.50010783116977; Wed, 12 Jun 2019 12:58:11 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190612045753.12398-1-cgxu519@zoho.com.cn>
Subject: [PATCH] ext2: fix a typo in comment
Date:   Wed, 12 Jun 2019 12:57:53 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Just fix a typo in comment and remove redundant blank line
in ext2_data_block_valid().

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext2/balloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 33db13365c5e..547c165299c0 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1197,7 +1197,7 @@ static int ext2_has_free_blocks(struct ext2_sb_info *sbi)
 
 /*
  * Returns 1 if the passed-in block region is valid; 0 if some part overlaps
- * with filesystem metadata blocksi.
+ * with filesystem metadata blocks.
  */
 int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t start_blk,
 			  unsigned int count)
@@ -1212,7 +1212,6 @@ int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t start_blk,
 	    (start_blk + count >= sbi->s_sb_block))
 		return 0;
 
-
 	return 1;
 }
 
-- 
2.20.1



