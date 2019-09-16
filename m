Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179B3B343F
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 07:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfIPFCY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 01:02:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35554 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfIPFCY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 01:02:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so26366470lfl.2
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 22:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+77oKblgW1oj6FjBllVFfQm2XV8GTAz0jQsoKS4xdc=;
        b=bW2PJuAaZzpeBG5JdcrThGYexKY4t+waHJVh5kr2Qo1YC1+VtAFPsCi28FJ19gU/rH
         PTGWJ4+8rpiLCWaU4mDtgGFu5YreF0dHPosQIaObW57Di/8f4ch5usXEydRlgaWOCzD7
         zsN38UFAxuPASKzpthvDx8t/rXJBJu/58gXJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+77oKblgW1oj6FjBllVFfQm2XV8GTAz0jQsoKS4xdc=;
        b=CWuEKQE+GTRrrP9RP7k9aaJB0SScX85QOBlAVclRznTvMVuEOEjTPbDsF/EUIMjMUn
         c5v9gMFJ8VnKiudJwsqNTC9OM+HvB/18JL4MTDA6rVF7QiZbGYPjzi52fM28WbUWY7QI
         0oL/cILfUnkqn3dHdiT4792k9uHOLCkM9fBztnk4F/4rqMfl3A6wFaFfONrybKnqU0jP
         4rIp0A0U+Pgewjg5hyh90/ddaC6x/5x4/s6hWNIp7cmmkaixdO5Yy02rJWoFcSXTgduc
         bYa20tHWRei1P/VwjnQXCIDPJXk7m9Ou8U6zJoYm8g1PN6wkf+Pno4EDCg+br8I6Hbny
         SNsg==
X-Gm-Message-State: APjAAAVrY5lmzQ5Jp2xPgLvjfpw2Ki91LL+KG9Cqm8qDcQ63Y+5C4LUU
        CMAN89C5d8/k1AL3k4ls6EgYmG1wRdE=
X-Google-Smtp-Source: APXvYqxVCxPVfymHqQXpDi7MjQhMSx8SCFuze+YA31nmxqlFfMtjsjKDlhQ3yfIQnHIbxVf8DcnZUA==
X-Received: by 2002:a19:710c:: with SMTP id m12mr6550471lfc.41.1568610140363;
        Sun, 15 Sep 2019 22:02:20 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id n12sm5336365lfh.86.2019.09.15.22.02.18
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 22:02:19 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id v24so4789275ljj.3
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 22:02:18 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr3508817lji.52.1568610138468;
 Sun, 15 Sep 2019 22:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login> <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc> <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu> <20190916042952.GB23719@1wt.eu>
In-Reply-To: <20190916042952.GB23719@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 22:02:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
Message-ID: <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
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

On Sun, Sep 15, 2019 at 9:30 PM Willy Tarreau <w@1wt.eu> wrote:
>
> I'd be in favor of adding in the man page something like "this
> random source is only suitable for applications which will not be
> harmed by getting a predictable value on output, and as such it is
> not suitable for generation of system keys or passwords, please
> use GRND_RANDOM for this".

The problem with GRND_RANDOM is that it also ends up extracting
entropy, and has absolutely horrendous performance behavior. It's why
hardly anybody uses /dev/random.

Which nobody should really ever do. I don't understand why people want
that thing, considering that the second law of thermodynamics really
pretty much applies. If you can crack the cryptographic hashes well
enough to break them despite reseeding etc, people will have much more
serious issues than the entropy accounting.

So the problem with getrandom() is that it only offered two flags, and
to make things worse they were the wrong ones.

Nobody should basically _ever_ use the silly "entropy can go away"
model, yet that is exactly what GRND_RANDOM does.

End result: GRND_RANDOM is almost entirely useless, and is actively
dangerous, because it can actually block not just during boot, it can
block (and cause others to block) during random running of the system
because it does that entropy accounting().

Nobody can use GRND_RANDOM if they have _any_ performance requirements
what-so-ever. It's possibly useful for one-time ssh host keys etc.

So GRND_RANDOM is just bad - with or without GRND_NONBLOCK, because
even in the nonblocking form it will account for entropy in the
blocking pool (until it's all gone, and it will return -EAGAIN).

And the non-GRND_RANDOM case avoids that problem, but requires the
initial entropy with no way to opt out of it. Yes, GRND_NONBLOCK makes
it work.

So we have four flag combinations:

 - 0 - don't use if it could possibly run at boot

   Possibly useful for the systemd-random-seed case, and if you *know*
you're way past boot, but clearly overused.

   This is the one that bit us this time.

 - GRND_NONBLOCK - fine, but you now don't get even untrusted random
numbers, and you have to come up with a way to fill the entropy pool

   This one is most useful as a quick "get me urandom", but needs a
fallback to _actual_ /dev/urandom when it fails.

   This is the best choice by far, and has no inherent downsides apart
from needing that fallback code.

 - GRND_RANDOM - don't use

   This will block and it will decrease the blocking pool entropy so
that others will block too, and has horrible performance.

   Just don't use it outside of very occasional non-serious work.

   Yes, it will give you secure numbers, but because of performance
issues it's not viable for any serious code, and obviously not for
bootup.

    It can be useful as a seed for future serious use that just does
all random handling in user space. Just not during boot.

 - GRND_RANDOM | GRND_NONBLOCK - don't use

   This won't block, but it will decrease the blocking pool entropy.

   It might be an acceptable "get me a truly secure ring with reliable
performance", but when it fails, you're going to be unhappy, and there
is no obvious fallback.

So three out of four flag combinations end up being mostly "don't
use", and the fourth one isn't what you'd normally want (which is just
plain /dev/urandom semantics).

                     Linus
