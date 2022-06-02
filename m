Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ABB53B185
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jun 2022 04:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiFBCGS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jun 2022 22:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiFBCGR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jun 2022 22:06:17 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25822E2757
        for <linux-ext4@vger.kernel.org>; Wed,  1 Jun 2022 19:06:16 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-f2bb84f9edso5049716fac.10
        for <linux-ext4@vger.kernel.org>; Wed, 01 Jun 2022 19:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofscGzSt/rOGc75JQamSRJX+pWAVfplRsnOQmqxQuNY=;
        b=jred40wDBvxtaBko/+wNrBxqydxoofWL56zUvbNimaXPhyrU6i0bkk4axP9s+KZnF3
         ATrsIo0HuWQwVEb9++2W9PymsMNZRfqeUTsmOFa4OtFi3Mmo5i5fpXzKZSTlvIqJuVim
         KWAfbMk+ms23ClNl5ppiJrZc61VCQ2ht7ojQezaOAgMfqSVfwc2YVPrVmY9WLBUU/hLX
         7ZPwdx12z/mIZHA2vkm6jfek9bBbQme9fKlWbGeVpaMB0jG3rBVFAvIyuUfAOdekGM/q
         BSQk2oCBVi5ZeTaDhreiD9NRrDO4Wn/IIlgJQ0pvV/yP22FCHcNw8nnL9nsEsMXhf75w
         vjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofscGzSt/rOGc75JQamSRJX+pWAVfplRsnOQmqxQuNY=;
        b=0wq65Lu+KTonqP9kBJI8kWUY4WLTJS6jgLqPUjqecO4OnmMLUhSutBa/vJqaYwb1cV
         P8nJo4WjKCeEDh8/uJcyNoZZinaNMwvmV+N/FIBDnlvweL+R4hNZ0blI+0X3Pf3dUbBN
         ilgd1LNdn8wbeMM2wDVgiKzzVqu/tgeMA6DzIxiowPHPw+R5+a337BroZFEkPZT7iOOa
         GPFeX6pVSdWT1HJkr+xwemz5FWTd0NVnDDh1PxLJlD1DYkeMc3b5xKrzJ23j3Fj6Ltb0
         hMMhVnLqkyz8vauJdbVIC2Ni2eUj3u/UCzVx0CRaYnajkEHH3GyV3TPfQn/JII4JchON
         Vbpg==
X-Gm-Message-State: AOAM530/PjjJvrkhV9eVtiYcqL553Qm+AJ2gRh6JQpStmOjStwgCr8Bt
        P8ab2frnW6pvYVDjVM9NuGfNJLYdsMhbnz/oaew=
X-Google-Smtp-Source: ABdhPJw+m7+F83eMLufvoySFWVv3PwEM1m3YcCixs/km9HE5twJ80K+b3FvNceS5yiaqEiLiwGuKBxqMxyPx68ksB/A=
X-Received: by 2002:a05:6870:d211:b0:f2:91f4:3dfb with SMTP id
 g17-20020a056870d21100b000f291f43dfbmr1468502oac.226.1654135575500; Wed, 01
 Jun 2022 19:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDdnB1Rq3vNe_qt_0u+inzOuL4vrGhgbOoQZKBwfBktni=Npw@mail.gmail.com>
 <YpLLTkje/QUYPP9z@mit.edu> <YpNk4bQlRKmgDw8E@mit.edu> <CAFDdnB0a3mfcoY7rg5N4dO13qMeSsV+PkA2YHeerEOFRv8484Q@mail.gmail.com>
 <YpQixl+ljcC1VHNU@mit.edu> <CAFDdnB1WxrqddeLJwjsqqgoij1q_QGa=SBs-i=j31W2QbksJ=Q@mail.gmail.com>
 <YpVeeKRH1bycP7P1@mit.edu> <YpVxYchs1wScNRDw@mit.edu>
In-Reply-To: <YpVxYchs1wScNRDw@mit.edu>
From:   "Stephen E. Baker" <baker.stephen.e@gmail.com>
Date:   Wed, 1 Jun 2022 22:06:04 -0400
Message-ID: <CAFDdnB1KJVSXXzXKOc+T+g1Qewr11AS4f9tFJqSMLvfpiX-5Lg@mail.gmail.com>
Subject: Re: simplify ext4_sb_read_encoding regression
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, hch@lst.de, linux-ext4@vger.kernel.org
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

On Mon, May 30, 2022 at 9:37 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > I don't know what to tell you.  I took your config, stripped out all
> > of the modules, and enabled CONFIG_HYPERVISOR_GUEST,
> > CONFIG_VIRTIO_MENU, and CONFIG_VIRTIO_BLK, and build a 5.16 kernel.
>
Maybe a silly question, but how do I enable CONFIG_HYPERVISOR_GUEST with
this config.

I run:
ARCH=arm64 CROSS_TOOLCHAIN=aarch64-unknown-linux- make menuconfig
and search for HYPERVISOR_GUEST, it reads:

Symbol: HYPERVISOR_GUEST [=HYPERVISOR_GUEST]
Type  : unknown

With no option to go to or select it.
