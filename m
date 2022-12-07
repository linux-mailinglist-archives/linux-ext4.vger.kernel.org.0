Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9866454A6
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 08:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLGHf0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 02:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiLGHfI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 02:35:08 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18D2AE39;
        Tue,  6 Dec 2022 23:35:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so740873pjd.5;
        Tue, 06 Dec 2022 23:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZrF7oXJiczkGAEAp6okQb1rCRRzIpLB6iIyJkiyYBo=;
        b=laYAyzvc+Ajp/Qs7j/MJsyuSkp0J4Jk4TDqAvKCSCuhUALua5MvY18vqHX6cHHuQEi
         mQ+yMXT6GmDgTV5BBGfASb6vSqBzuXOK5FJa4vzvdcOjioZ19wOG871A7VDNznh9p7Xm
         da25qMd/sMMZjo13h5CvJB0V9XT5Ofr/+OxS7fxkGcHkJcDOve3xCpOr4e1WRW7sCRyb
         hmtbbeIFCCTun5LSmph8g10z0zonnb0wF5Zs/8QyMl+MwS0uoFEqbuAJNSSbIY50VOHS
         V9gzHVMdPrP8jq6epfV4uRwoyS8XCTyE2s/hHsW5vdt8ByqF89rDZ2IXsKMFMmq6nwH/
         R3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZrF7oXJiczkGAEAp6okQb1rCRRzIpLB6iIyJkiyYBo=;
        b=O5OL+b6J/9ivWqaLZL2MR0/AUdsIkII4xEo5eYpKcasnPo5JcinewMf2YDDr9MYIHo
         6bf21UBdfa5kFky+K8IZy/kpODNqAP0bRVxKfhFf0YHSe4S2XQNA2LLbgKS//9zc3u0o
         SGATdS532eM4kXtbi3RtfKjBXMNoLZwUzaOSFHGSGMu3RckpGQnlbhinp5Cl8Y917a5d
         /AqXsj4mdcWeysfy6fKOcoKCIDhdBf0czDrrqqU/F54+N50KoxlaX6amzQ34VL9QtiKa
         UhYKbtfrQ2kKLMcFkxvVcP+KGsJ3L+cDmDFB2ZuQGJbf8matcTL4s+C+S/OQ61Nvm/fr
         9fGg==
X-Gm-Message-State: ANoB5plEpw9EwBE02Hhq1cnGgRijUDcV1mTPqbZDIaMh4jx4NaNnIkEv
        0tVKZqFf83ZqYJd6iZTtt7vGtRaQpYs=
X-Google-Smtp-Source: AA0mqf5Z+2efEZznUwcu/uE/m25vhOEEe8s8gJIxRsg9fOPTHQ9RX2X8QLQfYCZRvPtsnCy8QWeYHQ==
X-Received: by 2002:a17:902:a989:b0:188:d4bf:dbfe with SMTP id bh9-20020a170902a98900b00188d4bfdbfemr72636333plb.31.1670398506742;
        Tue, 06 Dec 2022 23:35:06 -0800 (PST)
Received: from debian.me (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b00188ef3ea2b6sm13733241pln.262.2022.12.06.23.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 23:35:06 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id AB9101042C6; Wed,  7 Dec 2022 14:35:02 +0700 (WIB)
Date:   Wed, 7 Dec 2022 14:35:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v2 5/6] ext4: rename xattr_find_entry() and
 __xattr_check_inode()
Message-ID: <Y5BCJja2oxI6p8EP@debian.me>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
 <20221207074043.1286731-6-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yAUBd0KfIXzRG67a"
Content-Disposition: inline
In-Reply-To: <20221207074043.1286731-6-yebin@huaweicloud.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--yAUBd0KfIXzRG67a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 03:40:42PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>=20
> xattr_find_entry() and __xattr_check_inode() is in EXT4 xattr module. so
> add 'ext4' prefix to unify name style.

What about "Prepend ext4 prefix to xattr_find_entry() and
__xattr_check_inode(), since these functions are in ext4 xattr module."?

--=20
An old man doll... just what I always wanted! - Clara

--yAUBd0KfIXzRG67a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5BCIAAKCRD2uYlJVVFO
o1q2AP9OCsBqI3xnJN8LzepLK4M50OTJ80QelFu0vR7/EyPQjAEAkR+OCt+bNzOe
KAp0W4BnsO7uxdsI0TyPfGyeyos6Vww=
=Y9RF
-----END PGP SIGNATURE-----

--yAUBd0KfIXzRG67a--
