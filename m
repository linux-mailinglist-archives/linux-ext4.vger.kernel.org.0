Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D0DB9807
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 21:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfITTve (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 15:51:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45628 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfITTve (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Sep 2019 15:51:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so8158147ljb.12
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/KRNd6WnVd1TN8iGmZGtSrb5q1ExNfe/4Yl0euZMS0=;
        b=iAXp/EtQxpgvqEzrvvxqiOyQr7c9BVQXW9AqVrmJ1uutftSkoOvoPGmu0/aiukB8Eh
         a4oRgtofk+kMsCJx0F/+Q7WlMYD9WpnDU1zVcsFNFP16vWm2XLFfmQumCUclks6ozIfb
         3NBzrIVS9HrmA+u9BOyxaHHk9xq0ckXcDd5Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/KRNd6WnVd1TN8iGmZGtSrb5q1ExNfe/4Yl0euZMS0=;
        b=T1ne617AhRgrzgAD2ubce+3dE7Y3xL1FlTp3Lwq9xOtG/4kbqT36g7kuQ2I5cRPT99
         HJfzYQIj/1JI4IDiRD5Tku60aJIqygN+ghlqWFXfPSX4jBBOPq/+ElUCE84OIKUE4/Fe
         czUHgV7+PSKa2ehabvmOPdA3Qupi0VtVMf5Fb3vSk9wI4djq/NL8qQxr/mZsittl+RQq
         kdQ+cuGvnLfKu8u8o2R7KisHqqOG3vL1QZe9tqUxUuYmEJNJ/x8BL+zuz1UX7f0oVH/6
         TW89d+D6nFQZakQ9GsuZe/qrJd+YfEE9Tb6Lc+BaCLFY4uzZevekUYDtgHOyi+5cuCE3
         S4cg==
X-Gm-Message-State: APjAAAUyA4ixD8VBjFwYZJaqyjXcKxt3CWm0mXTQHCXTJv5HDK2tabe1
        jqxTQ2IIiuS+lG0S7zW58404jBQDnOo=
X-Google-Smtp-Source: APXvYqykdyYBNlL9b3jQmS3YnLn+v9hA+diHZ2AJ1F3YAkYLUxBCSU4ps1edDNGpJ0tk0edJoBCbEg==
X-Received: by 2002:a2e:b4c4:: with SMTP id r4mr10380607ljm.69.1569009091074;
        Fri, 20 Sep 2019 12:51:31 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id f5sm666915lfh.52.2019.09.20.12.51.30
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 12:51:30 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id e17so8149251ljf.13
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 12:51:30 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr10431173ljj.72.1569009089004;
 Fri, 20 Sep 2019 12:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc> <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
 <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
 <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com> <CALCETrUEqjFmPvpcJQwJe3dNbz8eaJ4k3_AV2u0v96MffjLn+g@mail.gmail.com>
In-Reply-To: <CALCETrUEqjFmPvpcJQwJe3dNbz8eaJ4k3_AV2u0v96MffjLn+g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 12:51:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJ3kmcZp=Ws+uXnRB9KokG6nXSQCSuBnerG--jkAfP5w@mail.gmail.com>
Message-ID: <CAHk-=whJ3kmcZp=Ws+uXnRB9KokG6nXSQCSuBnerG--jkAfP5w@mail.gmail.com>
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

On Fri, Sep 20, 2019 at 12:12 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> The problem is that new programs will have to try the new flag value
> and, if it returns -EINVAL, fall back to 0.  This isn't so great.

Don't be silly.

Of course they will do that, but so what? With a new kernel, they'll
get the behavior they expect. And with an old kernel, they'll get the
behavior they expect.

They'd never fall back to to "0 means something I didn't want",
exactly because we'd make this new flag be the first change.

> Wait, are you suggesting that 0 means invoke jitter-entropy or
> whatever and GRND_SECURE_BLOCKING means not wait forever and deadlock?
>  That's no good -- people will want to continue using 0 because the
> behavior is better.

I assume that "not wait forever" was meant to be "wait forever".

So the one thing we have to do is break the "0 waits forever".  I
guarantee that will happen. I will override Ted if he just NAk's it,
because we simply _cannot_ continue with it.

So we absolutely _will_ come up with some way 0 ends the wait. Whether
it's _just_ a timeout, or whether it's jitter-entropy or whatever, it
will happen.

But we'll also make getrandom(0) do the annoying warning, because it's
just ambiguous. And I suspect you'll find that a lot of security
people don't really like jitter-entropy, at least not in whatever
cut-down format we'll likely have to use in the kernel.

And we'll also have to make getrandom(0) be really _timely_. Security
people would likely rather wait for minutes before they are happy with
it. But because it's a boot constraint as things are now, it will not
just be jitter-entropy, it will be _accelerated_ jitter-entropy in 15
seconds or whatever, and since it can't use up all of CPU time, it's
realistically more like "15 second timeout, but less of actual CPU
time for jitter".

We can try to be clever with a background thread and a lot of
yielding(), so that if the CPU is actually idle we'll get most of that
15 seconds for whatever jitter, but end result is that it's still
accelerated.

Do I believe we can do a good job in that kind of timeframe?
Absolutely. The whole point should be that it's still "good enough",
and as has been pointed out, that same jitter entropy that people are
worried about is just done in user space right now instead.

But do I believe that security people would prefer a non-accelerated
GRND_SECURE_BLOCKING? Yes I do. That doesn't mean that
GRND_SECURE_BLOCKING shouldn't use jitter entropy too, but it doesn't
need the same kind of "let's hurry this up because it might be during
early boot and block things".

That said, if we can all convince everybody (hah!) that jitter entropy
in the kernel would be sufficient, then we can make the whole point
entirely moot, and just say "we'll just change crng_wait() to do
jitter entropy instead and be done with it. Then any getrandom() user
will just basically wait for a (very limited) time and the system will
be happy.

If that is the case we wouldn't need new flags at all. But I don't
think you can make everybody agree to that, which is why I suspect
we'll need the new flag, and I'll just take the heat for saying "0 is
now off limits, because it does this thing that a lot of people
dislike".

> IMO this is confusing.  The GRND_RANDOM flag was IMO a mistake and
> should just be retired.  Let's enumerate useful cases and then give
> them sane values.


That's basically what I'm doing. I enumerate the new values.

But the enumerations have hidden meaning, because the actual bits do
matter. The GRND_EXPLICIT bit isn't supposed to be used by any user,
but it has the value it has because it makes old kernels return
-EINVAL.

But if people hate the bit names, we can just do an enum and be done with it:

   enum grnd_flags {
      GRND_NONBLOCK = 1,
      GRND_RANDOM, // Don't use!
      GRND_RANDOM_NONBLOCK, // Don't use
      GRND_UNUSED,
      GRND_INSECURE,
      GRND_SECURE_BLOCKING,
      GRND_SECURE_NONBLOCKING,
  };

but the values now have a _hidden_ pattern (because we currently have
that "| GRND_NONBLOCK" pattern that I want to make sure still
continues to work, rather than give unexpected behavior in case
somebody continues to use it).

So the _only_ difference between the above and what I suggested is
that I made the bit pattern explicit rather than hidden in the value.

> And the only real question is how to map existing users to these
> semantics.  I see two sensible choices:
>
> 1. 0 means "secure, blocking". I think this is not what we'd do if we
> could go back in time and chage the ABI from day 1, but I think it's
> actually good enough.  As long as this mode won't deadlock, it's not
> *that* bad if programs are using it when they wanted "insecure".

It's exactly that "as long as it won't deadlock" that is our current problem.

It *does* deadlock.

So it can't mean "blocking" in any long-term meaning.

It can mean "blocks for up to 15 seconds" or something like that. I'd
honestly prefer a smaller number, but I think 15 seconds is an
acceptable "your user space is buggy, but we won't make you think the
machine hung".

> 2. 0 means "secure, blocking, but warn".  Some new value means
> "secure, blocking, don't warn".  The problem is that new applications
> will have to fall back to 0 to continue supporting old kernels.

The same comment about blocking.

Maybe you came in in the middle, and didn't see the whole "reduced IO
patterns means that boot blocks forever" part of the original problem.

THAT is why 0 will absolutely change behaviour.

                Linus
