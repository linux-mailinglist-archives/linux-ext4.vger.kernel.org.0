Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B8BB2D1D
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2019 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfINVLi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 17:11:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43514 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfINVLh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 17:11:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id q17so30512217wrx.10;
        Sat, 14 Sep 2019 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LlOdOy3KWJQjxCTVMfOJ3x8EX8EsEr3SCTQpuq4qJzg=;
        b=TNcBXYAiK8SQp8X281WxYJXrhrd835Ub5tRKqX8LO4STVnw2hSExbTgcyyPNsbubCx
         7MK8a4qIA5cTLZ45VcJH53zqbQMtUeMLfBP9I/o2PWed5KUhStlAz9a1aBcYpU2mxPyp
         cMFCTuWj8rbWZ9KW9mihXdiHgMrusSZKETjBnAbr9t6p9BVcK+kaMgaW/u/BrGcMwTF0
         WLA6gRhOuutTNC/ui9RYjT69n56k3jcXVvRXLvFd/g9nBFWB34XUxMdV2DizGVJQt+he
         taXWPSjMKxGEJ8WcBhujmkYK3XJ9GOWcCYXSXDRsxWXadqesyojeplctg2G9rxD+WJdp
         cRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LlOdOy3KWJQjxCTVMfOJ3x8EX8EsEr3SCTQpuq4qJzg=;
        b=ozPk+jv5OPefz8SEfe6l9iRiVBfXphBrO6i0Pkvs43X+FBTm+kQRlOTmsldg12KfAG
         rgJE0wFlJ0XcHss/6oieRPrM79wKKxoU1FmhPd+rJeoTzu7R1JbZ6kZrxHicierzgufX
         GfY7f0Pl9JK1eh8/VCN+ckK/3MnoyKmxHyS8LqKN8mLaRI5xioRMJQz4cm039dFC1yqf
         +rT+j+CrtjK83X5OBOKhczTfQmwuSJezLBhGM05l7Kd4VtgPKoq5MQx/C+21HBwcSIfb
         ZKSLoH+P0Awk1huWJtGlDKNQyIJ1Dl5yvaOjEa0fiAXpuG2vHafjWNtPLj+w1PbQkCr5
         RgJQ==
X-Gm-Message-State: APjAAAUu3I9r5a6tCmdUvcximMoisGmBIk/NZqi6ZgQAqt8DfzVa+15c
        PpDdZ7r1NxfXMSVhQTRXDDI=
X-Google-Smtp-Source: APXvYqxtXKumRSjSnxsEyDa+c9BMeql5KCk0JiFcU5AJ9nRfQCXT3ns3uaM2BJouTcP0bkHsuF6lAA==
X-Received: by 2002:a05:6000:10f:: with SMTP id o15mr6046218wrx.92.1568495493586;
        Sat, 14 Sep 2019 14:11:33 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D1401AF0812D8DEE03BEC.dip0.t-ipconnect.de. [2003:d0:6f2d:1401:af08:12d8:dee0:3bec])
        by smtp.gmail.com with ESMTPSA id b144sm7007661wmb.3.2019.09.14.14.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 14:11:32 -0700 (PDT)
