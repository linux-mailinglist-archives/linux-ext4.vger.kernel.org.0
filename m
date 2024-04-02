Return-Path: <linux-ext4+bounces-1814-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3589497E
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 04:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9011F224D7
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 02:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B390B111A3;
	Tue,  2 Apr 2024 02:41:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A4F2A7E6;
	Tue,  2 Apr 2024 02:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712025713; cv=none; b=DECJkQtyRPHxbIf4JWs5DoVytBmXsKEVXjfY4EEkOPmpfHgG9k6T38lHSvqJ1DnQJN4H8IwuW+btmfTA9TVDeaCA9qJaA4vK8eSMh6iF9niSCFfXlXJkGbx7gisopqxoBrKUrVtxMdqxfy7eBFrT7Doir8tMk8Z0LGDxgbIvi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712025713; c=relaxed/simple;
	bh=wy+1wWxus3Q38bJ2nREE6uZNn5pDAYb82HW7ZqHZbS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ij70/0RHfyxSORUzpwyfDexqhIPiIbDztR7M0rILrnwPX3Y3djmP3Q9RFmmyj1U69gOwBcad9i5Tp3HoTv2xBkAD65RMeFbh+up3rnVU2H8aj20pf4D+kkXezzIC0Mkb2340TBx/3ZfB9Ti+pcJUCpm2wKMAx5qSsAT8tqdbJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 86079605A1028;
	Tue,  2 Apr 2024 10:41:47 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?ext4:=20extents:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=98NULL=E2=80=99=20values=20from=20path?=
Date: Tue,  2 Apr 2024 10:41:40 +0800
Message-Id: <20240402024140.28456-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

path is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 7669d154c05e0..4ab96f01a6f31 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -600,7 +600,7 @@ __read_extent_tree_block(const char *function, unsigned int line,
 int ext4_ext_precache(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	struct ext4_ext_path *path = NULL;
+	struct ext4_ext_path *path;
 	struct buffer_head *bh;
 	int i = 0, depth, ret = 0;
 
-- 
2.18.2


