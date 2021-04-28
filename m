Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE9F36DE4A
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Apr 2021 19:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbhD1R31 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Apr 2021 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbhD1R30 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Apr 2021 13:29:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFBBC061573;
        Wed, 28 Apr 2021 10:28:41 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u25so34837726ljg.7;
        Wed, 28 Apr 2021 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XiDkDGEE4btr09JaX3wGmRBxeV6dNzC/hyl0FxehK8=;
        b=GZpmsCncjuprG6+asstSsX5oepVjz0xOWymnDCshF00N2Rw+nfY7cBxb+FvB9BJYfC
         qLg+aT6NgphyS7FPAVkomnO8r3tsQw/cEBtBRigNgQh6tPBEdAPlkRCAJWUDGSVm2dFT
         I4kgQSE1hD84pX/vSvoaEKkXChXxtaOl3D3I+r22AI2eoHxqvUAj/ej43NBolSLR3JoT
         NUr5ZUWkrGF+7IzWmFFjbb0ouDY0D3+cEmOENGDnVBFJ5LZcRb+fSPL34baHZCy+M0VJ
         auDF9Buu8HDPqM0MLh9xenjA0LxkliaGfkSivJS/J+kaY91zWv00+Rmm/SEF2BtDEKdD
         T2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XiDkDGEE4btr09JaX3wGmRBxeV6dNzC/hyl0FxehK8=;
        b=tamR+SnwWIytnh9+Aia8+AxDyR7exILwDb7+VdLyQo2YGFIbaW6jCRoNj0Us3C4JMR
         Aaz0oqm7VlTZgkCdq2X4mBsbgeaM/ormi96aIvqFKtPy4u5c/roSlj+traUHv7bC7Oon
         wblHmvo5mmVGX56ZpQB4fcKiiyLI2UesiWRtRGuTiy+JWurbHmb5FYetKbSaeCVR54NZ
         rTaKDvoJM/gJransp0vxl/DAVPgor4lR53LHe/gda7x890bxm2HJ7aYotr8tGoMTi8Vz
         IA2z7I9mcZ57S8aNEjESlAQVFPOnQWlho2ctK862LYWRnzkEAgqE9mWrjTL3QYYce7Lz
         Zsag==
X-Gm-Message-State: AOAM533uvB2Zs0BBCrrC1ELQxIOtjCuZEu0kSInHccaXpImfbTXkPUHa
        LWTpb2rdzuiPfFbEk/X+m40=
X-Google-Smtp-Source: ABdhPJwHjkl+4vki37PhnFjR3qt2TUXGaKWKn/Wg0boY1wzE5b2i+2ZmEvZax2nb4xAhe3YoIjG3qQ==
X-Received: by 2002:a05:651c:513:: with SMTP id o19mr21519090ljp.291.1619630919562;
        Wed, 28 Apr 2021 10:28:39 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.147])
        by smtp.gmail.com with ESMTPSA id z145sm108539lfc.169.2021.04.28.10.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:28:38 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix memory leak in ext4_fill_super
Date:   Wed, 28 Apr 2021 20:28:28 +0300
Message-Id: <20210428172828.12589-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot reported memory leak in ext4 subsyetem.
The problem appears, when thread_stop() call happens
before wake_up_process().

Normally, this data will be freed by
created thread, but if kthread_stop()
returned -EINTR, this data should be freed manually

Reported-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Tested-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 fs/ext4/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9693680463a..9c33e97bd5c5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5156,8 +5156,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 failed_mount3:
 	flush_work(&sbi->s_error_work);
 	del_timer_sync(&sbi->s_err_report);
-	if (sbi->s_mmp_tsk)
-		kthread_stop(sbi->s_mmp_tsk);
+	if (sbi->s_mmp_tsk) {
+		if (kthread_stop(sbi->s_mmp_tsk) == -EINTR)
+			kfree(kthread_data(sbi->s_mmp_tsk));
+	}
 failed_mount2:
 	rcu_read_lock();
 	group_desc = rcu_dereference(sbi->s_group_desc);
-- 
2.31.1

