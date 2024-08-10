Return-Path: <linux-ext4+bounces-3693-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7753894DB6B
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Aug 2024 10:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B5D1F2127A
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Aug 2024 08:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB1D14D29D;
	Sat, 10 Aug 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn6sFyUm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6314C583;
	Sat, 10 Aug 2024 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723278509; cv=none; b=p8Ar6z90U9+3+LZheLt+ykzLlNFtpPywdPlwoy8iOniOT41nXGt+58Qb0GIkBucr9ELepY+5corHL+qOfZSog+m7dC5cLkePR2256fUNOiObV2wJlmcyHsc+Up4l2X4kwJFAeg2dmPGTL1bpoSWG3EfuVxKq0zcuBu4vJj5svA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723278509; c=relaxed/simple;
	bh=wdiNS1NVUsFCdpAPH1x17L4nOv4E184Rt48nedcpfLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xmjd63SdrwPVmwQ/PbkjTKXBEaT8jn2HtC9prr/lpFcmUT3ANVAtDnciqTY3GA7rRuLaBVc7hJTzB5FYd677FjiZUwdOIGdyzf1TERin51AfQJSNh0qXhYoPy1Hy8htFdh0TGf+bzMIwCR/6NIhBODkQAUcIQsZeRUOuDKSBrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn6sFyUm; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8223f0614b6so919175241.2;
        Sat, 10 Aug 2024 01:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723278507; x=1723883307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfkinVOCRqqx14ba0QNxtd1YpB4MXEXYboXHawxHb8w=;
        b=Tn6sFyUmQK5ydGXmJsZsHjRRWEOKLDyB2QXvstKX0jsYXqK88WOQPyL0NdK6f2wIgY
         Ap+HAggYepiJboSfUgy3m+4crcovcXAtqpxKrvVZgwuddNPn+21vKYIABMwtwfN2qIJS
         7i/2rmqFoRttTF5uzEKdUTkXjoMnkIYfSt0/D1P07oox3JkaqBuVq49PUFfJR+26V5QR
         WbacDJtIUIDSCWazeQGWjqVr3H/g/7/OmZHfP5IqjOFS2SqN86d+U4UKyQgppGpjg290
         bqpRBJHkTAXXrIqZuSLuMWM2vkmLNrmGg95UCVeBrtWvw7rV4CThpq8WDNiwhBOo4/qT
         NpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723278507; x=1723883307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfkinVOCRqqx14ba0QNxtd1YpB4MXEXYboXHawxHb8w=;
        b=pCJmolxNfaV7sWQVEIFVbj9wrvRUHK8xBHHZONlFNjW7gvZczzMTqdk6ttg0zoNdCl
         0xDmBxt75fxeDeuO35hQHZG92qIjT+vC433MIHvJvcEVmmrWL6847Y7qIwfwWA30kt6o
         PGQMCTFd//9tZKrF0PHJaL4ww2E+lKsmYPjgLUiJCVcrRw5o6edWuCPSL5reqU2ZWyVp
         h2wTXUNT05AaW93Ol2DiBwQMpo5YuXgu7gAEsWtNHIeXJhhg2b4Hu/uhiKFm+6GCbxGE
         UiogDGCdkzx84nL5/2W+yoypo+FN1Q/1aL+wB6ajgWPg4/YBXclaWZTL4BKPFCynLJxj
         mEyA==
X-Forwarded-Encrypted: i=1; AJvYcCUMmBjzsvZ8r0qVNyentB6aMZ2COLU1yuGtiXH3y/n5Msvelhd9JjIAgjJEjbJshJ2dCATFtTlLVvtjN78kDO3VARtJql4FGiYfCtfs
X-Gm-Message-State: AOJu0YxQ2fQybqbfG3FFEuh2DMVURI0Fz/RpnA+MA4LINHxbk0XsMo8J
	UOOFydElnMX+tItUTx1lPZzgKueLlnikyyWfr0lX/Ztzva+BWI9g
X-Google-Smtp-Source: AGHT+IE4NUkWyiiqXdmtF6hIKBPZSxvvNxOTXmRN0m6q3gBBFnHullZGiSnvAfG2e7BLe8Qrnxl/JQ==
X-Received: by 2002:a05:6102:3f47:b0:48f:a858:2b52 with SMTP id ada2fe7eead31-495d860b1e4mr6043346137.29.1723278506604;
        Sat, 10 Aug 2024 01:28:26 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a8c454sm854092b3a.180.2024.08.10.01.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 01:28:26 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v3 1/3] ext4: hoist ext4_block_write_begin and replace the __block_write_begin
