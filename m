Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD9BB2D84
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 03:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfIOBLI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 21:11:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45925 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfIOBLH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 21:11:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so19941090ljb.12
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2019 18:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jaz+3rRqlSOpgo+I/TmiFB0JMhsAKNvHZJnxSa0w8w=;
        b=aclPG/A9P+tr2kYHdAmA46ZRYIp9V55HAtxJ94L+Dt6Hj6i2u7wbW0zA9HKOGWcbp0
         khpbUTOnGoyzVQkbyCgpLizTCdiIEBX01ILPyiV+YNXpsSVoexwBTdIg7DG4f+S8g98p
         9YZ7Nu65nCfjMaunYW2V+DXGGHfxAuvV9aKm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jaz+3rRqlSOpgo+I/TmiFB0JMhsAKNvHZJnxSa0w8w=;
        b=SIG0lDdxwdf7ullm0yWv1PrdUqI4ReDjIUeWynwCDh7Rfd9SDy0QNwjc2ufF+zdrYZ
         yKyVaUAj8RNQiI4pcvj5dUEnlOV5s9m1YuER+OBFFUuZjirYVh74avxKP3G9J2MOAk6I
         b3AbKe9tnWbk0PYI+hBihqaJeh2cWD5owPzOIDoErQot1eeuXSeSF6BZz3/eNkgMes0d
         EzMjAJwmAJFuMEPgFJyNUWd2+1cCGRAJFzO7abxOTutBrb3U2qNlsCZe9MQyJEVfJ5a+
         gKdtd8FhjAlroWNKD8vYS5F9VxJj/utZ0fGrGhqIqSPv/dqbbHxnujbVcogfy8eGpkSO
         lfPg==
X-Gm-Message-State: APjAAAWlP/ZbVcJvL2yBGrb0mJknS52nsKzFBSqDOMhnQ4sEJ7IK8SuT
        yf+eh8OZahsOYpdL66gY2zqYwCAbFNM=
X-Google-Smtp-Source: APXvYqyHAkVaWlopdg9W6aWnia6RybdTa/bCmVIsQPq3u7eqrAJFqXWhOOxm12inHll7hAgQo0Airw==
X-Received: by 2002:a2e:808c:: with SMTP id i12mr897345ljg.78.1568509865231;
        Sat, 14 Sep 2019 18:11:05 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i21sm7964891lfl.44.2019.09.14.18.11.04
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 18:11:04 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id d5so30453304lja.10
        for <linux-ext4@vger.kernel.org>; Sat, 14 Sep 2019 18:11:04 -0700 (PDT)
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr26091372ljo.180.1568509863854;
 Sat, 14 Sep 2019 18:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190914211126.GA4355@darwi-home-pc> <20190914222432.GC19710@mit.edu>
 <CAHk-=wi-y26j4yX5JtwqwXc7zKX1K8FLQGVcx49aSYuW8JwM+w@mail.gmail.com> <20190915010037.GE19710@mit.edu>
In-Reply-To: <20190915010037.GE19710@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 18:10:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGTV0e_P73V0B3cPVrfeoSZcV6CjQMgj-+yL-s38DKaw@mail.gmail.com>
Message-ID: <CAHk-=wjGTV0e_P73V0B3cPVrfeoSZcV6CjQMgj-+yL-s38DKaw@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 14, 2019 at 6:00 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> That makes me even more worried.  It's probably going to be OK for
> modern x86 systems, since "best we can do" will include RDRAND
> (whether or not it's trusted).  But on systems without something like
> RDRAND --- e.g., ARM --- the "best we can do" could potentially be
> Really Bad.  Again, look back at the Mining Your P's and Q's paper
> from factorable.net.

Yes. And they had that problem *because* the blocking interface was
useless, and they didn't use it, and *because* nobody warned them
about it.

In other words, the whole disaster was exactly because blocking is
wrong, and because blocking to get "secure" data is unacceptable.

And the random people DIDN'T LEARN A SINGLE LESSON from that thing.

Seriously. getrandom() introduced the same broken model as /dev/random
had - and that then caused people to use /dev/urandom instead.

And now it has shown itself to be broken _again_.

And you still argue against the only sane model. Scream loudly that
you're doing something wrong so that people can fix their broken
garbage, but don't let people block, which is _also_ broken garbage.

Seriously. Blocking is wrong. Blocking has _always_ been wrong. It was
why /dev/random was useless, and it is now why the new getrandom()
system call is showing itself useless.

> We could return 0 for success, and yet "the best we
> can do" could be really terrible.

Yes. Which is why we should warn.

But we can't *block*. Because that just breaks people. Like shown in
this whole discussion.

Why is warning different? Because hopefully it tells the only person
who can *do* something about it - the original maintainer or developer
of the user space tools - that they are doing something wrong and need
to fix their broken model.

Blocking doesn't do that. Blocking only makes the system unusable. And
yes, some security people think "unusable == secure", but honestly,
those security people shouldn't do system design. They are the worst
kind of "technically correct" incompetent.

> > > For 5.3, can we please consider my proposal in [1]?
> > It may be the safest thing to do, but at that point we might as well
> > just revert the ext4 change entirely. I'd rather do that, than have
> > random filesystems start making random decisions based on crazy user
> > space behavior.
>
> All we're doing is omitting the plug;

Yes. Which we'll do by reverting that change. I agree that it's the
safe thing to do for 5.3.

We are not adding crazy workarounds for "getrandom()" bugs in some
low-level filesystem.

Either we fix getrandom() or we revert the change. We don't do some
mis-designed "let's work around bugs in getrandom() in the ext4
filesystem with ad-hoc behavioral changes".

              Linus
