Return-Path: <linux-ext4+bounces-10966-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51F9BED3BC
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Oct 2025 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712375E26A5
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Oct 2025 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494591FE46D;
	Sat, 18 Oct 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD8vw0jA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F260B672
	for <linux-ext4@vger.kernel.org>; Sat, 18 Oct 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760804177; cv=none; b=b1ugvrIQhQUTArxzobgS1xB3vxJJkPis/j6GDG8veZMy/P+VT1YuZzcUKkcEIKbGAta/mVY3/49y5i4/7P+T3AIgYCbACBLDcYIs4V/QTj1I/vvjcLgIxsnaMtO47+ZlVrWJPZuJ72q+by2yvelt2IiC4ykHbdd+DTssgv4f0tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760804177; c=relaxed/simple;
	bh=+3gAvnzI+cuGaiZxUWSd19HgWxd+NZJ02iVRQAzsYdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rf96mkF7w0USBawfJAiGgAe1AFpzUIlQ7XabCZVyrRDDPpsDmlnb2LYZ4a4uvFPKyt91/f/5tbSATAvOMz8XPySFVSzOhan8tY0QUf589N4sTdhzLtmKRtSB7nSHNpLMrIenSOZVGfLA3EzIf4Z+URfGIkoc3qp6qEz0MzrYIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD8vw0jA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29226bc4bafso13926955ad.0
        for <linux-ext4@vger.kernel.org>; Sat, 18 Oct 2025 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760804175; x=1761408975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSdDV+77YGHONmky4lHEZ+t4EXPNjUiuSFX0q2ZUFEE=;
        b=KD8vw0jA6LbOB0yYtLSAvEiEIg4SQQzOyaW5A7vGAKpGHSxxbjdQj8Ztp/uhCZQ6Rz
         Nr+ZHDgawr0rhfZlVec3HR5KvSZH7/uqsqP4JfDrcMWgZfCwVCTOknQ+AETd7TKoV70K
         LEyLPAS/76izq4Rsy2C4PNmzOdHpNKBtNGgwF9xQWaCuTqiROU2HJLSkyrupwcUvGgPy
         HxAGsvnhSELo1q3b9UhOi2NQJQ+GA0j3bjvLN9074oLQuGZeNLUAD9M/5PmAblO5iJ9J
         Gus7WNeAt+BbSm3S8DHD0L8/WjscXgnL+CpCNqCAK/6abIpjMWRuj8ZxoC4HhKGrbX1Q
         oVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760804175; x=1761408975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSdDV+77YGHONmky4lHEZ+t4EXPNjUiuSFX0q2ZUFEE=;
        b=IF7BzqQDoJlLwb6/5J8Ao00ZARmGwU+lBEDMGPy/YpIbmJREdHAu++HfEJASNflQnh
         mZpuAGSsb3UjHzs8E2m7DI+XLwVjDo7IUfKj0BYOThZAI+PwgP8VCJpdHPvkaYC8CgRL
         SijAGLEA4hkaNLoZ/RBKZO6aFY8eJN0GeXEuGQ7kozkr+FS/CjO8B0oubhsMVEJwP159
         VZ28qKG3vTuGM1OgeQLLz0R+GV/rmKo7Q1qruLSBrckYDAdnNWf3+wrG3OWDiPkgZr81
         lzO1jZ3dwTXg2kEmmuVmqjorhH+7rrveIb8ov0Fk7/YndD7meHcAW2f8+P2WKuhwgTZl
         BSvg==
X-Gm-Message-State: AOJu0YxOiCp49hoovHSg7Ip8SBNmyvqYCtR9GhCh5dY24NKlK9rR9lNa
	wDb6wlOXucpEE4BqvyqqptiCVnIIaREVMNjVSnG+uIRqN/xJb7+e66lY
