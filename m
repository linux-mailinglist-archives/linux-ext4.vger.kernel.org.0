Return-Path: <linux-ext4+bounces-2693-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E748D29F7
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C907289141
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758FE15AD9A;
	Wed, 29 May 2024 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fBFPbQ6U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC015A841;
	Wed, 29 May 2024 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716946122; cv=none; b=N02NJuVDiKBMtrus7u2Sxi4XDhOJUi6mRQSYK6P6XbBVLQwxmLLKYqATe3qQ720RuDtGl6daa1Vlm/lIPanSmDOdRTy3kAL+kj6WNf2Gy1d1o4fS6SNwt+72mCE84d7w/ug0Hv4MFQcnHxs9ur9pW0n6RPRPE5a+L31ISdJvnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716946122; c=relaxed/simple;
	bh=j3htC+RmfS/MluEVClfrUS0wbKNXXr8GUemPYhAO0v0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NJe+8n9uiODh8P+O2qxXUIkXyQGqnXYYoy7VcYCFZ8KDYctkKI/Ex96EXIk4lDM2jXBDGq+x9LU6HxqJGlyY8eDzqtQ82yJnLTVNNH2hhVmnJtswTTcYxW5UL9dgZqODTwunL4Ku/Fvdq95LBVOHUnMCar0Y1lRvjIRl1iC+e8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fBFPbQ6U; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716946109; bh=OOjVQMK7W8tJWIF171tEGyp2a8xk0aKQ+MIa3W0Xb6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fBFPbQ6UAMbL/dqr0GXJu81N8umE1vc+k/9ZGL5SQQeODA9v2iIO8XHU1jqB+HuDO
	 iWavkQyDfmJHgn5Gau0YEJ/nFBe4xxJCKPIPMEHXEqzRp/b1bcF8StrVJr+6knuW1D
	 SMinDgrh41Mn+5j6jyuLS34xgecrnLH2FoYBqLao=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 3C1310D4; Wed, 29 May 2024 09:15:01 +0800
X-QQ-mid: xmsmtpt1716945301tgjycg6rl
Message-ID: <tencent_72297DA3B4444FF762977666C65361437E05@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70guOsM/HY0pDqYQRhlhcRAMO0baPQfpwTWUVC+XwO2+YZXLXkCd
	 Ah6koRaVDbU5rMY7FURDqchAGTGzGkBCmgMe8MfydY2uIYFBzk/2WOnWW8gdnxzPbf1/HmnPVnZc
	 vqFgrJqQye4W4tgTDazT6I0ityKM52D0mryV2A+eVamH8ciEL+OCwCg4+Oi2gAQwAURbk5DARsaS
	 /kg5HoSn+sNuqkwP1/NACkkHHvYOhOzF/NylHkNJk1P5wDtQxDMcnQ1n+Pmuybdi9Mw6leQhtXDo
	 VpK3dRWO2QjxQCtS8cSKOyaBN2K+UDQkly23VTjA2avWrATAeH7X/0jbrBsgxOgA/sGomb/LhUlh
	 tHKW8lNq56zg3s8t29JFMDsumsBcTx8nFHOUF3xy2kLIbwOweUIbTyr9Yi5IYHWVomCM6O84GY9l
	 0QEN1Q3ff5H9+TewKblnCYgBmRf7SKqRcwesH0YCylGHk6FMD278Dm65FAs5rzbakFQYnUX82bGp
	 K9YNFRV67GSmBHRVE4AZxPN1aQytbWh14EnMLU0x5EBNvf4rCr7VwoTfXg0nozRvsks+eiB8h0iZ
	 bLjdDhXUZpBtgzEBNd/1GDbTScGv6OPYNf2jxVZIsr9MCFFplFi2qAnooKACTtnTH+4Lu4Q6lVH0
	 tYJarfKD3zHh4zXm1rMs4RNM1MeVe5vN+hcL24DZD+nFOxQrTJ3yRGgpk8Ebu4h33lLD2D1OB5WX
	 p2fOrT/krxe5STcSyxLOAZBLvzfygbmHvmIShFzyPrjqtUqGhATsG8p+B2AWKHX7paQc/4FZ/D4G
	 DzHwwdk9sD46F4aZ/in7SfJ8tMYzIqSPfD6IdyiHPHNvALPsbY/ulXnuDMTzQMCvEfCAiZB465ti
	 /xIYWvgSSHIzh/eeOMKtWU42CyV5VVnqP9ouZidC9Sggwg5BiGWewwCcyDVn9eWZBuITLpkXRT
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+fe42a669c87e4a980051@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: [PATCH] fs/dcache: fix warning in ext4_xattr_inode_lookup_create
Date: Wed, 29 May 2024 09:15:02 +0800
X-OQ-MSGID: <20240529011501.2190031-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002b03350619853096@google.com>
References: <0000000000002b03350619853096@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext4_xattr_inode_lookup_create() will use s_root, so set it to NULL
after do_one_tree().

Reported-and-tested-by: syzbot+fe42a669c87e4a980051@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 407095188f83..e2f1a3f92ce9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1551,8 +1551,8 @@ void shrink_dcache_for_umount(struct super_block *sb)
 	WARN(down_read_trylock(&sb->s_umount), "s_umount should've been locked");
 
 	dentry = sb->s_root;
-	sb->s_root = NULL;
 	do_one_tree(dentry);
+	sb->s_root = NULL;
 
 	while (!hlist_bl_empty(&sb->s_roots)) {
 		dentry = dget(hlist_bl_entry(hlist_bl_first(&sb->s_roots), struct dentry, d_hash));
-- 
2.43.0


