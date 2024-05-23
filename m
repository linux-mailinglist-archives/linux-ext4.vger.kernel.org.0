Return-Path: <linux-ext4+bounces-2642-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0778CDD0C
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2024 00:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511A62882B6
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DDC128391;
	Thu, 23 May 2024 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UpBwIAxP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B5127E3F
	for <linux-ext4@vger.kernel.org>; Thu, 23 May 2024 22:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716504859; cv=none; b=e5ngRaCXHmTlbxQ4KI4IHiR8doWs7l9rW5nz2PGVKcs6OAQ4QxTAKEjY/Dt41EDSp1WF3Qas4Bipu+M2wOyOoao/PFMBMc2PDK8S5VxgETzIqO5nFuA4JBAvB1gfexU+FJVEK9OJ6v/hPZT5ZN4PQ8QGo4rwiO66/n1h8Xs/KXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716504859; c=relaxed/simple;
	bh=8xZg34USATzGqgSCdoZnVM1prsayTUdOdmM7joOB0uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X8D24nQxBfEaEaGYw4Z+GGkB/6UqhZbx3vriv3I6BjIvKBj+EQ6LSBlwPYlCCj2jhXcFvPH67/20R7VlWK7YmPBlnr8221Oz7R35eaIeuOvYMv/q7xoTVlq5Y6skZpcnJY1X2odfpeVoO/UVNmSTAEp8drTFe9oEZor+uIvh3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UpBwIAxP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f67f4bebadso2754766b3a.0
        for <linux-ext4@vger.kernel.org>; Thu, 23 May 2024 15:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716504857; x=1717109657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+HxhhwWxpOnO+u12YpT/sUY3evQxw+3Sm/bBnvujtM=;
        b=UpBwIAxP8CCxW4jrWfS3V6bDC0IBR265o0PqFnhQOSS9UjRwxYPYuMIhVOA9tuRoL7
         cvjcFx3WbI8B8NMKhdNErcOHfxjFmc5c6W+aJQAIoXRgOt7zERzNV/YXpXdEYpabbi5v
         +JcQ/4v4qsd4qCvD+wn07HLYxoB6A+KJctbM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716504857; x=1717109657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+HxhhwWxpOnO+u12YpT/sUY3evQxw+3Sm/bBnvujtM=;
        b=MwhcdWruzK5iRSuSZGYNiKf5fZmzHnJcqWKAHdQ5ApiObiWlolA4jYc8OKMs743Oqz
         pofnkYaMzR8WAktVrURYEsnhQ+soAvraFnwUBU71FqEYvOHbnDnqEwAelx9E5aEOiSfo
         orDYDrTn2RyJBUSlWQeb+PBZt4Oo8UmB64cqNbGM7+hRAV6/PwLkNFSwzyvrzx1/7iYX
         iiSurPi6hZuTYf5+JLFeU98tXaHSJ3Fh3oKjcjOoHhUUnIJKV4J5uXkTmrkHGh9iHtnu
         ZFyBcToPpohMqCpFdzFbbV0qHA9qwGk/b3LLX3QF9FZf2v1ME+QRIlf6rZEyMBiwEndH
         LHxA==
X-Forwarded-Encrypted: i=1; AJvYcCUuV3s4E/KGQjCSzB45H7+UJkdqSFVUn4f9afxWMaICf3VbkNyNsAUdxxBWy9uZVc4KsfV/szVbj44gDaJ1rKCaSHnHsFAnokbkiw==
X-Gm-Message-State: AOJu0Yw/aMP5IL1UQIZM9SiCut5sPppCtotw+qGvBO5WRNhchd4B01qE
	osDLLwpYoeJNPswM/5vGatUDg0bXrSojOF5VWk4VnPgwn1JSgg6JX96jlQyiKA==
X-Google-Smtp-Source: AGHT+IFJDeRVzR/CmcQh9/usRPuj/9gA0/y1cIEjghi9Zyo54TlF+rIffB8Oldl/5AWX2fVfA4L5Cg==
X-Received: by 2002:a05:6a20:43ac:b0:1aa:43f4:3562 with SMTP id adf61e73a8af0-1b212d38fd6mr1062643637.11.1716504857311;
        Thu, 23 May 2024 15:54:17 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75f5d0sm1074095ad.43.2024.05.23.15.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 15:54:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kees Cook <keescook@chromium.org>,
	syzbot+50835f73143cc2905b9e@syzkaller.appspotmail.com,
	Justin Stitt <justinstitt@google.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ext4: Use memtostr_pad() for s_volume_name
