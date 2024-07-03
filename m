Return-Path: <linux-ext4+bounces-3096-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58AA924C97
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2024 02:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E1283416
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2024 00:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B34F645;
	Wed,  3 Jul 2024 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au6rlGAJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D520621;
	Wed,  3 Jul 2024 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965223; cv=none; b=D/f6lC+S7WHuw8rIiTUWRGNuCA9Z6cxRAd2r4ZMrlZXTBJs+pkquA8mia77Ws/83P3zPUO+WYmJMwXDthLHfzpvYzsT2LS3b+ln7zEPZ3GsTEXFjgVcv1ZYX09jb2tf1HecPwybtVzHcSCrm9LyFy4XLXcdMC02QxBUrmCn6nLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965223; c=relaxed/simple;
	bh=KOjkQB3I1BkmOGdUI7hd+tydhVz2TLsy35U2esSLVOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DzRbyv/+iv+9+GMbnGDfASMnT7qwB5vI6D2arbI5w0022MStFzE8NZSnoWciIJU3fHbj4ldQSM2an/GPTo3xaqueqhF+TDr2+7f0JWmmEgaMstvJLZnT5WJwlC+nj74+mTvOXgKrCgfFtQdhrsGzRmD7M4wWXJuxh0HQMv7hUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au6rlGAJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e03a8955ae3so400553276.1;
        Tue, 02 Jul 2024 17:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719965221; x=1720570021; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZvRNv/JZDDTRdI18aBXSlRlEYxDmftdVdHUvCCc4C4=;
        b=Au6rlGAJQDXOY0zMuhMvhWU/ZLzgBMfOnfailO8ydHSWGiiGX3e52rAoa1kzmKlmu4
         UY5nHPyZhLNaRnKaaZw6yXuLSuCZQEe51j4Yyvs97s1MQzXOyAxEoH+ECkyX0A1YBHwH
         s8snUuFVE6PsrW6umxRQe24M+PIqELnyf6OGLetQxYtzm5Nhl1PipmXxgVFedzz7fnvV
         eM/WvbrkxJFQP6673lNxiWvsMBL+VO/0hF5RSszshmh0Led4h9+WWkxKt0MKut8yXOB7
         XiLISOmGX+mEmr6G5TXlJmp/KoWc0XmYeXMzbbpCiNJ0KcVxN3MdnLJPAY6kzxlf5M4y
         UFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719965221; x=1720570021;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZvRNv/JZDDTRdI18aBXSlRlEYxDmftdVdHUvCCc4C4=;
        b=DC6Spkn1IzYr1/6HqO2JfmUFDlIxURDaRmA+YQdKMM7zUdb0GM0kVozYSvFQq+b3Un
         hx4kXfUVzjjsv5TNwTjOOtwjSn9DXkKS8Voi/2T26W+cL4Ac7jhDxRf0bLo5iX1X3qws
         Tnsy8gpC6IJEXwI7KF3y+Bnzv8/FvBUAEntl5sp+0DfJPBVBD37Vav1APGBx4M7h/OP8
         X/2EI15DJHFjCvqd67y4tRA5p/sFzEWGzTW9fJIvqzTFDazWFhVyv1a0ZxP50nH2Gknk
         XtwH9O30vZI5Fa9aeFsWNbBCGENJFmW31PZ74sI1R5Yx+9g8gSN8O5BRZAEKLlXcnn87
         5Pzg==
X-Forwarded-Encrypted: i=1; AJvYcCWZfCHkNuJ7AORBQA6Wukr8yEoy4WOC/B0GYcXUgQA4CJeUhC9pgDGmWEfteBUtdyUHj1h/wbGl3ClJFr5UpedFWGV2N0xK4vp3OrSV
X-Gm-Message-State: AOJu0Ywhz7+7ywyaqOnwevc8M4gUh+eKhjTLvnbfWzryv2pnTr1kDPit
	dcjwRUo2FbWo0FxUQ6oboVgVtade42QGdUk4ZLK0WxB8euD/cJUp
