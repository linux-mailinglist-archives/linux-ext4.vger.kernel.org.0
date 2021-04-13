Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA30C35DFCB
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Apr 2021 15:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhDMNMG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Apr 2021 09:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhDMNMG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Apr 2021 09:12:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD855C061574;
        Tue, 13 Apr 2021 06:11:44 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l14so16384104ljb.1;
        Tue, 13 Apr 2021 06:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=QdLdl7ZYVcXzeYaosVMxtDawv9mtCEbRVs/6OC9JF9o=;
        b=CT0d7ft2eGC496UOqY7CPcm/vmeacczS8kxYMJupYLVqzF5Luq7SXqOCLpEuTKmOxN
         5Fk1G14n4rLcTt3un6okLXTUpQD3o8eBq613SLQ7heYQmcrYsg4NuKfNTPEcCnBQeO78
         spsQ/GSiAZFtO5OwxUoJGdWzSres2mZMMSgyblCWt4g2JOStBk80hQ6rHXeJpp8h7mEV
         BnzO8dFbzxclTyaMKr7jxP5K92E+SZcAyoU0FceBXtGx1IP6yp0Jr1DvRjMY5czhBiFX
         /47pNOfhYRjaHoSz5ykS3t2MUr2RJrBvqHVXz6hp4fPwBoYBfGtUUMg0uCX6a5UWP1Kw
         bdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=QdLdl7ZYVcXzeYaosVMxtDawv9mtCEbRVs/6OC9JF9o=;
        b=Wvsp+SOTdwmToC3bm8SdpWgY8xRBB0b96TDFg4jyGc+x8SfR8VvQquQcVGIM6vkmz4
         vpe78z3dLeOM776HXDMIV9aVmNJ3ZDKxcNz3D0AqitlZ5vGUPd/TL7snsur7jB0fLnmb
         af0alny6Y2f6Sphde+23yEFVKJGnzc8J4bsGU6n3qCW368uQtwljVQJ2CiZ1GacXsBjc
         JUUn3hOa6HpiG+QjlHa905MDSSsaiCrTSxJkgHRAr8RAp7eqmTMZOm2LDlGJQjy5H+QJ
         K/FJGegSPEi6e9W2lAc9B2YnUBci18iOq4lR6Y25Bi8augZWnugG1FliHobWsUbZi8LO
         5GPg==
X-Gm-Message-State: AOAM532d8u66ZDcJO94t5qCfeSGNtBGlX6LQ4JBMxU86nSOxq6fdjRWr
        8rb7gCHcMTvvX2o8KncfiVvYljhi5+8lAg==
X-Google-Smtp-Source: ABdhPJzzEAnNBu3PaFSv/V5rMsWkYmo2d4Mf6z3k/+v/uK+a8Iym35+wofwnC1KxXTZNa8IEUmZo1Q==
X-Received: by 2002:a2e:b555:: with SMTP id a21mr21162925ljn.69.1618319503380;
        Tue, 13 Apr 2021 06:11:43 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.90])
        by smtp.gmail.com with ESMTPSA id k2sm3344307lfg.107.2021.04.13.06.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:11:42 -0700 (PDT)
Message-ID: <d37a412f244eaa0f1352b394fdf933ce75d9968c.camel@gmail.com>
Subject: memory leak in ext4_multi_mount_protect
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Date:   Tue, 13 Apr 2021 16:11:41 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

I've done debugging on this issue
https://syzkaller.appspot.com/bug?id=420258a304e5d92cfef6b0097f87b42506e1db08
and I want to ask you about 
proper way of fixing it. The problem was in case sbi->s_mmp_tsk hasn’t
started at the time of kthread_stop() call. In that case allocated data
won't be freed.

I wrote fix patch, but I am confused about it, because I didn't find
any kernel code like this. I don't think, that adding new members to
struct super_block is good idea, that's why I came to that decision: 

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9693680463a..9c33e97bd5c5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5156,8 +5156,10 @@ static int ext4_fill_super(struct super_block
*sb, void *data, int silent)
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


I look forward to hearing your perspective on this patch :)

With regards,
Pavel Skripkin