X-Gm-Gg: ASbGncv9GV6Y8ty/hJeBLSitP2ZPoAg/5nJ6E2jdUQJj9nbn3J+hs+GCaWoN7uaxfg6
	znSnlGgOqDk0OYWt9AbDAy41hArowUcCx6lWHkud/qtzU6kPiKJR8D7ZoD9QJ185WvomrBYumXJ
	6mwo/UsRvyIo592UXsuX/vOPdQA6MZB7IufB6EJuaNxPzXndCYhnX6WVTvfTE41NvynjmHnioL3
	Ui26B/q/0qGVnB79ihvOhp3RDu8S2TyRvQOHBEgh1oRFAdUc+kxqm3AmnBA+i1LThCrC+ELbjIo
	xziVk/t3LNfPP8xdbCCZ6KsEygdlMfs1HHHGYW3lttZoQhEfPNSOzjeYfmVpExAKoJmBEJTU+lp
	fySjPI3mGiqCNoijPD/urrOrzwsfuXj/ddHlHICnFApSwazKeXb8bNx0ZwfTx6VAaXlzX8UtVFf
	xbmWzOSA/qPWdw4/2f/nenyRWtUZ0lizpEcKiS82doSQXgNhccllxggpPEubdJjtYtqzw=
X-Google-Smtp-Source: AGHT+IHYI+FFaaDvVpaxlIAX/sl/GzLTAOyuwL7XHMuLFvxKBqk1F72Br/+q3CnnYmwEGgo8GUd0nw==
X-Received: by 2002:a17:902:e88e:b0:24b:25f:5f81 with SMTP id d9443c01a7336-290c9ca72bcmr105157945ad.17.1760804174643;
        Sat, 18 Oct 2025 09:16:14 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:f9a4:de93:6765:f5dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d598asm30006445ad.63.2025.10.18.09.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 09:16:13 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix inline data overflow when xattr value is empty
Date: Sat, 18 Oct 2025 21:46:06 +0530
Message-ID: <20251018161606.412713-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a file has inline data with an xattr entry but e_value_size is 0,
ext4_prepare_inline_data() incorrectly uses the theoretical maximum
inline size (128 bytes) instead of the actual current capacity (60 bytes
from i_block only). This causes it to accept writes that exceed the
actual capacity, leading to a kernel crash in ext4_write_inline_data_end()
when the BUG_ON(pos + len > EXT4_I(inode)->i_inline_size) is triggered.

This scenario occurs when:
1. A file is created with inline data
2. The file is truncated, leaving an xattr entry with e_value_size=0
3. A write is attempted that exceeds i_block capacity (>60 bytes)

The bug occurs because ext4_prepare_inline_data() calls
ext4_get_max_inline_size() which returns the theoretical maximum (128)
even when the xattr value space is not allocated. This leads to:
- ext4_prepare_inline_data() thinks the write will fit (120 < 128)
- Does not return -ENOSPC
- Inline write path is taken
- ext4_write_inline_data_end() detects overflow and crashes

The fix checks e_value_size in ext4_prepare_inline_data():
- If e_value_size is 0: xattr exists but has no data, cannot expand,
  use actual current capacity (i_inline_size)
- If e_value_size > 0: xattr has data, expansion possible,
  use theoretical maximum (ext4_get_max_inline_size)
- If no xattr entry: use theoretical maximum

This ensures the capacity check accurately reflects available space,
triggering proper conversion to extents when needed and preventing
the overflow crash.

Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inline.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..3a3aa2d803db 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -413,7 +413,30 @@ static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
 	if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
 		return -ENOSPC;
 
-	size = ext4_get_max_inline_size(inode);
+	if (ei->i_inline_off) {
+		struct ext4_iloc iloc;
+		struct ext4_inode *raw_inode;
+		struct ext4_xattr_entry *entry;
+
+		ret = ext4_get_inode_loc(inode, &iloc);
+		if (ret)
+			return ret;
+
+		raw_inode = ext4_raw_inode(&iloc);
+		entry = (struct ext4_xattr_entry *)
+			((void *)raw_inode + ei->i_inline_off);
+
+		if (le32_to_cpu(entry->e_value_size) == 0) {
+			ext4_find_inline_data_nolock(inode);
+			size = ei->i_inline_size;
+		} else {
+			size = ext4_get_max_inline_size(inode);
+		}
+
+		brelse(iloc.bh);
+	} else {
+		size = ext4_get_max_inline_size(inode);
+	}
 	if (size < len)
 		return -ENOSPC;
 
-- 
2.43.0


