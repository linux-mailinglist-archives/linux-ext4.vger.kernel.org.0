Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B60BFADD
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2019 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfIZVMD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Sep 2019 17:12:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37065 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfIZVMD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Sep 2019 17:12:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so4011156wmc.2;
        Thu, 26 Sep 2019 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FI1xrP5jjBsQPaMVmci1V+BqiWwo6aK8tEQUUDKJq3s=;
        b=AbFfvazGXAD0zLF3y6MQ+8btH+FUTb+dZuhxQtKDxqx3mkfuG65NeUr1xRvbqmcuLq
         6LfIYygjn4F2QFxnjc5nhYV0lkjExxvDNgnAfOILhCrT1w+kjwOaAvFFtIErhLvagaTq
         m+WXGwXtHTv1IcmqgX4KzmJBWiiItqLoE5zpmSjhb5JDfp5wY48C8btfTQmHv10fK1sZ
         yPFI2gEWkVRyWgFxN5236PXiZlyibuJHUj1U0UQsXnXY6fV5/EP/WHYeNoI6Vri/QI4c
         KR7Yi1ZGpMVvU9M3Z9t4mOFgtIfaLEdjmVCLbkkQgGpKcwy2hfZQqaT9Y1sitRcnGphd
         a6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FI1xrP5jjBsQPaMVmci1V+BqiWwo6aK8tEQUUDKJq3s=;
        b=AT2CyH4uO3MrY9MEXXYGKjWhYO3l0JzKv+GKqYNVM6m3OBJAcoUZEzG69ZiLCC5XWo
         vLiUfHTZymNymT/UVsZZ28jOJTFF8CouhANzod8ckUflUV65TbWB5TLhGJ4g16lxlKfQ
         XW7ASwU3ol1OrsK2niMjkdMwWC+a+4B5zIKBxKUWAg0QyeTdqoK1rw2A/QTH9A3WVrVu
         ah4Sde6znN5TYyF3qf/IewT19BXHR2dseiqDQ4tM+4KU+629TeapLXUdaa9383LJaLwb
         uYsthzkNfYO5NeKkaaBU1J+j/n9Yndq/IJT9E+nPLIm55u0ZLR1m9dZ8s/+KvisH0q8W
         P40Q==
X-Gm-Message-State: APjAAAXTnPaI9B15Dq4bcJEJBqUXYxa7BdF7GmRhk4f++AtlahOxQ4OH
        xn32KM5MJjcr/rVvfnvcMYQ=
X-Google-Smtp-Source: APXvYqxGVxier8ZJkkzbhZRUj2Md+Fotcwwj2JqZVqJYIFwEMitoJ12K0uooWAW12Ewj20nujf4mgQ==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr2178427wml.86.1569532319027;
        Thu, 26 Sep 2019 14:11:59 -0700 (PDT)
Received: from darwi-home-pc ([5.158.153.52])
        by smtp.gmail.com with ESMTPSA id g185sm8031301wme.10.2019.09.26.14.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 14:11:58 -0700 (PDT)
Date:   Thu, 26 Sep 2019 23:11:50 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190926211150.GA1085@darwi-home-pc>
References: <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc>
 <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
 <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
 <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
 <87blvefai7.fsf@oldenburg2.str.redhat.com>
 <CALCETrWM9opVj+BBrHnnTakTLunW_fB9RM+VSNpNSkR9drDjMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWM9opVj+BBrHnnTakTLunW_fB9RM+VSNpNSkR9drDjMw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 23, 2019 at 11:33:21AM -0700, Andy Lutomirski wrote:
> On Fri, Sep 20, 2019 at 11:07 PM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > * Linus Torvalds:
> >
> > > Violently agreed. And that's kind of what the GRND_EXPLICIT is really
> > > aiming for.
> > >
> > > However, it's worth noting that nobody should ever use GRND_EXPLICIT
> > > directly. That's just the name for the bit. The actual users would use
> > > GRND_INSECURE or GRND_SECURE.
> >
> > Should we switch glibc's getentropy to GRND_EXPLICIT?  Or something
> > else?
> >
> > I don't think we want to print a kernel warning for this function.
> >
> 
> Contemplating this question, I think the answer is that we should just
> not introduce GRND_EXPLICIT or anything like it.  glibc is going to
> have to do *something*, and getentropy() is unlikely to just go away.
> The explicitly documented semantics are that it blocks if the RNG
> isn't seeded.
> 
> Similarly, FreeBSD has getrandom():
> 
> https://www.freebsd.org/cgi/man.cgi?query=getrandom&sektion=2&manpath=freebsd-release-ports
> 
> and if we make getrandom(..., 0) warn, then we have a situation where
> the *correct* (if regrettable) way to use the function on FreeBSD
> causes a warning on Linux.
> 
> Let's just add GRND_INSECURE, make the blocking mode work better, and,
> if we're feeling a bit more adventurous, add GRND_SECURE_BLOCKING as a
> better replacement for 0, ...

This is what's now done in the just-submitted V5, except the "make the
blocking mode work better" part:

    https://lkml.kernel.org/r/20190926204217.GA1366@pc

It's a very conservative patch so far IMHO (minus the loud warning).

Thanks,
--
Ahmed Darwish
