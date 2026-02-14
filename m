Return-Path: <linux-ext4+bounces-13699-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHabEfLpkGkfdwEAu9opvQ
	(envelope-from <linux-ext4+bounces-13699-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 22:32:34 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CC013D961
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 22:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE775302B81A
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 21:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABAF2309B9;
	Sat, 14 Feb 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr0bemsT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D72FDC20;
	Sat, 14 Feb 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104435; cv=none; b=LCYY6q1U98zjs5LHaF3o6ylFn7zO/R2hHVFgA6uBk5+69V1lDTqxRYzT52dw3I6wbXZ4SDtO5JOlRlBn0BTNTKcGjMxHjAjqubOwcx+cqEQOkt462hGGbQcmvucnvQenZCiJHDER81f6VsPf/OHdzM0xOhnxZcdNAkyYYB3yT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104435; c=relaxed/simple;
	bh=U+tA0vkY6vpqXtXMkjENXllx3tPQws0mO8+SdxXCtMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6/ixl5MJu0OKOnkN+FhHzUyiKg/krG6YWsswo1v0zJLCGmYHOphqhYuTptM2FU0Yt6KQZSiGD6pL1fF7ocaa9lBlZEpilwAmB4dG3uUOoLR97d36S3eYE5TaJ1WxzNwD6SQKQJWMcgUaY6V11VikWTviAtfrfrqhZKZ6vcv3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr0bemsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46EDC16AAE;
	Sat, 14 Feb 2026 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104435;
	bh=U+tA0vkY6vpqXtXMkjENXllx3tPQws0mO8+SdxXCtMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zr0bemsTJBGExQlNcYboNX5rDuv0if6cMPvq5qVrnNrq5W3HInCNfm2gmM5UpxqdU
	 MscBFedcPs4eDIqtlMnfMDs1TFsJj78b0R6Jum7r2rqU8P3ubsUvMUcNOuhqHiZyhF
	 N4j3D9cjQmc098I04Ezd1TXJfslIinupMA24VWmJQ0TpwxIyj394ck+tJwrIswequp
	 fpRiC9mG7y9Qs01QkgIZBWiwNvXR/E/5UsJ8uLXY/yX69HvjTP1FeSa6XEICQdWFrd
	 ZmGg9/D4QxkNKtN1bGyt+3b62UvvfUMI2w1J99WioqZpgDvkGQRB3wTFpl7lBC2aNO
	 O+CaAa3KnmXYQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.15] ext4: mark group extend fast-commit ineligible
Date: Sat, 14 Feb 2026 16:23:47 -0500
Message-ID: <20260214212452.782265-82-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13699-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.beauty:email]
X-Rspamd-Queue-Id: C5CC013D961
X-Rspamd-Action: no action

From: Li Chen <me@linux.beauty>

[ Upstream commit 1f8dd813a1c771b13c303f73d876164bc9b327cc ]

Fast commits only log operations that have dedicated replay support.
EXT4_IOC_GROUP_EXTEND grows the filesystem to the end of the last
block group and updates the same on-disk metadata without going
through the fast commit tracking paths.
In practice these operations are rare and usually followed by further
updates, but mixing them into a fast commit makes the overall
semantics harder to reason about and risks replay gaps if new call
sites appear.

Teach ext4 to mark the filesystem fast-commit ineligible when
EXT4_IOC_GROUP_EXTEND grows the filesystem.
This forces those transactions to fall back to a full commit,
ensuring that the group extension changes are captured by the normal
journal rather than partially encoded in fast commit TLVs.
This change should not affect common workloads but makes online
resize via GROUP_EXTEND safer and easier to reason about under fast
commit.

Testing:
1. prepare:
    dd if=/dev/zero of=/root/fc_resize.img bs=1M count=0 seek=256
    mkfs.ext4 -O fast_commit -F /root/fc_resize.img
    mkdir -p /mnt/fc_resize && mount -t ext4 -o loop /root/fc_resize.img /mnt/fc_resize
2. Extended the filesystem to the end of the last block group using a
   helper that calls EXT4_IOC_GROUP_EXTEND on the mounted filesystem
   and checked fc_info:
    ./group_extend_helper /mnt/fc_resize
    cat /proc/fs/ext4/loop0/fc_info
   shows the "Resize" ineligible reason increased.
3. Fsynced a file on the resized filesystem and confirmed that the fast
   commit ineligible counter incremented for the resize transaction:
    touch /mnt/fc_resize/file
    /root/fsync_file /mnt/fc_resize/file
    sync
    cat /proc/fs/ext4/loop0/fc_info

