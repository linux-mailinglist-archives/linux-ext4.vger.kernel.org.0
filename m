Return-Path: <linux-ext4+bounces-5948-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CE1A0372C
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 05:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D974163DB0
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 04:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91C197A8B;
	Tue,  7 Jan 2025 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixsAfxiO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1D770FE
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 04:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736225839; cv=none; b=eLs3/BSXU07TO5bkzMZMC7SMnYa7dqxWlMPEXXl5P9sSkkh1WqBO8vmXjDh/iJ6aGYJ+vwYj3i8Zx/Fqt+ofllmrm8LCB5qhr8uMjfqO+Jz6aEzes15mHJq8uVFm9DLBSU3JjKe5J2IQZcjukeCWbE/cMvTk8DJ1esS5fQV0MAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736225839; c=relaxed/simple;
	bh=5JpNjmcvYYl/PR/Sm4pNFVLCWuiWXxANcz/NVJwxpQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BaGgOYp00p+CyY+6y2Uv5lr3kLcNF38oRUK4wWfvUawF7TEa6WHZ/m4ZcSYB76OYCi0IAHSqLnrOWRiLCeowZotDVdKppqIjrcmmiQak8hngphCzNhDOMu0Exoa53Vcu2j5DQHhNXlZGQOZ//FfRqdOYdA+OZ4Off7k4beACRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixsAfxiO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21669fd5c7cso223272295ad.3
        for <linux-ext4@vger.kernel.org>; Mon, 06 Jan 2025 20:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736225835; x=1736830635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1yfJ80/eWZchC7T0n8tm3VszjO5fqNgDceOTgZmDkI=;
        b=ixsAfxiO3sVqNyTRI4V3FlP3aTl2HY12cUwkZDq/ZJZAYKJWCYLVhiv4lSYAtu/WhH
         MT16hi3KTdfniaRB/pgCZ4mPpMNAMw8k8yoKvtEoTJigdWSJeHtJolrqJefjpiYOsRVo
         MbamCH4n8/k2Lf4waiOqzkfu1E9WEHhS5+FHW9wtwx86rWbtSvqPCBDCJ3cMSeILuFUL
         1y0qK1wi+xn4li03luJUPiLoHTgFi9uPx7A8+eDggDoJTixzXm1a/Xg7ilBU8VC70xVI
         TTpaE7jhgF5oT/G5m7OEcIl5V0BzZm5/17zV2O8Yp7WdlRDwWdVT/b5R1Mbg+vjMWwfa
         9Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736225835; x=1736830635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1yfJ80/eWZchC7T0n8tm3VszjO5fqNgDceOTgZmDkI=;
        b=QttmkeA8OvcbB7QlEkY0H/b+qAnXDNPq28OKp/l1e80eoLQiqTzFObBGrVEaYJZXws
         rndIWuMBOF9bDWbu5eXe0E+pNVwjfwg52dp4/r69RTd56cRBi3OhtHcHRr9mCF7kGXvL
         wG3ebff85fGfyCLRmnpg8+w/Ah4yCqQ1ODg6+SSWvovRI4doEGNikg467ZmRINQC7Ms3
         lP9rqky8RfzLSHMluNDfRZ4jL+/em+4p+ahh+oIhHP/Ty1ptww4LRAJB6R0gP+eAtnNO
         5cS9FnrKvMZEIfKqYFde8V2Fo26ErPXawwqQIpVhfV38Qwz9nc5MTP04LT6DROKJuSvJ
         lOGQ==
X-Gm-Message-State: AOJu0YwSzGL6p3E5DozepQR6JSmHp1NIGUDuio664ZrVMK+Ymkj/NmZf
	9qwaWINtOUxkN7HCPi6GpseS+PMkU7D2db6YEEx/7fxDmMvbSArGoMNcRkSc7Ic=
X-Gm-Gg: ASbGncvqy1E59hEfIvhRPQ5G/c57vtzUtYCVUkRTanTtWPOcNlQMVhxQyksVsVq+Ltz
	FtV83DcIsm5Ae43MYwCyHlUUOv9c0czdVp8LXUTZLVQWheJdvsci4WTKy815ExL4CmHmlybZJRW
	hVyjlj6rNFWrW48/ifqAd/WvC6U637PDVSu8pIbuiGRalVxStR5SdXdsVMhI9+dSFCA2d5gG35b
	2MV3by2NEc41anJHAUZMf6y02DbXY5KpX4giQIy5M7n/0yiYqNwTkGii7ZwnQ==
X-Google-Smtp-Source: AGHT+IHk0bnDSVicFKVYQkjk4R/PgDsI5xb8EcGlrJQQSvevPP+OOd7VYLHqJHYyglewFM6LwnCcyQ==
X-Received: by 2002:a17:902:f64d:b0:215:94e0:17 with SMTP id d9443c01a7336-219e6ebb6admr942054675ad.23.1736225835579;
        Mon, 06 Jan 2025 20:57:15 -0800 (PST)
