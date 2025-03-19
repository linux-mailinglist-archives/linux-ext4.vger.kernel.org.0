Return-Path: <linux-ext4+bounces-6924-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1138EA69609
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Mar 2025 18:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439DC465A4A
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Mar 2025 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBC81E3DCD;
	Wed, 19 Mar 2025 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnN5FcZ/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392D8257D
	for <linux-ext4@vger.kernel.org>; Wed, 19 Mar 2025 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404219; cv=none; b=ZVqfD8eSqMAGRz5lLQJsMpFZ98RQO4n6hgIMDkiGSWW6NQeb4KqJ0aFnv76QrbTaQePvTFXiXwM++3NbeGkl+NqwXYS65oSCO4dkqUMXStIgQBOo0wtfF4T2ZUgF/6CK+KAQe1moFki/NPiK3DvfX6M4+iq+WBKGc25H820CyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404219; c=relaxed/simple;
	bh=4HyK30fXj8jmmWqbOQWkXLt3uhY5uVrPZrm/l/RsMg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MtGsZlqEF9X7LVPJsaZyVojkdVtrylUb56CaaycXc/aNrXWxvtqRWiBAEJOvusabcDo41TNRDL0aOwph/n8sAx4hZ51uBredejjIGA7Wx708kSRXlc9Vk4QZeZGhCdZx2W/6O4R2SRYbpTJY6A34MvQEddEY+QKSSxcaJPjmCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnN5FcZ/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22398e09e39so160250985ad.3
        for <linux-ext4@vger.kernel.org>; Wed, 19 Mar 2025 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742404216; x=1743009016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wAMDty2lGXMF6kT5UaoWL6sYMpJK5FPZx76CJefODNQ=;
        b=MnN5FcZ/5QwvOTos/qg1Ps2oJjQEaO9Ad0Gz/u0C/C+PSr0oyfUCKYzfxEDPXvOuz8
         yNfbREFEfrLza3RolquLRteFqSTf4ieZTgtr7bYpkSPVApqtwfo8Q4AFosgGpBW+mhyE
         CT9cVE76lSa5lK0gWGfgXTSpnlnylBFj9cIkvs8YOn7NriDxgEBV1JXtU0EPU/VgCiRa
         8HNSTrIWLWEuuZX5Hcwdl30E5Z8TGtlB1Nea4vtk9Lav912+EYheKjhEBSp3kNHvJPz5
         UaaPOCYYAkwwOj7Re/tH7gzVMs0tvCQ6IDjUFYiPzwc1YFP7mpNWW65OKq2sd90NTo7o
         /43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404216; x=1743009016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAMDty2lGXMF6kT5UaoWL6sYMpJK5FPZx76CJefODNQ=;
        b=j4TTAJnD2NdCpp15WBP7afchjkQgTDJYIo2ZGXbNLwYE3dKN0NhTcmbPJgrGBUaLWG
         57BN3w0B1QMqI4KbPhKtZDchPESeC689OQFsVi/wMcaNdvC85szj9A5mkYzbja/qvHBp
         fJG+oSO8V4tPvYCEwUwKtRgTPlo0y9+eSaunocI7Q1r6ypbehigUU6n2LWwm3L6LgGvR
         6Vl49pgB7IgCWmLnpOao11Su762hdIdyDnnzVrXH5ZJabWvhwKRgTMXNiC3N/t/ptzfN
         pP1Pp03DxYAcW1xPRvLkTB15CTl2g+MV70hT1H2I1kBuF91qdgplh7NBf4nSOa9cIPJC
         h85w==
X-Gm-Message-State: AOJu0YzrYJkJwbQ6RB8EQq9WwNdKX2GFgrYAgtAxRe8+kemVpsMaXNMG
	DapSwJJ1xL1i5TCTaMdm8yqDirHpLod5/fF13LT/SmcgsGX0+bhy
X-Gm-Gg: ASbGnctbc2wm/nczhWK4nF2A5ttvpafTtpeXDxgn9AZpLhYW7aw2CZZo0IWUOUhqXd0
	hB/440YiX8+nOY8PstW9LuTL/y2EWx99Qs/fjufTTqQUuWBcLo9be/leiuLRMcmZiPc3Lw3SgEj
	um0hLGdlm/0png1FiVTzv40pTZ+g4gC9zsZhIbuEz0Tc8inNb7hLfa1inSOnPGrvClvUwpQgskX
	8DKDSEQ5rABCZoCXVe9cjA7pGUcZsxh4qFsYxRyr/nRNvmbh57iLI2ivDNUfFu8ZkjHDLvuV5H0
	qeASDcLtEmFktlCWYBUcy1aM6SeXxZp8ndjNb9DHvF0N9bMJNvuShisIH3PQ6WknMvM4Tyg7E4c
	Flg==
X-Google-Smtp-Source: AGHT+IEn4YL33aFmpufF1RNQqdbHuc8K6J7qxlASh0NuyBlHhc8QsognW/uTbKK8S+xYegZ5H9v0lA==
X-Received: by 2002:a05:6a00:8d5:b0:736:4d44:8b77 with SMTP id d2e1a72fcca58-7377a83e9bemr58471b3a.8.1742404215986;
        Wed, 19 Mar 2025 10:10:15 -0700 (PDT)
Received: from debianLT.lan (67-61-129-104.cpe.sparklight.net. [67.61.129.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b10edsm12264270b3a.171.2025.03.19.10.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:10:15 -0700 (PDT)
From: Nicolas Bretz <bretznic@gmail.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Nicolas Bretz <bretznic@gmail.com>
Subject: [RESEND PATCH] ext4: log rorw on remount only when state changes
Date: Wed, 19 Mar 2025 11:10:11 -0600
Message-Id: <20250319171011.8372-1-bretznic@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

it logs ro/rw on remount only when state changes
removes "Quota mode" as it is obsolete

Implemented the suggested solutions in:
https://bugzilla.kernel.org/show_bug.cgi?id=219132

Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
---
 fs/ext4/super.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a09f4621b10d..0067184aa599 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6760,6 +6760,7 @@ static int ext4_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	int ret;
+	bool old_ro = sb_rdonly(sb);
 
 	fc->s_fs_info = EXT4_SB(sb);
 
@@ -6771,9 +6772,9 @@ static int ext4_reconfigure(struct fs_context *fc)
 	if (ret < 0)
 		return ret;
 
-	ext4_msg(sb, KERN_INFO, "re-mounted %pU %s. Quota mode: %s.",
-		 &sb->s_uuid, sb_rdonly(sb) ? "ro" : "r/w",
-		 ext4_quota_mode(sb));
+	ext4_msg(sb, KERN_INFO, "re-mounted %pU%s.",
+		 &sb->s_uuid,
+		 (old_ro != sb_rdonly(sb)) ? (sb_rdonly(sb) ? " ro" : " r/w") : "");
 
 	return 0;
 }
-- 
2.39.5


