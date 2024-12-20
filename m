Return-Path: <linux-ext4+bounces-5819-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2189F9536
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 16:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988A516749B
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1843D218EA0;
	Fri, 20 Dec 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knTPwv32"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D69219EA0;
	Fri, 20 Dec 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707844; cv=none; b=TnqFj22PbfkUWeGRV5NKA+njTqdXOrkDBsIg/j0Y6mzYeBhXtTVRwddoXUlLGwkTnLHN9ZjJhgSCoFehwHTIoRbCd1Z/+nA+1c8+errP3nMyurqjc20MlvVz28jyUjogcwSXxoOrawOkPZNsG/66pPPtbokUA0Ar2XMDcnkfduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707844; c=relaxed/simple;
	bh=vbVdTfdfp5lb6LbT4z9rcX33jZhZ/+Hz+G+ZW7iFIRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ilvdfBh2U93H4KgqthcWj3n030s+uLjOkTS9hN7e84tpHT564FXHZzF2uQ6YYhVUht2uT0RdJIdIg/F/sVM6x4RRDzfkuin2y5FmzQQ9ICgqiSyMBbGAGRXsCInOEJbGbnGI+vdu0V3dNhh0qLtNHVozzcs1j47MNA+TcFTsQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knTPwv32; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161eb94cceso14198215ad.2;
        Fri, 20 Dec 2024 07:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734707841; x=1735312641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFIyTYptesldPIEJHxlIStIBxP3eV3kAABVRgii/L4Y=;
        b=knTPwv32lzn+TJ1U+yySg0wzNv1tyYVzEDoWaWJj9CFje1Xkb5yuN4F1FSXCHxWA5n
         NFec90KEjq0qxkK5AcP6hSjnSxoOA7pBrVnyVvwMdoY6EkB0n4pZ+ssQqfgt8XNlb6oc
         TWSs0O774Y0TyxKnQxXlWIHV52S7zFys2NGUEfL0+dkN94KkuR/XaJUwhSx7UAkar7x9
         HbsGpQZBuNiwxozdORTVyPazbaDw6JEFwmxqt6SjtQZ+sKljT7kvig4LCzRjNsCz8e8v
         lFUaD4ADXWYtO7JCmRA6vE0JVMOp9ginurqD+0EDVFHDHHT2i2L7ucSSQ7qyCbPPfddk
         ruhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707841; x=1735312641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFIyTYptesldPIEJHxlIStIBxP3eV3kAABVRgii/L4Y=;
        b=TmpEUvaOhMswUy4RkFeJBo6zhn42sfjg/zJoR4Ir5jnwNH4vXWuiL6y3Z0ngR9q8tN
         FCNuFfDk2es4t72OiIdoNxU0EqUXJG+CKXZecs1V6TqZu+PCOIzM5HC3KtD2IAx9nzAz
         5/BWldtEpvRAUF+5HOnKh1W79NEDLpvX+vaVAoRol8U43m/FdeeK5jAi70bMM345aReA
         DOO9lue+qp02+3VaMyzUNCyEn7yHz+rEE7VOfeydZApLXbryYfwYr8qiHe7uOdK5B4SX
         YRGXkiVkENMB6u4lWlAc1NfMKgbaMHnya/N1Oiyx1Jp9m6y6kd/gjsowTDuHlyuf8biL
         7adw==
X-Forwarded-Encrypted: i=1; AJvYcCWuyniwo6YBSkxxf+B7YMllA1cUAmMH84KP4nWGdebaYLOEkHE4gK8Ivd6PUuYgr2jUZC01e5e7qqQhBe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4hsV+TbtO0aeGHdELv9//A0PuFuvnDRKSu03r4ix1Kjeen4K
	kyoLUjT9leY5hKYzNuhYpjIbEqc0Aq5PmJvr3UQ0USDz0N5BiL+jxPFw8lMOsuGMYw==
X-Gm-Gg: ASbGncugbn0Gd443a6/0gmnuzuyZNoZqMCuL+jzwpJZoV0X6fR/Zlqf9ONV3j59PwME
	uqk0AHvBZf4epRSL10z/m0xe/8jHVp7Z1KbdKmz3nhj4oGPqxKVP2HkIxuTNfRUiSHZ3CU6tSzo
	8Y4m3Q3L6zgd+vnf+kaqBJuYYU8Qtj3lF0dSC+iAGuF1fYHm9tNwT3Nu+KnyzQqpZi3Sv7csKHq
	8gJmAwGJLh5CdgPHZvMF5aKYriUm5jJe0+eqxEVCgJ8EAvDZZdNhkJe+ynKILM=
