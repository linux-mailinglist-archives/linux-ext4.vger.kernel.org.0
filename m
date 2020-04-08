Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3121A1F19
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgDHKrM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:47:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36964 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHKrM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:47:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id u65so2232369pfb.4
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/sCPK4EAfucZ4oL+FKdVtn5ycTMzZXmhQ6JEHaJ1dFc=;
        b=ezMMIpr2Zt054mV9TP1vYQ2G77U4W6uE+IIR1EfvJ9u7CKClGGI21DVrs4MCKpvPUM
         cjdeRcu9vLFbg+bGgQG4i8P1YxiOL3lue5nK6s/hxiKzBhJOo1uItYQDKx0FlU8qLd3q
         NoK5pt2jDrH9zNAp118JO6gQUjY/1jHd6PrP9qC+OABPv+PV+bhFE5xQRUEupkEZt7uB
         QusswkQWbHcb0MVLNphWBoRgdVrivF5vJiCbC4SLXxRDNHr6ZtCwUen4xkUuE3CI6plk
         n3c9F/+5042Yr7nQMDe3Yz3SyAHlJCHKYKFDQUjEHq9XijqVEFtxJ1QuR6Q6oGhNSn1h
         cvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/sCPK4EAfucZ4oL+FKdVtn5ycTMzZXmhQ6JEHaJ1dFc=;
        b=W/vAKVtUpCWqy6zm4lOzQEBge+SkFfmSjqo2SVOfpQ8ExVqKICJZjIPuGvHNq7Czi5
         EQaF5WYh3m0csiJZ/stKdDqbnaOfW1oBa+OegzWjYSew9S8542e29AyoDNpNJCBZktA5
         UMhaNkNaTglhITN2m3FDeUVzX6BET/PzxXGT0fr199oNf2yN6sftmIrh25+fEzyhPt1C
         Ezt1XcWXGzo4M5D2J+MvfCIeVk2PAFyRxsecZZ74swgivc8Vys76ATtvfGkIFtf5VfNp
         M/xwBpsS0gX/F21zloVmc6zT68+c6AoJiKawHs/f/pqenu+VIRdR7YEQFPUMToIbBwzI
         kPfg==
X-Gm-Message-State: AGi0PuaBgGdUtbKGr46DpRoHLc+esmAx1wInQGZtVjdWYPL9dhBgfwY4
        hptReCnBWSDmo7VYMZBQvY7xhtn44Tk=
X-Google-Smtp-Source: APiQypKPbDw9Z5j/dAsB8HEokI1LeqahT/Gn1FJd7BD3CXskBGQms0/nfluFvtu1gqzLwbUGOnGF6A==
X-Received: by 2002:a62:2c87:: with SMTP id s129mr7279655pfs.263.1586342831111;
        Wed, 08 Apr 2020 03:47:11 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:47:10 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Li Dongyang <dongyangli@ddn.com>
Subject: [RFC PATCH 46/46] libext2fs: optimize ext2fs_convert_subcluster_bitmap()
Date:   Wed,  8 Apr 2020 19:45:14 +0900
Message-Id: <1586342714-12536-47-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Dongyang <dongyangli@ddn.com>

For a bigalloc filesystem, converting the block bitmap from blocks
to chunks in ext2fs_convert_subcluster_bitmap() can take a long time
when the device is huge, because we test the bitmap
bit-by-bit using ext2fs_test_block_bitmap2().
Use ext2fs_find_first_set_block_bitmap2() which is more efficient
for mke2fs when the fs is mostly empty.

e2fsck can also benefit from this during pass1 block scanning.

Time taken for "mke2fs -O bigalloc,extent -C 131072 -b 4096" on a 1PB
device:

without patch:
real    27m49.457s
user    21m36.474s
sys     6m9.514s

with patch:
real    6m31.908s
user    0m1.806s
sys    6m29.697s

Change-Id: I054ed3ae9e25b20de34f61358dfce3c4bd6f3092
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
Signed-off-by: Li Xi <lixi@ddn.com>
---
 lib/ext2fs/gen_bitmap64.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index d354cffa..299fee6e 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -856,8 +856,7 @@ errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
 	ext2fs_generic_bitmap_64 bmap, cmap;
 	ext2fs_block_bitmap	gen_bmap = *bitmap, gen_cmap;
 	errcode_t		retval;
-	blk64_t			i, b_end, c_end;
-	int			n, ratio;
+	blk64_t			i, next, b_end, c_end;
 
 	bmap = (ext2fs_generic_bitmap_64) gen_bmap;
 	if (fs->cluster_ratio_bits == ext2fs_get_bitmap_granularity(gen_bmap))
@@ -874,18 +873,13 @@ errcode_t ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
 	bmap->end = bmap->real_end;
 	c_end = cmap->end;
 	cmap->end = cmap->real_end;
-	n = 0;
-	ratio = 1 << fs->cluster_ratio_bits;
 	while (i < bmap->real_end) {
-		if (ext2fs_test_block_bitmap2(gen_bmap, i)) {
-			ext2fs_mark_block_bitmap2(gen_cmap, i);
-			i += ratio - n;
-			n = 0;
-			continue;
-		}
-		i++; n++;
-		if (n >= ratio)
-			n = 0;
+		retval = ext2fs_find_first_set_block_bitmap2(gen_bmap,
+						i, bmap->real_end, &next);
+		if (retval)
+			break;
+		ext2fs_mark_block_bitmap2(gen_cmap, next);
+		i = EXT2FS_C2B(fs, EXT2FS_B2C(fs, next) + 1);
 	}
 	bmap->end = b_end;
 	cmap->end = c_end;
-- 
2.25.2

