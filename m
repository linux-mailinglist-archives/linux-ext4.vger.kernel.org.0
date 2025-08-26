Return-Path: <linux-ext4+bounces-9654-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 620E0B36E7F
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E464608C4
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92B43680BD;
	Tue, 26 Aug 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PAIBrMSp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263036809E
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222894; cv=none; b=OUtURJhGMD+Si8Wn6YBX5zuc3gVVrfeAhDOy+r3umWLhZ5yDHiz53m+Wpma53TodmBqTBRgFXDxJlI9rn9av3fmCVLEGab0cab0dViPENXwWeiFARgaBAdD2a5S2x6IEQxbQ0Q0jToZ9P4sKnOeQ1kanz8FF1UgAb55z+v7eBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222894; c=relaxed/simple;
	bh=KH914xoQJXrO8N3ZjmL923rQ+0fw5BtVRwkJcmLo93g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SA7NeOp1uGCb0/7yoihK6C5uJJJhEwmH0ADWXS0OKsa+JxF8iMNoDoq4W9KzS/4evHTRIVdRqUK+b1GPZATCsynrBHd+4yzftv4JIcnU5UkZCENLBJCzs4RZixAPTHN0u8gc4r4KR8k+T0QLNRB53L0YRKAE4xvkymCXGU3/Y8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PAIBrMSp; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-72019872530so23005107b3.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222891; x=1756827691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5KAKsh2PfGXT4+TYPG/ltaJ7kkJlF6llKvHHQC7hMo=;
        b=PAIBrMSpjeDzuYzNJC62+RMhL/Fl6xdLmvBwZflI1a2/qZ0H7VxahgeFe2J2cCNZRY
         B7WCA2M7b7ZxDaLu8Pv1/LjFNsZODqQwetoe6/v53qB85BF4QxQRvZt+epApAW5nmbox
         5K4Z5S9FFpR5PrM1gDfEFGHtONcq8m5NWSsyG+D3GR2Xr6y9n/29LBjdYnoYNqyDtZ6a
         aqoCK/SRshuysx1TLXRFN6UKV6pcIFgfMJamxsm/QRbcCddYijlsCeSpK+3iW5MlUTpL
         QIbe3e8BkATd0PTHj2lgJVw7U8vA7LWjvbcnN36GpewVJX01gNebt/D18gy6m+PdtcNT
         zUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222891; x=1756827691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5KAKsh2PfGXT4+TYPG/ltaJ7kkJlF6llKvHHQC7hMo=;
        b=okA/+TnH/lDHdLpO+H581/TX+5tSWcj36unoa8LUmYw/cuJj0krPlJEOmOtBjy2D4R
         uMsPqed0ELQ/X6fhMoAb83jZ2beWyXgJAy4Znd/C9kBcEyxZNzcTv+Rv5IttjyOQ3bQB
         jqwYQVT0fnH/2FDooXByznEyOmnS8hZ8ri5CWRpVpmLSzA9X5JySSInN/i53juDG+sbx
         lY1fmxV/sfg5gXQ6/fSOvCrmGvRVF+zW5l5KIwyZpZHpPsCVC3/kcdXUrFDmJk+sjZq8
         A/mgJxcl0NhLBI1E9tNw9DdpTA9R+ICqEazdYoRZ0QbmJrCHyoPQqxSGlr4f5MR1iiun
         Yc1g==
X-Forwarded-Encrypted: i=1; AJvYcCV5MeJDpHGkmSVbeAX3dw+uVm/kn0rxQx9MR3+VcyS9ixwb1afm8EBzPznbTtNriT3RVZOyNyESRl73@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhLOsdG0o/eQO/gB6Y5PYpnZERLgUH8G2djA62rUjbJ1Ug71F
	aGg2Au2zKSsexfLwIFw5GBzLFm5QfZikAGE7pssesgURvKLTL8PUflMwkpYLzWUcKlA=
X-Gm-Gg: ASbGncuGo3LAHCexHTTMKj6cl7wBziHcYDe4mxuegMH2zFUaKahLvtDAj8sKvpYNXsf
	ldnC+f/BNAwGsROxoyHTpQvmfTX5pfYPRnN/4L88f03lpxK8i/48A9ZgAup0tpreeEDyyw1ZwIT
	gMw3CZj5z2sIlPr8dvhDk+lKzJPWs1B8uhfTwaHD1etNyxw3nUtxH10lS8czCBTwJ8AU1iCc3x6
	Eoq7MdtVWPFluw0cGzPpgck7pD6Z3OmXo3OOldrQZKS2W+GAIg2nN3Bq7giyQBWfhEB7E25FwIk
	6k7r3V014XPbqvWM3hnF/AuUfrbkrb2cdj/8a2yXf7EcpMpohbfOfF2X+r+1VFh5QIX/BB/j2XX
	iA3ehD01LS1LKQFPlFHafRSQBDvTn4PZ8lMEkXw+/cQ7r3omNPAEORW3Lx5yfdfCyEf+8/Q==
X-Google-Smtp-Source: AGHT+IFKqwEmHNx5eQFlQTUVO696PTRIuWbfxVqgnshRh3PzZ7/9O1IwzGnfu42E66nP2s6IML84qQ==
X-Received: by 2002:a05:690c:620d:b0:721:369e:44e4 with SMTP id 00721157ae682-721369e668dmr18015457b3.45.1756222890893;
        Tue, 26 Aug 2025 08:41:30 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ffce104d1sm21641597b3.28.2025.08.26.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:30 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 29/54] fs: use inode_tryget in evict_inodes
Date: Tue, 26 Aug 2025 11:39:29 -0400
Message-ID: <a9182c9716b474752c0110af726b95125a7007db.1756222465.git.josef@toxicpanda.com>
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

Instead of checking I_WILL_FREE|I_FREEING we can simply use
inode_tryget() to determine if we have a live inode that can be evicted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 2ceceb30be4d..eb74f7b5e967 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -967,12 +967,16 @@ void evict_inodes(struct super_block *sb)
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


