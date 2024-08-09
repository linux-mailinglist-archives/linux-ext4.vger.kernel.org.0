Return-Path: <linux-ext4+bounces-3682-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2352B94CAC3
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 08:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B361C22014
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 06:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C428416D4FE;
	Fri,  9 Aug 2024 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/sVgBZK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E902216D4EE;
	Fri,  9 Aug 2024 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723185991; cv=none; b=QRgPPND7XFV2eI8EXd22Z4u4kyZDUIhIHMtcfVkKEnEj+cDdSIe6o4lR9HWpwgA7dplxc73i/GxSopQBfx174EF4wiQIUUfWzLmrYLZ20kk5l/HE3W1hVJwgbtZ9bNAo042lcJifC9hZm9/fXqIpV+r+xak7f5lPZGDy0dl47Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723185991; c=relaxed/simple;
	bh=0XjSVnAX262gGnoCnVHs2qpH728XqwdlxfLY0/kEphI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itobLQO7dqM+AsvuswqpehDqFSpBnEgJhGF+BkCrOYSi4HnmgBrLDzl3tkD3+2SmOZpCAJXk4JYvChXu84ODVdObuzgvax/g/TTXVy85DFFs5RWJT4zHlWK7MHVp9Ovs4tcWsNWLOUfBF1RB4aDkU0NgIsT9HHh/0SgOY6NQ0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/sVgBZK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb510cd097so1451133a91.1;
        Thu, 08 Aug 2024 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723185989; x=1723790789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmeU6YujhDN+JQ00gbkG5q3lZjXBS3ZjjOccDr3kLEc=;
        b=I/sVgBZKjdzHeA6ho+KX7mNMFWtKJywPtx4z49wtIxOc4Z/rVpllN4Qpx+8rs5ziTt
         nwZoGreoLTy+niv84dhO4duPywKol9jxgSqtI4pmqJHSlt9AGqn+VouuNL8kSdfdt8gF
         pEWtHeF81JOebu8LjJbvk/dnHa1R+BELPglzd0wH6DTg2zptgI+Buoq1zS0eQVM+WDRN
         rwh1422IIcN/kGEDLnVbvU/jfId3wqGmZT6decdY2y+WDzZRMWyRhj4FnlAI7cq9yeN4
         6QZdtVk+adnOiDcdAAktrfGJ+bLepBBMrtg5XxowNsSKDPRzRYxqrX1xd7iIdXgbP2bI
         T61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723185989; x=1723790789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmeU6YujhDN+JQ00gbkG5q3lZjXBS3ZjjOccDr3kLEc=;
        b=LNxXYayQ8XSpBndt6dEYUx0muVidGusuOg4/u+CJRsY5V283V2mUy9X8vC7UmKxclV
         Wv11OVrK3fVNoNa2syh1jcw1iAFoEWLKyzYfF8T9qUQGxL3i6o2TjIzVq4R0cMH9SzK4
         3rV4hYP/dfT+oUAh5h9W9Rlqrn0STRVdDRIzbKQbURsA2xKutvJkuzU/rn4opEOaUBAT
         we4igb5/7NfByPNGfElgVcBiRkvAno2hjnUC5eIYMotEx0JxO24hk3tEZyEnj/e2R2XZ
         ur0wrtKB++IP2p0kXIruU94HP/Lgdio88//vQ5yfG2lpx/6fLSbbcL/mA01A+LLBVovU
         EzWA==
X-Forwarded-Encrypted: i=1; AJvYcCWAI4YL/Yzh6++HLymZwbIQDP1RxTNnHXVTGvbjBKJL7j8Nj2OrFel+qSDWisGemOM0c72stayRHGELerg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0883ibIYgn8lUY+aN6u11CeMp+hWhZcVQlDNZsGUG9ft8A/7d
	YUmY1WWWGKIYLLsa+ksekJjHf/zJ3Dk0kxkE23dikzBX3H9jB3+w
X-Google-Smtp-Source: AGHT+IGXN4pPCc482mbAOY0AU8yxNDO8RXnNS+hRFpMl0trjmLBMX9o8YHd5C8A/dENRrBWSJUTCRA==
X-Received: by 2002:a17:90a:c695:b0:2c9:66d3:4663 with SMTP id 98e67ed59e1d1-2d1e80a08e2mr478057a91.43.1723185989209;
        Thu, 08 Aug 2024 23:46:29 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9db44e5sm2201491a91.46.2024.08.08.23.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 23:46:28 -0700 (PDT)
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
Subject: [RFC PATCH V2 2/2] ext4: Replace the __block_write_begin with ext4_block_write_begin
Date: Fri,  9 Aug 2024 14:46:06 +0800
Message-Id: <20240809064606.3490994-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809064606.3490994-1-zhangshida@kylinos.cn>
References: <20240809064606.3490994-1-zhangshida@kylinos.cn>
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
fscrypt related code. Narrow the scope of CONFIG_FS_ENCRYPTION
so as to allow ext4_block_write_begin() to function like
__block_write_begin when the config is disabled.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/inode.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index de46c0a6842a..31389633086a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1046,7 +1046,6 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 	return ret;
 }
 
-#ifdef CONFIG_FS_ENCRYPTION
 static int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 				  loff_t pos, unsigned len,
 				  get_block_t *get_block)
@@ -1135,7 +1134,9 @@ static int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 							 from, to);
 		else
 			folio_zero_new_buffers(folio, from, to);
-	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
+	}
+#ifdef CONFIG_FS_ENCRYPTION
+	else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 		for (i = 0; i < nr_wait; i++) {
 			int err2;
 
@@ -1147,10 +1148,10 @@ static int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 			}
 		}
 	}
+#endif
 
 	return err;
 }
-#endif
 
 /*
  * To preserve ordering, it is essential that the hole instantiation and
@@ -1232,20 +1233,12 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	/* In case writeback began while the folio was unlocked */
 	folio_wait_stable(folio);
 
-#ifdef CONFIG_FS_ENCRYPTION
 	if (ext4_should_dioread_nolock(inode))
 		ret = ext4_block_write_begin(handle, folio, pos, len,
 					     ext4_get_block_unwritten);
 	else
 		ret = ext4_block_write_begin(handle, folio, pos, len,
 					     ext4_get_block);
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
@@ -2978,12 +2971,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-#ifdef CONFIG_FS_ENCRYPTION
 	ret = ext4_block_write_begin(NULL, folio, pos, len,
 				     ext4_da_get_block_prep);
-#else
-	ret = __block_write_begin(&folio->page, pos, len, ext4_da_get_block_prep);
-#endif
 	if (ret < 0) {
 		folio_unlock(folio);
 		folio_put(folio);
-- 
2.33.0


