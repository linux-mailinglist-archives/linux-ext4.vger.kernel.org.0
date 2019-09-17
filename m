Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13068B52DF
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfIQQYE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 12:24:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39496 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfIQQYE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 12:24:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id s19so4171763lji.6
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxsyW6nLofhV8viqZYmUtikq7MzcUQ0DLONnisNNMgg=;
        b=TqK580QEDxVQPMUfHjJ7kx8CJ6swQ66oeXEZhXBI33FU+q9pAhpktcTOSJh9FjQuYB
         g/amoJaPGMr0tVs+0KonicAn6CEpIb0jSqvDt3HwUdn6xXa6sACcDsgEA68nfpRcpykU
         M3sf6qYdD8L0B4HAx6NYPW9aAgS0IclpQKu/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxsyW6nLofhV8viqZYmUtikq7MzcUQ0DLONnisNNMgg=;
        b=L6ixAKplIlMLGuQqZ/Td1oFk+qnOCKEl+bcXoBNfyYJ49bco/5KBPCMh+/4UBMXhJv
         ZchfTDZ7q6Mk2VIeNNrnZpDBgS6rvz3w1hpM9BxOaOWX7hsrHp9O5IZfuiJQR2BtOFrc
         1zo+OWY7HQ9TUnwZ/5pdwG39YtbT+U0BCgIUZGoy15NzA946gs5BX1Wts/vG8SH2MHFe
         5O50Nf6oD3xD/QMLH72HTXRbUFntsdI/rggwaaecdHSi4M09ZjE9KCOY+x3rhw2Bu0pS
         nF6GIAti+sLTeRPpruliiicU90FdG7/Sv/wh0y/4jR6HojImX8S12U1YAky7CcEImPVT
         Gd8g==
X-Gm-Message-State: APjAAAXO84Ii0kI47MM3TdasPFVYLW7oP/rEJw+MHYC49FkRHAA1eCE1
        TPBmlIWbvFaLoerUdrOasa6JpOIq9d0=
X-Google-Smtp-Source: APXvYqzbYCz1FQvGPuI4S3ZmYQ8+raVxV+NygeZJYkaCN/UaabHbKjAHGNFpwkt2Mf3wo8+ychFeQg==
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr2356038lje.90.1568737441082;
        Tue, 17 Sep 2019 09:24:01 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id w30sm507556lfn.82.2019.09.17.09.23.59
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:24:00 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id a22so4223241ljd.0
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 09:23:59 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr2491562ljs.156.1568737439299;
 Tue, 17 Sep 2019 09:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba> <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de> <20190917160844.GC31567@gardel-login>
In-Reply-To: <20190917160844.GC31567@gardel-login>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 09:23:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
Message-ID: <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 9:08 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> Here's what I'd propose:

So I think this is ok, but I have another proposal. Before I post that
one, though, I just wanted to point out:

> 1) Add GRND_INSECURE to get those users of getrandom() who do not need
>    high quality entropy off its use (systemd has uses for this, for
>    seeding hash tables for example), thus reducing the places where
>    things might block.

I really think that trhe logic should be the other way around.

The getrandom() users that don't need high quality entropy are the
ones that don't really think about this, and so _they_ shouldn't be
the ones that have to explicitly state anything. To those users,
"random is random". By definition they don't much care, and quite
possibly they don't even know what "entropy" really means in that
context.

The ones that *do* want high security randomness should be the ones
that know that "random" means different things to different people,
and that randomness is hard.

So the onus should be on them to say that "yes, I'm one of those
people willing to wait".

That's why I'd like to see GRND_SECURE instead. That's kind of what
GRND_RANDOM is right now, but it went overboard and it's not useful
even to the people who do want secure random numners.

Besides, the GRND_RANDOM naming doesn't really help the people who
don't know anyway, so it's just bad in so many ways. We should
probably just get rid of that flag entirely and make it imply
GRND_SECURE without the overdone entropy accounting, but that's a
separate issue.

When we do add GRND_SECURE, we should also add the GRND_INSECURE just
to allow people to mark their use, and to avoid the whole existing
confusion about "0".

> 2) Add a kernel log message if a getrandom(0) client hung for 15s or
>    more, explaining the situation briefly, but not otherwise changing
>    behaviour.

The problem is that when you have some graphical boot, you'll not even
see the kernel messages ;(

I do agree that a message is a good idea regardless, but I don't think
it necessarily solves the problems except for developers.

> 3) Change systemd-random-seed.service to log to console in the same
>    case, blocking boot cleanly and discoverably.

So I think systemd-random-seed might as well just use a new
GRND_SECURE, and then not even have to worry about it.

That said, I think I have a suggestion that everybody can live with -
even if they might not be _happy_ about it. See next email.

> I am not a fan of randomly killing userspace processes that just
> happened to be the unlucky ones, to call this first... I see no
> benefit in killing stuff over letting boot hang in a discoverable way.

Absolutely agreed. The point was to not break things.

              Linus
