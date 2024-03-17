Return-Path: <linux-ext4+bounces-1672-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 630EA87DE00
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Mar 2024 16:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB52D280CA9
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Mar 2024 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579CC1CA81;
	Sun, 17 Mar 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="wfcqJOhz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580681C6B5
	for <linux-ext4@vger.kernel.org>; Sun, 17 Mar 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710689852; cv=none; b=fm6OtGxd1irDZrBaW67U5XncMP2FYwEblN83yyMlC3RxbAp25i/IW+lxznkT+RzFPgUmE+lviN7E7qFln6/nY0VrUzBJhANMWnV3R2jBNFeBh1m4PJpgTZmsasHTmxCbP7BRGyzVu6cpWlcPDIUYXU1julvQxung3YWhU4qVI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710689852; c=relaxed/simple;
	bh=wzHFPfAyYIm56eipbp/ckevoI92cV1TIIuBMAdOOBEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCsKTBAtYajdjM5qzhVrUV0Te3gKhFaKaNs3P8BBw/ycSfSiHblg7vevdTbY69vSdPn14jd64swT96anKcsDHJ+8mZN5CnnDS9p+W64gr2GxzyeCi1TQa3gET9eTUxP7hoQv/4qTYMvOzjS/O9oDmgo/UQreMklgdvgSI7p5HFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=wfcqJOhz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4140c185a7dso3477245e9.1
        for <linux-ext4@vger.kernel.org>; Sun, 17 Mar 2024 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710689849; x=1711294649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh6mJZXAndRjR9bEU8O8LAe21t8oF3so4wv78/G3xZM=;
        b=wfcqJOhzw43I9q26sBk8UqiIy3NwTgErZkNQsswXDA2Elq75R+xhHP8vpShEcBGc5p
         o925uJ2jiA6cM0R8fVW3rS8MyKpOatLSbdmIIetCt6PprDw7P1xuDDDmdPUCLuMaVtNs
         qgai6i7jGYZgDciH2fRJmR8u371wE4H19fThpXGSn6lWDhMnIzwSdz/aEF5Gv6JI6pYT
         rcS28oGq4VYKZkY+rPQnHnKUVHnh/DpFfXOq/ZFLdbYZxAdj9Ym9igM6IQd0MQDFL/vG
         agR4TCoD3e67AddozohDFlyEUuIGSVyt5nCSAYEtKcP7YJWM14l4F5m2PCuw7zqEhlrw
         EzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710689849; x=1711294649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh6mJZXAndRjR9bEU8O8LAe21t8oF3so4wv78/G3xZM=;
        b=LlDUCf8YyHyVhqgem5WtuumbxSjGpU71blLVm/zGY/QeW89TaUf20F3vEvgeyjKwjd
         d7TLuV91TZ7H/tCVOUKxS8GQJpEre+BsE7GSDeg4w87urRwqdGyDVkQcgIcaUPmTBvoD
         g1vBjLh9Uma3EN9iaTFkvPcbaiVtiYekkeCiBs7giLO91VWQzaj+p/RfSaMbmvG/43kO
         ghDX9DmiXzqTn1nDCG18hyabLGkvtv6Dcxu3epfPwCa398tKPJtFVqSxb+ZyxUv9c4Hl
         HMTGwu3ITRFXEdOFeWSlhVrdIcPE63J/rt1QCkPVQEu217zU8V6LfPdh+lBZta1ENgLu
         ALsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMb6/vawOUc12QTqSXkZeRBhUFPELJSQpf09bKcvq5/heYwau77Kb88fJI068KU3Fy5qP/QKVEA6L6Bpaze7fkyZlxYYyZJtNK3A==
X-Gm-Message-State: AOJu0Yy6i6NnJTppLX09O2JJlwKT+uBzDBdnD4GNxAOX0vgfF8/8oUi6
	z8igLdiaM6WynQ1idljnBU7lDZnFl91NZOntTlouTslvjU/a6ROJTAm63Rjncc8=
X-Google-Smtp-Source: AGHT+IGtuRn18tXGMEylwW1EQ/gXzGfXayK2YMVEMOZjg00wy8f++b4khAqjOx7Hd8BFozmhJizQYg==
X-Received: by 2002:a05:600c:4f8a:b0:413:eb74:fe46 with SMTP id n10-20020a05600c4f8a00b00413eb74fe46mr7167867wmq.34.1710689848939;
        Sun, 17 Mar 2024 08:37:28 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b00413e6a1935dsm12100649wms.36.2024.03.17.08.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 08:37:28 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: ritesh.list@gmail.com
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thorsten.blum@toblux.com,
	tytso@mit.edu
Subject: [RESEND PATCH] ext4: Remove unneeded if checks before kfree
Date: Sun, 17 Mar 2024 16:36:39 +0100
Message-ID: <20240317153638.2136-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <878r2w4n0k.fsf@doe.com>
References: <878r2w4n0k.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfree already checks if its argument is NULL. This fixes two
Coccinelle/coccicheck warnings reported by ifnullfree.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0f931d0c227d..9b7a0b4f2d3d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2079,8 +2079,7 @@ static int unnote_qf_name(struct fs_context *fc, int qtype)
 {
 	struct ext4_fs_context *ctx = fc->fs_private;
 
-	if (ctx->s_qf_names[qtype])
-		kfree(ctx->s_qf_names[qtype]);
+	kfree(ctx->s_qf_names[qtype]);
 
 	ctx->s_qf_names[qtype] = NULL;
 	ctx->qname_spec |= 1 << qtype;
@@ -2485,8 +2484,7 @@ static int parse_options(struct fs_context *fc, char *options)
 			param.size = v_len;
 
 			ret = ext4_parse_param(fc, &param);
-			if (param.string)
-				kfree(param.string);
+			kfree(param.string);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.44.0


