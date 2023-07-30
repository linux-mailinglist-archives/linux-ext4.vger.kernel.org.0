Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D942676841A
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Jul 2023 09:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjG3HKy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Jul 2023 03:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjG3HKx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Jul 2023 03:10:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13441FE0;
        Sun, 30 Jul 2023 00:10:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3174aac120aso3230428f8f.2;
        Sun, 30 Jul 2023 00:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690701050; x=1691305850;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W+NY0+aVddXBDHRK3qT5EharoS+L/NL2W3fL10wSPAY=;
        b=R4H6jzWsmXCfNh6MpHMpVXaZOLf7Q6oiwwG1Ey0kcBs/lr78DS65NX6rTySESBOmUx
         7Yd2QqJpWvN/xrOz6UksOwXcoXGhZ5SxzeyEdPSSvfnVofLERmq1clCDurh83upWaxvc
         RMCIwecEYbDFe3UWbXkzhG6rndUxLERzZLYdR283NUEipv8NvcrGllLPntPFq2fntsuC
         gbsValCiDoA5Y459eqHMmzQD6SudC03+g8fpBGiQbY5GXSEFlh0SY81t6z+T9/eXH5t0
         VCX7Ni3NEaXA3s9APeUaTIuQSg3AmFXZMxwPB6DcoPkltyCEHxSoyfejt1uEl7sX9aCy
         Wc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690701050; x=1691305850;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+NY0+aVddXBDHRK3qT5EharoS+L/NL2W3fL10wSPAY=;
        b=OzOvcNok8qxl8VpSj7N1n7yGCAkmFhHQkAb2O/DL/whNcrF+KtJrOGZ2mW14ZdtO27
         DLEGITwlD31fneCThiSpgFb4Hz9LG5IJ+OGFpTq9bLJcAjU6z24Ur6j3LNtYbqIDg7vp
         TxsiKFMu5tsX2+1EcG6JsoJ140X5+D5WW0hVFAf0bXLWIaDpDivoo3EwaaicrhX7IJuF
         2TecKOHSbhP/FlMBaFTMhjdXCNJKc7OKYyK9K4mDEJcw+7d2f4Q9JEAq8YajmatGkl5K
         3nyAT1mhm7bM/r5vQvDEnRzJ5p1pbHPITApBIK6k7qMnc8/5Y5Qp9zOz0iKgE19CQdHY
         JdbQ==
X-Gm-Message-State: ABy/qLbGV3AF0pTELPyfdtUiW52EYmf4kQbsa7ZcXHAK0iExGxJq8Tmu
        t/27z5QIoSAcNT/kgmHLc9I=
X-Google-Smtp-Source: APBJJlHwFDZQycIf2BZm5lmHW0tlntCTcmXEBB9Puo1NhJUwPNVgd0U6ESck881MpBiKRN21vRCHcg==
X-Received: by 2002:adf:dd50:0:b0:314:1d53:f3aa with SMTP id u16-20020adfdd50000000b003141d53f3aamr4512393wrm.50.1690701049916;
        Sun, 30 Jul 2023 00:10:49 -0700 (PDT)
Received: from torreasustufgamingpro (209.pool90-77-130.dynamic.orange.es. [90.77.130.209])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b00317495f88fasm9218605wrp.112.2023.07.30.00.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 00:10:49 -0700 (PDT)
From:   =?utf-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: Contributing subsequent patch versions
References: <877cqlmdpg.fsf@gmail.com>
        <8ef54195-4102-0c6c-e14d-efc9bc45cddc@web.de> <877cqk5zdt.fsf@gmail.com>
        <61a79836-3981-b6e0-cbbf-fe03507dbea4@web.de> <87tttnhohp.fsf@gmail.com>
        <20230728195959.GB607743@mit.edu>
Date:   Sun, 30 Jul 2023 09:10:48 +0200
In-Reply-To: <20230728195959.GB607743@mit.edu> (Theodore Ts'o's message of
        "Fri, 28 Jul 2023 15:59:59 -0400")
Message-ID: <87pm49nabr.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Fri, Jul 28, 2023 at 08:36:50PM +0200, Oscar Megia L=C3=B3pez wrote:
>> I don't know correct steps to send patch's v2 as above instance. Sorry,
>> but I need step by step instructions, if not I think that I can make
>> mistakes and I don't want. Sorry, but my experience says that is very
>> easy make mistakes when I am newbie.
>
> We all make mistakes; don't worry about it!  This includes myself,
> which is why I often will run:
>
>       git format-patch -o /tmp/p -5
>
> <then examine the patches in /tmp/p very carefully to make sure they make=
 sense>
>
> before I run
>
>        git send-email /tmp/e --to linux-<subsystem>
>
> where I have a bunch of aliases in ~/.mail_aliases, e.g.:
>
...

Thank you very much Ted for your help and your time. I really appreciate
it.

I apologize for my doubts, but I've always been told that I'm
different because I doubt everything. Sometimes is good and sometimes is
not good.

In my experience, I believe that asking for help from someone who knows
much more is the right way to act when you don't know how solve issue.

--=20
Regards
Oscar Megia L=C3=B3pez
