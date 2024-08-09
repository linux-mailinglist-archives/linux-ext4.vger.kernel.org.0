Return-Path: <linux-ext4+bounces-3681-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D42C494CAC1
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 08:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004CE1C21FC9
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 06:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6257616D321;
	Fri,  9 Aug 2024 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcbZNopY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885C624;
	Fri,  9 Aug 2024 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723185986; cv=none; b=sZSwPPWwPsH56ZIgPZrvad6xLEVUb/X5pi3At+w3eoIdxxgIaRjNmBq7zjk8JmauuJYbw8WZhNyXL++xOvyMbevit7vO2w+yC3Wnbxr3xOESGPWhmenbBRkRx8SGD+o6T8/mpfOvwwWajWkDk9XZoktKXy9Ong7KylWxAaDEYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723185986; c=relaxed/simple;
	bh=GOmAEKkDCxXxTeQy+ohPq48m3ANFAobDqX2kyGU86fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AN0Qq6EnhoAJtGWv7NSk+0IDWu2Cj6YbAGSQR/H3js73NdOAVGvE6EmCTzn/106BrxcaIC2zGpCcMkLRu1yzCU6qtCKTyAsuNmf4d3zZaU+xVkAUARwIm8/Ji5hVSimHWLC4aNqjJiXsXtAXfRsexnReB7br/xSfs+U41UAoaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcbZNopY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cdadce1a57so1440023a91.2;
        Thu, 08 Aug 2024 23:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723185984; x=1723790784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW2OgXMUfSkKBF6ghUV+7wPkhaTvXh+ssQE/5vN8TKs=;
        b=mcbZNopY28oEQsb7HgYX2r5JGU2SM6oihbq1z9hKWQAHxoSEQ3rizcln74wGoBp9QI
         OTZjKp2p1UgadEosl/Oqe1PHPcXX2or4GSqooM9toXlFNUHyBbHnzBeek4VqO1XtMXqH
         xyg7vao/EJNJz+Mm8clp2Ji0csCXSOD1e7a3pRYALEIo14zaQgET3xKisMvywhy4fcRg
         lriNqQVLWZ968c+9YsmCfSwm2SWfHldmCOn2Goe/R1ymClHCm2Flc5PWtbyAvVjpvMBE
         cwzxKpgjobIzvXIx4pQrUvajbQxLeeotf4lhmjhSr7t0t1swDx4cVW3xaRP59zHVNsT/
         ZhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723185984; x=1723790784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FW2OgXMUfSkKBF6ghUV+7wPkhaTvXh+ssQE/5vN8TKs=;
        b=BhMtxICEjVa7uFRS0wEJR6AKQfgMkR7oP1SQ7hPXO7kHHMw55nsqhYRQZDkKLgYTqE
         QHeT07g6+8bjnYxoY4hq0NmTPuwBWfj0dVqZ5trLDC++ToV6Ga48zmrpebW0WHANhVrp
         3lrPEeiPnOzDaOYtV7739H9wGJfsAzqC6wUiQ0FsUpPWR5OE5ihwy29t14CduyQSXSw6
         8NFY0Rwj4Ca0RXIlPJqauYdZ2TCJ+fYdAjsDtZUR4woqFXMT6ZhA4DnK9hmH3BSPcu/P
         UMLkYCO04A9bexsBMH1klmGsFVSETVcKTFOP/sNeDSlHqEVigI0r8j6AWd/7NuNhMxqc
         5v1g==
X-Forwarded-Encrypted: i=1; AJvYcCWG2YPhlrv8NgJZUAizUVKfh+jRRhl1re1J1h/a8Rumb03neyYiVEAFDGycFi5/SHVy7Ba8YkX0tBubHJecpE/sdIKMpskraolLmUmz
X-Gm-Message-State: AOJu0YxbwBpE+7NFiOv28/Z28OUjmWxIDi30E/xpfOSaJ78CmxkUVfU3
	J6bumIWnn6rOBS+T8jut/ooflMTBF58UFsm/djjWkMVIUWbm6FXj
X-Google-Smtp-Source: AGHT+IHosMwL5TJtg5Dhpvvhi4+zmV+99ojQAL/2dMzkGsn2sm9oFCN+uN/ZqbwKo/uDJ0ZGbOJ81A==
X-Received: by 2002:a17:90a:ec0f:b0:2c9:96fc:ac54 with SMTP id 98e67ed59e1d1-2d1e7f9b006mr590056a91.2.1723185983519;
        Thu, 08 Aug 2024 23:46:23 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9db44e5sm2201491a91.46.2024.08.08.23.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 23:46:23 -0700 (PDT)
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
Subject: [RFC PATCH V2 1/2] ext4: fix a potential assertion failure due to improperly dirtied buffer
Date: Fri,  9 Aug 2024 14:46:05 +0800
Message-Id: <20240809064606.3490994-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809064606.3490994-1-zhangshida@kylinos.cn>
References: <20240809064606.3490994-1-zhangshida@kylinos.cn>
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

