Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C815E382632
	for <lists+linux-ext4@lfdr.de>; Mon, 17 May 2021 10:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhEQIG5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 May 2021 04:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbhEQIG4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 May 2021 04:06:56 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6A8C061573
        for <linux-ext4@vger.kernel.org>; Mon, 17 May 2021 01:05:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w4so6061923ljw.9
        for <linux-ext4@vger.kernel.org>; Mon, 17 May 2021 01:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4hj+ReIpbLxmvNHFTfNCeLffenDc/WsOuPZee29vTls=;
        b=gAebueAhV0SLrUe7bXIL41tfcAewnM/U3SUA2AuCi70hPjYk/DnBlaUfHB/XMXVfcO
         NsxEobrPI8yq87ubdX52ZpGbmgwoUEHbgr4dcP6fVVJ92ue8AgodtYEePxwp4nTN87pb
         vDYIa1i0bekPBYK+ncLw4IY7wj1QtACvozWqhZQq26e1+V9qmynV0Zb8HtJWovahL+qY
         3EtyW/nmgDW5jKdfL/B9PIJnjfqdhGTs0zsfE31k/uapX5zHICENM2NnktY2Fj7wFKQW
         RtLf5jR55B2Qmi8/5MuOAa/D/rWi76w/OPyK3SFpOqqPvRZ2wcV58gU9lI1g8wVankni
         xq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4hj+ReIpbLxmvNHFTfNCeLffenDc/WsOuPZee29vTls=;
        b=Q7shLJTLuUg7esmeMA63Ai5NtP9Sth7J0rIFcx+UB/Roo0Fz15y4dL2TOVeL0L0SwP
         L3bFwxpTCa6eZYDKee17XKEc1GeobFlbtFxnLbZpso/Y7uNiT1BjVJ4nfX1Nz0TxjLZf
         EFQh+SxGciXNaA1MyOl17mtBUQBaRmhtqEE/4KGDxNp9L/6TVhZW+Hu9DJtyilgq8wlG
         IjPB+XealoYON4uqzqqOwU1nN19PZKIe+OiL3N8ZzImN1Mlo8by/M/0wdvBGlM3yTUzt
         nrjai5Lh7hIFRl2Zg6QYLgy3SgbjSAW3bJv6+ju1Iha/NpK+wJfRVY9WdDN4H0h+JZMk
         mEsQ==
X-Gm-Message-State: AOAM532E5pb+FY6wRwOUYifEvtui+l9MUR7XPjv4NxZQd2HF3nWxxbU0
        o8HlhQ0L7VXaayAz4JMw038FvFXK7HnUfA==
X-Google-Smtp-Source: ABdhPJxhTcdI2HthJlnLP0ey1TbLjvU15wjNrhcRqGP8rg/4+PbYRG4b47a7WGEwIZt+WutHzxXMUw==
X-Received: by 2002:a05:651c:210:: with SMTP id y16mr46164394ljn.279.1621238737805;
        Mon, 17 May 2021 01:05:37 -0700 (PDT)
Received: from [192.168.2.192] ([83.234.50.67])
        by smtp.gmail.com with ESMTPSA id n3sm1885841lfi.147.2021.05.17.01.05.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 May 2021 01:05:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.20\))
Subject: Re: [PATCH] ext4: remove set but rewrite variables
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <1621220165-11849-1-git-send-email-tiantao6@hisilicon.com>
Date:   Mon, 17 May 2021 11:05:32 +0300
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5603A0A-D24E-46A2-94B6-79451E39141C@gmail.com>
References: <1621220165-11849-1-git-send-email-tiantao6@hisilicon.com>
To:     Tian Tao <tiantao6@hisilicon.com>
X-Mailer: Apple Mail (2.3445.104.20)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On 17 May 2021, at 05:56, Tian Tao <tiantao6@hisilicon.com> wrote:
>=20
> In line 2500 of the ext4_dx_add_entry function, the at variable is
> assigned but not used, and it is reassigned in line 2449, so delete
> the assignment of the at variable in line 2500.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
> fs/ext4/namei.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index afb9d05..18bbf15 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2497,7 +2497,7 @@ static int ext4_dx_add_entry(handle_t *handle, =
struct ext4_filename *fname,
>=20
> 			/* Which index block gets the new entry? */
> 			if (at - entries >=3D icount1) {
> -				frame->at =3D at =3D at - entries - =
icount1 + entries2;
> +				frame->at =3D at - entries - icount1 + =
entries2;
> 				frame->entries =3D entries =3D entries2;
> 				swap(frame->bh, bh2);
> 			}
> --=20
> 2.7.4
>=20


Hello Tian,

Thank you for the patch.=20

Please, clarify, do you think the logic not changed after you patch if =
"while (frame > frames) {=E2=80=9C loop is not executed or terminated by =
=E2=80=9Cbreak:=E2=80=9D in " if (dx_get_count((frame - 1)->entries) < =
...=E2=80=9C block?
Also I am not sure code lines numbers in the description are useful for =
future readers, because they can be changed.

Thank you.=
