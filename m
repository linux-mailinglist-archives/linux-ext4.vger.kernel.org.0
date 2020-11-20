Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C292BB510
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 20:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbgKTTQp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 14:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732276AbgKTTQo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 14:16:44 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE2C0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:44 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id v12so8767848pfm.13
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0hzlz8HwLKz6qwhsD2BujHz+YW0z2tjXKA4WWmM0ew=;
        b=nfLhP9YcWg8HKjYImav9iw0M9S2Q22KSsxEaDF5DHCM1pdZ89XPCmtFO529MiEodTg
         BWdGxNMVXDxjaiFVqnc9qxZcWR8EzBI/JShFsk1f+X4tjNH+mFm424i+8ggjPcqclRS1
         cg5Kds3GpStcDwLUS3RQhMHiujpAUxeAm+8h6qVW2oEoRv5l5m89Z2tbaKOET0dZP8Mf
         1IHBL9obh6tFRnUM5sXcHUPOW2ZvTzAQv128tmRekFDgEiMPjlMyZmbd5clVxBxS/9iT
         otu4hA0/ZfHckSfnW90qupqe1HDS1Ypy3sxEgosEYOyhnDpdV0W8s7+Rg67VnBZrg/Fe
         Rv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0hzlz8HwLKz6qwhsD2BujHz+YW0z2tjXKA4WWmM0ew=;
        b=rAEezlfjG8ryRLiwjyXOPUe2eqhZ+YYOPEbSN0tOd/WAyAGCtTMcThBy70CxaZlVAO
         s4Y2zcfdeQEmoRA3/fy0bCrS2OPfZeLB2gPb/Ck4Oi8eBjrJL+eVAivFP8PnYDM8G/Na
         jUX7Yq89HcLy6zSY6D37V4E0nfyvTcIIDLuTP6cc3E82nUOL5eK3BZr+ywcseDRV3VU4
         k32IHoZWE+xuAtpofCY47JV3xm+Aa4spQr+4FlaTQDzMM1I6iArMpN81MIOOH+nEsIdT
         rQk+rQud9PQm+j9C2wQ/sfOGwiAOKQBSVVt4U+vvA/R6YHFgnY55VjpfsVmWasY2aeMT
         X9ug==
X-Gm-Message-State: AOAM530jXctOyA3XJ4arWH71AejRRmfoCgDitMNjO7yaqIHO5kYVofSY
        qDTjPuJ+byB98TRwtv5acYDUpELhl1k=
X-Google-Smtp-Source: ABdhPJxfByswgPZkwwLZOGVeHzsyIfBPUlWdxqA1RlOJoay4qMyIIxWNhZ2U/Y4NMfcRDnydvPIQMg==
X-Received: by 2002:a05:6a00:80e:b029:196:1cad:b64 with SMTP id m14-20020a056a00080eb02901961cad0b64mr15314605pfk.5.1605899803059;
        Fri, 20 Nov 2020 11:16:43 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o9sm4370480pjr.2.2020.11.20.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:16:41 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 15/15] ext4: fix tests to account for new dumpe2fs output
Date:   Fri, 20 Nov 2020 11:16:06 -0800
Message-Id: <20201120191606.2224881-16-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

