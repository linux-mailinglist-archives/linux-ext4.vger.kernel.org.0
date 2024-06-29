Return-Path: <linux-ext4+bounces-3031-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DAA91CADF
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Jun 2024 05:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8817B1C211AC
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Jun 2024 03:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DACA1D6AA;
	Sat, 29 Jun 2024 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5vGZfjw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87478A945;
	Sat, 29 Jun 2024 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719631887; cv=none; b=PgrIScQaGUMh2c7wiTWpPdUJ2yCggfu5by/dQUvufPjh/FrT3Y0iaohs/X3leWoUcnCMRZ8ro3h18tAS7BepemJUA5jdxPHbaORpglkgE2jYXs9dAarmLUX4A0ISaQULsA7c/XfpFIS39anXCHPwUGFTtXWUS4GNX68LR7NFNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719631887; c=relaxed/simple;
	bh=UMbUn3CgsoktVzkBOL+mHpKeupOeuLEClQKjfRD/RVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YUh1f1HCinyvL2XrqFIUcGc/SOORBxS/zPt5u5Q6xHBlnMBUL26LISqtBQTztmlUFtqPCUsUAXSHv5eWz6aQRmCCR/wtJp+IpbTiBg0zILRiP7hPknY5NiNUa/7+GUBV5dhkLaekXL94KXUNkLmQ8BDayRf0MDRyZPNlq+bY2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5vGZfjw; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-24c9f6338a4so591500fac.1;
        Fri, 28 Jun 2024 20:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719631885; x=1720236685; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSl9MMzmnJSlDuFOdf3HeBK75wkl+RK1RWvEFXp2fhI=;
        b=m5vGZfjwrnrjrzkWIADQ8Uq8LfsBlRcetNijK4ZrciYEXXJTnkPRGWuY3PS4EyhcYZ
         otjb3Lq2fwFYeUsZ1BMxpJwBmDMhM94DfLM2/FOwbNHAkAKqvm9502zZtNFg1kaPbFbo
         t5r1XooB8HpjdVQ/nzGhlAcLrXoFiPf2JMeuy3W6ooSm3dE4GNWKhRnwbuiVGsrY2fNg
         S3KmlvpriboZwmFFwRFNUfzIXaBgBNe+49yiJgKEsirWj/qIfF1VrTXLNSjOR78NUgbB
         mnef0BKx2qThuV9mualjcTJpwX0fyjId7pNx6ybCHGdY414h5RsRD2fYIZ4aeKNQUWhr
         8lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719631885; x=1720236685;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSl9MMzmnJSlDuFOdf3HeBK75wkl+RK1RWvEFXp2fhI=;
        b=SEiK6y+u65gaPNp/nzWKu2hORVQPlgJySMZNQL5Ss4rHllu+Kf6KmDbvHnndwJDYCe
         p/ltxDIEG2c38rxNH+VgtJ7s/E5Sa+hMzGLJV/XbE33uV9czE3NkGAenlIGv8wfia1cJ
         3OqqMjucZVudhJA5LhlpggKBHVFVx5hqUWp0PMnA1SHXqxNof/yyRyDMnXRNUPT/EhRP
         4N8hJR5uxfIsGGGuVYLYMHo4kSz2jrOkgSY1KKSwVl+q+u9oMa56RlS7XkKT2idUkNqk
         YqDDBMxyHICIw8JwLD9CBoISxW8xVCP802BfE9UVOMgLCWCG0l9It910nSp/hEGlSUEO
         WWhA==
X-Forwarded-Encrypted: i=1; AJvYcCWAZbqTwSC63rmScNhYZFn2lUEJtyDO5wLhD9NRj7fV/lkSAqfnhZrEhBIEcqB1bZ1UQ+9hWffLyLFrTLOcafwtAlmFJSW/FH94ZDtC
X-Gm-Message-State: AOJu0YyFXXcAnxftbbwvTBzc1imArT8lpXupRcbrTX7/6RRadRymKb/5
	GnwCQsvIrhaivbZ2yOTMIiygEgTLQwkqFgfJAd+6upyhGNEPmc8Q
X-Google-Smtp-Source: AGHT+IGWOucm3yANDUxSUMd+Sqwxzia3bJCdr5UpKwsT9yw8LfxMGazEPdAT+FPDio4CDnhliR47BA==
X-Received: by 2002:a05:6870:e9aa:b0:254:a2c2:d3c3 with SMTP id 586e51a60fabf-25db340df60mr35138fac.2.1719631885592;
        Fri, 28 Jun 2024 20:31:25 -0700 (PDT)
Received: from [127.0.1.1] (107-197-105-120.lightspeed.sntcca.sbcglobal.net. [107.197.105.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b397b7sm539594a34.68.2024.06.28.20.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 20:31:25 -0700 (PDT)
From: Pei Li <peili.dev@gmail.com>
Date: Fri, 28 Jun 2024 20:31:22 -0700
Subject: [PATCH] Fix WARNING in __ext4_ioctl
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-bug8-v1-1-417ef53cca33@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAmAf2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyML3aTSdAtd8zRzA4NEIyOLZJNEJaDSgqLUtMwKsDHRsbW1AMPc8nx
 WAAAA
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com, 
 Pei Li <peili.dev@gmail.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719631884; l=1333;
 i=peili.dev@gmail.com; s=20240625; h=from:subject:message-id;
 bh=UMbUn3CgsoktVzkBOL+mHpKeupOeuLEClQKjfRD/RVo=;
 b=mek6p9iKGykiUOqRtZH7wiiHEclyE1V/+I/m0KTKQaC6EZocWYSaK0oWt3Z2kN5Ilf1L3JCNN
 60WZ9Ny256PAqNlMP0GuYamNeNQCnNL3me4L548CY510ClW366+MJNB
X-Developer-Key: i=peili.dev@gmail.com; a=ed25519;
 pk=I6GWb2uGzELGH5iqJTSK9VwaErhEZ2z2abryRD6a+4Q=

Specify the size of s_volume_name in strscpy_pad() to avoid buffer
overflow.

Reported-by: syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2cab87506a0e7885f4b9
Signed-off-by: Pei Li <peili.dev@gmail.com>
---
strscpy_pad() by default takes the size of destination string as the
size to be read from source string. However, as s_volume_name is only
declared as an array of size EXT4_LABEL_MAX, we are reading 1 byte more
than expected.

Specify the size of s_volume_name in strscpy_pad() to avoid buffer
overflow.
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


