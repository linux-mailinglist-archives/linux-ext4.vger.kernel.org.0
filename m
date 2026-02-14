Return-Path: <linux-ext4+bounces-13695-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI0NKa3pkGkOdwEAu9opvQ
	(envelope-from <linux-ext4+bounces-13695-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 22:31:25 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABB513D8B7
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 22:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B85830BBC9A
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A509311956;
	Sat, 14 Feb 2026 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xin2MogE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E3142E83;
	Sat, 14 Feb 2026 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104366; cv=none; b=t3mfFLKYcNC4nqex9VXmV1ZJQN6xUdFCHdjxoTdg18G5P1Wd8CP03MV+MRpkdMWoTVuAx+f7VHDEJ3VIB6wvozMWGUMFTe7+kf1m01htTOTdxhNjoIInd9huhvJMgYHdEqEm/lz5F0wdGFs8nukh+cD33X24faU6TgkYMzw7RDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104366; c=relaxed/simple;
	bh=vdvTBmCb5EyZhJSrdOW0ZnvI83pSoJKJxd61EWia9dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGu0kbTgCmULEHaCW+kWdp5+cFpV8dXA7JmDNT9dwF7c749AsxngW9pEiVer0CGKpGI8KSmx17KrhnZq37IFWg3OY/5nILeWDeoyJWK7A9Fa8038j6kfRDN0eQYvpadnklsc3C46oE4laN0ecNGEGTbuIeQsHJN8FSGQXCB8Vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xin2MogE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF39C16AAE;
	Sat, 14 Feb 2026 21:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104365;
	bh=vdvTBmCb5EyZhJSrdOW0ZnvI83pSoJKJxd61EWia9dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xin2MogEv1/wpCLxPsDkd237Id1o7L/7hHuH35+hAI4NFSWJQRXCDKcFI7xfgAWlY
	 bEhV26yjCaUacq3TRN7fHElRcW4wLpI25NW5Tj6QuEaw8aZorlCTvlrMBCyVfEWTRH
	 +5tda9z8Kj+yZYrYvvPPh6bme+cANsCU2QYrefnZncrkvpVaPTCjlN0JSbwkwtcN8/
	 2FtoJDBjNCTi6u0hlQfuY4MEKEGHUGkTztwrdUsiKCJsHXoontIobv35HwawJmhsnX
	 8CbhA7WdIrqZlvchy1UuLYFvoPc8iYD/L0AZhXc/KFjX6ccCkBPmJcRdjGoleGOsGg
	 tFkcMnD4uaaIg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] ext4: use reserved metadata blocks when splitting extent on endio
Date: Sat, 14 Feb 2026 16:23:09 -0500
Message-ID: <20260214212452.782265-44-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13695-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,huawei.com:email]
X-Rspamd-Queue-Id: 0ABB513D8B7
X-Rspamd-Action: no action

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 01942af95ab6c9d98e64ae01fdc243a03e4b973f ]

When performing buffered writes, we may need to split and convert an
unwritten extent into a written one during the end I/O process. However,
we do not reserve space specifically for these metadata changes, we only
reserve 2% of space or 4096 blocks. To address this, we use
EXT4_GET_BLOCKS_PRE_IO to potentially split extents in advance and
EXT4_GET_BLOCKS_METADATA_NOFAIL to utilize reserved space if necessary.

These two approaches can reduce the likelihood of running out of space
and losing data. However, these methods are merely best efforts, we
could still run out of space, and there is not much difference between
converting an extent during the writeback process and the end I/O
process, it won't increase the risk of losing data if we postpone the
conversion.

Therefore, also use EXT4_GET_BLOCKS_METADATA_NOFAIL in
ext4_convert_unwritten_extents_endio() to prepare for the buffered I/O
iomap conversion, which may perform extent conversion during the end I/O
process.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20260105014522.1937690-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The commit message says "to prepare for the buffered I/O iomap
conversion, which may perform extent conversion during the end I/O
process." This suggests it's preparation for a future change. However,
the bug exists **independently** — even in the current code path through
`ext4_ext_handle_unwritten_extents`, the flag is set at line 3908 but
the `ext4_convert_unwritten_extents_endio` function hardcodes only
`EXT4_GET_BLOCKS_CONVERT` when calling `ext4_split_convert_extents` at
line 3779-3780.

