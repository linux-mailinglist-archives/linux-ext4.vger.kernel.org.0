Return-Path: <linux-ext4+bounces-9510-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87928B3064A
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39421D22F31
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A5A38B656;
	Thu, 21 Aug 2025 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PFgN+rvT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298C3705A0
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807631; cv=none; b=N13NIXAMPYPmb18lg0vd8MkTRqEFHWjn/oeQw788mqOLbw5vcMM2iflOARkZ2bUcvraXhSznZ+WkVtWdO0udCB5bFCNh0zEt9AZXqj/Gp3vjszwbjNTiBVP692uyCW6EsfKVVP6QiPnEpOWgRBzy50T8gNRqYfnC07bSAHqhviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807631; c=relaxed/simple;
	bh=mSQpopMs8dImzlrX65dFzEQHkhmtgotammgYg2xJShw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZprldVLMXAHLCL5OJ01Kp5B1BgUkny+SfcvJLu1w+Fos0bzS4qJbUwLaSpDb0efyCeDXlRxQfflVggXmAkwhjsDj3jcwdoGF40bKEAjCUPT6plAdCCEnpct1v16bC8pvy1OgZPD+jLYYi5VZiBnixJaMaDmdtuQouq2Cmrqna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PFgN+rvT; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d5fb5e34cso14480917b3.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807629; x=1756412429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mDquPBH/1dSQpXa532hRheL3YkOl1FWy6w71RzklVE=;
        b=PFgN+rvTFe6Jh697lf1YTLQHfjBouKpYVk5go+U5yPIR+7t8W/QQirX8BnnzjA/2Zt
         pGbo48pXs8xgFv+9nqMMvAgc7fagC0nm5kpfiFDxh2iyzjorNfO03gJ0MymoxwNo6QYZ
         wuO0kcqeePoAJWFDfn/WoFTCsgBliTkAI3l/7wSjB8/hFzEejaCxEFu92HtcP8aSsCkt
         fFTuULHPPIsgGlOA5KpRaaCi3ree7O+Az5uX1aToadK6O/gKSoZPu7U9gNJjpvqDRx4j
         wrshbWQFUNwI3CI80xtd/UF4eJXWKNPtBRCxg0N58mdztawSIzjMvKAt90cc8IGmBrfn
         lMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807629; x=1756412429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mDquPBH/1dSQpXa532hRheL3YkOl1FWy6w71RzklVE=;
        b=lpdf9RLmhv7VMDh2xKEe2idHLHUJsOcdyBQXh9e7X9MuzKbOjdW1ul4ovxqdnWJ5IF
         RgWtYQcOb8/yrKvL0wXGedyvWUz/kfif0vDn+87kMwUB9wnVZDLP0UPklaSqmOWhDKxa
         0ks0B+5a8n4LvwRoyWfQVBIjhoE7TNa5n2UfGTZh0Z3Bo7Ro0k05VNsGCw7Lgebx0m3F
         m1FMaTt9dVrw+FgkL713RAagY/gozn3+OmHByTeqlSIVOluDHhh4p1/5P0ZKNQUcEXRk
         OxYczSHDV0FgVsnV1iKhtv6/GkkMLMeOa91utM7K34NUr1fizShb7l95t1xW+SCAw2fv
         pDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqNs8RrIwP/fskUHo6Bwuj72YPL+PTwdVN/+282mUKmvAjiLaR8YW6HoWR9g+HLeKcx2PIB/04jdpF@vger.kernel.org
X-Gm-Message-State: AOJu0YwRl7Dx5p335ZnRZNcGoUcPULHzg21p2qKwTysDSn067/8Daa+V
	dABdcSUivytkSMSx1LOO3wnM7e+l5zNBsG359nHkVDpk1oUoLTmxZolX9LwSfiLjPasnQpuekXa
	3vaqzYf+4hw==
X-Gm-Gg: ASbGncuCa2M79yxZXiyNVXh9aE3bpgrLM+HmS4yEjLoH4BeS7SDehd2UxAa4E24kBaE
	FxjzxzzRE/QIdMqfmOPkYW0Y/CZzmzulhKF6GfDV2+fK8cnOBLEi0x5Kek3EpeRGLQlzK33wnfv
	w51VxhsEzbVmjKFOkqckUcObNFELfaLEUSlk4pj/ZXfTKILT29PJUrZVq8zeH9YafAMzCI2e16S
	E/GjImzvlMEnC6SiCjIYbz9VRP+d+9e9F1D3LW8w1mfMipOXmwPpG46vfHPKmYZvkk9d70YxgTB
	KhVG9mcoKdkPlnay1r8/qlM92gqFOYAuq6txvvDnma6q1gm0Fbx8wz/wnb5HMINcguVVSAAE09z
	MbbIBZokRo8kDiiaG6zEuhT+n8/KBSDyytgnH0RyV7UZcOqfNCggqQU5qwza3DayBb3B/ZQ==
X-Google-Smtp-Source: AGHT+IFlxiZ33ZFGeY0+eRtjwiN/2t7a7T8FkZf43ZiG6zuU4o9brNEc8ITMkGpER2WpFIGqL1aG9Q==
X-Received: by 2002:a05:690c:370a:b0:71f:9a36:d336 with SMTP id 00721157ae682-71fc9fb83c0mr40822927b3.25.1755807628850;
        Thu, 21 Aug 2025 13:20:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fa24e97bbsm19766127b3.68.2025.08.21.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 09/50] fs: hold an i_obj_count reference while on the sb inode list
Date: Thu, 21 Aug 2025 16:18:20 -0400
Message-ID: <000670325134458514c4600218ddce0243060378.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are holding this inode on a sb list, make sure we're holding an
i_obj_count reference while it exists on the list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 7e506050a0bc..12e2e01aae0c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -630,6 +630,7 @@ void inode_sb_list_add(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
+	iobj_get(inode);
 	spin_lock(&sb->s_inode_list_lock);
 	list_add(&inode->i_sb_list, &sb->s_inodes);
 	spin_unlock(&sb->s_inode_list_lock);
@@ -644,6 +645,7 @@ static inline void inode_sb_list_del(struct inode *inode)
 		spin_lock(&sb->s_inode_list_lock);
 		list_del_init(&inode->i_sb_list);
 		spin_unlock(&sb->s_inode_list_lock);
+		iobj_put(inode);
 	}
 }
 
-- 
2.49.0