Date:   Sat, 14 Sep 2019 23:11:26 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190914211126.GA4355@darwi-home-pc>
References: <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On Sat, Sep 14, 2019 at 09:30:19AM -0700, Linus Torvalds wrote:
> On Sat, Sep 14, 2019 at 8:02 AM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> >
> > On Thu, Sep 12, 2019 at 12:34:45PM +0100, Linus Torvalds wrote:
> > >
> > > An alternative might be to make getrandom() just return an error
> > > instead of waiting. Sure, fill the buffer with "as random as we can"
> > > stuff, but then return -EINVAL because you called us too early.
> >
> > ACK, that's probably _the_ most sensible approach. Only caveat is
> > the slight change in user-space API semantics though...
> >
> > For example, this breaks the just released systemd-random-seed(8)
> > as it _explicitly_ requests blocking behvior from getrandom() here:
> >
> 
> Actually, I would argue that the "don't ever block, instead fill
> buffer and return error instead" fixes this broken case.
> 
> >     => src/random-seed/random-seed.c:
> >     /*
> >      * Let's make this whole job asynchronous, i.e. let's make
> >      * ourselves a barrier for proper initialization of the
> >      * random pool.
> >      */
> >      k = getrandom(buf, buf_size, GRND_NONBLOCK);
> >      if (k < 0 && errno == EAGAIN && synchronous) {
> >          log_notice("Kernel entropy pool is not initialized yet, "
> >                     "waiting until it is.");
> >
> >          k = getrandom(buf, buf_size, 0); /* retry synchronously */
> >      }
> 
> Yeah, the above is yet another example of completely broken garbage.
> 
> You can't just wait and block at boot. That is simply 100%
> unacceptable, and always has been, exactly because that may
> potentially mean waiting forever since you didn't do anything that
> actually is likely to add any entropy.
>

ACK, the systemd commit which introduced that code also does:

   => 26ded5570994 (random-seed: rework systemd-random-seed.service..)
    [...]
    --- a/units/systemd-random-seed.service.in
    +++ b/units/systemd-random-seed.service.in
    @@ -22,4 +22,9 @@ Type=oneshot
    RemainAfterExit=yes
    ExecStart=@rootlibexecdir@/systemd-random-seed load
    ExecStop=@rootlibexecdir@/systemd-random-seed save
   -TimeoutSec=30s
   +
   +# This service waits until the kernel's entropy pool is
   +# initialized, and may be used as ordering barrier for service
   +# that require an initialized entropy pool. Since initialization
   +# can take a while on entropy-starved systems, let's increase the
   +# time-out substantially here.
   +TimeoutSec=10min

This 10min wait thing is really broken... it's basically "forever".

> >      if (k < 0) {
> >          log_debug_errno(errno, "Failed to read random data with "
> >                          "getrandom(), falling back to "
> >                          "/dev/urandom: %m");
> 
> At least it gets a log message.
> 
> So I think the right thing to do is to just make getrandom() return
> -EINVAL, and refuse to block.
> 
> As mentioned, this has already historically been a huge issue on
> embedded devices, and with disks turnign not just to NVMe but to
> actual polling nvdimm/xpoint/flash, the amount of true "entropy"
> randomness we can give at boot is very questionable.
>

ACK.

Moreover, and as a result of all that, distributions are now officially
*duct-taping* the problem:

    https://www.debian.org/releases/buster/amd64/release-notes/ch-information.en.html#entropy-starvation

    5.1.4. Daemons fail to start or system appears to hang during boot
  
    Due to systemd needing entropy during boot and the kernel treating
    such calls as blocking when available entropy is low, the system
    may hang for minutes to hours until the randomness subsystem is
    sufficiently initialized (random: crng init done).

"the system may hang for minuts to hours"...

> We can (and will) continue to do a best-effort thing (including very
> much using rdread and friends), but the whole "wait for entropy"
> simply *must* stop.
> 
> > I've sent an RFC patch at [1].
> >
> > [1] https://lkml.kernel.org/r/20190914122500.GA1425@darwi-home-pc
> 
> Looks reasonable to me. Except I'd just make it simpler and make it a
> big WARN_ON_ONCE(), which is a lot harder to miss than pr_notice().
> Make it clear that it is a *bug* if user space thinks it should wait
> at boot time.
> 
> Also, we might even want to just fill the buffer and return 0 at that
> point, to make sure that even more broken user space doesn't then try
> to sleep manually and turn it into a "I'll wait myself" loop.
>

ACK, I'll send an RFC v2, returning buflen, and so on..

/me will enjoy the popcorn from all the to-be-reported WARN_ON()s
on distribution mailing lists ;-)

>                  Linus

thanks,

-- 
darwi
http://darwish.chasingpointers.com
