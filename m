Return-Path: <linux-ext4+bounces-8271-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5A2ACA77A
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jun 2025 03:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9357A4175
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jun 2025 01:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FF333530E;
	Sun,  1 Jun 2025 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaPTMTqh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98A3352FD;
	Sun,  1 Jun 2025 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821480; cv=none; b=QaHAN//ONT6BLe4IEY5nEA7Ccvl7Ql62nfjMIMiG9l9H6CJro4tap7w6ZpFEuWlPrfyFt63tDqHyfFLOcME57MhfVy9JZABvakP4Cjtnna8nR+Y6cqrpvmlZJA9azoH7RJemZo/eLfrAPttR7S5ZaG+2JgtHdA8g4jlcS3LfZ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821480; c=relaxed/simple;
	bh=Lrd4w18aQGRnmEoCnX6nYN+B0jzeVk2ueXmwGY6/tjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W8UEXqNA+gKiHzJLvwYLnu3uAIRg6IwlSQeZdAgzV/qZ2K/swDQnSntsFvzVYyJ5G5zZBDyR8Lht9tpS3syHMrbFCmNOAJFR/kyCBem0k8NQv2GkCkFQHkAavOAbiJA/OHYGwbyETnW6s2bhI6zvWTFoeYAZ3c2gYWjeA0HOe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaPTMTqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79C2C4CEE7;
	Sun,  1 Jun 2025 23:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821480;
	bh=Lrd4w18aQGRnmEoCnX6nYN+B0jzeVk2ueXmwGY6/tjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaPTMTqhNFQTJQL51UUvpT0Dl8jmg+0vGgEh0Pi7hB0d2iDzAIhvRp23VtpI1i1v8
	 ywqE4273qW+rF+5R9hwGUMzyeGnIp/5022IzK6DswR1efZL62S4cyD936Q+dIIFgdO
	 YjkuEHPR0Mn4HH6+nN08HPZFTl5NEO/+wrA7UAOd87P5ycfw99AG/6SOKJC8/sdz9d
	 /hccDlCzBLbQ0Q0QWBeiv5JHRM7vxjwCf19MidSNNQQ3PUzD5qI3HATFIPNDGKdEGQ
	 vqwO/aglZrPELbM7A5PC9xu5XVuIOJlA2APE+bJm1cWgNw5I8qJNfw1qtENI1x53Tb
	 uWcciP0m7ZbDQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 18/34] ext4: prevent stale extent cache entries caused by concurrent get es_cache
Date: Sun,  1 Jun 2025 19:43:42 -0400
Message-Id: <20250601234359.3518595-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601234359.3518595-1-sashal@kernel.org>
References: <20250601234359.3518595-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit f22a0ef2231a7d8374bb021eb86404d0e9de5a02 ]

The EXT4_IOC_GET_ES_CACHE and EXT4_IOC_PRECACHE_EXTENTS currently
invokes ext4_ext_precache() to preload the extent cache without holding
the inode's i_rwsem. This can result in stale extent cache entries when
competing with operations such as ext4_collapse_range() which calls
ext4_ext_remove_space() or ext4_ext_shift_extents().

The problem arises when ext4_ext_remove_space() temporarily releases
i_data_sem due to insufficient journal credits. During this interval, a
concurrent EXT4_IOC_GET_ES_CACHE or EXT4_IOC_PRECACHE_EXTENTS may cache
extent entries that are about to be deleted. As a result, these cached
entries become stale and inconsistent with the actual extents.

