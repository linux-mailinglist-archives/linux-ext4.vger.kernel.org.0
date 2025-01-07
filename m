Return-Path: <linux-ext4+bounces-5947-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC84A0372B
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 05:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C655E3A49DF
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 04:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721B197A8B;
	Tue,  7 Jan 2025 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRsK/U8a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB1770FE
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736225778; cv=none; b=D4dpzJ+C/PCihwmkGKiNcSiX17Smp7VVsXYf3kauXkdNgYJirAPqU/JuWQuSPyZrAZydKfeQIcJCA55nogpXOuFCA9EUdjS01sG7x15zjdg/te7xgwXw+Sr95Kw98SHJiZgqhCJi9ze3Vt5P3H/KJ9SjtgcX45q6X90fpCqHe/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736225778; c=relaxed/simple;
	bh=HAMhpeAMU4cpNzPVNKxKONutuA2jctDvMDJLVr/snKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CsntyZ3TnPpyOkuh3X6RyB0I5xSFNHdty3tfRS0HQDa6VU3gussFPJXPf0rsiLnca1Fc0H40Hm+G5HNQRVe+ZXcdFjcv7j3aafSl1Mh3tDRnoFyjPA33r8ppTIrDmbukUcmRmAt0d+nUADeBVn/F7H/YWlDnRJzBQw41ZwSLAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRsK/U8a; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21628b3fe7dso212956275ad.3
        for <linux-ext4@vger.kernel.org>; Mon, 06 Jan 2025 20:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736225775; x=1736830575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9oYItJ97ao6M8iGq3e2bAdygRw21GysYLCgQSvyL3E=;
        b=jRsK/U8aeIZJrUKh9Xb4giKrD7JlRD10PRQIVMKYvFHwfTS/56+AUIXlwHDMMkKcoy
         wPTBcEl+ALDgDbRIMyvzYPHokVqDbp37qtO5NADWH48D3EGJZruC5rXvzzQIx1PSivEj
         bUvFsOcSp9pgnXdOIMDvJE9CsNy7GQ2LKVNUyctim86InUaEfv7UShYA67Zh+RrNpqZ/
         rg8mkhFDCk1VBR+ePidqyi4Ig6Go6/VHtGSSCIg0hSDLowrq1oHp8EAsEwdOPXxvW/jU
         2/cqAxYbJuui140Vn8LV32+KiEwjHJOKjPW/5xFEhRG+vW1V7XWoTT9UmmKZUNoO29fs
         Ss3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736225775; x=1736830575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9oYItJ97ao6M8iGq3e2bAdygRw21GysYLCgQSvyL3E=;
        b=qEU4W6Oqd86TKLgUby5MGFbbWMw5KiDcIfTMIE+xzx9TOivNg+wzw5Imv/SAMGogNR
         dV7JHXXF3QQLG6AYCIhYWH38yq1NfYQMQbJGcLfw6uPpEx2gq/BuntAPJiuKarbVLtTa
         xHZ7BG6bw/SthNtj/qHfSccEOeX5Kb5cG37UxOVUF/pcp9SUdOlJXaofVfnEI+WAzC3i
         hwlEZ2sYpsFwnE8GJ7uqYczQsAdBHRGVFdefcnyXeiMnON84jejkoilHKf9uxOg21bGd
         AY4R89bD6PSw5Vx6VswWZQA5b1pFxxWuroQf7W06zsbiR3kZPE0fTVSTUzUpHJ3NTUsy
         hQlw==
X-Gm-Message-State: AOJu0YwAZSP1RHB1Rrd99W6wj2UyDZEDucOEsaOga1gurOOdqBj9PcGe
	lAbtrtJ13Jt7qd7Zg5G+twCQ5ODKSPhfuiNgAnNI9W6K9r5nl+I81UYP2z3k9aQ=
X-Gm-Gg: ASbGncvEUU5nMLaEPDI1kxAZmjtUX9XhU4OKrHlHtbXxrsX0ZdGu9cJ62n7to4MmbF4
	4LmnaTuZwaRIAhN1zSRoGSITedt+/httxP7PbRis9hm3x5lcY3M6dXijVV0E0XzBwkeS0iAnF5I
	u/7M7R9igXNMd/yh4StE3+B9xGL6I8S8StNd68BXxiIdOOsKSKRMsHwgJ3/yMipcU3ZF+XhyecK
	yZRAXcCLC/QT1SUpfz0+F3g27eNeRBAyw3egoJ5R4iI8oBfc0XzTZFsATvaig==
X-Google-Smtp-Source: AGHT+IHlbJBwPIeKm3wqSkdo2+eQeEPYfItvtw7ZjrMO6KWviV5EJg3Hsad/L5BTE9kZ754RWKPqYg==
X-Received: by 2002:a05:6a20:d045:b0:1e4:8fda:78ea with SMTP id adf61e73a8af0-1e5e08661eemr106871813637.46.1736225774854;
        Mon, 06 Jan 2025 20:56:14 -0800 (PST)
Received: from localhost ([123.113.100.114])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842dcaca43bsm29904597a12.66.2025.01.06.20.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 20:56:14 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v2 3/5] ext4: Introduce a new helper function ext4_generic_write_inline_data()
Date: Tue,  7 Jan 2025 12:55:49 +0800
Message-Id: <20250107045549.1837589-1-sunjunchao2870@gmail.com>
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

A new function, ext4_generic_write_inline_data(), is introduced
to provide a generic implementation of the common logic found in
ext4_da_write_inline_data_begin() and ext4_try_to_write_inline_data().

This function will be utilized in the subsequent two patches.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inline.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..3e103e003afb 100644
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
@@ -652,6 +657,87 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
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
+
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


