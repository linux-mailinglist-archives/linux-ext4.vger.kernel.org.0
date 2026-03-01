Return-Path: <linux-ext4+bounces-14260-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPcoBqKao2l4IAUAu9opvQ
	(envelope-from <linux-ext4+bounces-14260-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:47:14 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B821CBB4D
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A37CC3093417
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B652C0294;
	Sun,  1 Mar 2026 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWydPyAl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8A277C9D;
	Sun,  1 Mar 2026 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329343; cv=none; b=nfmpxKuLccA4lhVB2dUElJsdi5yn+hqTE8FNOUypjuDEGpEdnwV/fKlLYr2n8T0eSyTadbiQJu7iKF7LaWEdF38WScPNO3E/i0EDmiEUCWY+grU6Suj3JK371lhOcBgEtnm/kUSh9LSBal4VLg7/55MVK6Wc/30CiKXH4u39ZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329343; c=relaxed/simple;
	bh=BjgrVegcUHANXVuh/vK3PEtVGb/ek9d5yfA7Mi6bues=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIPnuKUJP/mdFuRCPsXXzgnkudVPLOfQhRQX4BVlDUIUTJL0DVC0DyH3TfJ6fhAIIReTy/VL9eGHSXn+2fKXTKBjuk/+GN3FHgzRTcV1hZVS0oe0M9Xsf0g7/6KHNR40NG6PZIgDX84N3lDY7T9+d2oj3bbBnzBkEjEHMm0Meac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWydPyAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D4FC19421;
	Sun,  1 Mar 2026 01:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329343;
	bh=BjgrVegcUHANXVuh/vK3PEtVGb/ek9d5yfA7Mi6bues=;
	h=From:To:Cc:Subject:Date:From;
	b=hWydPyAldNCY1YtOVu1TXbJs7+CJFcom/55Q+xH7TEtnA4Oa7d5OA0xejPalfDAbb
	 I2YQQYJl5mCDiD9fbtXdISO+vOpU114ncSKc94p/zNBjx5hmr4RB543cpBSxbmuQT+
	 AAVhHKnLtnDY1mn3wG/4N8SgIWiyhYdhDUi9eb/jsRH2i2FE9jkkOQL57VHxqiIiFg
	 tm3dooV8GucqgcRBE6xiqxcoCSoc9st1T79T/unA61yBdwpv9vBM1lM0aI7RfudKpU
	 KrojdKWBxq5Uf4tT+xjgPZlsWFgXDy0nMZG8VkGOJHNA01ZsISU1eacmM3L2zoNFS8
	 KKS+U03+VMbHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yi.zhang@huawei.com
Cc: Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: FAILED: Patch "ext4: drop extent cache after doing PARTIAL_VALID1 zeroout" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:42:21 -0500
Message-ID: <20260301014221.1704190-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-14260-lists,linux-ext4=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,huaweicloud.com:email]
X-Rspamd-Queue-Id: A5B821CBB4D
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6d882ea3b0931b43530d44149b79fcd4ffc13030 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Sat, 29 Nov 2025 18:32:38 +0800
Subject: [PATCH] ext4: drop extent cache after doing PARTIAL_VALID1 zeroout

When splitting an unwritten extent in the middle and converting it to
initialized in ext4_split_extent() with the EXT4_EXT_MAY_ZEROOUT and
EXT4_EXT_DATA_VALID2 flags set, it could leave a stale unwritten extent.

Assume we have an unwritten file and buffered write in the middle of it
without dioread_nolock enabled, it will allocate blocks as written
extent.

       0  A      B  N
       [UUUUUUUUUUUU] on-disk extent      U: unwritten extent
       [UUUUUUUUUUUU] extent status tree
       [--DDDDDDDD--]                     D: valid data
          |<-  ->| ----> this range needs to be initialized

ext4_split_extent() first try to split this extent at B with
EXT4_EXT_DATA_PARTIAL_VALID1 and EXT4_EXT_MAY_ZEROOUT flag set, but
ext4_split_extent_at() failed to split this extent due to temporary lack
of space. It zeroout B to N and leave the entire extent as unwritten.

       0  A      B  N
       [UUUUUUUUUUUU] on-disk extent
       [UUUUUUUUUUUU] extent status tree
       [--DDDDDDDDZZ]                     Z: zeroed data

ext4_split_extent() then try to split this extent at A with
EXT4_EXT_DATA_VALID2 flag set. This time, it split successfully and
leave an written extent from A to N.

       0  A      B  N
       [UUWWWWWWWWWW] on-disk extent      W: written extent
       [UUUUUUUUUUUU] extent status tree
       [--DDDDDDDDZZ]

Finally ext4_map_create_blocks() only insert extent A to B to the extent
status tree, and leave an stale unwritten extent in the status tree.

       0  A      B  N
       [UUWWWWWWWWWW] on-disk extent      W: written extent
       [UUWWWWWWWWUU] extent status tree
       [--DDDDDDDDZZ]

Fix this issue by always cached extent status entry after zeroing out
the second part.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Message-ID: <20251129103247.686136-7-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/extents.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index be9fd2ab86679..1094e49234513 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3319,8 +3319,16 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 			 * extent length and ext4_split_extent() split will the
 			 * first half again.
 			 */
-			if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1)
+			if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1) {
+				/*
+				 * Drop extent cache to prevent stale unwritten
+				 * extents remaining after zeroing out.
+				 */
+				ext4_es_remove_extent(inode,
+					le32_to_cpu(zero_ex.ee_block),
+					ext4_ext_get_actual_len(&zero_ex));
 				goto fix_extent_len;
+			}
 
 			/* update the extent length and mark as initialized */
 			ex->ee_len = cpu_to_le16(ee_len);
-- 
2.51.0





