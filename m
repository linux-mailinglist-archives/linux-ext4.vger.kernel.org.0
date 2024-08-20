Return-Path: <linux-ext4+bounces-3800-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21649958868
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 16:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AE9281266
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C27B191F6B;
	Tue, 20 Aug 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZsTVHTcg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A891917E4;
	Tue, 20 Aug 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162544; cv=none; b=f0mcaWA9gsFNlq+VFqh3LSM0K/wDf8jFYkRMLUCs+Ze0SCOkUDQdoHPmh/RRhO+c3WlswsSZteFv0tm+hhVdIhPcGIOPjS3GzWHJsTm1QwnuU4PhGI7xEv9zERSjpj1Ovj4elPWmtEws0zXzXdoPD1HD5OmPu1qa7sP2RBtFQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162544; c=relaxed/simple;
	bh=/RP+vchqEyeezYylnz8b10s5iJ9FMw2qzdebpR/Z78U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8nmQQ+Qm0IOfbeLLxk6QfRXeIel0cTAKo++wE5yNsA/aEs/Eb/KTSyqZbA8S5IRkDZo6pvSC/+dFYyu2LZHacI5+rPohZ68/Soi+ijpOcSPOGZ3AfdFLbULGaJOloq/vQY9l86bOXaM+qWS5W8+tHTFaeesRezsY1jzX8GMdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZsTVHTcg; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sXowgNI7Ym7p4ze9gJRZD2DGLWRu4RKLL5qm9E1s/ns=; b=ZsTVHTcgNKZ2oRSChowadTFdMb
	xGtRVwUHj4ySi0UkAO+GkGS5CVs4dvM8IwesectYlk/DvqtAxVVG0kbTwGZ11wRU/zrwZpyF9DeYG
	e0XD53wQRhKa0cW+qXTxVJLfi+n0JdcPZWfQk3M2d9bsI/jElVx+YhuNBeOJXPn2YTU+MMPEznp2x
	PJESkvzek2wHQ89abJ0qQOP7Zpsb7mLRkYUTu4eNrecW+kywS6gYL6GwU66LyhuKrRZ+txhjT2Gxx
	4phuuIQ/Sy93a3tBu6YNVpkKM/BByvzzm22QaU6E2xqIiJiDzm2Su12xzr1uKxYr6T2PKs3BFd3Cc
	n8It4SkQ==;
