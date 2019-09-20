Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20AFEB96F8
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 20:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405763AbfITSKQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 14:10:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40803 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405121AbfITSKQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Sep 2019 14:10:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so7950361ljw.7
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rM+Onl6ZZjCImWZH5w1UTQehqPPbzrNaxCZa4cd8l/4=;
        b=WFFZp5fgdUni5U9NnLZhbw6pO9xDM5RkYeghIYgcBWXFD7T14QJUQvBU7Cdx+lxBSa
         bkTbGx0p3+3IzHwHnVfQ/fS6soC0P0rWIQj80S3A+ae2wmbHsBjD9Sa0XYRauaOcnE0g
         4Ju1XgJzmbU7Wa53qZygI9UxcmISnicMfpTV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rM+Onl6ZZjCImWZH5w1UTQehqPPbzrNaxCZa4cd8l/4=;
        b=B4WCETZuuDM/smQWi7Bnoyb4AsqTkHbZ+FpJrK8gqNDzeuVgN2czk1wERz7aCLVQMr
         yJA7RaiAU4RNR6ahKtICw6jzBnEbRZ5jtBBXr5I8kuVCuNI7TAIIncp+doSZvL3DgCaV
         IrW93wM3ZigcyzC73ZdLt1rX+8xX/PRvtegzNv0DoZyF4M9zmbBZKhy77Tu9ZhbfMUEl
         +qpYxLMTe8xXad1qahFLa8Hrj5W9ROdABPwqOSmYociJ1yfTjxUmAwwqNsKRrzkhQNLR
         dobIulusY8oC3l5FluduZqrsD79bHYrMKAPW13ewdYvQ5QAUoOI1X5Axu1wWE7yJBU4t
         8mQg==
X-Gm-Message-State: APjAAAUtYsmSoe9X8dzqs05oX2v6m16E2vZAESaqZl485Qy0zOv2h95X
        NX0688y2cmQBfa7QvoBnj/bJHz25hDQ=
X-Google-Smtp-Source: APXvYqx397UGpwOMas/Co7nHkG6Nmd35pzvGGpfEhZ5/wj7ZiG+U/FM9xgU+ne5nMw2UKMFFFhYcxg==
X-Received: by 2002:a2e:95cf:: with SMTP id y15mr9972858ljh.27.1569003013229;
        Fri, 20 Sep 2019 11:10:13 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id c16sm626651lfj.8.2019.09.20.11.10.10
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 11:10:10 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x80so5688008lff.3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 11:10:10 -0700 (PDT)
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr9479913lfm.170.1569003009866;
 Fri, 20 Sep 2019 11:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc> <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com> <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
In-Reply-To: <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 11:09:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
Message-ID: <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 20, 2019 at 10:52 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> IMO, from the beginning, we should have done this:
>
> GRND_INSECURE: insecure.  always works.
>
> GRND_SECURE_BLOCKING: does exactly what it says.
>
> 0: -EINVAL.

Violently agreed. And that's kind of what the GRND_EXPLICIT is really
aiming for.

However, it's worth noting that nobody should ever use GRND_EXPLICIT
directly. That's just the name for the bit. The actual users would use
GRND_INSECURE or GRND_SECURE.

And yes, maybe it's worth making the name be GRND_SECURE_BLOCKING just
to make people see what the big deal is.

In the meantime, we need that new bit just to be able to create the
new semantics eventually. With a warning to nudge people in the right
direction.

We may never be able to return -EINVAL, but we can add the pr_notice()
to discourage people from using it.

And yes, we'll have to block - at least for a time - to get some
entropy. But at some point we either start making entropy up, or we
say "0 means jitter-entropy for ten seconds".

That will _work_, but it will also make the security-people nervous,
which is just one more hint that they should move to
GRND_SECURE[_BLOCKING].

> getrandom(..., GRND_EXPLICIT): just fscking give me a number.  it
> seems to work and it shuts up the warning
>
> And we're back to square one.

Actually, you didn't read the GRND_INSECURE patch, did you.

getrandom(GRND_EXPLICIT) on its own returns -EINVAL.

Because yes, I thought about it, and yes, I agree that it's the same
as the old 0.

So GRND_EXPLICIT is a bit that basically means "I am explicit about
what behavior I want". But part of that is that you need to _state_
the behavior too.

So:

 - GRND_INSECURE is (GRND_EXPLICIT | GRND_NONBLOCK)

   As in "I explicitly ask you not to just not ever block": urandom

 - GRND_SECURE_BLOCKING is (GRND_EXPLICIT | GRND_RANDOM)

   As in "I explicitly ask you for those secure random numbers"

 - GRND_SECURE_NONBLOCKING is (GRND_EXPLICIT | GRND_RANDOM | GRND_NONBLOCK)

   As in "I want explicitly secure random numbers, but return -EAGAIN
if that would block".

Which are the three sane behaviors (that last one is useful for the "I
can try to generate entropy if you don't have any" case. I'm not sure
anybody will do it, but it definitely conceptually makes sense).

And I agree that your naming is better.

I had it as just "GRND_SECURE" for the blocking version, and
"GRND_SECURE | GRND_NONBLOCK" for the "secure but return EAGAIN if you
would need to block for entropy" version.

But explicitly stating the blockingness in the name makes it clearer
to the people who just want GRND_INSECURE, and makes them realize that
they don't want the blocking version.

             Linus
