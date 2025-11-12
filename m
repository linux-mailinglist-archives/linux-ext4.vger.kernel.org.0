Return-Path: <linux-ext4+bounces-11828-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C66C538FC
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 18:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5A15547207
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0E309EE9;
	Wed, 12 Nov 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="c9+bFVhd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA6D1339A4;
	Wed, 12 Nov 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963175; cv=none; b=OLt8wcFRDPv5F6DuZJDdhEQ2TqlIkN0/+D4Zb7N543j0HFlwdoamd+FAZmP8g2cw8HEBv678fRf6WSYpYSfCGVX7KjU4dXuzudFbLoeFW9d8h6XOcyGTg+pCv8Ig7OxYFMvDDHq2/ZRcdokBOyIh7whM155DfxyWwUvnTu4vFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963175; c=relaxed/simple;
	bh=PsjPaE4lZoLTPqrzivsYPbw6hTDiG4sJvFzbGnjYUwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V2EzpW6ru8DOjk5bIM/Des8oqZjP6CuEPnDpH23lfFIe3x6lc/qAnukX7uBDsTLO5PTxFL6uycYbzXqneehAKUzV+YUA/V/FNSA4w9qDr68g+/oJ54HvsA6BsilbVEmA3maqJ5G9gOMQWc/jN6qDMiSvJKFcvKFUrXF1dQhW9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=c9+bFVhd; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=8AhE/
	aG7KhI0jDuF9HucPWyrSJmKir5bczNqavi8w4I=; b=c9+bFVhdSkRVk76c4Yx9l
	lI7tikyUDRxzZ8qdgu5RR9AQyEw3Npv/E5F8PUkR2Ig9irI6XK3I+OLRRCFiaJq6
	GrBnCEMN4APhLicTE3+G/fGz3JbwDst33LjNR2o7jHjcLAnCcFzvvETSZKNuNEen
	QbpkrBQIhLXY66yORacT30=
Received: from localhost.localdomain (unknown [183.172.8.203])
	by web2 (Coremail) with SMTP id yQQGZQBH7CzTrhRp9F1wAA--.27113S2;
	Wed, 12 Nov 2025 23:59:16 +0800 (CST)
From: Haodong Tian <tianhd25@mails.tsinghua.edu.cn>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haodong Tian <tianhd25@mails.tsinghua.edu.cn>
Subject: [PATCH] fs/ext4: fix typo in comment
Date: Wed, 12 Nov 2025 23:59:16 +0800
Message-ID: <20251112155916.3007639-1-tianhd25@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQBH7CzTrhRp9F1wAA--.27113S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWxCr48ZrWfAr15GF1ftFb_yoW3Jrc_Wa
	9rAFW8Z34rtr1Skan2yr45KryFk348tr45Gr13Jr9xXa45ta1v9w1kA39xAFnxWFyayrZx
	ZryrZry3CayrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjfU8q2MUUUUU
X-CM-SenderInfo: hwld0xrgsvqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgQEAmkUKZu2VwABsv

Correct 'metdata' -> 'metadata' in comment.

Signed-off-by: Haodong Tian <tianhd25@mails.tsinghua.edu.cn>
---
 fs/ext4/balloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index c9329ed5c094..8040c731b3e4 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -752,7 +752,7 @@ ext4_fsblk_t ext4_new_meta_blocks(handle_t *handle, struct inode *inode,
 		*count = ar.len;
 	/*
 	 * Account for the allocated meta blocks.  We will never
-	 * fail EDQUOT for metdata, but we do account for it.
+	 * fail EDQUOT for metadata, but we do account for it.
 	 */
 	if (!(*errp) && (flags & EXT4_MB_DELALLOC_RESERVED)) {
 		dquot_alloc_block_nofail(inode,
-- 
2.47.3


