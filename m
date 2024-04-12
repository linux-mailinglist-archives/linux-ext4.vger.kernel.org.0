Return-Path: <linux-ext4+bounces-2071-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2B38A38AA
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Apr 2024 00:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2164285790
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Apr 2024 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA521494A1;
	Fri, 12 Apr 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vqbtfDFh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F50E1487CD
	for <linux-ext4@vger.kernel.org>; Fri, 12 Apr 2024 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712962261; cv=none; b=DCp+ZdBNYyA+kuZvRFdASkkFZGc3kUdFe+oz/7kEFE82xhhBBfLJT1QpbJKC8azObksqNsvW1+Lw6X42RAZk1/XTJN4RwJUrOelGe/WDaWBloicnJ1Jx1ba2SiK/4NhqQ/LWZ9Tu6e7qS2cNooBLn8rAYT1+Yjc9ZnXiAyXBRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712962261; c=relaxed/simple;
	bh=wzHFPfAyYIm56eipbp/ckevoI92cV1TIIuBMAdOOBEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzQfZ82Zkx47btO0EGrnoQlURs3V3x4uekA677VWzqxznWZMrW+jfgDLScoS8+pemNYe9cPEtokUPl1ykq+KV1AkxAPeYBNgaFH/noZlOs1kT8EZhPiPAkVbTtp4MdyRNppthA6tL65+ludhgUVb4ndDiRO8usbJsGMh4iVDpk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vqbtfDFh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so1378191a12.1
        for <linux-ext4@vger.kernel.org>; Fri, 12 Apr 2024 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712962258; x=1713567058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh6mJZXAndRjR9bEU8O8LAe21t8oF3so4wv78/G3xZM=;
        b=vqbtfDFhmOQJ0isjr3cSDEdD3x7dXXDB272jIxeGzr8vUz4nEWpYDFgU7jT7DJUXyS
         VbEnApPpe0Sw8qbTw4owFya6KzX+VI8LFlrKnPiI2bCaZRZ4gxmQk0wi0pWCbD3tkUlh
         QB3wYy+nrkAuz+iD23GCayvCYhNncZBZF+U3jiZ2ug07QBmCyAHAdKSsfyaAzoEIgyV6
         d+axuAoFsyvIq+bqNIVj14K9CoCT3V6zK8bXxO87x5fIHj0w8hoGb9zrhZaGL60GVgiq
         ommQQ1ynql2VCn81faYNBwNLcaO4YSBgCnYrLboVH1p3jeRKDbKcgcRwNhdpxY3OTxQe
         EUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712962258; x=1713567058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh6mJZXAndRjR9bEU8O8LAe21t8oF3so4wv78/G3xZM=;
        b=ngyJPjLNGeIs7BxO8fZ0/yLD8LwY6eKJSOg4BAUp2Df1e3ZQh0bDAmJxKx7VwrbPYz
         cScz4jLjsghjcr2dYmc5TB3uQtGC0IJRCG2IEv3EZW5BE83cVRbKX/X48sZ4BCSf9Lkg
         n6Nnamac5eKOVcyrftUzQqMAgmxQWHk6J5Ve1P3WRzV4ErwbjUsxeCMbvTUKJoauuF7u
         bQ83829xsrbxFZLGFoty89WFBYtY9OHeyTRjqIlB+hfcs7K8syjIufaF/PrrIi8GnzyM
         O7ao2FJNwBfUyjCuVM/omfuh8dnb0d58jCDJNrasoUqK3vOp3x9ThNDdthJKfnUl3GBb
         LAsg==
X-Forwarded-Encrypted: i=1; AJvYcCVX2hwI3iqI97i//G+lflacFoSRCcPKnMBm0hiXdxBzf2e8dCLV4gcU4VcDcX9xiicU0fVMfzeAjZmVlX1+FaArqM21FxRoWQ95ag==
X-Gm-Message-State: AOJu0Yw6qpWw2HPM0YdEDB2xdgTBCYrKqwDGb8nDeJEqn6LJ/aMg+aSY
	cm3EQnltBN6+y/5MkGqpyBrr2dfa1RSCS9nh6FDIOqlYXxSgc4yEWIKd7dZ/Dp57/4OZH4DfvKn
	rQkQ=
X-Google-Smtp-Source: AGHT+IFhEKXPD/C6gQXJekuRmCuYLbsgI+4dXDo7rs/HRaOvtR9yeQEfNKXhQUTWIQ/RBraxSKdOhQ==
X-Received: by 2002:a50:875d:0:b0:56e:2bfa:c7e0 with SMTP id 29-20020a50875d000000b0056e2bfac7e0mr2654142edv.13.1712962258444;
        Fri, 12 Apr 2024 15:50:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id h29-20020a0564020e9d00b0056fffcb76e1sm918637eda.75.2024.04.12.15.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 15:50:58 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ritesh.list@gmail.com,
	tytso@mit.edu
Subject: [RESEND PATCH] ext4: Remove unneeded if checks before kfree
Date: Sat, 13 Apr 2024 00:50:27 +0200
Message-ID: <20240412225026.207063-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317153638.2136-2-thorsten.blum@toblux.com>
References: <20240317153638.2136-2-thorsten.blum@toblux.com>
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


