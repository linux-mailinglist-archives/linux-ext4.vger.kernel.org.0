Return-Path: <linux-ext4+bounces-3976-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB9A9656FD
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 07:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09741C2263E
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 05:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D38A14AD2D;
	Fri, 30 Aug 2024 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnrlRLIx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D46152DF5;
	Fri, 30 Aug 2024 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996274; cv=none; b=U7cYZBsCqQOK4CtzQmygu0tlitcDquh1Yd9Ruq2uqjYlW/+bEx2teky0+a2oSa9+uOLOCDb+1kcgQc54MQxtMRzBK2tpEWYW6RWPwmDuwXLnBf7OTQ7/V+2sCb9g6INRwgQsRKki44BMx/F/nBeMRg35L5jfJ+RN2wA0TyFbff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996274; c=relaxed/simple;
	bh=BzLfhI5kqpS2KTzpMtsOujy405L5fAsQSsJ9SRU8C7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3+KB3eY6H+DdMdZFPfxtIhZ8cFrS7UuQm/anQ2Vs6jeZxKQOrAK+yJYV+zaAzQkUbaY9FdfFi0vfQlGhSICWMiasCVlU8lOiJwKV12L4gJTtYgBJSYVXnJ+bTmRfWSckMjCwEr6ziZtPcFAApUThJ5fKK1N+3fIDz5WuIvo6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnrlRLIx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7142a93ea9cso1216569b3a.3;
        Thu, 29 Aug 2024 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724996271; x=1725601071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPGJ08ZeJjCpmoz/bGbkq2klJXuedkm7eCcxXYnusQE=;
        b=FnrlRLIxAW4D2C5fqgdW0bDmovC/UsAizQTMgYso1TkEAykt1ovF1snpqCCGX4L5sw
         LLH1/J1X6uu16I9B6PL/Rmm4zyHx4h7GH3j7s6bYpPLp6kCOMIiki6wf0DRo27oqEcrc
         dPaBHWRPTXtyLrOSS9x2Hq0sFkgCE6hiJI7OQH4tNmh1Ju5g421K7zzJ0fzfLu9gv6pm
         hsX03syGGRIQ9g67jdVyGw6O765Ql1QAMhMWM/ojr9lUcUoqGW9p7Rr0fs9s8kwWFsy5
         5PfN6mXeFALkkkpsw+c0MruBVxU9ASPc9RgEDjzDk5RLuzM+5n4eNWS7pIxel0/nC1fC
         un5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724996271; x=1725601071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPGJ08ZeJjCpmoz/bGbkq2klJXuedkm7eCcxXYnusQE=;
        b=sIoWvkz8AkaxVQHdTnwldssmfpmA77LUzfuNJnbxHTXBzVnuB+x7KFn6tQ5rDL30KO
         tlKl91XvDVgCmkMo6ENEzaSSSnOI/XDDwcMS7opkaTk0UiAzCqKDmdMgB0mfKDvn9kuq
         rdpz/NBeYRBoz+8RPNSFs175nuN9cgQL8ibofmuIhoX2L/cFVkK/3fBhnYyUKdjmuEtf
         ILATrXWVuWgoBwCeU5aPrg56GkF80+/QB7PhG8XtLd4LfhNq0yyHvSn/61pqy2YTNon4
         hDaUmYgZWZSPXdxGXtpC6FMuyOyRfwtDIuaGVlvi6bdvpavKebiEwxLMLc1t/nF2ikcv
         iTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAJiWpcpdZoqzKa7dem+ugqZR/+1I/Voskrywpxnwamo4Rq5PbDFSg/7EjY5SjcVrXUP5CJFQ7Vgbvk1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+q36Ox14I3DgC1x8PnRu86q1B2SglFcxGQDbGVel16hhyt69
	ON308gJSykAZZPEA8NVrkC1LzmDsTU5AyI74LMbz8l4D3TmwLq8f
X-Google-Smtp-Source: AGHT+IEgET23reRNRQf9VJhSqIuOoOqLbFV1EHBZOfqchq7fRrXPDMWCQbbWx35doBgsVKafNJhKDw==
X-Received: by 2002:a05:6a20:9e49:b0:1ca:edd5:9254 with SMTP id adf61e73a8af0-1cce100b937mr4388048637.16.1724996270936;
        Thu, 29 Aug 2024 22:37:50 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515534801sm19784075ad.154.2024.08.29.22.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 22:37:50 -0700 (PDT)
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
Subject: [PATCH 2/4] ext4: hoist ext4_block_write_begin and replace the __block_write_begin
Date: Fri, 30 Aug 2024 13:37:37 +0800
Message-Id: <20240830053739.3588573-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830053739.3588573-1-zhangshida@kylinos.cn>
References: <20240830053739.3588573-1-zhangshida@kylinos.cn>
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
Reviewed-by: Jan Kara <jack@suse.cz>
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


