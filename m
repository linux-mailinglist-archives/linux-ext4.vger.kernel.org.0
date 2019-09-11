Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E74B024B
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Sep 2019 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfIKRAk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Sep 2019 13:00:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33359 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfIKRAk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Sep 2019 13:00:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so20738782ljd.0
        for <linux-ext4@vger.kernel.org>; Wed, 11 Sep 2019 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hI3EB/9BDPeGlAj5JSZDGYA2f1JCFRdoSzkNrQAXirE=;
        b=CGKf9ffZA0sDKRiYz4VTL4pJ6O/i9q/3SuKL2cMKY0lYCwrIgBzzQc9qpL02hJUCVf
         zhRFfXilE/dIFAK6zLlsU05aZBlAW8SlX2gIrBCON7ulaV9IINxTNXZGi6/Lfghu5RUo
         Ttenh548bV73virB1och/bEQUdMXAWdJlPKp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hI3EB/9BDPeGlAj5JSZDGYA2f1JCFRdoSzkNrQAXirE=;
        b=VTzcB6Fli2i7mfwurvf6geOBzBDDuzWg0gtsrtJIpWSjYzLMOgBJ+OxlFR53TL8Ng+
         JicnOb5Ps4dUDfuBQbrZYFafSuAmvT5wu91rlexT5vzy8YNxV2w12U+c+fSyNQrlm4Pw
         guRV34Mng+gad9hW/Ok997qlGokhRyC3wL/qc4aiWP7uMFbqcoyRjb8Ij2VpYZ8l9+kk
         wHiBNCktUE7YiJ37YgCKzTfyK3ZPmGjxsw+dk8+EEReqPs7+H94U5UxUlw2oUoNjGPZ7
         G9vttlqTyPsGQ+70PM3e+og821m/oNo8RqEdo2hsEhTUR+l23ZojvtAj0MDVTuEYG+oV
         49Nw==
X-Gm-Message-State: APjAAAWyhAu581n66FrmfvTVIvrgSBgJYgUG4AlSVDgGDWYehG0TeAwj
        iguUzwpIXgSb8nfnWOnCP5DY5cn+M9SqXg==
X-Google-Smtp-Source: APXvYqyQKDD0VXDh6jRytqK4x81Vx3r3/ESmbL+t00hNLDqcSfuD9e8fAa0E6QtaVRVkxfcetYPyIw==
X-Received: by 2002:a2e:654a:: with SMTP id z71mr24080001ljb.37.1568221237193;
        Wed, 11 Sep 2019 10:00:37 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id f15sm5244872lfc.30.2019.09.11.10.00.36
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 10:00:36 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id q22so16125409ljj.2
        for <linux-ext4@vger.kernel.org>; Wed, 11 Sep 2019 10:00:36 -0700 (PDT)
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr16107533ljo.180.1568221235850;
 Wed, 11 Sep 2019 10:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc> <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc> <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
In-Reply-To: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Sep 2019 18:00:19 +0100
X-Gmail-Original-Message-ID: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
Message-ID: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
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

On Wed, Sep 11, 2019 at 5:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'd be inclined to either lower the limit regardless - and perhaps
> make the "user space asked for randomness much too early" be a big
> *warning* instead of being a basically fatal hung machine?

Hmm. Just testing - normally I run my laptop with TRUST_CPU enabled,
so I never see this any more, but warning (rather than waiting) is
what we still do for the kernel.

And I see

    [    0.231255] random: get_random_bytes called from
start_kernel+0x323/0x4f5 with crng_init=0

and that's this code:

        add_latent_entropy();
        add_device_randomness(command_line, strlen(command_line));
        boot_init_stack_canary();

in particular, it's the boot_init_stack_canary() thing that asks for a
random number for the canary.

I don't actually see the 'crng init done' until much much later:

    [   21.741125] random: crng init done

but part of that may be that my early boot is slow due to having an
encrypted disk and so the bootup ends up waiting for me to type the
passphrase.

But this does show that

 (a) we have the same issue in the kernel, and we don't block there

 (b) initializing the crng really can be a timing problem

The interrupt thing is only going to get worse as disks turn into
ssd's and some of them end up using polling rather than interrupts..
So we're likely to see _fewer_ interrupts in the future, not more.

            Linus