X-Google-Smtp-Source: AGHT+IFvnDviwYP2MMWVIyiZGWuWfw8Pha6PWftZA89tPNoEvhz68eBNpCbXiLVaSfSolspbTBiLpw==
X-Received: by 2002:a81:a50a:0:b0:643:fd49:2db6 with SMTP id 00721157ae682-64c7123b008mr112444957b3.1.1719965221531;
        Tue, 02 Jul 2024 17:07:01 -0700 (PDT)
Received: from [127.0.1.1] (107-197-105-120.lightspeed.sntcca.sbcglobal.net. [107.197.105.120])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9a23bae7sm19621077b3.42.2024.07.02.17.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 17:07:01 -0700 (PDT)
From: Pei Li <peili.dev@gmail.com>
Date: Tue, 02 Jul 2024 17:07:00 -0700
Subject: [PATCH v2] Fix WARNING in __ext4_ioctl
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-bug8-v2-1-be675f490db1@gmail.com>
X-B4-Tracking: v=1; b=H4sIACOWhGYC/13MQQ7CIBCF4as0sxYDAwpx5T1MF4hAJ7HFgBJNw
 93FLl3+Ly/fCsVn8gVOwwrZVyqUlh64G8BNdome0a03IEfFj2jY9RUN00FzbhGNUxb69ZF9oPf
 GXMbeE5Vnyp9NreK3/gFVMMGU0D4cpHNWynOcLd33Ls0wtta+AGDL1ZgAAAA=
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com, 
 Pei Li <peili.dev@gmail.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719965220; l=1799;
 i=peili.dev@gmail.com; s=20240625; h=from:subject:message-id;
 bh=KOjkQB3I1BkmOGdUI7hd+tydhVz2TLsy35U2esSLVOw=;
 b=PCjjmgpOOOYcDd86Cde/YaT+V68Ga0Vs4zKgw6YZC7RbX1jiHDk/V1rwonT4uNkeJ0EkvlnOv
 nTJOcIdwcM9AGEL1bQy6u3HPgDrwEjXy+pIFdcQGnFEu5wxQ39Dv93o
X-Developer-Key: i=peili.dev@gmail.com; a=ed25519;
 pk=I6GWb2uGzELGH5iqJTSK9VwaErhEZ2z2abryRD6a+4Q=

Specify the size of s_volume_name in strscpy_pad() to avoid buffer
overflow.

strscpy_pad() by default takes the size of destination string as the
size to be read from source string. However, as s_volume_name is only
declared as an array of size EXT4_LABEL_MAX, we are reading 1 byte more
than expected.

Reported-by: syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2cab87506a0e7885f4b9
Fixes: 744a56389f73 ("ext4: replace deprecated strncpy with alternatives")
Signed-off-by: Pei Li <peili.dev@gmail.com>
---
strscpy_pad() by default takes the size of destination string as the
size to be read from source string. However, as s_volume_name is only
declared as an array of size EXT4_LABEL_MAX, we are reading 1 byte more
than expected.

Specify the size of s_volume_name in strscpy_pad() to avoid buffer
overflow.
---
Changes in v2:
- Add fixes label
- Move workaround into commit log
- Link to v1: https://lore.kernel.org/r/20240628-bug8-v1-1-417ef53cca33@gmail.com
---
 fs/ext4/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index dab7acd49709..0c4fb579757a 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1151,7 +1151,7 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
 	BUILD_BUG_ON(EXT4_LABEL_MAX >= FSLABEL_MAX);
 
 	lock_buffer(sbi->s_sbh);
-	strscpy_pad(label, sbi->s_es->s_volume_name);
+	strscpy_pad(label, sbi->s_es->s_volume_name, EXT4_LABEL_MAX);
 	unlock_buffer(sbi->s_sbh);
 
 	if (copy_to_user(user_label, label, sizeof(label)))

---
base-commit: 55027e689933ba2e64f3d245fb1ff185b3e7fc81
change-id: 20240628-bug8-7f700a228c4a

Best regards,
-- 
Pei Li <peili.dev@gmail.com>


