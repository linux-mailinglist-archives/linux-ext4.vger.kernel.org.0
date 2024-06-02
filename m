Return-Path: <linux-ext4+bounces-2739-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AEE8D7544
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Jun 2024 14:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A2A0B20F56
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Jun 2024 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492C439FD8;
	Sun,  2 Jun 2024 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b="2tHWW3s8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CD3D51A
	for <linux-ext4@vger.kernel.org>; Sun,  2 Jun 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.3.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717330542; cv=none; b=BNN3ErV/ZS7flziZc4+7/wghauMklav1mo/WmZd/dIDDM/ehSSD0pLpTR1oaihrnwtb2uxB2BUnNNFN4M/6EkdRVkus0EMRfBHvO/2MeSG9ih7lTNnRDCX9QdiFTgUtw55HhW5C43mN876yIKnXvvSJkz9nYQw4Q5Eixt+cNcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717330542; c=relaxed/simple;
	bh=Njp6KCE9wyEFjpp7hZ86IPaiG19bUetl5J+liw0Bo6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hvH+QID9iQgiUh1z/wYfizWaWygOXOjUXt4oVM6NoFND8968GjTysa9xPJOyNrnVBNu6cOdQCEMPCEfRwmc6u6m6uCiUdg9vjVSgOc8VZZpzd32uaTHDslPuGX475a6i+zMMid5k8agA/oZhmhWeqbYCbn3zZR5H6vo8k2YtlkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se; spf=pass smtp.mailfrom=lxm.se; dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b=2tHWW3s8; arc=none smtp.client-ip=93.188.3.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lxm.se
Received: from s807.loopia.se (localhost [127.0.0.1])
	by s807.loopia.se (Postfix) with ESMTP id 9F9F6301F6A0
	for <linux-ext4@vger.kernel.org>; Sun, 02 Jun 2024 14:07:57 +0200 (CEST)
Received: from s899.loopia.se (unknown [172.22.191.6])
	by s807.loopia.se (Postfix) with ESMTP id 8F9A12E2872E
	for <linux-ext4@vger.kernel.org>; Sun, 02 Jun 2024 14:07:57 +0200 (CEST)
Received: from s472.loopia.se (unknown [172.22.191.6])
	by s899.loopia.se (Postfix) with ESMTP id 8E1752C8BA68
	for <linux-ext4@vger.kernel.org>; Sun, 02 Jun 2024 14:07:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1.2
X-Spam-Level:
Authentication-Results: s472.loopia.se (amavisd-new); dkim=pass (2048-bit key)
 header.d=lxm.se
Received: from s980.loopia.se ([172.22.191.5])
 by s472.loopia.se (s472.loopia.se [172.22.190.12]) (amavisd-new, port 10024)
 with LMTP id lFMVuc_PQEzr; Sun,  2 Jun 2024 14:07:57 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: henrik@lxm.se
X-Loopia-Originating-IP: 92.35.23.126
Received: from pc.arpa.home (c-7e17235c.012-196-6c6b701.bbcust.telenor.se [92.35.23.126])
	(Authenticated sender: henrik@lxm.se)
	by s980.loopia.se (Postfix) with ESMTPSA id 21684220164B;
	Sun, 02 Jun 2024 14:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxm.se;
	s=loopiadkim1708025221; t=1717330077;
	bh=niS0o5ubvzUlqH+oKPFCJymMECr+LOFr6uOVCuGx/dw=;
	h=From:To:Cc:Subject:Date;
	b=2tHWW3s8qFhJmmHS3EVEfI9FR+wLCxcXjBj7qFjY1Q+nwQS/FQHPS3/w/QnoaAVPP
	 u18ZtODPBEuDkmg5FR55GoTO+WaJbC3PseBqqenCimMcSV2OAzAa/vxySkmGTPh5cw
	 7tnYozRXwYbHoBW8/o/4o+5uKcAHZrSQhXsiUp3H2issImzUwamMhU+hptyIj2WTfT
	 qSoygEcKcJDXSnk9zZoPjm8mjLavA9rh/C1qcOgd2XRIhX5o6Gw2mA+T+5rVYzm6T5
	 WxwhF1iqDvD6DPmHSdp5IwTMpU7VYXvb2JPbjDsX1SfogNfWDrS8/micaSqHV5AWV+
	 Ol0+cccyVfVkA==
From: =?UTF-8?q?Henrik=20Lindstr=C3=B6m?= <henrik@lxm.se>
To: linux-ext4@vger.kernel.org
Cc: =?UTF-8?q?Henrik=20Lindstr=C3=B6m?= <henrik@lxm.se>
Subject: [PATCH] Fix implicit my_llseek declaration error when targeting musl libc
Date: Sun,  2 Jun 2024 14:07:21 +0200
Message-Id: <20240602120721.387561-1-henrik@lxm.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Henrik Lindström <henrik@lxm.se>
---
 lib/blkid/llseek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/blkid/llseek.c b/lib/blkid/llseek.c
index 59298646..edb64320 100644
--- a/lib/blkid/llseek.c
+++ b/lib/blkid/llseek.c
@@ -52,7 +52,7 @@ extern long long llseek(int fd, long long offset, int origin);
 
 #if SIZEOF_LONG == SIZEOF_LONG_LONG
 
-#define llseek lseek
+#define my_llseek lseek
 
 #else /* SIZEOF_LONG != SIZEOF_LONG_LONG */
 
-- 
2.39.2


