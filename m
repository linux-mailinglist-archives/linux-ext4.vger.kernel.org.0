Return-Path: <linux-ext4+bounces-7238-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA24A8839B
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8BB37A6092
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B793A2DC481;
	Mon, 14 Apr 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8JS3pkB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FD2DC4A1;
	Mon, 14 Apr 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637518; cv=none; b=lpdFipsxnAMsfszINoz9JCZLv4bj+lBB4RZfDWDPrp6Iw40o0jPyFeLIjlqgtBKUWLVc5tNIz53/qik0gQO0KfR7RriC8dixgMNz9zqLp/a9EuGEPo+qWsMODG6Ffi4K9y2TkrKPF5IpXza9KRgUesAgLughLW56ghCho8LY0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637518; c=relaxed/simple;
	bh=pBZh8wT0+j+ZRwXzPPAwRPNP7IBvQaVC7He6ZqpVwRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhDt497sujjFhRIPhwgnHCzQQV7OeYuEKh6TVNSX4ExwwtOw96WNKhad+gqAM6PYFEd0xBXAiBAqIs0j0/FYqvBW1iYdZpmfAVCmCaSzAnBGo7VdJsJ4ybVP3f6FF/VN/QmMJpnoFKSySLl2oYHPtyGKrTWYyNtkSZ4L+3Or84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8JS3pkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE10AC4CEEF;
	Mon, 14 Apr 2025 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637518;
	bh=pBZh8wT0+j+ZRwXzPPAwRPNP7IBvQaVC7He6ZqpVwRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8JS3pkBHwCftunvKDBZCpAZa+zvFO1irFagFJEEL+T8B/0++wYsN/4JiQaKXTesX
	 hK5HeXJ9WoNSYRxTFIsgrtEb/CRwi89GVgvbfvZxyUiRPCbqg/skMcPr6NFVCalEBL
	 mTfnZTDErkEEcfmYJrIvpOuq1wmPW1DGtyRMJd2eBIaB6V3NMxnJT2I0NG14egOyzd
	 vrqRZDPCF1D1SJiEwjKp6gdkN5P8wgHbpjLJhLBMeGA8g46WZiEnnHf3TWx2w7QT6N
	 GyeKEUAiwjaMw2qXaxqOJAVZpPXo2s6Zuqj4cr8DYYDiZjqzvzyEuby+1SbXSFVJOB
	 wBGVuRUmmiPlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 15/15] ext4: make block validity check resistent to sb bh corruption
Date: Mon, 14 Apr 2025 09:31:25 -0400
Message-Id: <20250414133126.680846-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
Content-Transfer-Encoding: 8bit

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit ccad447a3d331a239477c281533bacb585b54a98 ]

Block validity checks need to be skipped in case they are called
for journal blocks since they are part of system's protected
zone.

Currently, this is done by checking inode->ino against
sbi->s_es->s_journal_inum, which is a direct read from the ext4 sb
buffer head. If someone modifies this underneath us then the
s_journal_inum field might get corrupted. To prevent against this,
change the check to directly compare the inode with journal->j_inode.

**Slight change in behavior**: During journal init path,
check_block_validity etc might be called for journal inode when
sbi->s_journal is not set yet. In this case we now proceed with
ext4_inode_block_valid() instead of returning early. Since systems zones
have not been set yet, it is okay to proceed so we can perform basic
checks on the blocks.

Suggested-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/0c06bc9ebfcd6ccfed84a36e79147bf45ff5adc1.1743142920.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/block_validity.c | 5 ++---
 fs/ext4/inode.c          | 7 ++++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 6fe3c941b5651..4d6ba140276b5 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -351,10 +351,9 @@ int ext4_check_blockref(const char *function, unsigned int line,
 {
 	__le32 *bref = p;
 	unsigned int blk;
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	if (journal && inode == journal->j_inode)
 		return 0;
 
 	while (bref < p+max) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 87e6187e6584b..88992594b4724 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -409,10 +409,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
 				unsigned int line,
 				struct ext4_map_blocks *map)
 {
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+
+	if (journal && inode == journal->j_inode)
 		return 0;
+
 	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
 		ext4_error_inode(inode, func, line, map->m_pblk,
 				 "lblock %lu mapped to illegal pblock %llu "
-- 
2.39.5


