Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FD65388EA
	for <lists+linux-ext4@lfdr.de>; Tue, 31 May 2022 00:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiE3W1r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 May 2022 18:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243298AbiE3W1o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 May 2022 18:27:44 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95242443E4
        for <linux-ext4@vger.kernel.org>; Mon, 30 May 2022 15:27:42 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e93bbb54f9so15946843fac.12
        for <linux-ext4@vger.kernel.org>; Mon, 30 May 2022 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WD4VQ+NgwBnKN85w6k7WNytbDRjxaD1PpngEWX1Y+qM=;
        b=EbwBIROAuGnSTHJcQsvx2mreAHyHkQI1gKxrzLp53LlOEsHCCX9MwobealLPfPbo9p
         8Ypd/Pu+NjIvYReaLpAENEXqfU9kufzXEUhFGKbDbxpjwabU5rhj8cO3W8IR9JAC6d82
         1+X8/T1Dl+Kc05YBM0EWPGCFQ6CNXBIKHj5UcO+XyjAwzlSUIg2/SWR1OGB86CoQlnEj
         zscZWjAemOY3h4MuNbBwnk153XR502ZeIrn7DW7BymnZ5+sr4zNmRFEKZK3Up9AtY3r7
         RJUhL0UhrnzWwLaieZjyWRQ0bR3fqZsZU6qQAg5rW+qjmIvRDICiqWgjRqgTXndj0JUH
         SkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WD4VQ+NgwBnKN85w6k7WNytbDRjxaD1PpngEWX1Y+qM=;
        b=mwaCBmswRaduZu1LbW/m1y5ycYR0Fe/zOKCWpTRuCnk4+M9F1yrj4ltlYY85zrrPBO
         /Ai0NpZrCr94vlb0irmRjeFakUJ+I11EBANcFb+YPJVZybCr5YnQBRlCOmXxVyg+gHXP
         T+LssfvmWEYUOgrPOxycFCsyqjerbj3XWwz4O/u5KGPToyp20yX+KZ2LZAIKU5QkZ5Wi
         LwrgJdZMcKlYIoDB1eMWDQjN6DnE5O5OHGIujLV5C/DLycxxsWo3osHA+Yw8amie1ole
         KnlmUAWVH9H84FSdJZlC7xD0w33ffDEriBqW+8Pldm/uROwI881ABeWWSYolUtQlvLFp
         T60w==
X-Gm-Message-State: AOAM531SDRnq8owPrviQnaHgqH1HPaJI4N3F0bJsjzJb5hdjx2mIA1WG
        uWPLwzDUNMjiAiO6ZK9xUZ4eg5XhO1ZeHzmx069roKcrbEE=
X-Google-Smtp-Source: ABdhPJywFP5/TlAab0ABTgMXO3fIs+mv7HZ4/d0pxE+VLud0DuhEDF6lb+2Hk+Ln1/nclePVZiTSC6H4wauGEz4svxs=
X-Received: by 2002:a05:6870:79a:b0:e9:109a:1391 with SMTP id
 en26-20020a056870079a00b000e9109a1391mr11442592oab.105.1653949660944; Mon, 30
 May 2022 15:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDdnB38yRcZ+mQButh9UwGoh928xsZCgmjQ7r3HPEpEwdrZbg@mail.gmail.com>
 <87sfor85j1.fsf@collabora.com>
In-Reply-To: <87sfor85j1.fsf@collabora.com>
From:   "Stephen E. Baker" <baker.stephen.e@gmail.com>
Date:   Mon, 30 May 2022 18:27:29 -0400
Message-ID: <CAFDdnB3U67YJ7pivdHQaMB-CkdmvvTbcpxp1FXxBmFyAgJPknw@mail.gmail.com>
Subject: Re: simplify ext4_sb_read_encoding regression
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 30, 2022 at 10:21 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> "Stephen E. Baker" <baker.stephen.e@gmail.com> writes:
>
> > Hello,
> >
> > I have a Samsung Chromebook Plus (rk3399-gru-kevin) which boots linux
> > off an external ssd plugged into USB. The root filesystem is ext4 with
> > unicode support, case folding is enabled only on some directories in
> > my home directory.
> >
> > Since 5.17 the system has been unbootable. I ran a git bisect and it
> > pointed to aa8bf298a96acaaaa3af07d09cf7ffeb9798e48a ext4: simplify
> > ext4_sb_read_encoding
>
> Hi Stephen,
>
> This series moved the UTF-8 data tables to a kernel module; before it,
> the module had to be built-in.
>
> Since you have your rootfs as a case-insensitive filesystem, either the
> utf8data module needs to be available in the initramfs or unicode
> needs to be built-in.  Are you building your own kernel?
>
> Can you confirm that utf8data.ko exists in your initramfs, and
> regenerate it if missing?  Alternatively, make sure that you have
> CONFIG_UNICODE=y in your kernel configuration file.
>
Thanks Gabriel, I've verified that CONFIG_UNICODE=y, as well as
CONFIG_UNICODE_UTF8_DATA which exists in this patch for that
purpose, though it was removed earlier.

> If that doesn't work, can you provide the kernel log?  If you can't
> collect the console output, a photo of the screen displaying the error
> will suffice.
>
I don't have any output to provide unfortunately. It fails before the
backlight turns on, and nothing is written to disk. I seem to remember
that someone else at Collabora had figured out a way to get a serial
console on this device - perhaps Tomeu. I'm not equipped for that
personally, particularly if it involves soldering.

>
> Thank you!
>
> --
> Gabriel Krisman Bertazi