dumpe2fs tool now is capable of reporting number of fast commit
blocks. There were slight changes in the output of dumpe2fs outside of
fast commits. This patch fixes the regression tests to expect the new
output.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 tests/d_corrupt_journal_nr_users/expect |  6 ++++--
 tests/f_jnl_errno/expect.0              |  6 ++++--
 tests/f_opt_extent/expect               |  2 +-
 tests/i_bitmaps/expect                  |  8 +++++---
 tests/j_ext_dumpe2fs/expect             |  6 ++++--
 tests/m_bigjournal/expect.1             |  6 ++++--
 tests/m_extent_journal/expect.1         |  6 ++++--
 tests/m_resize_inode_meta_bg/expect.1   |  6 ++++--
 tests/m_rootdir/expect                  |  6 ++++--
 tests/r_32to64bit/expect                |  6 +++---
 tests/r_32to64bit_meta/expect           |  4 ++--
 tests/r_32to64bit_move_itable/expect    |  8 ++++----
 tests/r_64to32bit/expect                |  6 +++---
 tests/r_64to32bit_meta/expect           |  4 ++--
 tests/r_move_itable_nostride/expect     |  6 ++++--
 tests/r_move_itable_realloc/expect      |  6 ++++--
 tests/t_disable_mcsum/expect            |  4 ++--
 tests/t_disable_mcsum_noinitbg/expect   |  6 +++---
 tests/t_disable_mcsum_yesinitbg/expect  |  4 ++--
 tests/t_enable_mcsum/expect             |  6 +++---
 tests/t_enable_mcsum_ext3/expect        | 10 +++++-----
 tests/t_enable_mcsum_initbg/expect      |  6 +++---
 22 files changed, 74 insertions(+), 54 deletions(-)

diff --git a/tests/d_corrupt_journal_nr_users/expect b/tests/d_corrupt_journal_nr_users/expect
index cdfb49a0..656d35c3 100644
--- a/tests/d_corrupt_journal_nr_users/expect
+++ b/tests/d_corrupt_journal_nr_users/expect
@@ -34,8 +34,10 @@ Default directory hash:   half_md4
 Journal backup:           inode blocks
 Checksum type:            crc32c
 Journal features:         (none)
-Journal size:             4096k
-Journal length:           1024
+Total journal size:       4096k
+Total journal blocks:     1024
+Max transaction length:   1024
+Fast commit length:       0
 Journal sequence:         0x00000001
 Journal start:            0
 Journal number of users:  9999
diff --git a/tests/f_jnl_errno/expect.0 b/tests/f_jnl_errno/expect.0
index 2a9426d9..96fb01a7 100644
--- a/tests/f_jnl_errno/expect.0
+++ b/tests/f_jnl_errno/expect.0
@@ -31,8 +31,10 @@ Journal inode:            8
 Default directory hash:   half_md4
 Journal backup:           inode blocks
 Journal features:         (none)
-Journal size:             1024k
-Journal length:           1024
+Total journal size:       1024k
+Total journal blocks:     1024
+Max transaction length:   1024
+Fast commit length:       0
 Journal sequence:         0x00000005
 Journal start:            0
 
diff --git a/tests/f_opt_extent/expect b/tests/f_opt_extent/expect
index 6d1f9d11..9d2021e8 100644
--- a/tests/f_opt_extent/expect
+++ b/tests/f_opt_extent/expect
@@ -35,7 +35,7 @@ Change in FS metadata:
  Free inodes:              65047
  First block:              1
  Block size:               1024
-@@ -48,8 +48,8 @@
+@@ -50,8 +50,8 @@
    Block bitmap at 262 (+261)
    Inode bitmap at 278 (+277)
    Inode table at 294-549 (+293)
diff --git a/tests/i_bitmaps/expect b/tests/i_bitmaps/expect
index fb9d8f1f..6199bb7c 100644
--- a/tests/i_bitmaps/expect
+++ b/tests/i_bitmaps/expect
@@ -1,6 +1,8 @@
-46,50d45
+46,52d45
 < Journal features:         (none)
-< Journal size:             1024k
-< Journal length:           1024
+< Total journal size:       1024k
+< Total journal blocks:     1024
+< Max transaction length:   1024
+< Fast commit length:       0
 < Journal sequence:         0x00000001
 < Journal start:            0
diff --git a/tests/j_ext_dumpe2fs/expect b/tests/j_ext_dumpe2fs/expect
index db77a36d..2838bbd1 100644
--- a/tests/j_ext_dumpe2fs/expect
+++ b/tests/j_ext_dumpe2fs/expect
@@ -43,8 +43,10 @@ Desired extra isize:      28
 Default directory hash:   half_md4
 Checksum type:            crc32c
 Journal features:         journal_64bit journal_checksum_v3
-Journal size:             2048k
-Journal length:           2048
+Total journal size:       2048k
+Total journal blocks:     2048
+Max transaction length:   2048
+Fast commit length:       0
 Journal first block:      3
 Journal sequence:         0x00000003
 Journal start:            0
