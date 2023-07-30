Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C063768446
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Jul 2023 09:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjG3H45 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Jul 2023 03:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG3H44 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Jul 2023 03:56:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DF81710;
        Sun, 30 Jul 2023 00:56:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d58b3efbso3116942f8f.0;
        Sun, 30 Jul 2023 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690703813; x=1691308613;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ljAWSPp6JJ09C5xCBdCnvI6g5oU9J+7I9JqocYaYKqA=;
        b=Ymj/7uyGVQibhRQBLidaLFD+e7fjfaZr6exwNzLg2Irynk6KI26u9GsjADX/ScEdQc
         6I8ApCWoDBd7urof4krmXzsS5CxaHgSu7GABVQ4u7W/YxGwEQO3EhqGyEZ57wuqTe6Y1
         INVcL1Jm1i3aYxMxLS2wLAZD7lP4GAohauDD6hSgCIJxEl9N99Z74IFRxVSNs9McB1PK
         1qkfYtoO4coYO/oJqYoV7+HbxE48wUxo2EhJnWoBKk1PbXy70Y1pGeJal5qTZvaYJ2TU
         x+VTLN0GiQqp1/Jm6fgu5rbf4VL3Xz3O2dcbmmPf1+tALvpbfz62i2nvQlL+KwXTB+k0
         EYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690703813; x=1691308613;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljAWSPp6JJ09C5xCBdCnvI6g5oU9J+7I9JqocYaYKqA=;
        b=JHg6s4V+chDKCO69SSd345tcBVTVvuHziiEN0Dd7ijSNLtHP/Y9Uhmr2C8gbiv+Hac
         PQTwmaeYJpJujELhlvlt8dYUjI3yZdw0QkGLAPqbkez0ud8qSt1quD0Mt178IawvEmOe
         J9OEKcOW0OwfmA7JX//tQ5nfURjwxDu4FivMKXxFejAECv55BI+4FyJWMFNkNLVD462q
         FxIHJvlclNnPNPuz+3wm6LEgW1Z9MzrMUfeFAtPqOeAJmP4uDSro6NkwfEiJOhINNYYP
         9hGGFmD9aowU2YQO3Inqi0WfIm3WsRuD9/2lnjG+KK2cdurlioBteh5hq57qn2AurZph
         7pXg==
X-Gm-Message-State: ABy/qLaE0Y1wVPdCUFPyemd9CGuUOLkZayM2VkSIdVjYkgNedqUbCku0
        tV+G5tmHmE8UPZURD/vDOC4=
X-Google-Smtp-Source: APBJJlGv0f6nuOou/FpZ5rQzl4uCcO+8Rgy/FaK67a0h0/nWVMmFqwBkHaupjAuBKvck+byxHIwGjg==
X-Received: by 2002:adf:fd47:0:b0:317:2574:c2b1 with SMTP id h7-20020adffd47000000b003172574c2b1mr2432840wrs.30.1690703813369;
        Sun, 30 Jul 2023 00:56:53 -0700 (PDT)
Received: from torreasustufgamingpro (209.pool90-77-130.dynamic.orange.es. [90.77.130.209])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d6691000000b0031779e82414sm9342368wru.79.2023.07.30.00.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 00:56:52 -0700 (PDT)
From:   =?utf-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: Contributing subsequent patch versions
References: <877cqlmdpg.fsf@gmail.com>
        <8ef54195-4102-0c6c-e14d-efc9bc45cddc@web.de> <877cqk5zdt.fsf@gmail.com>
        <61a79836-3981-b6e0-cbbf-fe03507dbea4@web.de> <87tttnhohp.fsf@gmail.com>
        <27a41740-9cdd-2adf-f3cc-1f9a2d9f2ed1@web.de>
Date:   Sun, 30 Jul 2023 09:56:51 +0200
In-Reply-To: <27a41740-9cdd-2adf-f3cc-1f9a2d9f2ed1@web.de> (Markus Elfring's
        message of "Sat, 29 Jul 2023 07:34:47 +0200")
Message-ID: <87leexn870.fsf@gmail.com>
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

Markus Elfring <Markus.Elfring@web.de> writes:

>> Sorry, but my experience says that is very easy make mistakes
>> when I am newbie.
>
> Which kind of errors would you like to produce if you would become
> an =E2=80=9Cexpert=E2=80=9D (like a system tester) in additional areas?
>
> Regards,
> Markus

I don't know, but what I've observed during my years working in IT is
that I come up with tests that no one else does. This way I find bugs
that no one else finds.

For example, I forked the project https://github.com/pixel/hexedit and
tried to find errors. I found many, such as what happens if you try to
load a very long filename, what happens if you try to load a very large
file, etc. I fixed them all, but because maintaner didn't accept my
first patch, I didn't carry on.

If anyone is interested in me testing their patch, I would love to do
it. Now I'm reading LINUX KERNEL DEBUGGING book (written by Kaiwan N
Billimoria) and I'm on chapter about strace and some tools like lttng,
so I can use these tools mentioned on book to test patches.

--=20
Un saludo/Regards
Oscar Megia L=C3=B3pez
