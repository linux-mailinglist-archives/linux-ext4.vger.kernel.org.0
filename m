Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20B3B3F6B
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 19:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390280AbfIPRHv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 13:07:51 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42968 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390276AbfIPRHv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 13:07:51 -0400
Received: by mail-lf1-f47.google.com with SMTP id c195so539309lfg.9
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2019 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhXl70av4EvOTbL0RRXS4SdgE4V4WRtYtcKsjJL619g=;
        b=Fs3ihW1d0/7OhSFVjmMcwT0WBaV23WDO7f0r7V2eN5ewaGmCnHtgRxJ+CpdhycMKWW
         rP4+Xi9hy0A30CcOwQKaYl7GEfN4Xr6h3g3ESaYI871rAs2uhfnN/bND0hOZVHWDEA6y
         f3Qrk6EBNA9PfhZV/b9JMfp5fSM0rIwDkmdKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhXl70av4EvOTbL0RRXS4SdgE4V4WRtYtcKsjJL619g=;
        b=OroX1AF0P7UUeVUhJF3NL5BUycPWdNxRsr5c4rlYuyx2/RDLpcTHbNYx0y5B0iI/N1
         AYCuH7X1CX1L9afZ+h1S5sfJx6S1yWcCsbp+ykl3w9jdvZzo0eCMIV8HW7t44B6mmyA8
         70RWU0wv+OQLRKCDZKqhgPBSfTSJOO76awsvGFSypXyVV6TzD6wXzXTHbAcnddUhrsdx
         wWrM60NKy9v8mZIBRj4aqz/oIH+Qtbdvf9bAYl3gfZIhnKb4d28p9Guhm81ljyIiWoJu
         RSea1buG4ckGjvteaOaS6zZGepjxDSsCDU8ZEOFN+VVeGTFs5J+8WeJhPSq0EGJ/FGis
         hqnw==
X-Gm-Message-State: APjAAAUDhooBeg9ccmHSGudTItOlWl6gGxjwgq3foUNfuBtdSjEA3kx9
        Q+wnWBOjGnUK7R2FOQfHtwaVvDQIpgc=
X-Google-Smtp-Source: APXvYqxmunsWpexv76CF9DJlIdo95lkrlGcwVgEhbme4UCB2LBAoeSBoClG6I+cjfWnB5WASi1v2Ug==
X-Received: by 2002:ac2:4551:: with SMTP id j17mr234639lfm.81.1568653668269;
        Mon, 16 Sep 2019 10:07:48 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id z7sm3790642ljc.9.2019.09.16.10.07.44
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 10:07:44 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id m13so619524ljj.11
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2019 10:07:44 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr383093ljs.156.1568653664082;
 Mon, 16 Sep 2019 10:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com> <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login> <CAHk-=wi8wAP4P33KO6hU3D386Oupr=ZL4Or6Gw+1zDFjvz+MKA@mail.gmail.com>
 <20190916032327.GB22035@mit.edu> <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
 <20190916170028.GA15263@mit.edu>
In-Reply-To: <20190916170028.GA15263@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 10:07:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHNtmCAWGWmUn7LYnwGWdNvDavhzBdNdeeTnP4Wkk3gg@mail.gmail.com>
Message-ID: <CAHk-=wiHNtmCAWGWmUn7LYnwGWdNvDavhzBdNdeeTnP4Wkk3gg@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 10:00 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> How /dev/random blocks is very different from how getrandom(2) blocks.
> Getrandom(2) blocks until the CRNG, and then it never blocks again.

Yes and no.

getrandom() very much blocks exactly like /dev/random, when you give
it the GRND_RANDOM flag.

Which is completely broken, and was already known to be broken. So
that flag is just plain stupid.

And getrandom() does *not* block like /dev/urandom does (ie not at
all), which was actually useful, and very widely used.

So you really have the worst of both worlds.

Yes, getrandom(0) does what /dev/random _should_ have done, and what
getrandom(GRND_RANDOM) should be but isn't.

But by making the choice it did, we now have three useless flag
combinations, and we lack one people _want_ and need.

And this design mistake very much caused the particular bug we are now hitting.

                  Linus
