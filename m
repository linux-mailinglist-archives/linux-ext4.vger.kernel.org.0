Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B18C6B575A
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfIQVHE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 17:07:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42368 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfIQVHE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 17:07:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so4993751lje.9
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHrObK8b+yTwXUpTknBWom0+qFXiK3R3tZjZ4MRZwFw=;
        b=ZGDVy1dUaQtKpgdgdOVfn2ocAdPPX/vdWupn5Tq0b6mOU1+upk6uZJtQVBC20v7jGw
         CbIdJYnxxcQqMf9qM5m5SL0B1Rfxv9frW2ay/IyXYPuQIqy8qt8R3bYEpGAA/jNcpOUh
         Rvj5TZaXMBPqI1vJva1Ju07IwTuegIJmAAbNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHrObK8b+yTwXUpTknBWom0+qFXiK3R3tZjZ4MRZwFw=;
        b=L/tSEib+JkdMBSrpI1RCGqK4xczM/rQjT3dP8vb8Zoi/MiGyplMQsF96urmE317XZd
         CIpWxH/cRurSSamuLwuJoAPv6sLJeMI+Gs57ZDGulXkWHim5Akx5wh6ZFpyW3/KezUKX
         5D6aXO9UrD0s6iiOk82HoELlo2ZwOKH/foiShTjLrx++iV1+pz3JXWnA0pnXuuK46R9V
         5xx8nmsbfzNNYcOjeZWIds6A6ctWYUyH8zJ66IsGRuDrAlj9VvAnXEuett7yl6ufZiVR
         unjofBaqaGGRQ7FnbCmcCo4m07llfFuvpSC98YEgz8WYPfEA7JDRky3U7xcNy+oNcP0Z
         g+rA==
X-Gm-Message-State: APjAAAWQGuMfW7I/zw6oYQ4i9L7OY4R8uSBKELM20a/hjPdqiiDCCK+d
        1KAUPPfnQJgdnGXNfoaACxKOT6RfdDM=
X-Google-Smtp-Source: APXvYqxXAZ5bjBF4X+4D7UE4HPPM/Xs7qks7H+N0OltURzbRjb/gBu6WWohQs6fF+41BDZAkAUNisA==
X-Received: by 2002:a2e:3004:: with SMTP id w4mr202664ljw.21.1568754422659;
        Tue, 17 Sep 2019 14:07:02 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id c10sm631590lfp.65.2019.09.17.14.07.02
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 14:07:02 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id h2so5058208ljk.1
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 14:07:02 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr203592ljj.72.1568753941203;
 Tue, 17 Sep 2019 13:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba> <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login> <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login> <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
In-Reply-To: <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 13:58:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOCv2eOT2M8Vw9GD_yOpsTwF364-hkeADyEu9erHgMGw@mail.gmail.com>
Message-ID: <CAHk-=wgOCv2eOT2M8Vw9GD_yOpsTwF364-hkeADyEu9erHgMGw@mail.gmail.com>
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

Side note, and entirely unrelated to this particular problem, but
_because_ I was looking at the entropy init and sources of randomness
we have, I notice that we still don't use the ToD clock as a source.

There's not a whole lot of bits there, but at least one of the attacks
against entirely missing boot-time randomness was to look at the
output of get_random_bytes(), and just compare it across machines. We
sanitize things by going through a cryptographic hash function, but
that helps hide the internal entropy buffers from direct viewing, but
it still leaves the "are those internal entropy buffers the _same_
across machines" for the nasty embedded hardware case with identical
hardware.

Of course, some of those machines didn't even have a a time-of-day
clock either. But the fact that some didn't doesn't mean we shouldn't
take it into account.

So adding a "add_device_randomness()" to do_settimeofday64() (which
catches them all) wouldn't be a bad idea. Not perhaps "entropy", but
helping against detecting the case of basically very limited entropy
at all at early boot.

I'm pretty sure we discussed that case when we did those things
originally, but I don't actually see us doing it anywhere right now.

So we definitely have some sources of differences for different
systems that we could/should use, even if we might not be able to
really account them as "entropy". The whole "people generated a number
of the same keys" is just horrendously bad, even if they were to use
/dev/urandom that doesn't have any strict entropy guarantees.

               Linus
