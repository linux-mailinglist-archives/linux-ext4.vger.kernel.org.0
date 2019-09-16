Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8FB33C4
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 05:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfIPDkw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 23:40:52 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:33622 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfIPDkw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 23:40:52 -0400
Received: by mail-lf1-f43.google.com with SMTP id y127so3021809lfc.0
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 20:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLXQAqPqQDmWrNXiK3wVfq5Z50mijKvlxznDrVOzmgs=;
        b=Z+nV7Ke5BSXKKmQ+Ts4YTT7qlC7TbyV/jm6NLKBU6z03rU7NvAQNji5GioZWgK17s7
         62yKx2FMR6rJFiizi4ZjNRv5njnEY7NFsF2OjfCFTgE2HwxHxhM9PY/0+JsGYd4dJ2fD
         dgKtQX7Ouj0JYOEnIgLAxi0CnKF/POvAmDnps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLXQAqPqQDmWrNXiK3wVfq5Z50mijKvlxznDrVOzmgs=;
        b=juNzqY8dFXFICN4TkitGuT0rM5v13CfAv1fH+CixpxbpCfEdaHumdR0FkQ/3G2r4Dr
         wlc4OjOvlFFohwCxcgXJgtzzg7V64A5NpRK/QPBpAgJLTVYSC3kdQMe2Nr485PZdamtr
         YTk9QtAIfMPS2Kdkpui7aWAGEwaNM4cnYdZbjmoPhyJNx5ZihuxlcuVCqLmv8LEPt9ui
         TN3Oc+ygXgOdiTn6dppNYuxEuGh7Qxig8GXl4tbyS5IaMmlnnm4BQH536lLJPn4GjrYk
         gSrlQQkFz+Kp9AkAlaKwfHphq0jvMztuSfshwBM0WrYd3z/TI7uZNHqXzfA7ddFdjvk6
         Pg3w==
X-Gm-Message-State: APjAAAUPz0cSXRl//yEwj+eHqBbVnlQJpTX9q0ofbVIdSon/+/jpuEfV
        sKYphC0TyzgXnZzKyXkto9z1VOgfYvg=
X-Google-Smtp-Source: APXvYqwoFzhlJGFjNHeqb0KxCRKI7EnEfWPKxCjt1fbOkfEfxrm3ObJhKOkpEyTVWrhJi2+2XhKsFA==
X-Received: by 2002:ac2:4196:: with SMTP id z22mr18252550lfh.54.1568605248820;
        Sun, 15 Sep 2019 20:40:48 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 3sm8077343ljs.20.2019.09.15.20.40.46
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 20:40:47 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f5so300184ljg.8
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 20:40:46 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr5130786ljs.156.1568605246706;
 Sun, 15 Sep 2019 20:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com> <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login> <CAHk-=wi8wAP4P33KO6hU3D386Oupr=ZL4Or6Gw+1zDFjvz+MKA@mail.gmail.com>
 <20190916032327.GB22035@mit.edu>
In-Reply-To: <20190916032327.GB22035@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 20:40:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
Message-ID: <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
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

On Sun, Sep 15, 2019 at 8:23 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> But not blocking is *precisely* what lead us to weak keys in network
> devices that were sold by the millions to users in their printers,
> wifi routers, etc.

Ted, just admit that you are wrong on this, instead of writing the
above kind of bad fantasy.

We have *always* supported blocking. It's called "/dev/random". And
guess what? Not blocking wasn't what lead to weak keys like you try to
imply.

What led to weak keys is that /dev/random is useless and nobody sane
uses it, exactly because it always blocks.

So you claim that it is lack of blocking that is the problem, but
you're ignoring reality. You are ignoring the very real fact that
blocking is what led to people not using the blocking interface in the
first place, because IT IS THE WRONG MODEL.

It really is fundamentally wrong. Blocking by definition will never
work, because it doesn't add any entropy. So people then don't use the
blocking interface, because it doesn't _work_.

End result: they then use another interface that does work, but isn't secure.

I have told you that in this thread, and HISTORY should have told you
that. You're not listening.

If you want secure keys, you can't rely on a blocking model, because
it ends up not working. Blocking leads to problems.

If you want secure keys, you should do the exact opposite of blocking:
you should encourage people to explicitly use a non-blocking "I want
secure random numbers", and then if that fails, they should do things
that cause entropy.

So getrandom() just repeated a known broken model. And you're
parroting that same old known broken stuff. It didn't work with
/dev/random, why do you think it magically works with getrandom()?

Stop fighting reality.

The fact is, either you have sufficient entropy or you don't.

 - if you have sufficient entropy, blocking is stupid and pointless

 - if you don't have sufficient entropy, blocking is exactly the wrong
thing to do.

Seriously. Don't make excuses for bad interfaces. We should have
learnt this long ago.

             Linus
