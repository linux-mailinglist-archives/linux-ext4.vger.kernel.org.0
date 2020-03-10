Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C271800F9
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Mar 2020 16:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCJPCI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Mar 2020 11:02:08 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:45482 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726295AbgCJPCH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Mar 2020 11:02:07 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 0CF862E1497;
        Tue, 10 Mar 2020 18:02:05 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id mFQyHLN6eK-23k46thl;
        Tue, 10 Mar 2020 18:02:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1583852524; bh=Feen9PWQJXnrtetun+BGBQDWZlOnNeskcbh9mD4M6uw=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=coToy5GPWCOkM7TTGEcaI6BCjU4MLyUTY0ODRZWr4vDx2IEZ3f0r4aM9OyWG0XEaK
         2NkTvo1gLz0oDM2/zjtIXKgmYV1cPsncHNbYRTXcbeGObV47gSVv9Ms9Wj7g9Zor3f
         F0X2ckjSpbzopgbSg+sCG8lYZiRYkYP/ulMatELY=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id DnDE2BLoMZ-23V4BbiU;
        Tue, 10 Mar 2020 18:02:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Dmitry Monakhov <dmonakhov@gmail.com>
Subject: [PATCH] ext4: mark block bitmap corrupted when found instead of BUGON
Date:   Tue, 10 Mar 2020 15:01:56 +0000
Message-Id: <20200310150156.641-1-dmonakhov@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We already has similar code in ext4_mb_complex_scan_group(), but
ext4_mb_simple_scan_group() still affected.

Other reports: https://www.spinics.net/lists/linux-ext4/msg60231.html

Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
---
 fs/ext4/mballoc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1027e01..97cd1a2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1901,8 +1901,15 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 		BUG_ON(buddy == NULL);
 
 		k = mb_find_next_zero_bit(buddy, max, 0);
-		BUG_ON(k >= max);
-
+		if (k >= max) {
+			ext4_grp_locked_error(ac->ac_sb, e4b->bd_group, 0, 0,
+				"%d free clusters of order %d. But found 0",
+				grp->bb_counters[i], i);
+			ext4_mark_group_bitmap_corrupted(ac->ac_sb,
+					 e4b->bd_group,
+					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+			break;
+		}
 		ac->ac_found++;
 
 		ac->ac_b_ex.fe_len = 1 << i;
-- 
2.7.4

