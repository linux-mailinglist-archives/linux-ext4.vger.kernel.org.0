Return-Path: <linux-ext4+bounces-2243-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F78B847B
	for <lists+linux-ext4@lfdr.de>; Wed,  1 May 2024 05:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6016B21CE0
	for <lists+linux-ext4@lfdr.de>; Wed,  1 May 2024 03:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136E2288D1;
	Wed,  1 May 2024 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G64SH0uI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AAE33E1;
	Wed,  1 May 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714534237; cv=none; b=rsQ7hpATaRFJhErt+YHIPYeh+CMoCcTKuN9cnnqtkmENOBMOMp7pgXlTOQx79LUyC3oDRxoo1s1uL5iBRbhQuTUl/cfs38uFrJtiXOwLY/sOFWHWCI8Vq6MhrtG7ou7UVR1sXAkSTEFzL4rvwzXGd1o4vSSZlqkAD6xIB8PLmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714534237; c=relaxed/simple;
	bh=AZqaVP/fdYNnoHVh1oLlS6RKKM4t9T3kTnc5J4IcKew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oTE8HVaMq8KsZXnem4W65y4Rissvt7ICMWGIm8OErPohrKltrkjkb+aVijya8dRdHX6qhyoEuMHY+Rzr+x9BDD8loHEaxG3TYj4owGtIBQjGZ+qPjsyjmX8YxqTE05R6ajwtBTXAiomQxe9xk+/G+9MqGUkJ8MtETgBO8TlVBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G64SH0uI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e5715a9ebdso53762265ad.2;
        Tue, 30 Apr 2024 20:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714534236; x=1715139036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnow3STX8Y3K2+gpJbQ63eiMRqnaCAyfXcxevymo0kI=;
        b=G64SH0uIKiV20sdpXLO4M8C5fxoWxGdE5ukjZwWg4Elk7pyFeQw9YhQnkfEGJeK94I
         UeL3G7oqCggriw139Oswzqxe7uL0mNt7IuKMdgniEBgrNJsIp1mHP7GwglU/D+0YDHdl
         5j1mxNInW/lEK+M6eR7lMRZPFoIZivI7kYoNJSsF4Ag31VrOJOru/3tYV3CO0ULwTw/P
         PNq+ojTgjjYMgZ7EiDCoyV5emA2bgZhaiPkClnVmRpT67iFqBnKXElh3K/Z3zdUbl66V
         Q33nIA6pBHTtnnkxTb/VMHPgBS2rqb8pjSlUimOhn8p4qwWycUu5JvYsgqIlEd3pQca9
         KY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714534236; x=1715139036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnow3STX8Y3K2+gpJbQ63eiMRqnaCAyfXcxevymo0kI=;
        b=Qd1OOw+RAuQ67U60GwgI17e/FAdNbnWH7TF0HNsilFb8LrgkCDDGC7Q035I4D8SbRp
         EYTPuKK6Va1DW1ce+N5cqeR9+WnFbRjtpst+hP5wzzamLkmQURPEsyEwJKPTuKAUzttd
         mJS99DMdBTcUXYW856kZq3fw0jzysAa4MF5eWo9XJhz3M7zwYACvyz527QBTmbRbNRFf
         zDyt0dDjQ6QfsL6HXYmtBoZIuQnVrS9VJEDIXdWhT9voqrvhRcvtGnxWGolDbriux15w
         etuTSMdUTMMSRkw3v4W9WhqAqbEvJTUqDWyrnCqZvVIzcLDaX/Xct4n/WoqB4ekgZ79Z
         2HaA==
X-Forwarded-Encrypted: i=1; AJvYcCXmnXWnxtxzC4tPWQggxCSoyd6rUAyOxUZu9q5F8zv4BvZh3jTUcjQE23oZemaONSkixfh+3+GueGgTsV+bGK3zsCOQIP1Z0YrZQlRcCjCznibUzwAU0PZrDKRGFYBb0pkA96hiflYG5w==
X-Gm-Message-State: AOJu0Yy2JnVaHzJg5uMVAbMoHPwMBSlQyjhIX2549On6/KhIkzKP7GW0
	q1kflZfdP4aKuiS9gtcTx8R7YJ00qrvoFpUyjZDMMcyHzXN3bmXS
X-Google-Smtp-Source: AGHT+IGmsz0mxq6stMt2cHIdgUOeSily243GuNQkps2dg0aG2dFHskBNu99WV9mPi5Wi9ol95aiaJQ==
X-Received: by 2002:a17:902:7008:b0:1ec:3c71:eae7 with SMTP id y8-20020a170902700800b001ec3c71eae7mr1154783plk.47.1714534235453;
        Tue, 30 Apr 2024 20:30:35 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.gigstreem.net ([66.160.179.28])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902a70c00b001e45c0d6be6sm23237906plq.246.2024.04.30.20.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 20:30:34 -0700 (PDT)
From: Xiaxi Shen <shenxiaxi26@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shenxiaxi26@gmail.com,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	syzkaller-bugs@googlegroups.com,
	syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com
Subject: [PATCH] Fix uninitialized variable in ext4_inlinedir_to_tree
Date: Tue, 30 Apr 2024 20:30:17 -0700
Message-Id: <20240501033017.220000-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has found an uninit-value bug in ext4_inlinedir_to_tree

This error happens because ext4_inlinedir_to_tree does not
handle the case when ext4fs_dirhash returns an error

This can be avoided by checking the return value of ext4fs_dirhash 
and propagating the error,
similar to how it's done with ext4_htree_store_dirent

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
Reported-and-tested-by: syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eaba5abe296837a640c0
---
 fs/ext4/inline.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index d5bd1e3a5d36..e7a09a99837b 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1410,7 +1410,11 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 			hinfo->hash = EXT4_DIRENT_HASH(de);
 			hinfo->minor_hash = EXT4_DIRENT_MINOR_HASH(de);
 		} else {
-			ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+			err = ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+			if (err) {
+				ret = err;
+				goto out;
+			}
 		}
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
-- 
2.34.1