Received: from localhost ([123.113.100.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca025d1sm300954505ad.254.2025.01.06.20.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 20:57:15 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v2 4/5] ext4: Replace ext4_da_write_inline_data_begin() with ext4_generic_write_inline_data().
Date: Tue,  7 Jan 2025 12:57:10 +0800
Message-Id: <20250107045710.1837756-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107044702.1836852-1-sunjunchao2870@gmail.com>
References: <20250107044702.1836852-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the call to ext4_da_write_inline_data_begin() with
ext4_generic_write_inline_data(), and delete the 
ext4_da_write_inline_data_begin().

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/ext4.h   | 10 ++---
 fs/ext4/inline.c | 98 +++++-------------------------------------------
 fs/ext4/inode.c  |  4 +-
 3 files changed, 16 insertions(+), 96 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..78dd3408ff39 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3569,11 +3569,11 @@ extern int ext4_try_to_write_inline_data(struct address_space *mapping,
 					 struct folio **foliop);
 int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 			       unsigned copied, struct folio *folio);
-extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
-					   struct inode *inode,
-					   loff_t pos, unsigned len,
-					   struct folio **foliop,
-					   void **fsdata);
+extern int ext4_generic_write_inline_data(struct address_space *mapping,
+					  struct inode *inode,
+					  loff_t pos, unsigned len,
+					  struct folio **foliop,
+					  void **fsdata, bool da);
 extern int ext4_try_add_inline_entry(handle_t *handle,
 				     struct ext4_filename *fname,
 				     struct inode *dir, struct inode *inode);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3e103e003afb..58d8fcfbecba 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -657,7 +657,15 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	return ret;
 }
 
-static int ext4_generic_write_inline_data(struct address_space *mapping,
+/*
+ * Prepare the write for the inline data.
+ * If the data can be written into the inode, we just read
+ * the page and make it uptodate, and start the journal.
+ * Otherwise read the page, makes it dirty so that it can be
+ * handle in writepages(the i_disksize update is left to the
+ * normal ext4_da_write_end).
+ */
+int ext4_generic_write_inline_data(struct address_space *mapping,
 					  struct inode *inode,
 					  loff_t pos, unsigned len,
 					  struct folio **foliop,
@@ -967,94 +975,6 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 	return ret;
 }
 
-/*
- * Prepare the write for the inline data.
- * If the data can be written into the inode, we just read
- * the page and make it uptodate, and start the journal.
- * Otherwise read the page, makes it dirty so that it can be
- * handle in writepages(the i_disksize update is left to the
- * normal ext4_da_write_end).
- */
-int ext4_da_write_inline_data_begin(struct address_space *mapping,
-				    struct inode *inode,
-				    loff_t pos, unsigned len,
-				    struct folio **foliop,
-				    void **fsdata)
-{
-	int ret;
-	handle_t *handle;
-	struct folio *folio;
-	struct ext4_iloc iloc;
-	int retries = 0;
-
-	ret = ext4_get_inode_loc(inode, &iloc);
-	if (ret)
-		return ret;
-
-retry_journal:
-	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto out;
-	}
-
-	ret = ext4_prepare_inline_data(handle, inode, pos + len);
-	if (ret && ret != -ENOSPC)
-		goto out_journal;
-
-	if (ret == -ENOSPC) {
-		ext4_journal_stop(handle);
-		ret = ext4_da_convert_inline_data_to_extent(mapping,
-							    inode,
-							    fsdata);
-		if (ret == -ENOSPC &&
-		    ext4_should_retry_alloc(inode->i_sb, &retries))
-			goto retry_journal;
-		goto out;
-	}
-
-	/*
-	 * We cannot recurse into the filesystem as the transaction
-	 * is already started.
-	 */
-	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
-					mapping_gfp_mask(mapping));
-	if (IS_ERR(folio)) {
-		ret = PTR_ERR(folio);
-		goto out_journal;
-	}
-
-	down_read(&EXT4_I(inode)->xattr_sem);
-	if (!ext4_has_inline_data(inode)) {
-		ret = 0;
-		goto out_release_page;
-	}
-
-	if (!folio_test_uptodate(folio)) {
-		ret = ext4_read_inline_folio(inode, folio);
-		if (ret < 0)
-			goto out_release_page;
-	}
-	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
-					    EXT4_JTR_NONE);
-	if (ret)
-		goto out_release_page;
-
-	up_read(&EXT4_I(inode)->xattr_sem);
-	*foliop = folio;
-	brelse(iloc.bh);
-	return 1;
-out_release_page:
-	up_read(&EXT4_I(inode)->xattr_sem);
-	folio_unlock(folio);
-	folio_put(folio);
-out_journal:
-	ext4_journal_stop(handle);
-out:
-	brelse(iloc.bh);
-	return ret;
-}
-
 #ifdef INLINE_DIR_DEBUG
 void ext4_show_inline_dir(struct inode *dir, struct buffer_head *bh,
 			  void *inline_start, int inline_size)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..24a3b0ff4c8a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2918,8 +2918,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	trace_ext4_da_write_begin(inode, pos, len);
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
-		ret = ext4_da_write_inline_data_begin(mapping, inode, pos, len,
-						      foliop, fsdata);
+		ret = ext4_generic_write_inline_data(mapping, inode, pos, len,
+						     foliop, fsdata, true);
 		if (ret < 0)
 			return ret;
 		if (ret == 1)
-- 
2.39.5


