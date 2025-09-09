Return-Path: <linux-ext4+bounces-9881-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A643B501B3
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 17:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4162D1C64955
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C667822154B;
	Tue,  9 Sep 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhanVBZe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9736124
	for <linux-ext4@vger.kernel.org>; Tue,  9 Sep 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432474; cv=none; b=B940OgM3brTdANytYiSJe6Ry3MMfE50NWCaZut4wjogxkIwkDLKEr3G+ZbFf/dlWSEed1kGGMxJyzv/1YELGBcxP/6sJDSohjf2ys/UWTyh6HwmNVyO7B5Cg+ydKnu1S+9KjdzF1njmtmP4exIhEBnZkkGCDCkXwXwPhkmf+dDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432474; c=relaxed/simple;
	bh=rpp6Pi6eSLyGLozS+sufZuKxOGYgoS5xVLTuJZH0tlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TVpX1sdWr2Uj+00ePE6PH+iG0dP6VSzhMjK+GVctkJQJHd+4MvQqfsbwMVcp0BK23n8yacgnL4DT99PM6OfkldFYQpQ2NdZqLtEnLgWFI3EYQOtz/rXfqKC1QSAQ6vEyzRKOpsj2RDEJ/o7vNKnZRRKfEI0pKjUsx/8IKXwJ3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qhanVBZe; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b38d4de6d9so30015421cf.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 Sep 2025 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757432472; x=1758037272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVU63+hXhbJrDswoPjqPxuOvb7/xFFxzLaYpjhjSmcI=;
        b=qhanVBZeBq2HVXHWAigapARD/IuGPCpMMY3FoVZ0IeCyAdN5MEMHMnjUIeILdR/JZ+
         Kyac6lq+8LoLAe0YH15xUMK39oGUHmsZSDvtO+BhTx6RQ7WDSOeZI9tSKZALpv6lZJMV
         CvI4CvzYOZ07O0EDFxuARQVJxhd6H2j3aXpCTfL1Ng9jEQsY7KnkizcIzdsKpdxd4D8l
         AJvUIAyOIkiZVhhhP/a84MX4J3INTebyEKHrV6VRpV2XWj+36czcMsWfvZvSz71m0RP8
         p3AaDQXBkecKtUt/VlCTZAtOEnDkZyecAv+ba5NPa4hXuL2z22T2NeGYbBOACel3sE7w
         9RdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432472; x=1758037272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVU63+hXhbJrDswoPjqPxuOvb7/xFFxzLaYpjhjSmcI=;
        b=Zc9wMjG2VqHC3qy+Ab4vFBaq2LfPTBjbHdhDJZdawZ9anfP8DYgKKHH9QK8+b+XtY9
         eExYEZOOMAgr61sjN80JyFUNKI/ltG5xoTrs6JsXsDOc/LM1e+ri23usqHBLmgOnizcI
         y103fj5U2+uRCvSSQ0Jt1UtdBOwf7cgPnkzNK5eA1UXsINAL0kPMU0F+7nc6NMWJg0Tk
         9AEDkVC3iQ/h/8gZ6RbH/ctgDt72Si4Q/8DHHbVd6yQDIKkwiyGWSEJRvsStzLsiMsJ6
         fswMGzsmGCmESySnuLeiLavComeSgncF6oW8OeFgKFZkeKGCJ2jbkiX1NLoGqAFq5a7Y
         51Dg==
X-Gm-Message-State: AOJu0Yyo48xTDhfh3Pj6YbeHXCKnBf/h4Q/3exnLO8yeDy7qfMlaxIb1
	gEUb8Kp6t8K1yP5K1ygBhpWMD1YhiRRi5Nf7H5S4WH31C/aFMu18c+A5BkgXoL2fPOBUZuilt0s
	oZyIC
X-Gm-Gg: ASbGncuZJQCxip0AzjWHpt4tO/NWCJdgEI8DC69fQdRiPVh/FkKf2cABnpXOG3PdC78
	w5bTCOTuAGBL/3tBi9SbqHtKDwxVr3cRv8+xMj3b5cyDv9NugB+035zvmUuiGaTAIL8f/fEJ75L
	mHAm/nh9+4p2yJ1mz7GyjlQlK6Ffjxv+Jm3YinMccly6AAvkevPKGmQBpI8Vd40zx2Nf9jSTKw2
	ly1/CSkyP7VYCa7e1GiPJzsMjrUZNQuCB8SV3jMhVjLbwGv7pJ8YlXW4ednMQ6sZRNQC9muKOkb
	SB/V0p9WKJxmUq5i5qf8BT4EQmxK54GjCCG2/QPVzAMOqIuka1wb++VzyI1e2cgXuHG1AqHMxWI
	I/yT2ziegPT/BGRe7Ba9CfTaEUGgXz3IwxGiLkg==
X-Google-Smtp-Source: AGHT+IFViFTnOjo8Q07LOfn/9iYezPdMx6Ay9NEbuJaUltI3KKPEtTeGehrvsgUTm+LlXj12WHkCeQ==
X-Received: by 2002:ac8:5e49:0:b0:4b5:1bee:4288 with SMTP id d75a77b69052e-4b5f8381efemr134706791cf.24.1757432471524;
        Tue, 09 Sep 2025 08:41:11 -0700 (PDT)
Received: from maple.netwinder.org ([184.147.192.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58c54d9asm138885185a.1.2025.09.09.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:41:10 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 09 Sep 2025 11:40:50 -0400
Subject: [PATCH RFC 1/3] mke2fs: document the hash_seed option
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mke2fs-small-fixes-v1-1-c6ba28528af2@linaro.org>
References: <20250909-mke2fs-small-fixes-v1-0-c6ba28528af2@linaro.org>
In-Reply-To: <20250909-mke2fs-small-fixes-v1-0-c6ba28528af2@linaro.org>
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


