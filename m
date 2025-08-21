Return-Path: <linux-ext4+bounces-9539-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B87FB306D2
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F79AE5443
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2CC39096A;
	Thu, 21 Aug 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Noh6+6O1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77937440D
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807676; cv=none; b=m4izYNPAesMrVCblDQBADHAedo88ZCCL2YLuIVmE1WMxhNeGx5V5cRXCUS/2jTAYkPnmZwlOEXFzbjn8e0a6tcfxN5QkWsgOxxENL80u5GS5xJvRfHTsDWLdspqceb0dTSw6ShwKYQcfXYfIHN1K+43Smt8R+edLkVqhqiGUMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807676; c=relaxed/simple;
	bh=ncJFwZEJnrUj8IpeTHtrl/YVsygglgXTHVy3Yq69xu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXd5v7nxaotWySR26HRVxmTJVSxZXmHqn8yCK1P7jJ1HFlWbtzvRCDpUJvbHjIbMmY6OT2P9PhHFVr/6eucwJ7TPGjt5f/0SehzRbhj00quelRhL4VNZSOiGIw4f/HjVqUpJbeHiaJ0Thu7usBzJ0WBKqRqgNBbTKZoKna9vMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Noh6+6O1; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d71bcac45so12465017b3.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807674; x=1756412474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g58GglhqUUo58s59oHZ910JXpBoXdBxDvcz31WoZTlM=;
        b=Noh6+6O1VBrZag18/Jsw752jC+t2WdDij1ILyT2rRFYsHyJGGN69lGgbCytGxMavtr
         8PVJJOo1qBT5zfZ8d8V4mT/P9JlxUjEpBr/T8Kp2bgvLFm/cFrBhQLYmq77NGUon/G8i
         NV92sSUbhdJFoNO2kTnAApAn7uU1nhUhXKZ8UOcK6JT2suOfRFPdZ99SnS2KgOrgmrTd
         CGl9qjbIhnNwpA/ZnYZyE/SxBFipPIvMLgNB4AhpP1lCkMfQKpIl+G0WdCVMvoJvgfO+
         u25zDuXIF974jlrCUrkp5w865xNa5zoicWgjxUtq9mvNEsUZLEz/xqCNBhfF7Nw6xPgb
         tThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807674; x=1756412474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g58GglhqUUo58s59oHZ910JXpBoXdBxDvcz31WoZTlM=;
        b=eaEn2qYBBxJyQ4YWqb+Xd4IP1OUsEa2kf7nOieH3IpNaMi65fPUO9wMvAI9gEnZ1MI
         OcFmp3WxxHEk+jc84VPWMeZ6D+APyfW5Cc/lPGniIAxjlrpWyGfuT9RP3KDS/6YLuBkf
         qF/kJSne4FM/VMfNr2rfIDgMQcyQqwp8IVOIyG71cX1/y4Z3/WWsdbi3x24rJKAhBpia
         mGDN/YyHgH3BEXmVccDDMTcb1Q7FPnEcYF9409xvnsUBK2tbxEpDRBmSVx09fzS9JpRg
         QXwcyFuUJdt2uIRlsOy68iirq8vGBAl9AYw/uz2cI3ruxU4sw6MRw1wDNBrlWl0iEDA+
         O7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCV8ell7Wxl490IEwM7rl13b2YQYDMgH0MQJgHfqapD3WYyV4ZBRgLefi4XP6X3It8Tb1mNPfYk8ENag@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDfPmf7pUjCCFjeEEHr4A8YjLh1ktiZjcwogTrCHkBTcdJ5j6
	Ta29lPGF1N4rbqPRPgo3vojWCfeLvDOlaQz94mmThszsBzgTykDTBOjD3Udu+5HGISA=
X-Gm-Gg: ASbGncsNlW945GxwBBuoKV8J3oeq2GW6GmCD7gf5xlEPgmEWU1YMugnXyRRF3jEClNp
	z5axAdOyBby+sl2I2wd+cCCn0vJy8Rycrmd/BHhxjJCDgjjt575rFDSIr0IJm/ovBGj5BfB0Gka
	XnvAJQ4WdXzmLxUUkBL7BFtX6S5rSyKImnIAyeo4yqgaown8qKGe6iRbwQUcuczp2yIpFz9j1Ut
	HY5vxQs8E/6AfILbJhXZwBMIMBLhdyTIuA+3m4OEAb7YVvVmLk/YdmzLXxARmsJsmYy33bl6Ufl
	lG3S/Hp3nCAU+m84bK1SWqooquGYHDAgOan545u44PPY4t0zvlnbcPE6YGukdZfeuoqZP1dcBAe
	Sw097XACC++8FtwJ3pIa4fSHh7RHb7AZl2h5LGEAOsyo7Cn8tdTzrHAC3f80eCkFfgOtQUw==
X-Google-Smtp-Source: AGHT+IEqiDcFpm5jVq2WLhuv9tbmk7e+a0LbMcXW6cqI1uIKhRjkqvGvdJzMtVHbr+LWKhC12dhjiA==
X-Received: by 2002:a05:690c:6702:b0:71f:b944:102a with SMTP id 00721157ae682-71fdc5389camr6706207b3.51.1755807673675;
        Thu, 21 Aug 2025 13:21:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e84367526sm34113897b3.61.2025.08.21.13.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 38/50] notify: remove I_WILL_FREE|I_FREEING checks in fsnotify_unmount_inodes
Date: Thu, 21 Aug 2025 16:18:49 -0400
Message-ID: <6fce2524c1614e400f399260b5a2bc5c10d9dacc.1755806649.git.josef@toxicpanda.com>
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

We can now just use igrab() to make sure we've got a live inode and
remove the I_WILL_FREE|I_FREEING checks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fsnotify.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 0883696f873d..25996ad2a130 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -46,33 +46,15 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		/*
-		 * We cannot __iget() an inode in state I_FREEING,
-		 * I_WILL_FREE, or I_NEW which is fine because by that point
-		 * the inode cannot have any associated watches.
-		 */
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-
-		/*
-		 * If i_count is zero, the inode cannot have any watches and
-		 * doing an __iget/iput with SB_ACTIVE clear would actually
-		 * evict all inodes with zero i_count from icache which is
-		 * unnecessarily violent and may in fact be illegal to do.
-		 * However, we should have been called /after/ evict_inodes
-		 * removed all zero refcount inodes, in any case.  Test to
-		 * be sure.
-		 */
-		if (!refcount_read(&inode->i_count)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 		iput(iput_inode);
-- 
2.49.0


