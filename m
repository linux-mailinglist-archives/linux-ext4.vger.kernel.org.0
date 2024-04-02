Return-Path: <linux-ext4+bounces-1821-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E968A8950F1
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56D728796E
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F316B626DF;
	Tue,  2 Apr 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="mMFzxVgl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD960DFB
	for <linux-ext4@vger.kernel.org>; Tue,  2 Apr 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055159; cv=none; b=XDeGBzj588VQ+AzytYMYtFup55OMdKfmtUN9HaIrR8ggD820JIn+EO+qqVkQtGRGbAeBJGWJ8JBczZHZvIn7Ro241J7/braIyZaZyvWniO6xUXjuv0tilLcGsG3Abt0KtZO+ou/ivHf6YY9UbwrfbIBbEDVvYQBTOnqjomfjCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055159; c=relaxed/simple;
	bh=FxRmJZ9KL9xpBpm4pOBuIBWeWydQ+wxCpl14xHng60Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XILOihbCJVz1CxQ8oDACI5k6Uoi6Xv9TsSE1VFcCLJS5OFP/oUVRRiGjOgMkLbXPeBu7fwUyt8oOoRs77kBtQyzerT3VJJUeeBbD2BZjFjEVZ8YbTGf7Huv8oWyFIH6TwCHOzYFmYUF7dxbejG7HG2ngHYcSJZqgpTTD98S/z1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=mMFzxVgl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44ad785a44so562013266b.3
        for <linux-ext4@vger.kernel.org>; Tue, 02 Apr 2024 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712055156; x=1712659956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTP+C6xMYT5Qm5c+52geS7X5NPkIi5DsshiYl5+1cnQ=;
        b=mMFzxVglnO1eGpcECFfrzGp0UvKcvtdECusQp0QDQ1n/FgfiGjSl4CSngVUEFKW2qD
         uoj0mJulw+/++cz2u0Dm+jR7S/mEIKkfqKpN0qskd02mTLGarFtdv44+w3qbXIady89W
         NGmUik6LdAVEEA04XnybbmSy3PrJjwIgk9fsPFM5mOQycaG5CQ/mV1js5TA3csNz5cdQ
         QcrtmZB4158iP76umfgb4JWn0TBaEzFN99/Uw0mE3Lt4jFIo8rFZQvX9d0GFYghNZabr
         WKID1aEl39obIzPKjGBG5al6H/cmEIUrVcL+8OwyskHaghxWIsxQK6MfAo3Wc9/0pOh0
         wrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055156; x=1712659956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTP+C6xMYT5Qm5c+52geS7X5NPkIi5DsshiYl5+1cnQ=;
        b=FzmfEKGlgclrM2eav/u7u5k9asF2JrDKnDCstZJ/lMpaf+/w04vfYR8/wbU5o+EXjA
         EDJXvNWvk2RsKcuPiUwcXoW4ztmdFB9U7vlQ9zcnN3Mx2vUwf1QHjaf1p2IBuD0cVr5C
         +W5yYdT0rZdVetEclJgM3NRtZvroviG194dEt7fA3Hv3X9tAGXegZgdHPfZZmO/vJ70p
         2s+C0hSxNVBwM89Z05vAt6sW8usbDqnYHXq90yCs/xTgcqguJcBj8vhcDUoEijN+M3RO
         eeOyK274+1aMhTeigkS7+oGjfiVrx98385Rqy7XLDBQBpi8Jvzx9/YISWqxfygPg1HTi
         sS7A==
X-Gm-Message-State: AOJu0Yz/GP3GZn/a3eUIMUbXIV29/CRxx+b3FqMMsALy4axCr+clwg7O
	tsbSAj2pjjeBzgKlKWcehClkvfEpiLsTo1l7XH9ekabvZxntYWg7yWHB4LcQu48=
X-Google-Smtp-Source: AGHT+IEPB4lf+7AgxzD2ZzI90EcqqarZcmw7DFa1Hl54/l1ZvwyGEvz/POzaHyV9FGreF9kuK/Z3OA==
X-Received: by 2002:a17:907:7e9a:b0:a47:4ae0:3bb9 with SMTP id qb26-20020a1709077e9a00b00a474ae03bb9mr9289912ejc.23.1712055156147;
        Tue, 02 Apr 2024 03:52:36 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id c3-20020a170906340300b00a4739efd7cesm6435520ejb.60.2024.04.02.03.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:52:35 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] jbd2: Use str_plural() to fix Coccinelle warning
Date: Tue,  2 Apr 2024 12:51:58 +0200
Message-ID: <20240402105157.254389-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(dropped)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/jbd2/recovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 1f7664984d6e..af930c3d0d97 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/crc32.h>
 #include <linux/blkdev.h>
+#include <linux/string_choices.h>
 #endif
 
 /*
@@ -374,7 +375,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 			be32_to_cpu(journal->j_superblock->s_sequence);
 		jbd2_debug(1,
 			  "JBD2: ignoring %d transaction%s from the journal.\n",
-			  dropped, (dropped == 1) ? "" : "s");
+			  dropped, str_plural(dropped));
 #endif
 		journal->j_transaction_sequence = ++info.end_transaction;
 		journal->j_head = info.head_block;
-- 
2.44.0


