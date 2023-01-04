Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A614665CF02
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 10:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjADJDo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 04:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjADJDi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 04:03:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E46B1B
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 01:03:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD194B810FA
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 09:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59660C433D2
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 09:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672823015;
        bh=6NX0oFmfOIN7QvXTLxB3SKKdVoLe9WJ94+VBUec1j9o=;
        h=From:To:Subject:Date:From;
        b=WMPYmxQbZbCTIw0YMXqalrxJRgqiY0ncWFhxaRP2yK1I2TlLSd+XeMzCT71XemIn3
         wjKDcvivyfoeAf492T56igACS/Mx4zFQ/Sbg2aGsOjqCTOyy1pg1S8sp42SrcBYod4
         T895jS67TEtrnTV0hEK3ED4AOUQ9l04HRurqI9W7az7ugx5VAZ5KSYHJpG+xm3kDCR
         9d3ItuSEpaYmzZR0z57BXpClcOGmaCAKESxCEa+U4Q75oQfGTAbnWXZWgvp7ExyuNO
         MfG9Q9XCH5D172253saw5ph2CtGS+FphXEozNCeSenIpyTFLMFIXIXsJU1S9hgS29z
         e58l7Uw7ka+3w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [e2fsprogs PATCH] libsupport: clean up definition of flags_array
Date:   Wed,  4 Jan 2023 01:03:23 -0800
Message-Id: <20230104090323.276063-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add braces to address the following compiler warning with gcc -Wall:

