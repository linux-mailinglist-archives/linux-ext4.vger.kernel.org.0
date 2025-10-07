Return-Path: <linux-ext4+bounces-10651-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55025BC2FC2
	for <lists+linux-ext4@lfdr.de>; Wed, 08 Oct 2025 01:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 403474E8858
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Oct 2025 23:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C42221DAE;
	Tue,  7 Oct 2025 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZ8c0jXd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6681234BA5F
	for <linux-ext4@vger.kernel.org>; Tue,  7 Oct 2025 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880716; cv=none; b=lrCX7tCHJ2AJk1AKtBS2EhQxPQb0Oo8EAAdLtZmUf0voZ60S+bjvwflmM74LmFKgDucpD6O8WUkwHTCY/mXPwLrV/9smn2jqLhUXhaTQ3meJlMUW980pTJ1AR/Fx5PrByssrAE0ZJnZI71v4UGzptejUGthNmNkgd/N+PcGag4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880716; c=relaxed/simple;
	bh=t4jCJVkxoZJxN5/EmPGG5tBlDrNWCM4Ia/uSSq0TPUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCfzySr/Nro+i3/JTPuXWOy87QzW8oRz8uTBEwOzLbedbt+SU6Uwc23erxdaeUU2LkmIu1udGhR39UJBtXBal0ElioGcCzsnFefyjCF2REmZi6kpXHbJNIntUapP24sBJfAPHXoGQ5xf2pg9E74iteAaZriOACmVV8pgtaCcWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZ8c0jXd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so59540565e9.2
        for <linux-ext4@vger.kernel.org>; Tue, 07 Oct 2025 16:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759880712; x=1760485512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDfdN6rIqKoqG6qeZ1NEX3pLR4+cLj1rml/VExyclBs=;
        b=EZ8c0jXddk/1wDxnojFYF0rVadjGeFjZN/iH3AH0kfqlV/sM+tpYFxxqKGDkOCrz/H
         g3RCLhfGdP6ERGS4LmDRF2I//ESpCYXSzwWqhb5BsrbOedlmFLKrv82eOLRNKIuIkkGs
         yaJ16bwXZgI/jhpGn+zd6F+D5zpYPuAWsNk1AqUK6lTjKcim3J97v+GyreRYK2qxl3g5
         RJDlMqk9kNStpBnloXAFfiuDVKNTtgcPhNr0ymiRYBBJxqGOq0pg6uaCA8D9wXM2F3Vm
         BQB+Jm55eVyv4clwy1Axe84re1+93yxyv7diLZsQ9WTp+FbqnGCVxCwfLcq6eqvjBqFA
         LAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759880712; x=1760485512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDfdN6rIqKoqG6qeZ1NEX3pLR4+cLj1rml/VExyclBs=;
        b=n/ftueZ5CH+jot4zGipSZ2SR8CQPoW/mlDUny145o0Zfds33sz8ZVjhQOG9veOzokk
         F9Aeno7hf41dIpOxgB28ufDHLI4rVttnJkRNT/+FaA5ta5AQBhFRoGUo1GuuVMvD/zBi
         SC9LG9U7VKEFiGmK/ZgQjCtUMP7wAtlhaj/iRaeJu56TCClj+oMGn97lyRACh3X5TrUj
         Dmj0RHSRdqTVN0VIJu0NPrARCp94BdBvz7qfOvhRO8gHmjLRhG1Urcd+5jpKQR9IIzuO
         M0nllhWAIaCO29sAipiLD29jjoQ0RHcZsSo7h7vXOGugxpF2T6M7O9p6vyzJVWw76zsn
         hVEA==
X-Gm-Message-State: AOJu0Yw3+vrZFiu5CBBfrpCcH+zZhcL0EtAcYwVsXY6jKqIcbe9fMKym
	a0Db6IJqhRdmS2Y1lyox5GPzieIZvUKhJZBkmLDoiTsfLdC9btF0MgGo
X-Gm-Gg: ASbGnctATYzPQL0qk2k3weSPteDnnMI0RPw8aCpSV5WkyGt3buDkUnSouxwhdAmnh2t
	SFl0RbgnyoP1jeo9+N2YuseRGyefBXGoMCPVrddKgwTgMCh7nD13JV9+TMJXQOHhetxqp3Y+vL4
	VwO6rM34l7gmk3TkieUWw/vR1H5fTxb4rmUhFqIvspgnV0b3/v2Y6n0AWPr/pl0XtqnLBx6wIER
	b1c4sshV9SEnEy1pEOnnfEc+9fgAl5cLtgN4gurVNLoaL4YOzmSCTgmhXrFkZS6xGEjN4wTh8/U
	DfWNrfTJT40o/yRc0woAlFc9hRfnvvGfQAmkCrzJAxwpsJF3QOjCl8EofXVIFVGX9lIvhXMfwx/
	oiGcIeGoALgqCVVLcOL2czngqq/BVeMeWCHuHcUKid/M91eRM
X-Google-Smtp-Source: AGHT+IEt32j5aTlsj5mt5Vj8nJDWXlTmSLYYgW3aLAsDb+6G6ToKNZ2kXLfLfkP0BbJLDMQBydQ4Tg==
X-Received: by 2002:a5d:5f82:0:b0:424:2280:5079 with SMTP id ffacd0b85a97d-4266e7d6d67mr603421f8f.25.1759880712163;
        Tue, 07 Oct 2025 16:45:12 -0700 (PDT)
Received: from eray-kasa.. ([2a02:4e0:2d14:1539:70f9:c50a:91c9:9e0d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab909sm26693197f8f.19.2025.10.07.16.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:45:11 -0700 (PDT)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [PATCH] Fix: ext4: add sanity check for inode inline write range
Date: Wed,  8 Oct 2025 02:42:22 +0300
Message-ID: <20251007234221.28643-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple check in ext4_try_to_write_inline_data() to prevent
writes that extend past the inode's inline data area. The function
now returns -EINVAL if pos + len exceeds i_inline_size.

This avoids invalid inline write attempts and keeps the write path
consistent with the inode limits.

Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com> 
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 fs/ext4/inline.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..13ba56e8e334 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -782,6 +782,16 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 	struct ext4_iloc iloc;
 	int ret = 0, ret2;
 
+	if ((pos + len) > EXT4_I(inode)->i_inline_size) {
+			ext4_warning_inode(inode,
+				"inline write beyond capacity (pos=%lld, len=%u, inline_size=%d)",
+				pos, len, EXT4_I(inode)->i_inline_size);
+		folio_unlock(folio);
+		folio_put(folio);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (unlikely(copied < len) && !folio_test_uptodate(folio))
 		copied = 0;
 
@@ -838,8 +848,8 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 	 */
 	if (pos + len > inode->i_size && ext4_can_truncate(inode))
 		ext4_orphan_add(handle, inode);
-
-	ret2 = ext4_journal_stop(handle);
+	if (handle)
+		ret2 = ext4_journal_stop(handle);
 	if (!ret)
 		ret = ret2;
 	if (pos + len > inode->i_size) {
-- 
2.43.0


