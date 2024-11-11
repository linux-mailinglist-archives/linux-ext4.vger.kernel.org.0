Return-Path: <linux-ext4+bounces-5049-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346F9C4A3C
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 00:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28F4B2D1DB
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 23:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFFF1CB313;
	Mon, 11 Nov 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OF0WUr0e"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601FC1C9DD5
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368936; cv=none; b=lFe95paOr8X0QPzoRceTEOxDewezQ9FQATDSaCHhAbY94dAv010mWJQJ1GR/LQ6y11bcU20SaviqZLoDfTeMcfOwRfZBz/Q466SHQx4yDB/Dmd1StjWy4s43mxDYUz4/uluZYJ6slYHVmf88tfYx6dqz2Vh0Ly9Z5GIHjH1FAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368936; c=relaxed/simple;
	bh=HNesIF4+NCKJRgMS8RJOzPdBmK2CQSC6p10zaqTN28c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1hJtKL6kXKyN+XN3MEAOO8ayPoobJa3Ouo9tf/8UYmAtnos9mbfaNHP3/VfU0UHsgcXgWEO7sOTEkGWWscPCgd39PwRK//k9WyusXTcJsSPM9lj058C1uXdiijaJ9Nyb8D4UNqFP0DzvmuUXQuyQI2l3aRHLf2MUNifEmOAd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OF0WUr0e; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720be27db27so4124104b3a.2
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 15:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368935; x=1731973735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=573A7VIJaN7Phef7EPro6/84rHuXaF2Ar2GUBUbETSc=;
        b=OF0WUr0e79AhMimpy85I61HjDhF5jReL4TeivNjN63K7r49rrhSv7C6PCMZY9s0O3m
         sLe8wGHHnzUhI7aCOzrlNV/u7656/fPSZM9IXjsZu386cjzZppTSuX3jZxFFhcNeBequ
         IOforrBU/9NM2a6r8qfZeumikX1uIs0sRNcxiBBcn5X8g6QJJlCMCMx+yr8oj9MBmg1s
         8JkNJHdepngU/Kl7g4gqt60K2PlqJua1d01OgSKE1APkdCy6rjaKAnM9PW60BL83fFS3
         7XD9h1iDmcXobE4n0Xy4+P85IofXytwjL5Vcg1VRFIwp2MQf0WjHLASbw50JezW06b2T
         BGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368935; x=1731973735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=573A7VIJaN7Phef7EPro6/84rHuXaF2Ar2GUBUbETSc=;
        b=bEM86swaSmBVOgfLbpalP+P2Lf+h3VA0DMlMZC1kpHbUO5tBiEtnhTo4EOnxZ2mzX7
         frPARVLy7R/Sr95uU0xzq9G+w2fTvtbYGNRZO8u0hfxZAFnzBvsSbsn8dxbIhJXbr7uP
         +2Vwr6BkFiTKpGwkJJ82OHYd0sVZrKSJoojIEn/1Mtky7v8/5XhdBw2LyVNYk8Fz+2d6
         YKMuZF+YHzM/VclDXzleaTqThC8apYKLEAv1VV1mK0vUOEs4DsUGOitGUQhgFzgxgxSr
         dkgIgjnRO/cUyzs1J8UoZikxygEN8CSp8l6USWPCzBSbz64QdQ5mmirKS4LMUBrRrRF/
         3IOg==
X-Forwarded-Encrypted: i=1; AJvYcCWnmoc8kf2gpW/mRstiv0EbbpW/G+vqpdXIe9KH0d2QshwVPFm3ejYvSZaO65sFpHjT4fFR/QqvQXil@vger.kernel.org
X-Gm-Message-State: AOJu0YzayGTZe/FlMCCGorAMVsm2pHN7plJS6CjVrb3kq+/rtVyrF3Oh
	jf8uNgyNbGQdnx1QEsp7PAZAd9px1jznkHgb27qIO4TtcyNUywNNqUXvaPcUVSo=
X-Google-Smtp-Source: AGHT+IFFv9yEg9ETjAil4BLRBKswDm5bw1d1rwvQrtFRdIgpywcgln1Dsm8EO2zN3a/ZuXT+tu0A8A==
X-Received: by 2002:a05:6a00:460e:b0:71e:75c0:2545 with SMTP id d2e1a72fcca58-7244a5d480fmr1035562b3a.25.1731368934821;
        Mon, 11 Nov 2024 15:48:54 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:48:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/16] mm/filemap: use page_cache_sync_ra() to kick off read-ahead
Date: Mon, 11 Nov 2024 16:37:32 -0700
Message-ID: <20241111234842.2024180-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than use the page_cache_sync_readahead() helper, define our own
ractl and use page_cache_sync_ra() directly. In preparation for needing
to modify ractl inside filemap_get_pages().

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 91974308e9bf..02d9cb585195 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2528,7 +2528,6 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
-	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct folio *folio;
@@ -2543,12 +2542,13 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 
 	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	if (!folio_batch_count(fbatch)) {
+		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
+
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
-		page_cache_sync_readahead(mapping, ra, filp, index,
-				last_index - index);
+		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
-- 
2.45.2


