Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A11A36E959
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 13:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhD2LJD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 07:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhD2LJD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Apr 2021 07:09:03 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ADAC06138B;
        Thu, 29 Apr 2021 04:08:14 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u25so37630127ljg.7;
        Thu, 29 Apr 2021 04:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yygg84Sqz7tFZ7poeLqPsydlYQ9P2Ikd5S+jATfOK8k=;
        b=kzL6VRRuThAkLZrXOJp03XQzoLfbrqzhOI7k8SNoZpa8Yenh5Bp1ZDCcC6zJLrhaL9
         IGCPMOShrm7Eo01oNiSn5WT38kKGRfiiw0lUHOeKHoXQPUU2Yhxn6p2sp4K1nrwsvTMQ
         E9rXRl5SWqa+u+YTvw5czuo86+IFHfEf0LbtSiFx2CEGAj/M5i0thUp9flRN2nket5mN
         nUmLNUjSq0V+etp2d+TNTWYSmZ1q1ATQ0BTCv0KBFV9KoQiIU/enQ1WSP6nDGNPkYyru
         mJMeIdcCsfQQSx1f98Q0XnwOlzb47nNjsTTpIQQ0+2aQNwlCvGwbNLdRWZX+SDqUyqX+
         ygnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yygg84Sqz7tFZ7poeLqPsydlYQ9P2Ikd5S+jATfOK8k=;
        b=QEyS6+vVE3MYupbruasPkOwJNejgSp+Sjja3yH/RbM/plh+jERQGZeCRrpuRgHFbXR
         qCGVUuB33GDoIhve2GEl5AnUMoI1a9YXOJ04QD/XXZgjgLQp07RukZfZwnJypXEI7gEI
         lTsnSGSuQqagiOjVS7W4FMGNThnlSWkCNj69/G3AhMRJiOuKHKJJmppBaOvyXi00iyax
         nfLzBtnoYWJZDZNRsQHCOT3VOFK4PJL2iXC6nMLeNjrnLVSJD+lt7bDiF0gJjGZOeaZY
         G8Z0ZbLj/HbVOXyyF+v5HWJhaktT4qxKsp98XA22u3u1k07n0EeqBtIu1VgsBcHcIyzx
         FtTQ==
X-Gm-Message-State: AOAM53253KUiGodimGdPJLH/UDbC4xauLBSC8KkE4Ktzy0DvVj8WP1LH
        tv+M8+vtXGx2SoyU8Sx/Pg1WqeWUcoD2ow==
X-Google-Smtp-Source: ABdhPJzjFgLoBsK/gRGo5Vf23f7Sfd+HJimzCoNx6n7Q+H+MHYsMcPAxhbjUjTZHr+/j55NdaOuIgg==
X-Received: by 2002:a2e:a552:: with SMTP id e18mr24074014ljn.383.1619694491955;
        Thu, 29 Apr 2021 04:08:11 -0700 (PDT)
Received: from localhost.localdomain ([94.103.226.84])
        by smtp.gmail.com with ESMTPSA id z22sm496575lfu.200.2021.04.29.04.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 04:08:11 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:08:09 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix memory leak in ext4_fill_super
Message-ID: <20210429140809.5929edd0@gmail.com>
In-Reply-To: <3c3877a4-fef2-9e24-f99f-2ecc46deb7e4@oracle.com>
References: <20210428172828.12589-1-paskripkin@gmail.com>
        <3c3877a4-fef2-9e24-f99f-2ecc46deb7e4@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 29 Apr 2021 12:01:46 +0200
Vegard Nossum <vegard.nossum@oracle.com> wrote:

> 
> On 2021-04-28 19:28, Pavel Skripkin wrote:
> > syzbot reported memory leak in ext4 subsyetem.
> > The problem appears, when thread_stop() call happens
> > before wake_up_process().
> > 
> > Normally, this data will be freed by
> > created thread, but if kthread_stop()
> > returned -EINTR, this data should be freed manually
> > 
> > Reported-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
> > Tested-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > ---
> >   fs/ext4/super.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index b9693680463a..9c33e97bd5c5 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -5156,8 +5156,10 @@ static int ext4_fill_super(struct
> > super_block *sb, void *data, int silent) failed_mount3:
> >   	flush_work(&sbi->s_error_work);
> >   	del_timer_sync(&sbi->s_err_report);
> > -	if (sbi->s_mmp_tsk)
> > -		kthread_stop(sbi->s_mmp_tsk);
> > +	if (sbi->s_mmp_tsk) {
> > +		if (kthread_stop(sbi->s_mmp_tsk) == -EINTR)
> > +			kfree(kthread_data(sbi->s_mmp_tsk));
> > +	}
> >   failed_mount2:
> >   	rcu_read_lock();
> >   	group_desc = rcu_dereference(sbi->s_group_desc);
> > 
> 
> So I've looked at this, and the puzzling thing is that ext4 uses
> kthread_run() which immediately calls wake_up_process() -- according
> to the kerneldoc for kthread_stop(), it shouldn't return -EINTR in
> this case:
> 
>   * Returns the result of threadfn(), or %-EINTR if wake_up_process()
>   * was never called.
>   */
> int kthread_stop(struct task_struct *k)
> 
> So it really looks like kthread_stop() can return -EINTR even when
> wake_up_process() has been called but the thread hasn't had a chance
> to run yet?
> 
> If this is true, then we either have to fix kthread_create() to make
> sure it respects the behaviour that is claimed by the comment OR we
> have to audit every single kthread_stop() in the kernel which does
> not check for -EINTR.
> 

Me and Vegard found the root case of this bug:

static int kthread(void *_create) 
{
	....
	ret = -EINTR;
	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
		cgroup_kthread_ready();
		__kthread_parkme(self);
		ret = threadfn(data);
	}
	
	do_exit(ret);
}

There is a change, that kthread_stop() call will happen before this
. It means, that all kthread_stop() return value must be checked
everywhere

Vegard wrote code snippet, which reproduces this behavior:

#include <linux/printk.h>
#include <linux/proc_fs.h>
#include <linux/kthread.h>

static int test_thread(void *data)
{
        printk(KERN_ERR "test_thread()\n");
        return 0;
}

static int test_show(struct seq_file *seq, void *data)
{
        struct task_struct *t = kthread_run(test_thread, NULL, "test");
        if (!IS_ERR(t)) {
                int ret = kthread_stop(t);
                printk(KERN_ERR "kthread_stop() = %d\n", ret);
        }

        return 0;
}

static void __init init_test(void)
{
        proc_create_single("test", 0444, NULL, &test_show);
}

late_initcall(init_test);


> 
> Vegard



With regards,
Pavel Skripkin
