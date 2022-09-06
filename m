Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24535AE47A
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Sep 2022 11:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiIFJlf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Sep 2022 05:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiIFJld (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Sep 2022 05:41:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846337548A
        for <linux-ext4@vger.kernel.org>; Tue,  6 Sep 2022 02:41:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w8so16423466lft.12
        for <linux-ext4@vger.kernel.org>; Tue, 06 Sep 2022 02:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=AOQWwaPlBKah4iqv+wxoHpRLfp1WYybJL1kCW9M6JuY=;
        b=Uuuzw3hpZQyFzLwd5Be4OsaeSyPRGEMLz/mnietoyl9+yMZe59YY4KZq15kbpod8Ur
         pcYK6o225UwlXeKkYaQxDPxENmgOVDOqoIEyRbrC0+W+JLFw7LeLHX0eigZzQkmBTPAu
         K9GmpbVV6RVuZAHhp8TQ2xM8wjE6HhkjqP6C4zikUMDdzUHZUFi4s2iUiYM5ZBybDHnh
         BkQyZVZh9NaPKxFrRj1dop/VQ8vFaMdM6iwEVdECZvNzPpNzwfGu1GiPG5y6yLpMJhbX
         ikdPscIdCMfZ1efQyeNXydmqx4cEqMkxFlHXiQ30zJelYwuveI5e9pKRdTXIzL4f1FOc
         5ILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AOQWwaPlBKah4iqv+wxoHpRLfp1WYybJL1kCW9M6JuY=;
        b=fI5oWxEENcycEilsyfyQ22qlQyhIPEa58XU7lqoplVgZYZl0r46A57fr0Y646FC+9u
         lutUbLmVHkRBoVQhvf2yt7apXAIYlLIo6hFdRlP1LjWUYc6qEt8ScPQNTl3Delrslp8i
         ev2/YPSvCEhGkcTUo9Wc9E1l6U2FrcnJVTt/+anOzniwOq20F4W6bMchduCX48KxcddN
         0pEj6iZ8yO8uxkkAVPhuqD1TG7zJLrVC9nig7iGiGypeODWFdbB+CSLXPt1r27HayY2x
         ZowYqRyC6BWFvTgZF7dzyXXCSFr3V+iolGWzd9zoFS7vAx9lOpz5iF4uZePK0bI7DQkr
         yS6Q==
X-Gm-Message-State: ACgBeo3fpH1OTThunCGeuogWdqjiZtXVrE61OkhQVGoRyH7og2WEnQwk
        tI2bZUcnpoxveHOS1H1+7x99jdOGOsGZIjlB
X-Google-Smtp-Source: AA6agR6SgptXscthT5V55OsdnLOc68i+qUwsHEZvmEo0i/2O6QG3pv8nVYg4d9z2C8lweQ8iyoH/iQ==
X-Received: by 2002:a05:6512:13a4:b0:477:a28a:2280 with SMTP id p36-20020a05651213a400b00477a28a2280mr16450950lfa.689.1662457289644;
        Tue, 06 Sep 2022 02:41:29 -0700 (PDT)
Received: from smtpclient.apple ([83.234.50.195])
        by smtp.gmail.com with ESMTPSA id g11-20020a2eb5cb000000b002637c04b472sm1776743ljn.83.2022.09.06.02.41.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2022 02:41:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] tune2fs: tune2fs_main() should return rc when some error,
 occurs
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
In-Reply-To: <7a6e1a43-d041-c3cf-a3dd-a9761d8dd4d6@huawei.com>
Date:   Tue, 6 Sep 2022 12:41:26 +0300
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9EBB17B-7EA2-44A3-9361-FDD09EE69FB5@gmail.com>
References: <7a6e1a43-d041-c3cf-a3dd-a9761d8dd4d6@huawei.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Reviewed-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>

> On 5 Sep 2022, at 18:40, Zhiqiang Liu <liuzhiqiang26@huawei.com> =
wrote:
>=20
>=20
> If some error occurs, tune2fs_main() will go to closefs tag for
> releasing resource, and it should return correct value (rc) instead
> of 0 when ext2fs_close_free(&fs) successes.
>=20
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
> misc/tune2fs.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 25ade2fa..088f87e5 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -3481,6 +3481,7 @@ _("Warning: The journal is dirty. You may wish =
to replay the journal like:\n\n"
> 			fputs(_("Error in using clear_mmp. "
> 				"It must be used with -f\n"),
> 			      stderr);
> +			rc =3D 1;
> 			goto closefs;
> 		}
> 	}
> @@ -3744,5 +3745,5 @@ closefs:
>=20
> 	if (feature_64bit)
> 		convert_64bit(fs, feature_64bit);
> -	return (ext2fs_close_free(&fs) ? 1 : 0);
> +	return (ext2fs_close_free(&fs) ? 1 : rc);
> }
> --=20
> 2.33.0
>=20
>=20

