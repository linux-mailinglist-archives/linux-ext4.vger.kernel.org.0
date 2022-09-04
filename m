Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6445AC800
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Sep 2022 00:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiIDWdE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 4 Sep 2022 18:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiIDWdE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 4 Sep 2022 18:33:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06348286E9
        for <linux-ext4@vger.kernel.org>; Sun,  4 Sep 2022 15:33:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l3so6847490plb.10
        for <linux-ext4@vger.kernel.org>; Sun, 04 Sep 2022 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=Jpap4vmGmTI5uA9ZKz9G1SzHNvyt3zCTBBoidrY1T5Q=;
        b=OKaNGsnLFB3RG1dVmBTcVZqsmXn3JtBWxS5cFnXAaQwG4CJ3etcPtPwnb553q72gTh
         oxuEGdAfXzU25j7BNBK/n9kHR74QPuK6mnHo0UrwHCqc3nQhhRC5cEEJgDRRwHKIpTJ0
         YMVRzgQHNbB3mms5fcrPwhDwIRfPDwjEgLAI7z/W4IrDfAl35TW1IsmBmZ2uAlWX1DV8
         7eLDr85atqZLj4mpti9b5nqGdFxMRj1+owMPqax3kedmKoFUmsqFf4GYSE93XXxn1LIl
         uZrRrmDzSRC4qxfbwegUNNt5ZM3U5QOGU+GVWxncY2pg6X1Klgf+SI64JCneY2WSA08p
         w26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Jpap4vmGmTI5uA9ZKz9G1SzHNvyt3zCTBBoidrY1T5Q=;
        b=HEvPSM9Hz0x0I64d6J58ORjOW771xi3sn7J94QjeJc6YkyOsid8exgJX4OJK8sfaBl
         bScZxKQPqXxZMhFfxXkHOjfmDCqBrkoO5fDeYktcMTNoVU7NPle0pMXBO+mKh4zJvGXp
         4YJC2yMu9LBWApI0Gy2H+H1UrFuszts7DoHUXIebmBPxRJ+qKqGuDAE+dp1OrCUY1mxQ
         TgDuJ7DTVSfQ5roa85okPhG/bPSqvCUXeEi7tnkIfK/sJ+3d6WxsxKeEEMYUJIRkfZsX
         6Bp06VQoBAyBs/Cjw+ZULwVacEo6sirFBhbT8RxEWLrEUxWMEyvJsrDqtErAwGXgV1wh
         /MuA==
X-Gm-Message-State: ACgBeo2jVpWd+Ea6xb23sNbmI12JQUqJt/4tkfBPrcZUhqADYQR9wgKR
        S3+NF/bCR7q5Ph8ue1XMQP7H6w==
X-Google-Smtp-Source: AA6agR7pWkCE7MVFheb7kyR4C/DRj0CI2QoR6ZC83kzRAgbc1WBzX1pR11A36zlA0yCIChHVUqE9uQ==
X-Received: by 2002:a17:90b:4f91:b0:1cd:3a73:3a5d with SMTP id qe17-20020a17090b4f9100b001cd3a733a5dmr10276319pjb.98.1662330781428;
        Sun, 04 Sep 2022 15:33:01 -0700 (PDT)
Received: from smtpclient.apple (cpe-98-155-89-166.hawaii.res.rr.com. [98.155.89.166])
        by smtp.gmail.com with ESMTPSA id k6-20020aa79d06000000b005379dd2deb5sm6127955pfp.137.2022.09.04.15.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 15:33:00 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Date:   Sun, 4 Sep 2022 12:32:59 -1000
