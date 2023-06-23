Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA46A73AE2E
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jun 2023 03:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFWBGL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Jun 2023 21:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFWBGK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Jun 2023 21:06:10 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1075F10F4;
        Thu, 22 Jun 2023 18:06:10 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55380677566so120862a12.3;
        Thu, 22 Jun 2023 18:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687482369; x=1690074369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvhuIIVvKv0fuQ+6tTOIBoMGzj6AvWTNCnkT84dvlWk=;
        b=XErsvJ4DdWRzfegm18+ppDABJi95b1Qg2ElH45DtvpWdaxcbDFT6KND169FegrvhYg
         LpSD6sp7i9vzmpqSDgDgJKnWpc5Y1JdNqq7guQFw2zr3+v8SGXY2oO4fsRE5MpGHMzJA
         4/xj6p5uibtWgepAI7WPEV+w61/XaSFxlWMhjAmtKcmTIdv+VTZxyNPW01h+XCFZ1VhL
         TCTLJM0Yhk6p6IkyQkbY1S3b7u4QRWPDl1cE4E6SYLPf5uuHIa2aLNjsg8M3/YkgGqf/
         Q32FtJ9xBROtRxGrd7e0dVlPc6nLTcgbt4HXSfxyb9zeOKy1EuhFEJkGWiBxfDMPflwP
         mKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687482369; x=1690074369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvhuIIVvKv0fuQ+6tTOIBoMGzj6AvWTNCnkT84dvlWk=;
        b=kUofsu5vgU71XN5HVW40b/2q/AGez5ursy8E6l/L8GYXAhT4HL5Aqk9y7ZUZRabrzd
         Cz/jsZix4wmzAFpQaMg356eeA7aDsQr+mwlAyajhJRczbH4YViYznENvkNsha9ZRWI/3
         w6m4ZGd+QZdCwSY+99Jb3ANdQRLCSbwf2I4E99guX+PGvxaI264+8O4sfgFxG/te7gH4
         BhPEshl7aeoAwQeZMk4l93uRRB8opiXfcfPZhTPiYkW4LG467Hsh4pzSYFzxGSw9Www9
         TyCsAu1IOYoi0AdDlr+MVeHFrMVcQ1CpulsULA6HoAdGOBgZUXQChwxBh7+H52yAPTZF
         AXlQ==
X-Gm-Message-State: AC+VfDweMdncMUADS6ud0q66QwNhIO35JSlSDcFDLRCuwySNlxl/itsZ
        0VDgMY71ZuGfVxzXgu6jF8Q=
X-Google-Smtp-Source: ACHHUZ6sj6zZAJmnu/bn+OZ7d9vsFPzQGo6z+Gj7R8ENWzV89+QgiLfebpcvgrTXmEQqTt7LCgOVEA==
X-Received: by 2002:a05:6a20:7d8b:b0:122:6de4:125d with SMTP id v11-20020a056a207d8b00b001226de4125dmr10362491pzj.19.1687482369279;
        Thu, 22 Jun 2023 18:06:09 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id bb5-20020a170902bc8500b001a0567811fbsm5576623plb.127.2023.06.22.18.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 18:06:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 910E48B2EC0F; Fri, 23 Jun 2023 08:06:02 +0700 (WIB)
Date:   Fri, 23 Jun 2023 08:06:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sean Greenslade <sean@seangreenslade.com>,
        linux-ext4@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: RO mount of ext4 filesystem causes writes
Message-ID: <ZJTv+it2x/glkmpp@debian.me>
References: <ZIauBR7YiV3rVAHL@glitch>
 <ZIa5P1HqE62rmzqu@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oHvmzLVb4TIpJ2OW"
Content-Disposition: inline
In-Reply-To: <ZIa5P1HqE62rmzqu@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--oHvmzLVb4TIpJ2OW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 01:20:47PM +0700, Bagas Sanjaya wrote:
> On Sun, Jun 11, 2023 at 10:32:53PM -0700, Sean Greenslade wrote:
> > Hello, folks.
> >=20
> > I noticed a change in behavior of ext4 in recent kernels. I make use of
> > several luks loopback images formatted as ext4 that I mount read-only
> > most of the time. I use rsync to synchronize the backing images between
> > machines. In the past, mouning the images as read-only would not touch
> > the backing image contents at all, but recently this changed. Every
> > mount, even ones that are RO from the start, will cause some small
> > writes to the backing image and thus force rsync to scan the whole file.
> >=20
> > I confirmed that the issue is still present on v6.4.rc6, so I performed
> > a bisect and landed on the following commit:
> >=20
> > > eee00237fa5ec8f704f7323b54e48cc34e2d9168 is the first bad commit
> > > commit eee00237fa5ec8f704f7323b54e48cc34e2d9168
> > > Author: Ye Bin <yebin10@huawei.com>
> > > Date:   Tue Mar 7 14:17:02 2023 +0800
> > >=20
> > >     ext4: commit super block if fs record error when journal record w=
ithout error
> >=20
> > That certainly looks like a likely cause of my issue, but I'm not
> > familiar enough with the ext4 code to diagnose any further. Please let
> > me know if you need any additional information, or if you would like me
> > to test anything.
> >=20
>=20
> Can you show dmesg when regression happens?
>=20
> Ye: It looks like this regression is caused by your commit. Would you like
> to take a look on it?
>=20
> Anyway, thanks for the bug report. I'm adding it to regzbot:
>=20
> #regzbot ^introduced: eee00237fa5ec8
> #regzbot title: commit super block writes even in read-only filesystems
>=20

Hi Thorsten,

No reply so far from the culprit author (Ye Bin) nor from Ted. Can
you help in this case?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--oHvmzLVb4TIpJ2OW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZJTv7gAKCRD2uYlJVVFO
o0k2AQCp/yGtFABFS0mWI8CAR7Iw6rXZ7YzDVYLumcrnHz7X/wD/bHBNW5DJFBe9
ThtrVO1RQ+VBOE2LY2hLK9CHgsXOWwI=
=9Qko
-----END PGP SIGNATURE-----

--oHvmzLVb4TIpJ2OW--
