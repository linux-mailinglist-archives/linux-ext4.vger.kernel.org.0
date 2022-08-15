Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885A1592BCF
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Aug 2022 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbiHOJ1R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Aug 2022 05:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiHOJ1Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Aug 2022 05:27:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07C51BEAC;
        Mon, 15 Aug 2022 02:27:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f65so6054505pgc.12;
        Mon, 15 Aug 2022 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=n8OcJOQcp/vvTFlnm7zIuv3uiuVOqAzl5JtUGDcvcy8=;
        b=mtIxoMtD2/2/pRfnUI/Q6pzAJi+GmyYRBz5aRINPa6QniHTskAuYALqSGWS4bAhUeA
         hxbq/oM+gd78WwO6K7r3iia8cPxNW3hKEXs7PibgPMaH0YshWZLZ7Ke2olzxhKZLNXOi
         sTXmvWD/N/YK3czyiU+/Q4NimfnZLdrCMEmk+WL76LZ+q+qYOJ5zQq6huYXtj7pkJyrO
         A7Q2uFLVyajx6h7kcfoelSEXuPixjn4XAjbR1Shb32fd87yp6iGrlxFxyvFdtVPr8D1U
         Q3f+ELDOgnefrn905cWvLkn92jmmWim6NurCNVIYvmAj/z/nR3uPMxQWtqJeNZWDs5B8
         XfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=n8OcJOQcp/vvTFlnm7zIuv3uiuVOqAzl5JtUGDcvcy8=;
        b=Luw3jq7gPuXqVZ138ZlqvZaMnRdueWOm036CjPkT3Uct2teVyHIY1+cyugcoewkNcn
         9EwQ1vHRGWA5rBs35kQW0EO7eEFQOhQGS0Ba7yJCpIQ8XOCvgqnRapJhLlmiTly9xIvV
         LZk1QGe8Qk4NTqiad7iGU2hcYaEf6OhQEJ018vUX46DW1W8IqtBECFpNyCRJxZIeao4F
         QAHA2UKbBqcnC9CRzMSdmW4q7e2flZ+I98xM5zaexXOWuOTrUc4ZSu7c7KCOZbb5OXNP
         kYU0pXxgBz5hGUSSJ0CT4+dRPXBbyLE21HSLFj81FHkAsF4xY03D1AsmaXVKclmo6SDt
         dttA==
X-Gm-Message-State: ACgBeo3G46HDh5ILCUHKbxqSucBvOv+rrC6xiocVAFhEsyDc+nPxlJ7e
        TGPsQz/txLqgDk2wjzu6UMY=
X-Google-Smtp-Source: AA6agR7Bl7wV2BAb7RqLNP40SdjfbSg8ixJDejACFzl3RyQEJeNdSHFv+E1rhU07haQzIzKPmUR60g==
X-Received: by 2002:a05:6a00:10d3:b0:4fe:5d:75c8 with SMTP id d19-20020a056a0010d300b004fe005d75c8mr15985771pfu.6.1660555635346;
        Mon, 15 Aug 2022 02:27:15 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-81.three.co.id. [180.214.233.81])
        by smtp.gmail.com with ESMTPSA id 196-20020a6218cd000000b0052b94e757ecsm6212563pfy.213.2022.08.15.02.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:27:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0B039100014; Mon, 15 Aug 2022 16:27:11 +0700 (WIB)
Date:   Mon, 15 Aug 2022 16:27:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Wang Jianjian <wangjianjian3@huawei.com>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] ext4, doc: Fix a broken layout
Message-ID: <YvoRb8crZvjC/Vo2@debian.me>
References: <d3ec14afe2396272da6353162b3081a0c92de313.1659248273.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OVZiTBs945otpzH1"
Content-Disposition: inline
In-Reply-To: <d3ec14afe2396272da6353162b3081a0c92de313.1659248273.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--OVZiTBs945otpzH1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 31, 2022 at 08:18:24AM +0200, Christophe JAILLET wrote:
> The commit in Fixes: has removed an escaping character without updating
> the layout of the table.
>=20
> Add the missing space.
>=20

Hi,

This has been already fixed on mainline by 19a7cc817a380f ("KVM: x86/MMU:
properly format KVM_CAP_VM_DISABLE_NX_HUGE_PAGES capability table"). Thanks
anyway.

--=20
An old man doll... just what I always wanted! - Clara

--OVZiTBs945otpzH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYvoRbwAKCRD2uYlJVVFO
o0pOAP98VOUTDIqJNISo55J/KGTjrnBvKdcyoUkBo+Yq7mR2+QD+JuMIQLb1L7Ko
musjRK2zf28QeocGk9ohfJ4mRE169Qo=
=R5Os
-----END PGP SIGNATURE-----

--OVZiTBs945otpzH1--
