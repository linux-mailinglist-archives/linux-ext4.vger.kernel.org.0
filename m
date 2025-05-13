Return-Path: <linux-ext4+bounces-7816-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2C3AB4B14
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 07:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8123A7DE4
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 05:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BA61E6DC5;
	Tue, 13 May 2025 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs+zhuj7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C81E5734
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747114734; cv=none; b=FiLuyGif8M6qWz/0ko61CJE9Hz7++hTMzLdVLU74IjJKlY1AxbYJbY+XLguAxP7MMWnoA4/1jnFtac79CsspRaejGTJaQeuS+ytZhNtPWw+dbc9eYlkQbBUmnjxCdpSIBdrpyguuMWwysLDDzLCuLEvXNvHrq+NCjeNPq45x04Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747114734; c=relaxed/simple;
	bh=RBxG8SWCEKJyl5sYeDjC7/sRTSf+IuHwN5o2xM2azGw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7h2EhyPfN+PRs6Mnt50CDXVwwEF14RX9BGWlKKVqDi5SloCw03dRi90m/k0o0VZ3dc51EoS0Smq8cvr3a5RGsGbqMJpt7p5GD34b5wqFzoBFpn6zg5DyMNaOrUaSEc0+gSM02fuXALrKE9QYHLL8sA02eYfSBTj8yy4VxUMEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs+zhuj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D00AC4CEF1
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 05:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747114734;
	bh=RBxG8SWCEKJyl5sYeDjC7/sRTSf+IuHwN5o2xM2azGw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Zs+zhuj78SBv7WMwSR+5jPxo21LRYr3WI1EvlsrrQ9lxVzhHqZHWIAxU6CKDX1Qtv
	 ZEh076s3ErYBDfplcA0izbSClrLCFxgUdorxog0uu6KLmnL/I7ttObLtgcj7pdpbMc
	 yvSIC5Km9cmA5KRT0GMBcUFLEJ2MBmeBb1El1EcMkefTHo1QMNGApSuEbzgBOw37YY
	 3oFkJtijppSJ1LihHEmK9BV0A0cscaDbnivDMjPrTlEB0J9G0AYw1ct/keeo6IY/Cg
	 ycB8tzwUk5+vnysqU9XEJVJAcOnO13QNjMXxQVONQCx9lIE3StdoeI6SJA/h9eEkGK
	 tnNM03zXKMKYA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-ext4@vger.kernel.org
Subject: [PATCH 4/4] jbd2: remove journal_t argument from jbd2_superblock_csum()
Date: Mon, 12 May 2025 22:38:09 -0700
Message-ID: <20250513053809.699974-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513053809.699974-1-ebiggers@kernel.org>
References: <20250513053809.699974-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Since jbd2_superblock_csum() no longer uses its journal_t argument,
remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/jbd2/journal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 255fa03031d8..46a09744e27a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -113,11 +113,11 @@ void __jbd2_debug(int level, const char *file, const char *func,
 	va_end(args);
 }
 #endif
 
 /* Checksumming functions */
-static __be32 jbd2_superblock_csum(journal_t *j, journal_superblock_t *sb)
+static __be32 jbd2_superblock_csum(journal_superblock_t *sb)
 {
 	__u32 csum;
 	__be32 old_csum;
 
 	old_csum = sb->s_checksum;
@@ -1384,11 +1384,11 @@ static int journal_check_superblock(journal_t *journal)
 			printk(KERN_ERR "JBD2: Unknown checksum type\n");
 			return err;
 		}
 
 		/* Check superblock checksum */
-		if (sb->s_checksum != jbd2_superblock_csum(journal, sb)) {
+		if (sb->s_checksum != jbd2_superblock_csum(sb)) {
 			printk(KERN_ERR "JBD2: journal checksum error\n");
 			err = -EFSBADCRC;
 			return err;
 		}
 	}
@@ -1819,11 +1819,11 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 		       journal->j_devname);
 		clear_buffer_write_io_error(bh);
 		set_buffer_uptodate(bh);
 	}
 	if (jbd2_journal_has_csum_v2or3(journal))
-		sb->s_checksum = jbd2_superblock_csum(journal, sb);
+		sb->s_checksum = jbd2_superblock_csum(sb);
 	get_bh(bh);
 	bh->b_end_io = end_buffer_write_sync;
 	submit_bh(REQ_OP_WRITE | write_flags, bh);
 	wait_on_buffer(bh);
 	if (buffer_write_io_error(bh)) {
-- 
2.49.0


