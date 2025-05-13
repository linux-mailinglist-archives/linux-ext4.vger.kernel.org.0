Return-Path: <linux-ext4+bounces-7869-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B26AB5AC7
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 19:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D8419E170B
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6851A2BE7D6;
	Tue, 13 May 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egkiV0DY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9D2BE110;
	Tue, 13 May 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156065; cv=none; b=cYHxhfZDOml0MuaLP5F03MZE6j6+cf95SDlM0Uh1zpJ1FgL/iRoZg4Sbb41nb+5FoIFhklzQDxdCP9mrO9Ni6iiXaqyJQWr2BvCtUALM9e4sVDrHEhmp65qw2pqYKF22q3c8xHs0YvIiJ3nIQOxP8DfpAU7VF6N8f24LzSIcqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156065; c=relaxed/simple;
	bh=uanJLByxQFW3gbTPTgvXVKnJwMqfoxW0i7mA6lk5O9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uv61hEdzp19AD1R+qxJEe9JbrcGQXsMWs/ksmxGTToYlWtJlkH8hSym0JGCs8OprbZe3YfS7q/50TKo406TGaIEbG/V4jbbSjTz8HRCuNhVpJ2+InaumYieMYgB2lVu6fn5hId0wpUcUEQ7PipIJ+/KUhUOkBIVCZbjPJOB1Y94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egkiV0DY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30a99e2bdd4so5248459a91.0;
        Tue, 13 May 2025 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747156063; x=1747760863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfL86GdlhnBK3jXx8LFujEcI9N5sypqjwqtS1nmW2i8=;
        b=egkiV0DY99hgUVYh5j6LU5NzuheVJ3z7m/T1B/eS46UwSfztNnAK1SDRrkoF3ALCGR
         JhBGVneemhlmEXw9haPM7+bGR9f0hZEfDFDuytyeSQKFGHVBbsNhnasD0trPS5h4Pljn
         XFgrqcF+nbY86Zb/LSFNJi4HF9nLvMwMW/4DXBt5cbVH4oQMAiialEssLStnFEdRWUUl
         HnEdsVqHAv0c7FW3A8MR2OnL6DSf6QZmG+BrjDMX4tHBFFFh7N/N0AQeOF9J5XF5AZvw
         uYy/DE6uaWL1uqOmU8j6/0ArrU0Ng5TYAzVfxImtWreDNRMIS38q41t+oYDgKM/zO9/Q
         2RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747156063; x=1747760863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfL86GdlhnBK3jXx8LFujEcI9N5sypqjwqtS1nmW2i8=;
        b=uAP2vJHZ6VoudXrF5ftvMaKGJf9GrVYgxZMcCMB9sQ75VeuuXc1p4UfSjFIJbqPp0L
         fvZBv0/ap2LNcpWGALy6ooZO5zPYeufB3XQR+JmijnyAX6JrScHKk3KOYnWc3zDuPIta
         vxFtAzOnpCSM33bEHz1gQwRrnRimhrGXNTgPKr34xBDY5KuGf9SFslDikXrHv/ItER0/
         w3jZXg/2m9vI1eYXTS2i5mem4bqwcLLgkIzbctzk9lY2KWqjpCX3SnMfSEyEC9EHHkl/
         am5GS8u+xdjavgKi2QZQr4yaTvgzq3pto7koxdKGzyul/pmhKyf6LtZtjRQzDh8gbd+0
         9boA==
X-Forwarded-Encrypted: i=1; AJvYcCUJn16IEEuJ8qFI1zF2kGz2rmqxIEAbjKuHwesQ01oQLFBLaFk9wANFXkGBXkN2NVvqsvwmMUmxoC1EUgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNfF0usXHxUXwbpnxnEDJU4GwSn0CwCOGFw95PMpcu/lcDASQ
	T0xe1pxpryuX5JOchuRUa3aT1QgUDZ9vHm64AHptUtdQF96x94eS
X-Gm-Gg: ASbGncuJmDOGcx5KoEdDKI0bQ6YTP/fod6wmZpMz4gq0kHjqPuM4jlzibc8Qaw4a2nS
	ir4/5RE+OGTqc6UH4B1v42rg659l9wPNCp4jwULsE4uVc27JCT1j2/NF9HHOZ7sKeDi6VdEMg38
	a+w0lmmi2hg+4+8LNZQdTdloZ40I7qEn7CUyW1bNzn4G+dXrdoyiy7bHEYtvLXocmQqw40OBr7Q
	hD+fEAYgm9pzvUBhcQOCuEXMtGg6DS2gP4wzn1nNtjxV5liJYIFUyJQ3hkRKIr2p3dpBNrCqJ9c
	NeKAxZVmWyDy4hW2VzQq3lOdKyp8XhBtsrZHW5khChkwa2FDfphWziQc5KxpsPrpEuR/aVX87pN
	uah6a
X-Google-Smtp-Source: AGHT+IE550DTZxU0fAa0iB/XH8wB1LPuYOfBQ7sf4z66ubJSzSBXCrqXU7OTN2wRAWtJzZbWszP1Zw==
X-Received: by 2002:a17:90b:58ef:b0:2ff:64c3:3bd9 with SMTP id 98e67ed59e1d1-30e2e625f04mr394350a91.23.1747156062426;
        Tue, 13 May 2025 10:07:42 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e75dbfsm8756276a91.41.2025.05.13.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 10:07:42 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: tytso@mit.edu,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
