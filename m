Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE718BB07
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Mar 2020 16:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgCSPZO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 11:25:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35861 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSPZO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Mar 2020 11:25:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id k18so3088215oib.3
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyRv3rP13OdLMBv8QRB7zdcpaPYtYEwSo56+MzJ+ZFs=;
        b=nzCTjk/WTGmmxNxA/H2Cm1aSINgVwKRL8P40cMXfECaWzeOSAETe1qT50eksA8E/7M
         d6GjSn2pnegk1NyifuP79dQ9dC84a8nmHM4syOqSu8g2d0cBsI9pyKnyp9aAHhpNWDgl
         SI5Sw4lRrTbSnV6BRVaNrD9l0O94eJvI9K0GDjWRZmWyg2PtbD4PFVnNrS+SC3zVHxiW
         ZZ9EZXoe4IZ+toL1KWsOxuyDqnbxAMygRUUttkQTKU0AyzcXRMRCFCeRdACmmtUKb8GO
         0kw84WtHRP2nsNgF9//Ikrxe0/kAALjzDPNwSPDsWSh+XO5iP74e7dP5Gs+/reJiePmq
         WfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyRv3rP13OdLMBv8QRB7zdcpaPYtYEwSo56+MzJ+ZFs=;
        b=JU6x16gWdnIYVfZtA+kUg6dKqxPXKSpi+SrrMHX+8AclQXoUUjavaUitsUCk7Gl91S
         5Vvjju/Aj3VIZjwe7lzrNqpdzS3TylOxWahE2lsACZfAbJzV0VJJSPcTgjRytHcZjxXH
         5oGcvWJCzJk/T5O6M8VmY2I8/0GVZjp2sIu4ke+hBz7mKBlQPL4zgXZ8QpE41RRN+5cg
         tfyJw/YYrBJ6cXkfLr93OhCKzkNE0yBkriXZTpU7jiiByBidrDkIjBWq3FERuUtw9d8L
         r9yPvygUVh9qvrrBvA+Xtcu+2mh1qIeK1HeLQqqoC4brsgWL0/7EzCFSq1fKJuffBBJ1
         srCg==
X-Gm-Message-State: ANhLgQ1/12gYW080ex/52Y7YpE5tetnQUxmNGNC0VU2kv06RFxK5Iz2u
        GGop9+hUG2KLiEHVbyOU8WtwbodhUIZOzE0lPPb2Ng==
X-Google-Smtp-Source: ADFU+vsgVj8VybU7JzyAy1YYrvaI4EJLEym/9TXDcM5ONy7z6Htgah/Qv4dB39epUio4ehFI0vqfFJqCDsnVlUdEerI=
X-Received: by 2002:aca:c695:: with SMTP id w143mr2824247oif.98.1584631513703;
 Thu, 19 Mar 2020 08:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
 <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com> <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
In-Reply-To: <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 19 Mar 2020 15:25:02 +0000
Message-ID: <CAFEAcA-gdwi=KSW6LqVdEJWSo9VEL5abYQs9LoHd4mKE_-h=Aw@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To:     Linus Walleij <linus.walleij@linaro.org>
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

On Thu, 19 Mar 2020 at 15:13, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Mar 17, 2020 at 12:58 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > What in particular does this personality setting affect?
> > My copy of the personality(2) manpage just says:
> >
> >        PER_LINUX32 (since Linux 2.2)
> >               [To be documented.]
> >
> > which isn't very informative.
>
> It's not a POSIX thing (not part of the Single Unix Specification)
> so as with most Linux things it has some fuzzy semantics
> defined by the community...
>
> I usually just go to the source.

If we're going to decide that this is the way to say
"give me 32-bit semantics" we need to actually document
that and define in at least broad terms what we mean
by it, so that when new things are added that might or
might not check against the setting there is a reference
defining whether they should or not, and so that
userspace knows what it's opting into by setting the flag.
The kernel loves undocumented APIs but userspace
consumers of them are not so enamoured :-)

As a concrete example, should "give me 32-bit semantics
via PER_LINUX32" mean "mmap should always return addresses
within 4GB" ? That would seem like it would make sense --
but on the other hand it would make it absolutely unusable
for QEMU's purposes, because we want to be able to
do full 64-bit mmap() for our own internal allocations.
(This is a specific example of the general case that
I'm dubious about having this be a process-wide switch,
because QEMU is a single process which sometimes
makes syscalls on its own behalf and sometimes makes
syscalls on behalf of the guest program it is emulating.
We want 32-bit semantics for the latter but if we
also get them for the former then there might be
unintended side effects.)

> I would not be surprised if running say i586 on x86_64
> has the same problem, just that noone has reported
> it yet. But what do I know. If they have the same problem
> they can use the same solution. Hm QEMU supports
> emulating i586 or even i386 ... maybe you could test?

Native i586 code on x86-64 should be fine, because it
will be using the compat syscalls, which ext4 already
ensures get the 32-bit sized hash (see hash2pos() and
friends).

thanks
-- PMM
