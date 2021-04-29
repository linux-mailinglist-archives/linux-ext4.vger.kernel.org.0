Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8836F072
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhD2TYv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 15:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbhD2TVU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Apr 2021 15:21:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C479C06138B;
        Thu, 29 Apr 2021 12:20:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p12so875132ljg.1;
        Thu, 29 Apr 2021 12:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8d4Y+3fQnVXcrWsarbuVfuo1sLNCCMSP2te5/Kx4NI=;
        b=XpqcPXbEJI5DMvLw09LOKf2n2k+1/27+46TZ0HM6lgNhYHw3HCncidDOTfUMSEO8Jd
         9mAbUO/9zQYxYLyWBRfYRXVpOf81MWQT3yI4jBdv0sFJ6qg47ZaZ+3ht88QwBPdvIutX
         Gw+Wq1pYEixuCvWZXrqCNwwrfRcvitcD+6MoFc7M9nE7jEO00E+BSik8lyktPs3+qZfS
         H+xxGc6r/Rmb9g+nPv3rUN0gcRH2kA82n0ridnM+vJioh/2GJxF7aYs4ws0Hb2WVrb+z
         ZPpc/hw384UvKEvFju3yIVpITbnHiC2UCGStnXYiicsOKb9y2r2E6FUC0vK0AuLAf7HH
         yFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8d4Y+3fQnVXcrWsarbuVfuo1sLNCCMSP2te5/Kx4NI=;
        b=cnjbhh23xLSUKzVj/VMf5XRD+vEKzOoVaoqIjT/dzrhBHB1G6dJvFYRXBm3mKk0ebs
         h10W+EfFcahGQT5csLRKnSH1idp/g0yvYI/qu3gH1ZzgAaAH4ovBEVNmFHdumhnTUuny
         xUimPLn54QatIEje7/0znGVNGthibvZx6tegxJozP0y+fbMycpILdo2MuNDHtSiIkZVK
         r1+s7LktRalgyxWo8tLxrWGzpd877Ic8WS5lDtQRONDPwMs9XCaRXFda2u6lcOmojK3h
         ShsYzzuFzpIOCZt0l5qkgzGz+WC7cD4SUoFO2cpg7izcR3WO1V4vSUI4jJEOrQ7hEZKv
         7fnA==
X-Gm-Message-State: AOAM533Y6906uncizR/CQ/SQvgMn5xx+Sr371MaqshyHlk0tgKPMVNUr
        6285OCqn3JC91H5EgasjRls=
X-Google-Smtp-Source: ABdhPJzNMSO4Jy694qhCMtqQC5FrV35QXxVEEzdV87vmhE/8zAlZOiz0gL/Zl82BUIQ7YvQ9s+urHw==
X-Received: by 2002:a2e:808d:: with SMTP id i13mr921622ljg.366.1619724031505;
        Thu, 29 Apr 2021 12:20:31 -0700 (PDT)
Received: from localhost.localdomain ([94.103.226.84])
        by smtp.gmail.com with ESMTPSA id i12sm43798lfb.256.2021.04.29.12.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 12:20:31 -0700 (PDT)
Date:   Thu, 29 Apr 2021 22:20:23 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        akpm@linux-foundation.org, peterz@infradead.org, axboe@kernel.dk,
        pmladek@suse.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix memory leak in ext4_fill_super
Message-ID: <20210429222023.43db6fb1@gmail.com>
In-Reply-To: <YIrnPXJo/n68NrQs@mit.edu>
References: <20210428172828.12589-1-paskripkin@gmail.com>
        <3c3877a4-fef2-9e24-f99f-2ecc46deb7e4@oracle.com>
        <20210429143354.418248a7@gmail.com>
        <YIrnPXJo/n68NrQs@mit.edu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi! Thanks for your reply.

On Thu, 29 Apr 2021 13:05:01 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:
> On Thu, Apr 29, 2021 at 02:33:54PM +0300, Pavel Skripkin wrote:
> > 
> > There is a chance, that kthread_stop() call will happen before
> > threadfn call. It means, that kthread_stop() return value must be
> > checked everywhere, isn't it? Otherwise, there are a lot of
> > potential memory leaks, because some developers rely on the fact,
> > that data allocated for the thread will be freed _inside_ thread
> > function.
> 
> That's not the only potential way that we could leak memory.  Earlier
> in kthread(), if this memory allocation fails,
> 
> 	self = kzalloc(sizeof(*self), GFP_KERNEL);
> 
> we will exit with -ENOMEM.  So at the very least all callers of
> kthread_stop() also need to check for -ENOMEM as well as -EINTR ---
> or, be somehow sure that the thread function was successfully called
> and started.  In this particular case, the ext4 mount code had just
> started the kmmpd thread, and then detected that something else had
> gone wrong, and failed the mount before the kmmpd thread ever had a
> chance to run.
> 
> I think if we want to fix this more generally across the whole kernel,
> we would need to have a variant of kthread_run which supplies two
> functions --- one which is the thread function, and the other which is
> a cleanup function.  The cleanup function could just be kfree, but
> there will be other cases where the cleanup function will need to do
> other work before freeing the data structure (e.g., brelse((struct
> mmpd_data *)data->bh)).

I skimmed through kernel code and I didn't find any code
examples, except ext4, where kthread is freeing something. Maybe, this
API isn't required, but, as Vegard said, comment over
kthread_stop() should be changed, because it's confusing.

I have already added kthread.c developers (I hope, I chose
the right emails) to CC. Maybe, they will think about this API. 

> 
> Is it worth it to provide such a cleanup function, which if present
> would be called any time the thread exits or is killed?  I dunno.
> It's probably simpler to just strongly recommend that the cleanup work
> should never be done in the thread function, but after kthread_stop()
> is called, whether it returns an error or not.  That's probably the
> right fix for ext4, I think.
> 
> (Although note that kthread_stop(sbi->s_mmp_task) is called in
> multiple places in fs/ext4/super.c, not just in the single location
> which this patch touches.)
> 

Good point, I'll add this and -ENOMEM checks and will send v2.

Thanks!

> 						- Ted



With regards,
Pavel Skripkin
