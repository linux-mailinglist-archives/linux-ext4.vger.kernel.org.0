Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012CA36E9A5
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 13:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhD2Leq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 07:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhD2Lep (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Apr 2021 07:34:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207FC06138B;
        Thu, 29 Apr 2021 04:33:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j10so11115367lfb.12;
        Thu, 29 Apr 2021 04:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pRbuoEIim8wsF2C8VdzLs/YLM/1AITJTydfJ7MQBhhM=;
        b=ogDtxXWDerzgMms96J516/1092QTu+vbUPMbohoBszxQJ6Ux3wSkwodVyccD7yu/aw
         P9GVfMuEnPJS7WvQ+4AlfPyBLzun3JogjtQ4Kkb44RwQFvjefPHMApucSULbYD7G5tGb
         /e1RTI3o89oLU3BE3OEGE6o2pBts63GFo9Yukk/KUalCaVg5yeoY0D6aZgTybDSVcQBD
         GZJ7yz7KshRQTAhcGE2OUHnIxTBvWEwfngpDNPsPS/ZCy2Hxr/bR5pxn2FEQt98xDs0+
         g668wocdERHPqniLTrSTJv9Ot8ktvQXGTw6SG43TrEAM4HhjBjhWfxjCm97eTXrIaopD
         yG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRbuoEIim8wsF2C8VdzLs/YLM/1AITJTydfJ7MQBhhM=;
        b=Su3SnWLWdfaOPpNbFj5nZW9gdzt9RWiVBngNd3+TMLVOrLa9lr3vJuysnYqVLiZLeu
         cQ46EDcxC1kzctsaCEt6Zs9kY51foxJciLVOziYbzwKVR1OBU4oYEDUjWdEuTiI0180q
         pRZDzsicl1gFN0xAxmSpK1DyGWUamPQn0fVaA1bfkQvT9nGgj4PRrUz9CXKCxY64ZMIh
         iM5lgCwgzzJEB4sfmz7Hdu2h8fX6tdMCUQdvVSQya6FlhImn10OUnNK8PdC8jXFLn6k6
         6NN8w031+PXOaUiqioOGyOw7JBhAqr3ENWms1ar/E8pVxCRTh6kywxeUvZSgQ47l/yO8
         d4+Q==
X-Gm-Message-State: AOAM530JGrzjX7XIX5bdA9kbS9hJTKm7ZQwd2FXArPFhp2REXV4wZ37b
        xIQrLZXRlFN95hAU3mtxnjaLztFJHUFV51+q
X-Google-Smtp-Source: ABdhPJzSiF9h9nx6Q9ZGVGhdfChxe1/b3PVD/6xVTkd2Ui8nLkL41A2/T8ooeXfhhJkeZvUB1rNeUQ==
X-Received: by 2002:a05:6512:3ca9:: with SMTP id h41mr25760102lfv.145.1619696037463;
        Thu, 29 Apr 2021 04:33:57 -0700 (PDT)
Received: from localhost.localdomain ([94.103.226.84])
        by smtp.gmail.com with ESMTPSA id h22sm496950lfu.91.2021.04.29.04.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 04:33:57 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:33:54 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        akpm@linux-foundation.org, peterz@infradead.org, axboe@kernel.dk,
        pmladek@suse.com
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix memory leak in ext4_fill_super
Message-ID: <20210429143354.418248a7@gmail.com>
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
> 
> Vegard

I am sorry for my complitely broken mail client :(

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

There is a chance, that kthread_stop() call will happen before
threadfn call. It means, that kthread_stop() return value must be checked everywhere,
isn't it? Otherwise, there are a lot of potential memory leaks,
because some developers rely on the fact, that data allocated for the thread will
be freed _inside_ thread function.

Vegard wrote the code snippet, which reproduces this behavior:

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

So, is this behavior is expected or not? Should maintainers rewrite
code, which doesn't check kthread_stop() return value?


With regards,
Pavel Skripkin