diff --git a/tests/m_bigjournal/expect.1 b/tests/m_bigjournal/expect.1
index 80f71d1f..eb0e3bc3 100644
--- a/tests/m_bigjournal/expect.1
+++ b/tests/m_bigjournal/expect.1
@@ -42,8 +42,10 @@ Journal inode:            8
 Default directory hash:   half_md4
 Journal backup:           inode blocks
 Journal features:         (none)
-Journal size:             5000M
-Journal length:           1280000
+Total journal size:       5000M
+Total journal blocks:     1280000
+Max transaction length:   1280000
+Fast commit length:       0
 Journal sequence:         0x00000001
 Journal start:            0
 
diff --git a/tests/m_extent_journal/expect.1 b/tests/m_extent_journal/expect.1
index cfc052a8..9a9219e9 100644
--- a/tests/m_extent_journal/expect.1
+++ b/tests/m_extent_journal/expect.1
@@ -48,8 +48,10 @@ Journal inode:            8
 Default directory hash:   half_md4
 Journal backup:           inode blocks
 Journal features:         (none)
-Journal size:             4096k
-Journal length:           4096
+Total journal size:       4096k
+Total journal blocks:     4096
+Max transaction length:   4096
+Fast commit length:       0
 Journal sequence:         0x00000001
 Journal start:            0
 
diff --git a/tests/m_resize_inode_meta_bg/expect.1 b/tests/m_resize_inode_meta_bg/expect.1
index 6a7f3993..7feaed9d 100644
--- a/tests/m_resize_inode_meta_bg/expect.1
+++ b/tests/m_resize_inode_meta_bg/expect.1
@@ -51,8 +51,10 @@ Journal inode:            8
 Default directory hash:   half_md4
 Journal backup:           inode blocks
 Journal features:         (none)
-Journal size:             4096k
-Journal length:           1024
+Total journal size:       4096k
+Total journal blocks:     1024
+Max transaction length:   1024
+Fast commit length:       0
 Journal sequence:         0x00000001
 Journal start:            0
 
diff --git a/tests/m_rootdir/expect b/tests/m_rootdir/expect
index 113ffc64..dbc79772 100644
--- a/tests/m_rootdir/expect
+++ b/tests/m_rootdir/expect
@@ -36,8 +36,10 @@ Default directory hash:   half_md4
 Journal backup:           inode blocks
 Checksum type:            crc32c
 Journal features:         (none)
-Journal size:             1024k
-Journal length:           1024
+Total journal size:       1024k
+Total journal blocks:     1024
+Max transaction length:   1024
+Fast commit length:       0
 Journal sequence:         0x00000001
 Journal start:            0
 
diff --git a/tests/r_32to64bit/expect b/tests/r_32to64bit/expect
index c6816b7f..de573b3e 100644
--- a/tests/r_32to64bit/expect
+++ b/tests/r_32to64bit/expect
@@ -47,7 +47,7 @@ Change in FS metadata:
  Blocks per group:         8192
  Fragments per group:      8192
  Inodes per group:         1024
-@@ -41,16 +41,16 @@
+@@ -43,16 +43,16 @@
  
  
  group:block:super:gdt:bbitmap:ibitmap:itable
@@ -70,7 +70,7 @@ Change in FS metadata:
  10:81921:-1:-1:270:286:2852
  11:90113:-1:-1:271:287:3108
  12:98305:-1:-1:272:288:3364
-@@ -66,9 +66,9 @@
+@@ -68,9 +68,9 @@
  22:180225:-1:-1:131079:131095:132641
  23:188417:-1:-1:131080:131096:132897
  24:196609:-1:-1:131081:131097:133153
@@ -82,7 +82,7 @@ Change in FS metadata:
  28:229377:-1:-1:131085:131101:134177
  29:237569:-1:-1:131086:131102:134433
  30:245761:-1:-1:131087:131103:134689
