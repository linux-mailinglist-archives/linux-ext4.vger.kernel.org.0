Return-Path: <linux-ext4+bounces-9511-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B84B30651
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5521D1C261EF
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18E334DCE6;
	Thu, 21 Aug 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HJIyusrn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE438B665
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807634; cv=none; b=Df9tJqDTAwuKrQX/4rU/4PTJva/xlEtJoV5Cle3N/tgDKNeBH6bL8dmIqMeWMg5Eh8QINI2LqDxhMK2eGuHBXlMuOLVUgokVZXIgCaxzeWYspidkuBeWjinZT2BgOZunKMqqjulrYLdpC1HTsczO8wjiAYQzYrtZI6yJuBeWd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807634; c=relaxed/simple;
	bh=ai2oUzPAcRJzj4bWGdjdsYHnumyQaMH/ub0qR04Gbgw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBupRIs65CYOweVBK3WUDun6/pvcN3J5+JrsiFM5Tbx67YpUBZAm/JxB39wiGmGZZMIXA+9ceof7HD6RfqIPGAiBkGK934nrnZ8tB4SoJJ7GI3WO/kerhEavtYzRD39e6fX9hepc+NVeyBKg3Bma2Bpm5qMM2ckd0xOEIKDMjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HJIyusrn; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e931cddb0e2so1153796276.3
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807630; x=1756412430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opvoMbW1BQLT38gew8BsXyJcIC3tejqT6ZRE2IoYWVw=;
        b=HJIyusrn5p0YqzySCgPuwSXTOrj7WUWgzNcKljJ2uIU1Qr6qdPlsRaXxP0hgg5d1fY
         2GeN+mvpFQiaS0E6lymLMIlFUTHaB+Mbk7WNMGMCOq5QKW1pxr3F9zb0r77rLPUfw2mh
         ZOZwSh3R6+VhSC1+PxMeHs+KRTjW3F7tJqUH7dZ6ehPRmvjtMej4e8eo3tPV1VjB4Smc
         T+ulJHIQlNFYGdNtM7VW/VM/nMAqJbp1vKYAYBfCRt4IIdlbvCX8aK0TMloY6rRtk0x4
         i/FVeln2imLP8DO36EUzBkLJK9I82l3G0SyhpNc5H15Pf8j3nV/2fEqVSA21ScSdJP5S
         p25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807630; x=1756412430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opvoMbW1BQLT38gew8BsXyJcIC3tejqT6ZRE2IoYWVw=;
        b=qhN3D1vDBxaMi/HOMY3ayjns0iXyvYuQOKwSwHhy5QdEKP6hPHsAtL4/bAA1cLbMLx
         KqmVQfqx2T30zskIIP1gKl74FjscZH2Mt2YQpd5bvhTwzm9/LJ/OKmHJP+/xyfCzns+Z
         8+B1BCGSlcThuz0c3pyQb+9Ppuvi47VKd3X6vLQAXluzcPUy/tijy2EsZxm0n0WMvg12
         It+W+EqHKkoOof/SkBUw4ww/MqLdhbL3y6fS2Euq0V6gLpzWVLl39ngHOiO4ORJD9zBq
         Pj6EiQTh18Ou+5gBA8DjITjAwVjli3Kgrq1euBAKP2a7ZZpIJQIAGGuRnAEZGUaheL/K
         h0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI5DaBzqmuTlq8fQstV0r2SdsAuKuPGLfU0kABkID6IvuN28mUFAe95DKmcstz9hW7Jx5q02Emc+y7@vger.kernel.org
X-Gm-Message-State: AOJu0YwKIs38vq36Eo+YNFWn6FJlOId5EUBA4R1HQGS80StJvXcnPHgB
	nzJUdaavoCHiQZkcOE+i9h6n9qz3hKh+WRwsSCwYUOrLvQxifsV3ZBTtW7vKpo98uOBvAGvgMXh
	I/tVfGBdD7IKG
X-Gm-Gg: ASbGncuLWFHzm0DE96HOOQCJBZyr9+27dYLmJrO5Lqcg6fru5X+YpB/3G9lgLRQEdpM
	obkERfP6ax85Euvysjse17bTlHoEB2o5RD7fvZaF341XHwrxrS8UW48G+6FmfEFU2W/0LkYGL44
	XGaEjALtMhIP29wux9xheWH/YdvrGiCs/Ek+yHckFHmCueHj2egFWA3uzXmiboUeWhnLmzzj6I3
	k/xYMXBxpS8f02Rf3Rt38qDCeLotLNN++mFcCejtDAYCDwr1qPtegBdlymNkPfYlSYEke6rrrIz
	tLSKd0FfK2w6GyQjAa3WuowKVcQ8cj0PPXVRJBGjA/ufYVk4lWxK6PgPqEzfsB0X5b+7n21tbm5
	RlnYfChOEc4eCRDSjlTqR17K5Ecw3ziMNb95n6Vkr/6NDIQ8dm/zK9mk1OpQ=
X-Google-Smtp-Source: AGHT+IHyIwzTgpEWg8XzW3K6HAoMrfMJMt75D5zXrJVqgdg8vv7vwKweBunmDYNPDq3GubatUhjj2Q==
X-Received: by 2002:a05:6902:6b07:b0:e93:3e42:63ca with SMTP id 3f1490d57ef6-e951c3c4751mr826219276.30.1755807630352;
        Thu, 21 Aug 2025 13:20:30 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e951c976124sm141967276.34.2025.08.21.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 10/50] fs: stop accessing ->i_count directly in f2fs and gfs2
Date: Thu, 21 Aug 2025 16:18:21 -0400
Message-ID: <b8e6eb8a3e690ce082828d3580415bf70dfa93aa.1755806649.git.josef@toxicpanda.com>
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

Instead of accessing ->i_count directly in these file systems, use the
appropriate __iget and iput helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/f2fs/super.c      | 4 ++--
 fs/gfs2/ops_fstype.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1db024b20e29..2045642cfe3b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1750,7 +1750,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
 			/* to avoid evict_inode call simultaneously */
-			atomic_inc(&inode->i_count);
+			__iget(inode);
 			spin_unlock(&inode->i_lock);
 
 			/* should remain fi->extent_tree for writepage */
@@ -1769,7 +1769,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			sb_end_intwrite(inode->i_sb);
 
 			spin_lock(&inode->i_lock);
-			atomic_dec(&inode->i_count);
+			iput(inode);
 		}
 		trace_f2fs_drop_inode(inode, 0);
 		return 0;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index efe99b732551..c770006f8889 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1754,7 +1754,7 @@ static void gfs2_evict_inodes(struct super_block *sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		atomic_inc(&inode->i_count);
+		__iget(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&sb->s_inode_list_lock);
 
-- 
2.49.0


