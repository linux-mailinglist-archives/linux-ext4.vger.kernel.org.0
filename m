Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A716B6D82
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfIRU07 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 16:26:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36942 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbfIRU07 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Sep 2019 16:26:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so639660lff.4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2019 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WA83kKskWDi0wSYWEMANppD1TtU2egtENlabxouEkMs=;
        b=D7phgcdky5drAnukp4PGzIPILGleUSxw/Oy6UL6EcAOEXsYTKGPslV2lsSMTxEN+mH
         M3RqihbNDrPkWyIcw/igYnJ1odNGKJcr97829hJnei6qtbXfJEkFQsRdPHCP5ZG4HipW
         KeCnm0IJheqNUiL0MQFc74cHjOFPY3i9mSC8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WA83kKskWDi0wSYWEMANppD1TtU2egtENlabxouEkMs=;
        b=RnZ51ko186ExtAzpZbYiHnnjU8b29gLip9wS17nLKRWPeDiWyvkjLBy6dLXaRUE/rS
         SHzkEw8lN/GdMmsD1qR/tkTG7RZpSlNsf1A2j2vu24EK4SQS67CH8ELgvMU2uRhtLLLr
         +RCH/Sj6ljwcGttafii/fDjz9uHFg6wyEZqwcP8g7WUo2a1wVH9y9nRgZ2n2ydjftbVV
         3B4lvpcbzogIQHOYzLFri0vuArumQEgMhgb1tyhn8VkqfR97t9Vpt2eOIXWsiXhP9xT4
         X1bl43anJCbZwi28yAkGt4vRjHL+C+eeBO5c/GNh+0FunM/bNuQitpXxue8XiDyspsoh
         /m3Q==
X-Gm-Message-State: APjAAAW4PTZS32XEkujtxPJ/dVzXTBcyWVgsl2mUWvF1dJoMyJSPj3HV
        74Nk7jqibhJHM+He+m7Gkgp69QbEIYY=
X-Google-Smtp-Source: APXvYqy7Hg0mT7TE5PJ4b2IdQbDuw+QY6fHLgubl9s2rKt3cpN69fyn/oau3c+uUwQQOE2sU8WZGVA==
X-Received: by 2002:a19:117:: with SMTP id 23mr3093850lfb.115.1568838417262;
        Wed, 18 Sep 2019 13:26:57 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id c18sm1403492ljd.27.2019.09.18.13.26.55
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 13:26:56 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id y127so657718lfc.0
        for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2019 13:26:55 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr3099120lfp.61.1568838415644;
 Wed, 18 Sep 2019 13:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba> <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login> <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login> <87zhj15qgf.fsf@x220.int.ebiederm.org> <84824f79-2d12-0fd5-5b32-b0360eb075ac@gmail.com>
In-Reply-To: <84824f79-2d12-0fd5-5b32-b0360eb075ac@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 13:26:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYhC-qXHdEypy6iC7SzPA+KvWphLXSGF+mvGCGHGjNZw@mail.gmail.com>
Message-ID: <CAHk-=whYhC-qXHdEypy6iC7SzPA+KvWphLXSGF+mvGCGHGjNZw@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
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

On Wed, Sep 18, 2019 at 1:15 PM Alexander E. Patrakov
<patrakov@gmail.com> wrote:
>
> No, this is not the solution, if we take seriously not only getrandom
> hangs, but also urandom warnings. In some setups (root on LUKS is one of
> them) they happen early in the initramfs. Therefore "restoring" entropy
> from the previous boot by a script that runs from the main system is too
> late. That's why it is suggested to load at least a part of the random
> seed in the boot loader, and that has not been commonly implemented.

Honestly, I think the bootloader suggestion is naive and silly too.

Yes, we now support it. And no, I don't think people will trust that
either. And I suspect for good reason: there's really very little
reason to believe that bootloaders would be any better than any other
part of the system.

So right now some people trust bootloaders exactly _because_ there
basically is just one or two that do this, and the people who use them
are usually the people who wrote them or are at least closely
associated with them. That will change, and then people will say "why
would I trust that, when we know of bug Xyz".

And I guarantee that those bugs _will_ happen, and people will quite
reasonably then say "yeah, I don't trust the bootloader". Bootloaders
do some questionable things.

The most likely thing to actually be somewhat useful is I feel things
like the kernel just saving the seed by itself in nvram. There's
already an example of this for the EFI random seed thing, but that's
used purely for kexec, I think.

Adding an EFI variable (or other platform nonvolatile thing), and
reading (and writing to it) purely from the kernel ends up being one
of those things where you can then say "ok, if we trust the platform
AT ALL, we can trust that". Since you can't reasonably do things like
add EFI variables to your distro image by mistake.

Of course, even then people will say "I don't trust the platform". But
at some point you just say "you have trust issues" and move on.

            Linus
