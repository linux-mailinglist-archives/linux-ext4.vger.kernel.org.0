Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5E778B24B
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Aug 2023 15:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjH1Nx3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Aug 2023 09:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjH1NxD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Aug 2023 09:53:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABCEE3;
        Mon, 28 Aug 2023 06:53:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a6f6a66e1so2272021b3a.2;
        Mon, 28 Aug 2023 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693230780; x=1693835580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FmnTH4U9OSJhGxAibPkRaPpwtt5dIptHO+rY27erzo=;
        b=Mjom9tYhcWSUwzV14X18el+3OX+n9997CG0Ii5zZODB2SvTtK/ybTzdMj7+7K47RA3
         wSPtzFE9il4sbnIb/ecIBzvlne0dEg56jQG5k4ZUjCmA4vRsJ2yBrUiJM0c+4izjfG+u
         DOdvJn1WY8SMK/s+f6onEID3W+OM59OEmdkM3N9WDjNJUfcX5MEuAsPDubDfw4KsHHWx
         SnNecqcp4jOMYU+PVUP3jhMujRohsqvkJvA3Vg2+Swylxs9/IiOS1VQ8bIhfyRohGZmm
         4S/BnfgdQ7EGJrPRUVgilPg4db048/eqxKmR4XVFqaUgL8blGgeSDorc0/em51YcIAH5
         RQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230780; x=1693835580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FmnTH4U9OSJhGxAibPkRaPpwtt5dIptHO+rY27erzo=;
        b=IMXQVkO19HWEEVPHUX/jnzPwU3cJMGQrlpCvAawxQLo0OihF/SuTfZY8DYW3m91EWf
         wZMlj1mtt2kDdcJrKXkzQORGJh6BpMeVBGTcx1XVKAnpJi5a0OObv1UIC3jeszaMXR2D
         jDxy1OWZh6g8eeRN8v768ja89V6EULIPwkcvyjutOjFfs7D802piT7P3jsv6Uxzb5D2n
         m37fioaBU1SP0PdELApRjRLsY4khLuI9Tp0UX4caBmvGKZ23iaIfAGxLDWczypLTQUF3
         a3wC5NPMBMSQXfvl3fVF0FOvOUnELGU+acnZJyuMi8655gqXZkkbAKCrmVhutbIw+L4W
         JLZQ==
X-Gm-Message-State: AOJu0Yz4RQHlcfUqJKunrgDdMGatT6Nuy8eKlUhj1swzwgrcUy0qpYCx
        61LpztJly82r8ryH3PSENwYAlv2EVhM=
X-Google-Smtp-Source: AGHT+IGwe6fMpNwLXLqG9W9bii5SM9SpBYM153qClnV57jqRshve66AaWDXjUK10BPKKg0JBE957Cw==
X-Received: by 2002:a05:6a00:b8e:b0:68a:530d:a39b with SMTP id g14-20020a056a000b8e00b0068a530da39bmr20706157pfj.8.1693230780198;
        Mon, 28 Aug 2023 06:53:00 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7800c000000b00687dde8ae5dsm6650080pfi.154.2023.08.28.06.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:52:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BF47A9ED5C53; Mon, 28 Aug 2023 20:52:54 +0700 (WIB)
Date:   Mon, 28 Aug 2023 20:52:54 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Dr. David Alan Gilbert" <dave@treblig.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Theodore Ts'o <tytso@mit.edu>, hch@lst.de,
        adilger.kernel@dilger.ca, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Message-ID: <ZOymtgiZYGQ6QlxN@debian.me>
References: <ZNqWfQPTScJDkmpX@gallifrey>
 <20230815125146.GA1508930@mit.edu>
 <ZNt11WbPn7LCXPvB@gallifrey>
 <ZNu668KGiNcwCSVe@gallifrey>
 <ZNwm7Mo9yv7uIkno@gallifrey>
 <324fc71c-dead-4418-af81-6817e1f41c39@kernel.dk>
 <ZNzg1/zhxYV2EkBX@gallifrey>
 <ZNzl2Sq9UJ3FiTgV@gallifrey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Iq+/xu6Yd8z1UumD"
Content-Disposition: inline
In-Reply-To: <ZNzl2Sq9UJ3FiTgV@gallifrey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Iq+/xu6Yd8z1UumD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 03:06:01PM +0000, Dr. David Alan Gilbert wrote:
> > > Can you try and pull in:
> > >=20
> > > https://git.kernel.dk/cgit/linux/commit/?h=3Dblock-6.5&id=3D5ff3213a5=
387e076af2b87f796f94b36965e8c3a
> > >=20
> > > and see if that helps?
> >=20
> > <testing....>
>=20
> Yes it seems to fix it - thanks!
>=20

#regzbot fix: 5ff3213a5387e076af2b87f796f94b36965e8c3a

Yet, I don't see that fix commit on v6.5 release...

--=20
An old man doll... just what I always wanted! - Clara

--Iq+/xu6Yd8z1UumD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOymrgAKCRD2uYlJVVFO
oxazAP9NpxTwVV8bQ0KBj16fxHi9bhqrOUF6EQpBC5d/SRa/4gD+LVhHGbh71kaq
grxoLg4y8ejZXf4+uKYHP3w7avGIJAU=
=yJub
-----END PGP SIGNATURE-----

--Iq+/xu6Yd8z1UumD--
