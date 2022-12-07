Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2486F6454BE
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 08:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLGHlh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 02:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGHlh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 02:41:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751FB1A831;
        Tue,  6 Dec 2022 23:41:36 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so762730pjm.2;
        Tue, 06 Dec 2022 23:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65HmRJXtq0DWw8S6G7RRwmt1dsKtm0mfOzvHD9YTrOM=;
        b=hTRYRNlC/EoU6FHn7pY06XhdG4d1ko/1UAwopLB90Kk/vAIIBzYEgkHwdbpQKHGdmV
         Ph7z8zcOF7aDbS5KJzSjlpDUwG+Ew+KBKxEEOdMio2vZ0VExOUpZKwuRXkrwTZWv4Ka7
         l/Gtk/DhgJXyGEo0oLXFTgfsLdXlFu+EQQvLMZYBbYd4e8Evqy/dO0DgF63WyUW1hN9z
         J1fucBFbH310L6ifI64mgEGeWT9ZOO7hwY7csrwfVJKMBv6C9sQ6nfIFUYrSHakqmZoe
         42FNr8g216SzcGTVzexl6fT4LNCvppWikJvWuVLdhQXtCIfXs7f7mj33bNE/5EsIMKRS
         CtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65HmRJXtq0DWw8S6G7RRwmt1dsKtm0mfOzvHD9YTrOM=;
        b=D6Xs/Iur1zi2V+qTVYfPxmEsEQt0+PwbEPJBAZZSJZ42i+uzGheCd0zEmEGPHS3jAz
         rM7z9o9xBo/5N/1qFUrI2FBlhU3IgdjU2H7cfVa0I+ecSAK7kO4bqq74TQx6X+UfL49x
         C3YDwCJ0J4roAEkApnX77hlxoxkkepkzvprEKNdUW2Wok7JMTodTA3VflvBRIEl2f42G
         Hivf+f3BWD1lb2WB9CR8o9eucnFRg2jdp5CB9eUg5r3yYbVot8iyKHAEkl+byg1626a9
         FPbo8RApzgexiit6ED7eUgNM8K3EyyslQ9R7h4lKlr67jUYzySVHzVHyo0eadGwfFja9
         QvgQ==
X-Gm-Message-State: ANoB5pkjtn0t9CdBzwtLPGhbBQ1DP7/jBbQg8G+Za8ymEvs2nMJ2vARs
        yWuMCKlGKLqd7uwMyAlhqfA=
X-Google-Smtp-Source: AA0mqf7Qz/m48SMHxfQF0qPeORkG0CUR7tn6vS+iuQ86G+iurQU8vHySBl0SuQDXBGxgLjqrYRZydQ==
X-Received: by 2002:a17:903:41c8:b0:187:3932:6422 with SMTP id u8-20020a17090341c800b0018739326422mr73447094ple.135.1670398896019;
        Tue, 06 Dec 2022 23:41:36 -0800 (PST)
Received: from debian.me (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id t7-20020a625f07000000b005625d5ae760sm10604163pfb.11.2022.12.06.23.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 23:41:35 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id A332F10444C; Wed,  7 Dec 2022 14:41:32 +0700 (WIB)
Date:   Wed, 7 Dec 2022 14:41:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v2 5/6] ext4: rename xattr_find_entry() and
 __xattr_check_inode()
Message-ID: <Y5BDrFVf9wtWK0Ld@debian.me>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
 <20221207074043.1286731-6-yebin@huaweicloud.com>
 <Y5BCJja2oxI6p8EP@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FWmByTGCb/bAbDcI"
Content-Disposition: inline
In-Reply-To: <Y5BCJja2oxI6p8EP@debian.me>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--FWmByTGCb/bAbDcI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 02:35:02PM +0700, Bagas Sanjaya wrote:
> On Wed, Dec 07, 2022 at 03:40:42PM +0800, Ye Bin wrote:
> > From: Ye Bin <yebin10@huawei.com>
> >=20
> > xattr_find_entry() and __xattr_check_inode() is in EXT4 xattr module. so
> > add 'ext4' prefix to unify name style.
>=20
> What about "Prepend ext4 prefix to xattr_find_entry() and
> __xattr_check_inode(), since these functions are in ext4 xattr module."?
>=20

Oops, I mean "Prepend ext4 prefix to function names of
xattr_find_entry() and __xattr_check_inode() for consistency with other
functions in ext4 xattr module."

Sorry for inconvenience.

--=20
An old man doll... just what I always wanted! - Clara

--FWmByTGCb/bAbDcI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5BDrAAKCRD2uYlJVVFO
o2Y5AQC0PRilUfvCXARt+10hb6wzESJNxnTY3G0t6/0VfFcU9wEA9sKiMEhyO0Pu
pM9TZToOjgA6LgkituEnAHWS+NG4Egg=
=WdmZ
-----END PGP SIGNATURE-----

--FWmByTGCb/bAbDcI--
