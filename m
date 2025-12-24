Return-Path: <linux-ext4+bounces-12506-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBD7CDB43B
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Dec 2025 04:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FDC304A287
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Dec 2025 03:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B2030DD2C;
	Wed, 24 Dec 2025 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Ym/brqct"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BC296BDC;
	Wed, 24 Dec 2025 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766547006; cv=pass; b=WUkAAkMwCWPjnk7W0/cQDDIcuTPVvnGGpiwPMapOWtghq943jU+z73ZDTPb5U4a4srvgHI1LOzZkBVnavdYJIiWMZpt7m4Ft4iDPRR+yH8NBT+6q9uSTgw+daNI7pJEKfkYXzeMZOnMQtG/yDk3dxrxbT/7GsGsM8fgrb3Xeco8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766547006; c=relaxed/simple;
	bh=rBPBL/Vb8Hw/d3o10YSURgcEebSW3b8ZLT5xTWdOyok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6ouWNMjCJxnxSLlfue6BWnJRtOvBmH8E9WWYG91nuHJZX+EQUtbj4PekmRPbwj3X8TWPuH1zVoSr9safNnGBu1OPBfZjcZugvm83YCF/oTt0+uzpdUkryMrHiZwiV4G/NO6+nl/FCgdZ443wvqm+Xq2az+Jm7qMqGH0VCLqzJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Ym/brqct; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1766546992; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NggRZdUh7loRZMU03jxtsbP1lkxG1qMMlfEoGEY64NSNQ/SsBHe+b2E+nK/h3mSOEOtS972JvGLRfvoJ5hH79EWe0LLQIMnpgsVi4/z6mMtFasdkXG3s9f7eeliHg8hnxCc4m831OU/Z4svmDBx636fyIoFNQSBv/1vcE6x2e4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766546992; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pgvFPCJXhtluCAV66VL90Qhj7kF7VLamnOW1x72E0H8=; 
	b=UgGaYISkipVknw4nT3nAfMbMzy6OIeUOTjfFdq9sVprgZyIv1DxtybXrXf4v2JDrcse+jC5B+4ACQPE8jn3vMeQU/Le5EfoR18BYd/610CJp/EzTHgU4C7AKvwzKcZrDNfiCasWgZvW955bbHQjck6W6Sxkzey/j0ehmMOq00cI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766546991;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pgvFPCJXhtluCAV66VL90Qhj7kF7VLamnOW1x72E0H8=;
	b=Ym/brqctNxTCBN5Isw100DdpX09KFzDNVZo6MfHUZPN4hTUzEBpQEVmFggoKNSdN
	UhBh+OVZEflACkmY8inlfXyg7+zFB6J+8klSZ2/ShkiHxxp/cIB4BoIb22a1vL3xfCc
	PmX6w5HmoWN7TLmvDW5wiG2qv0uvhMUJDL58eMS0=
Received: by mx.zohomail.com with SMTPS id 17665469898281022.4434469429821;
	Tue, 23 Dec 2025 19:29:49 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [RFC v3 1/2] ext4: fast_commit: assert i_data_sem only before sleep
Date: Wed, 24 Dec 2025 11:29:41 +0800
Message-ID: <20251224032943.134063-2-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224032943.134063-1-me@linux.beauty>
References: <20251224032943.134063-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ext4_fc_track_inode() can return without sleeping when
EXT4_STATE_FC_COMMITTING is already clear. The lockdep assertion for
ei->i_data_sem was done unconditionally before the wait loop, which can
WARN in call paths that hold i_data_sem even though we never block. Move
lockdep_assert_not_held(&ei->i_data_sem) into the actual sleep path,
right before schedule().

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/fast_commit.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index d0926967d086..b0c458082997 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -566,13 +566,6 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return;
 
-	/*
-	 * If we come here, we may sleep while waiting for the inode to
-	 * commit. We shouldn't be holding i_data_sem when we go to sleep since
-	 * the commit path needs to grab the lock while committing the inode.
-	 */
-	lockdep_assert_not_held(&ei->i_data_sem);
-
 	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
 #if (BITS_PER_LONG < 64)
 		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
@@ -586,8 +579,16 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 				   EXT4_STATE_FC_COMMITTING);
 #endif
 		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
-		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
+		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
+			/*
+			 * We might sleep while waiting for the inode to commit.
+			 * We shouldn't be holding i_data_sem when we go to sleep
+			 * since the commit path may grab it while committing this
+			 * inode.
+			 */
+			lockdep_assert_not_held(&ei->i_data_sem);
 			schedule();
+		}
 		finish_wait(wq, &wait.wq_entry);
 	}
 
-- 
2.52.0


