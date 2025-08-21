Return-Path: <linux-ext4+bounces-9533-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54468B306AD
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20D8B00942
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A438FDE6;
	Thu, 21 Aug 2025 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="T4u0tbi4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F638FDE9
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807666; cv=none; b=uf8uegPjUNCOBsg4AredwbPdbWZqSMB4EM4aSNn9gIQqVX8ob8HZCr20cpDconiB0AZaZp7uoA1RXDWOdXUcc1Pa8vEaEy7i+Hb9lrgXiHthFDxQnn1xUxtdr0ALXnQrYvpregX0nl/EBleTfmhF8BLao9uMtAdcDhec3qecED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807666; c=relaxed/simple;
	bh=sLtWG4tBwYzFayC8el4qA8KAx3MpBYf6WBWbOygRAvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzggAl3mFI4R2etXGkhtz31s4LCcC5Bb+hL6oMoNE6Ca1vprrHjSI5NTF0z9TYQrXAKI0/WiXEpwjVHGyhj0B8dwbz3UGHpaUCYMk5cnVUJ1g4p8H3wi1Xr6Ig8paep9qdTYi7kbAilrqjh59eQfkNE2a+71Tm75W6a4tFT7/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=T4u0tbi4; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d60110772so13045157b3.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807664; x=1756412464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=T4u0tbi4Zb4tBUiLbA2xTner5l3xFJnADxs1QlZj+pO0Lvg+mgQ+z/ZqDKph84MOI2
         FgdvHdgatMts8XVlYQDeiGGmenaP35LFrf4LwnDO+bGSaebO/S+00/yLx2m26ml7RKJy
         zezEaoYtNkL+cCUmjfR84Yvh/o6p0vjPX1jCaakHZAPkRECg0Ytp+QWSu5pxTCsqGT/b
         9PIlNbd+K4oVbClwZAbLvsu791PeNO+JZRxSYdYfma5KtS0WuSAvQBsH+tGRgcwG5dj0
         woTsS5O8F6/ANmDqqQIpwNKolzADTvJMzuwPT4ngqPxUa+zpeD9qHRE7FrigtyiPGys7
         fCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807664; x=1756412464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=eGMLQNsE+DpnXEdQAhdpPG71ib2o/HAwVzzzlSsHMcbpkmevF1RW1JXcwBmGiU/hK3
         3WPBIuILSJetU9D5XOLT4Gl9/k/d27QZmDIDhUnlVkyRb3KvlxSQhYPRJL+fZcWxd7/d
         CABCyLz1lmk0cJEtQMq4w4BOaoqOaxFXZ8QHq+oq9RWDu7KGII74mYzpGKaWIoTnSlmU
         C6z1qcbGzgnVCvs9fqO6kLgHQHdeeqRSDLUKCN7yKExKdUWiAKSpyng15kNCZ8u7h5FM
         wG/92ZcIHQ1WLMYqak2eTqymih4v/1D9fS7jJNca8jqUm+FBfRSPyCYi6Re4vf2LGI4r
         r6YA==
X-Forwarded-Encrypted: i=1; AJvYcCXTepcakhkcAfwdR8yr3/NQagHCvxwkQkINpOhtw4zXL+G+I7j65mdhKyteJQWnTLAqp7x2A0rj04c1@vger.kernel.org
X-Gm-Message-State: AOJu0YyCw/pAluae3uywiksUn62Dr2mYGL9tS5S5JqdSJsuTSDpOIHdw
	ityZogPDd5UPzHy5IJQ3uZJNhxMtG6/y9YU2FpTtzIwSDgbR58ltBUSaoeDlrVOFWX8=
X-Gm-Gg: ASbGncsYKjCixVyLebVTAF1708uhSQu/4+V+QQ8Ol46UvSJ09z3Z6tTrIWj8qPgOmUC
	Rp/HxAgF1LvdogCm+7u7IM5xYsftZvlfcfqtrtOciz+njwWlHe/Pu1PkX9LQlyXhY2qs6CEVtpT
	Yoz1nEqFnCTpc+OicoUymVy3FLftwUhyuysvCvHKI15mZ3DZYTmeZINdPvuCDonaBGjHJlRDPT9
	xaSO98AjnsnbGxYijgI3/T+v9pajUI45H5rubZeZBxw1HKr/IiVcgP7V1lamvcjxxl3o4jgBEMx
	FafcFDAMxgrELv9KjcjvYjnIRc44QeFj7sVUK6xluHcXfptIvlH+g43hGbsKGD2FvyS3kD64TJw
	Xz8tD0sORJXpatShr+T7kDBm9wLipnHqir+whUH8i3F6qCtlMUwnDTfrl1js=
X-Google-Smtp-Source: AGHT+IFwsNnYsC18/NFJN5WgIoo/uwdywJ99qClr9yakhuxBJ4gcZI1q3LLBJjoDD8XpK/y4+KE4Iw==
X-Received: by 2002:a05:690c:6c0d:b0:71f:a20b:6d34 with SMTP id 00721157ae682-71fdc30ab77mr7353677b3.22.1755807664570;
        Thu, 21 Aug 2025 13:21:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0b039dsm46054927b3.59.2025.08.21.13.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 32/50] fs: use igrab in drop_pagecache_sb
Date: Thu, 21 Aug 2025 16:18:43 -0400
Message-ID: <4259ca48aec7355b3d3ab26d5d779973e5f2f721.1755806649.git.josef@toxicpanda.com>
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

Just use igrab to see if the inode is valid instead of checking
I_FREEING|I_WILL_FREE.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/drop_caches.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 019a8b4eaaf9..852ccf8e84cb 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -23,18 +23,15 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		/*
-		 * We must skip inodes in unusual state. We may also skip
-		 * inodes without pages but we deliberately won't in case
-		 * we need to reschedule to avoid softlockups.
-		 */
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    (mapping_empty(inode->i_mapping) && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-- 
2.49.0


