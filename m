Return-Path: <linux-ext4+bounces-3694-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF7E94DB6D
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Aug 2024 10:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A740282563
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Aug 2024 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6756114EC62;
	Sat, 10 Aug 2024 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI7U16Jo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D8A14D43D;
	Sat, 10 Aug 2024 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723278513; cv=none; b=dnVEOhs5U1nhM0uc7FAYTWBtjietuXKZBbMf0RyZHGUNxXpoOLFRnPvY3XiF6E/WXsuWUxMD6B6AnWsFjpPxJ75v9LIy7lmjjE2P/pY0oAL+2UCj0zwQ8RkesjWi253eKwBj2GotO2uSYL1ottgo3krK7alqfmWurBDD4fRtvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723278513; c=relaxed/simple;
	bh=RkuvIMkclvFPD0SfbQ0lukE1nGNH6KOgpTMJO2EH9vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHN/RwqHaU38Dun6L4hGSAcJHeknUXUMj+Ljcr0hnNliCo/z+3DragMudNmLq+W0q5h6JSKeD5r30LrGvQ7TLT4kL7p154Y5eDWMFxU6Ez2zdd+Nq2X3W8p6OYY0/aG4fWEr9o5S8GuAtQzBaL/1ygJ9rAlUZRLMUGsqMR5JZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OI7U16Jo; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2689e7a941fso1893398fac.3;
        Sat, 10 Aug 2024 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723278510; x=1723883310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1fH1Ho4GcX3EGjEBqcsALQduBlTVXsfPzay7ElzmRk=;
        b=OI7U16JoCcBYkfcNyHMjeIssxSWqXFnC10XgkBUPVul4UtSYvIrnwz9ecaKiR1czOv
         28DgODmY/DNNxYM75XA58bNz7qYBiCDToZmrOjBiLCuCSlZmyqCI35QWpxfp0aB+pqc9
         uFvdiqL2i82rnEw3zBA1mYF7OSyeetVqnm8un+GYdMv/6WVf2ku+wJErjPn6Heq6h2wr
         ZzfeYmg+JExmWvh1cXVfsouhaDXQz0ouZsVJOPnmnfDLsU2Otc7jP1w+RfgbCQXqcxaK
         6tSsDjL73V8eQOpzgjFDuWYP2F47Q6/DqdqypenyMazgRY73QPQvz+6ywgAnH5pe3DIS
         yRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723278510; x=1723883310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1fH1Ho4GcX3EGjEBqcsALQduBlTVXsfPzay7ElzmRk=;
        b=bWb8nMIGex6RxqNPOcvB258+5IJOJ1OFSDyaLJkYx5WGd5O14B6YU1qbxBlIDvv0IE
         118neJYOVZwEAJ3MI9tiRIrN5ssjGG8PLVleS2+drFtSeElsaBp2cOXSzR6x0qX8uzaW
         EkHwpbRWeQmNIsktdqPJ5pwW2ZOc9GgepJtmQt5WDvbZdVMhtGc1ko3IQhZTIO+Wkt27
         6+kXBPG9YTabxfnxa1MYvNy7cHVYgxUEU1vxEKRoR7YGGhVmjmctBDx8OB7vP444KUzM
         rLxJyLMyaOfYdJhkXrqYkdXMeE0eeNY0jbHhDm2tp0LP90GiB85Y/zM8aaY378WH9DwN
         gyOw==
X-Forwarded-Encrypted: i=1; AJvYcCUsVTq3J6RYtKPn3HMZEsZD6/7R6vMJapV9BrBfu7fg2Qf0xNi3PNN+U9V1FBK63YHvvFDwkE2WRu7h7uQnhJEsmhrD7ic+UJnj8St2
X-Gm-Message-State: AOJu0Yy3t4mmd/Ix0R2SbQh/KQxpDfaeF4ON4kldGMQHq6C8SkEOxVyH
	rxiD87eGJKo3sjHI8rL0zNB8QltuY5M+VEKKYLtyZlfs0Q9+EsUK
X-Google-Smtp-Source: AGHT+IEzsxubHbJF6CWVozJ9oM3cep1yA8YrhjqmeIrMsateIHoyAtM/9NuUqRuSb+yVAM/rm5ksYA==
X-Received: by 2002:a05:6870:3282:b0:261:1339:1cb9 with SMTP id 586e51a60fabf-26c62f21d48mr5160013fac.35.1723278510219;
        Sat, 10 Aug 2024 01:28:30 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a8c454sm854092b3a.180.2024.08.10.01.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 01:28:29 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Baolin Liu <liubaolin@kylinos.cn>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v3 2/3] ext4: fix a potential assertion failure due to improperly dirtied buffer
Date: Sat, 10 Aug 2024 16:28:13 +0800
Message-Id: <20240810082814.3709867-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240810082814.3709867-1-zhangshida@kylinos.cn>
References: <20240810082814.3709867-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

