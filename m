Return-Path: <linux-ext4+bounces-10322-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACD3B8D2E6
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 02:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5008B18A1C20
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 00:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA345948;
	Sun, 21 Sep 2025 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZf6JRG1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3B3D994
	for <linux-ext4@vger.kernel.org>; Sun, 21 Sep 2025 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758416046; cv=none; b=MRy4fAN1nUuDHFD7tcX7CPgXpM9nOftjUchmM07UjlY/QpIkOYpSTtVUEzMOMQwgqW8t7/Q+xMTItRVqje9rFMvA6lRyECx4/kQp1c63tmBR1i3dBjsmWpK3gusGN6nO6sWe8DygOLEO7NXKICkhJ7MTy7NyAoiaaDCkAmASh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758416046; c=relaxed/simple;
	bh=XJLcnpyFDbcrUNJK0RLa8lSJbTVEk9it7w3F6E4Ersw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ny0k9mtI83hlZLfzV2R8J0ul29m/lLWPx4Dys/sg73vJcb5HLYviCUk8RBKAdsjG5rxIg+67EhHzX8i5q7gRkwu6DVQPm4138yEK3Pc+q2J8lVoz1qD2xvugsXs4ap/dLHQs3qFjcFRG54xKHv8IzIYtD2Ik0fiGgXjQygGlpEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZf6JRG1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b551b040930so1176355a12.2
        for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758416044; x=1759020844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+h1Kg1XUADh46XM87Pzv9Q7V3EM4p/bXxTvuNim9YA=;
        b=SZf6JRG1+V5KA0ZyTY/kEeKEIrfftIQ25I6rTv7Vbtqd6VKAiay1V1YPMOv9VJqt50
         3ySowLuDhswoxaBGjdTAJmAdU396d+9oW5wBdv+aR9KZdZoouTiqwqVxgnodq1h9ELnf
         jYJ9KaCsi7SsPweClTtJdirHdX/Dk0C8YPMOClbCZe86+82gxzWooJ5QBx6S2O3ZC+pC
         Q5TkoqKzBEapQzd3wZ3n1WtOvclx9XclvrpUyUKgux5r166W00QYV9UUtq4CgKQ1EP93
         TPjj5GqjJaE5LJk1B8ky3Bhz/AVbLkcE3iidg/iOdouJv8PHGlr5FTosQ7sA/wB0HP06
         f/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758416044; x=1759020844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+h1Kg1XUADh46XM87Pzv9Q7V3EM4p/bXxTvuNim9YA=;
        b=oLtEZe1/BcFO/yG6rUnHmdnp/6Wm1ITL7w4R8O2gp7dWVTD9K1eTenVpiRApHIbwYa
         uOTmSUwqMrj7XT3RSP9Li54Plc5v8BiE/Dkm9jb8t2XQABfxvdqP/6cudUlVJJbWzMWe
         KbGm1bKKbPon0LzJWca79VbK5TD6KxmKA0Aj05vjTdjnV6r9RYJigBZHZGkbcMLpIlUB
         2fqxXdrk6zstUfpgb79fg2K56iPWz7Q6aU44BoO0syN9xLIBdYneCWPku2ShRB3HH4lA
         5vgrfQp5+i09RrsXsaG1mzEmIgwyYyP7MI8hu2eF3wuY+tDa/chS/KsB0uKo3YFvoHXh
         FfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnFv9sQ5BoTFIJc2WrED5TlnPVOwQElCb20TmP+6jVD9xmWer99yfpoco4eUQ0H2CR2+LnfjDHecEY@vger.kernel.org
X-Gm-Message-State: AOJu0YxzuK9kTqfNSdqelkXJWPaV/ihzlI2f/afxJ5oJ4Qwb35snVoSI
	gFDLhNZuy1EztyYzoAvtYnWju36Us+XkWSr0HASQ9oUMUdboS/tJYdHW
X-Gm-Gg: ASbGncu/Elp8pdWRLk/0ydCzr84TSN+Rpb2aX81NIizTRXS1lFhXu3WKJ+nfxKXZwOI
	PIHrW8smHGu6oHFh2O4dy6CBp8BCnUlVpkKc36gNIry2bgV4qxUuxVTMzBQcEoNvE8fMKhBqegg
	/XuuxJUBhT9XUdmH0ndEaH0mBaRB0BqmrnywfSjoBWD8qmiqFDbm9AUsr4ZbHQatOfNaitzefRG
	qyl5GkTj0I7UURv+rTqC8L50yukLO9mNuMt6tZidXNFJKGhBqSKwa28Em1uf5BVVKC+8MfXRkLL
	yVUs8BJEWCj7WzexmMSIeE4C1hlUZfJPf4Ws9f88MckR7Sg8h4GRjqyho+pITE14OPBatBXVo4F
	I41fC1z9S8OcnoxqlH2W/PvQ8fZ6vllbXzXN0dcPnnWv3noqwplsGjL7P5YYS9uHGZ/jkMyhhlY
	jEr9k=
X-Google-Smtp-Source: AGHT+IH5wvagxzQ11EQaBVs/POhQHg5J/z8nO5Itigu2Q6lwT3rHAD8jftfGEklAkycuTsBUUctYoA==
X-Received: by 2002:a05:6a20:5491:b0:251:9f29:453e with SMTP id adf61e73a8af0-2926e840fc8mr12024483637.39.1758416043683;
        Sat, 20 Sep 2025 17:54:03 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:9135:55f6:8a14:ad5c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551380444asm6544282a12.27.2025.09.20.17.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 17:54:03 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-ext4@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] nsfs: validate file handle type and data in nsfs_fh_to_dentry()
Date: Sun, 21 Sep 2025 06:23:56 +0530
Message-ID: <20250921005357.786637-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Add comprehensive validation of file handle type and data in
nsfs_fh_to_dentry() to prevent processing of handles with incorrect
types or malformed data. This fixes a warning triggered when
open_by_handle_at() is called with invalid handle data on nsfs files.

The issue occurs when a user provides a file handle with an incorrect
handle type or valid FILEID_NSFS type but malformed data structure.
Although the export subsystem routes the call to nsfs, the function
needs to validate that both the handle type and data are appropriate
for nsfs files.

The reproducer sends fh_type=0xf1 (FILEID_NSFS) but with a data
structure from FILEID_INO32_GEN_PARENT, resulting in invalid ns_type
values that trigger warnings in the namespace lookup code.

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..7f3c8e8c97e2 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -461,8 +461,17 @@ static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 					int fh_len, int fh_type)
 {
+	if (fh_type != FILEID_NSFS)
+		return ERR_PTR(-EINVAL);
+	if (fh_len < sizeof(struct nsfs_file_handle) / sizeof(u32))
+		return ERR_PTR(-EINVAL);
 	struct path path __free(path_put) = {};
 	struct nsfs_file_handle *fid = (struct nsfs_file_handle *)fh;
+	if (fid->ns_type != CLONE_NEWNS && fid->ns_type != CLONE_NEWCGROUP &&
+	    fid->ns_type != CLONE_NEWUTS && fid->ns_type != CLONE_NEWIPC &&
+	    fid->ns_type != CLONE_NEWUSER && fid->ns_type != CLONE_NEWPID &&
+	    fid->ns_type != CLONE_NEWNET)
+		return ERR_PTR(-EINVAL);
 	struct user_namespace *owning_ns = NULL;
 	struct ns_common *ns;
 	int ret;
-- 
2.43.0


