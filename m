Return-Path: <linux-ext4+bounces-3489-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293493E687
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF631C21238
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094DA79DC5;
	Sun, 28 Jul 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVHPEldb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8412D209;
	Sun, 28 Jul 2024 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181498; cv=none; b=cqJriqchOQzt0RRn+LacqQb0CVDmx3aYEKgDPWHLcnSF18hVCTKav8wYYCT95Jgd0VcnQ3UU+lf37DShLBKmWklbFFLqYqadLGvUgQH2mIPoMmfCzCkYYxDXitpv2hpifVbKK7fZox1ZAGgGIhs1maiynP0sMkjDgtfNUJzYy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181498; c=relaxed/simple;
	bh=Kl/zGhmPjgU29qKp0mbfvPZ8RsWisEndDWh/+mGe9Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELAAecCNXXhayYCkJC+aQrvsWiX40csG8Sa3ghcABY901cCAAo4HiE9+9M5G9ICM1BjekIAhgMcRtdDOB0TFeWs1nN1/c1CWimWzrHF1pSiaOBo4YRx7OIxGQ0O1oMFQ4gQ98wk7XDYS8sWi4jQz/951EvFglOLN0PcWni8osaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVHPEldb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47852C116B1;
	Sun, 28 Jul 2024 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181498;
	bh=Kl/zGhmPjgU29qKp0mbfvPZ8RsWisEndDWh/+mGe9Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVHPEldbIjzbBUuXrFQUy9eSTy01uX+uJ1+NGAbxi6z5ihU2eZmpNaxWDyA5KOXfA
	 RuOc3OEOR3g3Cw+HDti2qBNwIH9FoKXdxi0vbmj1AX2ptCIAwA6zkpEgmuNZnbJwPj
	 017p5BpJT5Ajhbh2wnagkk+YakKFv4s1PZibXNvb4ZUxmotIabWzVEhb+XI6RpBp9v
	 jBVPVeKtVPWCKNFZsndgJH/yhG6lX85b6elcZGx+WnCdCOqsPRcl1k2hrK+BP5XXOW
	 AdxHRZPZpPFOQ2y1YdtdOoWtpGdGehBPR8o2G8rqil6gu51OE1lkPNfBlcI7R6Nt7E
	 dIOElENqP04hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiaxi Shen <shenxiaxi26@gmail.com>,
	syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 29/34] ext4: fix uninitialized variable in ext4_inlinedir_to_tree
Date: Sun, 28 Jul 2024 11:40:53 -0400
Message-ID: <20240728154230.2046786-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index d5bd1e3a5d36c..e7a09a99837b9 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1410,7 +1410,11 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
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


