Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89E7664C4
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jul 2023 09:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjG1HFX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jul 2023 03:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjG1HFS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jul 2023 03:05:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA954268B;
        Fri, 28 Jul 2023 00:05:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fd190065a8so20120125e9.3;
        Fri, 28 Jul 2023 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690527915; x=1691132715;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CJ/kGhTa7GdVn/+TUEMQPQY9NaN5oB4Dlu8HWJz0ekw=;
        b=O1mJEs0hZ4Ewn5DeZ4X4JWqe/XodR6yAdfgccTgUCwwo9ynpuYnYPwF4CKkK1YX5P6
         xqD+cBN9dHZK6aoQATnR+U7kihDe9ruZmn6JdK7vVhiLO07gcsMzKTZ9m4h7keH2q1au
         mgo2IeAptYC27Xi53E/+tPEi4/cjvj2BwFgBrjWdcZj21sVASDtddxc0NJu/GObUAYh0
         xnf169XTlvNyj46Z0Q684TyavFvmeTgjJd7xD1LlE2enVVscGAXlesm7dVkk/Vl1qHLp
         BZfsrtVtksOVbtSP/QsPiqIWd8cqsccSuf+ub++HyFiJOMLqX5QoUDPBfwwOcJpRV5gw
         n90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690527915; x=1691132715;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJ/kGhTa7GdVn/+TUEMQPQY9NaN5oB4Dlu8HWJz0ekw=;
        b=fk/s9hH3a/Pbx8Y4Cc/Zbs6JXOKgInUiC8t7zSDzXKgKGVUVXkbZ4AVumwWhmJtX/P
         61+XKnJE5cqYYVsl4OkgIpgP3LnGbbWnAlzzMAtWaa8effe8iHiS14AjiQR15a5X+QOa
         i47GRyp+128IAhdBX8l4E/lctWNdS+dxtx6Rra9M4dT2yVLwlw8peMNaGf2xvuIwClDz
         DbnwnYmBgCFakju1/enEj0nG6NCziW0/HIKdquthw++Glbasvh/9pgTbZMHf8NVw5BLn
         tmFqhxHdu3OBWEZf4UqMDVybOC2+Ec50Yvxj3c+vHuoV4QuostBGRYQ9329GqrPgp6lc
         cCTA==
X-Gm-Message-State: ABy/qLY2susVFj+tZtlPnXfbSwNILQLlpeSlN4Z7tSf9iUeL+c204xtM
        A2NKlLIHIos7BG5dXTmOpeXLPLuEAgGHFm2X
X-Google-Smtp-Source: APBJJlFhcOJASLtfYopTTkLRqybbchMdv4Blcym0+gkcUHOXj+dgMTvRRKFwCpYLOQjvWzSluFgNBQ==
X-Received: by 2002:a1c:f309:0:b0:3fc:182:7eac with SMTP id q9-20020a1cf309000000b003fc01827eacmr1197772wmq.33.1690527914848;
        Fri, 28 Jul 2023 00:05:14 -0700 (PDT)
Received: from torreasustufgamingpro (209.pool90-77-130.dynamic.orange.es. [90.77.130.209])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b003fb225d414fsm6228854wmk.21.2023.07.28.00.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:05:14 -0700 (PDT)
From:   =?utf-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH] e2fsck: Add percent to files and blocks feature
References: <20230423082349.53474-2-megia.oscar@gmail.com>
        <73bfa972-1f3a-3a74-c511-4255eae91806@web.de>
Date:   Fri, 28 Jul 2023 09:05:13 +0200
In-Reply-To: <73bfa972-1f3a-3a74-c511-4255eae91806@web.de> (Markus Elfring's
        message of "Thu, 27 Jul 2023 22:23:56 +0200")
Message-ID: <87wmyk4ity.fsf@gmail.com>
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

> You should put also the address "linux-kernel@vger.kernel.org" into
> the message header field "Cc" (or "To").
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n231
>

Sorry, I though that were different proyects.

>
>> I need percentages to see how disk is occupied.
>
> At which occasions do you tend to care for such numbers?
>

For example, when the root disk is almost full, I'd rather know than get
system/application errors. It has happened to me and I think it is
necessary information.

>
>> If also I would see percentages for me would be perfect.
>
> Where would you find such information more helpful?
>

Because on my computer it shows busy/full for one or two seconds and
I don't have time to remember them, much less to calculate the occupancy
percentage. Humans handle percentages much better than many numbers in a
row (at least I do). Also when running e2fsck it is useful to see
percentages.

This is e2fsck with my patch:

$ sudo e2fsck/e2fsck /dev/sdc5
e2fsck 1.47.0 (5-Feb-2023)
label: clean, 405784/2449408 (16%) files, 6651303/9765625 (68%) blocks
$=20

I think it is helpful to show the percentage. Only number of
files/blocks and totals is not enought.

>
>> I think that this feature is going to be good for everyone.
>
> Will persuasion efforts grow accordingly?
>

Sorry, I don't understand what you mean.

>
> How do you think about to choose a corresponding imperative change sugges=
tion?
>

Sorry I do not understand what you mean. If you want to say that my
sentence "I think that this feature is going to be good for everyone."
is to force the change, I'm sorry. It was just a comment to
explain why I submitted the patch. If it was only useful to me, I would
not have sent it.

> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n94
>
> Regards,
> Markus

--=20
Regards
Oscar Megia L=C3=B3pez
