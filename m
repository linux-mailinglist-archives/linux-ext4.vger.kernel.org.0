Return-Path: <linux-ext4+bounces-3958-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D55F963F32
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 10:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A224F1C24552
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D6518DF80;
	Thu, 29 Aug 2024 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejYJiDfm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C918DF76;
	Thu, 29 Aug 2024 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921664; cv=none; b=My0hsLH9M1ilj8Y1rgNGqkR5oJUbdENI5QgNCRZiOrCl1I0YbsmSEugY5vPqzQEvF+fALEE4P2/t5Q80dClvBk8sJ1dYg3AcefGSCWzbmR6pDGbrNVC6zsMFIu3Kj5gkJclvD72VCLdxkbOY1TGVPDEz6npUvc7Ot+xm2R7fJx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921664; c=relaxed/simple;
	bh=NuOOl4B0O6SgRCZ9WgyPYfugB0wWSFDZus2Cir+Of/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ResaqWlSO4EE5Imo2bT20IHXKGwGyS31PWISuMwif1x3AQK49mIctdanm1ghEYaTLV1alFyJDqMjSLIQv0wgojuOQAJgZHI3ZNhCh5j5KoSigoQlwgvmRCH3Uc2lZlPEQ2jendTgc8CuLrbX81mhPjAh+neXDA3JOP7E0DcFRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejYJiDfm; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5dfa315ffbdso88208eaf.3;
        Thu, 29 Aug 2024 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724921662; x=1725526462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drlosV0jYeCTB1hRz+zjdH7bQAKjEiJRmwaFd3cvm/M=;
        b=ejYJiDfmI4PDnYqHpknF9C7lV5a0FYhoZBhtAn1EL/ebCQgkqVgx+54PV37+9SpZ4j
         71sx3jvt91lXMar9PuAGDrjVsra3WnPQanFXQnCpkubPQPjcC3jxqIBmGDgXCC9XkwZH
         DhlGSuvIDLHT82PUFdFfyPofemhegjp+8WAgydcS4YlP2SdA5irb3AwsNyx4UvysXWpw
         axYlyl1nMWs4Ippa2RANQdabSI4arbFaOrug5darVZFocaTCRKsmOvBNCIPdtSqaMT38
         GFkz39PNYirAv2WhImJx3JjLGg9g+0r9A1HiG/3UnZX3HbV5m0yLB59M2SPKNQz2XqSI
         58ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921662; x=1725526462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drlosV0jYeCTB1hRz+zjdH7bQAKjEiJRmwaFd3cvm/M=;
        b=MLFD455oWpGoegSlKPdCoCmc7nFRR9Af0DULIqpRcnkS9rxKSiFKpG+8Rqf+YEkbyl
         Z+bml3mTRlU2kybRUsQGA5w17SbZr020gTZu0oHGsmxG9/YpNE7DN/30IR4VD+Jm+FQ7
         ix9EQsYWCt2GrAy05uUVctHYkgFUJtTfMSd1XLk/os6Elr4E/vgfvmwVra7TxihbDmwT
         xZ1Uho+RDUc4Ddy6BqCAgsbXrWZSdias9m7MYxLFg2k0+4z3Z5hpJXm8IFu1WHwqKxM2
         iHVg6hjb8Z8C7aesMJaWJmB6LJ0CANh7Gt0SkJcpVEkFYyZkSZJKvP5wKpR8/bYl+M0X
         9OMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKauJVbI5eZhz9h2v+PYSRXqTWGT5nHpNFIpcP9TbJHzKQdtk2/sT4AUvlC3aIDokHnbPsCqRVAXfmD14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsfv83dJTb7BI925KScJkdoR7uxW8vfhXXpCzbxIYP3kGVHJv
	h7InOL3N/4WY+d/z/mYmVcgj1dU/4sxCBll667QrmVRQ62AYHO7sPCDQFQa1
X-Google-Smtp-Source: AGHT+IEggqwH7nLJxSjaEa+R5dLu4fGLb8IQ9jxQ7CunzV+LG/ht7+ns54iHM9Nsg8Fng9GlmOCpMA==
X-Received: by 2002:a05:6870:c150:b0:261:515:d311 with SMTP id 586e51a60fabf-277900c7344mr2295851fac.18.1724921661878;
        Thu, 29 Aug 2024 01:54:21 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56e3f95sm708789b3a.176.2024.08.29.01.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:54:21 -0700 (PDT)
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
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] ext4: hoist ext4_block_write_begin and replace the __block_write_begin
Date: Thu, 29 Aug 2024 16:54:06 +0800
Message-Id: <20240829085407.3331490-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829085407.3331490-1-zhangshida@kylinos.cn>
References: <20240829085407.3331490-1-zhangshida@kylinos.cn>
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
fscrypt related code. Remove the unnecessary #ifdef since
fscrypt_inode_uses_fs_layer_crypto() returns false (and it's known at
compile time) when !CONFIG_FS_ENCRYPTION.

And hoist the ext4_block_write_begin so that it can be used in other
files.

Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/ext4.h   |  2 ++
 fs/ext4/inline.c | 10 +++++-----
 fs/ext4/inode.c  | 24 +++++-------------------
 3 files changed, 12 insertions(+), 24 deletions(-)

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
index a0a55cb8db53..4964c67e029e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1024,10 +1024,10 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 	if (!buffer_mapped(bh) || buffer_freed(bh))
 		return 0;
 	/*
-	 * __block_write_begin() could have dirtied some buffers. Clean
+	 * ext4_block_write_begin() could have dirtied some buffers. Clean
 	 * the dirty bit as jbd2_journal_get_write_access() could complain
 	 * otherwise about fs integrity issues. Setting of the dirty bit
-	 * by __block_write_begin() isn't a real problem here as we clear
+	 * by ext4_block_write_begin() isn't a real problem here as we clear
 	 * the bit before releasing a page lock and thus writeback cannot
 	 * ever write the buffer.
 	 */
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
@@ -1134,7 +1133,6 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 
 	return err;
 }
-#endif
 
 /*
  * To preserve ordering, it is essential that the hole instantiation and
@@ -1216,19 +1214,11 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
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
@@ -1241,7 +1231,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 
 		folio_unlock(folio);
 		/*
-		 * __block_write_begin may have instantiated a few blocks
+		 * ext4_block_write_begin may have instantiated a few blocks
 		 * outside i_size.  Trim these off again. Don't need
 		 * i_size_read because we hold i_rwsem.
 		 *
@@ -2961,11 +2951,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
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


