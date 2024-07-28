Return-Path: <linux-ext4+bounces-3496-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE5493E720
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8BA1C20B20
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C6C155A5B;
	Sun, 28 Jul 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2y9h7qO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4B15572A;
	Sun, 28 Jul 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181793; cv=none; b=haDho1wcOXbnLnLyQ0qtdJgahVDjLZ3EkSVJWZAO5gLXKfgSHrWILZjMwRWeyQBisFVU9lZgJSMzlwpD0v7WIC78copeOBbyzrOyn5hKYZ+sC2z0XB59HTpiSbAGBIyahHRomkm+uPlrT5qR2AbGthqN0ubGl72vjt/KMT8m7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181793; c=relaxed/simple;
	bh=9EYuljhfcMjJD9/Krb8g2G2OQNsgjn5rET5cCzyvlBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hE5n6iaqcwqxuoH4c+AO/Grsfk9zngccPBIzG2RRoHEkkUIj/VtLuBOHF7QI1Jq0gzlxUVSF8h/mIvjtKMF5JlQTj2WEXk9oyfQEJkzHgVdkbJ0heKayeDkPAujLpJRBBcTM3uJohrNmKmJnTeBwzr2G5tpttF+nFBtbkOfDK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2y9h7qO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E328C4AF14;
	Sun, 28 Jul 2024 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181793;
	bh=9EYuljhfcMjJD9/Krb8g2G2OQNsgjn5rET5cCzyvlBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2y9h7qOkf1f7VnADqYG2WSjrDhDbGEqMJCDxcSwXX60w1fwcAmUKxEycQekDpk5e
	 bv0XV+0unadIQNZPTIyQWTdprwirq9MZoGeFQo86BiwfISGD3jceUmrtZBrc0yCCx4
	 wiAi3iuvowLpAaXiWeix1yiUftEFRUsFmQRtxbu2O0lmLPx+VxQIkGAl/fSWKCEPVv
	 cXXi/Hx5BFi57mixw9O0pyFA3iBleysGq5MugTVQrOUZb3gzJKHjA5eXLRriaBZx4f
	 QoOq7lJNL3uZkzYPjQiI4Mvt7SajWRLp/j/sRrLwpZhSv/AYgUGD82gLeDl/nrnaG8
	 A0bX08+5XhGJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiaxi Shen <shenxiaxi26@gmail.com>,
	syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 07/10] ext4: fix uninitialized variable in ext4_inlinedir_to_tree
Date: Sun, 28 Jul 2024 11:49:05 -0400
Message-ID: <20240728154927.2050160-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154927.2050160-1-sashal@kernel.org>
References: <20240728154927.2050160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 6fe665de1b203..bc7f6417888dc 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1446,7 +1446,11 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
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


