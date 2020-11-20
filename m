Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BCD2BB502
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 20:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbgKTTQZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 14:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgKTTQZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 14:16:25 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E2C0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:25 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id l11so5361175plt.1
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LoaZ+lPWTh2hzvkHLYosf1B+tt8bIDWRafiaipRQw/I=;
        b=KMFimrcB8O4RhZ2ypYwvrTMteZQxXgA79418hifE0Q2aOEwyM86WnVTGzj8x0mYYKg
         Oh4OzLRB7dJsHF2PpUzKUUV50+gOHtRpuXQtub26TtghMtPiMwZ3jIC3JKcsQJQSyLVn
         lDX19a8yeiAhWOCTwdT9bBzg/zNmEiFPHoDPJ3rY1DcdalQZTjXrAGrZqKJ5hHREKwpC
         Z11wHu+Mbnd7b/xdTWOi0uq48JnfXFWJGkKMBT8We4rlHx+bxJTq4+C5ZMVQKYYvaH7k
         bTEa+En9hDBly+uL/jP4ODhjtnzBHouwvgEdRzEeFyfhFbpn6+uEJ7SWeJdroHPrd+Tx
         JB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoaZ+lPWTh2hzvkHLYosf1B+tt8bIDWRafiaipRQw/I=;
        b=WjNu+gWTtsoPtJEKORTyqexwTZVnMJNEST3DWgqTAehjujpvjoJSCZugEUwBant6xw
         XAGE54Fw861gi4sTx3w9Tm1er1L8TOeUqb+u6fgrXiwp+1QmGY73G7fDvN5E9FDUe8YO
         WxB2hFwfLoYVa5Jqafj6haTTgb3rm3EW69KHSvD1Prt76ftbd9CSakzliDo2qbLvfQSL
         OqIaulP23vjBmYpMk3/15+p4rAWBloiWp5NHJhRevcz+0sB2ecJ0TBncFO+dnC1zAnCT
         Xz9P2TkHH2rqgJroCdZA0iHDpNhx0QrXKejJ7joajOWQMvhaApi31AeNTPBMo6kHpDTt
         RFQQ==
X-Gm-Message-State: AOAM532PC5OKsg5X3i7ag8O4sgv69iI4QG0khKPwxSdek59LNe5i9JSU
        e+ZyphvkR/6s8QcNePqietRyKIMl5Mg=
X-Google-Smtp-Source: ABdhPJxphQ82aRQJ+RyZDlFR3qvRzC9zFdTfM531clLLGZPTyO1goJCtFMdC1sMA1Kc0ol8rkBkoLw==
X-Received: by 2002:a17:902:7486:b029:d9:d4aa:e033 with SMTP id h6-20020a1709027486b02900d9d4aae033mr10544327pll.16.1605899784520;
        Fri, 20 Nov 2020 11:16:24 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o9sm4370480pjr.2.2020.11.20.11.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:16:22 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 02/15] ext2fs, e2fsck: add kernel endian-ness conversion macros
Date:   Fri, 20 Nov 2020 11:15:53 -0800
Message-Id: <20201120191606.2224881-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In order to make recovery.c identical with kernel, we need endianness
conversion macros (such as cpu_to_be32 and friends) defined in
e2fsprogs. This patch defines these macros and also fixes recovery.c
to use these. These macros are also needed for fast commit recovery
patches later in this series.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/recovery.c   | 42 ++++++++++--------------------------------
 lib/ext2fs/bitops.h |  8 ++++++++
 2 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index 5df690ad..6c3b7bb4 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -121,27 +121,6 @@ failed:
 
 #endif /* __KERNEL__ */
 