Signed-off-by: Li Chen <me@linux.beauty>
Link: https://patch.msgid.link/20251211115146.897420-6-me@linux.beauty
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

### 4. DETAILED FINDINGS

This is extremely revealing. The investigation shows:

**A real gap exists:** `EXT4_IOC_RESIZE_FS` already has
`ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE, NULL)`, but
`EXT4_IOC_GROUP_EXTEND` (and `EXT4_IOC_GROUP_ADD` in a sibling commit)
do **not**. This is an inconsistency — all three ioctls perform
filesystem geometry changes that are not supported by fast commit
replay.

**No replay support for geometry changes:** The fast commit replay logic
only handles file-level operations (add_range, del_range, link, unlink,
creat, inode). There are NO replay tags for superblock or group
descriptor changes. If `GROUP_EXTEND` runs and a fast commit is used
instead of a full journal commit, the geometry changes would not be
replayed on crash recovery.

**This is a data integrity issue:** If a fast commit transaction
includes both file operations (which are tracked) and geometry changes
from `GROUP_EXTEND` (which are untracked), crash recovery could replay
the file operations against stale filesystem geometry, leading to silent
metadata inconsistency or corruption.

### 5. CLASSIFICATION

This is a **correctness/data integrity fix**, not a feature addition. It
closes a gap where filesystem metadata changes could be lost or
inconsistently replayed after a crash. The `EXT4_FC_REASON_RESIZE` enum
value already exists — only the missing call site is added.

### 6. SCOPE AND RISK

- **Size:** 2 lines added. Minimal.
- **Risk:** Extremely low. The only effect is forcing a full journal
  commit instead of a fast commit during `GROUP_EXTEND`. Full commits
  are always correct; fast commits are the optimization. This is a
  fallback to the safe path.
- **Subsystem:** ext4 filesystem — widely used, data integrity matters
  enormously.
- **Could it break anything?** No. A full commit is strictly more
  conservative than a fast commit. The worst case is a minor performance
  impact during online resize, which is an infrequent operation.

### 7. USER IMPACT

- **Who is affected?** Anyone using ext4 with fast_commit enabled who
  performs online resize via `GROUP_EXTEND`. While this is not a common
  operation, when it does happen, data integrity on crash recovery is
  critical.
- **Severity if triggered:** Without this fix, crash recovery after
  `GROUP_EXTEND` + fast commit could result in filesystem metadata
  inconsistency — potentially data corruption.
- **Practical likelihood:** Low frequency, but high severity when it
  occurs.

### 8. DEPENDENCY CHECK

- The `EXT4_FC_REASON_RESIZE` enum already exists in stable trees (it
  was added when `RESIZE_FS` was given this marking).
- The `ext4_fc_mark_ineligible()` function already exists.
- This is a self-contained, standalone fix with no dependencies on other
  commits.
- There is a sibling commit for `GROUP_ADD` that would be good to
  backport together, but each stands alone.

### 9. STABLE KERNEL RULES ASSESSMENT

| Criterion | Assessment |
|-----------|-----------|
| Obviously correct and tested | Yes — mirrors existing pattern for
RESIZE_FS, tested by author |
| Fixes a real bug | Yes — missing fast-commit ineligibility marking can
lead to incomplete crash recovery |
| Important issue | Yes — data integrity / potential corruption on crash
recovery |
| Small and contained | Yes — 2 lines in one file |
| No new features | Correct — uses existing infrastructure |
| Applies cleanly | Very likely — minimal change to stable code |

### 10. RISK vs BENEFIT

- **Risk:** Near zero. Forces a safe fallback path for a rare operation.
- **Benefit:** Prevents potential filesystem metadata inconsistency
  after crash during online resize with fast commit enabled.

### CONCLUSION

This is a small, surgical, correctness fix for a real gap in ext4's fast
commit mechanism. The `RESIZE_FS` ioctl already had this protection, but
`GROUP_EXTEND` was missed. The fix prevents potential data integrity
issues during crash recovery. It uses existing infrastructure
(`EXT4_FC_REASON_RESIZE` and `ext4_fc_mark_ineligible()`), is self-
contained, and has effectively zero regression risk. It meets all stable
kernel criteria.

**YES**

 fs/ext4/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 5109b005e0286..e5e197ac7d88b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1612,6 +1612,8 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		err = ext4_group_extend(sb, EXT4_SB(sb)->s_es, n_blocks_count);
 		if (EXT4_SB(sb)->s_journal) {
+			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE,
+						NULL);
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
 			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
-- 
2.51.0


