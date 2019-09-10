Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA8AE934
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2019 13:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfIJLdc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Sep 2019 07:33:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43294 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbfIJLdc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Sep 2019 07:33:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id d5so16047386lja.10
        for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2019 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/87kLUWhA8VGKwQ9ReDVfft5SDHkATRiA6uskomi3Do=;
        b=VPec9JRv8Tfx9xEc4r84woloylMuGNHPDiClO6km+SMR4SlGOn2EWxH8paATQU4SYk
         EdX0wUykyyflt8+WFj/VGKXZi/CVm+7AEyvwhPWJkWLBihBks9G66wETZBSNT1pzq08G
         a35JZGXi1OKWxuE5XkZCOuOYghEjdjQryubYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/87kLUWhA8VGKwQ9ReDVfft5SDHkATRiA6uskomi3Do=;
        b=bzJguR5+2mWZ7tg7Of5Q4qhIjiqIk0xqmfbpSTCsju2p4EqeP8cYQ0qGZuajsQL1Gr
         TF9DVJQTW3ZEyRJhfccQmY5juJgBfN/ZlD43y8I2ZLUI+CdVDOEBHtha3dxPE1/HupJ9
         wrAJhgf9lrtnlr50qolU/yFGJ1nE5MWNV+/fXAjEyVmmuz4eZp693+HgjhcTDf4HVKo9
         XXsC8MS7HhYmS4GF75A2Fb6lQyfKV7JiBpbKPdmGBY6VgnkYTFYxw3ZW2Mwg7pbi9k0k
         BAPf0JoJ+KU31AIGAo4fTMrFpSuTpEOd0sl+eCYQ91aZgoW55u59zo6kctnTF/ZrbK9G
         lpfw==
X-Gm-Message-State: APjAAAWLG7C79FeqazrBiE8NkCunU4uejtaEX+UQZ4cgej8BpF7Ozqx4
        Nj3NiRXO1/9mzjkTkwgdIYC4DLECv3ZtXg==
X-Google-Smtp-Source: APXvYqxszH7hz0Hr38fm/MEjo+S1ejDXzqg5Z23iFovu5SPMdpFE/Yvbf0zMeUOBBdp/xxcL0l/FSA==
X-Received: by 2002:a2e:8611:: with SMTP id a17mr15767865lji.130.1568115209723;
        Tue, 10 Sep 2019 04:33:29 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id d8sm3775371ljj.59.2019.09.10.04.33.28
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 04:33:28 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id a22so16090537ljd.0
        for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2019 04:33:28 -0700 (PDT)
X-Received: by 2002:a2e:3c14:: with SMTP id j20mr18756186lja.84.1568115208066;
 Tue, 10 Sep 2019 04:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc>
In-Reply-To: <20190910042107.GA1517@darwi-home-pc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Sep 2019 12:33:12 +0100
X-Gmail-Original-Message-ID: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
Message-ID: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, zhangjs <zachary@baishancloud.com>,
        linux-ext4@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 10, 2019 at 5:21 AM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> The commit b03755ad6f33 (ext4: make __ext4_get_inode_loc plug), [1]
> which was merged in v5.3-rc1, *always* leads to a blocked boot on my
> system due to low entropy.

Exactly what is it that blocks on entropy? Nobody should do that
during boot, because on some systems entropy is really really low
(think flash memory with polling IO etc).

That said, I would have expected that any PC gets plenty of entropy.
Are you sure it's entropy that is blocking, and not perhaps some odd
"forgot to unplug" situation?

> Can this even be considered a user-space breakage? I'm honestly not
> sure. On my modern RDRAND-capable x86, just running rng-tools rngd(8)
> early-on fixes the problem. I'm not sure about the status of older
> CPUs though.

It's definitely breakage, although rather odd. I would have expected
us to have other sources of entropy than just the disk. Did we stop
doing low bits of TSC from timer interrupts etc?

Ted, either way - ext4 IO patterns or random number entropy - this is
your code. Comments?

                 Linus