-@@ -90,7 +90,7 @@
+@@ -92,7 +92,7 @@
  46:376833:-1:-1:262159:262175:265761
  47:385025:-1:-1:262160:262176:266017
  48:393217:-1:-1:393217:393233:393249
diff --git a/tests/r_32to64bit_meta/expect b/tests/r_32to64bit_meta/expect
index c4f39266..70babbd9 100644
--- a/tests/r_32to64bit_meta/expect
+++ b/tests/r_32to64bit_meta/expect
@@ -46,7 +46,7 @@ Change in FS metadata:
  Blocks per group:         8192
  Fragments per group:      8192
  Inodes per group:         1024
-@@ -55,9 +55,9 @@
+@@ -57,9 +57,9 @@
  12:98305:-1:-1:15:31:3107
  13:106497:-1:-1:16:32:3363
  14:114689:-1:-1:17:33:3619
@@ -59,7 +59,7 @@ Change in FS metadata:
  18:147457:-1:-1:131075:131091:131617
  19:155649:-1:-1:131076:131092:131873
  20:163841:-1:-1:131077:131093:132129
-@@ -87,9 +87,9 @@
+@@ -89,9 +89,9 @@
  44:360449:-1:-1:262158:262174:265250
  45:368641:-1:-1:262159:262175:265506
  46:376833:-1:-1:262160:262176:265762
diff --git a/tests/r_32to64bit_move_itable/expect b/tests/r_32to64bit_move_itable/expect
index 0a3b78e7..a1d2aebc 100644
--- a/tests/r_32to64bit_move_itable/expect
+++ b/tests/r_32to64bit_move_itable/expect
@@ -46,7 +46,7 @@ Change in FS metadata:
  Blocks per group:         8192
  Fragments per group:      8192
  Inodes per group:         1024
-@@ -39,16 +39,16 @@
+@@ -41,16 +41,16 @@
  
  
  group:block:super:gdt:bbitmap:ibitmap:itable
@@ -69,7 +69,7 @@ Change in FS metadata:
  10:81921:-1:-1:81921:81922:81923
  11:90113:-1:-1:90113:90114:90115
  12:98305:-1:-1:98305:98306:98307
-@@ -64,9 +64,9 @@
+@@ -66,9 +66,9 @@
  22:180225:-1:-1:180225:180226:180227
  23:188417:-1:-1:188417:188418:188419
  24:196609:-1:-1:196609:196610:196611
@@ -81,7 +81,7 @@ Change in FS metadata:
  28:229377:-1:-1:229377:229378:229379
  29:237569:-1:-1:237569:237570:237571
  30:245761:-1:-1:245761:245762:245763
-@@ -88,7 +88,7 @@
+@@ -90,7 +90,7 @@
  46:376833:-1:-1:376833:376834:376835
  47:385025:-1:-1:385025:385026:385027
  48:393217:-1:-1:393217:393218:393219
@@ -90,7 +90,7 @@ Change in FS metadata:
  50:409601:-1:-1:409601:409602:409603
  51:417793:-1:-1:417793:417794:417795
  52:425985:-1:-1:425985:425986:425987
-@@ -120,7 +120,7 @@
+@@ -122,7 +122,7 @@
  78:638977:-1:-1:638977:638978:638979
  79:647169:-1:-1:647169:647170:647171
  80:655361:-1:-1:655361:655362:655363
diff --git a/tests/r_64to32bit/expect b/tests/r_64to32bit/expect
index 7dff2a05..eb609fbd 100644
--- a/tests/r_64to32bit/expect
+++ b/tests/r_64to32bit/expect
@@ -46,7 +46,7 @@ Change in FS metadata:
  Reserved GDT blocks:      256
  Blocks per group:         8192
  Fragments per group:      8192
-@@ -42,16 +40,16 @@
+@@ -44,16 +42,16 @@
  
  
  group:block:super:gdt:bbitmap:ibitmap:itable
@@ -69,7 +69,7 @@ Change in FS metadata:
  10:81921:-1:-1:272:288:2854
  11:90113:-1:-1:273:289:3110
  12:98305:-1:-1:274:290:3366