Wait — let me re-read the flow more carefully. When
`ext4_ext_handle_unwritten_extents()` calls
`ext4_convert_unwritten_extents_endio()`, the flags variable with
`METADATA_NOFAIL` is local to `ext4_ext_handle_unwritten_extents()`.
`ext4_convert_unwritten_extents_endio()` doesn't receive those flags as
a parameter — it constructs its own flags (`EXT4_GET_BLOCKS_CONVERT`)
internally at line 3780. So **the METADATA_NOFAIL flag is NOT
propagated** to the split operation inside
`ext4_convert_unwritten_extents_endio()`.

This is a real bug that exists in the current codebase, not just a
preparation for future code. The split operation during endio can fail
with ENOSPC because it doesn't use reserved metadata blocks.

### 3. Classification

**Bug fix**: Prevents potential data loss on near-full ext4 filesystems
when extent splitting is needed during endio. When the filesystem is
nearly full, the extent conversion can fail because it doesn't tap into
the reserved metadata pool. This failure at endio means written data may
appear as unwritten (zeroed), which is **data loss**.

### 4. Scope and Risk Assessment

- **Lines changed**: ~5 lines (adding one flag to an existing call)
- **Files changed**: 1 (fs/ext4/extents.c)
- **Risk**: Extremely low. The `EXT4_GET_BLOCKS_METADATA_NOFAIL` flag is
  already used elsewhere in the same function's caller
  (`ext4_ext_handle_unwritten_extents`). This just ensures the flag is
  also used when the called function internally needs to split extents.
- **Subsystem**: ext4 — the most widely used Linux filesystem. Affects
  everyone.

### 5. User Impact

- **Who**: Any user with an ext4 filesystem that is near-full performing
  buffered writes where extent splitting is needed during endio
- **Severity**: Data loss — written data appears zeroed because the
  extent remains marked as unwritten
- **Likelihood**: Increases as filesystem fills up; real-world scenario
  on busy servers

### 6. Stability Indicators

- **Reviewed-by**: Jan Kara (ext4 co-maintainer), Baokun Li, Ojaswin
  Mujoo — three reviewers
- **Committed-by**: Theodore Ts'o (ext4 maintainer)
- This level of review indicates high confidence in the fix

### 7. Dependency Check

The change is entirely self-contained. It only adds an existing flag
(`EXT4_GET_BLOCKS_METADATA_NOFAIL`) to an existing function call. No
dependencies on other commits. The affected code
(`ext4_convert_unwritten_extents_endio`) has been in the kernel for many
years and exists in all stable trees.

### Summary

This is a small, surgical fix for a real data loss scenario in ext4 —
the most widely used Linux filesystem. When the filesystem is near full,
extent conversion during endio can fail because it doesn't use the
reserved metadata block pool. The fix adds a single flag
(`EXT4_GET_BLOCKS_METADATA_NOFAIL`) that was already supposed to be
propagated but wasn't. It's been reviewed by three ext4 experts
including the subsystem maintainer. The risk is minimal and the benefit
is preventing data loss.

**YES**

 fs/ext4/extents.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2cf5759ba6894..f1322f64071ff 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3770,6 +3770,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	 * illegal.
 	 */
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
+		int flags = EXT4_GET_BLOCKS_CONVERT |
+			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
 #ifdef CONFIG_EXT4_DEBUG
 		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
 			     " len %u; IO logical block %llu, len %u",
@@ -3777,7 +3779,7 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 			     (unsigned long long)map->m_lblk, map->m_len);
 #endif
 		path = ext4_split_convert_extents(handle, inode, map, path,
-						EXT4_GET_BLOCKS_CONVERT, NULL);
+						  flags, NULL);
 		if (IS_ERR(path))
 			return path;
 
-- 
2.51.0


