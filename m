Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9929DB33D0
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 05:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfIPD47 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 23:56:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38729 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbfIPD47 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 23:56:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id u28so5486083lfc.5
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 20:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/WJOiZU+ONLAF5VZ8QdOdt/8naAIMcee9SR9+Sx4feo=;
        b=CtTVmBweTrysJ5DoBdCUD/t7zNLy0x4eKmXubkXkdKS8+ArCc5ANYpzn9sH94OOKbs
         Jk5h0KuyermsSKSl+qKF7ca6CUOT9A6LKnCKJZbR4H18skYWhZHhR7XelAKdszwFd9Z2
         hKybKfniHYIfTwncY2S8j6sL+gJCjCg2rE644=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WJOiZU+ONLAF5VZ8QdOdt/8naAIMcee9SR9+Sx4feo=;
        b=jRi/kRihck9kNPuClzXi8X3Tq6M3jYNP+1GQxk/gaCPBF/SA5HwMzmpuud/Xyqv5Z8
         tno4B08nu7Mk7rImkB9H58nlx/wNVIg2N2lgsdyXyLRpgHuHeZ4UUmoPUBSwK6fYREiT
         2n9/kb6DYT3o4WRz9XsnJWoxKhNZ7lhqWfD0Ah1HnWtEnM035zIoH/l6LZ3mW1G8JUxi
         mUu2Xkke62O1UQYQlJJTmJ5yj0zTMXmx2Rzz6z88Sd8J0cF/0tLuU1ykLdBcxCpU2mC8
         aMnBvra4tiTZjQk8gcZ9/dUwWLtARL3fdMZZXLRvNWG2Q+ebnFTLo2qSc3wIkvtE0Ogr
         Xlhg==
X-Gm-Message-State: APjAAAXbx9KgfiT3fd1zhkAeA/t6K2fvsp8CYTk3KFGmund2p2jta6N1
        uEBomMPI2pjDyme9A9V2PVia5LIR9/0=
X-Google-Smtp-Source: APXvYqw3moiWf2PLLXNHsH2EByg7wZs7UQKWsmyZV5+oKoJFEbkCzQjTtL18ih8rMEaZhVFs0o0BIA==
X-Received: by 2002:ac2:51ce:: with SMTP id u14mr34448951lfm.72.1568606216975;
        Sun, 15 Sep 2019 20:56:56 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e21sm8680440lfj.10.2019.09.15.20.56.55
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 20:56:56 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 7so32280898ljw.7
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 20:56:55 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr5154441ljs.156.1568606215653;
 Sun, 15 Sep 2019 20:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com> <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login> <CAHk-=wi8wAP4P33KO6hU3D386Oupr=ZL4Or6Gw+1zDFjvz+MKA@mail.gmail.com>
 <20190916032327.GB22035@mit.edu> <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
In-Reply-To: <CAHk-=wjM3aEiX-s3e8PnUjkiTzkF712vOfeJPoFDCVTJ+Pp+XA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 20:56:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPDR6_crhmvaoXDo8q6Joz5rD02bZpd2x9rr-LazPxRA@mail.gmail.com>
Message-ID: <CAHk-=wjPDR6_crhmvaoXDo8q6Joz5rD02bZpd2x9rr-LazPxRA@mail.gmail.com>
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

On Sun, Sep 15, 2019 at 8:40 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you want secure keys, you can't rely on a blocking model, because
> it ends up not working. Blocking leads to problems.

Side note: I'd argue that (despite my earlier mis-understanding) the
only really valid use of "block until there is entropy" is the
systemd-random-seed model that blocks not because it wants a secure
key, but blocks because it wants to save the (now properly) random
seed for later.

So apologies to Lennart - he was very much right, and I mis-understood
Ahmed's bug report. Systemd was blameless, and blocked correctly.

While blocking for actual random keys was the usual bug, just for that
silly and pointless MIT cookie that doesn't even need the secure
randomness.

But because the getrandom() interface was mis-designed (and only
_looks_ like a more convenient interface for /dev/urandom, without
being one), the MIT cookie code got the blocking whether it wanted to
or not.

Just say no to blocking for key data.

            Linus