Message-Id: <46CC2CC6-FB9B-4F6B-AA68-926D28F69592@dilger.ca>
References: <c449eea8-87e4-3f74-5d11-d159eae28c0b@i2se.com>
Cc:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
In-Reply-To: <c449eea8-87e4-3f74-5d11-d159eae28c0b@i2se.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sep 4, 2022, at 00:01, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>=20
>> Am 27.08.22 um 16:36 schrieb Ojaswin Mujoo:
>>> On Fri, Aug 26, 2022 at 12:15:22PM +0200, Jan Kara wrote:
>>> Hi Stefan,
>>>=20
>>> On Thu 25-08-22 18:57:08, Stefan Wahren wrote:
>>>>> Perhaps if you just download the archive manually, call sync(1), and m=
easure
>>>>> how long it takes to (untar the archive + sync) in mb_optimize_scan=3D=
0/1 we
>>>>> can see whether plain untar is indeed making the difference or there's=

>>>>> something else influencing the result as well (I have checked and
>>>>> rpi-update does a lot of other deleting & copying as the part of the
>>>>> update)? Thanks.
>>>> mb_optimize_scan=3D0 -> almost 5 minutes
>>>>=20
>>>> mb_optimize_scan=3D1 -> almost 18 minutes
>>>>=20
>>>> https://github.com/lategoodbye/mb_optimize_scan_regress/commit/3f3fe8f8=
7881687bb654051942923a6b78f16dec
>>> Thanks! So now the iostat data indeed looks substantially different.
>>>=20
>>>            nooptimize    optimize
>>> Total written        183.6 MB    190.5 MB
>>> Time (recorded)        283 s        1040 s
>>> Avg write request size    79 KB        41 KB
>>>=20
>>> So indeed with mb_optimize_scan=3D1 we do submit substantially smaller
>>> requests on average. So far I'm not sure why that is. Since Ojaswin can
>>> reproduce as well, let's see what he can see from block location info.
>>> Thanks again for help with debugging this and enjoy your vacation!
>>>=20
>> Hi Jan and Stefan,
>>=20
>> Apologies for the delay, I was on leave yesterday and couldn't find time t=
o get to this.
>>=20
>> So I was able to collect the block numbers using the method you suggested=
. I converted the
>> blocks numbers to BG numbers and plotted that data to visualze the alloca=
tion spread. You can
>> find them here:
>>=20
>> mb-opt=3D0, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/ma=
ster/grpahs/mbopt-0-patched.png
>> mb-opt=3D1, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/ma=
ster/grpahs/mbopt-1-patched.png
>> mb-opt=3D1, unpatched kernel: https://github.com/OjaswinM/mbopt-bug/blob/=
master/grpahs/mbopt-1-unpatched.png
>>=20
>> Observations:
>> * Before the patched mb_optimize_scan=3D1 allocations were way more sprea=
d out in
>>   40 different BGs.
>> * With the patch, we still allocate in 36 different BGs but majority happ=
en in
>>   just 1 or 2 BGs.
>> * With mb_optimize_scan=3D0, we only allocate in just 7 unique BGs, which=
 could
>>   explain why this is faster.
>=20
> thanks this is very helpful for me to understand. So it seems to me that w=
ith disabled mb_optimized_scan we have a more sequential write behavior and w=
ith enabled mb_optimized_scan a more random write behavior.
>=20
> =46rom my understanding writing small blocks at random addresses of the sd=
 card flash causes a lot of overhead, because the sd card controller need to=
 erase huge blocks (up to 1 MB) before it's able to program the flash pages.=
 This would explain why this series doesn't fix the performance issue, the t=
otal amount of BGs is still much higher.
>=20
> Is this new block allocation pattern a side effect of the optimization or d=
esired?

The goal of the mb_optimized_scan is to avoid a large amount of linear scann=
ing for
very large filesystems when there are many block groups that are full or fra=
gmented.=20

It seems for empty filesystems the new list management is not very ideal. It=
 probably
makes sense to have a hybrid, with some small amount of linear scanning (eg.=
 a meta
block group worth), and then use the new list to find a new group if that do=
esn't find any
group with free space.=20

Cheers, Andreas=