Date: Thu, 23 May 2024 15:54:12 -0700
Message-Id: <20240523225408.work.904-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=keescook@chromium.org;
 h=from:subject:message-id; bh=8xZg34USATzGqgSCdoZnVM1prsayTUdOdmM7joOB0uo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmT8kTsKNHKThRJmlbWkYa4+mZSvIto0827ZvNs
 WCZOoohy+yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZk/JEwAKCRCJcvTf3G3A
 JuH4D/0YcQozks4yjfdJp7U58EIbhq/lnbt7NB1OWxBMXL9t98LlkWEIMinU56rGRalVUDuONy3
 JDueXhRyT1F3e+zrD0GTObAxCL+cvcb6QGy9ILi7yKZvMcQFZgARmHPilFPpWQL0UUMIgAWFjps
 3PbD1qw/GJ1vEbRl2zmEf/GWEF9CoCfoLqEcyXKNuuj3qqiHAagfo6tZebDx7lmD2k57aAE6Vab
 cI3ZvCeoF+fw9DJ4omnVjn7IQYdwX3ECToeHhowoa1CB09PmtTjkZqkEh8wTXFrF119OFPOG2Ye
 cQKslnD1VeKZJYzUoEo6nCphqN73cOIcrgYlXsAs0nIwUbXwXtvEsTlqO+uuQMokwX/x/5h4yNC
 6aGovyqMkokthVPQqiW3z8UwM0iQzG0FFmbcrKshIlWt6HdDxHVrCEHhExxQJ1YAIYs9Yr/4Xl1
 CYXQOFQU9cMFrojObq15H8Ek9AYQPGtoeS8RJhSYSlhjPdPIG2+Z2j8blrvnX17w/OZrOYdSgwN
 fkWX3rVJzXA7XqWyxFlg9+MGW8Ku0pB8my8aXfXqeXhkiW0Ic1dDzSbiHkFpVGNhCsJQ1f6RmxQ
 1dKYTnbs6SwF8rh9r2ICYOhfwTqsMEOrYoIN/L+5KW215bnvyMyt3M3XOZqEeEM+d7J4mhb14uB
 LDpJFno Vq6wsq4Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

As with the other strings in struct ext4_super_block, s_volume_name is
not NUL terminated. The other strings were marked in commit 072ebb3bffe6
("ext4: add nonstring annotations to ext4.h"). Using strscpy() isn't
the right replacement for strncpy(); it should use memtostr_pad()
instead.

Reported-by: syzbot+50835f73143cc2905b9e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/00000000000019f4c00619192c05@google.com/
Fixes: 744a56389f73 ("ext4: replace deprecated strncpy with alternatives")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
---
 fs/ext4/ext4.h  | 2 +-
 fs/ext4/ioctl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 983dad8c07ec..efed7f09876d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1347,7 +1347,7 @@ struct ext4_super_block {
 /*60*/	__le32	s_feature_incompat;	/* incompatible feature set */
 	__le32	s_feature_ro_compat;	/* readonly-compatible feature set */
 /*68*/	__u8	s_uuid[16];		/* 128-bit uuid for volume */
-/*78*/	char	s_volume_name[EXT4_LABEL_MAX];	/* volume name */
+/*78*/	char	s_volume_name[EXT4_LABEL_MAX] __nonstring; /* volume name */
 /*88*/	char	s_last_mounted[64] __nonstring;	/* directory where last mounted */
 /*C8*/	__le32	s_algorithm_usage_bitmap; /* For compression */
 	/*
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index dab7acd49709..e8bf5972dd47 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1151,7 +1151,7 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
 	BUILD_BUG_ON(EXT4_LABEL_MAX >= FSLABEL_MAX);
 
 	lock_buffer(sbi->s_sbh);
-	strscpy_pad(label, sbi->s_es->s_volume_name);
+	memtostr_pad(label, sbi->s_es->s_volume_name);
 	unlock_buffer(sbi->s_sbh);
 
 	if (copy_to_user(user_label, label, sizeof(label)))
-- 
2.34.1


