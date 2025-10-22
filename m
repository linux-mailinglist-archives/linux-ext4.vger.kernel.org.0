Return-Path: <linux-ext4+bounces-11018-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6F3BFB2C5
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 11:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DB9C4EA6B3
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85022D0C63;
	Wed, 22 Oct 2025 09:34:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543F2874F0;
	Wed, 22 Oct 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125671; cv=none; b=iesvXgoXcKat0gkSw8CWVvairFoDx3lyfn78sFHSi0PXBN1AM2rwubypu/f2+SDx3yV44ycBythG7Uq9APn6xgeYYb8U4+X7XK3ajTSOVuALWbjcS4NZ2LFQ+WiqgG8QnAQtwSM0/sYK+D2IvNH8y494EafOG/Gb2mnouwdSSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125671; c=relaxed/simple;
	bh=OveFc3ZnPQQedsSK0v7q649BnTZuWQWlPtKKKjZpzIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YzHLk+09nCeRU7At+D7K1M/8qD7Yih2xY4G90ciGZogtgZJIk148ZlIJf86t5hH06P9sctQTmP9v0lpsCWl6ja7h4gWeEaPHeY2wac9YufEdz+kuW9gSTw1AQYu67GBo5PnoUJnxDPiPwTDWq24HanxaaBtB1u0e1Rsmi26Qo8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from spb1wst022.omp.ru (87.226.253.162) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 22 Oct
 2025 12:34:06 +0300
From: Karina Yankevich <k.yankevich@omp.ru>
To: Theodore Ts'o <tytso@mit.edu>
CC: Karina Yankevich <k.yankevich@omp.ru>, Andreas Dilger
	<adilger.kernel@dilger.ca>, Bhupesh <bhupesh@igalia.com>,
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-patches@linuxtesting.org>, Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ext4: xattr: fix null pointer deref in ext4_raw_inode()
Date: Wed, 22 Oct 2025 12:32:53 +0300
Message-ID: <20251022093253.3546296-1-k.yankevich@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/22/2025 09:17:54
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 197313 [Oct 22 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: k.yankevich@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 72 0.3.72
 80ff96170b649fb7ebd1aa4cb544c36c109810bd
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;spb1wst022.omp.ru:7.1.1;127.0.0.199:7.1.2;87.226.253.162:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 87.226.253.162
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/22/2025 09:20:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/22/2025 6:36:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

If ext4_get_inode_loc() fails (e.g. if it returns -EFSCORRUPTED),
iloc.bh will remain set to NULL. Since ext4_xattr_inode_dec_ref_all()
lacks error checking, this will lead to a null pointer dereference
in ext4_raw_inode(), called right after ext4_get_inode_loc().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c8e008b60492 ("ext4: ignore xattrs past end")
Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 fs/ext4/xattr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index ce7253b3f549..2e02efbddaac 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1174,7 +1174,11 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 	if (block_csum)
 		end = (void *)bh->b_data + bh->b_size;
 	else {
-		ext4_get_inode_loc(parent, &iloc);
+		err = ext4_get_inode_loc(parent, &iloc);
+		if (err) {
+			EXT4_ERROR_INODE(parent, "parent inode loc (error %d)", err);
+			return;
+		}
 		end = (void *)ext4_raw_inode(&iloc) + EXT4_SB(parent->i_sb)->s_inode_size;
 	}
 
-- 
2.34.1


