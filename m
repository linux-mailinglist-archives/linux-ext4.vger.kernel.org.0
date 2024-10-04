Return-Path: <linux-ext4+bounces-4505-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 931FF990EF4
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 21:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D43B3085B
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 19:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C4F22B561;
	Fri,  4 Oct 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1fBi5vz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458022B552;
	Fri,  4 Oct 2024 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066675; cv=none; b=lgXcNUGdQQN4qB0ueUmUTN132f/OjSBeG6Dy5TrIxpbf/pAqduNiwB1kYU7pSvRwDQSzq4e8eGc/Qy8QItsxdedNfy3vg+/OmkoO9aSWn+QBwxFhfc/qe6mwGpfDaMG4Vt1MPBZrvkabfTPDzsW82v2323v4yktyV0lS0qkBR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066675; c=relaxed/simple;
	bh=Z6wxp/uDYRFtVrH56D2GfLXb1JQJsthF7LDGv/DyJZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fq0yt3Il9tpfdo4/I3JaJK3e7Z4/oOz/CHbTDt/sluxVvqlx1KllqcseXQk5zILG6WjRjlwBbp8I7s3D/EBQUtTPMw4Osya7P9lM3G2FihuN88QHp79j/jeYAouKoMhr+MYjvkjoZYXOCd4YO/jY25I6ZzKOiXHHxq9VqcG7X4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1fBi5vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6F6C4CECC;
	Fri,  4 Oct 2024 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066675;
	bh=Z6wxp/uDYRFtVrH56D2GfLXb1JQJsthF7LDGv/DyJZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1fBi5vzClldjvILDMzmyLxk0WPUoDpky6J6NNCAqM1nmzg1E1Z/3HV58UoCpbLUM
	 QhLh10qlwwR5sdH39n5xK8DyBK80VVycruR9qN5Hh/UyyL0A8q1jWIOJXPf1DJ/Lh6
	 Kda58PQbNGHASxWNXsNdZ6W6KRDGm+qcoMKYlSrHd5hVpQ6jWXmcOepBCNxBevgamj
	 470O6n+LeQ8GfL4fj4V1ZOkjKzr86kKL3zG4ihb0GICHCZfht25vXuN+VHjFYXSeok
	 Pz/kAtR77aOl4EujMudrSoNfjP46b3uRoCCXCOsnqOuNw+X6jiEF1KQ5kdw4ItK2AU
	 AaaOhlkKFtYTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Artem Sadovnikov <ancowi69@gmail.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 05/21] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Fri,  4 Oct 2024 14:30:40 -0400
Message-ID: <20241004183105.3675901-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183105.3675901-1-sashal@kernel.org>
References: <20241004183105.3675901-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
Content-Transfer-Encoding: 8bit

From: Artem Sadovnikov <ancowi69@gmail.com>

[ Upstream commit cc749e61c011c255d81b192a822db650c68b313f ]

Fuzzing reports a possible deadlock in jbd2_log_wait_commit.

This issue is triggered when an EXT4_IOC_MIGRATE ioctl is set to require
synchronous updates because the file descriptor is opened with O_SYNC.
This can lead to the jbd2_journal_stop() function calling
jbd2_might_wait_for_commit(), potentially causing a deadlock if the
EXT4_IOC_MIGRATE call races with a write(2) system call.

This problem only arises when CONFIG_PROVE_LOCKING is enabled. In this
case, the jbd2_might_wait_for_commit macro locks jbd2_handle in the
jbd2_journal_stop function while i_data_sem is locked. This triggers
lockdep because the jbd2_journal_start function might also lock the same
jbd2_handle simultaneously.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Co-developed-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
Rule: add
Link: https://lore.kernel.org/stable/20240404095000.5872-1-mish.uxin2012%40yandex.ru
Link: https://patch.msgid.link/20240829152210.2754-1-ancowi69@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index dbba3c3a2f064..ebee8c94b5fe6 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -678,8 +678,8 @@ int ext4_ind_migrate(struct inode *inode)
 		ei->i_data[i] = cpu_to_le32(blk++);
 	ext4_mark_inode_dirty(handle, inode);
 errout:
-	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	ext4_journal_stop(handle);
 out_unlock:
 	percpu_up_write(&sbi->s_writepages_rwsem);
 	return ret;
-- 
2.43.0


