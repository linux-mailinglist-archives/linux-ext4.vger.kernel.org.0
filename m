Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482461B69FC
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgDWXhg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55846 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgDWXhf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:35 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlPS-0003tn-0h
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:34 +0000
Received: by mail-qk1-f198.google.com with SMTP id x5so8610437qkn.20
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KpVptCR3xvPiqteH6asEwl4abaaf4QlLND8iNO+ELo=;
        b=c/0AVWqjGVny7Y3jduCRV/+Ad44vw0iBCPrkFLmADXwsVkLpruL0dk5b0uK0MGzOWX
         hxyaW6e1vY0J3HdTSAQKjZA9CZxoQwmzJeVw0HU1antATRQGh8OLJuQ+/B83+M6dvHJn
         0yEdGZSPGPuLv5ECPgKEAu8qoERm5QJqzTtt4HLM08eymeF0g6KKdDVCe9UaOkJyMhGk
         OsvmoVk1haxeZhANfpQ8+pXrqTQ4WF9ZwC1lS4waqKAbm3hg7pokl8ljet+TM9Jb4Td1
         QEeYaklumIlrtdcynaNzlJ7eDWlqGwcg8RNff6hToDwswmu+fclWDnquW6DeIM9FcCf9
         hYtg==
X-Gm-Message-State: AGi0PuZcRDhV8fmgle4iaLW12XN93Ub3ccLUOYB9snaTL5jilJ4fp7DZ
        4Tvu1xt5qD03/yvWXrEAj2tbxdmMryGGZkEpGk0/gz9VPYiGhvG/jB6NZjDh0XJ9kt45J8ed4hs
        0kORfh4F8fk1aIZ1sDREU4xHMn8siRRRDrlfvf78=
X-Received: by 2002:a37:a0c7:: with SMTP id j190mr5943395qke.461.1587685052937;
        Thu, 23 Apr 2020 16:37:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypKKhbMgbLozXvdPiK3ZPKfNefJJVx4DfyQ8boSCJN+LUq9DsCy3AIF20L4lDT0KhPQmL7OObQ==
X-Received: by 2002:a37:a0c7:: with SMTP id j190mr5943377qke.461.1587685052714;
        Thu, 23 Apr 2020 16:37:32 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:32 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 10/11] ext4: deduplicate code with error legs in ext4_try_to_write_inline_data()
Date:   Thu, 23 Apr 2020 20:37:04 -0300
Message-Id: <20200423233705.5878-11-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423233705.5878-1-mfo@canonical.com>
References: <20200423233705.5878-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Make the error legs similar to ext4_convert_inline_data_to_extent(),
now that we have even more "unlock_page(); put_page();" statements.

While in there, do similarly for the semaphore and label "convert:".

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/ext4/inline.c | 56 +++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 9bb85e06854d..3d370b04a740 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -684,9 +684,13 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	handle_t *handle;
 	struct page *page;
 	struct ext4_iloc iloc;
+	bool convert = false;
+	bool sem_held = false;
 
-	if (pos + len > ext4_get_max_inline_size(inode))
-		goto convert;
+	if (pos + len > ext4_get_max_inline_size(inode)) {
+		convert = true;
+		goto out_convert;
+	}
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
@@ -717,6 +721,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		put_page(page);
 		ret = PTR_ERR(handle);
 		handle = NULL;
+		page = NULL;
 		goto out;
 	}
 
@@ -732,58 +737,47 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	wait_for_stable_page(page);
 
 	ret = ext4_prepare_inline_data(handle, inode, pos + len);
-	if (ret && ret != -ENOSPC) {
-		unlock_page(page);
-		put_page(page);
+	if (ret) {
+		/* If don't have space in inline inode, convert it to extent. */
+		convert = (ret == -ENOSPC);
 		goto out;
 	}
 
-	/* We don't have space in inline inode, so convert it to extent. */
-	if (ret == -ENOSPC) {
-		unlock_page(page);
-		put_page(page);
-		ext4_journal_stop(handle);
-		brelse(iloc.bh);
-		goto convert;
-	}
-
 	ret = ext4_journal_get_write_access(handle, iloc.bh);
-	if (ret) {
-		unlock_page(page);
-		put_page(page);
+	if (ret)
 		goto out;
-	}
 
 	*pagep = page;
 	down_read(&EXT4_I(inode)->xattr_sem);
+	sem_held = true;
 	if (!ext4_has_inline_data(inode)) {
 		ret = 0;
-		unlock_page(page);
-		put_page(page);
-		goto out_up_read;
+		goto out;
 	}
 
 	if (!PageUptodate(page)) {
 		ret = ext4_read_inline_page(inode, page);
-		if (ret < 0) {
-			unlock_page(page);
-			put_page(page);
-			goto out_up_read;
-		}
+		if (ret < 0)
+			goto out;
 	}
 
 	ret = 1;
 	handle = NULL;
-out_up_read:
-	up_read(&EXT4_I(inode)->xattr_sem);
 out:
+	if (page && (ret != 1)) {
+		unlock_page(page);
+		put_page(page);
+	}
+	if (sem_held)
+		up_read(&EXT4_I(inode)->xattr_sem);
 	if (handle && (ret != 1))
 		ext4_journal_stop(handle);
 	brelse(iloc.bh);
+out_convert:
+	if (convert)
+		return ext4_convert_inline_data_to_extent(mapping,
+							  inode, flags);
 	return ret;
-convert:
-	return ext4_convert_inline_data_to_extent(mapping,
-						  inode, flags);
 }
 
 int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
-- 
2.20.1

