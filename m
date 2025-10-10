Return-Path: <linux-ext4+bounces-10737-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE323BCC710
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 11:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97A6A4EFBFF
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BC42C0299;
	Fri, 10 Oct 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ea+bOKNg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E2220A5EA
	for <linux-ext4@vger.kernel.org>; Fri, 10 Oct 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089984; cv=none; b=hUg4v8eLEAcpu0l3oF5PoCoHJnW7d4dfGTNMuZNQVH2jOLBgMVQs/NsLNJUAF4NcEXCcX47RzU5iLaP7X9L+sIaq3ZnSWngT887IIFVGrK79+9F+H70gvEyyIv1QOJG06V7pK8cHh+oKb2E4UVjMWf7eq6T/flJIU5SeQmePnm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089984; c=relaxed/simple;
	bh=8BXppt1U4NxWfdmTe9Ool97G27PND00cmpzoCWr7mcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qzwTDL5+spezfOpktowkBHkWPE8VH3NyZjVXJTaC1gHI6avd6RE0ZPUzubOkiwwZcxZf3xGYlTb+s+2ybWcuc4jP+sLAgweGy38gf/lSAuyy64QphNtSHZ9Wri5FEKH8kJ7niNvYSbgz6FZJDzb3r+cG9UGntah+xt+HCslMAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ea+bOKNg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so1519845a12.0
        for <linux-ext4@vger.kernel.org>; Fri, 10 Oct 2025 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760089981; x=1760694781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRHyJDXOD3j1aH2KvtqZcQOhtcceIzAv+sdnNE0oQVA=;
        b=ea+bOKNgvJBuOLyJhFoUz70Q7RhCsw33ZR6/ZqD1pg2NGwgGPZHKJjbmQBmOYNIrEc
         mHPrg0Fbg3X6o3F7MVZ3tdSjORgBFHGGa07JF6Oj5/nQFwohQPhwiUt5JUmmPz4I8phQ
         SNisyEt+x8Xt/hiTCQ5NggPU9m3rUdG10zO9ppsKwrdOTDVtQMhXg8XLfKVOMGwp2Q+w
         9zDMgyBTiz4rrifNWD3XDAEZ5wGAoFE/lKd5HfUqLf0F0PJkk218ktfPHCMc+pxvCBhe
         PfJoA+vyonNZAYZsKdDQA20vHm2iyfnnRvCgiEwSx3+wc8Hr6R7NdFA9oQhGkHV/j1Ra
         7bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089981; x=1760694781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRHyJDXOD3j1aH2KvtqZcQOhtcceIzAv+sdnNE0oQVA=;
        b=Q0qBL/qolv3XBkK7Ne+JDFUu4+V9o/3jW/JQP2iMDCKopD1dJ4dT6DYtkRoLsXo8ft
         qGcM+6uPldWR4JlXfxY74OUgRPGzIuELaOLSwj3OoIlSBR5rvyUn/x0wWYYntbZ7its+
         SddC717LD4r5JuIH0huOiZGlOxrV5eWbN0aZHWqBWNGhbTGRUOO1eNmwLty0fgMKp2t5
         DIHtFgSlLlEN+kK7mrctqmbEGzEOQq97P9a4fnKpKbzCbYaOlHnvPf4ixoqpN5X1corg
         X2TsobPpjElkTxkQoQoCFHyhlOnxReQ20pjER8dfucjG+APq+MilfQOeT452Er3gpSGw
         kpOw==
X-Gm-Message-State: AOJu0YwaOFjIeBBpVcIfK3EJTK3kFnmAwrD+HQ7YS4pfBaNcvvNoJkpH
	OM6tsDsbhNWNTczV9FLkfyypK7XeVVgTaLohgjgzNmyhssm7YFuFjqmkEAtZbCZdvdpsxTgCg9G
	5xGCz/ds71g==
X-Gm-Gg: ASbGncvv/au7b0Otb15YFNu8hufMaT7v0z7iqYprq36+Wlf6ea8lycCwTO+iQvo3oAS
	pkciiQxzIOTNUxCqz0XFOmd7P236SlTRJ+adiUoaqVeD5SxmPx8p8UIvKKrGh+TStfefXLXw5QW
	4sVlclV7S9/IHPmr7Z7/ZOf515byiMhn/2jGltt7np/i8Qnd2qvyJ7NogByeZv1tJIozRvemWKB
	L4K4aFEllJ7cBMols8qd+pdnYrQtCs9ItcXb0SFV5b7fgxXr7DURZOn0XEkuTpSvIiJIVUG0At1
	UZkeXEiCR9kyLMiI1FiBdV3amEzZ4+cMF70ZvSqfCCQ4M8qiQfaEk0syRNDa/6JQErIyX+8UHbm
	nPd4tPYuRrbfjFDDK2Feb9/gXL/X4rddJpA8n/w4NOGPWg0AjEOiTM9FsM6rcaA==
X-Google-Smtp-Source: AGHT+IFhQus0IMdKIuHREnYY5GhZUGnUcjk+Kk7q21BYWUbv/wFkOFKm+FFnmogTJHEm5ndKmUdZGg==
X-Received: by 2002:a17:903:1aef:b0:250:1c22:e7b with SMTP id d9443c01a7336-290272e3a78mr144520735ad.43.1760089981239;
        Fri, 10 Oct 2025 02:53:01 -0700 (PDT)
Received: from localhost ([106.38.226.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c04sm52164555ad.110.2025.10.10.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:53:00 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	drosen@google.com
Subject: [PATCH] ext4: Make error code in __ext4fs_dirhash() consistent.
Date: Fri, 10 Oct 2025 17:52:57 +0800
Message-Id: <20251010095257.3008275-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently __ext4fs_dirhash() returns -1 (-EPERM) if fscrypt doesn't
have encryption key, which may confuse users. Make the error code here
consistent with existing error code.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/ext4/hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 33cd5b6b02d5..48483cd015d3 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -268,7 +268,7 @@ static int __ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 			combined_hash = fscrypt_fname_siphash(dir, &qname);
 		} else {
 			ext4_warning_inode(dir, "Siphash requires key");
-			return -1;
+			return -EINVAL;
 		}
 
 		hash = (__u32)(combined_hash >> 32);
-- 
2.39.5