Date: Wed, 14 May 2025 02:04:41 +0900
Message-ID: <20250513170441.54658-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since handle->h_transaction may be a NULL pointer, so we should change it
to call is_handle_aborted(handle) first before dereferencing it.

And the following data-race was reported in my fuzzer:

==================================================================
BUG: KCSAN: data-race in jbd2_journal_dirty_metadata / jbd2_journal_dirty_metadata

write to 0xffff888011024104 of 4 bytes by task 10881 on cpu 1:
 jbd2_journal_dirty_metadata+0x2a5/0x770 fs/jbd2/transaction.c:1556
 __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
 ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
 ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
 __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
 ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
....

read to 0xffff888011024104 of 4 bytes by task 10880 on cpu 0:
 jbd2_journal_dirty_metadata+0xf2/0x770 fs/jbd2/transaction.c:1512
 __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
 ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
 ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
 __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
 ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
....

value changed: 0x00000000 -> 0x00000001
==================================================================

According to this crash report, there is a read/write data-race in
jh->b_modified.

This is because the b_state_lock is locked too late.

For some reason, jbd2_journal_dirty_metadata() has been written in a way
that it does not lock b_state_lock before checking jh->b_transaction.

However, This makes the code that checks jh->b_transaction messy and
causes a data-race in jh->b_* variables. Since locking b_state_lock
earlier is not enough to significantly affect performance and most of the
functions defined in transaction.c lock b_state_lock before
reading/writing jh->b_*.

Thereforce, I think it would be appropriate to modify 
jbd2_journal_dirty_metadata() to lock b_state_lock earlier as well.

Reported-by: syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=de24c3fe3c4091051710
Fixes: 6e06ae88edae ("jbd2: speedup jbd2_journal_dirty_metadata()")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/jbd2/transaction.c | 49 +++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cbc4785462f5..7e6dbf37396f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1496,41 +1496,25 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	jbd2_debug(5, "journal_head %p\n", jh);
 	JBUFFER_TRACE(jh, "entry");
 
-	/*
-	 * This and the following assertions are unreliable since we may see jh
-	 * in inconsistent state unless we grab bh_state lock. But this is
-	 * crucial to catch bugs so let's do a reliable check until the
-	 * lockless handling is fully proven.
-	 */
-	if (data_race(jh->b_transaction != transaction &&
-	    jh->b_next_transaction != transaction)) {
-		spin_lock(&jh->b_state_lock);
-		J_ASSERT_JH(jh, jh->b_transaction == transaction ||
-				jh->b_next_transaction == transaction);
-		spin_unlock(&jh->b_state_lock);
-	}
+	spin_lock(&jh->b_state_lock);
+
+	J_ASSERT_JH(jh, jh->b_transaction == transaction ||
+			jh->b_next_transaction == transaction);
+
 	if (jh->b_modified == 1) {
 		/* If it's in our transaction it must be in BJ_Metadata list. */
-		if (data_race(jh->b_transaction == transaction &&
-		    jh->b_jlist != BJ_Metadata)) {
-			spin_lock(&jh->b_state_lock);
-			if (jh->b_transaction == transaction &&
-			    jh->b_jlist != BJ_Metadata)
-				pr_err("JBD2: assertion failure: h_type=%u "
-				       "h_line_no=%u block_no=%llu jlist=%u\n",
-				       handle->h_type, handle->h_line_no,
-				       (unsigned long long) bh->b_blocknr,
-				       jh->b_jlist);
-			J_ASSERT_JH(jh, jh->b_transaction != transaction ||
-					jh->b_jlist == BJ_Metadata);
-			spin_unlock(&jh->b_state_lock);
-		}
-		goto out;
+		if (jh->b_transaction == transaction &&
+			jh->b_jlist != BJ_Metadata)
+			pr_err("JBD2: assertion failure: h_type=%u "
+			       "h_line_no=%u block_no=%llu jlist=%u\n",
+			       handle->h_type, handle->h_line_no,
+			       (unsigned long long) bh->b_blocknr,
+			       jh->b_jlist);
+		J_ASSERT_JH(jh, jh->b_transaction != transaction ||
+				jh->b_jlist == BJ_Metadata);
+		goto out_unlock_bh;
 	}
 
-	journal = transaction->t_journal;
-	spin_lock(&jh->b_state_lock);
-
 	if (is_handle_aborted(handle)) {
 		/*
 		 * Check journal aborting with @jh->b_state_lock locked,
@@ -1543,6 +1527,8 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out_unlock_bh;
 	}
 
+	journal = transaction->t_journal;
+
 	if (jh->b_modified == 0) {
 		/*
 		 * This buffer's got modified and becoming part
@@ -1628,7 +1614,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	spin_unlock(&journal->j_list_lock);
 out_unlock_bh:
 	spin_unlock(&jh->b_state_lock);
-out:
 	JBUFFER_TRACE(jh, "exit");
 	return ret;
 }
--

