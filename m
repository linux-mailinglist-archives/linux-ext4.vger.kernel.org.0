Return-Path: <linux-ext4+bounces-12228-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5E7CAD298
	for <lists+linux-ext4@lfdr.de>; Mon, 08 Dec 2025 13:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B56BC302C4D5
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Dec 2025 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4B32F6930;
	Mon,  8 Dec 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PsobdKeF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A6246BD2
	for <linux-ext4@vger.kernel.org>; Mon,  8 Dec 2025 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765197439; cv=none; b=XzLKdG/Z3jOYal/6JqvrrQfGGcuvLnbwc6IXdgQVArTanhFt/D2zrwY5aGPByH3RNvKXLLWaO6LrIkcOmcn0pBZk+6aNbaO1Q57IAjvXkEG7baCLUZ81HJtSZME0cVPbM9WC+2fFQKAhO0M1NZkJ/xh40XSrWCeixLr/HL0UdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765197439; c=relaxed/simple;
	bh=TnzDHMyIxgtJKmRRhikgM3wn0reYMTYWZzAEnu5Kybc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q1iVJfMgkr3D3z/V6TiOguOPkY4v26JnY17zBS298nkZ3PYrG/QCkhp0HEdsJyP3DS5KQSsXIX042w9Ac9lMggvjeB7L/kcH3PD13CogHAKuDsopbWWySVVBE8tb5lwjb/jYZvtB95ffvqzrZOuv68K308WjvUkkzUhXUjGNSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PsobdKeF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-298039e00c2so59390515ad.3
        for <linux-ext4@vger.kernel.org>; Mon, 08 Dec 2025 04:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765197437; x=1765802237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RTKglAV7CorgnD71Y260fcfF8rHZcPsE6uR5IoPXaZQ=;
        b=PsobdKeFSUl2RMCQSrmMirYhduuvazUxWAgEDK4/vi0WGD9vJg7j4KhEpGAiUO0R/I
         Ad6NLHUVs1qFv+iLrEi+ekMHjHZT5+qVdj/0r4BBSiooey9XFTatSjcNl6BMBzl/5sxc
         jew1zXB1wZ9jceFGXGThKcfGJPYMouHUArVZXX5y0X89jjTQOEX5v+pto5SzgcidmamE
         jUBlgNwce0/mNxDyjaVVPpOeVOGGB2MBHPnWahemZ+c6WqcOpgZtK1C0Z8CfDYaHjLHn
         A9Mcl0XxzYiTDMNlUlXZmnCtQKH6lBxAjU95c1GamtBco/FbRl01EyVJCdHHxyAq/1nz
         KCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765197437; x=1765802237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTKglAV7CorgnD71Y260fcfF8rHZcPsE6uR5IoPXaZQ=;
        b=cx2pOUjFTZS0vPPWeGWnviDtT3gujvtBh8CutAp5t/ELPS6/QtHvcRURExi1qNhI1L
         YB1LIXU/P1UUUYVzq6akqId/plP3p8OLsKyntUwEFSyIQ6vCvBO5iHBRe+Yi+IG3nAUP
         sur/OLoa+EWWtNyNKvBYgHUrL2xeRuF+U4SvspNm/IJvQk+hg8t+BtQEu8oNHTIJyPoo
         GPHnIFmHKwupsX0ltwMZeN7SwEa/9WcM3QKcIP4QZkUUTJLCdqcNn8xPrsmxWK9W6x0R
         HpK2yxW+AChLxPmz9sa2x9zxYKaSrjZXxshsN3S88OxU0k1Dd5RGSjmmNoDvIJXAI4EY
         f/Dg==
X-Gm-Message-State: AOJu0YwTgE1fv0MLI9EJZsZWzY9P9KjBdwjln/hrkRbhpXjMjuT6soyd
	gcqKdf58UsAuNbsDM9nLKzsKrd1gvXoa/6AnqGM+rhJckYzhc71u9degr/pbEPZsSo+K2W+ChWx
	jdGzLvk4=
X-Gm-Gg: ASbGncv88daylpeQSvGWTGYtmxMgJb/Wu0wT7Mb6Z2j/6vIc9d+qelv9K6trdoP7mBu
	soUxXqhk7HSuNqOhetMZ3Y+Mu1gr62plnNlmqQ83oMz9wBMw+DX+rQriiJ2HcDuOfD/Zz+Nn6+m
	FjBy1pE+3O8Q/RktjyRpXRb5Y66spVdYQ1/P/DbTWA2+zThlU0bZXwB2ZI5CdISCkktmPK2TaUp
	04Ma8QsrTxvxqPpo8HfYnox301l287+6Brm/Zq5V7CFrnvAoQfjlsBtdaZHUSJPSMK2W38JmDMC
	2X7+/voDpYEc10SFTSjYAKEolsdut/UKfLi1Ig+xrjltkBzzF5HV0unxekageI971SDWbDTdiWX
	Dm+3/imOl4XyfYU7y7gDyKT/CagceYLNUJR3oV0Czdn0ZEUQHl5Pw8akjFu3zoJH9wnbKDmCmFg
	hKK1ASS8qeNELttg==
X-Google-Smtp-Source: AGHT+IFE3akw3RfS3w3VUP5sbGGv93R2aQSNinDv1WU7Vl6p7AilzDc4rfWkdgjCVkkekVZko7GXCQ==
X-Received: by 2002:a17:902:e74d:b0:265:47:a7bd with SMTP id d9443c01a7336-29df56772a3mr69867685ad.4.1765197436567;
        Mon, 08 Dec 2025 04:37:16 -0800 (PST)
Received: from localhost ([106.38.226.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6ae0sm125439285ad.93.2025.12.08.04.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 04:37:16 -0800 (PST)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	yi.zhang@huawei.com,
	jack@suse.cz
Subject: [PATCH] ext4: add missing down_write_data_sem in mext_move_extent().
Date: Mon,  8 Dec 2025 20:37:13 +0800
Message-Id: <20251208123713.1971068-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 962e8a01eab9 ("ext4: introduce mext_move_extent()") attempts to
call ext4_swap_extents() on the failure path to recover the swapped
extents, but fails to acquire locks for the two inode->i_data_sem,
triggering the BUG_ON statement in ext4_swap_extents().

This issue can be fixed by calling ext4_double_down_write_data_sem()
before ext4_swap_extents().

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
Reported-by: syzbot+4ea6bd8737669b423aae@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69368649.a70a0220.38f243.0093.GAE@google.com/
Fixes: 962e8a01eab9 ("ext4: introduce mext_move_extent()")
---
 fs/ext4/move_extent.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 0550fd30fd10..635fb8a52e0c 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -393,9 +393,11 @@ static int mext_move_extent(struct mext_data *mext, u64 *m_len)
 
 repair_branches:
 	ret2 = 0;
+	ext4_double_down_write_data_sem(orig_inode, donor_inode);
 	r_len = ext4_swap_extents(handle, donor_inode, orig_inode,
 				  mext->donor_lblk, orig_map->m_lblk,
 				  *m_len, 0, &ret2);
+	ext4_double_up_write_data_sem(orig_inode, donor_inode);
 	if (ret2 || r_len != *m_len) {
 		ext4_error_inode_block(orig_inode, (sector_t)(orig_map->m_lblk),
 				       EIO, "Unable to copy data block, data will be lost!");
-- 
2.39.5


