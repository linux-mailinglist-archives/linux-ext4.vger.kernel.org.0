Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043B319BC2
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2019 12:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfEJKiB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 May 2019 06:38:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45548 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfEJKiB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 May 2019 06:38:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so2642366pls.12
        for <linux-ext4@vger.kernel.org>; Fri, 10 May 2019 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4m5D9QVez5Gezr6B4lMwwIgqk5O6RKFJ5LKHI9If/Kw=;
        b=AWe8S7B1/Umm/pzw4JAW929x2F5YfxJ6v2J+RYcm08QCo9S0yvh6H007u3zktQ/fsi
         4zeXq4UELTdg3tvq82ZfffU99c7eoE1B48Ihf6Q6zY7S0nrorBoYy6+7FtshpOPw/Qi0
         Yz2NdQVSRaltXbBd+v2uqttDlqHIbFktS/PT/wctbI+Ajtk/T5SJvmqHzTwezdHs2iRJ
         cObhCqQlcL/Hh19L7PomaOcA0tDpqXpdivVeO9nVVaiXkM+wgURkfwmrtPGABdv+trpZ
         ZDZf+thmLCzTHB2MHstSs4wZi42nrOSQu2H+SD0uPEHRYmY0GbJbWZ3Dwjvn/dUwRbDI
         qJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4m5D9QVez5Gezr6B4lMwwIgqk5O6RKFJ5LKHI9If/Kw=;
        b=dnhv5UfCmHSEaKdqATRJyb5Eu8HvbapguxquxDbMT+7UVx89aMo96HIle+x9YPKOs3
         R69E5vA5lUmW+Hjte9zeKw428n3yVt+yTphLWR+WpsHZPyD4/bV8w3cfvUMbsAnYKNER
         qDvIQa6MTNc5NlT27pTQGOQzkp2VyCToSTEL/jcQ/+BZ1u/oGhKx7ASTj0x34PqJiYoa
         NcuXY36zL4VW4+1zlh80oZ3+9TAJgbXVwparY1FTzBV4P33fnqYT/WAh809vlLXW3o5Y
         PBPu+ig6PyJcd6oLUnmQImiZXnw/9o43DmmeHq5p7JzBaTr46KF5+z2KcRez2oart/di
         Ij9w==
X-Gm-Message-State: APjAAAX5VSZPRzIWA414HaOy8+4MkR7mLZhMkLCaLj1wbq5LtWz0RObO
        iuoQ+ZO5zeOphLTy5zftRV/iGjb/
X-Google-Smtp-Source: APXvYqy4TXEpMVIrepZtNhVVcii+q2HSQ8CX1kjsc1i8wUUbheK0ySCpXKlsFvhQbWNRYQaOBDB+5g==
X-Received: by 2002:a17:902:5910:: with SMTP id o16mr11664840pli.289.1557484680923;
        Fri, 10 May 2019 03:38:00 -0700 (PDT)
Received: from izt4n3nohp3b5a1z8j8uuaz.localdomain ([149.129.49.136])
        by smtp.gmail.com with ESMTPSA id o73sm12396964pfi.137.2019.05.10.03.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 03:38:00 -0700 (PDT)
From:   Chengguang Xu <cgxu519@gmail.com>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@gmail.com>
Subject: [PATCH 2/2] ext2: introduce helper for xattr entry validation
Date:   Fri, 10 May 2019 18:37:46 +0800
Message-Id: <1557484666-23562-2-git-send-email-cgxu519@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557484666-23562-1-git-send-email-cgxu519@gmail.com>
References: <1557484666-23562-1-git-send-email-cgxu519@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce helper function ext2_xattr_entry_valid()
for xattr entry validation and clean up the entry
check ralated code.

Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
---
 fs/ext2/xattr.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 6e0b2b0f333f..e40fff8ab543 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -144,6 +144,20 @@ ext2_xattr_header_valid(struct buffer_head *bh)
 	return true;
 }
 
+static bool
+ext2_xattr_entry_valid(struct inode *inode, struct ext2_xattr_entry *entry,
+		       size_t size)
+{
+	if (entry->e_value_block != 0)
+		return false;
+
+	if (size > inode->i_sb->s_blocksize ||
+	    le16_to_cpu(entry->e_value_offs) + size > inode->i_sb->s_blocksize)
+		return false;
+
+	return true;
+}
+
 /*
  * ext2_xattr_get()
  *
@@ -214,11 +228,8 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 	goto cleanup;
 found:
 	/* check the buffer size */
-	if (entry->e_value_block != 0)
-		goto bad_block;
 	size = le32_to_cpu(entry->e_value_size);
-	if (size > inode->i_sb->s_blocksize ||
-	    le16_to_cpu(entry->e_value_offs) + size > inode->i_sb->s_blocksize)
+	if (!ext2_xattr_entry_valid(inode, entry, size))
 		goto bad_block;
 
 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
@@ -483,8 +494,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		if (!here->e_value_block && here->e_value_size) {
 			size_t size = le32_to_cpu(here->e_value_size);
 
-			if (le16_to_cpu(here->e_value_offs) + size > 
-			    sb->s_blocksize || size > sb->s_blocksize)
+			if (!ext2_xattr_entry_valid(inode, here, size))
 				goto bad_block;
 			free += EXT2_XATTR_SIZE(size);
 		}
-- 
2.20.1

