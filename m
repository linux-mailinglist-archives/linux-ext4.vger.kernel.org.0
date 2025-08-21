Return-Path: <linux-ext4+bounces-9529-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80367B306B5
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8056622348
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D1A38F1BC;
	Thu, 21 Aug 2025 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="anu4mt8g"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A83728AB
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807661; cv=none; b=fo6m2xUBMQMGuFwry9m8FnUvAL5OJ7wNzOvL6i7SNG/8bheVF9AM3IXSsNUTEjXaNZBOB88zOIztR7qCy4Rj9gAsdJVOTXQrxrt5l00g7z+TDNN/oV8r8wq/9oX0NxxK0u9OsyzkETq7p6zWwy4aAx302CG9QdN5v1ZK0ys+JEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807661; c=relaxed/simple;
	bh=pZWAfjeKEyxWVI1i/b/M2R87xzgDWCxe1Yk13Yj6LPk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldzOXKSqkRyICg3ivh4+iS0zFklA1/1Jk/iGX9TpD3Un5UeHmvOI1idLUKKLeApLlV2U5mCjOO5SQKiQ+6tgkjlUxUJ+NRz3gQols3+qN2jXULL/syGA6aWCLaL/HQvKsMRIPM1bdgqUrRbi5pbVmXuOp+MFgf8S99x0xykwy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=anu4mt8g; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e951246fcb6so862162276.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807656; x=1756412456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8OxZ8arGUc2qFIUcpcCgS+zVxBChijINy+DyEvJNls=;
        b=anu4mt8g4EDrDHPwRfIeh+t/OfTiE6iTKHYbAl1ufsbOmDrHXxNeZyZPlUopTl18Jc
         zoT+amOB+TiovX4lcBQSI4NcmDavG+hMR9zDDcB03Zh9XMn/lOMM/BIVNiWiSSVBvaEo
         nV0kfxrI1DIrDqxfKqYFFkIc20yoHJBu4CrrCzS0lTH6+DrRCgGeBD8PQQ5hSfTVwebE
         SSjAiQzrYlN677ZgEF/F5YLofuJPhgl0P825tvVuKqNs9ay+prdXy2TmXKOnwG+Jrtgr
         hbVdnYjBgU7Nc1Oo8i0cmFmLk49/rV22w2s1UDJGagx5G9m0x9x5I32/sfvBmRqFvhKp
         r+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807656; x=1756412456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8OxZ8arGUc2qFIUcpcCgS+zVxBChijINy+DyEvJNls=;
        b=J8y9LhzVvDrhaixLxLKXgw/rYM0EkFUQRKXWAFXTeBFK671hEpC+RK6zbnptvclwAm
         Y+2t9cSXVneHCNRl5go4Bgg/8+rBOZkAfM0fGaQHzDUVGuALJqZgew/B5A3OyCTjWAfx
         yLO4tBYL9aAk0htQXEg7BFTmLhOs6W61BAYj8d/XsFvucc4Mv3ROjLGcW/9A4elk4ADJ
         UhPgham8PtW1Is7LR8bn3RFGwSZhnLPPH4pepp/GmncxkzusY/GUrV7gockdS08+o7/N
         XTpjHgXqmYOaVrlS3jRVwZRjNg8tEGjtkJdEe/yJJqxaCwxk/YBO/efpD5MLYd3ZFYTH
         hQZw==
X-Forwarded-Encrypted: i=1; AJvYcCVavq0gdk5a1m38e7lVqiGKG9tZnnP7RU1PI7EEhTfPOrRTcV9sAnqSUeEc3tW0jKK2wL9VxjBkthc3@vger.kernel.org
X-Gm-Message-State: AOJu0YwkwopmKUO8NmZkf5HLZI+7qaR0TnFF9Ybwwgow6PqLRoZp/yaU
	uwsczWp5Q+5R12DBH65KzpVgk1lopEWAs+RG7GpuDtWFMOfKUcB9VdRd7Dndok1Wp6A=
X-Gm-Gg: ASbGncv2qPWIgjgKuSWj+RKcFU53sq2euNMy+fTf1Pi86JZEjIh/GhhOd03OJybTKqa
	R7ctrxSlHbIiZdOicpdIRef33XSJL6gnefOKZxctm+KYj367/OtoMSNoaXJdVCDPiogI0AM6E5C
	Km98egPpTduLDAs4NmSxFHnOquBvo2Myqx94P7XEfCODKcqOQzHWaWVQo5RgMWFbJ8y0nXGr/Vx
	zY7GXlbF3tm1m12vy+Px1HpDcS4V0lIxWZ0qPeCGu9hLcmcCPj6pE8re5WnlNoatlWI7BUo8oBS
	yVucMtUSzQedLldOWQXSZxj1lq/57oEQT3CVG3U2vAnNiT1rcELOodu9ndLFlIBCD+KCFkYbNe2
	Dnk/fZ+O79mOt68SjukYqhRIxehBO6IioxXxADy6vzTjjz/BkXlOmN5TpiWcRgFxLHVqm09/Pw3
	xGPiyp
X-Google-Smtp-Source: AGHT+IHKdD7c0NoLaVeNfnIQ5Yw7Ue8ZdBZnrvI+mZUb/Urk+RN0cKprW6ynBsmjXYuBK0VVixEYQA==
X-Received: by 2002:a05:6902:102e:b0:e93:4952:e2bb with SMTP id 3f1490d57ef6-e951cdc81a7mr498133276.1.1755807656238;
        Thu, 21 Aug 2025 13:20:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94f1150b34sm2414635276.4.2025.08.21.13.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 27/50] fs: use inode_tryget in evict_inodes
Date: Thu, 21 Aug 2025 16:18:38 -0400
Message-ID: <7564463eb7f0cb60a84b99f732118774d2ddacaa.1755806649.git.josef@toxicpanda.com>
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

Instead of checking I_WILL_FREE|I_FREEING we can simply use
inode_tryget() to determine if we have a live inode that can be evicted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a14b3a54c4b5..4e1eeb0c3889 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -983,12 +983,16 @@ void evict_inodes(struct super_block *sb)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if (inode->i_state & I_NEW) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+
+		if (!inode_tryget(inode)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
 
-		__iget(inode);
 		inode_lru_list_del(inode);
 		list_add(&inode->i_lru, &dispose);
 		spin_unlock(&inode->i_lock);
-- 
2.49.0


