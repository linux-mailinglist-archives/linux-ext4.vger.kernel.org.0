Return-Path: <linux-ext4+bounces-13698-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EQAIt3pkGkOdwEAu9opvQ
	(envelope-from <linux-ext4+bounces-13698-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 22:32:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F413D923
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 22:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC70C30B4F8F
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7183313293;
	Sat, 14 Feb 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcq47aLC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B9309DB1;
	Sat, 14 Feb 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104423; cv=none; b=FfE+mivRqDbEctu0278pZ3y3hwGa8LdsJwcs2zAsMKy2CKIvH8hffeshDTcFAtDS/JgrXWkngNt8pxMNPrzhuoXyXYFS8coX9czbuiSoegD3F91492HOJIR39kGCj9hOic+MnflEwNVI5mpo8/vG5MlajChjfF7jsFaB033ATvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104423; c=relaxed/simple;
	bh=j88ihCWn0Rg3H31RZvvLFcG5R1vRQN4ClT5ZFfmu8Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ng++APLfQL8nx9cxLgAq5j9qutNL+fzzE2rJcR+w5yV/n8u61FrYeqpzJ4cUb1j90sTJVtQ7TEvlhHOeDYaptC/3NDNWwMO+CQTi6zVkQcvPrZxtX4DjHiywjY401qM1onIo816GyI2TP63BLtTUuBFvsBJYy44GoyR+C2O/oKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcq47aLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E975C19423;
	Sat, 14 Feb 2026 21:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104423;
	bh=j88ihCWn0Rg3H31RZvvLFcG5R1vRQN4ClT5ZFfmu8Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gcq47aLCRTCmMruHlSzw1tAEcA6J4IyrI2T47vJNZCQAvLkapnn/8Y1pfPmpo4Z9y
	 h/hKrb06DMm1YC4Ak6JumbmCbFFERdk/bXWUfrpxvMcD635uOJSQGtBOPPPn8Ay2qI
	 7hBuxWvbwNT9TyoRwD5Js1DkJTLOTSE5JrB02xkL9Wpna58nieQKc96BDuRha+KxNw
	 RzYOSlCu11aXXgc4W7kxlDVYPIRswoOVFS4bydT6BgdwW7JZznSfO7UxzRdnBz6i0M
	 BF5k0JBwB+cOY4RhEFtQJby8Tzm6OLT5cJoxJx3+qO4oPkk1bNv6xCtojyZsuykfJe
	 yvn+tUD+gl5QA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] ext4: propagate flags to convert_initialized_extent()
Date: Sat, 14 Feb 2026 16:23:42 -0500
Message-ID: <20260214212452.782265-77-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13698-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,suse.cz:email,msgid.link:url]
X-Rspamd-Queue-Id: 020F413D923
X-Rspamd-Action: no action

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit 3fffa44b6ebf65be92a562a5063303979385a1c9 ]

Currently, ext4_zero_range passes EXT4_EX_NOCACHE flag to avoid caching
extents however this is not respected by convert_initialized_extent().
Hence, modify it to accept flags from the caller and to pass the flags
on to other extent manipulation functions it calls. This makes
sure the NOCACHE flag is respected throughout the code path.

Also, we no longer explicitly pass CONVERT_UNWRITTEN as the caller takes
care of this.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/07008fbb14db727fddcaf4c30e2346c49f6c8fe0.1769149131.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

### 4. Deeper Analysis: Is This Just Performance or Correctness?

The investigation reveals important nuances:

**EXT4_EX_NOCACHE** prevents populating the extent status (ES) tree
cache during operations like `ext4_zero_range`. The purpose is stated in
the code: "we shouldn't be caching the extents when reading from the
extent tree while a truncate or punch hole operation is in progress."

The reason is **correctness, not just performance**: During operations
that modify the extent tree (like zero_range, which splits/converts
extents), caching intermediate extent states can leave **stale entries**
in the ES tree. Recent fixes (commits `6d882ea3b0931` and
`c2b3575dfcc7f` from Nov 2025, both Cc: stable) explicitly address data
corruption from stale extent cache entries during these exact
operations.

