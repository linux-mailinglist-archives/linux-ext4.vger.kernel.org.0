Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684F9191BD5
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Mar 2020 22:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgCXVSA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Mar 2020 17:18:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33051 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgCXVSA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Mar 2020 17:18:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id c20so54724lfb.0
        for <linux-ext4@vger.kernel.org>; Tue, 24 Mar 2020 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFWhs7FYWqUzfSLp89dUr9RqAyDvvxrGjpfFY3Xf6t0=;
        b=r/73bErWdHQvuSdWJNWD31sFM6sBzEI3plO5Ph0mnhTsKRC3h1QN3i7Fz3eKj47Yan
         BwWMNi7sdz1VngrNfJgVhs4otMGlVbKrH5Ojtg4qQyZl6c5KNhEt2puHDbfeP7zS1g9z
         9sb9L8shr//a5jX0W9biM5R/XFXVss0aK7nJnFNfhT69yuJ3vEp20yhHEiPfGub2S0l3
         eAM6WE6onEd3buLeks9BWIX5O3wweUSmc37Ts60F6+qNm0gZUEZMEVw0o0nixNUSAlOc
         geZpCA4tpuURui/rTdFdYUk8MNAkScEJxAEUfyVK4GkLj/8d6IGrDaMTou75bMHoukIi
         C9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFWhs7FYWqUzfSLp89dUr9RqAyDvvxrGjpfFY3Xf6t0=;
        b=cTMsKWdxYrLh1U+K0ZqUmXGQc8Is5qNjIjj3zbutEsRhvfk/sePGx62iqZky8WESGS
         JuyYW/PHkv+54wsagf5C4klNbAMffKtKBsySu2xdo3s/pqOe7v9bbbc+hkFYlGLrsClp
         d42rdVKnK7MiMCOHzffHEGqzbzLO03itKnRkXVX/y0Rl4QbZggbRhwaM5ijXVXsHvWwN
         bG8GoupwDGzcHgSwUVcMLce3CQHBprfPFwqBEv6KQ+eWoG+mwCO4MljyMjIWCscmPJ2J
         zUJroXRrbLynjFCzigX9uD12BRKOHrrzupLKfYxAmZcydRVTR+X/03KyMOBkrJxfMjOU
         gNsg==
X-Gm-Message-State: ANhLgQ1ypQ19H2rK+aQ8rqMPVc6nYuj8PzCNLYsyG9lvc4+93ZgYAseq
        cln6y6ygCd4MfT8mq2d4NxxBAVhwFzj5YOT7VC/hsw==
X-Google-Smtp-Source: ADFU+vu/WFfI8+Ea0qixkispTE8M2IBdFmk3vOeBjdzg2fpI2YVxUN1mkgIfe3Rc2yqBnwLXF8WOfkInLMcS8iGWzNs=
X-Received: by 2002:a19:6502:: with SMTP id z2mr23818lfb.47.1585084677811;
 Tue, 24 Mar 2020 14:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
 <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
 <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
 <CAFEAcA-gdwi=KSW6LqVdEJWSo9VEL5abYQs9LoHd4mKE_-h=Aw@mail.gmail.com>
 <CACRpkdYuZgZUznVxt1AHCSJa_GAXy8N0SduE5OrjDnE1s_L7Zg@mail.gmail.com>
 <20200324023431.GD53396@mit.edu> <CAFEAcA_6RY1XFVNJCo5=tTkv2GQpXZRqh_Zz4dYadq-8MJZgTQ@mail.gmail.com>
 <20200324184754.GG53396@mit.edu>
In-Reply-To: <20200324184754.GG53396@mit.edu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Mar 2020 22:17:46 +0100
Message-ID: <CACRpkdapsgkNbNNGz12tBQKh8GKgcUuwgLywM7CMghr94C-Fsg@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Peter Maydell <peter.maydell@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
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

On Tue, Mar 24, 2020 at 7:48 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Tue, Mar 24, 2020 at 09:29:58AM +0000, Peter Maydell wrote:
> >
> > On the contrary, that would be a much better interface for QEMU.
> > We always know when we're doing an open-syscall on behalf
> > of the guest, and it would be trivial to make the fcntl() call then.
> > That would ensure that we don't accidentally get the
> > '32-bit semantics' on file descriptors QEMU opens for its own
> > purposes, and wouldn't leave us open to the risk in future that
> > setting the PER_LINUX32 flag for all of QEMU causes
> > unexpected extra behaviour in future kernels that would be correct
> > for the guest binary but wrong/broken for QEMU's own internals.
>
> If using a flag set by fcntl is better for qemu, then by all means
> let's go with that instead of using a personality flag/number.
>
> Linus, do you have what you need to do a respin of the patch?

Absolutely, I'm a bit occupied this week but I will try to get to it
early next week!

Thanks a lot for the directions here, it's highly valuable.

Yours,
Linus Walleij
