Return-Path: <linux-ext4+bounces-14279-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ur3UHyCuo2m0JwUAu9opvQ
	(envelope-from <linux-ext4+bounces-14279-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 04:10:24 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EEB1CE462
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 04:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E5EF34C5768
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 02:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0F2F39BE;
	Sun,  1 Mar 2026 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0c7EMht"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E986416132A;
	Sun,  1 Mar 2026 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330444; cv=none; b=Of83CpxtQwIysee5kKbZJbegnsuU+f8PedweP7hAs66QYbPuyHWUkF7hPaxEYGFSx51lhbW63Jdrrqhz+EXJHkdVFI3TY6O49a8aaBhoFm38Gs4ozX037XyBM1vL1sl2mltn21a2yqx+N+5s8sunugL9JeiYarcwgN7xqTdG7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330444; c=relaxed/simple;
	bh=ZFGpzz1x+/9G9QYHarv39c/85mrHKt/72clX8cIHM7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzqjGxZLEU9hzaM2R2kU3fhHmd8yVXICOnDiLKtNr4iTf2SDNi7V/WdTHJU5sTOsFpTeRRt8Rd3pFWCy4mEiRZ4n0wHf/6m8xOAEhYUKgF+93ouThVPfmNKbvfhTWh7Iv5rbX5L5N1/eYmyxbDSJePLTwwN4FOzuTiKHwZr4qVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0c7EMht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183F8C19421;
	Sun,  1 Mar 2026 02:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330443;
	bh=ZFGpzz1x+/9G9QYHarv39c/85mrHKt/72clX8cIHM7w=;
	h=From:To:Cc:Subject:Date:From;
	b=S0c7EMhtGCTlUAnEONp74B+VSDeuArGdIZIkl33k/CCMaG0HGyMx2R8QOtVUa9C7W
	 I3MYYWfmX1iPzRk6Ru8DOvjLUjMwoOK32NJk9TwDn8F+hiTWp3tpbHy44FWm3HcRSM
	 1DaONWaW8ew0qqSrKcCrfFO42k2knP7v4+/yIwjUfvIQKgxJgKzbNCrBM+MLuYXLS2
	 WWW25AaA6B6/AfL2Qm52xma9GLz/o4T3LnXEdnUVzwUi+lPHR2VA1q/mzGhmMSLcCW
	 Fbv/roNgGyqNlK71CHy0OibhzKM9DfDVM8OUek/R96pTtniw7KnjCFd7Vvf+thpfk6
	 Rei/dN9YqUYFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yi.zhang@huawei.com
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: FAILED: Patch "ext4: don't cache extent during splitting extent" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:00:41 -0500
Message-ID: <20260301020042.1726967-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14279-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:email]
X-Rspamd-Queue-Id: E7EEB1CE462
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8b4b19a2f96348d70bfa306ef7d4a13b0bcbea79 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Sat, 29 Nov 2025 18:32:37 +0800
Subject: [PATCH] ext4: don't cache extent during splitting extent

Caching extents during the splitting process is risky, as it may result
in stale extents remaining in the status tree. Moreover, in most cases,
the corresponding extent block entries are likely already cached before
the split happens, making caching here not particularly useful.

Assume we have an unwritten extent, and then DIO writes the first half.

  [UUUUUUUUUUUUUUUU] on-disk extent        U: unwritten extent
  [UUUUUUUUUUUUUUUU] extent status tree
  |<-   ->| ----> dio write this range

First, when ext4_split_extent_at() splits this extent, it truncates the
existing extent and then inserts a new one. During this process, this
extent status entry may be shrunk, and calls to ext4_find_extent() and
ext4_cache_extents() may occur, which could potentially insert the
truncated range as a hole into the extent status tree. After the split
is completed, this hole is not replaced with the correct status.

  [UUUUUUU|UUUUUUUU] on-disk extent        U: unwritten extent
  [UUUUUUU|HHHHHHHH] extent status tree    H: hole

Then, the outer calling functions will not correct this remaining hole
extent either. Finally, if we perform a delayed buffer write on this
latter part, it will re-insert the delayed extent and cause an error in
space accounting.

In adition, if the unwritten extent cache is not shrunk during the
splitting, ext4_cache_extents() also conflicts with existing extents
when caching extents. In the future, we will add checks when caching
extents, which will trigger a warning. Therefore, Do not cache extents
that are being split.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Message-ID: <20251129103247.686136-6-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/extents.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index daecf3f0b367c..be9fd2ab86679 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3199,6 +3199,9 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
 	       (split_flag & EXT4_EXT_DATA_VALID2));
 
+	/* Do not cache extents that are in the process of being modified. */
+	flags |= EXT4_EX_NOCACHE;
+
 	ext_debug(inode, "logical block %llu\n", (unsigned long long)split);
 
 	ext4_ext_show_leaf(inode, path);
@@ -3381,6 +3384,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 	ee_len = ext4_ext_get_actual_len(ex);
 	unwritten = ext4_ext_is_unwritten(ex);
 
+	/* Do not cache extents that are in the process of being modified. */
+	flags |= EXT4_EX_NOCACHE;
+
 	if (map->m_lblk + map->m_len < ee_block + ee_len) {
 		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
 		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
-- 
2.51.0





