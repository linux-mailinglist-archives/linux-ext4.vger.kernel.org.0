Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B0712E3A1
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jan 2020 09:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgABIIH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jan 2020 03:08:07 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:39116 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgABIIG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jan 2020 03:08:06 -0500
Received: by mail-il1-f181.google.com with SMTP id x5so33509795ila.6;
        Thu, 02 Jan 2020 00:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVWIK2jrMiZ2hqvmNKsLEYjxusYcMZUIWglnH8mawmI=;
        b=j53lP8fYSXf6aYyvL8iSrfUXk6I+ezIkYkyE0UIKOolUYwvKxBBc/Rqdzfo3eC7k4z
         dSuefjzRjvD/K7sZb7YKtEf6e/9dmKwHE55Di0u5iX2Pg7AGUVNIWZZgNGDfTFI7daX9
         Rw3EgfnZ84GYByb1kas9jxv9TTmvu0AOY/3sQrZUTFBhY4TFJbQrnakyhOZtcowv5N2M
         f+M/G0/bA1WVEakSPkizvSu6tA5emb0MKnCZujsOjSoJ1rDSXTVYXct5triPeu58tP/R
         WqXgrcfPwzSNddWwk+4ZWIqruHXx+hYJeSO46I/qbq5Li7dk8t4MsucmbDMfEGQ0aYTz
         XJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVWIK2jrMiZ2hqvmNKsLEYjxusYcMZUIWglnH8mawmI=;
        b=earc/IoVMa/aXm5IbXfsrfRpUE4SI8aY/RxXNiAjjs6Omqkor+f++XjtjNxWUN4G30
         72SdjPkrfUVof/6TXlB/sqvWKwrshOf3450ESz2FZcXkFCODQ5/4biIk8MHd1HG0G3ZC
         DdU7CaHvq+cIXP6JUMxC9yECFeVBJv41HFE8QY6bCyjv94Y3yeu+ux3sNsWtCGBm12LN
         GFnw7iSg8E3G0wuwwN/6MGhryPf2grJtQX1ZY1kbeaYkJGu830T10d8i/XI9y+n/u+YZ
         cdX0602rUr7CveD65Q9q/j3KdoO6cw4FzeG9D8BIuUFCCAAhSz7tZZqXTzlFGhDb/Up9
         iEng==
X-Gm-Message-State: APjAAAVfwYB+vuuY2Wq9ULuF1reZ5VunLZG/twfDxp7wSv/LqBsSLoLv
        DVNC3o0VIA0J7Zz5PFnWNvsSEwRJm2FLjUuvbEZA4jh3rMc=
X-Google-Smtp-Source: APXvYqzKuZiS9hk42zQxj9hP2CNvgmA370dl7wlPLbY+cNy5FeliLUy30NYH16xo1anCR1oDk2U/qlc0asfcH2ZeTvE=
X-Received: by 2002:a92:3984:: with SMTP id h4mr65496279ilf.36.1577952485668;
 Thu, 02 Jan 2020 00:08:05 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsODr3tMpQxJ_nhWQQg5WGakFt4Yu5B8ev6ErOkc+zv9kA@mail.gmail.com>
 <20200101141748.GA191637@mit.edu> <CABXGCsOv26W6aqB5WPMe-mEynmwy55DTfTeL5Dg9vRq6+Y6WvA@mail.gmail.com>
In-Reply-To: <CABXGCsOv26W6aqB5WPMe-mEynmwy55DTfTeL5Dg9vRq6+Y6WvA@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 2 Jan 2020 13:08:41 +0500
Message-ID: <CABXGCsNkzPrjqMRaWpssorxzhMLWBvLeSw9BpKYr_DW4LJQECQ@mail.gmail.com>
Subject: [bugreport] "hwclock -w" reset time instead of setting the right time
To:     util-linux@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"hwclock -w" reset time instead of setting the right time on M/B "ROG
Strix X570-I Gaming"
Demonstration: https://youtu.be/QRB7ZLiEfrc
Some DE like GNOME has automatic time synchronization option and there
is a feeling that hardware time reset after each Linux boot.

--
Best Regards,
Mike Gavrilov.
On Thu, 2 Jan 2020 at 04:19, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Wed, 1 Jan 2020 at 19:17, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > The problem is casued by the fact that the mount time is incorrect,
> > which indicates that the system time was incorrect at the time when
> > the file system was mounted and when it fsck was run.  Since the last
> > write time was in the future, this triggered "time is insane" check.
> >
> > This is inconsistent with your report that started happening when you
> > switched to a new motherboard.  That's because the real time clock is
> > not reporting the correct time when the system is booted.  Later on,
> > in the boot cycle, after the root file system is checked and remounted
> > read-write, the system time is getting set from an internet time
> > server.  This then causes the last write time to be ahead of the last
> > mount time, and "in the future" with respect to the real time clock.
> >
> > Normally, the hardware clock's time gets set to match system time when
> > it is set from network time, or when the system is getting shut down
> > cleanly, but your init scripts aren't doing this properly --- or you
> > normally shut down your system by just flipping the power switch, and
> > not letting the shutdown sequence run correctly.  The other possibilty
> > is the real time clock on your system is just completly busted
> > (although normally when that happens, the last mount time would be in
> > the 1970's.)
> >
> > Running "/sbin/hwclock -w" as root may fix things; as is figuring out
> > why this isn't run automatically by your boot scripts.  Another
> > workaround is to add to /etc/e2fsck.conf the following:
> >
> > [options]
> >         broken_system_lock = true
> >
> > This will disable e2fsck's time checks.
> >
>
> Thank you very much for the tip, I would never have guessed that the
> cause of this issue in hwclock.
> I started to watch hwclock through the motherboard BIOS and found that
> hwclock resets every time after booting Linux.
> Demonstration: https://youtu.be/TBrLNFbBaPo
> Apparently for this reason, "hwclock -w" did not help me, workaround
> with "broken_system_clock = true" is working, but I would like to fix
> the root of the cause.
> Who can help with this?
>
