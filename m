Return-Path: <linux-ext4+bounces-1859-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B38988E5
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 15:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F81C1C24EAF
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E446412837A;
	Thu,  4 Apr 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dObrsTg4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F321512836B
	for <linux-ext4@vger.kernel.org>; Thu,  4 Apr 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237842; cv=none; b=Cu6G+hyTnvYX8wK3GU33do1EoDXBW3BQdmmhWyqm2fxaTLZP3JbKk448FJD0mV9o7sE84QKzTgrPE6pEWSkm8BzFocIpUNe1fgi1mXtfXUarpL8hsOVSigM8D3l1fzY2xrY2aCGSLK0DCA67jxDsVeJRs8SuiOEO7xLIWqBT+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237842; c=relaxed/simple;
	bh=940cLlbzV8VFpgJm1FQEG99fePaOqfrVaVB+HvJoX+A=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=EmMcgfY4uZt6BXdg6HfTPE6DDTPxnU2MOVZW0aAmeK+TCarp/rwdBsRWFcX0qslxD5IuQuK+SSCoqPnBcwEKporHNRsDMv7KnDP/n2qiBHh1AWtaNZA5BZlqDVaUVsbgSa0xsPWH7O4ABE7m3p6NT7L5KlfabbQrOO4Vduy1ALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dObrsTg4; arc=none smtp.client-ip=203.205.251.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1712237831;
	bh=+0TAgpTSkgu3idk7K76VlB30Cdq8PeIbrSWtdBOwwSw=;
	h=From:To:Cc:Subject:Date;
	b=dObrsTg4rL1NAxTmqRFUCEmXjmKRAt5hzPCQu/CSLde97clitDnFf2mUFM5PEnxf5
	 E/eCpPHyZrxBp0jNzJNQs4cz6OZtUKVIwDb0HTNUc1vWaR+fCGZtX3hreBGXXANxhv
	 8he8wkuTKb99hSResSdPwUBMDhjBA2KAYzietKJ4=
Received: from fedora.. ([120.244.21.52])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 94A25686; Thu, 04 Apr 2024 21:37:10 +0800
X-QQ-mid: xmsmtpt1712237830tmpzoxaxw
Message-ID: <tencent_1D453DB77B0F2091CB4A68568A77627D4E08@qq.com>
X-QQ-XMAILINFO: MyzgKsCjKVjegBKYzzElLS6RaXh/RgkJaJ/aA+2JBzSP2GhRSxz5bgyJLScDqy
	 vFNtYOmuSoXRIXWVXhZ2plgFUJMqXx2L0VNA0A+thFR5cCtXtSL8r67wFWeOldxcQO+8PuH7pWGu
	 rkzyxWdzsiy/8lzn6opDxU1FE8OzhMPVO5CdZCZr0tUSOovXPmrbzd0sW/jI0/B6ZFoXXJIOmmpo
	 qbuKGGGKwKkN3gpmhPBe0Nt8vX48WTGSzaIr+9w70xWhKd0zmr+KKxjPA8sOwYfhA6m+YOkOCpzr
	 neRI+wD8n+jpXloEX1jzSF2ak5pYtEMrGuqRihZnVmi4EG+0Fnx60CtAcSYiuRL6oUffcBU8EPB9
	 T+oT72KSgaZukLDrw/7AayKHiC+LrRrdim8c2MJ7QXXsRDRl2rxJ/V3wu/ixrzOc6h4wUcIMuXZr
	 aKWTj81MtEffBszLWLhlieG7ElJ6atmiJDeyRo7670S4H0J7yECnRoVj95b4rvsycA/as4jv7wbs
	 WZiZOyFKRjqJ8fhJ6NRcmPQp0NtGMtbw+QZFe98K9zW+X0in96Kvos8Pnl3Bq19go9jtbtEW6hLJ
	 ERrgUWnQYLsXFjHx5pR7yVwuXmPZuLbgg3ok01GYt5TmyvB33p/R8zna2Q5UubC8cVjuAXDH7MEK
	 fcUrXZkKu4DEYLAK/77tR5xaudXdGBsubhZM2sD/G/BxukgeTu/UHaKrqbNJ7nJrQhvgxtBeiwbd
	 Jvqy0P54MlvadJ0nI3759tGBTp6D1ewN+YzUV4fUUPwHpX9SOTR84ZbceVRNQ1yc1YePv/3ScfM3
	 teX/X4vjSvHSftzyISNeR40tZMx7MJreLOtmd5POicMFfe0TQ2mZfmBUsrNgQAmh29J1lNwqo9Ai
	 42oFXciOV7bmORprOQj9am+/32aZuXYzDUDxYImFK/+WQYN1WfbtobkE5ZDF058NzfQ0qYiX9UwT
	 23htecyd2GbaK6XWX7SamwqgsFGhukKFaXRiU8t2BnDCBLIHFQOC/2AKY1+I/Rz4DfArTflys=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Wang Jianjian <wangjianjian0@foxmail.com>
To: linux-ext4@vger.kernel.org
Cc: Wang Jianjian <wangjianjian0@foxmail.com>
Subject: [PATCH] jbd2: Add a comment for incorrect tag size
Date: Thu,  4 Apr 2024 21:36:54 +0800
X-OQ-MSGID: <20240404133654.46748-1-wangjianjian0@foxmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

journal_tag_t has already counted the checksum size, however, for
compatibility reason, we don't fix this bug and keep it as is.

Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
---
 fs/jbd2/journal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b6c114c11b97..b5e614818e8b 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2698,6 +2698,10 @@ size_t journal_tag_bytes(journal_t *journal)
 
 	sz = sizeof(journal_block_tag_t);
 
+	/*
+	 * journal_block_tag_t has already counted checksum size
+	 * but for compatibility reason, we keep it as is.
+	 */
 	if (jbd2_has_feature_csum2(journal))
 		sz += sizeof(__u16);
 
-- 
2.34.3


