Return-Path: <linux-ext4+bounces-5439-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3849DC2BC
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Nov 2024 12:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCC01626C4
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Nov 2024 11:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C819992E;
	Fri, 29 Nov 2024 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="WhJrOrU+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423919922A;
	Fri, 29 Nov 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879254; cv=none; b=GMC1t9fxq3duCO/CJbyl87m0qa8874w0OpROhQq2g9x7mmwEkJn4j+6DTQottaMiA9vjuKUyf+/HrOzK6Ai9WrRX7DmD1I5FvwTyjti+KQUWw2niQE719UsaIyVEFYpNSiYgkc2qRKwkqQzRHci3Xmwj36wQA/6z1yl6ETKM33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879254; c=relaxed/simple;
	bh=phrCSsYyEwaTDwkDLtTUl/Zv10XMDCCPskQcML1QjHM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=AGVT0oCyj101HAj2N+w8RuBE4uyy66WsT7q2fBU/cQEhusjyC4g1760Af1PuCTXDPvcrUpBi428iIvgTce2UWbDQv075p0r4kCdaO2LwpeW69CNsxU84FBZh/yUhlAa2TtpOBbvh25jyQBt5KQ1JKT4x8zDRQe6Mp6n/iL3UewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=WhJrOrU+; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1732878940;
	bh=jm5vfF8YJIf0gTL8TMZpGccCAM0Ro5FFz6ZWU/e2oHw=;
	h=From:To:Cc:Subject:Date;
	b=WhJrOrU+Ty8fxB0SRr8oY90QQ5/NQM9wv1+R4mHoO0eYM2piW2JCprEfLekXydHmz
	 M0W9y/3HlKiW6en4IxmeLD53jVnw7EaUe4wmHpbN9iG8BF+yBn4IxlBAd3GBt3afRe
	 k09Yc0mD+p0+13l7/UkKJBPLQ8qIhWa9gYucXoJ4=
Received: from localhost.localdomain ([222.125.197.123])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 3B70842A; Fri, 29 Nov 2024 19:14:55 +0800
X-QQ-mid: xmsmtpt1732878895tro52lmyz
Message-ID: <tencent_8557150557A6D039F5A0565D4E8E8AAC9F09@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zKpnStv6bJnVwxl9sL5aFqmToFOR7+JOsIbQ7yuKdqMIyqG7et0
	 2YatRSyQFL24+diPvXnJEnjnd/G3KOzUKPsSUJANWKxkuIrFjTZ86e+057zkokZshhVdRM/KfrcC
	 mSCJmyv65qSHHScw3rc5JuFsDaf4Q1nXevV0AVGTioEi7SCryfesSmuK1b7XqXl4drPTgCgAgqNG
	 4V0frHmPi5giPUo3yTS2VvMlFFzf/mmgh5BxBjdRqAlU0kobit8bcWmQq/pAP+9GsDkqckT5XZLe
	 AV2Mg28LgFDdS9zs6gQPXj4jc6OwuZpmBO0urdaitXWRNMjqg+PBlRRMPgsVVEXZRJQtgSjx3ESh
	 ez5IMiryyj9SgF3zjGaCsiDE3a3YYRDVwxIXKPMN373s36d9HS+6JluQFKK+W6aqveJLX2uv9iLg
	 +1+7wRpT1NKvim1u54ngqVenkZMgy1gMe4eaep/4LvYE8GSjD2MLoQEU7aEZRdKpDkF0tcq0hdxt
	 rM4KwgAgPHahyYQkDe6XFtybJL8IMdWkjfSQonX7mRRJGw/asKRjwVh7QRlZ9kvcPeScECoOBZ5V
	 blvkGnPiqC82LUmrMmwjWwoXB6KbVr0UDI3MxZqiLT4V2KsoJNrMx1reAf2AfWC21r7XGPpXKe6y
	 vLOqsWeh75knUmIEKDuyQeZ/SCxntbHJ3glhihknLVr5YbeGLGVBPXAwtA50UjZ2KsLnIZoYoSCV
	 u0eo7CvSe0TT3ahEK3kqPz2O9xdg00O4cSR6cQhHwLezQ2ZVijFzH6+PMsyooPMtYEgMTlSEexpr
	 umo4QkwvuBhBodSa7w/eprHIzNLa6+ykFe5/QGtGaW6VeESAFuUKdFkzGLyqPLE0EOPSvq7F1WjB
	 n9CytJo6guv6ltUCyp9msEZxqvQhepw/67QRIrDyTcljH+Z+IAFMpiZkqCo68rqLnZueIQZdLYHu
	 tajTFv4iEL/eeysN2db7bDU+WdPBmVPuu4fH3Gkl13kBlmp3wyzQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Lin Lin <linlin152@foxmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lin Lin <linlin152@foxmail.com>
Subject: [PATCH] ext4: optimize two log messages in super.c
Date: Fri, 29 Nov 2024 19:14:16 +0800
X-OQ-MSGID: <20241129111416.702608-1-linlin152@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates the first one to "run e2fsck". The second "Run e2fsck" has
double leading spaces, fixed it.

kvm-xfstests smoke passed in arm64.

Signed-off-by: Lin Lin <linlin152@foxmail.com>
---
 fs/ext4/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 785809f33..001b1cf2e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4622,8 +4622,8 @@ static int ext4_init_metadata_csum(struct super_block *sb, struct ext4_super_blo
 	/* Warn if metadata_csum and gdt_csum are both set. */
 	if (ext4_has_feature_metadata_csum(sb) &&
 	    ext4_has_feature_gdt_csum(sb))
-		ext4_warning(sb, "metadata_csum and uninit_bg are "
-			     "redundant flags; please run fsck.");
+		ext4_warning(sb,
+			"metadata_csum and uninit_bg are redundant flags; please run e2fsck.");
 
 	/* Check for a known checksum algorithm */
 	if (!ext4_verify_csum_type(sb, es)) {
@@ -4645,8 +4645,8 @@ static int ext4_init_metadata_csum(struct super_block *sb, struct ext4_super_blo
 
 	/* Check superblock checksum */
 	if (!ext4_superblock_csum_verify(sb, es)) {
-		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
-			 "invalid superblock checksum.  Run e2fsck?");
+		ext4_msg(sb, KERN_ERR,
+			"VFS: Found ext4 filesystem with invalid superblock checksum. Run e2fsck?");
 		return -EFSBADCRC;
 	}
 
-- 
2.25.1


