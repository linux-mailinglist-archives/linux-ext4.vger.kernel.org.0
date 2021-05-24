Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586A738E8DF
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhEXOmt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 10:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhEXOmq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 10:42:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A72C061574
        for <linux-ext4@vger.kernel.org>; Mon, 24 May 2021 07:41:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c10so19988850lfm.0
        for <linux-ext4@vger.kernel.org>; Mon, 24 May 2021 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gi5MH4Jv0khUm9tQXkxcAsBx+qss0AkjoigNKVrikHQ=;
        b=Tho7OEG4t7Qvnv0jtxFpPYtf+vj02CW2epcEQLuhWWKVAZb8DbCvA4/0/QDwTGGNqx
         KsdikQnc26WtE8xicAXsSVUjIV/HadEq6fCAAm8/n+SZzHkVT9ng+26pTMYBGNAmqANc
         s51PBr9tdaiCj/UHZU6VwuXCKpkrDE1emArrO6nS+jJP5b3phyZkXpwPLgnIJaVKE5C0
         IHwINR3KqC8CPECu42d5NGqtCIWFvoaDOS9Ko0XR8KgJ7vZS6NXVJcl7h02mIQN0OsKr
         st5pKY9ppDF6scxnFwe3LvHaKKd321ZsiE5wuEOi7rmr+9ZUGyFGsgZycPGA1DPAiNTy
         NAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gi5MH4Jv0khUm9tQXkxcAsBx+qss0AkjoigNKVrikHQ=;
        b=GFM8v7XFXoAU2xIq2spb8beWnf9/17Uq+TCKPQ7xKaJB7L4ECx2Iv9tm/zgJsFBzpW
         hlO80gMMImS/s8gBSU7EeCsp28o+8Cx0a+REKNKfOgt0uxtq2BcLgd+41w3RIcVmA0hc
         JjsjbhuSvr/laz5zjDuj2U5SMX1FapVVgjjcZ3tUJqHFc+BvhkPBUphXVNBXZucWjUUz
         vzjSpvcj3mC3gq9U4sTZ/F9KuO4xD7h+/fEbj73tuWjyr9YcOC7/uroI+/oeD+Ktm6T6
         rI3+fk3Whh2lAzK6GaebdvrokDYqIZuytYQwEOis3lew3cwodis3FiRyJgyhvH7HE4sz
         IzmA==
X-Gm-Message-State: AOAM533nhOxATvMLTfu/SefIIJOy9xV/WI6nBHkodnu+E9/m6p+jGNam
        zalnazEC1Oj1amHflzMDtLjjuc6NmmxlXcHO
X-Google-Smtp-Source: ABdhPJz4CIXYAbw9W0o7PjLMns65UePl9vatxPgPj3p+/Bl7pkXTw0GuRr4TBlSUnTOD6Uxe4LuS/Q==
X-Received: by 2002:a19:7011:: with SMTP id h17mr10698063lfc.4.1621867273383;
        Mon, 24 May 2021 07:41:13 -0700 (PDT)
Received: from [192.168.2.192] ([83.234.50.67])
        by smtp.gmail.com with ESMTPSA id o20sm1439885lfu.283.2021.05.24.07.41.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 May 2021 07:41:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.20\))
Subject: Re: [PATCH 03/12] zap_sector: fix memory leak
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <8ea5c607-54cc-ccaf-3e4b-ee2af0160a0b@huawei.com>
Date:   Mon, 24 May 2021 17:40:59 +0300
Cc:     linux-ext4@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E51F98C9-49F5-45B2-9B2C-4FC309B5C8AB@gmail.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
 <8ea5c607-54cc-ccaf-3e4b-ee2af0160a0b@huawei.com>
To:     Wu Guanghao <wuguanghao3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.20)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Wu,

Thank you for the fixes.

It looks like free and return operators should be placed in {} block.

{
	free(buf);
 	return;
}

Now function returns any time block is read successfully.

Also, this patch can not be applied cleanly to the master HEAD because =
of wrong offsets. Please rebase.

Best regards,
Artem Blagodarenko.

> On 24 May 2021, at 14:20, Wu Guanghao <wuguanghao3@huawei.com> wrote:
>=20
> In zap_sector(), need free buf before return,
> otherwise it will cause memory leak.
>=20
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Reviewed-by: Wu Bo <wubo40@huawei.com>
> ---
> misc/mke2fs.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index afbcf486..94f81da9 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -586,6 +586,7 @@ static void zap_sector(ext2_filsys fs, int sect, =
int nsect)
> 			magic =3D (unsigned int *) (buf + =
BSD_LABEL_OFFSET);
> 			if ((*magic =3D=3D BSD_DISKMAGIC) ||
> 				(*magic =3D=3D BSD_MAGICDISK))
> +				free(buf);
> 				return;
> 		}
> 	}
> --=20

