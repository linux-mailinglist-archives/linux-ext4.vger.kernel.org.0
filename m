Return-Path: <linux-ext4+bounces-14254-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLbEJqWao2kwIAUAu9opvQ
	(envelope-from <linux-ext4+bounces-14254-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:47:17 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 045891CBB5E
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F42E32185FC
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF472E8E09;
	Sun,  1 Mar 2026 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOmcTg25"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414D2C11DE;
	Sun,  1 Mar 2026 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328807; cv=none; b=u15XE+kTaePF1yHhwBi+E5BULbRg7u9csD0qQJp62KilG6IYQfyOd3R5DnHu1so8q8nFdHWaijLzFOqAF70aTIiFyAsgn49wpSCooTZ0myO1ukZ3OIB0as1BB8UdtkVS0kjBqD12iUP7kg8LsEQJ9aK1xbMSBqkP8wPJXK0hsG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328807; c=relaxed/simple;
	bh=JTt67oBsk6cub1IpA5IfsIHar5ySmsmTNh+z3yobY3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6oVeQmdeN8ua1UMVf+jb4YOIoQfaajSucfRi3ZkRYN5Wu3TGvaWmNrQI6x8ABTlfCK/sTmhYLtgBl4d827iXvUIRDz53F6Jz/NG8VXepdkgXsk0r4dz0Hmy6Xbhwk1BG3mVfO1MRPmfeCQ442hM20+YRVbASkc9AMUkRmbZ6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOmcTg25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F84C19421;
	Sun,  1 Mar 2026 01:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328806;
	bh=JTt67oBsk6cub1IpA5IfsIHar5ySmsmTNh+z3yobY3M=;
	h=From:To:Cc:Subject:Date:From;
	b=SOmcTg250TVvMdab2JLi/moNbRLAHhBKIcW+RG7cMvRywyTjtIkIeanSbDFS5+P1+
	 pozHVc1E9RMtylZhIysIDA46UPxJHvG+ypkI17o1i0kMGiYee0RwKhJh/Zb4e1XX50
	 3zdhZ7yWa7LfeCXb0rEU2f2o33DWl536W7mBtPk+lNCJzU5uYvdm2er+B6T/c6X0Zh
	 PG5PwA3IiNjTgiv/azEMu/xUZPBXshMMBfDuxIvlVCtVu8LMNLophM7VrJWlYtrAd+
	 4FT+wxSaYvMqKWXmFkUjPHqEgUADvwLPlRhbZ28jxpCzUskI/50dxqUd5G4OzB+BAR
	 er4U3iAJFOhvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jack@suse.cz
Cc: Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: FAILED: Patch "ext4: use optimized mballoc scanning regardless of inode format" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:33:24 -0500
Message-ID: <20260301013324.1692638-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-14254-lists,linux-ext4=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.cz:email,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 045891CBB5E
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3574c322b1d0eb32dbd76b469cb08f9a67641599 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 14 Jan 2026 19:28:19 +0100
Subject: [PATCH] ext4: use optimized mballoc scanning regardless of inode
 format

Currently we don't used mballoc optimized scanning (using max free
extent order and avg free extent order group lists) for inodes with
indirect block based format. This is confusing for users and I don't see
a good reason for that. Even with indirect block based inode format we
can spend big amount of time searching for free blocks for large
filesystems with fragmented free space. To add to the confusion before
commit 077d0c2c78df ("ext4: make mb_optimize_scan performance mount
option work with extents") optimized scanning was applied *only* to
indirect block based inodes so that commit appears as a performance
regression to some users. Just use optimized scanning whenever it is
enabled by mount options.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20260114182836.14120-4-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/mballoc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 910b454b4a21e..dbc82b65f810f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1148,8 +1148,6 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 		return 0;
 	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)
 		return 0;
-	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
-		return 0;
 	return 1;
 }
 
-- 
2.51.0





