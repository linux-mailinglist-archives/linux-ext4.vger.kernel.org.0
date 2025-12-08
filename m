Return-Path: <linux-ext4+bounces-12227-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE4CAC80F
	for <lists+linux-ext4@lfdr.de>; Mon, 08 Dec 2025 09:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE1EA30173AF
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Dec 2025 08:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836C326CE3F;
	Mon,  8 Dec 2025 08:32:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358AF221540;
	Mon,  8 Dec 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765182773; cv=none; b=BgI46esGVU+MVnOuVoo1p08GTf0LN9DOnsKo+T6gOJAxPL2G2YKme+cvL53XgFE7V03jOAF7MfDwtsK7VoTypiydONycJH539xCiYG0viOC+5jDT9+8U3hhR8Hcp6NyKfe/ot/+o3ctf4ST5hlYg92tsCCgc8WhrAy6Mz/o7TjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765182773; c=relaxed/simple;
	bh=uqex7jWNv/IVQhMmzlDWeAHV+HGDloKmgPRqAquGj7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXNAPtUn5o/rfBNM77exG4jNpNROPPU3PEzrGx0FmwJa5TZYUlW4Mjk3lvp0LiXsJk5ZlLekwQBo6okWfLYiJccXPwAk+O38DxDpKd3lmiCAVqycO1Z54DI2YLEPUdf2srlzzcXkpY51k7RBZetLnlHk6OYyOoPsWDk9V2PsB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A88C4CEF1;
	Mon,  8 Dec 2025 08:32:51 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yukuai@fnnas.com
Subject: [PATCH 2/2] ext4: align preallocation size to stripe width
Date: Mon,  8 Dec 2025 16:32:46 +0800
Message-ID: <20251208083246.320965-3-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208083246.320965-1-yukuai@fnnas.com>
References: <20251208083246.320965-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When stripe width (io_opt) is configured, align the predicted
preallocation size to stripe boundaries. This ensures optimal I/O
performance on RAID and other striped storage devices by avoiding
partial stripe operations.

The current implementation uses hardcoded size predictions (16KB, 32KB,
64KB, etc.) that are not stripe-aware. This causes physical block
offsets on disk to be misaligned to stripe boundaries, leading to
read-modify-write penalties on RAID arrays and reduced performance.

This patch makes size prediction stripe-aware by using multiples of
stripe size (1x, 2x, 4x, 8x, 16x, 32x) when s_stripe is set.
Additionally, the start offset is aligned to stripe boundaries using
rounddown(), which works correctly for both power-of-2 and non-power-of-2
stripe sizes. For devices without stripe configuration, the original
behavior is preserved.

The predicted size is limited to max free chunk size (2 << bsbits) to
ensure reasonable allocation requests, with the limit rounded down to
maintain stripe alignment.

Test case:
  Device: 32-disk RAID5, 64KB chunk size
  Stripe: 496 blocks (31 data disks × 16 blocks/disk)

  Before patch (misaligned physical offsets):
    ext:  logical_offset:  physical_offset: length:
      0:        0.. 63487:      34816.. 98303:  63488
      1:    63488..126975:     100352..163839:  63488
      2:   126976..190463:     165888..229375:  63488
      3:   190464..253951:     231424..294911:  63488
      4:   253952..262143:     296960..305151:   8192

    Physical offsets: 34816 % 496 = 96 (misaligned)
                     100352 % 496 = 160 (misaligned)
                     165888 % 496 = 224 (misaligned)
    → Causes partial stripe writes on RAID

  After patch (aligned physical offsets):
    ext:  logical_offset:  physical_offset: length:
      0:        0.. 17855:       9920.. 27775:  17856
      1:    17856.. 42159:      34224.. 58527:  24304
      2:    42160.. 73407:      65968.. 97215:  31248
      3:    73408.. 97711:      99696..123999:  24304
      ... (all extents aligned until EOF)

    Physical offsets: 9920 % 496 = 0 (aligned)
                     34224 % 496 = 0 (aligned)
                     65968 % 496 = 0 (aligned)
    Extent lengths: 17856=496×36, 24304=496×49, 31248=496×63
    → Optimal RAID performance, no partial stripe writes

Benefits:
- Eliminates read-modify-write operations on RAID arrays
- Improves sequential write performance on striped devices
- Maintains proper alignment throughout file lifetime
- Works with any stripe size (power-of-2 or not)

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 fs/ext4/mballoc.c | 60 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index eb46a4f5fb4f..dbd0b239cc96 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4500,7 +4500,10 @@ static inline bool ext4_mb_check_size(loff_t req, loff_t size,
 
 /*
  * Predict file size for preallocation. Returns the predicted size
- * in bytes and sets start_off if alignment is needed for large files.
+ * in bytes. When stripe width (io_opt) is configured, returns sizes
+ * that are multiples of stripe for optimal RAID performance.
+ *
+ * Sets start_off if alignment is needed for large files.
  */
 static loff_t ext4_mb_predict_file_size(struct ext4_sb_info *sbi,
 					struct ext4_allocation_context *ac,
@@ -4511,6 +4514,59 @@ static loff_t ext4_mb_predict_file_size(struct ext4_sb_info *sbi,
 
 	*start_off = 0;
 
+	/*
+	 * For RAID/striped devices, align preallocation size to stripe
+	 * width (io_opt) for optimal I/O performance. Use power-of-2
+	 * multiples of stripe size for size prediction.
+	 */
+	if (sbi->s_stripe) {
+		loff_t stripe_bytes = (loff_t)sbi->s_stripe << bsbits;
+		loff_t max_size = (loff_t)max << bsbits;
+
+		/*
+		 * TODO: If stripe is larger than max chunk size, we can't
+		 * do stripe-aligned allocation. Fall back to traditional
+		 * size prediction. This can happen with very large stripe
+		 * configurations on small block sizes.
+		 */
+		if (stripe_bytes > max_size)
+			goto no_stripe;
+
+		if (size <= stripe_bytes) {
+			size = stripe_bytes;
+		} else if (size <= stripe_bytes * 2) {
+			size = stripe_bytes * 2;
+		} else if (size <= stripe_bytes * 4) {
+			size = stripe_bytes * 4;
+		} else if (size <= stripe_bytes * 8) {
+			size = stripe_bytes * 8;
+		} else if (size <= stripe_bytes * 16) {
+			size = stripe_bytes * 16;
+		} else if (size <= stripe_bytes * 32) {
+			size = stripe_bytes * 32;
+		} else {
+			size = roundup(size, stripe_bytes);
+		}
+
+		/*
+		 * Limit size to max free chunk size, rounded down to
+		 * stripe alignment.
+		 */
+		if (size > max_size)
+			size = rounddown(max_size, stripe_bytes);
+
+		/*
+		 * Align start offset to stripe boundary for large allocations
+		 * to ensure both start and size are stripe-aligned.
+		 */
+		*start_off = rounddown((loff_t)ac->ac_o_ex.fe_logical << bsbits,
+				       stripe_bytes);
+
+		return size;
+	}
+
+no_stripe:
+	/* No stripe: use traditional hardcoded size prediction */
 	if (size <= 16 * 1024) {
 		size = 16 * 1024;
 	} else if (size <= 32 * 1024) {
@@ -4556,7 +4612,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_super_block *es = sbi->s_es;
-	int bsbits, max;
+	int bsbits;
 	loff_t size, start_off = 0, end;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
-- 
2.51.0


