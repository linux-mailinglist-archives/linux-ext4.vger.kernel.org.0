Return-Path: <linux-ext4+bounces-5949-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7CAA0372D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 05:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3779C3A498C
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 04:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24A0197A92;
	Tue,  7 Jan 2025 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsipeLsm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D12770FE
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736225859; cv=none; b=WMO+RvxXhZjZZtTX828BlKoNBaWsNsFzeef3eEynsBZGnjXsxC+WvxuGxkqQCsKcXmx2HkZ51cRgOiN9fNmoNYAbbmP5mI0FNf5PJs7XDIMlbkvmFI8oOWHvvCw07fa/QeIYyhJJYy12+wP/+9ubtb/EY8mYasXcwtMP4xGxFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736225859; c=relaxed/simple;
	bh=7+afrIzSXf6bVosr4j6TGKV7ocU9s1o85pHiNPq9MOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPO3TW+Zr0i+TYq/546Vhc15Q1wfQ7A679ywkKlqrq8gHYr8NUJ1GZygPAgWDz/w0e9dP5vA2kML4em5opwBFCPLCCefIxGxr9tusTLkIa01auKHe4AzMJUMhJ79vc+7hsowXlrKR3KUUyO5dn/u/AfsYIatelocjvN1PrrnOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsipeLsm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216426b0865so214656925ad.0
        for <linux-ext4@vger.kernel.org>; Mon, 06 Jan 2025 20:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736225856; x=1736830656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5h+NURRzAzCWUjwjXEqx5O3Li7qjWu9YhpKWCGnGCE=;
        b=SsipeLsmbLmdhiDW/k4g0mSL2IUXAdotL4lD+jdJfMo/2KHYhUPJDpMTIKyg8ztaKW
         31n6MyMLq+RVyfjKA1evlN/23MoSQagWlFLH1ddAVXvxQGK7K7wyS7+r0nm4wiPeodFn
         Rc8ILhE8h4gRRxyQo10k2bzSK5N2LxI64JvFWqZp3EzN96QyFTvUAbnjTO+joH5kDChd
         v9g/HuJYKpE9+24M6pIySbDKLo0UC88rPNrFSnqM7WEprkOQJ192BdPLffLW/sAg9sz5
         bDyppfpRMACdxZactemUky8DumIlZgEY0+n6ekrm7t7VrX1RuhFToN8Uo9J97M7nq0jF
         S8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736225856; x=1736830656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5h+NURRzAzCWUjwjXEqx5O3Li7qjWu9YhpKWCGnGCE=;
        b=gD3GBtdpoSEInVp27AktIUTsm1rbZFxcuDEjDown5rq/tsXrHCTA1xxvg4xB2eebQJ
         drbH03YadHnh0Pun9CrRJztHqveC1m0Msg68suHI4WcVB3mrSAtltZ2izTF2LTx5Swr4
         oWOYDgufz/GxKR4vT1XKjphuw14c3XBoL1fVTLX63PURc8rj4ySFUN/7L3P/rU4Q4HQ6
         VuBe7ya6bIHGHoxKrO5jgJnliLxELNNKiLDm6B0v2NF9ErH0JaEcX3uJGcFKJRrRfQLk
         F1Jnnxzr/nuOAtLAju2ExFX6I/frtP/A+xVKLECLMOnnNa9DcMxcT2jvHHoJmUCprqco
         XltA==
X-Gm-Message-State: AOJu0YwvhA9+j9HC1qq9534lrcEvgZ+WHGDocKQoJg64B9rCFeGLVHyP
	y+4EfptBaAS2juLHowh0c6w8iL4Nno0YOcshlTbXH/f7jLtCE/7gDGmZFXnPuB0=
