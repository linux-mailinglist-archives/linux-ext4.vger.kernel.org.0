Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3451B323A0F
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Feb 2021 10:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhBXJ7B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Feb 2021 04:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhBXJ6q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Feb 2021 04:58:46 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B67C06178A;
        Wed, 24 Feb 2021 01:58:05 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u4so1701315ljh.6;
        Wed, 24 Feb 2021 01:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=16S2vm4wQ2IbRIOxoNNSW+kBc6NWYn4yeVHfBztHcWo=;
        b=LUoeD/F3Lo6PadAq3VNHNqMMYlBtncEGy9/8znErhbvHz+Bru0Acsa3E5i3HFguV3B
         dpp4IGwKwzjFaQzsg/yhEXWukt3fdakSNmbal++swXNMpUHvdTwFvHRByIT11uRZ7YHR
         6bTRuIZP99pf43VlZ60QbAO4FUrRvWAvJWn3v1XZQHqU5D6evvUDD5LVXYpwjy+OJbd0
         xY3yQOzTdu+bY5kTMXEDKIOEJQOgp0BUbPZEvZ0uV89GLrzRZ9xRqMxWA0k8/3PV6Q8P
         5YnkrGNcFh2mNGvuA0sgBjJ5re0bKvbeMOgS4/YKgGWA67+admJyftHkavW2QlnWC1an
         U5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=16S2vm4wQ2IbRIOxoNNSW+kBc6NWYn4yeVHfBztHcWo=;
        b=r+axUKdv5ENW0TuRIE9c38cmandKyd5jnQqwJcKzRhYPgIV3nsmLRlpOP1S/JIqDH0
         8HLsXbwk5gbooykZC/03KpUYy/8oIPZFZPFnqSloSlveJNt5kcQ4AuAUs7+aGTx8Sfw6
         kXajcEotkH5oYSNnaytgj9ALyH7iMc2f7PQD1ZB9JZ6kpRzfs2PcCgCJC2/+1P8iHpF/
         KqMlTsHiqVUlSna1IwIqTnfQlKuZB26CWbpB78lnf70ZlXxZRE2cvUrFlWXC/lLUp4If
         9TyIrRhgJn0dU/lHFmj/yafjFRQYnrt+yZrXyn5C0cMQtGQipyRSuC2x68BTErVkgpW3
         4dVg==
X-Gm-Message-State: AOAM533oonI80r+Bi7IBzUGOmm7P2AU97uS+/cIDrRANuXopJo7aEGmK
        Eq27pqy2Zl6o8gGiIgrVAos=
X-Google-Smtp-Source: ABdhPJzcrjZ0sAHN6x3QnQwig4P/dTLiGpKycsbM11Cmy+UFaz5kYbCa4OhnLNgyAhJrNeRZC7S0hw==
X-Received: by 2002:a05:651c:1351:: with SMTP id j17mr19049387ljb.241.1614160684280;
        Wed, 24 Feb 2021 01:58:04 -0800 (PST)
Received: from localhost.localdomain ([146.158.65.227])
        by smtp.googlemail.com with ESMTPSA id k27sm379234lfm.125.2021.02.24.01.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 01:58:03 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     jack@suse.cz
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, snovitoll@gmail.com,
        syzbot+a8b4b0c60155e87e9484@syzkaller.appspotmail.com,
        tytso@mit.edu
Subject: [PATCH v2] fs/ext4: fix integer overflow in s_log_groups_per_flex
Date:   Wed, 24 Feb 2021 15:58:00 +0600
Message-Id: <20210224095800.3350002-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223170118.GD30433@quack2.suse.cz>
References: <20210223170118.GD30433@quack2.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot found UBSAN: shift-out-of-bounds in ext4_mb_init [1], when
1 << sbi->s_es->s_log_groups_per_flex is bigger than UINT_MAX,
where sbi->s_mb_prefetch is unsigned integer type.

32 is the maximum allowed power of s_log_groups_per_flex. Following if
check will also trigger UBSAN shift-out-of-bound:

if (1 << sbi->s_es->s_log_groups_per_flex >= UINT_MAX) {

So I'm checking it against the raw number, perhaps there is another way
to calculate UINT_MAX max power. Also use min_t as to make sure it's
uint type.

[1] UBSAN: shift-out-of-bounds in fs/ext4/mballoc.c:2713:24
shift exponent 60 is too large for 32-bit type 'int'
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x137/0x1be lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:148 [inline]
 __ubsan_handle_shift_out_of_bounds+0x432/0x4d0 lib/ubsan.c:395
 ext4_mb_init_backend fs/ext4/mballoc.c:2713 [inline]
 ext4_mb_init+0x19bc/0x19f0 fs/ext4/mballoc.c:2898
 ext4_fill_super+0xc2ec/0xfbe0 fs/ext4/super.c:4983

Reported-by: syzbot+a8b4b0c60155e87e9484@syzkaller.appspotmail.com
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
v2: updated > 32 condition to >= 32

> > +		if (sbi->s_es->s_log_groups_per_flex > 32) {
> 						    ^^ >= 32?
> 
> Otherwise the patch looks good.
> 

Thanks! Updated to >= 32 condition.
---
 fs/ext4/mballoc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 99bf091fee10..a02fadf4fc84 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2709,8 +2709,15 @@ static int ext4_mb_init_backend(struct super_block *sb)
 	}
 
 	if (ext4_has_feature_flex_bg(sb)) {
-		/* a single flex group is supposed to be read by a single IO */
-		sbi->s_mb_prefetch = min(1 << sbi->s_es->s_log_groups_per_flex,
+		/* a single flex group is supposed to be read by a single IO.
+		 * 2 ^ s_log_groups_per_flex != UINT_MAX as s_mb_prefetch is
+		 * unsigned integer, so the maximum shift is 32.
+		 */
+		if (sbi->s_es->s_log_groups_per_flex >= 32) {
+			ext4_msg(sb, KERN_ERR, "too many log groups per flexible block group");
+			goto err_freesgi;
+		}
+		sbi->s_mb_prefetch = min_t(uint, 1 << sbi->s_es->s_log_groups_per_flex,
 			BLK_MAX_SEGMENT_SIZE >> (sb->s_blocksize_bits - 9));
 		sbi->s_mb_prefetch *= 8; /* 8 prefetch IOs in flight at most */
 	} else {
-- 
2.25.1

