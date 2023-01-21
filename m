Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDCA676957
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjAUUhD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjAUUgs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7032915E
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72C9460ADD
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B8DC433A7;
        Sat, 21 Jan 2023 20:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333403;
        bh=js4EoiNuVDSE622JrtozM8VHganSNbk0FH7XROPaiHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PyyguBZmVU9j5aXZQqlkKXqpe1FGMjJ6MajMTNdEExVyeuwm3JS/lUgxRE83JymcV
         8d0h/CUJSCAJclO2uNMmYyuGAb+c354mMmOMtuVGbqPX+y3W5HWneVZe3KFD7qIcAf
         rvncf+XCWf9BRayiC1zXmhFClqdntko1ju38R7lMgY+ph+YMLgakBW9XSp/gd3Gj0o
         B7rQzazvfswf5R6KbBU8kxiJluibBzTJJ6zrE5FWH4UivA464k0t/0rX7OHU7nEpHm
         skMrlZzM63Bbf2ToVVI6zLivdRH9nYIvNlvqvP5TQDBmuFLIRYNwageEIe1ptva/o+
         +R8fQtok6AuyA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 24/38] lib/support: clean up definition of flags_array
Date:   Sat, 21 Jan 2023 12:32:16 -0800
Message-Id: <20230121203230.27624-25-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
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

Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/support/print_fs_flags.c | 60 ++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/lib/support/print_fs_flags.c b/lib/support/print_fs_flags.c
index e54acc04b..f47cd6653 100644
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

