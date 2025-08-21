Return-Path: <linux-ext4+bounces-9523-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F5EB30682
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411F3624847
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F90138D7F1;
	Thu, 21 Aug 2025 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iEQUrkg9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484538CFB7
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807652; cv=none; b=cQWBVHoMc0WjT29FqNFWvKgZvF1Q+4DzBUTJpY0EkzhnhHW0yZ9DJWuMLNz12z9IJcbHtgnRBsfiOdK5RkYzRSX/GgFhWfap0BWKx5dqoZw3ZkaSta1Er0fbp4QP1FpH2NChIAv8+zVdmQ8NEzA8po8BOKXiVJlj6J5g9kaIJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807652; c=relaxed/simple;
	bh=QDCTsMl47vNCm4pEABV38JgQSqrXPVXZ8WOdWXUjr7E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ge46NIV7DymCK1q0SygVshlfUrjo8oDqnCDa8gqdFXnPFwrtFJ5Z1obcPX2E0P0qZf7o2NJgvOpmgrpQt3SFoFu1Fjlmfl06iSxLl9+CsiFbo1AVciYAHriivPz9QqFxq1Kxt0BQUTeLPUwqij7VvYqZIVTFQTSUxG1bvvU/34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=iEQUrkg9; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d60157747so12169787b3.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807648; x=1756412448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPlcwVE6H0J7lPhjU7xhzvHl7lwTdtHL6DFVeSS7hKM=;
        b=iEQUrkg9gVl84ttehK6DWSMBd/CBNBiNqxHvlznvZ0tDZndP/QMkXPSXXrKEXe+4t4
         zqmvP022CCqJtShbRkl1f4/M9Jk/08sZ6RYtteC1tJFQrrFiBx1rsRcgiTozBLnYo6/U
         kkuXVQUO8s+YInEbMIqenJnPVcbIIILfFO2M61+lKZFi/7OnZ20nXSiuoQQMgPYdE9JT
         xoQvFxfUIvzx64OMWkRGIr1DSQO1BBeiQNYEgkqsbgCeP/bKsTMMEP0bXDMbTBQ/gT7a
         RSiKkEv3WreR1q0OjO6IxpuTfUynCJFSWK+Wx+o6gbyQBX10pFoemCVhp+fVzIVLYjMo
         i2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807648; x=1756412448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPlcwVE6H0J7lPhjU7xhzvHl7lwTdtHL6DFVeSS7hKM=;
        b=gOIXuO1kboYbUsHuZ8GnvWlUUfFu8kvLUP8KhBuy2a1QFGUEzc+CakPIw9ModsTyMJ
         x0VNiHAseZ8Vt+BgxomWFKyr3jzy+WGepp/Qv8+RiG8nmFXmvEkQii4NR6mL/zT6WhZ5
         5kU7CzWABnAXsiSX+KCb44KgfanrkyVo1nS5msQO5G0D7SDlW4OTMY8BYigF0CUjQsIQ
         a5sOb126+RQfbZNSSZi1LnI/LPTu7FGFCpdB0W1jxtHrBYMlyPdwLZvcKyVVd8QjK1b/
         pxtYdYlMckw2a50xnMvttMctyFksyUkkxW8qL2OEWU894QZtpZ2qnK3syFKiYsEBbDss
         3Qvg==
X-Forwarded-Encrypted: i=1; AJvYcCWUVsJYjPlOgnx5cU+/CYlPHZVzF4M1NWwioqNhWXS4U3G02hVrVGPfoJrROSlgJBKMJSK1VsvrKEVN@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhKXX6GuI+R60UVYuGPFN+gG02YK4umq9N59SBfjkCs0Beqz0
	oo6rJe7DNU5Fp1i/eeUNU6XTSxITC3KStV7BCkmgavAwcvO8oclZDJ8nSJArUv97Gfs=
X-Gm-Gg: ASbGncujoPOsczYPmlBgy/pi0lnSzK6dYEhO+xEd+43a82JqcpvwEG/u1lN/rpOPELH
	aAASr8Wf5HugMfIayasIASRPsFGWkjJ2pYzZ/GeR2uswfL3WiXgwc1dvJ55AA3XcH2DEEBnqEYJ
	Smq3jh3E0442+UKF8qsoD0a/lxPBMYjpQu2pDqszFgYAN113FtqwVvswPHjZUCAtRi48PfF2Pl4
	f5kY/c4AvDtOTzKhKo/2tS4UBNYxd2w7K125WlTJC8Unj4Z6OTmb77XILolzgUK8xM5sKFI94rD
	c4txRkLyTzh2EodR0bdcmhL7S5kEsJxYRBlLhLocMY5EsPltnPDqFshJQldoKoj9L/u5The/Cwk
	cEy+N9C8Dyj3UUIXQrqH9HTGv6S03djzMx7zJx40xBUzSWFYkBfx5IB+IREH3mcE5VsJMvw==
X-Google-Smtp-Source: AGHT+IGw5PNNsEWsBJ7M5Vz46WMQ8XvSWM1DvaLtn7uGKcRIEygyel+PAyOdDJrJ1R2bbH5CNEKGeg==
X-Received: by 2002:a05:690c:6601:b0:71f:9a36:d340 with SMTP id 00721157ae682-71fdc536729mr5987577b3.50.1755807648474;
        Thu, 21 Aug 2025 13:20:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e830843e9sm35039647b3.73.2025.08.21.13.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 22/50] fs: use inode_tryget in find_inode*
Date: Thu, 21 Aug 2025 16:18:33 -0400
Message-ID: <0fca9386c2eca65e7fa5a39faca34ebf42d71cd0.1755806649.git.josef@toxicpanda.com>
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

Now that we never drop the i_count to 0 for valid objects, rework the
logic in the find_inode* helpers to use inode_tryget() to see if they
have a live inode.  If this fails we can wait for the inode to be freed
as we know it's currently being evicted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index b9122c1eee1d..893ac902268b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1109,6 +1109,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 }
 
 static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked);
+
 /*
  * Called with the inode lock held.
  */
@@ -1132,16 +1133,15 @@ static struct inode *find_inode(struct super_block *sb,
 		if (!test(inode, data))
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, is_inode_hash_locked);
-			goto repeat;
-		}
 		if (unlikely(inode->i_state & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
 		}
-		__iget(inode);
+		if (!inode_tryget(inode)) {
+			__wait_on_freeing_inode(inode, is_inode_hash_locked);
+			goto repeat;
+		}
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
@@ -1174,16 +1174,15 @@ static struct inode *find_inode_fast(struct super_block *sb,
 		if (inode->i_sb != sb)
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, is_inode_hash_locked);
-			goto repeat;
-		}
 		if (unlikely(inode->i_state & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
 		}
-		__iget(inode);
+		if (!inode_tryget(inode)) {
+			__wait_on_freeing_inode(inode, is_inode_hash_locked);
+			goto repeat;
+		}
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
-- 
2.49.0


