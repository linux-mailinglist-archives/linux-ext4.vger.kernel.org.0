Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7B2109AAB
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2019 10:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfKZJEZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Nov 2019 04:04:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36192 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfKZJEZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Nov 2019 04:04:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id k13so8669790pgh.3
        for <linux-ext4@vger.kernel.org>; Tue, 26 Nov 2019 01:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+aHYWyEGOD7lKt/iwJJpgTUbdTtsRT9qbTTTzpTAYMA=;
        b=RK2KQsPpAaagfQX46gC46StrrFxir9XsqwtfeZ/dLkbakXUXcTmchlYDCE6MRu3nxS
         6GvjH51xGMlBJ7OC9aKYrQySsORVax1ji4NvUyanL/qarvUzac6osGB58DpkJK9/UJSv
         XMlaBFuoNPFxDRQZbdulu/KUPAuSg9zscnSvI4j3WPPCKuWkIm94hfFcU4sQBqzRHRk+
         Z7bHx5hK4xHjjMD5MeIJraEyV2V1kpgh1JdDcbUXOI/0dhKwXDt0i3iaaLzWKIJgSM/C
         oO/OvFzOu4tBO0t9yFoZc962xTjwGv6L7KykqhxmyPpPI1bEVKRCA8+fPWZo2vT7ycUY
         d8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+aHYWyEGOD7lKt/iwJJpgTUbdTtsRT9qbTTTzpTAYMA=;
        b=A5RivxXInCFqh1PDCz24adD8Rk0C1XW4jkoyPpfWsYLYNCu/zyVqQgUKO//OSi1muu
         slwDA4TVGvVS8vX0tll+Asfu+dXLCfPrJpCsQ3EMCmnd8PTsYHITyAUyRGJVG+T1BvdO
         BjK8eDWJT816+991h2vBFd1iqe3U4SGCUXAfeQbATavsSO1TpTnUvoDpbm/12phrvutX
         fLf1IzxfQ8EsJ42OEv/LlvqznP0BHnu6MW5cdzReixRNDS0wyaNB2GflT2bZJ0s+trrO
         5D7yH2XEvHYh9nM4425iRWCXycbNR1HDE7HjNhSvk/ES1O+Dsnrw/47BTO3OmhsBykYd
         q0wQ==
X-Gm-Message-State: APjAAAXsupKZBR+ZIRVd8PaTU0b/Psz9brxi8nirQwpHothzvp1uBtRo
        ityLWL5/7uQCmGPhUDb8UcrqmdUKh59b0vIL
X-Google-Smtp-Source: APXvYqyt8Ikc5dquFmXxx7oztfmFL+cHNK3ZMLthgXzyDnRNFSD2wV7kCg42omebfDoGK9sk+ker8w==
X-Received: by 2002:a63:fe06:: with SMTP id p6mr36934797pgh.245.1574759064246;
        Tue, 26 Nov 2019 01:04:24 -0800 (PST)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id b17sm11969851pfr.17.2019.11.26.01.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 01:04:23 -0800 (PST)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca, lixi@ddn.com, wshilong@ddn.com
Subject: [PATCH 2/2] e2fsck: fix use after free in calculate_tree()
Date:   Tue, 26 Nov 2019 18:03:59 +0900
Message-Id: <1574759039-7429-2-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1574759039-7429-1-git-send-email-wangshilong1991@gmail.com>
References: <1574759039-7429-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Hit following Seg errors randomly when running f_large_dir test:

+Signal (11) SIGSEGV si_code=SEGV_MAPERR fault addr=0x7f02cfffbc1a
+../e2fsck/e2fsck[0x43766e]
+/lib64/libpthread.so.0(+0xf7e0)[0x7f02d8c9a7e0]
+../e2fsck/e2fsck(e2fsck_rehash_dir+0x10f3)[0x436173]
+../e2fsck/e2fsck(e2fsck_rehash_directories+0xf4)[0x4362d4]
+../e2fsck/e2fsck(e2fsck_pass3+0x722)[0x4292c2]
+../e2fsck/e2fsck(e2fsck_run+0x47)[0x414ef7]
+../e2fsck/e2fsck(main+0x1c1d)[0x41319d]
+/lib64/libc.so.6(__libc_start_main+0x100)[0x7f02d8915d20]
+../e2fsck/e2fsck[0x40fc59]
+Exit status is 8

gdb output is:
0x436173 is in e2fsck_rehash_dir (rehash.c:752).
warning: Source file is more recent than executable.
747					dx_ent->hash =
748						ext2fs_cpu_to_le32(outdir->hashes[i]);
749				dx_ent++;
750				c3--;
751			}
752			int_limit->count = ext2fs_cpu_to_le16(limit->limit - c2);
753			int_limit->limit = ext2fs_cpu_to_le16(limit->limit);
754
755			limit->count = ext2fs_cpu_to_le16(limit->limit - c3);
756			limit->limit = ext2fs_cpu_to_le16(limit->limit);

The problem is alloc_blocks() will call get_next_block()
which might reallocate @outdir->buf, and memory address
could be changed after this. @int_limit and @root should
be recalculated based on new start address. Otherwise,
it will try to access freed memory and cause SEGV_MAPERR
errors.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/rehash.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
index 5250652e..0eb99328 100644
--- a/e2fsck/rehash.c
+++ b/e2fsck/rehash.c
@@ -636,6 +636,9 @@ static int alloc_blocks(ext2_filsys fs,
 	if (retval)
 		return retval;
 
+	/* outdir->buf might be reallocated */
+	*prev_ent = (struct ext2_dx_entry *) (outdir->buf + *prev_offset);
+
 	*next_ent = set_int_node(fs, block_start);
 	*limit = (struct ext2_dx_countlimit *)(*next_ent);
 	if (next_offset)
@@ -725,12 +728,18 @@ static errcode_t calculate_tree(ext2_filsys fs,
 					return retval;
 			}
 			if (c3 == 0) {
+				int delta1 = int_offset;;
+				int delta2 = (char *)root - outdir->buf;
+
 				retval = alloc_blocks(fs, &limit, &int_ent,
 						      &dx_ent, &int_offset,
 						      NULL, outdir, i, &c2,
 						      &c3);
 				if (retval)
 					return retval;
+				/* outdir->buf might be reallocated */
+				int_limit = (struct ext2_dx_countlimit *)(outdir->buf + delta1);
+				root = (struct ext2_dx_entry *)(outdir->buf + delta2);
 
 			}
 			dx_ent->block = ext2fs_cpu_to_le32(i);
-- 
2.21.0