AFAIC, that's how the problem works:
--------
journal_unmap_buffer
jbd2_journal_invalidatepage
__ext4_journalled_invalidatepage
ext4_journalled_invalidatepage
do_invalidatepage
truncate_inode_pages_range
truncate_inode_pages
truncate_pagecache
ext4_setattr
--------
First try to truncate and invalidate the page.
ext4_setattr() will try to free it by adding it to the BJ_Forget list
for further processing.
Put it more clearly,
when ext4_setattr() truncates the file, the buffer is not fully freed
yet. It's half-freed.
Furthermore,
Because the buffer is half-freed, the reallocating thing won't need to happen.
Now,
under that scenario, can we redirty the half-freed buffer on the BJ_Forget list?
The answer may be 'yes'.

redirty it by the following code:
ext4_block_write_begin
    if (!buffer_mapped(bh)) { // check 1
         _ext4_get_block(inode, block, bh, 1);
        (buffer_new(bh)) { // check 2
             if (folio_test_uptodate(folio)) { // check 3
                 mark_buffer_dirty(bh);

But can it pass the checks?

Is the buffer mapped? no, journal_unmap_buffer() will clear the mapped state.
Pass the check 1.

Is the buffer new? maybe, _ext4_get_block will mark it as new when the
underlying block is unwritten.
Pass the check 2.

Is the folio uptodate? yes.
Pass the check 3.

Yep, the buffer finally gets dirtied and jbd2_journal_commit_transaction() sees
a dirty but not jbd_dirty buffer on the BJ_Forget list.

To fix it:
Trace the user data dirting in ext4_block_write_begin() for data=journal mode,
as suggested by Jan.

Reported-by: Baolin Liu <liubaolin@kylinos.cn>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/inode.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..de46c0a6842a 100644
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
@@ -1042,7 +1047,8 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 }
 
 #ifdef CONFIG_FS_ENCRYPTION
-static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
+static int ext4_block_write_begin(handle_t *handle, struct folio *folio,
+				  loff_t pos, unsigned len,
 				  get_block_t *get_block)
 {
 	unsigned from = pos & (PAGE_SIZE - 1);
@@ -1056,6 +1062,7 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 	struct buffer_head *bh, *head, *wait[2];
 	int nr_wait = 0;
 	int i;
+	bool should_journal_data = ext4_should_journal_data(inode);
 
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(from > PAGE_SIZE);
@@ -1084,11 +1091,16 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
+			if (should_journal_data)
+				do_journal_get_write_access(handle, inode, bh);
 			if (buffer_new(bh)) {
 				if (folio_test_uptodate(folio)) {
 					clear_buffer_new(bh);
 					set_buffer_uptodate(bh);
-					mark_buffer_dirty(bh);
+					if (should_journal_data)
+						ext4_dirty_journalled_data(handle, bh);
+					else
+						mark_buffer_dirty(bh);
 					continue;
 				}
 				if (block_end > to || block_start < from)
@@ -1118,7 +1130,11 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
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
@@ -1218,10 +1234,11 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 
 #ifdef CONFIG_FS_ENCRYPTION
 	if (ext4_should_dioread_nolock(inode))
-		ret = ext4_block_write_begin(folio, pos, len,
+		ret = ext4_block_write_begin(handle, folio, pos, len,
 					     ext4_get_block_unwritten);
 	else
-		ret = ext4_block_write_begin(folio, pos, len, ext4_get_block);
+		ret = ext4_block_write_begin(handle, folio, pos, len,
+					     ext4_get_block);
 #else
 	if (ext4_should_dioread_nolock(inode))
 		ret = __block_write_begin(&folio->page, pos, len,
@@ -2962,7 +2979,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 		return PTR_ERR(folio);
 
 #ifdef CONFIG_FS_ENCRYPTION
-	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
+	ret = ext4_block_write_begin(NULL, folio, pos, len,
+				     ext4_da_get_block_prep);
 #else
 	ret = __block_write_begin(&folio->page, pos, len, ext4_da_get_block_prep);
 #endif
-- 
2.33.0


