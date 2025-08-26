Return-Path: <linux-ext4+bounces-9666-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7571B36EA9
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3388C1888625
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCECD37058F;
	Tue, 26 Aug 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QBarsf6+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DE36CE00
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222911; cv=none; b=lU2QWj3a38deAbZV36DraQkaWsdPSavI8bIOflRbDm2nY9+kf5MNdZ/EmlogjJfjGo4TuQlLNovUIPZoEV8dijzP9ol9TixpLHv61uE5fMhe+F1gbDv7fVm4PMFQE29w7WcJUpt3Vg9lReDIs8Xj5dpGQUpVtggpsull5Df+YPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222911; c=relaxed/simple;
	bh=2zYyZLHp4D2hgXiAAGibRc45yLHOvZtgp5B6E/34V4Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N551aA0kzlK5CrL7skVtOX2lg1lUV2MItPnnXLXGfQ2mKDzjEaNHYDJqbyn0c0yI/x7abUhIf36bIla100lCN6JXevPbZ8VQ5Ye1mDPRPLtzhs9OL4Z1k1M0yPq2DJZBW2Y4WSLh2p4+LC8aFMlL9XBD75L9Rqd6tm/xEa4oEZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QBarsf6+; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e953397c16eso2354338276.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222909; x=1756827709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BE//YinxPgmUWE8hsLrFsv2AZQscov+biNx5LkG7S88=;
        b=QBarsf6+5qFf4TdDe0d3qJt9CTe1q6JApaGKRCFwzUvqQhRcE9umkfMdU6tSTYB1Ly
         GyJk22XkSTXTcDGh1XJ68x443V+YkvJ6DKF2a9rrHJ5Lot6vOpDb6hBi3SSNTy/gSECR
         5oBpg8tsiQDbgCnT2T7fqUskT3VWmcRtnRFbHtaYgxpCcTs7a++Ns2teQByV4ZWl0jkF
         9frRsgDUa9rZSfVwfXTisE2TRn4LhviWcCf5OVux/cGUZ53/Eig9dLl1C3kdZfHzaHo/
         nLRjQxJ0q5JpkChLXLguhoFUs4UH/gaYr29tmTm0AnuPxTIUZ9FlbQC23zS4V8eGcpmg
         RbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222909; x=1756827709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE//YinxPgmUWE8hsLrFsv2AZQscov+biNx5LkG7S88=;
        b=ApagWm1X4tTM3Kd37ZjfLxy55JDxqqAebFebewvW8bkqKxI/AcYSsrgBR0Tlld35la
         ULD5Of1c/Ucpn+fntY5AJFKRdlK48xB9E7U5cOhse5NHlw6xjAyQtGVvYEyRGGLjzfLW
         krT3ZO/8A+PWMTmMehcqmTIC0r88WWESWB73qHJztx9IzPdRaZ9vTTPT4SiaBzpX/qH5
         e+K8agzh5oVugV115jXrM9jzb3zqyJlRTD3ZQoA++fphsLlFI5oLZJISp9M8rL806uog
         Idbd3CaWQU48WCp2RiG05AZEJee+xSFL394XqYQNAMyOzbktwGaS+ERdfJQCUb7sIcvW
         r+WA==
X-Forwarded-Encrypted: i=1; AJvYcCXItJmDBt7jjnZXZVAg7W1nhqWCmh4dELrJGLnV04xySpy8CxlMfnG5N1pEXPLNyxlR3S7cbHZ0JDGz@vger.kernel.org
X-Gm-Message-State: AOJu0YxxQ/3We8OyMMIp4NrA4Hv2QF+aYZC/FlCvubHszGlPpGLO1LNC
	xgyhYZ9YtuJ4zlJsKWc4IlFacNHoCEJVv5dflgPMtR1qwZ9Tv0XY026KWecN+iS+eCk=
X-Gm-Gg: ASbGnct0YCfAtpxrAwBX70u+mRNtDf8lAowVbzbmNWBI7dW3ePikahIfVHb3eV+Iv3Q
	22+2/qa3jEu/agLAOxkPWPZTFfvUT9lPzUU9u7SNDV7o+CG61o5qSMbm/nw4nPZgONoMQOYT91+
	aKQqED2YiTUzPeKQtRl6krOpHOQySWGpJIHpbtDudQK67mFO5SpGhI9nibAWnkvsa3+I25DuclG
	O0kwLJxOEERD3mv9zdkIp4Zhld6TB1OXB10Eq31xbvgFDke7UobxV376OQI+os1KdtnQcYluoxw
	1ScKUuxz4hmdDx55/kz507vHDUyhMe9godS/wvSIuqIDvcoicwy2QrXTvcvmN//MNy+bPRGbJ5s
	Bq3aWMkRyAMDJm9cP81eVYIbC2dblC1cMtOQiwxxuNTRNSOSBk+VFsEe3cCA=
X-Google-Smtp-Source: AGHT+IF30GxXzt31jHcfNUoY2pUyBatIJtVlXY2VZDYDljhQelnzFVQCaalCRl9Yu+PEcvaFlg6PNA==
X-Received: by 2002:a05:6902:2b10:b0:e96:c754:b4dc with SMTP id 3f1490d57ef6-e96c754b6f1mr7345665276.18.1756222908777;
        Tue, 26 Aug 2025 08:41:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96c38c8efdsm1865626276.14.2025.08.26.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 41/54] xfs: remove I_FREEING check
Date: Tue, 26 Aug 2025 11:39:41 -0400
Message-ID: <830cf8502686e1bafe75ec6fa7e87c68ed49bd54.1756222465.git.josef@toxicpanda.com>
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

We can simply use the reference count to see if this inode is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_bmap_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 06ca11731e43..cf6d915e752e 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -514,7 +514,7 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	if (!(VFS_I(ip)->i_state & I_FREEING))
+	if (icount_read(VFS_I(ip)))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
-- 
2.49.0