-static inline __u32 get_be32(__be32 *p)
-{
-	unsigned char *cp = (unsigned char *) p;
-	__u32 ret;
-
-	ret = *cp++;
-	ret = (ret << 8) + *cp++;
-	ret = (ret << 8) + *cp++;
-	ret = (ret << 8) + *cp++;
-	return ret;
-}
-
-static inline __u16 get_be16(__be16 *p)
-{
-	unsigned char *cp = (unsigned char *) p;
-	__u16 ret;
-
-	ret = *cp++;
-	ret = (ret << 8) + *cp++;
-	return ret;
-}
 
 /*
  * Read a block from the journal
@@ -232,10 +211,10 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 
 		nr++;
 		tagp += tag_bytes;
-		if (!(get_be16(&tag->t_flags) & JBD2_FLAG_SAME_UUID))
+		if (!(tag->t_flags & cpu_to_be16(JBD2_FLAG_SAME_UUID)))
 			tagp += 16;
 
-		if (get_be16(&tag->t_flags) & JBD2_FLAG_LAST_TAG)
+		if (tag->t_flags & cpu_to_be16(JBD2_FLAG_LAST_TAG))
 			break;
 	}
 
@@ -358,9 +337,9 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 static inline unsigned long long read_tag_block(journal_t *journal,
 						journal_block_tag_t *tag)
 {
-	unsigned long long block = get_be32(&tag->t_blocknr);
+	unsigned long long block = be32_to_cpu(tag->t_blocknr);
 	if (jbd2_has_feature_64bit(journal))
-		block |= (u64)get_be32(&tag->t_blocknr_high) << 32;
+		block |= (u64)be32_to_cpu(tag->t_blocknr_high) << 32;
 	return block;
 }
 
@@ -429,9 +408,9 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
 	csum32 = jbd2_chksum(j, csum32, buf, j->j_blocksize);
 
 	if (jbd2_has_feature_csum3(j))
-		return get_be32(&tag3->t_checksum) == csum32;
-
-	return get_be16(&tag->t_checksum) == (csum32 & 0xFFFF);
+		return tag3->t_checksum == cpu_to_be32(csum32);
+	else
+		return tag->t_checksum == cpu_to_be16(csum32);
 }
 
 static int do_one_pass(journal_t *journal,
@@ -579,7 +558,7 @@ static int do_one_pass(journal_t *journal,
 				unsigned long io_block;
 
 				tag = (journal_block_tag_t *) tagp;
-				flags = get_be16(&tag->t_flags);
+				flags = be16_to_cpu(tag->t_flags);
 
 				io_block = next_log_block++;
 				wrap(journal, next_log_block);
@@ -643,9 +622,8 @@ static int do_one_pass(journal_t *journal,
 					memcpy(nbh->b_data, obh->b_data,
 							journal->j_blocksize);
 					if (flags & JBD2_FLAG_ESCAPE) {
-						__be32 magic = cpu_to_be32(JBD2_MAGIC_NUMBER);
-						memcpy(nbh->b_data, &magic,
-						       sizeof(magic));
+						*((__be32 *)nbh->b_data) =
+						cpu_to_be32(JBD2_MAGIC_NUMBER);
 					}
 
 					BUFFER_TRACE(nbh, "marking dirty");
diff --git a/lib/ext2fs/bitops.h b/lib/ext2fs/bitops.h
index 505b3c9c..3c7b2496 100644
--- a/lib/ext2fs/bitops.h
+++ b/lib/ext2fs/bitops.h
@@ -247,6 +247,14 @@ extern errcode_t ext2fs_find_first_set_generic_bmap(ext2fs_generic_bitmap bitmap
 #endif /* __STDC_VERSION__ >= 199901L */
 #endif /* INCLUDE_INLINE_FUNCS */
 
+/* Macros for kernel compatibility */
+#define be32_to_cpu(x)		ext2fs_be32_to_cpu(x)
+#define le32_to_cpu(x)		ext2fs_le32_to_cpu(x)
+#define le16_to_cpu(x)		ext2fs_le16_to_cpu(x)
+
+#define cpu_to_be32(x)		ext2fs_cpu_to_be32(x)
+#define cpu_to_be16(x)		ext2fs_cpu_to_be16(x)
+#define cpu_to_le16(x)		ext2fs_cpu_to_le16(x)
 /*
  * Fast bit set/clear functions that doesn't need to return the
  * previous bit value.
-- 
2.29.2.454.gaff20da3a2-goog

