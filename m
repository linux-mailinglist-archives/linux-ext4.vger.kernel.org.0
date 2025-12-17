Return-Path: <linux-ext4+bounces-12381-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DDBCC6415
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 07:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 928D130721B9
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 06:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858292E62B4;
	Wed, 17 Dec 2025 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="phorxv5n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B7286D5C;
	Wed, 17 Dec 2025 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765952683; cv=none; b=hv6RzFLbNyhUWgStSvuaX2s8bFU6nJyhYI8pcN6WOnUh0fJ7ifRhP86JUOf3m4RAR+383vN5csgS9qRqaVOKWzGRektfPCedl0ciSaZDp/2gkRUxc9W36bbo48kDqUfonbEWwtIHq0ZvthdctwKgRHnUHSLaSq5taq+spq4g/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765952683; c=relaxed/simple;
	bh=otlYw6+Xl+JP3sFBsoBoQ5rVQaTbJeUTOWy0kTjMTCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWSDHWD28qA8ADgiJR6fJ6mXYVj8wyTNJcQ1Wwgshb7a5wGHpgpYdCjk08LLQwFsUNQTKiswAR2NWOAZddpZJB8YDzmYWBwRg8UsvmfoZVRiTH/g71867yveBGJuaY2z+5Z5fQpSRwW8xp+3rEtftTCUxlyaOhzw1gW/DfHb+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=phorxv5n; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9b
	+iswVfJgWgNiWrduk1sgLazk1pc4rHmXCbu3Pj5SQ=; b=phorxv5n7bNZV81PXS
	Rx2IFBG0PbsqRSl6Ap/45LbkDcvBqcZCTt/5QBP6epcXa99KqAYnZdrHstJbtlGg
	ILMebn1/tpK4xfKiOIFiN8CUzChFPTBH7FGZ+5kEOlV00MUsJfph8o0h04t/eSvV
	qUXVbOFlQJNDqoakYNuF9tAl4=
Received: from zhang.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3MaIDS0Jpt7EbAw--.23137S4;
	Wed, 17 Dec 2025 14:17:41 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: jack@suse.com,
	corbet@lwn.net
Cc: linux-ext4@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: [PATCH] doc : fix a broken link in ext2.rst
Date: Wed, 17 Dec 2025 14:17:37 +0800
Message-ID: <20251217061737.6079-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgD3MaIDS0Jpt7EbAw--.23137S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1fWw1UCF17Jr13XrWrZrb_yoWkWrb_Z3
	47Xan8tr4qvryxAF18CFnxGFyxAF4jkF1rZwsFyrn8Zw1UArWkJFyDJr1jyr48JrWS9F98
	tFZ8Xrs8JF4xJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbaZX5UUUUU==
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiNQm-gGlCSwn4xgAA3U

The original link returns a 404, so I update it to the latest
accessible url.

No functional change to any code, only documentation updates.

Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
---
 Documentation/filesystems/ext2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext2.rst b/Documentation/filesystems/ext2.rst
index 92aae683e16a..95f48c1fc6fb 100644
--- a/Documentation/filesystems/ext2.rst
+++ b/Documentation/filesystems/ext2.rst
@@ -388,7 +388,7 @@ Implementations for:
 
 =======================	===========================================================
 Windows 95/98/NT/2000	http://www.chrysocome.net/explore2fs
-Windows 95 [1]_		http://www.yipton.net/content.html#FSDEXT2
+Windows 95 [1]_		http://www.yipton.net/content/fsdext2/
 DOS client [1]_		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
 OS/2 [2]_		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
 RISC OS client		http://www.esw-heim.tu-clausthal.de/~marco/smorbrod/IscaFS/
-- 
2.43.0


