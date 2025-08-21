Return-Path: <linux-ext4+bounces-9525-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDDBB30691
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0ED56049E1
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A30373F8D;
	Thu, 21 Aug 2025 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ONDchD72"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1838D7FB
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807654; cv=none; b=OWfQlkMg8lQQRcB+UkyHHsNTWy4lh5gj92AaUA3qBSKUnU8b88a06bMY6rNqtBOC8cclO+xY/TDlsh7evvgyUNTChtQKxj70HsysTqaqh6Qyg7ywHF65YMc9nkgdXATj4b+RM47AE2PqQrV9uSAGYhZJVYeQcg+5yMOd3PL8+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807654; c=relaxed/simple;
	bh=/SD0GMQ7Z7lFaGRylxaKZKlYwNeii2yE86zZo8Sf7zY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyDxKCAX2Lqw2RMCzT5obwaq3qQJ447XexXRvKwMtEVL5+tyWrE6X9+zW14vE7eATwD7Si8Jvi4DbPK30kkI7Kk5RlX3clYe9ZZCdS1HuWTrrdQUUQubxyO4kVoIOIbVjLCOwG43SrYedokQUccRxFLZ++8ZSXPVQGY35zRbDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ONDchD72; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e94fc015d77so1481598276.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807651; x=1756412451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOMZ4zNNq1s5cON6tAf/wq9yALNeNe8lvhj+xp/yDeY=;
        b=ONDchD72W2DwN1FJdIE+SLzJAyAdGWwOzGuSG/IW4cVZAiN6IqrX5RMpnL/NTAGSK8
         wGlw9hG4pGobJJTyA6r6oVoC1zeB91GQsbdcyMO833NytI+hjCx64gUtVhtSrHq2vwfq
         YqQOsklf84SU5aepheB22LjL+sg0x/a1FCx15YrhUd7LO72w3ixGFEtLRnPVJQWY8MvM
         VK9/xCCadbCJBEePzm3zyrqlolYWJpT8BXOvM9Ddn7jK7w3vpNzTMfaHSUlER2cFLSOV
         Kc0GmNtGT4AodvEoRbTM4GPcAv2JlGBIBSd912getd0eJdCbkwRDO/uKMOWjHuxNkmJP
         RB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807651; x=1756412451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOMZ4zNNq1s5cON6tAf/wq9yALNeNe8lvhj+xp/yDeY=;
        b=gt28xFru6ptZ0QD/XNkUXyf9o8XN5TJrPmWBQP+g0ub/Hjv8U60FnZkCEhYU4O9LQg
         d1v2Wvz+arpLBU1rRq0iurTg4JF9AH6NAhQryPe5OlUXZYVIwfS3l9rWgiHQfnhD+fQ2
         y8Ot4ZLXsIp1a/qK2XPHu2sQfTEx92jF3V9A1TBizQljvI9u7SjglVE1/us371EE80n4
         4yqb7drvIs3s+5J0UIi1+tHZyc1OimtAyTkAvZKnFjVI7mjb34iTo5V1dLWqSqy0J7u2
         w1VIGoh7RPrELGFNGn4cCSWkqmX2hCSdOLPf1neVftqqzn8lLqHC8vGI4tz/9qZ0ALGf
         jfOA==
X-Forwarded-Encrypted: i=1; AJvYcCW5szgUo4m3H4pWiFMujiHhZsU50E0GMvycuoUKodsVW1YO54efiL/nVKuhxVFDcYkWock60jF/zfOi@vger.kernel.org
X-Gm-Message-State: AOJu0YwkvGg7HxQsMkoZPOQvAhcI5zeQtZaz+cQgrI3nGViH1n00EPTI
	c6kfio4T+NHchrdNGzojqakX9Bo1tZeTQSMPPn92P7DKCpECtLYdFr0nak3ghUt+g4c=
X-Gm-Gg: ASbGncuztaD36W0UuvppJ8+tDqdVV88EDxAWuORCE97VCsCLpTSU39/PZ0NDnp35ckS
	9S75wyRdd22/mi4mMPU/ZimD4/OhCLr+qcZmZOqbDLmMlqOuHbOPz876yhthZJ0aooNWdp2vsKw
	hOCuAn9p5VWgp27psR4/M5DNYSMwMQC1oqF2nSS1lGs5bjZMnyug3tdMP6QtIcNvaDPRle+hvEd
	1Z2J5v0XLA8GMMigEvHqWulvqBkTrDoGHyXqJbaKxZQRFhFauaw8VfPlMrsbAHL9ZtbThRUPfmN
	Ebo/lUpR0OdnG31wQ6Sc+zbBD0rGR142t818W+Fxrau51qm9H/WXvR0JuW5My3CERNE3LJJL+4K
	ViIHWntZsrlR0fP3PK5k+jnWo3dJbZqu4UL7bNJsaK121XaTXcDekFJqmhtlw4TWsQMeiyscSDs
	C0/BZE
X-Google-Smtp-Source: AGHT+IE6HvsxjPwCyB/oWd9nkC+GiXEkxClQFs1S1ZRPTLNR+IPSUbRvRPeUbjnnpHHrMVPQxbBM3g==
X-Received: by 2002:a05:6902:2b89:b0:e94:e1e3:efc8 with SMTP id 3f1490d57ef6-e951c2eac87mr904774276.53.1755807651484;
        Thu, 21 Aug 2025 13:20:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94f14d53cbsm2423258276.26.2025.08.21.13.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 24/50] fs: use igrab in insert_inode_locked
Date: Thu, 21 Aug 2025 16:18:35 -0400
Message-ID: <b4aa91a69d006ade6afc9acee6fbd2192cd186d4.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the same pattern in find_inode*. Instead of checking for
I_WILL_FREE|I_FREEING simply call igrab() and if it succeeds we're done.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 63ccd32fa221..6b772b9883ec 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1899,11 +1899,8 @@ int insert_inode_locked(struct inode *inode)
 				continue;
 			if (old->i_sb != sb)
 				continue;
-			spin_lock(&old->i_lock);
-			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
-				spin_unlock(&old->i_lock);
+			if (!igrab(old))
 				continue;
-			}
 			break;
 		}
 		if (likely(!old)) {
@@ -1915,12 +1912,13 @@ int insert_inode_locked(struct inode *inode)
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
+		spin_lock(&old->i_lock);
 		if (unlikely(old->i_state & I_CREATING)) {
 			spin_unlock(&old->i_lock);
 			spin_unlock(&inode_hash_lock);
+			iput(old);
 			return -EBUSY;
 		}
-		__iget(old);
 		spin_unlock(&old->i_lock);
 		spin_unlock(&inode_hash_lock);
 		wait_on_inode(old);
-- 
2.49.0


