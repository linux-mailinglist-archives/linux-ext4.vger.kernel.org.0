Return-Path: <linux-ext4+bounces-3492-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC293E6D1
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 17:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3ECF281C45
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B551448C0;
	Sun, 28 Jul 2024 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcqzhZsW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3421442FF;
	Sun, 28 Jul 2024 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181638; cv=none; b=SjrbOiZGrRPAw+rYyjv4FdGvsZNbk7OPkTiHUGniB5W5wlNp0ef9kC1eqC48AKokY8ayRAnLQsxzvcUMcGZiZ2bjpTDbVg5k6Vmz4mwGdzEkKMKp07DrglyM2fn3bGdI70G1UudsnLJWapfbK0RmUFZ5zo+mNedu9mJ+JfZUd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181638; c=relaxed/simple;
	bh=wjvQmQ5YGynBpKVKyj6iQK+rXeV5WCwNq/x6RHsqnGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUYWGGqAVc9DYnwlplr89yJIgPGQnCEMPwI4fdtoGhbXKrqjMoBOUMcbIUQeYWWz4C6W47O5PN+oa2m9xr9owGAwtCgU5AiJ2YtYyt1y+mXBa22zevwKrkIqovA8dHZz7crtFuCu+9JcArvpOIsRWQ525X+F5K+OB1Sy69AG6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcqzhZsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6892FC116B1;
	Sun, 28 Jul 2024 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181638;
	bh=wjvQmQ5YGynBpKVKyj6iQK+rXeV5WCwNq/x6RHsqnGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcqzhZsW2a1EhMhHJOsQUjJ1veQcDaol4hzZMg2rIN7jbZWJlFTbRDtISCrcRv2k5
	 ai0Wl/FhU30UtfskHv4dQpFvJOxFkvwJ0LhrcB9tpMpIq2gNAXbySMdao2gxvaxl2K
	 he4/8UttzMBMhxDMgku3XvrODrRGWlbuxcFgH2B/Qs/VzqszpVu+36KtzLeZCI41ME
	 /RhVcpROxqp6T8OE5ECLzsKSq3mPxHWe/v56oAQ814/kehlqXJF1yjRHHDBmxiKKA+
	 tlI21aI2Pu15TVrc2hYMorfzYPkwmHbA0KyFS8BfRY7+jbMM/jcbuuJXbNkyjSS0Uc
	 u9RLiKqA9za6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiaxi Shen <shenxiaxi26@gmail.com>,
	syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/20] ext4: fix uninitialized variable in ext4_inlinedir_to_tree
Date: Sun, 28 Jul 2024 11:45:15 -0400
Message-ID: <20240728154605.2048490-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154605.2048490-1-sashal@kernel.org>
References: <20240728154605.2048490-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 012d9259ff532..a604aa1d23aed 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1411,7 +1411,11 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
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


