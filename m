Return-Path: <linux-ext4+bounces-9898-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C240B5184E
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACE01BC15AF
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 13:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542B7081A;
	Wed, 10 Sep 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWFfOiKo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A6A212578
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512321; cv=none; b=PsVyEGgKp7U9KZhkfuDboRSw8D5vy94T8oZabpE0py6vKCS6wtsuaSgOrGv9jn0bfbsiloR0iVsnrUET2+lG4E1/K8/l9/LNHQ7zFa13h+/Agm39LjWRVAeSVXR2QEII2bFruYKDtgnRb8/aH4xiKlvyLMD//TXxfPowxOPGMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512321; c=relaxed/simple;
	bh=rpp6Pi6eSLyGLozS+sufZuKxOGYgoS5xVLTuJZH0tlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7ZTBjFqtZqTyqOtuOD7/BaXL8vfjcYHXFHXgOQCQTtYY42G3Zmt0X8xryq4bns6uhRiIMUNb/4tfUcnzFUF9+y0NwecaqOxvQ4WUdEH9AfDoGiEUg+ipCEM8pLURwhPOQdG2z/4iTWKqgkNg0l/6YQX8mCIbKLgvvkasoiR8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWFfOiKo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8116af074e2so480138885a.0
        for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757512318; x=1758117118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVU63+hXhbJrDswoPjqPxuOvb7/xFFxzLaYpjhjSmcI=;
        b=mWFfOiKo+KeNxlwwfX3fsKBqGONObh5SSKGXt5SXY0iNcp9lVhLj23m7HJVZOYu6FN
         oD/Sv203Z90nDQGoEMn8PCHxFF/xdDmNu0uxwULWQNzmJeOkvboy70pVHpy9fvJFB6QZ
         tiQ8+LL+0miOpyVPBM+ZATYHfiHdPwy/4FfUlOxje30dYO3f4W85blf/Drmuc36lNNSI
         c43aUVtnKCFUp+evZMFrSpK+1d99DwIFguf2KT7KbTvzoMB4H9FCkGLy5XA0SrgkEC13
         OscCgyJy3zG8I11uxapu+U+99lqODjQlfXEGnt3vkJ0vloSSjuIq01nXEvIZBliaPPfe
         gMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512318; x=1758117118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVU63+hXhbJrDswoPjqPxuOvb7/xFFxzLaYpjhjSmcI=;
        b=OTm5urztVlN88UyFZthU1GTVAyf97c0GKFmEoP3PI5v8YCtVXnLji13nzDgT2miQn8
         TroNftXENahfges3ZCm9TfCUqCsB9r5MbrWNNZpVtdlc97BYm8rcuEkjyTXPyrg79CQz
         +7js3phafCJf+C5YKxwiMHBR6p7qkuukCJmn2iMcdmlK9PSFmn33I713K12o0tvfMNj9
         ibsrTymdHHw2+denoqtM/H0CH6HUMVfV/9cmzNdv+F2mMbYxwbFtRlbbnA9ar5haquPz
         Yguzx4P0ESuHsiMEYizExxJVnYahi0JXkgPyY7ODQ/uAuMvWG2AG2K5ev9K5rY0aO9Ot
         PRyQ==
X-Gm-Message-State: AOJu0YwavURIAGEhoDXMjHIdkWZZMxXAXpseuXMBoj/Dh5oPdb8aGlb1
	snZsTAmiR9Z2S/mYpuVk50vIbyUsDtzcJIA1ZxlW+bhU/suh4fuLrZV1bnCgzq6CnxY=
X-Gm-Gg: ASbGncuVAri54uG6T1sHBaoG3Rcndq9C83BegsFxSL1QVfathYiL75+SmQh12LWR8e6
	VByYdJ1Hz4tud2VrYT+pz58VdaWmWJusNfqffpPMNza9R0Ew2QY+L6lMtzz1+iHLX9HJ0KcB7uN
	lvuTvuHN8iJdEddz5Ikp3HtnNQtuW3GrwlQ7Ky0ejMNkjmGH7zMC0RxB2hgfBrmLgSD3nHOkuJM
	RVOCB+ZSdskMJViINH78W73OH5609xfgKytY3xd3EAxOSz4Xrw44Y/fkYnmw9A0EvQaxbxrwbS3
	eZpgDOQYipnXuy7IjCODEOTpsCaPF2UVaMwDt9XkNE9w600bv0GC/KbuwQgtiogIiX+g4LEv3/b
	vJDBUzJ+9Dol9waqLkWTEqTAqpqs1jUvrgSZLgH/zQAaJErDY
X-Google-Smtp-Source: AGHT+IF92sd4E1OzM6HE15Ryhw3dmijUzbtdGlKzHFRQQx/lNRVw5eltTFufdy8aboWAXTd3LXhApQ==
X-Received: by 2002:a05:620a:191a:b0:812:693c:bce4 with SMTP id af79cd13be357-813c596ff46mr1808290085a.39.1757512318540;
        Wed, 10 Sep 2025 06:51:58 -0700 (PDT)
Received: from maple.netwinder.org ([184.147.192.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7252d6ad05asm137500176d6.62.2025.09.10.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:51:58 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 10 Sep 2025 09:51:45 -0400
Subject: [PATCH v2 1/4] mke2fs: document the hash_seed option
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-mke2fs-small-fixes-v2-1-55c9842494e0@linaro.org>
References: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
In-Reply-To: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
To: linux-ext4@vger.kernel.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.15-dev-56183

For reproducible builds, it is necessary to control the random seed used
for hashing. Document the extended option for this feature.

Fixes: e1f71006 ("AOSP: mke2fs, libext2fs: make filesystem image reproducible")
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 misc/mke2fs.8.in | 4 ++++
 misc/mke2fs.c    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index 13ddef47..14bae326 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -320,6 +320,10 @@ In the default configuration, the
 .I strict
 flag is disabled.
 .TP
+.BI hash_seed= UUID
+Use the specified UUID as the seed for hashing, rather than generating a
+random seed each time. Intended for use with reproducible builds.
+.TP
 .B lazy_itable_init\fR[\fB= \fI<0 to disable, 1 to enable>\fR]
 If enabled and the uninit_bg feature is enabled, the inode table will
 not be fully initialized by
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 7f81a513..3a8ff5b1 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -1180,6 +1180,7 @@ static void parse_extended_opts(struct ext2_super_block *param,
 			"\trevision=<revision>\n"
 			"\tencoding=<encoding>\n"
 			"\tencoding_flags=<flags>\n"
+			"\thash_seed=<UUID for hash seed>\n"
 			"\tquotatype=<quota type(s) to be enabled>\n"
 			"\tassume_storage_prezeroed=<0 to disable, 1 to enable>\n\n"),
 			badopt ? badopt : "");

-- 
2.45.2.121.gc2b3f2b3cd


