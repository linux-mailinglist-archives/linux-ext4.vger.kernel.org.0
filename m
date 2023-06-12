Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4172B90A
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 09:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjFLHsv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jun 2023 03:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbjFLHsj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jun 2023 03:48:39 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E820C10D9;
        Mon, 12 Jun 2023 00:48:10 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bc4e41b7bc9so2136600276.2;
        Mon, 12 Jun 2023 00:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686556017; x=1689148017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/JK3TU7YFRj/e68GIZTEHv4xrVfCyD4VBzaHU6EBRGQ=;
        b=dCSrVUixVhQ5Mr7sKm1SiHVnRZW9AXdSziFXvMroaucvk1TNbjj/JXgoAnMnItrPxE
         vNcvwvg7uM8wVOjJcF616s65EfhB21156DevNt6ER7p4BT0K02uIaiiWtgFjL9A5rsdt
         LPF/egVtU+MiXFuzrksZbJrSzqBdhe9qMEP4tFS7O5I7mCp+baNTYro8wC/p9RwMIu2y
         YBe6O+gSmRO936m8IvtaNYMLt8u8em9SIxM81f/St3+zXfbheFTzq4fVJorZEnHBnUv8
         ZKLO897nH2h1o/XTgsp99ok/8PXUZQPyC6q2lz1/VhOK+0Go+M9W2FGLe+ca4lmWKCsU
         Dq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686556017; x=1689148017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JK3TU7YFRj/e68GIZTEHv4xrVfCyD4VBzaHU6EBRGQ=;
        b=PBiAqgeYEDqqdqNRLsu4jKOIco2om/Y4qkTQqpfDsm8LmxcDzhtMCNUPQtQYk0QG7C
         eT+Bnt1074LaWLKDVGdORbR0zPucWL94nDT4udFNrljq+lRs3q//ipIpOtPckyTMavhJ
         Mnj0o7sdw7JiPp2VWf8aE5lHpRlzwyA3nYBSobwxwEa2VEuyR7zs5qnxOHxVrMopstDN
         ZRFVhNNFr9O0rL6ogTzkkRVvEZY89mAK87/slbYzYasvpIA3XySHyCZScRqbOdphsL9G
         qUqWyY3gd+dxrt08r3ncP7kDQ5MdPnfnV6ExnnCTn/aQDrkqPDaLksVtVPLTnJ+fW8h5
         E/OA==
X-Gm-Message-State: AC+VfDw31rJg4npqbBbtDgfa5DkrZGoKLXkMa0cclxQ4dMdCcOeXpEN1
        uiLaYaFvMGoRQPV/o43D3uRZNl/LS3Q=
X-Google-Smtp-Source: ACHHUZ47hq6fy+3dOE/9k3HLlR5J6NXUjY5+c8Xdb8hoek4U+8usGCZMz9GYBPy/DFFGlsARY+FkSA==
X-Received: by 2002:a05:6a21:6da3:b0:10a:be5c:6e2d with SMTP id wl35-20020a056a216da300b0010abe5c6e2dmr9208618pzb.39.1686550854098;
        Sun, 11 Jun 2023 23:20:54 -0700 (PDT)
Received: from debian.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7880e000000b0063d46ec5777sm6162834pfo.158.2023.06.11.23.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 23:20:53 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4DE28106C10; Mon, 12 Jun 2023 13:20:48 +0700 (WIB)
Date:   Mon, 12 Jun 2023 13:20:47 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sean Greenslade <sean@seangreenslade.com>,
        linux-ext4@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: RO mount of ext4 filesystem causes writes
Message-ID: <ZIa5P1HqE62rmzqu@debian.me>
References: <ZIauBR7YiV3rVAHL@glitch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oXjBG6aBq0cIy8y4"
Content-Disposition: inline
In-Reply-To: <ZIauBR7YiV3rVAHL@glitch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--oXjBG6aBq0cIy8y4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2023 at 10:32:53PM -0700, Sean Greenslade wrote:
> Hello, folks.
>=20
> I noticed a change in behavior of ext4 in recent kernels. I make use of
> several luks loopback images formatted as ext4 that I mount read-only
> most of the time. I use rsync to synchronize the backing images between
> machines. In the past, mouning the images as read-only would not touch
> the backing image contents at all, but recently this changed. Every
> mount, even ones that are RO from the start, will cause some small
> writes to the backing image and thus force rsync to scan the whole file.
>=20
> I confirmed that the issue is still present on v6.4.rc6, so I performed
> a bisect and landed on the following commit:
>=20
> > eee00237fa5ec8f704f7323b54e48cc34e2d9168 is the first bad commit
> > commit eee00237fa5ec8f704f7323b54e48cc34e2d9168
> > Author: Ye Bin <yebin10@huawei.com>
> > Date:   Tue Mar 7 14:17:02 2023 +0800
> >=20
> >     ext4: commit super block if fs record error when journal record wit=
hout error
>=20
> That certainly looks like a likely cause of my issue, but I'm not
> familiar enough with the ext4 code to diagnose any further. Please let
> me know if you need any additional information, or if you would like me
> to test anything.
>=20

Can you show dmesg when regression happens?

Ye: It looks like this regression is caused by your commit. Would you like
to take a look on it?

Anyway, thanks for the bug report. I'm adding it to regzbot:

#regzbot ^introduced: eee00237fa5ec8
#regzbot title: commit super block writes even in read-only filesystems

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--oXjBG6aBq0cIy8y4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIa5OAAKCRD2uYlJVVFO
ow0cAQC7IbRS13IAEmBezzjzEsFelZvVP5CenQsOEP8upCcnJgD9F7Q7Prz3KHjS
cfIlPECSx7tGH7s1tiQymT3LZ/C78w0=
=/u+c
-----END PGP SIGNATURE-----

--oXjBG6aBq0cIy8y4--