X-Google-Smtp-Source: AGHT+IGIQAFfUQfNPws4NZLQv1S5w2JvCUif5EYZO3iksQ3YOhQ2eGlB38c8O6U4NeJ/X5pQXqks5Q==
X-Received: by 2002:a17:902:f685:b0:219:e4b0:4286 with SMTP id d9443c01a7336-219e6ebcabdmr40215945ad.29.1734707841024;
        Fri, 20 Dec 2024 07:17:21 -0800 (PST)
Received: from localhost ([240e:404:6e10:2b36:20a1:a4d1:f531:7695])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02f95sm29590465ad.280.2024.12.20.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:17:20 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	boyu.mt@taobao.com,
	tm@tao.ma,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH 4/7] ext4: Introduce a new helper function ext4_generic_write_inline_data()
Date: Fri, 20 Dec 2024 23:16:22 +0800
Message-Id: <20241220151625.19769-5-sunjunchao2870@gmail.com>
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

A new function, ext4_generic_write_inline_data(), is introduced
to provide a generic implementation of the common logic found in
ext4_da_write_inline_data_begin() and ext4_try_to_write_inline_data().

This function will be utilized in the subsequent two patches.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/inline.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index d479495d03aa..7eaa578e1021 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -20,6 +20,11 @@
 #define EXT4_INLINE_DOTDOT_OFFSET	2
 #define EXT4_INLINE_DOTDOT_SIZE		4
 
+
+static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
+						 struct inode *inode,
+						 void **fsdata);
+
 static int ext4_get_inline_size(struct inode *inode)
 {
 	if (EXT4_I(inode)->i_inline_off)
@@ -651,6 +656,86 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	return ret;
 }
 
+static int ext4_generic_write_inline_data(struct address_space *mapping,
+					  struct inode *inode,
+					  loff_t pos, unsigned len,
+					  struct folio **foliop,
+					  void **fsdata, bool da)
+{
+	int ret;
+	handle_t *handle;
+	struct folio *folio;
+	struct ext4_iloc iloc;
+	int retries = 0;
+
+	ret = ext4_get_inode_loc(inode, &iloc);
+	if (ret)
+		return ret;
+
+retry_journal:
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto out_release_bh;
+	}
+
+	ret = ext4_prepare_inline_data(handle, inode, pos + len);
+	if (ret && ret != -ENOSPC)
+		goto out_stop_journal;
+
+	if (ret == -ENOSPC) {
+		ext4_journal_stop(handle);
+		if (!da) {
+			brelse(iloc.bh);
+			/* Retry inside */
+			return ext4_convert_inline_data_to_extent(mapping, inode);
+		}
+
+		ret = ext4_da_convert_inline_data_to_extent(mapping, inode, fsdata);
+		if (ret == -ENOSPC &&
+		    ext4_should_retry_alloc(inode->i_sb, &retries))
+			goto retry_journal;
+		goto out_release_bh;
+	}
+
+	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
+					mapping_gfp_mask(mapping));
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
+		goto out_stop_journal;
+	}
+
+	down_read(&EXT4_I(inode)->xattr_sem);
+	/* Someone else had converted it to extent */
+	if (!ext4_has_inline_data(inode)) {
+		ret = 0;
+		goto out_release_folio;
+	}
+
+	if (!folio_test_uptodate(folio)) {
+		ret = ext4_read_inline_folio(inode, folio);
+		if (ret < 0)
+			goto out_release_folio;
+	}
+
+	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh, EXT4_JTR_NONE);
+	if (ret)
+		goto out_release_folio;
+	*foliop = folio;
+	up_read(&EXT4_I(inode)->xattr_sem);
+	brelse(iloc.bh);
+	return 1;
+out_release_folio:
+	up_read(&EXT4_I(inode)->xattr_sem);
+	folio_unlock(folio);
+	folio_put(folio);
+out_stop_journal:
+	ext4_journal_stop(handle);
+out_release_bh:
+	brelse(iloc.bh);
+	return ret;
+}
+
 /*
  * Try to write data in the inode.
  * If the inode has inline data, check whether the new write can be
-- 
2.39.5


