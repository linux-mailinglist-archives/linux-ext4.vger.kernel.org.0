Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA53E16ED
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Aug 2021 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbhHEO0n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Aug 2021 10:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbhHEO0m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Aug 2021 10:26:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEAAC061799;
        Thu,  5 Aug 2021 07:26:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h11so7306545ljo.12;
        Thu, 05 Aug 2021 07:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language;
        bh=RKcFjiwMXc5BYKQz1bcpOMX6jWXaoe4r5Jt/CAUiijU=;
        b=JlQOWwRbyY7su5Ui0QQNVKy3zC9OgxhpIZmxcIhPI365ifSWs3bMVmxb+98MlAJ6BV
         17MQ4xAZE4ols7VmKvmKWoFNd+dRmZStuxLkAnUNNnK/p4/At15efHh9ite0f2SFQnx7
         J2COdnjHixWd1CgJ3EOZp+DFir55+2oXenPyvVK8B5BcM+cDWDJVcGcD2TBgoBxSj562
         uuiBCafM2Q3+QyZ2g6MO7ffRfZhsvQpOvbsrlXOi+KK0VA+4vSKLkBylUx55f0iWBoVN
         HYIlO0PNOa5JO5VB/aFU1LHMUietWuCDm+v04P0kcV2vTgz6tDnP7vdub0I8qwZC2ag8
         1T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=RKcFjiwMXc5BYKQz1bcpOMX6jWXaoe4r5Jt/CAUiijU=;
        b=b9HcH6CuJw34ZdSlwaRBAOHqYf45Af9fGif2AEaRbfGTj4XyXHnC383MbW4M8zRTkV
         cL9ynXIN40b4DPX1Vy2dMYf2m4SlxEWSgidCm1aETTUZkY8pCgbjmQDd6rq4IT763HLU
         EQx144zgX3ocO2917smztvM4cAbzAdY0hoBeOS13Sy91kgnZ7nFWT/xuPtbrvqn2Kn63
         9/5k+Z6dVjiI8FKP0PYbHEqE55boEmucxgAFdP+fhjWtj7qeIFCZbTDXrizxNEp++neh
         pwUVSnTUig6T7KnSxDgiClo7m34xmc41v/xTi1yyUAd0EV5j71q+vOHEn8Hrbb3jGw3m
         sa0w==
X-Gm-Message-State: AOAM531E6lqGOTviZCwpdCPqTk92E4QMinzNI5p3WVn8RGx0zGo2cpqY
        Lzg7fXJw7bo/xXZ2EWS6xus=
X-Google-Smtp-Source: ABdhPJy46+EtlzN2UP4L5z4EkCSCn+2mOqcPDZzhyGfwHI1K/D+5ksiR8GQoGx/lLadx7CsM4oF+bQ==
X-Received: by 2002:a2e:7c19:: with SMTP id x25mr3464048ljc.169.1628173585723;
        Thu, 05 Aug 2021 07:26:25 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.226.235])
        by smtp.gmail.com with ESMTPSA id q7sm531780lfm.27.2021.08.05.07.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 07:26:24 -0700 (PDT)
Subject: Re: [syzbot] INFO: task hung in ext4_fill_super
To:     syzbot <syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
References: <0000000000004c80e405c4df1a2d@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <1e291320-3ad3-aa21-77c6-c71da9d32fdb@gmail.com>
Date:   Thu, 5 Aug 2021 17:26:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0000000000004c80e405c4df1a2d@google.com>
Content-Type: multipart/mixed;
 boundary="------------675893B3B0BF5C1099A6646E"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------675893B3B0BF5C1099A6646E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/21 12:56 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f21b807c Merge tag 'drm-fixes-2021-06-11' of git://anongit..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=165fca57d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=30f476588412c065
