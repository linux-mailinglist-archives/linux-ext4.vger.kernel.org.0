Return-Path: <linux-ext4+bounces-3873-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB7195C2D6
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 03:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D977C283A74
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 01:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981BF18026;
	Fri, 23 Aug 2024 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOId8Pzq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD61CD39;
	Fri, 23 Aug 2024 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724376842; cv=none; b=TydT+6nMfE1VB7zvCx3kSk1iqzSzya025LKHy8piuaZbo9hJIk+KGV/I85MUxXNcK0bjKr0CIGO+Bq6HP3BQrMD+zgQegBYQsI+iooXookgRAGAMeCJ4RqfWCtRi/+tFA91P6ww65HXJzrf2EvgSlnlhL+Fwbe1bR1G49RIZ/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724376842; c=relaxed/simple;
	bh=wdiNS1NVUsFCdpAPH1x17L4nOv4E184Rt48nedcpfLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMdacdXsfq3XPA1zFy1r125fnjIJXpd1r5UFxI8emlLQkvP9qxDgkPWjazwt4icpsjPMM03YRAYbB0va/qoFhxjdINK8pxV9ECl9dx9zT/Q9JVbuWf8a83uCfq4dTm6xbcki5GOd2qsq9xN8l/Zt5zKr6IFDYyUwVPhe4fT8XUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOId8Pzq; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7cd830e0711so1396639a12.0;
        Thu, 22 Aug 2024 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724376840; x=1724981640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfkinVOCRqqx14ba0QNxtd1YpB4MXEXYboXHawxHb8w=;
        b=KOId8PzqKqijKvPpWLRd4UA69dmQGShiOdv8T4u1CMEiQ/Cp1ktkxuW37QKHY7e2BD
         xIDd3oXPsZnqjvZLZDB0a8M+f/v1HDFReS2fnZd6Y/OQdXkb5MrgERENvcht0lCbMrcp
         KRncyIQ93wuWVa2FSuZ26U7vh6yBiA1MqfLC6uz+JwTXELfcSQzy0vO9IhHeCtzilrO5
         UVRv+reI3Qb/EVHVbbV5CwsNl9C2TD0GzkgsSx2bwD56EnIkKGOihMca9onINuZlZT/T
         A7bBX4rMuMmG8irt+45CwyET0xjHTyZtiFR5rVv86HsJNr5/UaT1DgN9yMEbe0Pgxxvp
         0QqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724376840; x=1724981640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfkinVOCRqqx14ba0QNxtd1YpB4MXEXYboXHawxHb8w=;
        b=GnvXJuuvptNTFrpLhAfZ/81kMOEY+mU9dE1aV2ySaY6AJAJ2sJFQhdUAQr2QjnbjtU
         tZzV1hCFvywLxVMhvGbfToJ4avEh6wfJShNw3LC5txs3PudEd4o1tShlV8a+SWvKE8i1
         Uz+AnG+3697z6QHHx42LnfV+uhMLYHAhhaR8cMkMxjlgVn9FLB+0LOhExR+D/kMcn+Ft
         gEePKZkxNQQClFeKsqQWjuXZ+q8ET9gAAS3Ya5gBdcG75vR9HG2kUl9FbBRl2Tfvq+Hz
         iHo1yGu1nJSVJ0XzA/EVGXRKQ/66DcJSWxMLCjCd0Tve49tiHCPeM6HLeuxJA78H8K7r
         9zHA==
X-Forwarded-Encrypted: i=1; AJvYcCVU2lvEJG78FwUl77ipZ1ja3WruJj3/HmdSqEV1zMeEyPDQ+mk2XVOL1k7uIb8aslilgfi/dLGzeJuSCdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsqsa5k+cH0yqzt0OueWw3zEehYvisNoPcR2cE5viJkITvQxJh
	WguJOrpB7cjS8Cp+Mn3OsgykqbLNRXFCTOa0MFTVoko5tmdJuQv2
X-Google-Smtp-Source: AGHT+IEg2d7kQadVufNNOb92yEl6EjDz6nSaIh2etUdOnHIJkwXGrTEsu12juGse41XEXkBJMkcuIA==
X-Received: by 2002:a05:6a20:2586:b0:1c4:8694:6be8 with SMTP id adf61e73a8af0-1cae51ad0a6mr7541533637.3.1724376839370;
        Thu, 22 Aug 2024 18:33:59 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad6e334sm1735781a12.84.2024.08.22.18.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 18:33:59 -0700 (PDT)
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
Subject: [PATCH 1/2] ext4: hoist ext4_block_write_begin and replace the __block_write_begin
Date: Fri, 23 Aug 2024 09:33:28 +0800
Message-Id: <20240823013329.1996741-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823013329.1996741-1-zhangshida@kylinos.cn>
References: <20240823013329.1996741-1-zhangshida@kylinos.cn>
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