-@@ -67,9 +65,9 @@
+@@ -69,9 +67,9 @@
  22:180225:-1:-1:131079:131095:132641
  23:188417:-1:-1:131080:131096:132897
  24:196609:-1:-1:131081:131097:133153
@@ -81,7 +81,7 @@ Change in FS metadata:
  28:229377:-1:-1:131085:131101:134177
  29:237569:-1:-1:131086:131102:134433
  30:245761:-1:-1:131087:131103:134689
-@@ -91,7 +89,7 @@
+@@ -93,7 +91,7 @@
  46:376833:-1:-1:262159:262175:265761
  47:385025:-1:-1:262160:262176:266017
  48:393217:-1:-1:393217:393233:393249
diff --git a/tests/r_64to32bit_meta/expect b/tests/r_64to32bit_meta/expect
index b17a8784..70655909 100644
--- a/tests/r_64to32bit_meta/expect
+++ b/tests/r_64to32bit_meta/expect
@@ -46,7 +46,7 @@ Change in FS metadata:
  Blocks per group:         8192
  Fragments per group:      8192
  Inodes per group:         1024
-@@ -56,9 +54,9 @@
+@@ -58,9 +56,9 @@
  12:98305:-1:-1:15:31:3107
  13:106497:-1:-1:16:32:3363
  14:114689:-1:-1:17:33:3619
@@ -59,7 +59,7 @@ Change in FS metadata:
  18:147457:-1:-1:131076:131092:131618
  19:155649:-1:-1:131077:131093:131874
  20:163841:-1:-1:131078:131094:132130
-@@ -88,9 +86,9 @@
+@@ -90,9 +88,9 @@
  44:360449:-1:-1:262158:262174:265250
  45:368641:-1:-1:262159:262175:265506
  46:376833:-1:-1:262160:262176:265762
diff --git a/tests/r_move_itable_nostride/expect b/tests/r_move_itable_nostride/expect
index 098cbfc5..74c2cc0a 100644
--- a/tests/r_move_itable_nostride/expect
+++ b/tests/r_move_itable_nostride/expect
@@ -52,8 +52,10 @@ Journal inode:            8
 Default directory hash:   half_md4
 Journal backup:           inode blocks
 Journal features:         (none)
-Journal size:             16M
-Journal length:           16384
+Total journal size:       16M
+Total journal blocks:     16384
+Max transaction length:   16384
+Fast commit length:       0
 Journal sequence:         0x00000001
 Journal start:            0
 
diff --git a/tests/r_move_itable_realloc/expect b/tests/r_move_itable_realloc/expect
index f9a7f515..67f2fe4a 100644
--- a/tests/r_move_itable_realloc/expect
+++ b/tests/r_move_itable_realloc/expect
@@ -51,8 +51,10 @@ Journal inode:            8
 Default directory hash:   half_md4
 Journal backup:           inode blocks
 Journal features:         (none)
-Journal size:             16M
-Journal length:           16384
+Total journal size:       16M
+Total journal blocks:     16384
+Max transaction length:   16384
+Fast commit length:       0
 Journal sequence:         0x00000001
 Journal start:            0
 
diff --git a/tests/t_disable_mcsum/expect b/tests/t_disable_mcsum/expect
index 3341ad71..bfa21b89 100644
--- a/tests/t_disable_mcsum/expect
+++ b/tests/t_disable_mcsum/expect
@@ -34,8 +34,8 @@ Change in FS metadata:
  Journal backup:           inode blocks
 -Checksum type:            crc32c
  Journal features:         (none)
- Journal size:             16M
- Journal length:           16384
+ Total journal size:       16M
+ Total journal blocks:     16384
 Pass 1: Checking inodes, blocks, and sizes
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
diff --git a/tests/t_disable_mcsum_noinitbg/expect b/tests/t_disable_mcsum_noinitbg/expect
index 62eca4e9..fe61fcbc 100644
--- a/tests/t_disable_mcsum_noinitbg/expect
+++ b/tests/t_disable_mcsum_noinitbg/expect
@@ -34,9 +34,9 @@ Change in FS metadata:
  Journal backup:           inode blocks
 -Checksum type:            crc32c
  Journal features:         (none)
