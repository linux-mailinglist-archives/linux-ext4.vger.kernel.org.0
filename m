Return-Path: <linux-ext4+bounces-7882-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD86AB6C35
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 15:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B1B3B85FF
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9E276038;
	Wed, 14 May 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwxsP7Jm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8727A455;
	Wed, 14 May 2025 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228168; cv=none; b=Tg9u55F2odFAAsPsAGa6FrdOzIrfOQr63Ad6Z4feg/1Z4DbFly3wUC0GS2Ads5899myHkirUN9gXVYKDzzAZwf7smnTCJyTWLWDa4V1PYleoOR2gVQWH3w3ucmiSV2iuG3fNZxc9uFw6XZcthazA+OijJttfZUZo3fDHe3eo0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228168; c=relaxed/simple;
	bh=zeD8unXVnMUvwwF3GajVSv3NzHyHRhKQAwJ7usN+htk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/asDtqhky3N0FD40Mxb3vjToy6KnK0O6dpEYP2LqA0fCX9gAFgNZabcDX2JydojwJiV8R3EhNpQsToaMlOPdIDuYerXRmR41yQFZaBmHbF1PN3ZgCA+z3RXJ6D9ViLpJGH2IruUm/jyyagRxn//VvebCQf/Yfn+ZDl7o/pFf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwxsP7Jm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74019695377so5038277b3a.3;
        Wed, 14 May 2025 06:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747228166; x=1747832966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny7IJUDWkdRyrhuT9oc4WLLYxl4iVGqYTbLsxT55JRw=;
        b=iwxsP7Jm6xeen/+vFV3d2iJ1jJ/G08BsXwkfnxCr9GpNBMm1ALQl4EazncWCiT+bZt
         dh+zlTC/WEkj+mivoidQSke5dOMAXUG7DmMXlgsPsIX9uKOlzfWAluDsUQL/ASzSZJZx
         Ae6DlgIBYexkqU7bWrdf+d/0AJ+dhfDKJs9B6rgOdWa9K8HwfmiZ6Ra1hi95NoR91sDQ
         mJeIn/c8rvJ4Trqt962AfrC+bPl1XORaHdJYYJvQK8mhpOEnpOTBUzpfTkGrxWIVftn4
         OGdTcPOotDvXDwfolPaBi1mgpa6GIz7SCjEh8vs7dGsw56qrifvotoeDImTnHKrABtc3
         7neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747228166; x=1747832966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ny7IJUDWkdRyrhuT9oc4WLLYxl4iVGqYTbLsxT55JRw=;
        b=odwSOMUijAE7438oXIMU3RE61CvHtwF58syNlz8YU6lmjVKXyufvgsGuLxpnux/NPA
         lOGyVpzG3LTNajHQvMSE9chc21+uXe6bTCb/2q49EufZPaOBWbui8mH6qowqA7xGMqSr
         qdba6F6hhO1gmyvRYpSsSJRswCRCozsgWu5e93FbvayedYENglCwA8oRqoRdo3hXSO4s
         SzdBpzK1l8SnmQyCYHkhycyOEAxZt4Py4bnrcpDixYBNkGkxiloHrljIXfLCvSBjqTQz
         gsj2xnGv4IDN2dLYmc2t+Fmr3VZbzjsTCqk8cGpBBuh+DnMPltJKzTkmk6j+Zt1xF5TC
         gbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaFHFBiwLrHZOfdiNDqOW1p/fmTc1knqOb5r4s77FQBceBkBPO4WeYGJdPsZHKiq342hIIkHH9PSm2soY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZHAhSpm5XMwAMLhYJGNy84rBugv9wPNOfl+bo7mAi3l7Gppz
	0oFeN3pa0mN9JrrOWeLDeCcTvlQ5vPsHzB8uqgo4QYL4YTvKt+vc
X-Gm-Gg: ASbGncuu6DvdVt3jfD4GRribVXdg/tv5LdaYr7/bd4ihG4hZqK5jh7eGkNE5Kcw7JDm
	JqsxMQ708Jx+lX/8JID/FIgWFmF6Gu0zc1iIcRcWL0pgNvx7f1wwQRamZ0vCEZuOXb3h/flLTAM
	sJ1zfgtQjWuJjTl7O/1kXK4sb3ONwLEVnYzqEVLTJgi/eHWX18PRPlHG7XHNU3IT+P10JcLvftc
	nmzVDTS9OEI3tRbzk+JlcIdo/lN325O507qVe5tgBTwIs2U6oRwEqCtBLVSs++fz6jVo6qmFPg8
	LLNXKK+uOCDePzo2BSY69B3Rtxl6xy0BdeeWTCOFiRvkY1/wzbHuJwlX8lUkPrJ4
X-Google-Smtp-Source: AGHT+IHarGSfq8DTpiGk2i6P06np/kn23owSm18E/NQdeaxxSTuaZVzr+43mg9RGVy/dZcIsmD+ZXQ==
X-Received: by 2002:a05:6a00:ccc:b0:736:4ebd:e5a with SMTP id d2e1a72fcca58-7428936af7fmr5175222b3a.20.1747228166160;
        Wed, 14 May 2025 06:09:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:e60:a413:5fa1:d8a8:267:bf52:3c78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74283586d57sm2407646b3a.116.2025.05.14.06.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 06:09:25 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: tytso@mit.edu,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
Date: Wed, 14 May 2025 22:08:55 +0900
Message-ID: <20250514130855.99010-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since handle->h_transaction may be a NULL pointer, so we should change it
to call is_handle_aborted(handle) first before dereferencing it.

And the following data-race was reported in my fuzzer:

==================================================================
BUG: KCSAN: data-race in jbd2_journal_dirty_metadata / jbd2_journal_dirty_metadata

write to 0xffff888011024104 of 4 bytes by task 10881 on cpu 1:
 jbd2_journal_dirty_metadata+0x2a5/0x770 fs/jbd2/transaction.c:1556
 __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
 ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
 ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
 __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
 ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
....

read to 0xffff888011024104 of 4 bytes by task 10880 on cpu 0:
 jbd2_journal_dirty_metadata+0xf2/0x770 fs/jbd2/transaction.c:1512
 __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
 ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
 ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
 __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
 ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
....

value changed: 0x00000000 -> 0x00000001
==================================================================

This issue is caused by missing data-race annotation for jh->b_modified.
Therefore, the missing annotation needs to be added.

Reported-by: syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=de24c3fe3c4091051710
Fixes: 6e06ae88edae ("jbd2: speedup jbd2_journal_dirty_metadata()")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
v2: Changed to annotate jh->b_modified to avoid performance overhead
- Link to v1: https://lore.kernel.org/all/20250513170441.54658-1-aha310510@gmail.com/
---
 fs/jbd2/transaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cbc4785462f5..c7867139af69 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1509,7 +1509,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 				jh->b_next_transaction == transaction);
 		spin_unlock(&jh->b_state_lock);
 	}
-	if (jh->b_modified == 1) {
+	if (data_race(jh->b_modified == 1)) {
 		/* If it's in our transaction it must be in BJ_Metadata list. */
 		if (data_race(jh->b_transaction == transaction &&
 		    jh->b_jlist != BJ_Metadata)) {
@@ -1528,7 +1528,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out;
 	}
 
-	journal = transaction->t_journal;
 	spin_lock(&jh->b_state_lock);
 
 	if (is_handle_aborted(handle)) {
@@ -1543,6 +1542,8 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out_unlock_bh;
 	}
 
+	journal = transaction->t_journal;
+
 	if (jh->b_modified == 0) {
 		/*
 		 * This buffer's got modified and becoming part
--