Loading the extents cache without holding the inode's i_rwsem or the
mapping's invalidate_lock is not permitted besides during the writeback.
Fix this by holding the i_rwsem during EXT4_IOC_GET_ES_CACHE and
EXT4_IOC_PRECACHE_EXTENTS.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250423085257.122685-6-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my comprehensive analysis of this commit and comparison with
the historical similar commits, here is my assessment: **YES** This
commit should be backported to stable kernel trees for the following
reasons: ## Analysis Summary ### **Type of Bug Fix** This commit
addresses a **race condition** that can lead to **stale extent cache
entries** in the ext4 filesystem. The race occurs between: 1.
`EXT4_IOC_GET_ES_CACHE` and `EXT4_IOC_PRECACHE_EXTENTS` operations 2.
Concurrent `ext4_collapse_range()` operations that call
`ext4_ext_remove_space()` or `ext4_ext_shift_extents()` ### **Technical
Details of the Race** The problem stems from the fact that
`ext4_ext_remove_space()` temporarily releases `i_data_sem` when journal
credits are insufficient. During this critical window: - The extent
precaching operations (`ext4_ext_precache()`) can cache extent entries -
These cached entries are about to be deleted by the ongoing
collapse/shift operation - Result: **stale, inconsistent extent cache
entries** ### **Code Changes Analysis** The fix is **minimal and
surgical**: **In `fs/ext4/extents.c` (ext4_get_es_cache function):**
```c if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) { +
inode_lock_shared(inode); error = ext4_ext_precache(inode); +
inode_unlock_shared(inode); if (error) return error; ``` **In
`fs/ext4/ioctl.c` (EXT4_IOC_PRECACHE_EXTENTS case):** ```c case
EXT4_IOC_PRECACHE_EXTENTS: - return ext4_ext_precache(inode); +{ + int
ret; + + inode_lock_shared(inode); + ret = ext4_ext_precache(inode); +
inode_unlock_shared(inode); + return ret; +} ``` ### **Why This
Qualifies for Backporting** 1. **Important Bug Fix**: Stale extent cache
entries can lead to filesystem inconsistencies and potential data
corruption scenarios. 2. **Minimal Risk**: The changes are extremely
small and contained: - Only adds proper locking around existing
operations - Uses shared locking (`inode_lock_shared`) which allows
concurrent readers - No algorithmic changes or new features 3. **Follows
Established Patterns**: Similar commits in the repository (marked with
"Backport Status: YES") show this pattern: - Similar commit #2: "ext4:
fix data races when using cached status extents" - also deals with
extent cache consistency - Similar commit #3: "ext4: convert to
exclusive lock while inserting delalloc extents" - addresses similar
race conditions with proper locking - Similar commit #4: "ext4: do not
polute the extents cache while shifting extents" - prevents extent cache
corruption during shift operations 4. **Clear Impact**: The commit
message explicitly states this prevents "stale extent cache entries"
which can cause inconsistency with actual extents. 5. **Contained to
Subsystem**: Changes are limited to ext4 extent management and don't
affect other kernel subsystems. 6. **Stable Backport Indicators**: - No
"Cc: stable@" tag is present, but the nature of the fix (race condition
leading to corruption) makes it a good candidate - The fix follows
ext4's established locking protocol requirements - Multiple similar
extent cache race condition fixes have been backported ### **Risk
Assessment** - **Very Low Regression Risk**: Only adds locking
protection, doesn't change functional behavior - **Well-understood
Fix**: The locking pattern matches established ext4 conventions -
**Limited Scope**: Only affects two specific ioctl code paths This
commit represents exactly the type of fix that stable trees are meant
for: a small, safe fix for a real bug that can cause filesystem
corruption without introducing new functionality or architectural
changes.

 fs/ext4/extents.c | 2 ++
 fs/ext4/ioctl.c   | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 196134d48e00d..436b844d7d225 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5038,7 +5038,9 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
+		inode_lock_shared(inode);
 		error = ext4_ext_precache(inode);
+		inode_unlock_shared(inode);
 		if (error)
 			return error;
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 56829507e68c8..b6da12b4c8a82 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1139,8 +1139,14 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return 0;
 	}
 	case EXT4_IOC_PRECACHE_EXTENTS:
-		return ext4_ext_precache(inode);
+	{
+		int ret;
 
+		inode_lock_shared(inode);
+		ret = ext4_ext_precache(inode);
+		inode_unlock_shared(inode);
+		return ret;
+	}
 	case FS_IOC_SET_ENCRYPTION_POLICY:
 		if (!ext4_has_feature_encrypt(sb))
 			return -EOPNOTSUPP;
-- 
2.39.5


