Return-Path: <linux-ext4+bounces-1813-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DED89494C
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 04:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D6328581E
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 02:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A522DF51;
	Tue,  2 Apr 2024 02:23:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C1502DDA9;
	Tue,  2 Apr 2024 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024598; cv=none; b=esrQQqlnUobQuzzLwCiPtjcdZbgQ5EeYhpbXl8gdsjkYHqpW5dHPv1/ZbTrHcos7Gf6fxqw0jSP7G0z/2C0PMwGeIVWKLXTy96G4/NRhH/Q4+Tz5wmbpmOtbe1hwab9xeEuTDGlhuLoAfoUrTBwpCnrHp/w3/Gv5am2KTCBAyac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024598; c=relaxed/simple;
	bh=lK3dB+eY3hL7m93zgy5ec2mL/lUb+/06ViM6WyDGPNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pZn65deEiZ1I5aFAC9/TxnRSbFMJ0GGgv0BXo4EeohJl57/nT/qcQvRw+Xcj6bmtMU8oFRRGo0MixshyZK2wW+7E70/JQcYWDxf5kz9IulajcXfh1uC4/6GzStu2LlJuoioUNOpw7ibKYlnUGS8RxHAUqSsU+szZk07pHPLWFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 999C46055052C;
	Tue,  2 Apr 2024 10:23:07 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?ext4:=20block=5Fvalidity:=20Remove=20unnecessar?= =?UTF-8?q?y=20=E2=80=98NULL=E2=80=99=20values=20from=20new=5Fnode?=
Date: Tue,  2 Apr 2024 10:23:00 +0800
Message-Id: <20240402022300.25858-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

new_node is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/ext4/block_validity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 6fe3c941b5651..87ee3a17bd29c 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -72,7 +72,7 @@ static int add_system_zone(struct ext4_system_blocks *system_blks,
 {
 	struct ext4_system_zone *new_entry, *entry;
 	struct rb_node **n = &system_blks->root.rb_node, *node;
-	struct rb_node *parent = NULL, *new_node = NULL;
+	struct rb_node *parent = NULL, *new_node;
 
 	while (*n) {
 		parent = *n;
-- 
2.18.2


