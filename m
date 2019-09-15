Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6833B3107
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 19:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfIORCm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 13:02:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37103 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfIORCm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 13:02:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so25602106lff.4
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJog4a1KzN5ZWVAGm+sopT4jMum2Htu1nAr4w5DPQ7I=;
        b=Jzge8itIrkMmk+5MxzJFOr2K2SmoFAEAqlVEVaDURIi+whXghMX7iENXyNMTIZ+vWW
         DM69bi3TyUWtrCXoUO0j7yW1oyen2osJVfaw1v1KJOa6oOCij6UdODknmQzfqbdXpfWm
         H7SoJdJNAInos2aeL3w8Supy47UcnJIebMcSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJog4a1KzN5ZWVAGm+sopT4jMum2Htu1nAr4w5DPQ7I=;
        b=NkKao9gEgI9fnUyyeENMKCeA8kp5rFDjz3PS2ORR0kh0wU+hwYbSYerUiOF9q4Eu0p
         dXgZaYIvkqqKbxETTPSxlSZoX9KgTeeWH5+V/UjdKW7fIuhAR75lVjPXWAsM926KiA+X
         6rfPA8PTpkfg+uuRJ5Cxh5G3+99ppmhlz4+mshKLcKzd/LGeeaW9jcZQJHW44G22roWH
         PD7fiWjR1Ic1dAfen3ENnKT51rzxXQh1PhfxBzv5gK+Ufzd69cG4C27G9/uhpOCIdvJ/
         adKDMqGvKuVEkaUMVEABL15r+IsD4bdeQhNKsozm6HC3KvU9iXFLlC7WO5Mv668DS0nO
         5ieA==
X-Gm-Message-State: APjAAAWlPJJGjkjqR+cLQXbKhc6WLe9tLhOAFSMIFUxqlT/qGERBl6U2
        dXCbFxyI+pzURBgomm5eJs6IbGGhBFM=
X-Google-Smtp-Source: APXvYqzd43hqhtbgHgBWQyEaP9krtwrIDCp4CGU58m6/OqG7oaKALenPVCFzFYrvXUqdyi4B1GNINg==
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr11100643lfn.52.1568566958911;
        Sun, 15 Sep 2019 10:02:38 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id h9sm8476190lfp.40.2019.09.15.10.02.35
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 10:02:35 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u3so10486176lfl.10
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 10:02:35 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr31085363lfh.29.1568566954662;
 Sun, 15 Sep 2019 10:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com> <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login>
In-Reply-To: <20190915065655.GB29681@gardel-login>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 10:02:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8wAP4P33KO6hU3D386Oupr=ZL4Or6Gw+1zDFjvz+MKA@mail.gmail.com>
Message-ID: <CAHk-=wi8wAP4P33KO6hU3D386Oupr=ZL4Or6Gw+1zDFjvz+MKA@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
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

On Sat, Sep 14, 2019 at 11:56 PM Lennart Poettering
<mzxreary@0pointer.de> wrote:
>
> I am not expecting the kernel to guarantee entropy. I just expecting
> the kernel to not give me garbage knowingly. It's OK if it gives me
> garbage unknowingly, but I have a problem if it gives me trash all the
> time.

So realistically, we never actually give you *garbage*.

It's just that we try very hard to actually give you some entropy
guarantees, and that we can't always do in a timely manner -
particularly if you don't help.

But on a PC, we can _almost_ guarantee entropy. Even with a golden
image, we do mix in:

 - timestamp counter on every device interrupt (but "device interrupt"
doesn't include things like the local CPU timer, so it really needs
device activity)

 - random boot and BIOS memory (dmi tables, the EFI RNG entry, etc)

 - various device state (things like MAC addresses when registering
network devices, USB device numbers, etc)

 - and obviously any CPU rdrand data

and note the "mix in" part - it's all designed so that you don't trust
any of this for randomness on its own, but very much hopefully it
means that almost *any* differences in boot environment will add a
fair amount of unpredictable behavior.

But also note the "on a PC" part.

Also note that as far as the kernel is concerned, none of the above
counts as "entropy" for us, except to a very small degree the device
interrupt timing thing. But you need hundreds of interrupts for that
to be considered really sufficient.

And that's why things broke. It turns out that making ext4 be more
efficient at boot caused fewer disk interrupts, and now we weren't
convinced we had sufficient entropy. And the systemd boot thing just
*stopped* waiting for entropy to magically appear, which is never will
if the machine is idle and not doing anything.

So do we give you "garbage" in getrandom()? We try really really hard
not to, but it's exactly the "can we _guarantee_ that it has entropy"
that ends up being the problem.

So if some silly early boot process comes along, and asks for "true
randomness", and just blocks for it without doing anything else,
that's broken from a kernel perspective.

In practice, the only situation we have had really big problems with
not giving "garbage" isn't actually the "golden distro image" case you
talk about. It's the "embedded device golden _system_ image" case,
where the image isn't just the distribution, but the full bootloader
state.

Some cheap embedded MIPS CPU without even a timestamp counter, with
identical flash contents for millions of devices, and doing a "on
first boot, generate a long-term key" without even connecting to the
network first.

That's the thing Ted was pointing at:

    https://factorable.net/weakkeys12.extended.pdf

so yes, it can be "garbage", but it can be garbage only if you really
really do things entirely wrong.

But basically, you should never *ever* try to generate some long-lived
key and then just wait for it without doing anything else. The
"without doing anything else" is key here.

But every time we've had a blocking interface, that's exactly what
somebody has done. Which is why I consider that long blocking thing to
be completely unacceptable. There is no reason to believe that the
wait will ever end, partly exactly because we don't consider timer
interrupts to add any timer randomness. So if you are just waiting,
nothing necessarily ever happen.

                 Linus