- Journal size:             16M
- Journal length:           16384
-@@ -48,18 +47,18 @@
+ Total journal size:       16M
+ Total journal blocks:     16384
+@@ -50,18 +49,18 @@
    Block bitmap at 262 (+261)
    Inode bitmap at 278 (+277)
    Inode table at 294-549 (+293)
diff --git a/tests/t_disable_mcsum_yesinitbg/expect b/tests/t_disable_mcsum_yesinitbg/expect
index 7e3485fe..b9062489 100644
--- a/tests/t_disable_mcsum_yesinitbg/expect
+++ b/tests/t_disable_mcsum_yesinitbg/expect
@@ -34,8 +34,8 @@ Change in FS metadata:
  Journal backup:           inode blocks
 -Checksum type:            crc32c
  Journal features:         (none)
- Journal size:             16M
- Journal length:           16384
+ Total journal size:       16M
+ Total journal blocks:     16384
 Pass 1: Checking inodes, blocks, and sizes
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
diff --git a/tests/t_enable_mcsum/expect b/tests/t_enable_mcsum/expect
index cb0aef62..fcb0ed16 100644
--- a/tests/t_enable_mcsum/expect
+++ b/tests/t_enable_mcsum/expect
@@ -58,9 +58,9 @@ Change in FS metadata:
  Journal backup:           inode blocks
 +Checksum type:            crc32c
  Journal features:         (none)
- Journal size:             16M
- Journal length:           16384
-@@ -47,8 +48,8 @@
+ Total journal size:       16M
+ Total journal blocks:     16384
+@@ -49,8 +50,8 @@
    Block bitmap at 262 (+261)
    Inode bitmap at 278 (+277)
    Inode table at 294-549 (+293)
diff --git a/tests/t_enable_mcsum_ext3/expect b/tests/t_enable_mcsum_ext3/expect
index 11c5a26d..549e60e9 100644
--- a/tests/t_enable_mcsum_ext3/expect
+++ b/tests/t_enable_mcsum_ext3/expect
@@ -37,9 +37,9 @@ Change in FS metadata:
  Journal backup:           inode blocks
 +Checksum type:            crc32c
  Journal features:         (none)
- Journal size:             16M
- Journal length:           16384
-@@ -37,7 +38,7 @@
+ Total journal size:       16M
+ Total journal blocks:     16384
+@@ -39,7 +40,7 @@
  Journal start:            0
  
  
@@ -48,7 +48,7 @@ Change in FS metadata:
    Primary superblock at 1, Group descriptors at 2-3
    Reserved GDT blocks at 4-259
    Block bitmap at 260 (+259)
-@@ -46,7 +47,7 @@
+@@ -48,7 +49,7 @@
    0 free blocks, 1013 free inodes, 2 directories
    Free blocks: 
    Free inodes: 12-1024
@@ -57,7 +57,7 @@ Change in FS metadata:
    Backup superblock at 8193, Group descriptors at 8194-8195
    Reserved GDT blocks at 8196-8451
    Block bitmap at 8452 (+259)
-@@ -55,6 +56,6 @@
+@@ -57,6 +58,6 @@
    0 free blocks, 1024 free inodes, 0 directories
    Free blocks: 
    Free inodes: 1025-2048
diff --git a/tests/t_enable_mcsum_initbg/expect b/tests/t_enable_mcsum_initbg/expect
index a37648bf..987141f1 100644
--- a/tests/t_enable_mcsum_initbg/expect
+++ b/tests/t_enable_mcsum_initbg/expect
@@ -58,9 +58,9 @@ Change in FS metadata:
  Journal backup:           inode blocks
 +Checksum type:            crc32c
  Journal features:         (none)
- Journal size:             16M
- Journal length:           16384
-@@ -41,24 +42,24 @@
+ Total journal size:       16M
+ Total journal blocks:     16384
+@@ -43,24 +44,24 @@
  Journal start:            0
  
  
-- 
2.29.2.454.gaff20da3a2-goog

