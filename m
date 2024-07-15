Return-Path: <linux-ext4+bounces-3258-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D10930D38
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 06:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D60B20D10
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 04:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A761FFC;
	Mon, 15 Jul 2024 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDokbObt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679F1843;
	Mon, 15 Jul 2024 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721018042; cv=none; b=MJJo+U+DpHon+ljOisJeuWK+xNC5H8Tu3Y1HyK9FIwTMgk45wNQbd+Jj0nUXGxu3efcyx4auCtRxTED9WQiRiUmUVJ4Jnj+qYPcsZZ+Y4CpuWvHwhsDkzMsDcTKmX/RkRotsGQsbnfUAP80zP9Z0BCnTLeeoIonrLECtIqEHBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721018042; c=relaxed/simple;
	bh=3Wvcfe8oEdKfcyDZbopKoLa6dmTuK7X0SJZkvLu6YzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7Ubs7ZnmTZdgg3poiEiPXrKnhDrV+YaUQeaaJaEJh1kjJLDwFWtjWrygAezdB8byJBfIIXW8w6YY13RsnGqSDlC/Ly4Dt/tOe02Y66iCzIVqGte3ITFEr5JlWB2ZAumsmh6haztuzEA0McqS3bh0Dj5gEIoYzz5RNqgmfHrESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDokbObt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c983d8bdc7so3141244a91.0;
        Sun, 14 Jul 2024 21:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721018041; x=1721622841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4SCJwaKwCtR2CiDRItTCkrmfcVb4Wc6JiIR88R7Gqk=;
        b=IDokbObt2afl1Kbmedl5gPtDxasqxoJtZe/N7KnbJx6gY+/4gWdRPUqxLBguTQVxZE
         bLBOYsyXJz9uCTP3VF48pThbbtoRQ0/1FZUhhqbGU/scQNvLU8u240yXGqSXV0p3WBOK
         Rh0+aC/gfhb7op0xaTMpDZ+k9pnI/ALOnmPgrU1cD0XsKJneEbj+GI7fie5QWcaYxrN9
         j41da00zkShTWqM0ERhqfcCbcu6Zyxpyt+JrO/VNTJU0e+VMZyIG5WXBA5phkj2gpCSF
         F1NLNsgMemX6Hp4R+RJRuF9iVx4MtyLS+9pSTp/yLIILYfJfYngw0fBRh356KTcR/BGm
         7sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721018041; x=1721622841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4SCJwaKwCtR2CiDRItTCkrmfcVb4Wc6JiIR88R7Gqk=;
        b=ng82tJDTOhjjBDOzaefLV7oqUdsvr13zmEgeOpYJO73lUkhYibV4u3jhiPw36fTZG8
         Hb9LKzz0cwDE1wnRUCnM4MHfL6B7EXZUl4Cmt81gvozygH+T7IIvuvwAt1yacahe8Ets
         hDqBypWJ6hF7WxzCi3Fn+tcPGIGjyMbT9GGOJ4ujfZbVDzUu5qsV2IuAv+t+Mv/UXvWy
         3VAI0QQ3v3/2peZPCFLsD9CnlhPCzNbgrCiLr6kzKjDeZO4CUvFed8aDGoVovwg/j5IV
         uy1lF91/3r9QyzlbcJeZl8v01nqmZ+Y7pljz7x6LTFJaS1eFFEv6OOHZUVnGZX8sR6jW
         lFqA==
X-Forwarded-Encrypted: i=1; AJvYcCX48reshOBAmgn1igYTpSC5uDsdDEZ/UWQxB94fQi+X+jjM8Ye0hIPvRulRttyOH85CXoc5ZZ7aydFoaBvhCtkC3l6ZHZG9tQGUzoN3hdSzjZyCKHkk5bHA8ePuRlh85K+eNuGVlWReSg==
X-Gm-Message-State: AOJu0Yw3GHO0qjD7WD/h6Fr5sBqc02I+ciiKDwbMZGia2nzgPVHLDNd/
	+K/FfpSehR4uIwTTbXDm/ghes8TC34k7rnXX0uCkXQpRzpsA+VdH
X-Google-Smtp-Source: AGHT+IFTVrPHAW2F6fx28LMhuf1pFShWPTA6HQBjHb3NaDPwyjtxNWxNbfX71qwLaOqYBHRjkmP0Cg==
X-Received: by 2002:a17:903:184:b0:1fb:43d2:2c9e with SMTP id d9443c01a7336-1fbb6d42003mr161349985ad.17.1721018040398;
        Sun, 14 Jul 2024 21:34:00 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.. ([50.175.126.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6fedesm30904555ad.15.2024.07.14.21.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 21:33:59 -0700 (PDT)
From: Xiaxi Shen <shenxiaxi26@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	syzkaller-bugs@googlegroups.com,
	shenxiaxi26@gmail.com,
	syzbot+59e0101c430934bc9a36@syzkaller.appspotmail.com
Subject: [PATCH] ext4: Fix timer use-after-free on failed mount
Date: Sun, 14 Jul 2024 21:33:36 -0700
Message-Id: <20240715043336.98097-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has found an ODEBUG bug in ext4_fill_super

The del_timer_sync function cancels the s_err_report timer,
which reminds about filesystem errors daily. We should
guarantee the timer is no longer active before kfree(sbi).

When filesystem mounting fails, the flow goes to failed_mount3,
where an error occurs when ext4_stop_mmpd is called, causing
a read I/O failure. This triggers the ext4_handle_error function
that ultimately re-arms the timer,
leaving the s_err_report timer active before kfree(sbi) is called.

Fix the issue by canceling the s_err_report timer after calling ext4_stop_mmpd.

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
Reported-and-tested-by: syzbot+59e0101c430934bc9a36@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=59e0101c430934bc9a36
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c682fb927b64..1b4b0d3d8889 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5626,8 +5626,8 @@ failed_mount8: __maybe_unused
 failed_mount3:
 	/* flush s_sb_upd_work before sbi destroy */
 	flush_work(&sbi->s_sb_upd_work);
-	del_timer_sync(&sbi->s_err_report);
 	ext4_stop_mmpd(sbi);
+	del_timer_sync(&sbi->s_err_report);
 	ext4_group_desc_free(sbi);
 failed_mount:
 	if (sbi->s_chksum_driver)
-- 
2.34.1


