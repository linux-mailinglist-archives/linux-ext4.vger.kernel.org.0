Return-Path: <linux-ext4+bounces-8254-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A597AC9E7F
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Jun 2025 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CCE7A8F4F
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Jun 2025 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28111C7005;
	Sun,  1 Jun 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Em4MUJf5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF72DCC09
	for <linux-ext4@vger.kernel.org>; Sun,  1 Jun 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748781415; cv=none; b=rglXlRGOUayuh0wROPNBpC8vcpE+eYfy6KzXOFiu+gk6+iEu/4Os3fx1PXaTYLtCy+ZnR+sMJuPVMSRIfJ46fkckZsHieMVITfQ47sulgsZuJgbrJSyBVSKwTCjLM+HE2Qb+p9QOMXVNVZX6I+rmhb+ncmgPf6zy/slvBUExz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748781415; c=relaxed/simple;
	bh=Ce/KK9Ctsv5FRNTabccIj1LFEE6oQezImtah/j8FaEU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5TeEsE6aR6/9p/ngujU5ZyeWUfw6gWKpVqZP+lH6j+HVLu//J93a8Oa42pndXaPlcF64EwZnMNwZKKTknKd3j5H4zT/L753DUe7wDMMZeTdzbKQt7Z//b8H8ABcqJxBfIYGa9mTn7DazXzpZU8kS85FsoN8KFiPoMxHPVrXNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Em4MUJf5; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
X-KPN-MessageId: 363ade0e-3ee5-11f0-86ce-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 363ade0e-3ee5-11f0-86ce-005056aba152;
	Sun, 01 Jun 2025 14:37:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=TZLzQpF3Bh71q9MMH838sj0CHxNgIryOcCakwjW/1BI=;
	b=Em4MUJf500nCi9fMvl2Swmrven3e584f/2Xnt18fL4rg8NHkqUqIgdpT8NexMv8XgZJIjWjj1TJFE
	 xlwAyfeJguECiQtZ8w8h8VRXp/3MWAFZe4g5sii3OjreH81VZsMPG1UkdspzDO3FZzzLHoT2qxSqlX
	 zegAefvF1Qtz/ZHI=
X-KPN-MID: 33|S4Dyray4ayjkLngBYoMyeI+eW3Jrni5xZSDKH66LmSiWKi4eApMwRwNV5Hgams2
 jcAVAstQDrySOK0GrJ0y/L3tZyc/+ceNwlMqLw/b4o6k=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|BoiFawkXQHC0qEmFyZWYXfLX5MHGBEURCynuXrXpItzuOfpFZa6b3Mz1QFcgtbk
 rnLXyXl1tJSYdt0QthaPeoA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 127ff58e-3ee5-11f0-859d-005056ab7584;
	Sun, 01 Jun 2025 14:36:42 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: linux-ext4@vger.kernel.org
Subject: [PATCH 2/2] e2freefrag: correct a mistyped symbol name
Date: Sun,  1 Jun 2025 14:36:24 +0200
Message-ID: <20250601123624.16583-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250601123624.16583-1-bensberg@telfort.nl>
References: <20250601123624.16583-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem existed since commit 0c675a67c5 from last week.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc/e2freefrag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/e2freefrag.c b/misc/e2freefrag.c
index 7e095bec..9ed7d85d 100644
--- a/misc/e2freefrag.c
+++ b/misc/e2freefrag.c
@@ -397,7 +397,7 @@ int main(int argc, char *argv[])
 				fprintf(stderr, "%s: bad chunk size '%s'\n",
 					progname, optarg);
 				usage(progname);
-#ifdef DEBUFS
+#ifdef DEBUGFS
 				return;
 #endif
 			}
-- 
2.48.1


