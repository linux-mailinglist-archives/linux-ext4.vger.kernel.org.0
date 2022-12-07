Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3AB6454B2
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 08:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLGHhk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 02:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiLGHh0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 02:37:26 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A72D77C;
        Tue,  6 Dec 2022 23:37:25 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so774028pjb.0;
        Tue, 06 Dec 2022 23:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5MM7TPYGn4Pa35lkzDBb6EZuN1ITkF1p9suU6CJais=;
        b=b5JBbzF5a0e20rniKEc/3fu6Mo16sJB136mGDyYz1Zt4u/D7YbcyOkQNMMYVCyyrPp
         7A5SmEZ9IiTOsv8OleeHR4Fu+uj5VLpGLd9WMi3d4EJLS7zhGpv2XS9HKWukrnjorg6g
         1nmN2oQLU5t45fSOgDtOiVXt/jfNwgkCTZb/4BoeFgNuazqpTtHqz4bUEr6Ocp8KBGQC
         6fKVMCrOs7AGxSoRrjjpbcJ7w8CfM7J7wrlWiHWDJiXzDU1CBe5t+xG1aB6cAztx/Jna
         hyClEK0eQd18vV3YCMumPq/PxZQKwnoEt5FwXKdSBK4VSEPxU2yLd2W4QGBojyHxE76M
         UCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5MM7TPYGn4Pa35lkzDBb6EZuN1ITkF1p9suU6CJais=;
        b=s7HBegGaEv+UpUsUHwmdLbgD8AMZ6jUQZ1f18RlFRpOIGslbtK4l/5IDhNwlPAuCnx
         nnkLkIaG08D2EMr4owkm1dKdZT+uj9T8PTzgy+NcTpqbKrTWxaERMUAihNJyNiqvZJZo
         tPKubVZW6qyRwauLkMcckQpTmloHLppbo8v95Sge9WX419PAv7KqFcD+Lvyt9x0Kf//O
         6TB0HVNgfAZPK0+1oerdXfvq5Ve9bCayew1ETpMHMtt7qIROjx3vT2+n9cQWvyM6ZCHt
         WXBENT0T8VMe/1b/0rWprKmwzX13aNEEcpXI/MwjBlRjdmzMvrvkmg/jdztO2lc0/loF
         8QFA==
X-Gm-Message-State: ANoB5plOpEHG/20hMC+uxhI12ja7yVEaUNGa6BYASNLe1wKC/ps8wft2
        MwN/tcqQw7KqILTPvwHPOb8=
X-Google-Smtp-Source: AA0mqf4E/n1XjLfptg9l1Imu3jjwj+jjTb30vrmGdBS9J8cMZQMDfVcSWJlSWRKv+EqswbzG/LVCPg==
X-Received: by 2002:a17:90b:2541:b0:213:30c4:e803 with SMTP id nw1-20020a17090b254100b0021330c4e803mr101863079pjb.209.1670398645129;
        Tue, 06 Dec 2022 23:37:25 -0800 (PST)
Received: from debian.me (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b001897916be2bsm13889007plg.268.2022.12.06.23.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 23:37:24 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2191C1042C6; Wed,  7 Dec 2022 14:37:21 +0700 (WIB)
Date:   Wed, 7 Dec 2022 14:37:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v2 2/6] ext4: add primary check extended attribute inode
 in ext4_xattr_check_entries()
Message-ID: <Y5BCsVBKUuTHi/nY@debian.me>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
 <20221207074043.1286731-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+0NQJA3uoBiQc2lL"
Content-Disposition: inline
In-Reply-To: <20221207074043.1286731-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--+0NQJA3uoBiQc2lL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 03:40:39PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>=20
> Add primary check for extended attribute inode, only do hash check when r=
ead
> ea_inode's data in ext4_xattr_inode_get().

"..., which is only perform hash checking when reading ..."

--=20
An old man doll... just what I always wanted! - Clara

--+0NQJA3uoBiQc2lL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5BCsQAKCRD2uYlJVVFO
o88zAQCRqwm2uLVscmYAvfUkFgA66HfecQRlf6FGrFKNDyfHRwD/WIfBBjiA9MsY
6WXzKt9Dz5Y+XaUHJJ/d3aKkYpRadw4=
=6d5P
-----END PGP SIGNATURE-----

--+0NQJA3uoBiQc2lL--
