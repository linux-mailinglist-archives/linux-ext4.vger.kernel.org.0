Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A49B330A
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 03:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfIPBlB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 21:41:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45015 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfIPBlA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 21:41:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id i18so6427036wru.11;
        Sun, 15 Sep 2019 18:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s5NlWgemAgRgAck5V/LT2mO8N9Ly1ozLQCAwpxW+qmQ=;
        b=Io9gq4kxX3/9yiKAj3stqnJrMuXjc0/Fv/uNXEN8rQ8qWJh9vjpX5WJOdkFb+OzVX3
         kukd031wdu0fXYqw+lPw75A0y3wvKNkXQtBPoYy2BFDFoHyoGCRdVdqyyAeHY0SyhCzP
         jln4+j1+1DfUoJ807AMeDIwy5ZTgSUXw9MDDk/C/fTE2NZtRhXK+nVRzbSMWBbl/1UBD
         R8KS0ljobpqH447i45NN60s/2d2XQfjJFWQ6+zLuZ10bfjDNBSlz7KR+NPiCFVKItNSt
         LHWL8WJZZyfQHG6PT93H3UFRbwuGOAnEHIoM2A194wEq8+Jeo5YAj3mDaV/g/x74dpLR
         LJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s5NlWgemAgRgAck5V/LT2mO8N9Ly1ozLQCAwpxW+qmQ=;
        b=fHy198bGx4SukQr2u9arnflxOKUAYO3d7zBFmz+QW0cOO4pA1SaF+c3TcY2hROnGkR
         nvCGR+U0fWQMZ9U3+cEMcMZiMju0bmXC2yC+y+yfjZwXIm+UWDOYKVF8/40FeN9TZy6z
         jjOzxgUE5qk1kiY9E1FqNHYjmoKkLgLeHgr6p/p0JKcn26bAUsozAkzdEKIX1QTEQLfF
         HgfEI63yWx9ATibCJ903VKLNpsB0Gz2QvkWqd2KZ2FX1pt16oNkeXTT4eNrZTmdbw7jQ
         WnEmVL82CCYNhAEIwNJiDZgo1Zr1Mi8emnNuBGNUUS/34Qp4hJXluTDSGl2m4SeKEDbb
         Wvxw==
X-Gm-Message-State: APjAAAW2qkttallZF5XNHLN0+bzyLX+19ePx/YxGeZ2lPvlJ0vCtOKpE
        GUwP5TVidkAM4E7miHSR2h0=
X-Google-Smtp-Source: APXvYqz6sCS29EwAmavddzyT7utN1acTq4CZlykL/oWxxNi/CQgskS/fJUcG222M03uXlt1coc57pg==
X-Received: by 2002:a05:6000:10f:: with SMTP id o15mr9530373wrx.92.1568598057996;
        Sun, 15 Sep 2019 18:40:57 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D144910CD9D07D5336EC2.dip0.t-ipconnect.de. [2003:d0:6f2d:1449:10cd:9d07:d533:6ec2])
        by smtp.gmail.com with ESMTPSA id b144sm11061016wmb.3.2019.09.15.18.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 18:40:57 -0700 (PDT)
Date:   Mon, 16 Sep 2019 03:40:50 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916014050.GA7002@darwi-home-pc>
References: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login>
 <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 09:29:55AM -0700, Linus Torvalds wrote:
> On Sat, Sep 14, 2019 at 11:51 PM Lennart Poettering
> <mzxreary@0pointer.de> wrote:
> >
> > Oh man. Just spend 5min to understand the situation, before claiming
> > this was garbage or that was garbage. The code above does not block
> > boot.
> 
> Yes it does. You clearly didn't read the thread.
> 
> > It blocks startup of services that explicit order themselves
> > after the code above. There's only a few services that should do that,
> > and the main system boots up just fine without waiting for this.
> 
> That's a nice theory, but it doesn't actually match reality.
> 
> There are clearly broken setups that use this for things that it
> really shouldn't be used for. Asking for true randomness at boot
> before there is any indication that randomness exists, and then just
> blocking with no further action that could actually _generate_ said
> randomness.
> 
> If your description was true that the system would come up and be
> usable while the blocked thread is waiting for that to happen, things
> would be fine.
>

A small note here, especially after I've just read the commit log of
72dbcf721566 ('Revert ext4: "make __ext4_get_inode_loc plug"'), which
unfairly blames systemd there.

Yes, the systemd-random-seed(8) process blocks, but this is an
isolated process, and it's only there as a synchronization point and
to load/restore random seeds from disk across reboots.

The wisdom of having a sysnchronization service ("before/after urandom
CRNG is inited") can be debated. That service though, and systemd in
general, did _not_ block the overall system boot.

What blocked the system boot was GDM/gnome-session implicitly calling
getrandom() for the Xorg MIT cookie. This was shown in the strace log
below:

   https://lkml.kernel.org/r/20190910173243.GA3992@darwi-home-pc

thanks,

-- 
darwi
http://darwish.chasingpointers.com
