Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214D538280C
	for <lists+linux-ext4@lfdr.de>; Mon, 17 May 2021 11:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhEQJTx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 May 2021 05:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbhEQJTu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 May 2021 05:19:50 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2409BC061573
        for <linux-ext4@vger.kernel.org>; Mon, 17 May 2021 02:18:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o8so6369113ljp.0
        for <linux-ext4@vger.kernel.org>; Mon, 17 May 2021 02:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=z4UcpGzMWqkZUd/8oaYwRMHKMda1srSdYpoW2+D93aE=;
        b=ioL4j+Hg5OvGRIk2eHzBrKfxGwn8vCSAtf07UIwDjGd0+iXho35xngnDl6FFIdxMmq
         ObBTdoqi4cQKcOTQKmGAzz1sCU4++/4XAAAZ84/SlkefvIBwOBOFxcpjg8aayfmFmMqa
         xNNvDRC1SG7a997egaFJQrag7FDwtutIpSvp2SA7190tlp/+b844qFTq6ToX9+tlaFiw
         D+t4kGyrXXwbg9+Zuu9BkJU/E+SKR2D89c0CPaKaKuaaDpQPhh9JX+YZS8ctNFsSNlwq
         cDIzoUYqGvVFJIz5s5PVxbo6NviHTDSKJo2vU1aJQX8W/585nDhLHMZKlVTjbm7JvXXx
         w34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=z4UcpGzMWqkZUd/8oaYwRMHKMda1srSdYpoW2+D93aE=;
        b=HKwuRSgmRHYsU3zWc1+T0gqvVI8FBBvXSstGvjsB9hBGjpbeO1PG5numW0lLmoNs7W
         C1bEa5ruzDh/ZKMiQvzY31Ytuca+mLOzinwGSFR/FQLKUoHYpB+X9GBC3H0l/pY1oKAe
         6Fp9v1vMxkGLFO7FiRpTGrN+gjPhH8L2+FY9iD2KtSwxw1NuKiwOGPIgZRruPISQk/hG
         OsDnk5Q+30NIAIr2+UUwIfwbfg6FL+t5YF42YiXSSOeOsCwQoH1ISVFebyeZPOMvl8yo
         nUDurNfVzR97Yfhx8O5KjdcKF7M54t9q9NxTTFaTR/x2J+XOgK8uAeaFOQyain+0RHR8
         O9NA==
X-Gm-Message-State: AOAM530AzHbfYY3dZ3MbyxjquIkbRxtvTkXPCH7u/wuqMgzzJ55sOIHt
        dI+G++nopd4cFVwTV/kPcpE6OqbtKs65C/Px
X-Google-Smtp-Source: ABdhPJzrW/7ig2bXX0epwqGrWrfPfmqYiobBu6YwO/Iw8oSYtS6RIMqIdrShKVdy/mjXpKf1cdM2vQ==
X-Received: by 2002:a2e:9b45:: with SMTP id o5mr25337495ljj.153.1621243111705;
        Mon, 17 May 2021 02:18:31 -0700 (PDT)
Received: from [192.168.43.113] ([95.153.131.62])
        by smtp.gmail.com with ESMTPSA id m21sm105423lfu.188.2021.05.17.02.18.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 May 2021 02:18:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.20\))
Subject: Re: [PATCH] ext4: remove set but rewrite variables
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <c3e07a98-7eff-c761-4a99-78b8c5b73f7d@huawei.com>
Date:   Mon, 17 May 2021 12:18:20 +0300
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CCD53C8F-7A5B-40B4-9FB8-6D17F352AAFD@gmail.com>
References: <1621220165-11849-1-git-send-email-tiantao6@hisilicon.com>
 <B5603A0A-D24E-46A2-94B6-79451E39141C@gmail.com>
 <c3e07a98-7eff-c761-4a99-78b8c5b73f7d@huawei.com>
To:     "tiantao (H)" <tiantao6@huawei.com>
X-Mailer: Apple Mail (2.3445.104.20)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It looks like it is always reset just after =E2=80=9Cagain:=E2=80=9D  =
label. So, yes, your fix does not change the logic.

Feel free to add:
Reviewed-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>

Best regards,
Artem Blagodarenko
> On 17 May 2021, at 11:44, tiantao (H) <tiantao6@huawei.com> wrote:
>=20
>=20
> =E5=9C=A8 2021/5/17 16:05, =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=D1=
=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC =E5=86=99=E9=81=
=93:
>>=20
>>> On 17 May 2021, at 05:56, Tian Tao <tiantao6@hisilicon.com> wrote:
>>>=20
>>> In line 2500 of the ext4_dx_add_entry function, the at variable is
>>> assigned but not used, and it is reassigned in line 2449, so delete
>>> the assignment of the at variable in line 2500.
>>>=20
>>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>>> ---
>>> fs/ext4/namei.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>>> index afb9d05..18bbf15 100644
>>> --- a/fs/ext4/namei.c
>>> +++ b/fs/ext4/namei.c
>>> @@ -2497,7 +2497,7 @@ static int ext4_dx_add_entry(handle_t *handle, =
struct ext4_filename *fname,
>>>=20
>>> 			/* Which index block gets the new entry? */
>>> 			if (at - entries >=3D icount1) {
>>> -				frame->at =3D at =3D at - entries - =
icount1 + entries2;
>>> +				frame->at =3D at - entries - icount1 + =
entries2;
>>> 				frame->entries =3D entries =3D entries2;
>>> 				swap(frame->bh, bh2);
>>> 			}
>>> --=20
>>> 2.7.4
>>>=20
>>=20
>> Hello Tian,
>>=20
>> Thank you for the patch.
>>=20
>> Please, clarify, do you think the logic not changed after you patch =
if "while (frame > frames) {=E2=80=9C loop is not executed or terminated =
by =E2=80=9Cbreak:=E2=80=9D in " if (dx_get_count((frame - 1)->entries) =
< ...=E2=80=9C block?
>=20
> yes, it's reported by svace. and I check the code it's not change the =
logic. myabe I was wrong:-P
>=20
>> Also I am not sure code lines numbers in the description are useful =
for future readers, because they can be changed.
> I can update the commit message at v2.
>>=20
>> Thank you..

