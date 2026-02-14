Return-Path: <linux-ext4+bounces-13697-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIzSB+XokGkOdwEAu9opvQ
	(envelope-from <linux-ext4+bounces-13697-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 22:28:05 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D4013D686
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 22:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43FE1302E75E
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D943128BA;
	Sat, 14 Feb 2026 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoc6O6o9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286C3115BD;
	Sat, 14 Feb 2026 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104399; cv=none; b=ToKr+pcnU/mF4Av7sYwrqlR/vEsZMnwkUJDjZdB8PJQwNQ0iMMucrBMR8cKq5KTgnOjJblQUxI92QyzWZ1k4Ef76YZQyaGyDUwg2XmimO2PpvCzwp4tW8pN4zEY8d2CE4DKllaeAEFKSfF9DovJ8WnJ0kPHUAENrPZ3kfBfsaDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104399; c=relaxed/simple;
	bh=q2OrGAGT4GzPReLnJmMn03YBJ9yj2jYhHDFCk80CV0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFJpn66s3CsCVdTamYM3aqOyD4uxGXKu5Dd2UHkDq46+TCtsL8R5OPp5RdFN1WZstlm6Wfi/r4usp4QMhXc/SGZDTpGrAl+J80tqNAE5bqu2IY/gSH5ST9ThiSWSBEZpzr9fB/D1rDhQmkwBewH6h3vQ3R5yPF8r6XSwngwtBFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoc6O6o9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C413C19422;
	Sat, 14 Feb 2026 21:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104398;
	bh=q2OrGAGT4GzPReLnJmMn03YBJ9yj2jYhHDFCk80CV0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qoc6O6o9AC/2n4dpBphHHYjugyKvSl6/hRuZWKchhqklWTMs7sTeA52pLSra9e74y
	 nFONir8GxeJ2UZN4OH5GY5cHxRsacLyvpTlAsrl1G1fKaHRS8u8mvcl98O7y6Ww603
	 QEE1dMB6jFNktVksqGc9Kzryv9qTRlYBK7m+ezLNor2a7ZQt8aEBUoMuAUfN4W+DHu
	 eT/xHBos+ZrDRFze2v9mFfFBCRGUjv8YIZ7sG1e5A5U9E3EYej3Dc0UicCycojI6hr
	 Pm5oqT4vsWhgZ6ByONmKfVWLTJID6SE3yw68Ij76Q29IYPBb/CKUzqIWv4e7RDa3fB
	 sM/I9bOjWoYCw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.15] ext4: mark group add fast-commit ineligible
Date: Sat, 14 Feb 2026 16:23:27 -0500
Message-ID: <20260214212452.782265-62-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214212452.782265-1-sashal@kernel.org>
References: <20260214212452.782265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13697-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.beauty:email,msgid.link:url]
X-Rspamd-Queue-Id: E1D4013D686
X-Rspamd-Action: no action

From: Li Chen <me@linux.beauty>

[ Upstream commit 89b4336fd5ec78f51f9d3a1d100f3ffa3228e604 ]

Fast commits only log operations that have dedicated replay support.
Online resize via EXT4_IOC_GROUP_ADD updates the superblock and group
descriptor metadata without going through the fast commit tracking
paths.
In practice these operations are rare and usually followed by further
updates, but mixing them into a fast commit makes the overall
semantics harder to reason about and risks replay gaps if new call
sites appear.

Teach ext4 to mark the filesystem fast-commit ineligible when
ext4_ioctl_group_add() adds new block groups.
This forces those transactions to fall back to a full commit,
ensuring that the filesystem geometry updates are captured by the
normal journal rather than partially encoded in fast commit TLVs.
This change should not affect common workloads but makes online
resize via GROUP_ADD safer and easier to reason about under fast
commit.

Testing:
1. prepare:
    dd if=/dev/zero of=/root/fc_resize.img bs=1M count=0 seek=256
    mkfs.ext4 -O fast_commit -F /root/fc_resize.img
    mkdir -p /mnt/fc_resize && mount -t ext4 -o loop /root/fc_resize.img /mnt/fc_resize
2. Ran a helper that issues EXT4_IOC_GROUP_ADD on the mounted
   filesystem and checked the resize ineligible reason:
    ./group_add_helper /mnt/fc_resize
    cat /proc/fs/ext4/loop0/fc_info
   shows "Resize": > 0.
3. Fsynced a file on the resized filesystem and verified that the fast
   commit stats report at least one ineligible commit:
    touch /mnt/fc_resize/file
    /root/fsync_file /mnt/fc_resize/file
    sync
    cat /proc/fs/ext4/loop0/fc_info
   shows fc stats ineligible > 0.

Signed-off-by: Li Chen <me@linux.beauty>
Link: https://patch.msgid.link/20251211115146.897420-5-me@linux.beauty
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

So this is part of a series by the same author. There are three resize
paths:
1. `EXT4_IOC_RESIZE_FS` (already had `ext4_fc_mark_ineligible` from the
   original fast commit implementation)
2. `EXT4_IOC_GROUP_EXTEND` (fixed by `1f8dd813a1c77` - the companion
   commit)
3. `EXT4_IOC_GROUP_ADD` (fixed by this commit under review)

Both this commit and `1f8dd813a1c77` are from the same patch series
(patches 5 and 6 of the series based on the msgid link). They're
independent fixes to two different ioctl paths.

### 7. DEPENDENCY CHECK

This commit depends on:
- `EXT4_FC_REASON_RESIZE` existing in `fast_commit.h` — this was added
  in `aa75f4d3daaeb` (5.10 era, "ext4: main fast-commit commit path")
- The `ext4_fc_mark_ineligible()` API accepting `(sb, reason, NULL)` —
  the NULL handle variant was introduced in `e85c81ba8859a` which went
  to stable

The fast commit feature itself was added in Linux 5.10, so this fix
applies to 5.10+ stable trees. The API with 3 arguments (sb, reason,
handle) was introduced in `e85c81ba8859a` which was 5.17-era and was
already tagged Cc: stable. So the function signature should be available
in 5.15+ stable trees at minimum.

### SUMMARY

**What the commit fixes**: A missing fast-commit ineligibility marking
in the `EXT4_IOC_GROUP_ADD` resize path. Without this, filesystem
geometry changes from GROUP_ADD could be mixed with fast commits,
leading to potential filesystem inconsistency after crash recovery
because the fast commit replay has no dedicated handler for resize
operations.

**Severity**: Medium-high. While the scenario requires specific
conditions (fast_commit enabled + GROUP_ADD resize + crash timing), the
consequence is filesystem corruption/inconsistency, which is a data
integrity issue.

**Risk**: Extremely low. Single line addition that mirrors existing code
in the same file. The only effect is forcing a full journal commit
instead of fast commit during GROUP_ADD, which is the correct and safe
behavior. No regression possible.

**Meets stable criteria**:
- Obviously correct: YES (mirrors existing pattern)
- Fixes a real bug: YES (potential filesystem corruption on crash)
- Small and contained: YES (1 line)
- No new features: YES
- Already tested: YES

**Concern**: This is one of a pair of patches (the other being
`1f8dd813a1c77` for GROUP_EXTEND). Both should be backported together
for completeness, but each is independently valuable — they fix
different ioctl paths.

**YES**

 fs/ext4/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7ce0fc40aec2f..5109b005e0286 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -966,6 +966,7 @@ static long ext4_ioctl_group_add(struct file *file,
 
 	err = ext4_group_add(sb, input);
 	if (EXT4_SB(sb)->s_journal) {
+		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE, NULL);
 		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
 		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
-- 
2.51.0


