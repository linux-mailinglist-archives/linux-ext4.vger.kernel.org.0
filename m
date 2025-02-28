Return-Path: <linux-ext4+bounces-6623-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80744A49307
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2025 09:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5621B1888ADB
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2025 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711BC1DE4FE;
	Fri, 28 Feb 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS2gr5zc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA21CBA02
	for <linux-ext4@vger.kernel.org>; Fri, 28 Feb 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730294; cv=none; b=QGH3ymwLNhPh2/kYd8AqkWw1bkbotuW8jUnk4x/7kKqleUWeX16pEz3d3xmRnZpSZV80vx3/AJa971MSBcekwTmRF/bVlhT7gzk+Vd8gxHTN/22dwtgXGQN1PRoEtPdqy1YJ8MaNOl/aZDOoUKYfRUdNedq7H4gpq3OgaLrwt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730294; c=relaxed/simple;
	bh=vxDAeFZm3bbhGD+w27JImNKaJhIU+6pX1fEaS7UiIjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UGD8UEtCtO8Sab7xzNJYyqfrv4g31Cbk94mnn6K/IXIn2CA/e4/SOrZlaQbRC52wdUqN9n3+3Kzq/3fLHmGpXH05VKaCImX/ZJbGQ2DaRtI3ur4aOTpUXgu1tBFeTFaLdb++ZoM83qmpCHIiZCHxeHDtjzT0Om2AaT7UxGDh8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lS2gr5zc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223594b3c6dso28034355ad.2
        for <linux-ext4@vger.kernel.org>; Fri, 28 Feb 2025 00:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740730292; x=1741335092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ik/e7StD7/FUmv/Izat49d19IolagmNMTDrrmskS570=;
        b=lS2gr5zc+zpHTVI4gEsPaDBwOCosWFeCBXuogyDAdYy6OfHioAUXWSy0DkH13ZijiF
         ySJ52bPewtCZczZN/K4ML9i1RKPPxj3EAz6Tjxvs38NUR6DZGoy4IfsrQ5sKfU7nqfll
         JPqCbWesVzE8qxXJXQgZGwOI0HZ9UWaK8gjIJ8gLYOQAhsWcF51cfvFpWsi+SeM+ZrO2
         CG2irtxGHVA1J5g50ow9IwVYdI48r2jHbQONgii+N+Ch+d8b4yrwQYHwbZEYOMBjGNbi
         3bzRpbnNfk/JNu23qrlVAUiqFQ2Y5vFYtMe3ISGo2/I5aTpYwQFt7gYDLeuQxufRuqmE
         IMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730292; x=1741335092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ik/e7StD7/FUmv/Izat49d19IolagmNMTDrrmskS570=;
        b=fgxxNrVLeD/GY3U3NXx9PMbaVuSmBAAOWsbdCGfeIoj5Pq+sAgvoPXDVeevRgByU7S
         jS6q2OYjry0PcHRpLSKkE2gvHlzPtQWOxKUu719gjoOGQWVJ87Rd9dIugqpfcxyQ/OXd
         bbj/snDF6ViyzlbpRx5VL7NuO++nHiuNP1T8+Tc0aqhzKVPlsYkkMifnMhvYZYe6Ok+8
         mqMs8f5FML7C4MsDpoudK4eUges9qO6Z26WjMcZgSjMKuf0y+ilRBjiqsK9yV5V8er7h
         4tZijHfDSHZlBOnL8BuKRuR8bEFIppB8UP9E8h4lIqjIbSgKsRQ8wngqJbFRsdB1fyQG
         S1Dg==
X-Gm-Message-State: AOJu0Ywn+Cb+MXSfVInqJSXH1dTubQtkJJ25bVtBh91tcC3jTCsrUURx
	Xp257mRmhsRELcN+MYZaZoTf2bJbXhfeiqeLENzEhkk3uH0yNv2Mo4ShhA==
X-Gm-Gg: ASbGnctMs4VE95c4sUaTY2K5dYXZ8binsA20Yow2KLGsCTlsA7nVZ784sHyLDdH3hRo
	ky2Wi5+KDxIgofreq5ghmmQJP6QH71Z+PgO0QNutKZg4uFVBGrB9uFStiG8J5zvehvgQbfbqBOO
	BeciL+Xc2dZem0bRh50Kpl0Ui73XJ4R2hslNRpK/U5ZSu76eHMSug8eweIr4kHAVJGh/pWIvXQH
	7UKoqHwUf0e2mFRB3+ZE91a9j+u5Qb6QPCRmwnjYsH1oGPJChghAVjUKnrXr8i6w+pfDwMpcz4n
	J0ykJQhCOJboDvfNpQZ0TDY5re973w==
X-Google-Smtp-Source: AGHT+IF44EuXwLkOvaHfRq4NRxrniJPEybyAJWAWF6shJglC0IIFWp5VgUeXkhm+b5empCLo5l/BAg==
X-Received: by 2002:a17:902:f910:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-2236920c402mr27382445ad.39.1740730291324;
        Fri, 28 Feb 2025 00:11:31 -0800 (PST)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2761sm27987335ad.8.2025.02.28.00.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:11:30 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] ext4: remove unnecessary checks for __GFP_NOFAIL allocation.
Date: Fri, 28 Feb 2025 16:11:26 +0800
Message-Id: <20250228081126.2634480-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __GFP_NOFAIL flag ensures that allocation will not fail.
So remove the unnecessary checks.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/extents.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a07a98a4b97a..95debd5d6506 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2940,10 +2940,6 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	} else {
 		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
 			       GFP_NOFS | __GFP_NOFAIL);
-		if (path == NULL) {
-			ext4_journal_stop(handle);
-			return -ENOMEM;
-		}
 		path[0].p_maxdepth = path[0].p_depth = depth;
 		path[0].p_hdr = ext_inode_hdr(inode);
 		i = 0;
-- 
2.39.5


