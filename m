Return-Path: <linux-ext4+bounces-4480-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA30D990B20
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 20:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9821C228D4
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F32321C199;
	Fri,  4 Oct 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2rr6JoY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C321C18A;
	Fri,  4 Oct 2024 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065940; cv=none; b=RjsmegAE2BYz/PZABRX2N5WauR7g6QQnlKu2essRnOnWtM9dBPm7U7iWRTypKcXQRPlGioUgxMO3uHtFie3e0iHmlvn5XLouy6PsWEUxyiZirDvMrCUFnGReoLYVS/T5Dyz6596z1ujUaTMiO5gCbCDabGBZ1+tRjPfzsHT7R28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065940; c=relaxed/simple;
	bh=y/HESDUQcnYjFODBAlVirlQLZWQXcTxESDRfkB3GLUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUSTbA2R967lk2kel2sB0vAGC8frIkWQwylMCzqbyAkoQf39tWT4HZqcN/sOBGJdKLWEhDTJTNXIbTGbpFg12XF+H/ikOnHm2IcASNbet5AaOVt64Ik5CBwba4nwetnoEKiVXp1YS7Z+Ux8QKCbRicALblldCUsM+A9PFAdZGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2rr6JoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA99DC4CECC;
	Fri,  4 Oct 2024 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065940;
	bh=y/HESDUQcnYjFODBAlVirlQLZWQXcTxESDRfkB3GLUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2rr6JoYB8blxDbU3+wy7ezW2GH8kVODcmK9OU443HJ4xUO9vwqpUQUZCFzT5QlRC
	 6zGDj6ZwYusZVONgvaRuJYsbi+Y8VBKt/ND/n/uXnE9u273ir+WKhqCfXdeW3kIjCt
	 mqSgXjGyS1ghKuEKMrHEOhq0NbLCItfAzEVYGDb+lgU/7L8O8SENDMAE8oadkAtsVc
	 tbxq5yTGxNOfBr9vAPseeD9lQ4MqXrwlXPkRvGgYPVxSJXJ3w4mhNFCPu1Ofb34RmR
	 Y2NGPKyWJxH+EWO5chsXb3XNXRYCmXjkfr1SSZiY9l2aOcWAlz7MdaI9Tnyp6m9G4O
	 1qhEYXunKXNOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 18/76] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Fri,  4 Oct 2024 14:16:35 -0400
Message-ID: <20241004181828.3669209-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Lizhi Xu <lizhi.xu@windriver.com>

[ Upstream commit 985b67cd86392310d9e9326de941c22fc9340eec ]

When mounting the ext4 filesystem, if the default hash version is set to
DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.

Reported-by: syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 93c016b186c07..e8e32cf3e2228 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3583,6 +3583,13 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 			 "mounted without CONFIG_UNICODE");
 		return 0;
 	}
+	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
+	    !ext4_has_feature_casefold(sb)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Filesystem without casefold feature cannot be "
+			 "mounted with siphash");
+		return 0;
+	}
 
 	if (readonly)
 		return 1;
-- 
2.43.0


