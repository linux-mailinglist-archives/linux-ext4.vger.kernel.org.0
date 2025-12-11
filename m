Return-Path: <linux-ext4+bounces-12296-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E94CB5E5D
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 13:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 920E93013EED
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83A73101A2;
	Thu, 11 Dec 2025 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQjRylQy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7C30FF36
	for <linux-ext4@vger.kernel.org>; Thu, 11 Dec 2025 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456717; cv=none; b=WIBeN6pc9gmlH9dbFaWA/jF4+UzUbzFl/AACUFMHdaMqNfV5E3hOuvUplwctJQLW0ebsu+GApxPEAGdfsLe7RoNWjAjPa+4jISJBTzYHSH0PDf0MwDYbEfmyvVygaVh8OATFX/vkXbbz1FAt4BdNFM/tY3QA2M0sSchBriYDA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456717; c=relaxed/simple;
	bh=Wpd9VOFcp+Oh+2WjvJ0XXHzWot3Qw+9oiHL62xVXths=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lNS2ssTsv3q/KLFI6NRbF0qDJ1x2wOtw9R9n3QG4NFPDLrj5waeZ6EVKDOXukdqVhTUYtzyENNZofaGDJ2dsjNAxRuJP8JjdeBufXWtpTrJNskkgaRggj56r80Hr97+k/D7RczTDTAZYrM1YZJndRqWF4h7ClUs8gasvw0or6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQjRylQy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so29778b3a.0
        for <linux-ext4@vger.kernel.org>; Thu, 11 Dec 2025 04:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765456715; x=1766061515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jVklOrcJrjalf24Y9OhqgAs5pwV8d1t2PYYq/cy3dKs=;
        b=iQjRylQylOj5Z12VNaeANV6p74NyqD4vjG2Z3IKtN2VaHAuIC5ghm2dIXNW+7kZarE
         cW88ROTXWXi67OLOUemdKNb0k1zZzJ/XBaY7g1WfYbdca53bfIYppuMOpMuS5WE9EaHg
         L+dJnq22oG5xPBKDSHi6diSwRpoMAHegmLNrmIESZk2DkkhLW4cm7TnEZBcBdW7L9dL4
         LekaQLOVDXb+LnZ+00WcHCRAWavpYGryaUrhQS6rtjgxY5j2gAlkcosxGMQDuYhJoToy
         Steq41jW6ihf/Vq8DLNnzcvklEBoXeBdQ5wb6WwKpg7Oow+FRNZLUHHVLy9Q0sCyX5iV
         taSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456715; x=1766061515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVklOrcJrjalf24Y9OhqgAs5pwV8d1t2PYYq/cy3dKs=;
        b=Hty3gOSDGUdLUz/+EP3yiqz7/Hz7MqJ8TLW1B7rweaj14CA53LQLFg3/ZR5QbVWRm7
         7IMVfuz7SCacBKaRvaWyTAi0xUjNHtbo8gKr24xl3iAutu+ZnTNmCXDB7PvxG/uRqFHu
         pBDWkr9+9ZZWoPSnIkih6xQiZyqmxHb6K2f2zO0Y8wEQdh6ZN1/wdVRQLlYQ1h5e5qSe
         tXZqUAjyfSziNYlJGW4oBxOHjHiGA+E03LAM6g5A2m9loXcGvf5LAX7ajBiECAme7oMO
         Pw7VeNto5GM0uqEaXzHIEw5eLFyFw15VcIUs3/D8agCz5+AWp62DzGrj8mLJH7oPPqp9
         Gz1w==
X-Forwarded-Encrypted: i=1; AJvYcCVoukrnt8mXeTwd1axqJLSToKO4ILBsjw50hHrz67wYWB55bSvJv0hTo4NmvMRxK4WYi+5t8n91BfOf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2N9X98QfpCHcIHEMWDYc5H+PdNEz19HrE+EqwMebfjvGezcJF
	PyV+tC9BelaPAX7pg/SZvlnA9OVZjLmXlrocg8jV5tnRfONmNNFee79a
X-Gm-Gg: AY/fxX7kIWcLWGpyJvSf9ogOI+WIl9fOORDQlB/rzzzGnjSKavPN0VEu1uF+p0mckuU
	Cr3Atk9Fkii38MJl/+8sePKibsa8j2JK/RUhijaYk3Xz0oObwyAfQFZVPv6NMtVcP6GF5B9t7C1
	SO1Cyvg3zhsq5dvjWNpnfgpJUXpLMtRgb+m/IdpplAHPyUrOqCLOptCtkNdGpUhUKPiBukS+j26
	etbFlnAKe5mamKzoIqqBXcKJfPuQjjBtxqbL5oIaU3nCpE1d+5yBJLa+2MQEiV7KaAhUVED6ers
	8poRyULNnw4CGZGsPRMLjrnaT6gHR5XqSpelF1N8vZuvXq0RZwcemk2ZU4LCiyiQWdYq5KO7Qbu
	udwVg6CFf1vFkCWTVIyEVfhMjJsG0FffcESf6Tm0y+/cGHCf7Ne+h1eMpsduY3BwN3H0eeSlck8
	C8HYls5LMcFhPzpL+gX7dmAtc/N74=
X-Google-Smtp-Source: AGHT+IGa4YrlHupLsUEDSZr2VbkEFBQsGIuaDh0xGvggSgayjCcp2g6iU98/S7OR8r+4KF5/Gp3wiA==
X-Received: by 2002:a05:6a21:e082:b0:364:33f7:6099 with SMTP id adf61e73a8af0-366e2994d53mr6431757637.55.1765456715203;
        Thu, 11 Dec 2025 04:38:35 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea06dec7sm23944625ad.101.2025.12.11.04.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:38:34 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH] fs/ext4: Remove unnecessary zero-initialization via memset
Date: Thu, 11 Dec 2025 20:38:29 +0800
Message-Id: <20251211123829.2777009-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The d_path function does not require the caller to pre-zero the
buffer.

Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 fs/ext4/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 7a8b30932189..484cb7388802 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -858,7 +858,6 @@ static int ext4_sample_last_mounted(struct super_block *sb,
 	 * when trying to sort through large numbers of block
 	 * devices or filesystem images.
 	 */
-	memset(buf, 0, sizeof(buf));
 	path.mnt = mnt;
 	path.dentry = mnt->mnt_root;
 	cp = d_path(&path, buf, sizeof(buf));
-- 
2.34.1