Date: Sat, 10 Aug 2024 16:28:12 +0800
Message-Id: <20240810082814.3709867-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240810082814.3709867-1-zhangshida@kylinos.cn>
References: <20240810082814.3709867-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Using __block_write_begin() make it inconvenient to journal the
user data dirty process. We can't tell the block layer maintainer,
‘Hey, we want to trace the dirty user data in ext4, can we add some
special code for ext4 in __block_write_begin?’:P

So use ext4_block_write_begin() instead.

The two functions are basically doing the same thing except for the
fscrypt related code. Narrow the scope of CONFIG_FS_ENCRYPTION so as
to allow ext4_block_write_begin() to function like __block_write_begin
when the config is disabled.
And hoist the ext4_block_write_begin so that it can be used in other
files.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/ext4.h   |  2 ++
 fs/ext4/inline.c | 10 +++++-----
 fs/ext4/inode.c  | 23 ++++++-----------------
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 08acd152261e..5f8257b68190 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3851,6 +3851,8 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 	return buffer_uptodate(bh);
 }
 
+extern int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
+				  get_block_t *get_block);
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e7a09a99837b..0a1a8431e281 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -601,10 +601,10 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		goto out;
 
 	if (ext4_should_dioread_nolock(inode)) {
-		ret = __block_write_begin(&folio->page, from, to,
-					  ext4_get_block_unwritten);
+		ret = ext4_block_write_begin(folio, from, to,
+					     ext4_get_block_unwritten);
 	} else
-		ret = __block_write_begin(&folio->page, from, to, ext4_get_block);
+		ret = ext4_block_write_begin(folio, from, to, ext4_get_block);
 
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
@@ -856,8 +856,8 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 			goto out;
 	}
 
-	ret = __block_write_begin(&folio->page, 0, inline_size,
-				  ext4_da_get_block_prep);
+	ret = ext4_block_write_begin(folio, 0, inline_size,
+				     ext4_da_get_block_prep);
 	if (ret) {
 		up_read(&EXT4_I(inode)->xattr_sem);
 		folio_unlock(folio);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..6b15805ca88b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1041,9 +1041,8 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 	return ret;
 }
 
-#ifdef CONFIG_FS_ENCRYPTION
-static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
-				  get_block_t *get_block)
+int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
+			   get_block_t *get_block)
 {
 	unsigned from = pos & (PAGE_SIZE - 1);
 	unsigned to = from + len;
@@ -1119,7 +1118,9 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 	}
 	if (unlikely(err)) {
 		folio_zero_new_buffers(folio, from, to);
-	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
+	}
+#ifdef CONFIG_FS_ENCRYPTION
+	else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 		for (i = 0; i < nr_wait; i++) {
 			int err2;
 
@@ -1131,10 +1132,10 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 			}
 		}
 	}
+#endif
 
 	return err;
 }
-#endif
 
 /*
  * To preserve ordering, it is essential that the hole instantiation and
@@ -1216,19 +1217,11 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	/* In case writeback began while the folio was unlocked */
 	folio_wait_stable(folio);
 
-#ifdef CONFIG_FS_ENCRYPTION
 	if (ext4_should_dioread_nolock(inode))
 		ret = ext4_block_write_begin(folio, pos, len,
 					     ext4_get_block_unwritten);
 	else
 		ret = ext4_block_write_begin(folio, pos, len, ext4_get_block);
-#else
-	if (ext4_should_dioread_nolock(inode))
-		ret = __block_write_begin(&folio->page, pos, len,
-					  ext4_get_block_unwritten);
-	else
-		ret = __block_write_begin(&folio->page, pos, len, ext4_get_block);
-#endif
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
 					     folio_buffers(folio), from, to,
@@ -2961,11 +2954,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-#ifdef CONFIG_FS_ENCRYPTION
 	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
-#else
-	ret = __block_write_begin(&folio->page, pos, len, ext4_da_get_block_prep);
-#endif
 	if (ret < 0) {
 		folio_unlock(folio);
 		folio_put(folio);
-- 
2.33.0