On an old kernel version(4.19, ext3, data=journal, pagesize=64k),
an assertion failure will occasionally be triggered by the line below:
-----------
jbd2_journal_commit_transaction
{
...
J_ASSERT_BH(bh, !buffer_dirty(bh));
/*
* The buffer on BJ_Forget list and not jbddirty means
...
}
-----------

The same condition may also be applied to the lattest kernel version.

When blocksize < pagesize and we truncate a file, there can be buffers in
the mapping tail page beyond i_size. These buffers will be filed to
transaction's BJ_Forget list by ext4_journalled_invalidatepage() during
truncation. When the transaction doing truncate starts committing, we can
grow the file again. This calls __block_write_begin() which allocates new
blocks under these buffers in the tail page we go through the branch:

                        if (buffer_new(bh)) {
                                clean_bdev_bh_alias(bh);
                                if (folio_test_uptodate(folio)) {
                                        clear_buffer_new(bh);
                                        set_buffer_uptodate(bh);
                                        mark_buffer_dirty(bh);
                                        continue;
                                }
                                ...
                        }

Hence buffers on BJ_Forget list of the committing transaction get marked
dirty and this triggers the jbd2 assertion.

Teach ext4_block_write_begin() to properly handle files with data
journalling by avoiding dirtying them directly. Instead of
folio_zero_new_buffers() we use ext4_journalled_zero_new_buffers() which
takes care of handling journalling. We also don't need to mark new uptodate
buffers as dirty in ext4_block_write_begin(). That will be either done
either by block_commit_write() in case of success or by
folio_zero_new_buffers() in case of failure.

Reported-by: Baolin Liu <liubaolin@kylinos.cn>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/ext4.h   |  3 ++-
 fs/ext4/inline.c |  7 ++++---
 fs/ext4/inode.c  | 30 ++++++++++++++++++++++--------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5f8257b68190..b653bd423b11 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3851,7 +3851,8 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 	return buffer_uptodate(bh);
 }
 
-extern int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
+extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
+				  loff_t pos, unsigned len,
 				  get_block_t *get_block);
 #endif	/* __KERNEL__ */
 
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 0a1a8431e281..8d5599d5af27 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -601,10 +601,11 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		goto out;
 
 	if (ext4_should_dioread_nolock(inode)) {
-		ret = ext4_block_write_begin(folio, from, to,
+		ret = ext4_block_write_begin(handle, folio, from, to,
 					     ext4_get_block_unwritten);
 	} else
-		ret = ext4_block_write_begin(folio, from, to, ext4_get_block);
+		ret = ext4_block_write_begin(handle, folio, from, to,
+					     ext4_get_block);
 
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
@@ -856,7 +857,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 			goto out;
 	}
 
-	ret = ext4_block_write_begin(folio, 0, inline_size,
+	ret = ext4_block_write_begin(NULL, folio, 0, inline_size,
 				     ext4_da_get_block_prep);
 	if (ret) {
 		up_read(&EXT4_I(inode)->xattr_sem);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6b15805ca88b..4c34827da56e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -49,6 +49,11 @@
 
 #include <trace/events/ext4.h>
 
+static void ext4_journalled_zero_new_buffers(handle_t *handle,
+					    struct inode *inode,
+					    struct folio *folio,
+					    unsigned from, unsigned to);
+
 static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
 			      struct ext4_inode_info *ei)
 {
@@ -1041,7 +1046,8 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 	return ret;
 }
 
-int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
+int ext4_block_write_begin(handle_t *handle, struct folio *folio,
+			   loff_t pos, unsigned len,
 			   get_block_t *get_block)
 {
 	unsigned from = pos & (PAGE_SIZE - 1);
@@ -1055,6 +1061,7 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 	struct buffer_head *bh, *head, *wait[2];
 	int nr_wait = 0;
 	int i;
+	bool should_journal_data = ext4_should_journal_data(inode);
 
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(from > PAGE_SIZE);
@@ -1083,11 +1090,11 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
+			if (should_journal_data)
+				do_journal_get_write_access(handle, inode, bh);
 			if (buffer_new(bh)) {
 				if (folio_test_uptodate(folio)) {
-					clear_buffer_new(bh);
 					set_buffer_uptodate(bh);
-					mark_buffer_dirty(bh);
 					continue;
 				}
 				if (block_end > to || block_start < from)
@@ -1117,7 +1124,11 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 			err = -EIO;
 	}
 	if (unlikely(err)) {
-		folio_zero_new_buffers(folio, from, to);
+		if (should_journal_data)
+			ext4_journalled_zero_new_buffers(handle, inode, folio,
+							 from, to);
+		else
+			folio_zero_new_buffers(folio, from, to);
 	}
 #ifdef CONFIG_FS_ENCRYPTION
 	else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
@@ -1218,10 +1229,11 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	folio_wait_stable(folio);
 
 	if (ext4_should_dioread_nolock(inode))
-		ret = ext4_block_write_begin(folio, pos, len,
+		ret = ext4_block_write_begin(handle, folio, pos, len,
 					     ext4_get_block_unwritten);
 	else
-		ret = ext4_block_write_begin(folio, pos, len, ext4_get_block);
+		ret = ext4_block_write_begin(handle, folio, pos, len,
+					     ext4_get_block);
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
 					     folio_buffers(folio), from, to,
@@ -2954,7 +2966,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
+	ret = ext4_block_write_begin(NULL, folio, pos, len,
+				     ext4_da_get_block_prep);
 	if (ret < 0) {
 		folio_unlock(folio);
 		folio_put(folio);
@@ -6208,7 +6221,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		if (folio_pos(folio) + len > size)
 			len = size - folio_pos(folio);
 
-		err = __block_write_begin(&folio->page, 0, len, ext4_get_block);
+		err = ext4_block_write_begin(handle, folio, 0, len,
+					     ext4_get_block);
 		if (!err) {
 			ret = VM_FAULT_SIGBUS;
 			if (ext4_journal_folio_buffers(handle, folio, len))
-- 
2.33.0


