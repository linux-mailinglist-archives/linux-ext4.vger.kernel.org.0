Return-Path: <linux-ext4+bounces-9652-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D52B36E6A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A64A1B69734
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4A735FC15;
	Tue, 26 Aug 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zEftBxnH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891B3629A3
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222891; cv=none; b=uGqvYbk+vOe+EpvT1l3XOajcwgdWgNMjXvLrz20/ndR3Jk3Nz+YLcOUyJBPlPSgheBwX3edUEvaf9CU+ryByA/UDYWgDnQYv2RVdtjSD2brGjXQBEa+7fGvc3R2p6oRSZN3khnBOxnRhuN8Dfb3OGEdKB8qLvV9eoIpuULdQylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222891; c=relaxed/simple;
	bh=7Rb0WDz6RNiTOxNcfVfw/tSky4eT2lKquvzMe9BAl6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGMS1z/+seha8cD9rXKV4jVdHSWbF/AtHwHqja1elcWtz7qlvM2d4OBxaOmv95lgVmCYLOHqUdk1HoLbVYX6rwhsAsoy/FG9VC/Tv3fFeMLe/wZ/vwvhczM05/00Lgg59TkbTiSzNxd97eSDpcfhcPZSndBS1/jORoMe8ztUZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zEftBxnH; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e96eb999262so150864276.2
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222888; x=1756827688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pKHzHpITaAc/mjXTKQS2R/PEauqoOSV7l2KfBiByOc=;
        b=zEftBxnHOYqdJPVmTEXMYULPzm+1QQ1YN0kFgb3VDGK+z9TCCHC2njCjZoYJmPf0zI
         xZos5vZFx0pUPPuPWAFDp8hzx7eQDWWtj8TzNrfWp2vOukmRps/7etBdjP/fXKxYMG7y
         ZW9tl4+OOns9pZy6c3vgi8vCR7raxs+g5vXa3Xa7+8EyaOk7P8OASzrl7AkNWnzEs3ys
         /zdBiA0XBuwDWjDrKj/pP3n483Nnw9AzFAGis9z/mEVVv+XwXjfuVHlO7y6ZlN1aqCpk
         Iv9iz8/b36g46zQVGbEGYmombxLPIJZ0EDlY6DVBcyVnbJrNOH7Ghe63wJ6bPF3Dzqzk
         hOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222888; x=1756827688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pKHzHpITaAc/mjXTKQS2R/PEauqoOSV7l2KfBiByOc=;
        b=uylSoHiZVKpuiiEUHvjacyuUBcZ8a0F28wUUQ/8ub6SetL3qoX3075VTmYLlfadq/I
         y7aUzZJQhM06lA74IN3NkDTpeY0wxgCx65VUqVPKJvZ0+acuopqVkJQ+0j7IVFvzACNR
         TTp846uBeULU8qe1i5gV/RZLwACYNDowohN/gNA/jRbkAPs7WinBM+kmlNM7F+cIeh00
         HFLP8C1Clb1TfeeN9TynEBa8ulhxMIC+rLC5de3Zr6G4qJXgWCZDfhxzYdHtWoSXyiLI
         BpHLc7g5RY+MiyteCkZQlb1q63tabhcmTqGVb/hgK8P5ny3+le2TIFC/lZLXiAuKBGbR
         Q5TA==
X-Forwarded-Encrypted: i=1; AJvYcCXUO8B8izEpW06uwuHUOWpoe8LXBb+7UgynWRsnNUFrERNn3WWYak1uWhquzrUqCWttaQ39TMV/pfh9@vger.kernel.org
X-Gm-Message-State: AOJu0YyyMIHgh0O987eLCSv8wvJZtCHSxl3UqpKeooURdT+qtEH9545/
	saqYlfqzN7QqN/NvPNP7OzzDa/nWrqqZWUxZQNJIOYxU25258E7yKCTo/ywrpIQG8YU=
X-Gm-Gg: ASbGncuSb6xCFbfWATGW95h16Oxn2saLAH0ImcdAQuaL5F7kEm4r84zFdEm+grDhhHd
	xPu0gAIDnp2mzkCZCyAme3MaR8XHfzYXH6fIsN/DiJe34Ysl9GENvP/hMEx3Y+IOfqOCn6wJRVW
	SfrC9hJ9fVU4gY/OeCfVHGTWuW+z+5BNa/EQBCecgJJwmjOeFL8J4aVQhd3IJtx0ruK5yibaxZU
	C7gmBNQ59dJnWtK3t46vKAanBT3c6QTJO47JA2HnIQx3sIAxaPP65v8yASRyWuxu7oOY/gKzgxa
	H9pmU7BuOg73cV56Zl2BNnN4QPQlHTpf6ZQQvTQXBb+nqZ04o7Gm8KTW2m11/I5/ZwLmAO8rBrA
	JFhR3S7aeILopuWSuENLWjzpM25KmplrflYAjz0j3DOJj26l/Bn25cq92iGtJqkJgvO8bXg==
X-Google-Smtp-Source: AGHT+IHpeaJ39DrKl0SHq4TeALy48X7MoeQZe8JyD4wQTO8EFKaesDAqzHePbJNfnv8wB7k8ckcMHg==
X-Received: by 2002:a05:6902:3483:b0:e95:3b7b:6e4e with SMTP id 3f1490d57ef6-e953b7b72d3mr8336972276.53.1756222887983;
        Tue, 26 Aug 2025 08:41:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96ea63fab0sm169958276.8.2025.08.26.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 27/54] fs: remove I_WILL_FREE|I_FREEING check from __inode_add_lru
Date: Tue, 26 Aug 2025 11:39:27 -0400
Message-ID: <5b72bc52855034d68887e466dbf790d6c2a1a9eb.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only want to add to the LRU if the current caller is potentially the
last one dropping a reference, so if our refcount is 0 we're being
deleted, and if the refcount is > 1 then there is another ref holder and
they can add the inode to the LRU list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d34da95a3295..082addba546c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -597,8 +597,6 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	lockdep_assert_held(&inode->i_lock);
 
-	if (inode->i_state & (I_FREEING | I_WILL_FREE))
-		return;
 	if (icount_read(inode) != 1)
 		return;
 	if (inode->__i_nlink == 0)
-- 
2.49.0