X-Gm-Gg: ASbGncsurN19AmH+olK6wyPac3sx+oKhSP1I89s4Ah6crvseZxgRCJKF5y3r+U9YxSw
	7mQwmp1FPO4jDp2nK2ag0hswc/a+tcBGN7RBfSeteNumPzvwy71/FvUQpCDj02gC5/N9Yk/xqvJ
	4jsiDuuyw8qLjcvD9S1Phc5YU7RdhcFk32fhJyGn8hu+wbT5VGDNjBBFRecgzla+wYV79FSWSml
	2wN25AgrVyMZJ7GEq6Jck4alaL2cNdy+Fh30C9pdDHACddjBA22hfbUlEUD8w==
X-Google-Smtp-Source: AGHT+IGdOM5haKqo9hImmcP8hOWjC4MuYF7otI3rY2xiRpMdnb/yjxIEXaAaCAk4e97OUu60vWcb5Q==
X-Received: by 2002:a17:902:dac6:b0:216:2426:7666 with SMTP id d9443c01a7336-219e6e89559mr756660915ad.12.1736225856156;
        Mon, 06 Jan 2025 20:57:36 -0800 (PST)
Received: from localhost ([123.113.100.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02955sm302048485ad.266.2025.01.06.20.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 20:57:35 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v2 5/5] ext4: Refactor out ext4_try_to_write_inline_data()
Date: Tue,  7 Jan 2025 12:57:30 +0800
Message-Id: <20250107045730.1837808-1-sunjunchao2870@gmail.com>
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

Refactor ext4_try_to_write_inline_data() to simplify its
implementation by directly invoking ext4_generic_write_inline_data().

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inline.c | 77 ++----------------------------------------------
 1 file changed, 3 insertions(+), 74 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 58d8fcfbecba..a651a033e518 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -757,81 +757,10 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 				  loff_t pos, unsigned len,
 				  struct folio **foliop)
 {
-	int ret;
-	handle_t *handle;
-	struct folio *folio;
-	struct ext4_iloc iloc;
-
 	if (pos + len > ext4_get_max_inline_size(inode))
-		goto convert;
-
-	ret = ext4_get_inode_loc(inode, &iloc);
-	if (ret)
-		return ret;
-
-	/*
-	 * The possible write could happen in the inode,
-	 * so try to reserve the space in inode first.
-	 */
-	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		handle = NULL;
-		goto out;
-	}
-
-	ret = ext4_prepare_inline_data(handle, inode, pos + len);
-	if (ret && ret != -ENOSPC)
-		goto out;
-
-	/* We don't have space in inline inode, so convert it to extent. */
-	if (ret == -ENOSPC) {
-		ext4_journal_stop(handle);
-		brelse(iloc.bh);
-		goto convert;
-	}
-
-	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
-					    EXT4_JTR_NONE);
-	if (ret)
-		goto out;
-
-	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
-					mapping_gfp_mask(mapping));
-	if (IS_ERR(folio)) {
-		ret = PTR_ERR(folio);
-		goto out;
-	}
-
-	*foliop = folio;
-	down_read(&EXT4_I(inode)->xattr_sem);
-	if (!ext4_has_inline_data(inode)) {
-		ret = 0;
-		folio_unlock(folio);
-		folio_put(folio);
-		goto out_up_read;
-	}
-
-	if (!folio_test_uptodate(folio)) {
-		ret = ext4_read_inline_folio(inode, folio);
-		if (ret < 0) {
-			folio_unlock(folio);
-			folio_put(folio);
-			goto out_up_read;
-		}
-	}
-
-	ret = 1;
-	handle = NULL;
-out_up_read:
-	up_read(&EXT4_I(inode)->xattr_sem);
-out:
-	if (handle && (ret != 1))
-		ext4_journal_stop(handle);
-	brelse(iloc.bh);
-	return ret;
-convert:
-	return ext4_convert_inline_data_to_extent(mapping, inode);
+		return ext4_convert_inline_data_to_extent(mapping, inode);
+	return ext4_generic_write_inline_data(mapping, inode, pos, len,
+					      foliop, NULL, false);
 }
 
 int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
-- 
2.39.5


