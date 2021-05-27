Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBE3394434
	for <lists+linux-ext4@lfdr.de>; Fri, 28 May 2021 16:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhE1Obf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 May 2021 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhE1Obe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 May 2021 10:31:34 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C62C061574
        for <linux-ext4@vger.kernel.org>; Fri, 28 May 2021 07:30:00 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id k2so1953778qvc.5
        for <linux-ext4@vger.kernel.org>; Fri, 28 May 2021 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c1rPXBx2GaPg7VIOiEFz2/jnCDWfRtCDC7jv3JVhJuQ=;
        b=t7ANI4WjNUS1Xjf6LYQeutXDqoBL+kRdQyg+QJSO+Dza17WlCOLQruTkKhBpXGuLCu
         bw3vdxCjk/56/NisxxANjdqPbsHQ5SHhtfynv2fPWEzLhJjmmss1h9yfldzGlUQImGqV
         A0a1cXND///Br0MiXJtsXeW1IBWrYFNFbS102YiUQrxcNToxMdVO7h63235bWHSFHwnf
         e915uo2NkMj3tXbJTj9zQxOrMveQmuhKqgyv4DO5t278EkGJH9QY6a4XUi0l1AbNzs0j
         zsf1UeuZ0/dHD7Je1shU/RnvNo5k6DG3l7+vnM+bkyHEPxsarWDZB5GGncjwUyyAEzt4
         7ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c1rPXBx2GaPg7VIOiEFz2/jnCDWfRtCDC7jv3JVhJuQ=;
        b=lsenDdNasZCo5n/NsdSJy4sWWdpqphYZTBF1UWjTP/Ywi1YPe5YMfpulc2u7dmDwHf
         /hymytwpcXAsgzYcZ5Xrfcb7SdVY17wvz9cHVg1ZI7E311YatE9W1fdHpTmGsynWx/nK
         5NW7vWuIBJBvrCqNbs6HersUDggKwwgjBsRSsUx0EsvPi9OyGu4x7P+iTKuS/mRi+20M
         tryrJ+bLY0uuco0BgoNiFIluR9XeAtuIueD9dOYTtRNBFGg2CwQ3/1btXHfA+XDhv31F
         Y1UmArVfU9N2xvzVqUwgdZ/EKvvHTqZAN3YgoRno66qgyhmbzgJqw+Menca4X/Yv1JXr
         a77g==
X-Gm-Message-State: AOAM532iQ2jw9mqAIE7BYrO8Pwo4Xil/L201lNoRYYQR+o5gDjaDn+Qf
        ZbfGpI6h4jCC810og2JQw3MupYV8jJW8/Rwk
X-Google-Smtp-Source: ABdhPJzWf4Ub5xdRT33ONim4ZySUY353yACKI4KYAXOp24u+FCiIVvsNWQ2eyAq4TCAOkmgAfTL5Uw==
X-Received: by 2002:a05:6214:b0b:: with SMTP id u11mr4276774qvj.9.1622212197821;
        Fri, 28 May 2021 07:29:57 -0700 (PDT)
Received: from CO82.us.cray.com ([136.162.34.1])
        by smtp.gmail.com with ESMTPSA id 90sm3535285qtg.9.2021.05.28.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:29:57 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [PATCH] e2fsck: replay all commits except broken ones
Date:   Thu, 27 May 2021 04:57:07 -0400
Message-Id: <20210527085707.91688-1-artem.blagodarenko@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

E2fsck interrupts journal replay if a broken transaction is found.
Journal is replayed partly. Some useful transactions are not replayed.

Let's change this behavior and process all transactions except broken ones
if "-E repair_journal" option is set.