Received: from 179-125-75-209-dinamico.pombonet.net.br ([179.125.75.209] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sgPRA-002duS-Pe; Tue, 20 Aug 2024 16:02:16 +0200
Date: Tue, 20 Aug 2024 11:02:08 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: syzbot <syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_search_dir
 (2)
Message-ID: <ZsSh4NUWT7MlvlSL@quatroqueijos.cascardo.eti.br>
References: <00000000000062812a062004738b@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000062812a062004738b@google.com>

#syz test: upstream 47ac09b91befbb6a235ab620c32af719f8208399


diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e7a09a99837b..44a5f6df59ec 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1664,24 +1664,36 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 					struct ext4_dir_entry_2 **res_dir,
 					int *has_inline_data)
 {
+	struct ext4_xattr_ibody_find is = {
+		.s = { .not_found = -ENODATA, },
+	};
+	struct ext4_xattr_info i = {
+		.name_index = EXT4_XATTR_INDEX_SYSTEM,
+		.name = EXT4_XATTR_SYSTEM_DATA,
+	};
 	int ret;
-	struct ext4_iloc iloc;
 	void *inline_start;
 	int inline_size;
 
-	if (ext4_get_inode_loc(dir, &iloc))
-		return NULL;
+	ret = ext4_get_inode_loc(dir, &is.iloc);
+	if (ret)
+		return ERR_PTR(ret);
 
 	down_read(&EXT4_I(dir)->xattr_sem);
+
+	ret = ext4_xattr_ibody_find(dir, &i, &is);
+	if (ret)
+		goto out;
+
 	if (!ext4_has_inline_data(dir)) {
 		*has_inline_data = 0;
 		goto out;
 	}
 
-	inline_start = (void *)ext4_raw_inode(&iloc)->i_block +
+	inline_start = (void *)ext4_raw_inode(&is.iloc)->i_block +
 						EXT4_INLINE_DOTDOT_SIZE;
 	inline_size = EXT4_MIN_INLINE_DATA_SIZE - EXT4_INLINE_DOTDOT_SIZE;
-	ret = ext4_search_dir(iloc.bh, inline_start, inline_size,
+	ret = ext4_search_dir(is.iloc.bh, inline_start, inline_size,
 			      dir, fname, 0, res_dir);
 	if (ret == 1)
 		goto out_find;
@@ -1691,20 +1703,23 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 	if (ext4_get_inline_size(dir) == EXT4_MIN_INLINE_DATA_SIZE)
 		goto out;
 
-	inline_start = ext4_get_inline_xattr_pos(dir, &iloc);
+	inline_start = ext4_get_inline_xattr_pos(dir, &is.iloc);
 	inline_size = ext4_get_inline_size(dir) - EXT4_MIN_INLINE_DATA_SIZE;
 
-	ret = ext4_search_dir(iloc.bh, inline_start, inline_size,
+	ret = ext4_search_dir(is.iloc.bh, inline_start, inline_size,
 			      dir, fname, 0, res_dir);
 	if (ret == 1)
 		goto out_find;
 
 out:
-	brelse(iloc.bh);
-	iloc.bh = NULL;
+	brelse(is.iloc.bh);
+	if (ret < 0)
+		is.iloc.bh = ERR_PTR(ret);
+	else
+		is.iloc.bh = NULL;
 out_find:
 	up_read(&EXT4_I(dir)->xattr_sem);
-	return iloc.bh;
+	return is.iloc.bh;
 }
 
 int ext4_delete_inline_entry(handle_t *handle,
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 6a95713f9193..14163b32eddb 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1482,7 +1482,7 @@ static bool ext4_match(struct inode *parent,
 }
 
 /*
- * Returns 0 if not found, -1 on failure, and 1 on success
+ * Returns 0 if not found, -EFSCORRUPTED on failure, and 1 on success
  */
 int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		    struct inode *dir, struct ext4_filename *fname,
@@ -1503,7 +1503,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 			 * a full check */
 			if (ext4_check_dir_entry(dir, NULL, de, bh, search_buf,
 						 buf_size, offset))
-				return -1;
+				return -EFSCORRUPTED;
 			*res_dir = de;
 			return 1;
 		}
@@ -1511,7 +1511,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		de_len = ext4_rec_len_from_disk(de->rec_len,
 						dir->i_sb->s_blocksize);
 		if (de_len <= 0)
-			return -1;
+			return -EFSCORRUPTED;
 		offset += de_len;
 		de = (struct ext4_dir_entry_2 *) ((char *) de + de_len);
 	}
@@ -1574,7 +1574,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 					     &has_inline_data);
 		if (inlined)
 			*inlined = has_inline_data;
-		if (has_inline_data)
+		if (has_inline_data || IS_ERR(ret))
 			goto cleanup_and_exit;
 	}
 
@@ -1663,8 +1663,10 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 			goto cleanup_and_exit;
 		} else {
 			brelse(bh);
-			if (i < 0)
+			if (i < 0) {
+				ret = ERR_PTR(i);
 				goto cleanup_and_exit;
+			}
 		}
 	next:
 		if (++block >= nblocks)
@@ -1758,7 +1760,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		if (retval == 1)
 			goto success;
 		brelse(bh);
-		if (retval == -1) {
+		if (retval < 0) {
 			bh = ERR_PTR(ERR_BAD_DX_DIR);
 			goto errout;
 		}

