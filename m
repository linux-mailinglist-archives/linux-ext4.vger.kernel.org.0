Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAC852DEE7
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 23:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbiESVCA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 17:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244973AbiESVB7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 17:01:59 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5E5BD2E
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 14:01:57 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p139so11052855ybc.11
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nvfi/FkkRcQOxttlT1W4tUjOf5gCrt+pDxGf3qnwTek=;
        b=vqMlLof0fuiWzd248UraP76doOdIz5iCAKkORAsgESDI3ML/Yh+wuv4bh22lKGaWte
         VJFD8xu1QY90x8A2JxAEAor2S50Z8OIHycFD/5MIm9ijiVcMy/gn9zlO3hA2bkHfdD/o
         3UEx1e3vIVFEyHqMJEJoewgdkOmewkYmX+OwXt+6B+/6VoaEfEMQwaXFoGN6Oa1xOgz3
         344DT/L6UHbLY5AzfrKJUtUOr9RU6zjIDb5n6HwHv1f8V5loo6sPSBm8bSeO3ioUxA3s
         o9+lXNGnjYBNyZWEhxcAjfxsZbuR+EE4ukIs9OR7RPpRCUv1JkM/pB+p5aW2hctxX0ph
         zqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nvfi/FkkRcQOxttlT1W4tUjOf5gCrt+pDxGf3qnwTek=;
        b=hwGqtwKx/ZG0b9fh2JARKvtPoi7OqtsQNEmGIlodve+63J5KtJsqjNy9Np/x2O8yKL
         ELEbQahOi/ivO7/gMBXBTVeuoOmzOlT71k4PgGvY3Qv6rnbS1E2eiSY3CK7FINIlYU/H
         J1b7wI+Q9Lrua15D2SQo+Esa9GXy45Vx8QA8ulqeydJs7OlST80cz3GXoNCfK30yTiD4
         xI6ns0zqOgyoUEtJQ/BuzaOyOzSN3I6WmUd+YgOwysap0/MjVeVHxI1V0VGpXCYb50GH
         L35q30PQewIT2UUp0wSTLVNSUSoFoRgzeRdQGtl0gCMBVE4UWJefjdx6VHLg893wbFAJ
         NTGw==
X-Gm-Message-State: AOAM533huAjVjFZJ427AjnIm16ZtryqFgKsfOZMEDtqRt2bfBFcVoxlb
        Beb4enuffVS+NUpyqensfYFRicxMlnuwtRYDZGDzsQ==
X-Google-Smtp-Source: ABdhPJzNR4Wrf4wpzc22TgZlDNFOvKX8B13v65Sh0nJdkJ3ys3ADKjrd+O0tl1MT1zi4j+gQah1jkYknq+wLogmQE2A=
X-Received: by 2002:a5b:302:0:b0:64b:a20a:fcd9 with SMTP id
 j2-20020a5b0302000000b0064ba20afcd9mr6226804ybp.492.1652994116812; Thu, 19
 May 2022 14:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201117233928.255671-1-linus.walleij@linaro.org> <b63c04ff68340d367ad4138f3496d217df9b5151.camel@icenowy.me>
In-Reply-To: <b63c04ff68340d367ad4138f3496d217df9b5151.camel@icenowy.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 May 2022 23:01:45 +0200
Message-ID: <CACRpkdar8MeG4vYx+xJ5fh9U3+6LfKdMrNzNzYmC-7YUK=pQYA@mail.gmail.com>
Subject: Re: [PATCH v4] fcntl: Add 32bit filesystem mode
To:     Icenowy Zheng <uwu@icenowy.me>, Chris Mason <clm@fb.clm>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eric Blake <eblake@redhat.com>,
        =?UTF-8?B?572X5YuH5Yia?= <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 19, 2022 at 4:23 PM Icenowy Zheng <uwu@icenowy.me> wrote:
> =E5=9C=A8 2020-11-18=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 00:39 +0100=EF=
=BC=8CLinus Walleij=E5=86=99=E9=81=93=EF=BC=9A

> > It was brought to my attention that this bug from 2018 was
> > still unresolved: 32 bit emulators like QEMU were given
> > 64 bit hashes when running 32 bit emulation on 64 bit systems.
>
> Sorry for replying such an old mail, but I found that using 32-bit file
> syscalls in 32-bit QEMU user on 64-bit hosts are still broken today,
> and google sent me here.

Yeah the bug was 2 years old when I started patching it and now it
is 4 years old...

> This mail does not get any reply according to linux-ext4 patchwork, so
> could I ping it?

I suppose, I think the patch is authored according to the maintainer
requirements, but I'm happy to revise and resend it if it no longer
applies.

Arnd and others suggested to maybe use F_SETFL instead:
https://lore.kernel.org/linux-fsdevel/CAK8P3a2SN2zeK=3Ddj01Br-m86rJmK8mOyH=
=3DgHAidwSPgKAEthVw@mail.gmail.com/

I am happy to do it either way by need to have some input from the
maintainer (Ted). Maybe someone else on the fsdevel list want to
chime in? Maybe any FS maintainer can actually apply this?

Yours,
Linus Walleij