> dashboard link: https://syzkaller.appspot.com/bug?extid=c9ff4822a62eee994ea3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d19ce0300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108d7988300000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1646b8d0300000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1546b8d0300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1146b8d0300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com
> 
> INFO: task syz-executor768:8567 blocked for more than 143 seconds.
>        Not tainted 5.13.0-rc5-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor768 state:D stack:27544 pid: 8567 ppid:  8423 flags:0x00004004
> Call Trace:
>   context_switch kernel/sched/core.c:4339 [inline]
>   __schedule+0x916/0x23e0 kernel/sched/core.c:5147
>   schedule+0xcf/0x270 kernel/sched/core.c:5226
>   schedule_timeout+0x1db/0x250 kernel/time/timer.c:1868
>   do_wait_for_common kernel/sched/completion.c:85 [inline]
>   __wait_for_common kernel/sched/completion.c:106 [inline]
>   wait_for_common kernel/sched/completion.c:117 [inline]
>   wait_for_completion+0x168/0x270 kernel/sched/completion.c:138
>   kthread_stop+0x17a/0x720 kernel/kthread.c:642
>   ext4_fill_super+0x87ac/0xdfa0 fs/ext4/super.c:5190
>   mount_bdev+0x34d/0x410 fs/super.c:1368
>   legacy_get_tree+0x105/0x220 fs/fs_context.c:592
>   vfs_get_tree+0x89/0x2f0 fs/super.c:1498
>   do_new_mount fs/namespace.c:2905 [inline]
>   path_mount+0x132a/0x1fa0 fs/namespace.c:3235
>   do_mount fs/namespace.c:3248 [inline]
>   __do_sys_mount fs/namespace.c:3456 [inline]
>   __se_sys_mount fs/namespace.c:3433 [inline]
>   __x64_sys_mount+0x27f/0x300 fs/namespace.c:3433
>   do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x445b2a
> RSP: 002b:00007ffc5efbf598 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffc5efbf5f0 RCX: 0000000000445b2a
> RDX: 0000000020000000 RSI: 00000000200000c0 RDI: 00007ffc5efbf5b0
> RBP: 00007ffc5efbf5b0 R08: 00007ffc5efbf5f0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00000000200003f8
> R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000005
> 

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


With regards,
Pavel Skripkin

--------------675893B3B0BF5C1099A6646E
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ext4-avoid-huge-mmp-update-interval-value.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ext4-avoid-huge-mmp-update-interval-value.patch"

From 9eb3e2f727e1c33ec39c28694a1528b9cc4a32eb Mon Sep 17 00:00:00 2001
From: Pavel Skripkin <paskripkin@gmail.com>
Date: Thu, 5 Aug 2021 17:23:40 +0300
Subject: [PATCH] ext4: avoid huge mmp update interval value

/* .. */

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 fs/ext4/mmp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index bc364c119af6..2f632344d38c 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -7,6 +7,9 @@
 
 #include "ext4.h"
 
+#define EXT4_KMMP_MAX_INTERVAL		100
+#define EXT4_KMMP_MIN_INTERVAL		5
+
 /* Checksumming functions */
 static __le32 ext4_mmp_csum(struct super_block *sb, struct mmp_struct *mmp)
 {
@@ -140,6 +143,11 @@ static int kmmpd(void *data)
 	unsigned long diff;
 	int retval;
 
+	/* We should avoid unreasonale huge update interval, since it can cause
+	 * task hung bug on umount or on error handling path in ext4_fill_super()
+	 */
+	mmp_update_interval = clamp(mmp_update_interval, EXT4_KMMP_MIN_INTERVAL, EXT4_KMMP_MAX_INTERVAL);
+
 	mmp_block = le64_to_cpu(es->s_mmp_block);
 	mmp = (struct mmp_struct *)(bh->b_data);
 	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
@@ -156,6 +164,9 @@ static int kmmpd(void *data)
 	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
 	       sizeof(mmp->mmp_nodename));
 
+	ext4_msg(sb, KERN_INFO, "Started kmmp thread with update interval = %u\n",
+		 mmp_update_interval);
+
 	while (!kthread_should_stop() && !sb_rdonly(sb)) {
 		if (!ext4_has_feature_mmp(sb)) {
 			ext4_warning(sb, "kmmpd being stopped since MMP feature"
-- 
2.32.0


--------------675893B3B0BF5C1099A6646E--
