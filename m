Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777D21A9433
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 09:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393666AbgDOH03 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 03:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390602AbgDOHZv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Apr 2020 03:25:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E2DC061A0C
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 00:25:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn19so6326014pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 00:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5VgHU7jtRnhCC/czrFAYAewDkeV5MzN6GhhBv63cG/c=;
        b=CgPS/t7cuYLdbg7UMOEmKH9uGaZw0wvGVzb58LqZA9kHirfOaiNp0wrdomDyYFWrm8
         HNGnGgFgDse4X0tf82uO00Nnep8TEfiqpQuPGp+uaGmwrX5WJi9HewvQFan++QU9HP9h
         Cj8CM4Yc1GtvATKJC5Mrkbo4WiP+MsW9NnkqwafxZIW5CaG7fv6RoFl56pozvR+nvi6m
         aqAs5ObobTxa4gNCutwKryNp7WHudQUQevb6S4Y8YmGTPbKMzhmiH6R7vmGgIFIok72R
         xMkv5tMztk5wK9VDvB9gIi1Z7uJzFUJEmSrGq+YgXWD8xioPNdcVcd8Fkj+F826h+KFP
         671w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5VgHU7jtRnhCC/czrFAYAewDkeV5MzN6GhhBv63cG/c=;
        b=cfLZ/bvBfvCeFb//vQwZtIKu/kvxg8Ja2o+zQAgp8Pq9eZcMu5dnB9hrTSMZiDYYBu
         CNuouWKLC5OZgJiuPzDtSWkpYnVDpARegEJNYJvfO01jha75znAfcJAM6sjReoIf8+Kt
         ++LK7tfQH3NuOQ7vTJc/QFBN2r8lgxFU/o48KfkjfVLfM8hTcWZ6UYjPoLEP4ct1/Hg6
         dZFx4BZ4rbIoHvCxwRm/ED3lhiDpcSAWK3/i1NjCM6bssHKlcvr9qIGBIUSf+5qSwYcL
         x5Vc12RAHOjg7jhRrmGsLAjc+ntG6y9xtVKqnzK9IVElsR6kRMqqjj0c3FF8v5lLyE2N
         cYOw==
X-Gm-Message-State: AGi0PuZoiS8nvs+MdaaUvEUfXHsiEqLI1yjoiXYTgxQJGi72xVfkNQdD
        RCNyz2FfbTUULMywbSAr7o71HdU=
X-Google-Smtp-Source: APiQypJSusZrgRsxDzPz+K/usPXwpYnEnN05LFmkqB883XHngjDwGo/6uy2NZXJkwN2zjnG6qZJaIA==
X-Received: by 2002:a17:902:a40f:: with SMTP id p15mr3847702plq.154.1586935550469;
        Wed, 15 Apr 2020 00:25:50 -0700 (PDT)
Received: from he-cluster.localdomain ([67.216.221.250])
        by smtp.gmail.com with ESMTPSA id e16sm205815pgg.1.2020.04.15.00.25.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 00:25:50 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] ext4: remove redundant variable has_bigalloc in ext4_fill_super
Date:   Wed, 15 Apr 2020 15:25:42 +0800
Message-Id: <1586935542-29588-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

We can use the ext4_has_feature_bigalloc() function directly to check
bigalloc feature and the variable has_bigalloc is reduncant, so remove
it.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 fs/ext4/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 855874ea4b29..60bb3991304e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3681,7 +3681,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	int blocksize, clustersize;
 	unsigned int db_count;
 	unsigned int i;
-	int needs_recovery, has_huge_files, has_bigalloc;
+	int needs_recovery, has_huge_files;
 	__u64 blocks_count;
 	int err = 0;
 	unsigned int journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
@@ -4196,8 +4196,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	/* Handle clustersize */
 	clustersize = BLOCK_SIZE << le32_to_cpu(es->s_log_cluster_size);
-	has_bigalloc = ext4_has_feature_bigalloc(sb);
-	if (has_bigalloc) {
+	if (ext4_has_feature_bigalloc(sb)) {
 		if (clustersize < blocksize) {
 			ext4_msg(sb, KERN_ERR,
 				 "cluster size (%d) smaller than "
-- 
2.20.0

