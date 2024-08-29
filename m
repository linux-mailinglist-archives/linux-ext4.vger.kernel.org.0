Return-Path: <linux-ext4+bounces-3959-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B8B963F34
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 10:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6447E1C24515
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946C518CC18;
	Thu, 29 Aug 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY5Julto"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5BC18DF90;
	Thu, 29 Aug 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921668; cv=none; b=lCAudx/wMACznNHYxsRGtUgcXwcpCfjBhF6U/dVy8l1Cvq3X27G8p6Z1rXIV2k/qbN0148RKpvZLQ8zG/Cv9lOPlBx682M4j664UrR3nF7h1H+Eh+EVqIrGw7pPStFq4fqSBHJmy9fHEYAQhU/qhIF5abOI4W7Pn0E7aeJwFnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921668; c=relaxed/simple;
	bh=aNcuKur2RRGZzm/Cjy5aSYFHQrmqMOaH0SEuz++d644=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=suDE38orYHXoWMH/XF1m6ZCiaKw7zx9uTZiIRSuN3tHz/B673nmMxiMiWDhD2T1+EO8bM225hTd+RRxkCGP/BPezWKmjtDl3Uy0x3z4VEFtLgYZCCD4CDCIdJswg/WwU4N77rL09PN11MFCC6glYGyPLG32tYM4mXJnvWUoAISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY5Julto; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-27046394c9bso228909fac.2;
        Thu, 29 Aug 2024 01:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724921665; x=1725526465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btC5ManTiMADgBttAYOj92C9j/sYx4TVglTFjwxWLn4=;
        b=PY5Julto+tUGN2jnPI+5Qv13HLNLP2qm69QdIXpS1ULW4jDOLEc1pcVK5LcWAAluZZ
         1cLKN5P2pOTkHH/mjlM7mvLJ62Erf15ULfrvHGEhkzXbc34f9EH730bSTELj3z/bUSK+
         N39yYpUUahPycAQJUp8Fzc57jiv6/4IYT2c5+sCKA+HDoc1pkyJwqxlzN94SPxfMEoKl
         jhs9YSNRGu7fPGESxBgEL5fFwPv5Z74A65bavs7sufkz19IGC3j9L9GEDdA1Wxw6dqFT
         orJOY+0NTc/9FXhTYIgTZ0DAUWq4t3d2Sqh/sLCXMydC6B5ftEDyJD4fhJPWwX4GdH1y
         5tPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921665; x=1725526465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btC5ManTiMADgBttAYOj92C9j/sYx4TVglTFjwxWLn4=;
        b=gTCkn7uwM+RLtSUQ7DVXmQ5aS8gLQUvGwJHEUZXnlCDm6R9A/vUvFT0nHW6HrQBYUL
         onhb+9BKL4wcZCQc+Ge082ZAyhZLOohEfIAhtYKxI6AizoJmuww2lRWnNz2jR4rvH0tW
         8RGOncMg/Kb9bZroEomT0HRupctWVz5t+TtS71sfVVwupsCgGr5fJdw41fDEPVYChOm6
         ezX3LcKJJnEJibbpDemRuX0iT2CnPgDm0pmfz5dyWsTDMMBVVgQnue9KaIw42f4ErFHd
         dinRP9VCTrGvoXLDjXfeewFvkZRY5eLl2HJdJjBBwrjfg3ir6BmUgw1sQ9phfAYa50x6
         C9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXPwbqhK4tEa1/JnI4AUwRh1ndtz+5AJJWbsAzsaOY8D2uVmFUaXI05R4GmC431ADLP/LIDg/0CcVcqznw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3M7aw0EZ1UT82uUxSjemPydt66jDWq10s7GWAr3/s8AJ29rw4
	lAxNqYY9/yQ6qsrCT6C4zD1pXYAtgW5sgAseqVSjAgfk1+GC2IaF
X-Google-Smtp-Source: AGHT+IHbXCEbC2Z8aLEcBWY/XDCwEHkdbVwlXzD6o4QrW2kfSK62+R1JGF1wYzZZ1UvagR+LT2h0rQ==
X-Received: by 2002:a05:6870:6492:b0:268:a79a:be0d with SMTP id 586e51a60fabf-27790367381mr2368382fac.47.1724921665411;
        Thu, 29 Aug 2024 01:54:25 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56e3f95sm708789b3a.176.2024.08.29.01.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:54:25 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com,
	ebiggers@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Baolin Liu <liubaolin@kylinos.cn>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] ext4: fix a potential assertion failure due to improperly dirtied buffer
Date: Thu, 29 Aug 2024 16:54:07 +0800
Message-Id: <20240829085407.3331490-4-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829085407.3331490-1-zhangshida@kylinos.cn>
References: <20240829085407.3331490-1-zhangshida@kylinos.cn>
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
 fs/ext4/inode.c  | 41 +++++++++++++++++++++++++++++++++--------
 3 files changed, 39 insertions(+), 12 deletions(-)

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
index 4964c67e029e..bc26200b2852 100644
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
@@ -1083,11 +1090,22 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
+			/*
+			 * We may be zeroing partial buffers or all new
+			 * buffers in case of failure. Prepare JBD2 for
+			 * that.
+			 */
+			if (should_journal_data)
+				do_journal_get_write_access(handle, inode, bh);
 			if (buffer_new(bh)) {
 				if (folio_test_uptodate(folio)) {
-					clear_buffer_new(bh);
+					/*
+					 * Unlike __block_write_begin() we leave
+					 * dirtying of new uptodate buffers to
+					 * ->write_end() time or
+					 * folio_zero_new_buffers().
+					 */
 					set_buffer_uptodate(bh);
-					mark_buffer_dirty(bh);
 					continue;
 				}
 				if (block_end > to || block_start < from)
@@ -1117,7 +1135,11 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 			err = -EIO;
 	}
 	if (unlikely(err)) {
-		folio_zero_new_buffers(folio, from, to);
+		if (should_journal_data)
+			ext4_journalled_zero_new_buffers(handle, inode, folio,
+							 from, to);
+		else
+			folio_zero_new_buffers(folio, from, to);
 	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 		for (i = 0; i < nr_wait; i++) {
 			int err2;
@@ -1215,10 +1237,11 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
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
@@ -2951,7 +2974,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
+	ret = ext4_block_write_begin(NULL, folio, pos, len,
+				     ext4_da_get_block_prep);
 	if (ret < 0) {
 		folio_unlock(folio);
 		folio_put(folio);
@@ -6205,7 +6229,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
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


