Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5AB18C2ED
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Mar 2020 23:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCSWXr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 18:23:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38757 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgCSWXr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Mar 2020 18:23:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so4371430ljh.5
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJ6MzhtWalH0hDBYxWzZFJvnUo/A0DOitGKj0UfdYo8=;
        b=XBqh7pWnTmUlqQohZOg/HeJr0gQHAIeXOwQCGzJ5OwLz0JntySiWzUQk/bbyBsqGm9
         AOagPLaBdiW1PMwWYNG62+YPygcjxUIjKZCSAWI7Y+gXGQmEpDRx5s4L6A86L4QjzPhm
         g1WliO6jBKgCaK0bZjyFPxJo1T1kZceLM4t/lRH12iiIppbgjzQ3iyFeIrW4qK58Nko5
         lbNS0FS7GU3iUIH68IUAikInyw3mSaCNwFQaUwVoTXF/SPEBXD79mERRqpVxClHgzlbO
         LuBZhWaZGVlUhSTRyD/NNbgZlWYzqDYTxbQym6CawlmhMV6GI3Nb15UmNwRMlI/s0Tib
         EF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJ6MzhtWalH0hDBYxWzZFJvnUo/A0DOitGKj0UfdYo8=;
        b=mzu0m5bRBy9KlrqLMmIMCFzZ8qJ2nWX9Dt0e3drBPOCtQTcSy4hGvK1UXv7dijayn9
         +/zcHwgxSz4NGnahZRD3Qd4b+QGZoQ1e5tDeVBNA/nk6NL7Gj0zFhBTVyKcwG35WConz
         TrAZK7UGKh7YJzjnIUXYg73/hdORQx4TcdziYgPh53BFOU3hbjHRFhc9KLx1UsDhTVC1
         HR6G4WxQ6CquEGllCsptTmWJl+VhOZgpk8wwynRGJ97E8q9S0CriOqcN474DLaSdwxjb
         E+9Y2g6cwmUeLyj1le0+wxrrfpvAI8YNy93cR7x62pQCrDzLSeVRl+Ud9NEvnx6NdsQY
         ACgA==
X-Gm-Message-State: ANhLgQ3XAYW31Seu3wsDxyFHKxdP5j6wE53NM02jOWqAH46Frm2D5DBP
        8bZGOmQW3Tkg5mgauo8z7wI/6oXvV2dmxqGN6ygAOQ==
X-Google-Smtp-Source: ADFU+vsNGI4DJxjB5f7C7tgGloRNRzSoDi/T/uXs4OR8cIg4QaTNXgqQeL/rC2Yz+GqKJZUSlth8pWewRRKx9U7JH3M=
X-Received: by 2002:a05:651c:1026:: with SMTP id w6mr3408670ljm.168.1584656625715;
 Thu, 19 Mar 2020 15:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
 <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
 <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com> <CAFEAcA-gdwi=KSW6LqVdEJWSo9VEL5abYQs9LoHd4mKE_-h=Aw@mail.gmail.com>
In-Reply-To: <CAFEAcA-gdwi=KSW6LqVdEJWSo9VEL5abYQs9LoHd4mKE_-h=Aw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Mar 2020 23:23:33 +0100
Message-ID: <CACRpkdYuZgZUznVxt1AHCSJa_GAXy8N0SduE5OrjDnE1s_L7Zg@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 19, 2020 at 4:25 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Thu, 19 Mar 2020 at 15:13, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Mar 17, 2020 at 12:58 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > What in particular does this personality setting affect?
> > > My copy of the personality(2) manpage just says:
> > >
> > >        PER_LINUX32 (since Linux 2.2)
> > >               [To be documented.]
> > >
> > > which isn't very informative.
> >
> > It's not a POSIX thing (not part of the Single Unix Specification)
> > so as with most Linux things it has some fuzzy semantics
> > defined by the community...
> >
> > I usually just go to the source.
>
> If we're going to decide that this is the way to say
> "give me 32-bit semantics" we need to actually document
> that and define in at least broad terms what we mean
> by it, so that when new things are added that might or
> might not check against the setting there is a reference
> defining whether they should or not, and so that
> userspace knows what it's opting into by setting the flag.
> The kernel loves undocumented APIs but userspace
> consumers of them are not so enamoured :-)

OK I guess we can at least take this opportunity to add
some kerneldoc to the include file.

> As a concrete example, should "give me 32-bit semantics
> via PER_LINUX32" mean "mmap should always return addresses
> within 4GB" ? That would seem like it would make sense --

Incidentally that thing in particular has its own personality
flag (personalities are additive, it's a bit schizophrenic)
so PER_LINUX_32BIT is defined as:
PER_LINUX_32BIT =       0x0000 | ADDR_LIMIT_32BIT,
and that is specifically for limiting the address space to
32bit.

There is also PER_LINUX32_3GB for a 3GB lowmem
limit.

Since the personality is kind of additive, if
we want a flag *specifically* for indicating that we want
32bit hashes from the file system, there are bits left so we
can provide that.

Is this what we want to do? I just think we shouldn't
decide on that lightly as we will be using up personality
bug bits, but sometimes you have to use them.

PER_LINUX32 as it stands means 32bit personality
but very specifically does not include memory range
limitations since that has its own flags.

Yours,
Linus Walleij
