Return-Path: <linux-ext4+bounces-12516-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BAACDD887
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Dec 2025 09:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B4C1300252A
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Dec 2025 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F94314B82;
	Thu, 25 Dec 2025 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="DGB3VakA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA112E8E09;
	Thu, 25 Dec 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766652494; cv=none; b=FuQfTGQRV94OcbfOY0T+m3HuckzlBhj1DHgIXcI7BauF7KFOhntlPDYpdruZWjxl85t4FFj5uwnFAEveoYvGKAFch4nmprWEoomq3tH4ChUfvT+6LF0F9Is4NcJ14yChAZdCRvLpRDi2rA/vpzEhh0ZAV4brM/ELXd74Sece+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766652494; c=relaxed/simple;
	bh=JoUR//jWrLRm/jqMnDPyYkdHeCyTr1u3wShTEU/rT/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HxEpsRdttgLlZRYIZRhETqYh/oGlAjIGFOSp+259QmVKlmlwrRiQOq6bHuuaqLwb5uwlNgtazIz0OoPJkFvE6D+YPzHyuUSMKLsPmURgkEUpnFWieKm1yDn3dw2gIoj7tFf5rCs4BHhjnRe27LodbZJCHmdtJ4Vs4FC7ewltNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=DGB3VakA; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e8990173;
	Thu, 25 Dec 2025 16:48:06 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] ext4: Fix memory leak in ext4_ext_shift_extents()
Date: Thu, 25 Dec 2025 08:48:00 +0000
Message-Id: <20251225084800.905701-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b54b1a37703a1kunm30b6e74737ef3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTEtLVk4dGElOHxlJHU9OGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=DGB3VakALsZoioi1G2zMyu91qilQcWyCg88sd+zm/GTauuA3Cmn+qb/TO/LCYxnKx6gzMIO3nEWi2aW3oNsbFV0C85YqSTf6BA8SGeS/OZIyWbZsx+DyxbsvOot+dY6e5HXrb9+O7s4rrcTUu+2od8Rh2BE5CJpzp/tKhPSjGqI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=+PyY4ptEdV2osgl/CrfMicsDI6wHAwORrha+rcsKk0I=;
	h=date:mime-version:subject:message-id:from;

In ext4_ext_shift_extents(), if the extent is NULL in the while loop, the
function returns immediately without releasing the path obtained via
ext4_find_extent(), leading to a memory leak.

Fix this by jumping to the out label to ensure the path is properly
released.

Fixes: a18ed359bdddc ("ext4: always check ext4_ext_find_extent result")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2cf5759ba689..1d21943a09b0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5375,7 +5375,8 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 		if (!extent) {
 			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
 					 (unsigned long) *iterator);
-			return -EFSCORRUPTED;
+			ret = -EFSCORRUPTED;
+			goto out;
 		}
 		if (SHIFT == SHIFT_LEFT && *iterator >
 		    le32_to_cpu(extent->ee_block)) {
-- 
2.34.1


