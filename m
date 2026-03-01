Return-Path: <linux-ext4+bounces-14259-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLKHEpiao2l4IAUAu9opvQ
	(envelope-from <linux-ext4+bounces-14259-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:47:04 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D601CBB10
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E32EF30913D9
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 01:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5652D3EEA;
	Sun,  1 Mar 2026 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp/fdOIm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6C29B795;
	Sun,  1 Mar 2026 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329338; cv=none; b=nq6AD+MUXWYmMf77cbwiytUMCkY9KDhybGZgyTszmvRF5j0PsRY5mG8/WYDUQf22pddD0FUMq59I7hVpSVhflHWZUWPkjipF58DROdjlqBDxOwcy5cyi9ceqoOiRNm6/hL82MDX5r8AHJ0lBWLxTYJrcREiE/S8oMkIcqq1Kqas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329338; c=relaxed/simple;
	bh=yW6OHSpxhyVjHV/gi9B+6WDmw8M3IawGvSsZ5T7yuT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHPKqnV310oiy9YcwEnBJlEaGrZqa87hGwTn9/8SmSVC09QrqKQxe0hPHTZ32Quc0oFpM06wfMMDf0UNufAsByiwQ/3yzBCFW2uHMiUzmp/FXLziZXwKx5dLDNixIZ+qDMFe67Se2ZdxME4rkUwzdAoLP+vdhlkwWvR+IYlwhxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp/fdOIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E10C19421;
	Sun,  1 Mar 2026 01:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329338;
	bh=yW6OHSpxhyVjHV/gi9B+6WDmw8M3IawGvSsZ5T7yuT4=;
	h=From:To:Cc:Subject:Date:From;
	b=qp/fdOImRMndnDIY6y0N8PlxNN4yUOhkwN0wo7ZPvGr5k9skG06bKTwanl8IjHS4U
	 3KaZ5bTMRrf2nyl1u1JoJ/aaJxNVqla9QKOILdsMSVGrYROqx0uuca4RnzAAyz8uvd
	 kbdGaFTLX95gAzFd29o7NhzvngpgQWjL/My4TEP6xQSTP0GwBC2AhYCLw3tOpOEa9H
	 k//T3BfkqPzF1hxF/gszkdK/j+8aalNN0IdGsIQcODVUKi2soBkB5GBvJYQvRWGofb
	 kqTgFS2GR5Zq+j6a9SVaJUta9kWSQLQ2n1zF2GHHsTJ/+STH3V035oh2LguToK/CTP
	 NmhZR1uATsUUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yi.zhang@huawei.com
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: FAILED: Patch "ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:42:16 -0500
Message-ID: <20260301014216.1704094-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14259-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 02D601CBB10
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1bf6974822d1dba86cf11b5f05498581cf3488a2 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Sat, 29 Nov 2025 18:32:34 +0800
Subject: [PATCH] ext4: don't zero the entire extent if
 EXT4_EXT_DATA_PARTIAL_VALID1

When allocating initialized blocks from a large unwritten extent, or
when splitting an unwritten extent during end I/O and converting it to
initialized, there is currently a potential issue of stale data if the
extent needs to be split in the middle.

       0  A      B  N
       [UUUUUUUUUUUU]    U: unwritten extent
       [--DDDDDDDD--]    D: valid data
          |<-  ->| ----> this range needs to be initialized

ext4_split_extent() first try to split this extent at B with
EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_MAY_ZEROOUT flag set, but
ext4_split_extent_at() failed to split this extent due to temporary lack
of space. It zeroout B to N and mark the entire extent from 0 to N
as written.

       0  A      B  N
       [WWWWWWWWWWWW]    W: written extent
       [SSDDDDDDDDZZ]    Z: zeroed, S: stale data

ext4_split_extent() then try to split this extent at A with
EXT4_EXT_DATA_VALID2 flag set. This time, it split successfully and left
a stale written extent from 0 to A.

       0  A      B   N
       [WW|WWWWWWWWWW]
       [SS|DDDDDDDDZZ]

Fix this by pass EXT4_EXT_DATA_PARTIAL_VALID1 to ext4_split_extent_at()
when splitting at B, don't convert the entire extent to written and left
it as unwritten after zeroing out B to N. The remaining work is just
like the standard two-part split. ext4_split_extent() will pass the
EXT4_EXT_DATA_VALID2 flag when it calls ext4_split_extent_at() for the
second time, allowing it to properly handle the split. If the split is
successful, it will keep extent from 0 to A as unwritten.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Message-ID: <20251129103247.686136-3-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/extents.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8d5ca450aa5d2..1fee84ea20af1 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3310,6 +3310,15 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 		}
 
 		if (!err) {
+			/*
+			 * The first half contains partially valid data, the
+			 * splitting of this extent has not been completed, fix
+			 * extent length and ext4_split_extent() split will the
+			 * first half again.
+			 */
+			if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1)
+				goto fix_extent_len;
+
 			/* update the extent length and mark as initialized */
 			ex->ee_len = cpu_to_le16(ee_len);
 			ext4_ext_try_to_merge(handle, inode, path, ex);
@@ -3379,7 +3388,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
 				       EXT4_EXT_MARK_UNWRIT2;
 		if (split_flag & EXT4_EXT_DATA_VALID2)
-			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
+			split_flag1 |= map->m_lblk > ee_block ?
+				       EXT4_EXT_DATA_PARTIAL_VALID1 :
+				       EXT4_EXT_DATA_ENTIRE_VALID1;
 		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk + map->m_len, split_flag1, flags1);
 		if (IS_ERR(path))
-- 
2.51.0





