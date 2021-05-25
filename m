Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB5938FDFD
	for <lists+linux-ext4@lfdr.de>; Tue, 25 May 2021 11:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhEYJjf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 May 2021 05:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhEYJjb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 May 2021 05:39:31 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FF7C061574
        for <linux-ext4@vger.kernel.org>; Tue, 25 May 2021 02:37:31 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c20so29773825qkm.3
        for <linux-ext4@vger.kernel.org>; Tue, 25 May 2021 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d9lws8KQLCMq8mv+zGj80bFhbyEUWR5W6D4bJKhmvhU=;
        b=QunkamFzTehjvDR38LayE6RTrzOWUw3heFwPaqOz4mwGrhhwbqSsjdHh3IHcvc69I1
         whIk8K27W7qLYYsP6OA09f/h4iJ5IYRHNd/8mVOTPkDX+B/OTgoAAxB9e88NTtz4oC1Z
         KG3LjogEjwyUKvrXNJfLFiOxwwiJDc1nGohh5jBBdWaS22Hi7ElO7KNKezhkitT32a3E
         yu+g0Xj228yBYKQ7GxphK+v+NhNKHpeSKUlBagjFI8uAzeb85LwvwlICW2RPbA/1zqes
         dPJ6QrY6ezgKbj+GHhEaw3Ugkg9A1kxLDeghnIeIdR3FelanUzPE4rz9rSMPrOz2RK25
         1tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d9lws8KQLCMq8mv+zGj80bFhbyEUWR5W6D4bJKhmvhU=;
        b=KrGZN5M5otEjPnmHJfu7g/MXobcVZZvDK0LYQJRs/B0kntNbdyU4RykJ+27e3pxOTZ
         hr0KPsFlud5L0BUPGOcR9FFfKyE/0blGWpQFOoysTatYcCJm75PxISS2THkMozw5vRYQ
         QdShIsuaopL2cuAC4q8QUpgJBZ1A726jnQL9+k3X9+SMyVFlM+S0mWOZ+VD9m+J88nUo
         EK0vEeW37vI5154dDNfWbVB5d9t1BRJmedSSUTT2O2RvtdjG3itV4BCp3mS4a5fI0ZY4
         jX6nKxcK6z+6F3wICSWnmKqAE/8EyDa+XvxQ6Nd9d2RIZb1MKDK9RukQeina2Tmhd22C
         V5ng==
X-Gm-Message-State: AOAM533K5tbsiRmFrATkzIud+CESvp1OpMhNeek2/no5DiZsTwdLCfcR
        NtetipLIt/iMou2zKec/jMM=
X-Google-Smtp-Source: ABdhPJzrucsuXa4ZCcXGSy4XOj1BuJxU2s9NtHTgOaWenKPo0i5mwGbgfoGGXpROFka0pkbVcavfAQ==
X-Received: by 2002:a37:4697:: with SMTP id t145mr33799560qka.188.1621935450202;
        Tue, 25 May 2021 02:37:30 -0700 (PDT)
Received: from [172.25.67.2] ([136.162.34.1])
        by smtp.gmail.com with ESMTPSA id p17sm12060480qkg.67.2021.05.25.02.37.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 02:37:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.20\))
Subject: Re: [PATCH 06/12] append_pathname: check the value returned by
 realloc to avoid segfault
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <07fe127f-3814-7d12-dea6-b84d9ab4410e@huawei.com>
Date:   Tue, 25 May 2021 12:37:13 +0300
Cc:     linux-ext4@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1979B168-38E8-4D35-B8D7-2D47D04ED344@gmail.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
 <07fe127f-3814-7d12-dea6-b84d9ab4410e@huawei.com>
To:     Wu Guanghao <wuguanghao3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.20)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Wu,

Thanks for the patch.

> On 24 May 2021, at 14:23, Wu Guanghao <wuguanghao3@huawei.com> wrote:
>=20
> In append_pathname(), we need to add a new path to save the value =
returned by realloc,
> otherwise the name->path may be NULL, causing segfault
>=20
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
> contrib/fsstress.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/contrib/fsstress.c b/contrib/fsstress.c
> index 2a983482..530bd920 100644
> --- a/contrib/fsstress.c
> +++ b/contrib/fsstress.c
> @@ -599,7 +599,7 @@ void add_to_flist(int ft, int id, int parent)
> void append_pathname(pathname_t * name, char *str)
> {
> 	int len;
> -
> +	char *path;:
> 	len =3D strlen(str);
> #ifdef DEBUG
> 	if (len && *str =3D=3D '/' && name->len =3D=3D 0) {
> @@ -609,7 +609,13 @@ void append_pathname(pathname_t * name, char =
*str)
>=20
> 	}
> #endif
> -	name->path =3D realloc(name->path, name->len + 1 + len);
> +	path =3D realloc(name->path, name->len + 1 + len);
> +	if (path =3D=3D NULL) {
> +		fprintf(stderr, "fsstress: append_pathname realloc =
failed\n");
> +		chadir(homedir);

Did you mean chdir() here?

> +		abort();
> +	}
> +	name->path =3D path;
> 	strcpy(&name->path[name->len], str);
> 	name->len +=3D len;
> }
> --=20


Thanks,
Best regards,
Artem Blagodarenko.

