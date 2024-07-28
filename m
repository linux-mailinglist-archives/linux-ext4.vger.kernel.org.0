Return-Path: <linux-ext4+bounces-3494-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E409693E6FE
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214BF1C2155D
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF95147C74;
	Sun, 28 Jul 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpqWjKqZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949FC1474B3;
	Sun, 28 Jul 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181740; cv=none; b=VovkrXpLGFMAyrFBoM18RFTjrC+vP+fXWeYlvyjka80EGBsIp5SuWt7EIvQ1MS225dZBpIF1vsvfWQVIvs8KnX0KeBSaa45zIyHgjxax8b08E/3wQxTB7dolJM5/LUgIZT7GSb/yqRF0ntbUBxutmU+F2l+yAjWXiDXmCmpyMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181740; c=relaxed/simple;
	bh=XRyPz67iPr528/7/CK3SH/xzuGTTZ6he9hfc2DX/VmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ay0FFJixjbBDY82xAgXJlDUvQo4aZRwOlj0T6GCUsoBizX5uVcwRyJmWnGxaBER5q6DsBvnor8TeChmWEEbH2I6y1Z9Kp3Z1q5AqsPZbWZhyHmtBD3+u33XeOxMm8hDgqysqrS6szCcp0lFvbL0CBTFYhDMN0o0v8aGGwPrgM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpqWjKqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DFDC4AF10;
	Sun, 28 Jul 2024 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181740;
	bh=XRyPz67iPr528/7/CK3SH/xzuGTTZ6he9hfc2DX/VmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpqWjKqZ01lrNWiUHO7hhJHrNwlrVLy8OTvOg3rkHHIRa+44k3ABE6YLb/ZBEIQal
	 FuYTGDo0XO45JTIj46PewAZQhPZz76T9SId1URGhXQeCyD+/i4bUg5B+2udhm3RGJQ
	 7FuspqcaS9fMK4vSLYVYp0b1BQCxCQEu4bWKuYwFXh42UpZ+ZE2wpWWKy1qcpnvvC9
	 ovAfabtfF/BozVXZg10fdInirhTkrypsNqoN2jv7axK2xO0rZJ+JEoHVtBCpC8PUEc
	 wqZN8A/kwMyRLhYmsTgLzPGJrd5KafUWMusZN+BLbfkNADPLg276ezMd8Mu9ms6ngI
	 F2zlzZFF4uqWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiaxi Shen <shenxiaxi26@gmail.com>,
	syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 14/17] ext4: fix uninitialized variable in ext4_inlinedir_to_tree
Date: Sun, 28 Jul 2024 11:47:24 -0400
Message-ID: <20240728154805.2049226-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154805.2049226-1-sashal@kernel.org>
References: <20240728154805.2049226-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Xiaxi Shen <shenxiaxi26@gmail.com>

[ Upstream commit 8dc9c3da79c84b13fdb135e2fb0a149a8175bffe ]

Syzbot has found an uninit-value bug in ext4_inlinedir_to_tree

This error happens because ext4_inlinedir_to_tree does not
handle the case when ext4fs_dirhash returns an error

This can be avoided by checking the return value of ext4fs_dirhash
and propagating the error,
similar to how it's done with ext4_htree_store_dirent

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
Reported-and-tested-by: syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eaba5abe296837a640c0
Link: https://patch.msgid.link/20240501033017.220000-1-shenxiaxi26@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inline.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3a91be1d9bbe7..ee9d2faa5218f 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1439,7 +1439,11 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 			hinfo->hash = EXT4_DIRENT_HASH(de);
 			hinfo->minor_hash = EXT4_DIRENT_MINOR_HASH(de);
 		} else {
-			ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+			err = ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+			if (err) {
+				ret = err;
+				goto out;
+			}
 		}
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
-- 
2.43.0


