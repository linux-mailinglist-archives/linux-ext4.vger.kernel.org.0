Return-Path: <linux-ext4+bounces-14239-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kODaNgKWo2l7HQUAu9opvQ
	(envelope-from <linux-ext4+bounces-14239-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:27:30 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4E01CAA6F
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC84F3005311
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 01:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7C26E710;
	Sun,  1 Mar 2026 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdZ6vg3q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F217C211;
	Sun,  1 Mar 2026 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328112; cv=none; b=gtfqvgeJbjDvn97c65Rljfr+XkHkKrzcT8E/Gn9dfeZK7WW1hHNL4COReaP+sFnfh0owHkosjc1kun7QdsgRbu/y0QuW4NbKfAtW/5p6gttJPc+GWYUhljwExdiT4SDM7zQ2ATylugVWLH5kT1Pj83pqTd748tnHKvHUJ9g1tuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328112; c=relaxed/simple;
	bh=i8rLylkmaLizcbnzh89xIv7eO/83Uhnum9Zlnb9YRak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=he4jyzXIgj7SZwWu0PVGvxf3SvVwIDaqRrVIg0KQyGIqqb56BRORpyDcMyXF9KrsND+35yVYPECDblSNcakDuyq8Psq5G49geUqeAWskm3jXo9fD81PDSAAvWGutIXnA/hlA25wfKhN7PgB364Lb8ho0XIuNRI4L8Dh2xAMDEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdZ6vg3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E06C19421;
	Sun,  1 Mar 2026 01:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328112;
	bh=i8rLylkmaLizcbnzh89xIv7eO/83Uhnum9Zlnb9YRak=;
	h=From:To:Cc:Subject:Date:From;
	b=rdZ6vg3qfA0b8hKapUcZWRhD5MstAMSssw+f9ABDULc30sTeWHtxfG1JsOzRDYU7v
	 ruMbxRlx170e+hf75bUXnqPR04dinEwivZ71Tzfv68fUIbFpIetUQkARPXm3qxlvAJ
	 JET05SBQ9f8lNQgU9jvMe0hxEKJPmmumiBGBpsenT4yUCSLW4M1IEJ6LUnGDcEf6No
	 IIHMjyzZq4AG4HQfw+gZml/GmzuJlpPb1UoT1ORjyBgZ26lMz/18jzsJirW+GN400s
	 O74EUGyI4kIk1MiResbVmVIpZ4H4EC3ctB0EUFenoHfQRtks5UpWvEmu04eRZdvaUH
	 MdVa7NiAFkx8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yi.zhang@huawei.com
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: FAILED: Patch "ext4: don't cache extent during splitting extent" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:21:50 -0500
Message-ID: <20260301012150.1677907-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14239-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE4E01CAA6F
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
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





