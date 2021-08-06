Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98D93E2463
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 09:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhHFHpw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Aug 2021 03:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhHFHpw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Aug 2021 03:45:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891AC061798;
        Fri,  6 Aug 2021 00:45:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p38so16328005lfa.0;
        Fri, 06 Aug 2021 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language;
        bh=OWQLdupjTEh4OlyCZ+bQemzpvexRaSTViOt6rJ5MT8k=;
        b=SmL159THnj1qYHJdqCa0BQCY9pnPRBeO4lPKiYuE6Ogx41aR6VaZ3SOHeSRDDDET6b
         QI/vmJPnExW5+Z66Y0485vhx8D4pUhWzcpEfjwJYMmpg04tuUXC+AgS2frUAf/gJBOnq
         pDgZrEyT9P8r1jj4Z2ZXZPFS/8rMPhO6nZ5mJvBjBJxiWImrxrYO3GMXXZlbihtbACTO
         Q6ilpp1wCqa1VxByPPsfijWajQhqGpl4PdTxVjRX9vGGsdQn7USGB4iG289cMT4lHR0/
         3sstlCgK1Wc+8A9Ehg7rRNk9P8iPIid9TjaxcjN+u2LT413GrMNuVjuQjGf38Pc1z7E7
         tW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=OWQLdupjTEh4OlyCZ+bQemzpvexRaSTViOt6rJ5MT8k=;
        b=rfJwVaXxJtoZj4GlCv2O0P9GS5APWSbnTf5SW8AJkRdAu/wbeV4EWRaf2aObZh0h2r
         1G9CUylOr1RkXFzzUR/SU18aspgMYzO8BbWwZDNqq/AeXYPa3qtPmQEDEwwUFmVqGcLJ
         evEZmC/zooKP9MrCdmXXYKIAUPa+FiQ2PlZvILZGEncGATeS/oiEVW+DLDzINNMCgfF5
         rzAMdCS2HuLKSWjKt3WfQyBcXDtpTlefLhtQi6pGjtY119qRUHlfMQ++9qF7j4GEFpOZ
         DNbpumqCAKQbHAeq9gsbwIbQxbJkX8nFCHakQTLRSSMlVjJvb2MPaej/qFTwVg8n3EJR
         yV0g==
X-Gm-Message-State: AOAM532BpV08ly02cQc5jiAMlz8HDWFnDF2pHFASFqUJj3pf4lyxooSv
        +/Bs/HoisIyr2csHIyYmq9E=
X-Google-Smtp-Source: ABdhPJxDofi8yLWllCG+mcqf/KQ3XjFdw1OyL1Dis76BEOfkuHm0ON+aA8nhaW039P+n4LeYqCHo0g==
X-Received: by 2002:ac2:5978:: with SMTP id h24mr6833758lfp.354.1628235934010;
        Fri, 06 Aug 2021 00:45:34 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.226.235])
        by smtp.gmail.com with ESMTPSA id b14sm624419lji.91.2021.08.06.00.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 00:45:33 -0700 (PDT)
Subject: Re: [syzbot] INFO: task hung in ext4_fill_super
To:     syzbot <syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
References: <000000000000b6692805c8d0fae6@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <daae3696-aed8-a0b6-9470-d76ab4901b7d@gmail.com>
Date:   Fri, 6 Aug 2021 10:45:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <000000000000b6692805c8d0fae6@google.com>
Content-Type: multipart/mixed;
 boundary="------------79CCD88B29A58180385B73E4"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------79CCD88B29A58180385B73E4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/21 5:46 PM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         251a1524 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=166c8f6532dd88df
> dashboard link: https://syzkaller.appspot.com/bug?extid=c9ff4822a62eee994ea3
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=160a3301300000
> 
> Note: testing is done by a robot and is best-effort only.
> 

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


With regards,
Pavel Skripkin

--------------79CCD88B29A58180385B73E4
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ext4-fix-kthread_should_stop-while-TASK_RUNNING.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ext4-fix-kthread_should_stop-while-TASK_RUNNING.patch"

From f31fdca900d687994a880dfd675d0a46da1eaec9 Mon Sep 17 00:00:00 2001
From: Pavel Skripkin <paskripkin@gmail.com>
Date: Fri, 6 Aug 2021 10:40:31 +0300
Subject: [PATCH] ext4: fix kthread_should_stop() while TASK_RUNNING

/* ... */

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 fs/ext4/mmp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index bc364c119af6..fd1985b79a8d 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -183,9 +183,15 @@ static int kmmpd(void *data)
 		}
 
 		diff = jiffies - last_update_time;
-		if (diff < mmp_update_interval * HZ)
-			schedule_timeout_interruptible(mmp_update_interval *
-						       HZ - diff);
+		if (diff < mmp_update_interval * HZ) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (kthread_should_stop()) {
+				__set_current_state(TASK_RUNNING);
+				break;
+			}
+
+			schedule_timeout(mmp_update_interval * HZ - diff);
+		}
 
 		/*
 		 * We need to make sure that more than mmp_check_interval
-- 
2.32.0


--------------79CCD88B29A58180385B73E4--
