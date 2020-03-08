Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD54817D5A1
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Mar 2020 19:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgCHSoJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Mar 2020 14:44:09 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:32938 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgCHSoJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Mar 2020 14:44:09 -0400
Received: by mail-yw1-f66.google.com with SMTP id j186so7951497ywe.0;
        Sun, 08 Mar 2020 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKIjJU0Jcr/i2OtFnZ1TFH4hXFzpfr4RFpHDB2WtKvI=;
        b=nreiNSILwtuTWEJ2tdIYX6tvM05njLVG5fdM7asr8qgPsBtWKFmz3etkv30JS57Ym8
         EGhdRTeplo805LwXh3Dyr+DpxgRvP26US4Oruqv9yyk4byc0aRO6DAhmfU5Sj65SwM89
         R62oGDxLmFiDnKeGbjglD1HmSi3ldrftGCWmJojlSgdyN3yIsqEIqpAoGZNl0ZnbGYWe
         d7fTSO1M7yebuIuBkYLkwPS3J4gRmDIyj9VpUD+jGcKhLYNNzAa/Hd9xbbYp2miBktRz
         i+FFcrW5bZB0SJ0QRDXu7GjaskRk50tdeNIAZRiCa52+s/WeizsdcVP0qKturz1uXMmp
         un+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKIjJU0Jcr/i2OtFnZ1TFH4hXFzpfr4RFpHDB2WtKvI=;
        b=Hn0ZTdTxj3ZlYjMz7EEj7G8VbidLIy2OjhRsZQoQpLCqkJCUJdxLf5Ov0uv0jpVEuE
         b5wxpGCRuhLoTR5Wvup6azPn/quLEH08si0SdNcSbxVmu0L+/kPZqdXSSgLFgbtgG+pO
         kg3S49vI0NYOmkHFU6A70IqajmT7PW0rwbVGzDcGpFPy+b3bYAMKIHA+tczMEB6jvQ+T
         NYmPkz1D0s5knK4zI+ws3eKT1F+uYl3DQ3MCYo1YLByQXW//aIrdQNSRR+iTIolezoJ8
         aMl/VLeRj4RKw2uCTRu1dK7bctp4nQHnWtM+uZdiqiwpjzldY4LccBQc9XIIRwOpxPtw
         je0g==
X-Gm-Message-State: ANhLgQ1LDNZIVB/FP4u2Kh85xor3E9tTtR1c6qJsD5SdSq711Q6lNLwN
        z6gHN5q2Dpy9N5jBcPy8O4Q/OFfUMj9QYpRBDmI=
X-Google-Smtp-Source: ADFU+vtnfprRZoQimB2PWgBavUyh5kNGPoDaD0HE2dib7g11l1ZtJkyTIe+otEES+a3vraiF3W/X916cPo4xE93Ye+I=
X-Received: by 2002:a0d:e297:: with SMTP id l145mr14471732ywe.132.1583693046841;
 Sun, 08 Mar 2020 11:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200308043645.1034870-1-ebiggers@kernel.org> <20200308061611.1185481-1-ebiggers@kernel.org>
In-Reply-To: <20200308061611.1185481-1-ebiggers@kernel.org>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 8 Mar 2020 13:43:56 -0500
Message-ID: <CAH2r5mtRvs1NkWyvMvO1Pg2OPa9xq=gMUvHLgbA73bsj44DxVQ@mail.gmail.com>
Subject: Re: [PATCH v2] cifs: clear PF_MEMALLOC before exiting demultiplex thread
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

merged into cifs-2.6.git for-next

running buildbot cifs/smb3 automated regression tests now

On Sun, Mar 8, 2020 at 12:17 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Leaving PF_MEMALLOC set when exiting a kthread causes it to remain set
> during do_exit().  That can confuse things.  For example, if BSD process
> accounting is enabled, then it's possible for do_exit() to end up
> calling ext4_write_inode().  That triggers the
> WARN_ON_ONCE(current->flags & PF_MEMALLOC) there, as it assumes
> (appropriately) that inodes aren't written when allocating memory.
>
> This case was reported by syzbot at
> https://lkml.kernel.org/r/0000000000000e7156059f751d7b@google.com.
>
> Fix this in cifs_demultiplex_thread() by using the helper functions to
> save and restore PF_MEMALLOC.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>
> v2: added missing include of <linux/sched/mm.h>
>     (I missed that I didn't actually have CONFIG_CIFS set...)
>
>  fs/cifs/connect.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 4804d1df8c1c..97b8eb585cf9 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -21,6 +21,7 @@
>  #include <linux/fs.h>
>  #include <linux/net.h>
>  #include <linux/string.h>
> +#include <linux/sched/mm.h>
>  #include <linux/sched/signal.h>
>  #include <linux/list.h>
>  #include <linux/wait.h>
> @@ -1164,8 +1165,9 @@ cifs_demultiplex_thread(void *p)
>         struct task_struct *task_to_wake = NULL;
>         struct mid_q_entry *mids[MAX_COMPOUND];
>         char *bufs[MAX_COMPOUND];
> +       unsigned int noreclaim_flag;
>
> -       current->flags |= PF_MEMALLOC;
> +       noreclaim_flag = memalloc_noreclaim_save();
>         cifs_dbg(FYI, "Demultiplex PID: %d\n", task_pid_nr(current));
>
>         length = atomic_inc_return(&tcpSesAllocCount);
> @@ -1320,6 +1322,7 @@ cifs_demultiplex_thread(void *p)
>                 set_current_state(TASK_RUNNING);
>         }
>
> +       memalloc_noreclaim_restore(noreclaim_flag);
>         module_put_and_exit(0);
>  }
>
> --
> 2.25.1
>


-- 
Thanks,

Steve
