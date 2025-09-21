Return-Path: <linux-ext4+bounces-10326-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39200B8D541
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 07:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 401107B2415
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 05:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F029296BCB;
	Sun, 21 Sep 2025 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCPUyDc/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8107249E5
	for <linux-ext4@vger.kernel.org>; Sun, 21 Sep 2025 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758432204; cv=none; b=Q5iszdaxPEz8l7e7CxS3qcqExmgWTJszc/s/45tjiAU8De/uahcQykwYWtQ6NfUQcsepSVBxLGyw80Jg61JgQifArk1QvIzFzV4zqjSqNHa7YZUCOh2wn/uMIM/1i9c44vFRsoFg7Kz6W3jObygSTBa8K6pRifYWGARhkxCBT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758432204; c=relaxed/simple;
	bh=McF/z5lXBP7Ah9glPGzxglvf0lJ+HR5H+K7VjrPVKbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHpKkRfOft1z7r6eV3t2kXdpE25EGoh3a8bwsL/RT8ZYWhycGL/S0vIOPqSXqxJkhsr2az57GHYt8twfWYKJWHBlVXRzD2xQd/RfcQ/d6upbHQTyiarJDIKOp+kJdBFOTeLZVxIbMjeM0L8SGtCxxQn/Gr4jBXZPfJN/FYIIRgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCPUyDc/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f207d0891so485855b3a.1
        for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 22:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758432202; x=1759037002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/raf1KHNuoZawiMU7Nd52+wsbJC6EopsKr3p+fS6TI=;
        b=dCPUyDc/paT/Plu2Oe7LAYofcPbA8wH4F3pwl7DYT/GoQLHxmDFEfsvB8Jf7FSiQUd
         wfzoMbbvtSJKgsDNbY5ZRI89BvX9xXkmgO2bHzdDjbNccn0G+gJuBjdNoWN5r8aN/6yB
         gIfcsFw+Iu6Ju42ri6IxdGRbNz55YECqylY4LTWO27YwXUa9XrB1spuVsEud0UJZ+x1Z
         TP6f1pXbLa15zd1VuD4H14e4P68HSgTFHhLQpFc7Tz8HB22SuzDyH8SMPvDapn//yRGT
         0yttHn952AKvF1TDhZEnW4Wb2lOKjI51+2DBOtWlxsXlNFlTlRrDCc9l4v/kEBZaYrfa
         DMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758432202; x=1759037002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/raf1KHNuoZawiMU7Nd52+wsbJC6EopsKr3p+fS6TI=;
        b=qlhkwP2uck+bDZz/AeU8eXu3lO9lJMDfpbi6x52zh5/9y/e4T98LrhXv5iiGOD+ci9
         LKU98DWy6DdSNqakt4/Gqoop37uCQ4tjeBvHToN5nO6kVZBg5j/quIYbNkN+nQZ6poGD
         5z53NacPqttbOmY+5gQfcdKr/TLU8joIs4KEoMK4Mf3TFz94jt6v6gp92eIfBP+mhDtp
         Jkv1EQvhj0+s65fVjvHyyfHLm4yki21oB5AHHlKp52IjkmvEZsyKvwr3jadkQIssfnls
         pyIyZBGb1NsuuXIw846jMaD52qoARH9jdMy1lAARFTPZU1pLFr3C/8okDLSyr+HeqCSV
         KCPw==
X-Gm-Message-State: AOJu0YxFQnEBXe8jyvFjROGYdapKBM/kbCoY9AVRPeS+ILLe2FR7mrIL
	T0j2yCY7uES5FjOzW0nCXbFUplrJ3aqs0vYNCW+RcAckv6UFoFYjRG3i
X-Gm-Gg: ASbGncu4dwpYdnFS+8rad5a2+heEzqKEDVwoHZJRVk77Gomh90YSOI46mCZhYvtZOq6
	5CX0bj8W1a5yGKLco87uzMbyg4pZ2QsFdhlUYOuKj+W7twX3SOTnEAI8g7KWhXeMjCTeWTANSNw
	om53HEOSBw1znu2fe74okM/6MSBQLjAREkk8KG+c74wgKclQV4i8pdOI6UUR05chr27X+TQ2rZO
	kgfFsB1NBkWF+3VmfpdbJ/3cFgpGAmHKaghMfU2e/ggFS1zCPST28H7HXnQb9cHvGyy6KhatNDs
	aeT5r6edyP6FQpDted9+86PYH8lE2lboiOQzoRiL8CTDM9fK2t5mZGkIejwRzfeEJ8G5GBxuUzt
	ABkLtNztj0uQj8kCmHQVOL2McMbawryFVlB4fnC42rrQK6f7iI60ZW1ggqfOhiF5GfIncVCE147
	zt4JE=
X-Google-Smtp-Source: AGHT+IE7sk2/QI9x5a6PC0rz1xQPiS7oGhVmRLqRl1OKWtlPZ60Vk2kU++eRbYWB+hakKz/2eZ24wg==
X-Received: by 2002:a05:6a21:329e:b0:247:f6ab:69db with SMTP id adf61e73a8af0-2927182b69emr12433096637.40.1758432201918;
        Sat, 20 Sep 2025 22:23:21 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:9135:55f6:8a14:ad5c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551518480asm6618264a12.28.2025.09.20.22.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 22:23:21 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Cc: linux-ext4@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: [PATCH] nsfs: reject file handles with invalid inode number
Date: Sun, 21 Sep 2025 10:53:15 +0530
Message-ID: <20250921052315.836564-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Reject nsfs file handles that claim to have inode number 0, as no
legitimate namespace can have inode 0. This prevents a warning in
nsfs_fh_to_dentry() when open_by_handle_at() is called with malformed
file handles.

The issue occurs when userspace provides a file handle with valid
namespace type and ID but claims the namespace has inode number 0.
The namespace lookup succeeds but triggers VFS_WARN_ON_ONCE() when
comparing the real inode number against the impossible claim of 0.

Since inode 0 is reserved in all filesystems and no namespace can
legitimately have inode 0, we can safely reject such handles early
to prevent reaching the consistency check that triggers the warning.

Testing confirmed that other invalid inode numbers (1, 255) do not
trigger the same issue, indicating this is specific to inode 0 rather
than a general problem with incorrect inode numbers.


Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Tested-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
 fs/nsfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..42672cec293c 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -469,7 +469,8 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 
 	if (fh_len < NSFS_FID_SIZE_U32_VER0)
 		return NULL;
-
+	if (fid->ns_inum == 0)
+		return NULL;
 	/* Check that any trailing bytes are zero. */
 	if ((fh_len > NSFS_FID_SIZE_U32_LATEST) &&
 	    memchr_inv((void *)fid + NSFS_FID_SIZE_U32_LATEST, 0,
-- 
2.43.0


