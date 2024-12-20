Return-Path: <linux-ext4+bounces-5820-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555EC9F9540
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 16:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F287A1883D89
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761122594BB;
	Fri, 20 Dec 2024 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev+WcNOg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D021A438;
	Fri, 20 Dec 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707851; cv=none; b=IXTMczXxeipn4ELDa4ibrDJ2cT7KjNopPvxh4mShj/0EyHsvrdduSzlCu625mUURaBZ4CSTA7D9ChuITZ2aIPPRCAEpo0c4duqA0JEOG15TPWdY95ImeyWWn1XitXcBbU0w1C9rScwxDsSCjL2v3jKypJukLCQkAaceh5FugX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707851; c=relaxed/simple;
	bh=HzHq+CR/BlfrE1KWVHAOcyJf+u7oLyfRutvuuURumF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pPz30WIHN0s4pu+sgL5qRAKdJ/znu7QVaFBg0aWd3YE8AmWQP7Upb/ttMFOnZ05bWIhVr6pZKTDHUk8LxvVyiiYwt22vKGNKaTeUThqj3K1st7bjoC7YPHtJv8cwqYYJaRUrEAooxkYe2c8GOnrTu/TxZXljwauzZfu/y+UVGKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev+WcNOg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725f4025e25so1733452b3a.1;
        Fri, 20 Dec 2024 07:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734707847; x=1735312647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIKBXxjfXK7ToW398PmJS8mZL27WZ4D2BAwWJ5Ye6XM=;
        b=ev+WcNOgdt4hbMBbCM5aopsmycAkwSePIv21QTaNxUt2j8F7w5+2nw/9IwLhicsAA9
         Dhjm32rRVMPgSQQfLEryD5v77vbaSq35FR6IMLhgV2kMTdUIwElfBVf/PokpvvDL4B5m
         FBgs1kBVfuwKR/rS+eQUoHxhWKn1bhzMHcCcHuWaopOljID7gapNRxf4GdDi5M8iI6PY
         cCDF5nex0QmhtuESgzOdMbXGx+PXTv6mPjsxuJDNTBvDkEkt+esgMoELq4bxjrtAMZjI
         CyB58iEs1Mu97JEmX+FtIAg9jZp87aWMLiVuV8s3PdzbfZP2wB1mjKQKS1D63ihAR9c8
         VWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707847; x=1735312647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIKBXxjfXK7ToW398PmJS8mZL27WZ4D2BAwWJ5Ye6XM=;
        b=ZdfbIhTdtX0o7Ml9j4SZY33iFUKCIEtzUkDA6D8jyKUl7+/PQU7nuZNJ7OR8O0W1OW
         aEvBiniDgI54OVgNxcyQfAT26X0cN/o15Ozksqfnm/PULzkv0f4urLlA8uzW4EQVUoR+
         oPanBttxuQRxueHb/wfCynbkX+GWGZ51Df8acZxWfcsDcJ0ughQA9P0FnBqBPXp6KB/0
         PV/ee8bXPEim+v5GDqwm9FDqXZYp7mC8B+YvSZqCW983tHOV+9xlYjZ5swK4tJ9KBgoM
         lSk7pL9prmjAFrqtZYxUQnaeu5fSJdbq8kagVit5z4IqF1wG0w4Y0maEo4yt+NV9eE6B
         bfZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgOPOG35Zu3pGDBEbmVZIncEfAEXrHBa51FG37gIm23LVAxAwFJ5Hzdoe3WTfRQ92ZNmhGC9zGjNBcjNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETe9uOtRGVAgMr32Mn0cDdzDNticv+b6wVkfh+1xHp8CS8XLR
	uiRFlkkT+3+42fNR6sqg5cw2lyaRrrBSYFgpJMw2a8vcFqNMvSL0NiN/h+pDSU26Vw==
X-Gm-Gg: ASbGnctyWW9h5WuHsQfR1NNg4MkRIyT4TEeql5zVp0cDgH82rQFdy5fKQSMiOJlbP9r
	fw0+/POVs2WzQjeIrdZhnQVDVN1AaahuUzFS/7inuyuz5DuNSrJKPTmJLG0utUe7Qa9vBp+anU3
	7kUeQhnjA928EwqWSipaAoZG1yrZUuL8HiGVfE6AJNAMxMumJ3skcy4l3zQZJpNO7ZRk33RKzxs
	kc42fb6FLgZ2kJp01v50go3v6+oErlrR5p4wb/zlQ0mHu+1oEZue+c+9s2g3o0=
X-Google-Smtp-Source: AGHT+IFDOVEjHTXCADw9yeT74Dxmlme2vJ2l2m3sj/ocknvg2b4YTEWChCqLXtUiSmxMN/ZjQx7clg==
X-Received: by 2002:a05:6a21:670b:b0:1e0:d32f:24e2 with SMTP id adf61e73a8af0-1e5e081edf3mr6302465637.38.1734707847599;
        Fri, 20 Dec 2024 07:17:27 -0800 (PST)
Received: from localhost ([240e:404:6e10:2b36:20a1:a4d1:f531:7695])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbbabsm3334645b3a.101.2024.12.20.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:17:27 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	boyu.mt@taobao.com,
	tm@tao.ma,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH 5/7] ext4: Refactor out ext4_da_write_inline_data_begin()
Date: Fri, 20 Dec 2024 23:16:23 +0800
Message-Id: <20241220151625.19769-6-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241220151625.19769-1-sunjunchao2870@gmail.com>
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor ext4_da_write_inline_data_begin() to simplify its
implementation by directly invoking ext4_generic_write_inline_data().

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/inline.c | 74 ++----------------------------------------------
 1 file changed, 2 insertions(+), 72 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 7eaa578e1021..5dd91524b2ca 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -979,78 +979,8 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 				    struct folio **foliop,
 				    void **fsdata)
 {
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
+	return ext4_generic_write_inline_data(mapping, inode, pos, len,
+					      foliop, fsdata, true);
 }
 
 #ifdef INLINE_DIR_DEBUG
-- 
2.39.5


