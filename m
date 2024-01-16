Return-Path: <linux-ext4+bounces-796-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1D782E6AA
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 02:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F9A1C2297A
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 01:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23AF1C6B0;
	Tue, 16 Jan 2024 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vyx44MrV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2841C698;
	Tue, 16 Jan 2024 01:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7A0C433F1;
	Tue, 16 Jan 2024 01:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367112;
	bh=OBdpsAoslIOYEekxOPm1SsoKqRGWsFpPq2XgPbSHnn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vyx44MrVtnNztRtTrN0N30K/lYbB+uJpbyevMl+G6GZ6p7A7FhgwfeKsNRO7OLzqm
	 TWZgTQog1YJGXA69QWPg5ZkDEj1gmQVCaFrC1QSyBDOcc/sF6IEmaDgvu4uyT+35/+
	 tv6RsoHn3EYQiEXov2FtTHNlB41gIlBUIbBKsNzf389AT2t9N1lJpoYEzOryiPipho
	 NGjqtkvl1mTzyQKxepJZvIct0mJO6sdZ1Q9K+/RxpLZnhxXxBVoFkEcqoOHE5yKcXi
	 9Q+Y4NiavMb3+phXyTHnwPOpNnpNo/R0Bln9P3lHYc6hmkVO53nHNRocZlqSfP7v2R
	 K3upF5q/l333Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 20/21] ext4: remove unnecessary check from alloc_flex_gd()
Date: Mon, 15 Jan 2024 20:03:57 -0500
Message-ID: <20240116010422.217925-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010422.217925-1-sashal@kernel.org>
References: <20240116010422.217925-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit b099eb87de105cf07cad731ded6fb40b2675108b ]

In commit 967ac8af4475 ("ext4: fix potential integer overflow in
alloc_flex_gd()"), an overflow check is added to alloc_flex_gd() to
prevent the allocated memory from being smaller than expected due to
the overflow. However, after kmalloc() is replaced with kmalloc_array()
in commit 6da2ec56059c ("treewide: kmalloc() -> kmalloc_array()"), the
kmalloc_array() function has an overflow check, so the above problem
will not occur. Therefore, the extra check is removed.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231023013057.2117948-3-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 5d1935ac02ca ("ext4: avoid online resizing failures due to oversized flex bg")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/resize.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index c6d4539d4c1f..0a57b199883c 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -236,10 +236,7 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
 	if (flex_gd == NULL)
 		goto out3;
 
-	if (flexbg_size >= UINT_MAX / sizeof(struct ext4_new_group_data))
-		goto out2;
 	flex_gd->count = flexbg_size;
-
 	flex_gd->groups = kmalloc_array(flexbg_size,
 					sizeof(struct ext4_new_group_data),
 					GFP_NOFS);
-- 
2.43.0