print_fs_flags.c:24:42: warning: missing braces around initializer [-Wmissing-braces]
   24 | static struct flags_name flags_array[] = {
      |                                          ^

Also add 'const', and add an explicit NULL in the last entry.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/support/print_fs_flags.c | 60 ++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/lib/support/print_fs_flags.c b/lib/support/print_fs_flags.c
index e54acc04..f47cd665 100644
--- a/lib/support/print_fs_flags.c
+++ b/lib/support/print_fs_flags.c
@@ -21,40 +21,40 @@ struct flags_name {
 	const char	*name;
 };
 
-static struct flags_name flags_array[] = {
-	EXT2_FLAG_RW, "EXT2_FLAG_RW",
-	EXT2_FLAG_CHANGED, "EXT2_FLAG_CHANGED",
-	EXT2_FLAG_DIRTY, "EXT2_FLAG_DIRTY",
-	EXT2_FLAG_VALID, "EXT2_FLAG_VALID",
-	EXT2_FLAG_IB_DIRTY, "EXT2_FLAG_IB_DIRTY",
-	EXT2_FLAG_BB_DIRTY, "EXT2_FLAG_BB_DIRTY",
-	EXT2_FLAG_SWAP_BYTES, "EXT2_FLAG_SWAP_BYTES",
-	EXT2_FLAG_SWAP_BYTES_READ, "EXT2_FLAG_SWAP_BYTES_READ",
-	EXT2_FLAG_SWAP_BYTES_WRITE, "EXT2_FLAG_SWAP_BYTES_WRITE",
-	EXT2_FLAG_MASTER_SB_ONLY, "EXT2_FLAG_MASTER_SB_ONLY",
-	EXT2_FLAG_FORCE, "EXT2_FLAG_FORCE",
-	EXT2_FLAG_SUPER_ONLY, "EXT2_FLAG_SUPER_ONLY",
-	EXT2_FLAG_JOURNAL_DEV_OK, "EXT2_FLAG_JOURNAL_DEV_OK",
-	EXT2_FLAG_IMAGE_FILE, "EXT2_FLAG_IMAGE_FILE",
-	EXT2_FLAG_EXCLUSIVE, "EXT2_FLAG_EXCLUSIVE",
-	EXT2_FLAG_SOFTSUPP_FEATURES, "EXT2_FLAG_SOFTSUPP_FEATURES",
-	EXT2_FLAG_NOFREE_ON_ERROR, "EXT2_FLAG_NOFREE_ON_ERROR",
-	EXT2_FLAG_64BITS, "EXT2_FLAG_64BITS",
-	EXT2_FLAG_PRINT_PROGRESS, "EXT2_FLAG_PRINT_PROGRESS",
-	EXT2_FLAG_DIRECT_IO, "EXT2_FLAG_DIRECT_IO",
-	EXT2_FLAG_SKIP_MMP, "EXT2_FLAG_SKIP_MMP",
-	EXT2_FLAG_IGNORE_CSUM_ERRORS, "EXT2_FLAG_IGNORE_CSUM_ERRORS",
-	EXT2_FLAG_SHARE_DUP, "EXT2_FLAG_SHARE_DUP",
-	EXT2_FLAG_IGNORE_SB_ERRORS, "EXT2_FLAG_IGNORE_SB_ERRORS",
-	EXT2_FLAG_BBITMAP_TAIL_PROBLEM, "EXT2_FLAG_BBITMAP_TAIL_PROBLEM",
-	EXT2_FLAG_IBITMAP_TAIL_PROBLEM, "EXT2_FLAG_IBITMAP_TAIL_PROBLEM",
-	EXT2_FLAG_THREADS, "EXT2_FLAG_THREADS",
-	0
+static const struct flags_name flags_array[] = {
+	{ EXT2_FLAG_RW, "EXT2_FLAG_RW" },
+	{ EXT2_FLAG_CHANGED, "EXT2_FLAG_CHANGED" },
+	{ EXT2_FLAG_DIRTY, "EXT2_FLAG_DIRTY" },
+	{ EXT2_FLAG_VALID, "EXT2_FLAG_VALID" },
+	{ EXT2_FLAG_IB_DIRTY, "EXT2_FLAG_IB_DIRTY" },
+	{ EXT2_FLAG_BB_DIRTY, "EXT2_FLAG_BB_DIRTY" },
+	{ EXT2_FLAG_SWAP_BYTES, "EXT2_FLAG_SWAP_BYTES" },
+	{ EXT2_FLAG_SWAP_BYTES_READ, "EXT2_FLAG_SWAP_BYTES_READ" },
+	{ EXT2_FLAG_SWAP_BYTES_WRITE, "EXT2_FLAG_SWAP_BYTES_WRITE" },
+	{ EXT2_FLAG_MASTER_SB_ONLY, "EXT2_FLAG_MASTER_SB_ONLY" },
+	{ EXT2_FLAG_FORCE, "EXT2_FLAG_FORCE" },
+	{ EXT2_FLAG_SUPER_ONLY, "EXT2_FLAG_SUPER_ONLY" },
+	{ EXT2_FLAG_JOURNAL_DEV_OK, "EXT2_FLAG_JOURNAL_DEV_OK" },
+	{ EXT2_FLAG_IMAGE_FILE, "EXT2_FLAG_IMAGE_FILE" },
+	{ EXT2_FLAG_EXCLUSIVE, "EXT2_FLAG_EXCLUSIVE" },
+	{ EXT2_FLAG_SOFTSUPP_FEATURES, "EXT2_FLAG_SOFTSUPP_FEATURES" },
+	{ EXT2_FLAG_NOFREE_ON_ERROR, "EXT2_FLAG_NOFREE_ON_ERROR" },
+	{ EXT2_FLAG_64BITS, "EXT2_FLAG_64BITS" },
+	{ EXT2_FLAG_PRINT_PROGRESS, "EXT2_FLAG_PRINT_PROGRESS" },
+	{ EXT2_FLAG_DIRECT_IO, "EXT2_FLAG_DIRECT_IO" },
+	{ EXT2_FLAG_SKIP_MMP, "EXT2_FLAG_SKIP_MMP" },
+	{ EXT2_FLAG_IGNORE_CSUM_ERRORS, "EXT2_FLAG_IGNORE_CSUM_ERRORS" },
+	{ EXT2_FLAG_SHARE_DUP, "EXT2_FLAG_SHARE_DUP" },
+	{ EXT2_FLAG_IGNORE_SB_ERRORS, "EXT2_FLAG_IGNORE_SB_ERRORS" },
+	{ EXT2_FLAG_BBITMAP_TAIL_PROBLEM, "EXT2_FLAG_BBITMAP_TAIL_PROBLEM" },
+	{ EXT2_FLAG_IBITMAP_TAIL_PROBLEM, "EXT2_FLAG_IBITMAP_TAIL_PROBLEM" },
+	{ EXT2_FLAG_THREADS, "EXT2_FLAG_THREADS" },
+	{ 0, NULL },
 };
 
 void print_fs_flags(FILE * f, unsigned long flags)
 {
-	struct flags_name *fp;
+	const struct flags_name *fp;
 	int	first = 1, pos = 16;
 
 	for (fp = flags_array; fp->flag != 0; fp++) {
-- 
2.39.0

