Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B80C15DE48
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2020 17:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389664AbgBNQDc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Feb 2020 11:03:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389648AbgBNQDa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 14 Feb 2020 11:03:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBB1124654;
        Fri, 14 Feb 2020 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696209;
        bh=jwaeIp2MEMtqr9PJUVmeKPM5rbDAUa0EDOJ3hWpd4tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIe4p+7cZisWnKhF8gucmFTCd/yT6nZ7ePkomlxo+1fYkSz2lNZe+CYc39EF0mzrg
         GUpJA+cEwRXjkWalJ4P0ilDVAeGn/gAgpzmWl8cokFfk4Mo5Q4mf5C7PEWakftpIug
         wAjDmVai3jAFLPbJ3TvEkH3CeoAi+nYlNRgPglqM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 074/459] ext4: fix deadlock allocating bio_post_read_ctx from mempool
Date:   Fri, 14 Feb 2020 10:55:24 -0500
Message-Id: <20200214160149.11681-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 68e45330e341dad2d3a0a3f8ef2ec46a2a0a3bbc ]

Without any form of coordination, any case where multiple allocations
from the same mempool are needed at a time to make forward progress can
deadlock under memory pressure.

This is the case for struct bio_post_read_ctx, as one can be allocated
to decrypt a Merkle tree page during fsverity_verify_bio(), which itself
is running from a post-read callback for a data bio which has its own
struct bio_post_read_ctx.

Fix this by freeing the first bio_post_read_ctx before calling
fsverity_verify_bio().  This works because verity (if enabled) is always
the last post-read step.

This deadlock can be reproduced by trying to read from an encrypted
verity file after reducing NUM_PREALLOC_POST_READ_CTXS to 1 and patching
mempool_alloc() to pretend that pool->alloc() always fails.

Note that since NUM_PREALLOC_POST_READ_CTXS is actually 128, to actually
hit this bug in practice would require reading from lots of encrypted
verity files at the same time.  But it's theoretically possible, as N
available objects isn't enough to guarantee forward progress when > N/2
threads each need 2 objects at a time.

Fixes: 22cfe4b48ccb ("ext4: add fs-verity read support")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20191231181222.47684-1-ebiggers@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/readpage.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index a30b203fa461c..a5f55fece9b04 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -57,6 +57,7 @@ enum bio_post_read_step {
 	STEP_INITIAL = 0,
 	STEP_DECRYPT,
 	STEP_VERITY,
+	STEP_MAX,
 };
 
 struct bio_post_read_ctx {
@@ -106,10 +107,22 @@ static void verity_work(struct work_struct *work)
 {
 	struct bio_post_read_ctx *ctx =
 		container_of(work, struct bio_post_read_ctx, work);
+	struct bio *bio = ctx->bio;
 
-	fsverity_verify_bio(ctx->bio);
+	/*
+	 * fsverity_verify_bio() may call readpages() again, and although verity
+	 * will be disabled for that, decryption may still be needed, causing
+	 * another bio_post_read_ctx to be allocated.  So to guarantee that
+	 * mempool_alloc() never deadlocks we must free the current ctx first.
+	 * This is safe because verity is the last post-read step.
+	 */
+	BUILD_BUG_ON(STEP_VERITY + 1 != STEP_MAX);
+	mempool_free(ctx, bio_post_read_ctx_pool);
+	bio->bi_private = NULL;
 
-	bio_post_read_processing(ctx);
+	fsverity_verify_bio(bio);
+
+	__read_end_io(bio);
 }
 
 static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
-- 
2.20.1

