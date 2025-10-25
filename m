Return-Path: <linux-ext4+bounces-11085-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D5C0996B
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Oct 2025 18:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B06D1C8144A
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Oct 2025 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC8313292;
	Sat, 25 Oct 2025 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVr5kKUf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F9313286;
	Sat, 25 Oct 2025 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409390; cv=none; b=WS0KTDR4ALPXy8y0vqUrxSY22NNKSirqjMpCipJkZucbRnXHo90u7LxzsoQwma82fqHZHW8ovoiQM3ZgH0fe5jCzGb/VQ/0tTp2ppx0IGuO5oND4PTngRsuELQuGX3fXPZmumBUcZm9ODlgTTNpbpEpSY+oMd9b+dWn1sKNY34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409390; c=relaxed/simple;
	bh=wtCywLTFkiRyb4YuANo/iy9dCbFZ3i6HWTknPNjyz4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTsNCsfMPh1/rP9jK9JE+kPZQWA1ywcfwu3cb1iR58QvDUXO2x13qtdK+GLN0dFi2qgVtomgP2k2S7jsOsVb/7kUqF0yIOqkTshFSrHBi75vnOQT2Jz5M72js+RTVY9VnllbV3fZGJNYfjgoYaat6KTnaGJ8KhDDV3px9L4hnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVr5kKUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83D3C4CEF5;
	Sat, 25 Oct 2025 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409390;
	bh=wtCywLTFkiRyb4YuANo/iy9dCbFZ3i6HWTknPNjyz4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVr5kKUftcTYcZ/9tJSTZnPs3ldKCxcFbFFHfF9CbqprfyuZHq5BemuJpQP77770g
	 0uehxRD8G0+FLEQsYieadjLgjd01RrCQ1wudD1mJPWx/dftFHMKQs6Vmf+kmrufKq2
	 fE0OdmVnHagUIrJLcW5PIiEcJguDnylQurkodSjs8u/9xg67l2s6QFJLOYF6xE0cbF
	 04XoYufVofI2q87dtznRhciGgFui0BkHK6GPbamj3t0pGmeLfn1TDle+kaaHPdZYJD
	 RFZ8yQbcGIr7gr1Ymv9zDAmK7OTn5atZBw4M7OQgj+sqZo/78DdvOZWMFMmoz8lKzm
	 /n5oF/lSIfNWQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Julian Sun <sunjunchao@bytedance.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] ext4: increase IO priority of fastcommit
Date: Sat, 25 Oct 2025 11:58:53 -0400
Message-ID: <20251025160905.3857885-302-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Julian Sun <sunjunchao@bytedance.com>

[ Upstream commit 46e75c56dfeafb6756773b71cabe187a6886859a ]

The following code paths may result in high latency or even task hangs:
   1. fastcommit io is throttled by wbt.
   2. jbd2_fc_wait_bufs() might wait for a long time while
JBD2_FAST_COMMIT_ONGOING is set in journal->flags, and then
jbd2_journal_commit_transaction() waits for the
JBD2_FAST_COMMIT_ONGOING bit for a long time while holding the write
lock of j_state_lock.
   3. start_this_handle() waits for read lock of j_state_lock which
results in high latency or task hang.

Given the fact that ext4_fc_commit() already modifies the current
process' IO priority to match that of the jbd2 thread, it should be
reasonable to match jbd2's IO submission flags as well.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Message-ID: <20250827121812.1477634-1-sunjunchao@bytedance.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – aligning fast-commit writes with the journal’s request flags fixes
real stall/hang scenarios without introducing new risk.

**Bug Impact**
- When `ext4_fc_submit_bh()` tags fast-commit buffers with only
  `REQ_SYNC`, writeback throttling treats them as ordinary sync writes
  and can block them, triggering the long waits called out in the commit
  message; see the change at `fs/ext4/fast_commit.c:666`.
- WBT explicitly exempts requests carrying both `REQ_SYNC` and
  `REQ_IDLE`, so the old flag set lets throttling kick in (`block/blk-
  wbt.c:606`), holding `JBD2_FAST_COMMIT_ONGOING`, which then stalls
  `jbd2_fc_wait_bufs()` (`fs/jbd2/journal.c:868-895`) and anything
  needing `j_state_lock`. That behavior matches the reported high
  latencies / task hangs.

**Why the Fix Is Safe**
- `JBD2_JOURNAL_REQ_FLAGS` expands to `REQ_META | REQ_SYNC | REQ_IDLE`
  (`include/linux/jbd2.h:1372`), exactly what core journaling already
  uses for its writes (`fs/jbd2/commit.c:122`). Fast commits simply
  inherit the same metadata/high-priority treatment.
- The change is a single-line adjustment confined to the fast-commit
  buffer submission path, with no format or architectural impact and no
  new dependencies (the macro has existed long before fast commits
  shipped).
- Ext4 already boosts the committing task’s IO priority to match the
  journal thread (`fs/ext4/fast_commit.c:1211-1218`); matching the
  submission flags keeps behavior consistent and predictable.

Given the real-world stalls this resolves, the minimal and well-
understood code change, and its tight scope within ext4 fast commits, it
aligns with stable-tree rules and should be backported.

 fs/ext4/fast_commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 42bee1d4f9f97..fa66b08de9994 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -663,7 +663,7 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
 
 static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
 {
-	blk_opf_t write_flags = REQ_SYNC;
+	blk_opf_t write_flags = JBD2_JOURNAL_REQ_FLAGS;
 	struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
 
 	/* Add REQ_FUA | REQ_PREFLUSH only its tail */
-- 
2.51.0