HPE-bug-id: LUS-9452
---
 e2fsck/e2fsck.h         |  1 +
 e2fsck/journal.c        |  3 +++
 e2fsck/recovery.c       | 41 +++++++++++++++++++++++++++++++----------
 e2fsck/unix.c           |  3 +++
 lib/e2p/feature.c       |  2 ++
 lib/ext2fs/kernel-jbd.h |  5 ++++-
 misc/ext4.5.in          |  4 ++++
 7 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 15d043ee..7dccc8e4 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -179,6 +179,7 @@ struct resource_track {
 #define E2F_OPT_UNSHARE_BLOCKS  0x40000
 #define E2F_OPT_CLEAR_UNINIT	0x80000 /* Hack to clear the uninit bit */
 #define E2F_OPT_CHECK_ENCODING  0x100000 /* Force verification of encoded filenames */
+#define E2F_OPT_REPAIR_JOURNAL	0x200000 /* Apply all possible from journal */
 
 /*
  * E2fsck flags
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index a425bbd1..9b84c477 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -1620,6 +1620,9 @@ static errcode_t recover_ext3_journal(e2fsck_t ctx)
 	if (retval)
 		return retval;
 
+	if (ctx->options & E2F_OPT_REPAIR_JOURNAL)
+		jbd2_set_feature_repair(journal);
+
 	retval = e2fsck_journal_load(journal);
 	if (retval)
 		goto errout;
diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index dc0694fc..5aa3e529 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -33,6 +33,7 @@ struct recovery_info
 	int		nr_replays;
 	int		nr_revokes;
 	int		nr_revoke_hits;
+	int             nr_skipped;
 };
 
 static int do_one_pass(journal_t *journal,
@@ -313,8 +314,9 @@ int jbd2_journal_recover(journal_t *journal)
 	jbd_debug(1, "JBD2: recovery, exit status %d, "
 		  "recovered transactions %u to %u\n",
 		  err, info.start_transaction, info.end_transaction);
-	jbd_debug(1, "JBD2: Replayed %d and revoked %d/%d blocks\n",
-		  info.nr_replays, info.nr_revoke_hits, info.nr_revokes);
+	jbd_debug(1, "JBD2: Replayed %d, skipped %d, and revoked %d/%d blocks\n",
+		  info.nr_replays, info.nr_skipped, info.nr_revoke_hits,
+		  info.nr_revokes);
 
 	/* Restart the log at the next transaction ID, thus invalidating
 	 * any existing commit records in the log. */
@@ -787,16 +789,35 @@ static int do_one_pass(journal_t *journal,
 				}
 
 				/* Neither checksum match nor unused? */
-				if (!((crc32_sum == found_chksum &&
-				       cbh->h_chksum_type ==
-						JBD2_CRC32_CHKSUM &&
-				       cbh->h_chksum_size ==
-						JBD2_CRC32_CHKSUM_SIZE) ||
-				      (cbh->h_chksum_type == 0 &&
-				       cbh->h_chksum_size == 0 &&
-				       found_chksum == 0)))
+				if (cbh->h_chksum_type == 0 &&
+				    cbh->h_chksum_size == 0 &&
+				    found_chksum == 0)
 					goto chksum_error;
 
+				if (!(crc32_sum = found_chksum &&
+				    cbh->h_chksum_type == JBD2_CRC32_CHKSUM &&
+				    cbh->h_chksum_size ==
+						JBD2_CRC32_CHKSUM_SIZE)) {
+					if (jbd2_has_feature_repair(journal)) {
+						/*
+						 * Commit with wrong checksum.
+						 * Let's skip it. There are
+						 * some corect commits after.
+						*/
+						++info->nr_skipped;
+						jbd_debug(1, "JBD2: "
+							  "crc32_sum(0x%x)i !="
+							  " found_chksum(0x%x)"
+							  ". Skipped.\n",
+							  crc32_sum,
+							  found_chksum);
+						brelse(bh);
+						next_commit_ID++;
+					} else {
+						goto chksum_error;
+					}
+				}
+
 				crc32_sum = ~0;
 			}
 			if (pass == PASS_SCAN &&
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index c5f9e441..fc7649fc 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -763,6 +763,9 @@ static void parse_extended_opts(e2fsck_t ctx, const char *opts)
 			ctx->options |= E2F_OPT_CLEAR_UNINIT;
 			continue;
 #endif
+		} else if (strcmp(token, "repair_journal") == 0) {
+			ctx->options |= E2F_OPT_REPAIR_JOURNAL;
+			continue; 
 		} else {
 			fprintf(stderr, _("Unknown extended option: %s\n"),
 				token);
diff --git a/lib/e2p/feature.c b/lib/e2p/feature.c
index 22910602..6cd11384 100644
--- a/lib/e2p/feature.c
+++ b/lib/e2p/feature.c
@@ -134,6 +134,8 @@ static struct feature jrnl_feature_list[] = {
                        "journal_checksum_v2" },
        {       E2P_FEATURE_INCOMPAT, JBD2_FEATURE_INCOMPAT_CSUM_V3,
                        "journal_checksum_v3" },
+       {       E2P_FEATURE_INCOMPAT, JBD2_FEATURE_INCOMPAT_REPAIR,
+			"journal_repair" },
        {       0, 0, 0 },
 };
 
