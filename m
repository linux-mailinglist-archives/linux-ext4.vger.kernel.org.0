Return-Path: <linux-ext4+bounces-5875-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DCBA00A36
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 15:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEEA3A209E
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D7DC8FE;
	Fri,  3 Jan 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qQM+R7kU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085BC1B6CE3;
	Fri,  3 Jan 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912917; cv=none; b=BRHZqB58I/moYdv6JLchwHm61BYEsQ9GxnN+Bbsztd7DEP/ql592c0fgj9aZ987MxlP6EfwtPwgSkastfowk2LT0nBKliHCmpQNbTLe6u7y3ITeBqgdFPF8YZPAZaMrurkwHfnpNfINytDFh3nqNLQqy8aaWHH5k3vf0z2ywp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912917; c=relaxed/simple;
	bh=ZRno73Lk2Ty8S0opHivTNzfFl53OIMiLT3tzSC/C688=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY6RB6t+wnCX7Cy6dA6C49VG88yCdo0Qm9qmpZ3tWNrDg9svDuU85Wdcgpe9xYEnu2NAqFcx67EC1IbjJwL7QcFRLB4JAZdK3yOmOizda9NFBsQWPlMfEGUsqQlLvFBfV0UIuAUVPvTJyTLuKIJLiNhDT1+h1cfs7M6PCumXMNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qQM+R7kU; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id TiD9tWQAL3p3ETiEGt9jNC; Fri, 03 Jan 2025 15:00:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1735912844;
	bh=Q7/8sNe6EE+YUMiz3BwMXFn6gQr4fPPu1y7Xq24DSTo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qQM+R7kUntUm27bjnscuB4czDTZsh/deE0yB26iMb7BXl/Wn9tmlOvFlj5u7/6M+4
	 QF/sLtmbApUjGRCugm4FtaprL1XP1/WcdQGt1kGABidmRRELbiV1i2VZQ7eT0C+nv/
	 caXqebeZtTtsalMFmiOJrBMb52QlTxcP7lzEjTRHL/3GkaoBWCPa/oiyouFf6nckTs
	 c0uk4dCCRua/rHn8NBAS41YDM7KJYQuVQjgTLlKYfaQWhpsFiyRuzdzENgtAzkiqma
	 WG2/83dQFlP+VU0htC0f7oIt7QFjIwvyOUAKFj8NAsPXbPEPHukGmPsdSahM+NwkQO
	 kEFrC+VppkTjQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 03 Jan 2025 15:00:44 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 3/3] ext4: Remove some dead code in the error handling path of ext4_mb_init_cache()
Date: Fri,  3 Jan 2025 14:59:18 +0100
Message-ID: <282d130abca6fe7db5edef1922c971849397ffa9.1735912719.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <3921e725586edaca611fd3de388f917e959dc85d.1735912719.git.christophe.jaillet@wanadoo.fr>
References: <3921e725586edaca611fd3de388f917e959dc85d.1735912719.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'bh' is known to be a non-NULL value if the error handling path is called,
so there is no need to test for it.

This slighly simplifies the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 fs/ext4/mballoc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e536c0e35ca8..c22f7b8fd941 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1430,12 +1430,11 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
 	folio_mark_uptodate(folio);
 
 out:
-	if (bh) {
-		for (i = 0; i < groups_per_page; i++)
-			brelse(bh[i]);
-		if (bh != &bhs)
-			kfree(bh);
-	}
+	for (i = 0; i < groups_per_page; i++)
+		brelse(bh[i]);
+	if (bh != &bhs)
+		kfree(bh);
+
 	return err;
 }
 
-- 
2.47.1


