Return-Path: <linux-ext4+bounces-9658-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BA2B36E97
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3070E46142D
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BA836997D;
	Tue, 26 Aug 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EozQPsVp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE636934D
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222900; cv=none; b=MV0CIpqWyiBaN4t0J015bkFF1DuATNktWg7V0GDLxPvlLLJk0WvjmGaGNyCBP0+wAHVnvvqxerdJ3gx0jj/MbxTe2zMYM9kzy6kwUUk2mbipi62GUyl3EDrgZXc8g/KE5hwy0HM/AfQB8pIQLu8qezjMufnx28qNqet20wlD+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222900; c=relaxed/simple;
	bh=BXlX6/e3FMWvwMNd0XczwC8NoieaU2IAVI9/xOw4ajQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc3cPTgPRhdDOxCoI6ncPRhACf305BB6G0fAi1YaxvSAMJNKgZnDXBWdkqdHtOFczaicPW+yDqHKJ8BTb7/KSNie2OuXUb+0Tg2ONe3dBi6wVs6Rji3dZCk+Sr5L6qL4lPDgj+w+LIv75/hB3W8HhOdBhuX1KMVfbu9bvi+FoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EozQPsVp; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d60110772so49946337b3.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222897; x=1756827697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INSJnyvPg2WRednM7++OGWJKHeVt/LRMVDwrRwGwm+I=;
        b=EozQPsVpDqvP6qhtnb5+TIdQFia/oOY7o40GTMwU5MrnqGP+eQX2uDl1Clwz7TmnOA
         mLpIz43D06MCeQ9rmM53PGlsfxLfdtqkJm0DJk+faObSqnD5DGx4RlZ8/YVa4mfGD2ub
         XcZW1YnPpNpwK/oYEZtKHkQ8xNje8sduDljkT1iYM0T0tfytUgufU0sX+fbEu4j1M1NZ
         C1LbB28AeO440O8XQmCNpCt2ToOiM1H21LaF6TlNlj+Gykz8inKgwjG3nyN3r+JpLhPl
         pbqXZPFFnY5tI05E4Xbw7V2v7O6HA2gA4haIK231XNSyizV1CT2JuYPQ56Efy30YnNb4
         YvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222897; x=1756827697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INSJnyvPg2WRednM7++OGWJKHeVt/LRMVDwrRwGwm+I=;
        b=fZlzJ2lmEGDH7qBbUAG9TpNXHYRij/J1i29w73+ZX4c5xvF9m/BDpj9k4Gy+A6vS8U
         0zFtCbTkLWZ0ITgiVzwebr1LZisosNEbKKy/04mUhzOAAmGY0l9qcn/GCyV8PSq/NfG0
         l+0XrUtHVJ5Ru8cO/8xnUOZl2g/fquxpBnpGs3IDgta0vHwMKGwQ9OFuFM9FWmxBBvcF
         z99jCTc/raiiZA53OM1RjA2FhvVe8YU4md1QDWvtJKIAjFNYvX8Tx/yQtYPz7u3M77KV
         Koyz3fF3X9HYT2Zvy4nLgStIHHsLi7h2V8x93doxWjiVrT9TU4r9tV/93xuAkmNgYHw1
         flrw==
X-Forwarded-Encrypted: i=1; AJvYcCWKkWEtSwHrFsvEHLghJnZS8p5ybYHYg8I9diDdgP+yAOw3l9z4euwJh3QQL4xXX3Pclk9mCMRz+W3J@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxV9xhZe21VscCuByE6crkHxJ6UYMPoOmppFY54e8Vh289nG7
	kCnKUGuryhIpkFhv7KI8eABQpg2u58gy9j37hWdVyXj1iSOOnnWEocW/350OtWRfZew=
X-Gm-Gg: ASbGnct9zrS0kymzb9hnCFfGvNLfvGZbRQ8bE8yTCBZCbCM0f+s2FWbdoSAoGbRvM9O
	pNopk6rETQ35VRLHY6lKhTwIANAbFzpR/hH0/9SWS8Gj6JPfRZXWCuRyBbIPkYY+BrOvmD52khm
	22GKRjmSmXOpD8x2Y8YqIBnOlpcty0VHXtrjjR8eYBIbiPGs4Asm9T8Tj2b1SQwPRmAEXYlmiJA
	pzI/8bm2FJBFsLb8aveAsVzEPqXIuJO9LPoDrH9FaQ8pbppJwSvHZ0JX98kjOQiEUl9IvwYLvv0
	uD4tovD0Wx/p7C2CKlxh+gR7kpCJriqhPqi+VrHRgTMjfoBMeCe7liPGtV8clUWkic+XQmVpanq
	jiVbTG2J3OtcDEKo2EkwmjLNHHeL4AKHBnLrWZ3OzxGkyID0sBRvFGeQGq2e+laeXfaYtpzFWqZ
	hzQIWR
X-Google-Smtp-Source: AGHT+IH7pEeTz6Uz6BY9mq83w3WefooqttZ9snitZUIdAl5ESrBe4f30t0FX5yPTibQ5HgYDSnEUOw==
X-Received: by 2002:a05:690c:d1d:b0:710:f55f:7922 with SMTP id 00721157ae682-71fdc40106dmr156858857b3.34.1756222896947;
        Tue, 26 Aug 2025 08:41:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff170323esm25307497b3.3.2025.08.26.08.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 33/54] btrfs: don't check I_WILL_FREE|I_FREEING
Date: Tue, 26 Aug 2025 11:39:33 -0400
Message-ID: <af647029b7c50d887744808315c2640bae298337.1756222465.git.josef@toxicpanda.com>
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

btrfs has it's own per-root inode list for snapshot uses, and it has a
sanity check to make sure we're not overwriting a live inode when we add
one to the root's xarray. Change this to check the refcount to validate
it's not a live inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eb9496342346..69aab55648b9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3860,7 +3860,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!icount_read(&existing->vfs_inode));
 	}
 
 	return 0;
-- 
2.49.0


