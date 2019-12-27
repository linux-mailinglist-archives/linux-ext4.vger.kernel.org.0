Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F047512B288
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 09:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfL0IFe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 03:05:34 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38352 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfL0IFe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Dec 2019 03:05:34 -0500
Received: by mail-pj1-f68.google.com with SMTP id l35so4595592pje.3
        for <linux-ext4@vger.kernel.org>; Fri, 27 Dec 2019 00:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2aNw/rWNe0g8RUy51f95Wet5Pp8fqZdhsDlSGq/4Gbs=;
        b=qk47EJYCZ2xZSJ/U18hu/OItoHSSygqGjm/ARuEutNbN6GoQ3U9XjESdKlN3ZD9FBU
         KaLLmkXq0gmE2FLk/cLJPRNXQus2a6Po89fA1+8wBDMCmz/2vmh/tKmh2oUuUzjTpPN0
         hRbZMtPLJBxpkKHfOH93QtKVUs2TKRRorGc8Hc/9CYL0TuR4TrDEGuxHx4TGDT7lB6MX
         2LFrCcdELIaQgiWkxNG/BVePLJ9oTSgWiGZauDTVZAGGPRyfajr/SKIDEoKTxx+g7nZz
         o09PJKckDrM9a1Jh36sS6sX9IIKdTMLSoPmMxaf47SqNdOfmDH2r++RnNaJDUDb6uwjb
         7rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2aNw/rWNe0g8RUy51f95Wet5Pp8fqZdhsDlSGq/4Gbs=;
        b=JNkqPLtBxsPcqCKeE/XGeY/WtgVi0iD3cHx+h6o3PoYPN1a6iu0eK8utK5/P9tCymH
         TURyHO+BYkgMUMPnpe3jLkxGxK8VL/edngdJ8B1QIWwZkzB6ArMQfHaEi28psMmtaM4z
         ed+HaJO4U9anBLUjyFJoz0irYpTStrURokOWvXLnrJtsFjlt8aI03aZa2WeZoZY99vj4
         estnOXSEyjzS/LWY74MAHYZTPHGERZbf1wxFNzQGpI/X/7G08G3o7AdaKE6mbvto9SKl
         z5CfVjeMyZN2eCNI5JrGf34KNDk0gHquO/RmxH30aVveITR+K7TglwUGVNcDCIxzD+TZ
         ELkA==
X-Gm-Message-State: APjAAAUj8NSwI/h7gSiJcedZm8b3lwRnsSNnYIRDgx3+hwmu5O9RDNeu
        k1S4KXVV3AYCKug9gQSX/Es=
X-Google-Smtp-Source: APXvYqyTv4hR+6HDR8yVfSf2dkIRxEl09qlu/wOp1a8emUj/wBJzbAa0TFpQ7KQ91yO5T0ysXGQLvA==
X-Received: by 2002:a17:902:d906:: with SMTP id c6mr6782343plz.137.1577433933952;
        Fri, 27 Dec 2019 00:05:33 -0800 (PST)
Received: from hpz4g4.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id 3sm37271702pfi.13.2019.12.27.00.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 00:05:33 -0800 (PST)
From:   Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 1/3] ext4: Delete ext4_kvzvalloc()
Date:   Fri, 27 Dec 2019 17:05:21 +0900
Message-Id: <20191227080523.31808-2-naoto.kobayashi4c@gmail.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
References: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since we're not using ext4_kvzalloc(), delete this function.

Signed-off-by: Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
---
 fs/ext4/ext4.h  |  1 -
 fs/ext4/super.c | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 61987c106511..b25089e3896d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2678,7 +2678,6 @@ extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
 extern int ext4_calculate_overhead(struct super_block *sb);
 extern void ext4_superblock_csum_set(struct super_block *sb);
 extern void *ext4_kvmalloc(size_t size, gfp_t flags);
-extern void *ext4_kvzalloc(size_t size, gfp_t flags);
 extern int ext4_alloc_flex_bg_array(struct super_block *sb,
 				    ext4_group_t ngroup);
 extern const char *ext4_decode_error(struct super_block *sb, int errno,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b205112ca051..83a231dedcbf 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -214,16 +214,6 @@ void *ext4_kvmalloc(size_t size, gfp_t flags)
 	return ret;
 }

-void *ext4_kvzalloc(size_t size, gfp_t flags)
-{
-	void *ret;
-
-	ret = kzalloc(size, flags | __GFP_NOWARN);
-	if (!ret)
-		ret = __vmalloc(size, flags | __GFP_ZERO, PAGE_KERNEL);
-	return ret;
-}
-
 ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
--
2.16.6

