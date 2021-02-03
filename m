Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F8730DB93
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Feb 2021 14:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhBCNol (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Feb 2021 08:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhBCNog (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Feb 2021 08:44:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117E2C0613D6;
        Wed,  3 Feb 2021 05:43:56 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id v24so33380788lfr.7;
        Wed, 03 Feb 2021 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQe27HJA3SKQ/BJnULM2ot5ob2yy3uy3UEjOcwGN3a8=;
        b=seDQHK72t1flgxVqKrug/jRCVZBoDe42wc4rnVSIBqaBHZh7A5fAs+3VeBxI0t0Iz4
         Oaxjj3NTPHGe5XkQirAfK7VKb58RXbgVG0Ls1lc6H1yCYDWn8BXJFlORgxQO5Rlt/VCh
         1lGHuOddOQTXrVsI0zJSk4VO81SKu5I3EcmZp7VG+x2UXBIBgnqsYVsS7F7H1GnodPAd
         4Or5Kotbq08uLBkJVGrKRrf+g5rfmptoOK0nRWQEvLTKuS5Nfp3eAhZB4L0+leEuTITU
         o3NXFbGicqAUxBTEZW+pCvEHXBRmLWen1kq0TB+uTm1HZ/CLM48G/IewGisTVIgrtqPd
         VRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQe27HJA3SKQ/BJnULM2ot5ob2yy3uy3UEjOcwGN3a8=;
        b=YPRGWjS2SObCcnUfq9f75RzK36QqZcnnUS4N3UCYVSW+aP+fE+R6HCT0K//LjZsjBD
         NDu4BcUiEzcJ6MRS+S61pw0fyKcR3SAWMaGK+iuTj/5iUarsS1BZGkAl/gEm57ejDWXK
         F3r6PLaZeB1ZTztYwmKfAecKwS0GGEkYmMc0cLA6cYwHM3EGXmwI8ImdDcYkiy7pW3M1
         C0SVxUwVAqfSBM6pjcUX9Tt2x/7/Gqki+Ux475/B1la1oySpv3RcJCCFJNCblxxDCmvy
         Xo82XxsS2OYuAFkiPjdl8eaPf0pqqY01p7Laqk9hi4H9xuxrq3helFv8H5mGxBEfoKqt
         FiMw==
X-Gm-Message-State: AOAM531DvFzIK9+edFzS1vLVlfOtwUcwKBtKQ+1U6pVihKqMoldPkYf+
        ipocVOz4DrUy9f8zMqWmvCbsiHzXZx3FTmJL
X-Google-Smtp-Source: ABdhPJxf18draKWPxbuCjIpuGIBYIUfo52UzzGOa0rEBmPqW7d/ZX8iX5myFO3Yz1cdEmUWTvhl3Kw==
X-Received: by 2002:ac2:5d69:: with SMTP id h9mr1707491lft.576.1612359834585;
        Wed, 03 Feb 2021 05:43:54 -0800 (PST)
Received: from localhost.localdomain ([146.158.65.228])
        by smtp.googlemail.com with ESMTPSA id z23sm259875ljj.25.2021.02.03.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 05:43:53 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+a8b4b0c60155e87e9484@syzkaller.appspotmail.com
Subject: [PATCH] fs/ext4: fix integer overflow in s_log_groups_per_flex
Date:   Wed,  3 Feb 2021 19:43:51 +0600
Message-Id: <20210203134351.1697508-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
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

if (1 << sbi->s_es->s_log_groups_per_flex > UINT_MAX) {

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
 fs/ext4/mballoc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 99bf091fee10..e1e7ffbba1a6 100644
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
+		if (sbi->s_es->s_log_groups_per_flex > 32) {
+			ext4_msg(sb, KERN_ERR, "too many log groups per flexible block group");
+			goto err_freesgi;
+		}
+		sbi->s_mb_prefetch = min_t(uint, 1 << sbi->s_es->s_log_groups_per_flex,
 			BLK_MAX_SEGMENT_SIZE >> (sb->s_blocksize_bits - 9));
 		sbi->s_mb_prefetch *= 8; /* 8 prefetch IOs in flight at most */
 	} else {
-- 
2.25.1

