Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539B3215438
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jul 2020 10:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgGFIy7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jul 2020 04:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgGFIy6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Jul 2020 04:54:58 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201DAC08C5E0
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jul 2020 01:54:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so40738612ljp.6
        for <linux-ext4@vger.kernel.org>; Mon, 06 Jul 2020 01:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNNvIPbyRDyhu5ZgEEiWbAIxYQhb/2gTkX3OL9Va+WQ=;
        b=GwK48GhmFmirpg3fdswa9lBUePOmYDIUGRR8hdVDdkSej4xaxCeCZAFSNgxfHMX6Yy
         w9Kla9Zz94g96jzu2SdkDHlz3/g7x+cSsfL0CLrYgCZP6J19zRAdLsZs87JfMO7sIJE6
         hD8DhDJnDAm0DcZzdnRoijixEc6U2wSUxDKr/PyrnIZ6sDA3NJltPdTHsLduPer5Awad
         NUwH5K/XHmbz5gpeAqR5kYWsh2PSuS+J5l9UTHxPSnjzSl1GyAg/pMTCqSfzmJ/+quNd
         zVd7EeWl6Jy5ia0GEmuuMG516H4zo1kh4cHrXJacH0rZz+cmV3uWqvNIF5fVl3UCZoOV
         qcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNNvIPbyRDyhu5ZgEEiWbAIxYQhb/2gTkX3OL9Va+WQ=;
        b=mL+H8Pu/bfr3T/IvT9zho9xlEAEhc10Eoebc1o+WLOa2vLFg1TK7iKhp9EtTGxZa1d
         KQZarqZdScJ2B0akiMOwV32N66RSgImOWZWnjYq7pWG/N695KtlZzgXSlpNvVfs1vY+G
         J/sv1Sh9AN149VUGpAvFcAGfegM38SDsANlhf0d6y65b+PJj9TYdXbjfKZ6D7diD16sI
         ntmyRplCqCB7kbYd1TN8gwZ1j/0Lil6Z9Oj2aAqvrxPbM20C0nE/ZbWRhm+ocZMmiSps
         4eeYDYLWcc/lifRZ/qPTEgXoJiYaY8FmCtuFKb8i6S5HucT6FdALHQ+yihcUuGEz8yMH
         AlPw==
X-Gm-Message-State: AOAM533hxHb6rI+rrmbR3V4Ag4v6n2XQetzU6hCY0iuHZMUx5FygmPQ6
        VXKhC9Bdz2ad3A+Z8R3tCAK3t/K0BCVmXUNbkDUfEQ==
X-Google-Smtp-Source: ABdhPJylBq/GlipYoQiOaeWdyv7Nd1mhikRAHRzoHcrBYF2Tgt2xn3B345Rezd2yDNMo2CkzdbSQ8juxx+Oe1fm99VA=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr10720535ljc.104.1594025696518;
 Mon, 06 Jul 2020 01:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200529072017.2906-1-linus.walleij@linaro.org> <CAFEAcA-x0y6ufRXebckRdGSLOBzbdBsk=uw+foK4p+HDeVrA9A@mail.gmail.com>
In-Reply-To: <CAFEAcA-x0y6ufRXebckRdGSLOBzbdBsk=uw+foK4p+HDeVrA9A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Jul 2020 10:54:45 +0200
Message-ID: <CACRpkdZk-Pv49PyhtrW7ZQo+iebOapVb7L2T_cxh0SpYtcv5Xw@mail.gmail.com>
Subject: Re: [PATCH v2] fcntl: Add 32bit filesystem mode
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 23, 2020 at 12:08 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Fri, 29 May 2020 at 08:22, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > It was brought to my attention that this bug from 2018 was
> > still unresolved: 32 bit emulators like QEMU were given
> > 64 bit hashes when running 32 bit emulation on 64 bit systems.
> >
> > This adds a flag to the fcntl() F_GETFD and F_SETFD operations
> > to set the underlying filesystem into 32bit mode even if the
> > file handle was opened using 64bit mode without the compat
> > syscalls.
>
> I somewhat belatedly got round to updating my QEMU patch
> that uses this new fcntl() flag to fix the bug. Sorry for
> the delay getting round to this. You can find the QEMU patch here:
> https://patchew.org/QEMU/20200623100101.6041-1-peter.maydell@linaro.org/
> (it's an RFC because obviously we won't put it into QEMU until
> the kernel side has gone upstream and the API is final.)
>
> What's the next step for moving this forward?

Ted, can you merge this patch?

It seems QEMU is happy and AFICT it uses the approach you want :)

Yours,
Linus Walleij
