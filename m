Return-Path: <linux-ext4+bounces-4501-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D1C990E71
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 21:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971721F21B86
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 19:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1D81E3776;
	Fri,  4 Oct 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5hR4Iw2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685101DF25C;
	Fri,  4 Oct 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066616; cv=none; b=QVsX3tWoM/QyWLaAwJZQQlpRK432KrhI2TNTUhHKMDWmEUlXJ1uzT7GhjlKUxff8znUvpeWYyNVzDjHnSD+jyVD+JzwC0e3iBVlyiNVoKxE3c5h2bVfopK8DlOyGQXs9orG+CE5Xa17SfWWCVkDgYUgJQwyVkck2uqkNRwx+xkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066616; c=relaxed/simple;
	bh=uS5U70Id3+e1t5E9CsGLx6X4BJ0V88spen3mf51HuVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCXcPDkvymoGe8FJ+vcPdOaEAGHvTNyfvzMiVTGNTHFFNeea/Vnz9TcqvmTKl/9djmk9SSSk9ULMQfekW2kFvTvYlr1zovBBG2Rzlo5pz13cPvZCwbVMBUxhAQ3s9F0+9IYkah4h4pNIf5BWoAK4YQ21b/mFsUmTdqPUxJYTp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5hR4Iw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46001C4CECC;
	Fri,  4 Oct 2024 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066616;
	bh=uS5U70Id3+e1t5E9CsGLx6X4BJ0V88spen3mf51HuVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5hR4Iw2PALGrvskJpvEu0fYytx3L3H8xPb1D/f1iGLVD1ZyF/PevYLM5aam2ECIT
	 HKRol0f6qelXkwPkFVtmI/6wG8DKvKjuRCEb3Mga5j2s8y06P3VAJmcR4eigf05cBX
	 Xg4yKNRRoh1i4aWcw1fx6MjLNw1VWGcKP9zx9pIEYa1boH95DGSjitCI5jCX865Waw
	 5bUKYQ0k6/etmSqpp1wa0exrbg1hx6HXdE+CJfkpLO1n0tj5huOyKDmu3u1Mb+X29Q
	 0qCOKbMBuBwVoMOPazj6tiyc1h3H729nzKINoAMS6MjgERxHpK0Zwrx6ZHIYEGEp0B
	 7ytzQdsvtYQuw==
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
Subject: [PATCH AUTOSEL 5.10 05/26] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Fri,  4 Oct 2024 14:29:31 -0400
Message-ID: <20241004183005.3675332-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index b0ea646454ac8..59290356aa5b1 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -663,8 +663,8 @@ int ext4_ind_migrate(struct inode *inode)
 	if (unlikely(ret2 && !ret))
 		ret = ret2;
 errout:
-	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	ext4_journal_stop(handle);
 out_unlock:
 	percpu_up_write(&sbi->s_writepages_rwsem);
 	return ret;
-- 
2.43.0