diff --git a/lib/ext2fs/kernel-jbd.h b/lib/ext2fs/kernel-jbd.h
index 2978ccb6..4a2cef20 100644
--- a/lib/ext2fs/kernel-jbd.h
+++ b/lib/ext2fs/kernel-jbd.h
@@ -265,6 +265,7 @@ typedef struct journal_superblock_s
 #define JBD2_FEATURE_INCOMPAT_CSUM_V2		0x00000008
 #define JBD2_FEATURE_INCOMPAT_CSUM_V3		0x00000010
 #define JBD2_FEATURE_INCOMPAT_FAST_COMMIT	0x00000020
+#define JBD2_FEATURE_INCOMPAT_REPAIR		0x00000040
 
 /* Features known to this kernel version: */
 #define JBD2_KNOWN_COMPAT_FEATURES	0
@@ -274,7 +275,8 @@ typedef struct journal_superblock_s
 					 JBD2_FEATURE_INCOMPAT_64BIT|\
 					 JBD2_FEATURE_INCOMPAT_CSUM_V2|	\
 					 JBD2_FEATURE_INCOMPAT_CSUM_V3 | \
-					 JBD2_FEATURE_INCOMPAT_FAST_COMMIT)
+					 JBD2_FEATURE_INCOMPAT_FAST_COMMIT | \
+					 JBD2_FEATURE_INCOMPAT_REPAIR)
 
 #ifdef NO_INLINE_FUNCS
 extern size_t journal_tag_bytes(journal_t *journal);
@@ -392,6 +394,7 @@ JBD2_FEATURE_INCOMPAT_FUNCS(async_commit,	ASYNC_COMMIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
 JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
+JBD2_FEATURE_INCOMPAT_FUNCS(repair,		REPAIR)
 
 #if (defined(E2FSCK_INCLUDE_INLINE_FUNCS) || !defined(NO_INLINE_FUNCS))
 /*
diff --git a/misc/ext4.5.in b/misc/ext4.5.in
index 90bc4f88..95266864 100644
--- a/misc/ext4.5.in
+++ b/misc/ext4.5.in
@@ -574,6 +574,10 @@ Commit block can be written to disk without waiting for descriptor blocks. If
 enabled older kernels cannot mount the device.
 This will enable 'journal_checksum' internally.
 .TP
+.B journal_repair
+If journal is broken, apply all valid transactions and pass
+all broken ones(with invalid crc).
+.TP
 .BR barrier=0 " / " barrier=1 " / " barrier " / " nobarrier
 These mount options have the same effect as in ext3.  The mount options
 "barrier" and "nobarrier" are added for consistency with other ext4 mount
-- 
2.18.4

