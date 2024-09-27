Return-Path: <linux-ext4+bounces-4364-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E0988956
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 18:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15981C210DC
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B61C1740;
	Fri, 27 Sep 2024 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="YKC+aHS8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B255139587
	for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455904; cv=none; b=kpX3+tMWeA540sU2y2eXhcz5X+9hBoIUx2CjRakFdo24uM6DVVfv509HP7totw+nRP+qymslg2Kju81G+Ld8F9niLPGUX4nctz0oDPM1Dxo6cLt35LL7cEhKXV3/yEr184y627Sw8v8wOtycIfteYkV1HNzoXgWFuLRqTyXoSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455904; c=relaxed/simple;
	bh=w1hDeaaqePkObd4w74ICxIIrNF2olAqnyLHEkqzZJjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lnnASOjlP3u67a715oJfV7E+TGNOMPqNdfgf4Wog1FgpnxqgvYuwGkdIByVDjqI+6aUdyaql1PW0Vxes/LVbZlGhOMLNUMEoM7aqgTj8W4cNo/8Yo+4khPGvfeLW0Y9T6Hx1PWEvrm0YK1kZa8zlGknWXSIjmFKaXLEYWbJlTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=YKC+aHS8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718da0821cbso1883077b3a.0
        for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2024 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1727455902; x=1728060702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEYw1gYmwA8Qrj5YShUHffTTF3dzo6EdcZl8qQYjRd4=;
        b=YKC+aHS8iqgPtd9KfGe7jBZdhN9K01rPv4gFMwMYdX+dnFUWctPZOO4kXAmbSTei3T
         erqG3zFX3oiHlTZoW9Tmd/5lDV4khto3iKSVluo8xWhKOmVhR9liLtiG8X/D36vs+qlu
         SkvK0zJ++1w1cwNwqif2/Zo/fDHlNt3Td/qUe40Sy0dBN2nIPlcDx2zu6RyDDQWBVY+9
         hiZOIh8EobziIoovz0x/WoOOjTh6r0GhmtvYKVuT8uPMcm56eosL6uOXvnlLbFnfzXhs
         YCQQlo75JXGI7YzsDUjO+tKCfDucBVwdWmQn0H/9FahSXixFKK60CfSLR/ZSkLies8Ad
         bnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727455902; x=1728060702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEYw1gYmwA8Qrj5YShUHffTTF3dzo6EdcZl8qQYjRd4=;
        b=JOosz1Ef80mCVd/uYeLrxPalBdfGdJQC0wX/twISAzwm1aS9k1SLbr3hWJ+ZMPj/7W
         7NLOTx/QRONcIk9S7U7cTj8kANPLHrzlGL2O7JCZbRWGrmOCFHj/uru2TWrAGyKlek4g
         jCV0gNYRzOgv0sAQGsVBA+0a7rnFswWxXNQI3RA2NdvggYRVjVtMqxPQj+3QP2mcmfWR
         g6eRDB1F7I3QtCZpnA6nfggpq4Fgwu2hRsu25aHsXSdO79/CWd/1Y/T6Ik5dNikmA5Ss
         SOlG7VYhOO0VZcCYalAb5KbWWZFHRTSZa3JUq0GitjntkkofJruaSkxw+rtSOY+07AjG
         OVGQ==
X-Gm-Message-State: AOJu0YzCeIFFsAj4Mg1OIyTCAVxvr1n+G5/+W5d3cQiTKIcmiC/tYUDX
	MYj7UUTiSj/hcxfQ+S/hjOaTmyd3KeXf25J9Os/Gcp0WD48kcFRZmFvxI7Uad4c=
X-Google-Smtp-Source: AGHT+IFhIGmE5LlhA55s0kcrgULqLsbgUkU+TsikBbl64f/xmQdYg/RN8UoCzM3MFKkvAI7Dpi4j8A==
X-Received: by 2002:a05:6a00:3d14:b0:717:8ece:2f8b with SMTP id d2e1a72fcca58-71b26057f9emr6125090b3a.17.1727455902352;
        Fri, 27 Sep 2024 09:51:42 -0700 (PDT)
Received: from alpha.mshome.net (ip68-4-168-191.oc.oc.cox.net. [68.4.168.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515da6sm1800938b3a.122.2024.09.27.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 09:51:42 -0700 (PDT)
From: Remington Brasga <rbrasga@uci.edu>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com,
	Remington Brasga <rbrasga@uci.edu>
Subject: [PATCH] ext4: WARNING: locking bug in ext4_ioctl
Date: Fri, 27 Sep 2024 16:51:32 +0000
Message-Id: <20240927165132.17289-1-rbrasga@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the locking bug with the bisection found by syzbot.

Link to the syzbot bug report:
https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd

Reported-by: syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com
Signed-off-by: Remington Brasga <rbrasga@uci.edu>
---
First attempt at patching this issue. Verified the bug exists, and that
this patch fixes it, and EXT4 KUnit tests pass. Though I am not sure if
the patch should be higher up the stack.

Open to questions or any suggestions for improvements.

#syz test

 fs/ext4/xattr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index e0e1956dcdd3..2b30b9571fd8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -124,8 +124,12 @@ void ext4_xattr_inode_set_class(struct inode *ea_inode)
 	struct ext4_inode_info *ei = EXT4_I(ea_inode);
 
 	lockdep_set_subclass(&ea_inode->i_rwsem, 1);
-	(void) ei;	/* shut up clang warning if !CONFIG_LOCKDEP */
-	lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_EA);
+
+	if (ei->i_flags & EXT4_EA_INODE_FL) {
+		lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_EA);
+	} else {
+		lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_NORMAL);
+	}
 }
 #endif
 
-- 
2.34.1