**However**, the specific code path in this commit:

1. `ext4_find_extent()` with flags=0 instead of flags with NOCACHE -
   this means extents get cached when they shouldn't be during
   `convert_initialized_extent()`
2. `ext4_split_convert_extents()` was getting hardcoded
   `EXT4_GET_BLOCKS_CONVERT_UNWRITTEN` instead of the caller's flags
   (which include both `CONVERT_UNWRITTEN` and `NOCACHE`)

### 5. Risk and Scope Assessment

**Changes are small and surgical:**
- Only 1 file changed (fs/ext4/extents.c)
- Function signature change: adding `int flags` parameter
- 3 call sites modified: passing `flags` instead of hardcoded values
- Net code change is minimal

**Risk of regression:** LOW
- The flags being propagated are the same flags the caller already has
- The hardcoded `EXT4_GET_BLOCKS_CONVERT_UNWRITTEN` was already included
  in the `flags` from the caller (the call site check `flags &
  EXT4_GET_BLOCKS_CONVERT_UNWRITTEN` confirms this)
- The main behavioral change is that `EXT4_EX_NOCACHE` now reaches these
  inner functions

**Subsystem impact:** HIGH - ext4 is the most widely used Linux
filesystem

### 6. Does It Fix a Real Bug?

Yes. While the commit message is understated, the actual bug is:
- `ext4_zero_range` deliberately sets `EXT4_EX_NOCACHE` to prevent stale
  extent cache entries during extent tree modifications
- But `convert_initialized_extent()` was dropping this flag, leading to
  extents being cached during the modification operation
- This can cause stale extent cache entries, which related commits have
  proven can lead to **data corruption**

The commit message says "makes sure the NOCACHE flag is respected
throughout the code path" - this is a correctness fix for extent cache
consistency.

### 7. Dependency Check

The commit is self-contained. It modifies a static function and its
single call site within the same file. No external dependencies.

### 8. Summary

| Criterion | Assessment |
|-----------|-----------|
| Fixes real bug | YES - stale extent cache during zero_range can cause
corruption |
| Obviously correct | YES - propagating caller flags is the right
pattern |
| Small and contained | YES - minimal changes to one file |
| Risk of regression | LOW - only adds flag propagation that was already
intended |
| Subsystem importance | HIGH - ext4 filesystem |
| User impact | MEDIUM-HIGH - affects anyone using fallocate/zero_range
on ext4 |

This commit fixes a real correctness issue in ext4's extent cache
management during `ext4_zero_range` operations. The NOCACHE flag was
being dropped, which could lead to stale extent cache entries - a class
of bug that has been directly linked to data corruption in related
recent fixes. The change is small, surgical, obviously correct, and
carries minimal regression risk.

**YES**

 fs/ext4/extents.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f1322f64071ff..4e97d1e7213f3 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3818,6 +3818,7 @@ static struct ext4_ext_path *
 convert_initialized_extent(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map,
 			   struct ext4_ext_path *path,
+			   int flags,
 			   unsigned int *allocated)
 {
 	struct ext4_extent *ex;
@@ -3843,11 +3844,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
 		path = ext4_split_convert_extents(handle, inode, map, path,
-				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
+						  flags, NULL);
 		if (IS_ERR(path))
 			return path;
 
-		path = ext4_find_extent(inode, map->m_lblk, path, 0);
+		path = ext4_find_extent(inode, map->m_lblk, path, flags);
 		if (IS_ERR(path))
 			return path;
 		depth = ext_depth(inode);
@@ -4259,7 +4260,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			if ((!ext4_ext_is_unwritten(ex)) &&
 			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
 				path = convert_initialized_extent(handle,
-					inode, map, path, &allocated);
+					inode, map, path, flags, &allocated);
 				if (IS_ERR(path))
 					err = PTR_ERR(path);
 				goto out;
-- 
2.51.0


