Return-Path: <linux-ext4+bounces-12476-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98858CD6810
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Dec 2025 16:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F80F300C15B
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Dec 2025 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE892324B16;
	Mon, 22 Dec 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="H93F6oOa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58801B425C;
	Mon, 22 Dec 2025 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416769; cv=pass; b=EgtYgohgqD4eWqO9+ZOMLI3/LRjqBkUgPmbviIEpOnq6LvO4tDa6UyEe33sHRnvVnPoYJeldUx3beC05lXgmLNXkaIE/HjvbIxdo9qo+IksiLuOkqmj62GohaBXTA8tJ4IJ1AKIfFMa0d0CLtnCLCcq8FU2XZub8IMcOrPV4FUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416769; c=relaxed/simple;
	bh=r4ptAC2F0Cn+nJWJyf4HdcW9QhTtDYM63WnoejFKh8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUABc9hqgoNYVy6MU517/rTBPeio9APT9aQEGZgMVG7C+h3ZpnU5MH4XS5Q2oLDqfAOE8+jd3OxW+8JcUfC6t5PoX3akJLR81wG7VjOldZgBQfUqDeh3qnZ+PkdeKXnkNo4X+i86tpt9MbLGz1EYBdjhjnaf0ABeYXx0m/Tij1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=H93F6oOa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1766416762; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DKq2oiRe5FxcZngqCrvBmxjnANWI8H0dtq0kcwSZIRoAqNFquWcBqIk+kzbrXNblY2wqJeOCBoUZ0YIudorkNWuShwV1Z4OlcQkpJRuKv9UTsuuiWPSdhspSf7Advf7UoSTKsS9a3eo9FGJYOBQQY6dRD2Cm9RZiPOhnY6fd9ns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766416762; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3zJGWOMUhwbiCCj7ibA/R6CB577jChz4KZzN1mfnc48=; 
	b=aCCUWb/0JAL7rT9gvblwqqVRkWqMUBWzCBN9iJNiY4+d22Dw/H603UO7X0JvFaH0BFVKebPxssfqi1raAmqffZByAOCl5eX7fyIVgX2BgIqXItEALpx6QnhSdGFSdga6hEm9YUv+jAcC0gLFPDl+ixx43UI4QgT+zibO95zI6Mw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766416762;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3zJGWOMUhwbiCCj7ibA/R6CB577jChz4KZzN1mfnc48=;
	b=H93F6oOaCgy7ehFXCIGoxkbXfA+g3RhaUJTEcy7MGAsJFH9Zs/K8E/KcxxIX2W0j
	GRRDZn0XHztGHoIOa3gduCxCjgB6vH4atOLcxxkvs3dGFjcmaeGaFDbCaozFNKuaFtF
	8nqqIV9YQ1QTS5nQ1qP4wwyZGfbVozAO51a1L/+w=
Received: by mx.zohomail.com with SMTPS id 1766416761124611.196757545155;
	Mon, 22 Dec 2025 07:19:21 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [RFC PATCH v2 1/2] ext4: fast_commit: assert i_data_sem only before sleep
Date: Mon, 22 Dec 2025 23:19:05 +0800
Message-ID: <20251222151906.24607-2-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251222151906.24607-1-me@linux.beauty>
References: <20251222151906.24607-1-me@linux.beauty>
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
index fa66b08de999..3bcdd4619de1 100644
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
2.51.0


