Return-Path: <linux-ext4+bounces-11922-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B5AC7159D
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 23:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7B11E303C0
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 22:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116D533C1B8;
	Wed, 19 Nov 2025 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="u+FTl50r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A9339B2D
	for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592180; cv=none; b=hdBRuAhBfkat1lXopm/J90gXxNiJ7jVYiGiNBXTy/Fh3w4+pEymHoV6orFPfranU0Q6eCOC3hqDhcZf0Nig9OAa5f8aZSjOHLCTAmzsCrkmwGa/LkeflFjCA5XrEyoEKEOFW9FM/Z2yAphrdmEO9UBlMKrbnZ6BH+am3wS4Nstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592180; c=relaxed/simple;
	bh=B+CuVWSEnjv6apDf8L5h6dPvWF5EKrerRkT/3SM1e0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LEN0/cC9P+ha1RW+uyxRxkS5YlsjNVIEh1yHJ+qmBy7Ffr/GaMzXYFw9kZjM/u8OIckkb0XSIq95y1auc9NIKQkRf6sbXxGgFAToXuyPKM7b8LSH2Xoj0BZdThGFbMpH58zvNGe27mwaUtpoimZvKl0rYywAJgAsGXrqviylEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=u+FTl50r; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt5-006yy7-MA; Wed, 19 Nov 2025 23:42:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=j9oCSSBZzBkPtvRfjBAuEGRtwy0B7xvGWFsoQtyzxh8=; b=u+FTl50rmEe/5i/+MoBpS2Q33D
	6kgaICrHucVByc3skpZ+Y9wZV0GCSGmHsVxzszm0YG2B/KLufryU8cwnsPlFNfaRvjjg2uhJJX7ft
	jsWlK2n9WJWr/pukLGQRvyCQSjv77305Yj1/M7pmg0jt9UiGwWKys2AjlKk48jC8JfSrZwX1X6Tuz
	8KLvDNn8r0Gkw6zETtheN31hMHIQGskvPIxqa/TgERIIcc/wAZvVNeSoZYF6j1pggIgnVV7+2Xkn/
	mJ6zxZbLUedzV+ktQyPIH5+ui/rrWqfWnfOWJ/FVV1RVMFomp4YqIfPkJuoAl40KwvXaB+eo9UwHc
	IahpZXbg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt5-000873-7o; Wed, 19 Nov 2025 23:42:55 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsU-00Fos6-TH; Wed, 19 Nov 2025 23:42:19 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
	"Theodore Ts'o" <tytso@mit.edu>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 02/44] ext4: Fix saturation of 64bit inode times for old filesystems
Date: Wed, 19 Nov 2025 22:40:58 +0000
Message-Id: <20251119224140.8616-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

If an inode only has space for 32bit seconds values the code tries
to saturate the times at the limit of the range (1901..2038).
However the 64bit values is cast to 32bits before the comparisons.

Fix by using clamp() instead of clamp_t(int32_t, ...).

Note that this is unlikely to cause any issues until 2038.

Fixes: 4881c4971df04 ("ext4: Initialize timestamps limits")
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 fs/ext4/ext4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 57087da6c7be..d919cafcb521 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -909,7 +909,7 @@ do {										\
 		(raw_inode)->xtime = cpu_to_le32((ts).tv_sec);			\
 		(raw_inode)->xtime ## _extra = ext4_encode_extra_time(ts);	\
 	} else									\
-		(raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t, (ts).tv_sec, S32_MIN, S32_MAX));	\
+		(raw_inode)->xtime = cpu_to_le32(clamp((ts).tv_sec, S32_MIN, S32_MAX));	\
 } while (0)
 
 #define EXT4_INODE_SET_ATIME(inode, raw_inode)						\
-- 
2.39.5


