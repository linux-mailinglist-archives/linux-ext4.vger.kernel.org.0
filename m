Return-Path: <linux-ext4+bounces-7550-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8A5AA3D5F
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 01:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E647B807D
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 23:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142527E7CA;
	Tue, 29 Apr 2025 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye7eY4h/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C124255F20;
	Tue, 29 Apr 2025 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970665; cv=none; b=G9W9gThlAoQPG5vdILSv022Q5vHQkoIcqfflC/qFvccj+IycqZGrDPVAOJO7zohkKXCNl0yRSkswUJId8A/oXT7E7cz0eSvve8VZfxCQR5AQqTAEjUGns5tWjBoPc3Ke+T2x+s/OIYPOBCWXpZBBDTGPtDyv99TedILQgBUzgi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970665; c=relaxed/simple;
	bh=70b8Jc06bX+xlikGum4mEtZSHRqtISUc+HKBUjhBOWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQ+D3aSPiHX+aEGEJDiv7+ym+GSniiobd/s7nbHzQfqvkWCRmauShnaD2Wk+0qzobgjcFyF5IHaEpxTDlXqvqN1npRKEhbuQWYsJeOnpjx1jSAtpd74MNhXOeFVh7cibKdDzROT5yU+bE53/xBm7AAcQqALtJve+mf8BWcs9DGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye7eY4h/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30990C4CEE3;
	Tue, 29 Apr 2025 23:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970665;
	bh=70b8Jc06bX+xlikGum4mEtZSHRqtISUc+HKBUjhBOWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ye7eY4h/yc1n054FCtH760jgF15dAINbKxY5oq4F1xHg/qb1uUHQUFww7qQCMEzSD
	 T7K7vU2quUc14MjpQI+JlbA7EQhyfb7ouheRbHzbvGr1+h1H2jqd+TzhHah38ax0Eq
	 +Dru3elQfvnUA7mFbSY5CIZv+G9nvLfolBavbbRXhF7Pj36SJ0YLYxyJC/llmiebZR
	 qCyqhufC1ihqHh9AAN0/OTkW0Vz/peMUEr/ycX5IEYzqDElhUrNlp7CjXWODcM0Pcp
	 uUBT/oFsFQrbNSZ4xb+wokdDm1Cv3G/fBpR7IIMJ5bCN5vnYPVK588K1mPnMBe5C3p
	 5SVhLVuNPufqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jan Kara <jack@suse.cz>,
	kdevops@lists.linux.dev,
	Luis Chamberlain <mcgrof@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 31/39] fs/ext4: use sleeping version of sb_find_get_block()
Date: Tue, 29 Apr 2025 19:49:58 -0400
Message-Id: <20250429235006.536648-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Davidlohr Bueso <dave@stgolabs.net>

[ Upstream commit 6e8f57fd09c9fb569d10b2ccc3878155b702591a ]

Enable ext4_free_blocks() to use it, which has a cond_resched to begin
with. Convert to the new nonatomic flavor to benefit from potential
performance benefits and adapt in the future vs migration such that
semantics are kept.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://kdevops.org/ext4/v6.15-rc2.html # [0]
Link: https://lore.kernel.org/all/aAAEvcrmREWa1SKF@bombadil.infradead.org/ # [1]
Link: https://lore.kernel.org/20250418015921.132400-7-dave@stgolabs.net
Tested-by: kdevops@lists.linux.dev
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b25a27c866969..d6f1e61c6dc82 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6644,7 +6644,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 		for (i = 0; i < count; i++) {
 			cond_resched();
 			if (is_metadata)
-				bh = sb_find_get_block(inode->i_sb, block + i);
+				bh = sb_find_get_block_nonatomic(inode->i_sb,
+								 block + i);
 			ext4_forget(handle, is_metadata, inode, bh, block + i);
 		}
 	}
-- 
2.39.5


