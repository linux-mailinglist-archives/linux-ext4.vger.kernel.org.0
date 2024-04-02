Return-Path: <linux-ext4+bounces-1817-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B68949E0
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 05:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638F71C22348
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 03:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B8914F64;
	Tue,  2 Apr 2024 03:19:42 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C94CD2F52;
	Tue,  2 Apr 2024 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712027981; cv=none; b=qxwRVCfpDOHajoefNS+9o0B3GxHniPtpjv8dLNn0mkATSkAF1PHmheHzpFqXnL9vQwhs5jtz1AHM+SL48v2WXvYrY7UZg6hvQPHwzMYxocgvhxOsAVdhxZRSQ/i9KU13c0CvDQlbfNKcjJ3CMRkKEaMN/bxfOhuLpwki2RADQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712027981; c=relaxed/simple;
	bh=t7OGwSPTzMHZ3C/Fcp6Kle6Ak4fVZXc+vcW4hvY4BuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ddr6akNdIEThWDuyGXb1xGmyk9P5khCg0dxC7WkkiU0PiD7lSdXxUSBPtBiQ4E6BQyAhbfhWvEkjTuZppAx2vdzhbtSyPCE9PLTIaGbo3x53U6tAvUvQXTkPdpZl/da5DP3XbffJMm4pmd4Gc4Q/aiKgTBZz/W3nSXRpQI+ZCJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id A1A1F60A51E62;
	Tue,  2 Apr 2024 11:19:35 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?ext4:=20extents:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20error?=
Date: Tue,  2 Apr 2024 11:19:28 +0800
Message-Id: <20240402031928.33790-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

error is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/ext4/extents.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f3cb570951a7e..254e07a33eb9b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4977,7 +4977,7 @@ static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
 int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
-	int error = 0;
+	int error;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
 		error = ext4_ext_precache(inode);
@@ -5009,7 +5009,7 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
 {
 	ext4_lblk_t start_blk, len_blks;
 	__u64 last_blk;
-	int error = 0;
+	int error;
 
 	if (ext4_has_inline_data(inode)) {
 		int has_inline;
-- 
2.18.2


