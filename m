Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B13BB54D4
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 20:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfIQSBq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 14:01:46 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:45847 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfIQSBq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 14:01:46 -0400
Received: by mail-lf1-f44.google.com with SMTP id r134so3566296lff.12
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Er0gbtf1RnNHz6mdrzuapZEA6kkymLwTpdFJ1HqQU4=;
        b=HvP+vQgteoXL3yfoydiM6Z3RWF/sPvBd8S2iIsbEVja4KJe9Fsest2Y8FdeK6H1KRb
         qHlLfhbs1hWk+4zLWO+FtJSPwCPMIQ/Fxm7zGy+dSaUlkD+x/SIwFCXNAw6nN/tHknBN
         iPA8AbPat0lLjP6IRnGfhXLxkVO5dOqs+W19c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Er0gbtf1RnNHz6mdrzuapZEA6kkymLwTpdFJ1HqQU4=;
        b=o2fwucrsCC1NiO3DgKvb1GPSZjypPHYa1+0CsxMLKFFOI8UbCyrQmZFNuJJaRtLLbS
         7v5CqDf/NRAvxrFyINwihzYAf6lic5TNxjcbwYhHI2Cg99xJLd7pPHJoSBs14FiDAWTo
         OxUyWtW6OP5Z3KnR3vq1hPX2RfjSWNVFv6VQ9FmWOM4CVEHMRkICt1Bx13TAwlGYzRvV
         CfN/Av3ecVAn8+DJx1BhycLmLPB6hCBVbPpQu4kiisDVijv+CGLpl85dsOoERYDNap4a
         /9pMvd5/tZeRvX5espgIg/onpeROappUMSi5ASbxZ8KcoWz2MQfrYt6jfHw9UM5aCH/e
         D7pQ==
X-Gm-Message-State: APjAAAW1nlglKp2TIRGkNsCTPkOTqkOD3MQkKYu/QyWMOtcKvfWEh0Hn
        yy5ZWIOrKJj8VuQvhWhyTu+lZm9aG0A=
X-Google-Smtp-Source: APXvYqxPRSqDAxp3wADakR3BoBFxrFahdFNecCdPV6o202VksY16BC9OpkEdke0q/87L66WFPudhyQ==
X-Received: by 2002:a19:f801:: with SMTP id a1mr2521126lff.166.1568743303330;
        Tue, 17 Sep 2019 11:01:43 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z21sm556171lfq.79.2019.09.17.11.01.39
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 11:01:40 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id x80so3632429lff.3
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 11:01:39 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr2723201lfn.52.1568743299497;
 Tue, 17 Sep 2019 11:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba> <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login> <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login>
In-Reply-To: <20190917174219.GD31798@gardel-login>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 11:01:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
Message-ID: <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
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

On Tue, Sep 17, 2019 at 10:42 AM Lennart Poettering
<mzxreary@0pointer.de> wrote:
>
> So I think people nowadays prefer getrandom() over /dev/urandom
> primarily because of the noisy logging the kernel does when you use
> the latter on a non-initialized pool. If that'd be dropped then I am
> pretty sure that the porting from /dev/urandom to getrandom() you see
> in various projects (such as gdm/x11) would probably not take place.

Sad. So people were actually are perfectly happy with urandom, but you
don't want the warning, so you use getrandom() and as a result your
boot blocks.

What a sad sad reason for a bug.

Btw, having a "I really don't care deeply about some long-term secure
key" flag would soilve that problem too. We'd happily and silently
give you data.

The only reason we _do_ that silly printout for /dev/urandom is
exactly because /dev/random wasn't useful even for the people who
_really_ wanted secure randomness, so they started using /dev/urandom
despite the fact that it didn't necessarily have any entropy at all.

So this all actually fundamentally goes back to the absolutely horrid
and entirely wrong semantics of /dev/random that made it entirely
useless for the only thing it was actually designed for.

This is also an example of how hard-line "security" people that don't
see the shades of gray in between black and white are very much part
of the problem. If you have some unreasonable hard requirements,
you're going to do the wrong thing in the end.

At some point even security people need to realize that reality isn't
black-and-white. It's not also keeping us from making any sane
progress, I feel, because of that bogus "entropy is sacred", despite
the fact that our entropy calculations are actually just random
made-up stuff (but "hey, reasonable") to begin with and aren't really
black-and-white themselves.

> In fact, speaking for systemd: the noisy logging in the kernel is the
> primary (actually: only) reason that we prefer using RDRAND (if
> available) over /dev/urandom if we need "medium quality" random
> numbers, for example to seed hash tables and such. If the log message
> wasn't there we wouldn't be tempted to bother with RDRAND and would
> just use /dev/urandom like we used to for that.

That's also very sad. If we have rdrand, we'll actually mix it into
/dev/urandom regardless, so it's again just the whole "people started
using urandom for keys because random was broken" that is the cause of
this all.

I really really detest the whole inflexible "security" mindset.

> We can make boot hang in "sane", discoverable way.

That is certainly a huge advantage, yes. Right now I suspect that what
has happened is that this has probably been going on as some low-level
background noise for a while, and people either figured it out and
switched away from gdm (example: Christoph), or more likely some
unexplained boot problems that people just didn't chase down. So it
took basically a random happenstance to make this a kernel issue.

But "easily discoverable" would be good.

> The reason why I think this should also be logged by the kernel since
> people use netconsole and pstore and whatnot and they should see this
> there. If systemd with its infrastructure brings this to screen via
> plymouth then this wouldn't help people who debug much more low-level.

Well, I certainly agree with a kernel message (including a big
WARN_ON_ONCE), but you also point out that the last time we added
helpful messages to let people know, it had some seriously unintended
consequences ;)

              Linus
