Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FCB6AB503
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Mar 2023 04:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjCFDSD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Mar 2023 22:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFDSD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Mar 2023 22:18:03 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29F86A4D;
        Sun,  5 Mar 2023 19:18:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso11830827pjb.2;
        Sun, 05 Mar 2023 19:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678072681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KQzd9XueLqI63AeDIMil5F/+DkbaEc2qfGIFqYE5OI=;
        b=hNNvm2vUJ8ZBjimgo1npA8fVR8lW2pk/HMbY6dWwlZD2U/VDXE6N3v2JCVmvTDtTDV
         Op1I03n0jT6tY6f2dWezrLqU3wHd1q0afsF2F/E/gco26XHRVRf4tNZNZRyzVlAjpinE
         /I2H8WjV6vq99AnQrwPqEOJSBK+p6TiAXL7C8wmWWEKSuHFw0eTH1MhzI0bh/wVB/1/x
         39e0wLQT2FMBPrOIf9GdTsOLcYP6CRmXOyenwIUCEZ9Y42u10qjKj9rJO2zFrQ40TPxl
         kVY+wa29zvGm46+a1qrQ648jwd9QqSAyAWHYkUHhtXViBUNRYWByQVgpmqSQIIhZYDd8
         s+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678072681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KQzd9XueLqI63AeDIMil5F/+DkbaEc2qfGIFqYE5OI=;
        b=MUzYEJJUYh79tDQ5dOmX3jv20v3Nc0cFXcaRST+bVTRJuU524Wf1D15CfR6IdKnl/Z
         AYrhbEBo+IJsmmJY2Joze4KNGukmX9Uz+k/gVinSqEwtFDUWOKUqfeY2oQImxybeGOXh
         JV+noJVx293iCBZznjzJ90V82VuSRWXzcv5yZz4HeOpbUgZMb8ZZ3BrMeXfL8dL4IzQF
         eeFAv0GyU7Ipw3BUsA8+wSMERGJU02d0Buad4asSedz6ttTfqT766b5Pu6x78EELrIns
         bGMSnLmHiheVbwqSWseQOarjAlaUdSJlCnxiFhJWWM+eA6GlzWxfNMqGe+B29Lap9MjV
         VkVg==
X-Gm-Message-State: AO0yUKWyVz2+2fNzWgTrHssqkp8j/kSgQGlg9N1nNFP7YXpujg5EYmOp
        SqzCnjPULDZxWTN8cw6GV43WJMAy+WM=
X-Google-Smtp-Source: AK7set+LVVTNqr6aoI6BmNRE9xggFXF9QUVLWnl+MDQDGFIUvMfdxcsF6by2kLQ5a6d6BQudUdfHYg==
X-Received: by 2002:a17:902:ea02:b0:19c:c8c8:b544 with SMTP id s2-20020a170902ea0200b0019cc8c8b544mr12451217plg.64.1678072681382;
        Sun, 05 Mar 2023 19:18:01 -0800 (PST)
Received: from debian.me (subs02-180-214-232-85.three.co.id. [180.214.232.85])
        by smtp.gmail.com with ESMTPSA id ko7-20020a17090307c700b0019a6cce2060sm3449739plb.57.2023.03.05.19.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:18:00 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id DDC7A106595; Mon,  6 Mar 2023 10:17:56 +0700 (WIB)
Date:   Mon, 6 Mar 2023 10:17:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ext4 Development <linux-ext4@vger.kernel.org>
Subject: The state of ext4 tree merging (was Re: Linux 6.3-rc1)
Message-ID: <ZAVbZJSyOdF0BxAJ@debian.me>
References: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K1nqM47Qf7ezryjK"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--K1nqM47Qf7ezryjK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 05, 2023 at 03:24:41PM -0800, Linus Torvalds wrote:
> In fact, it was quite nice in a couple of ways: not only didn't I have
> a hugely compressed merge window where I felt I had to cram as much as
> possible into the first few days, but the fact that we _have_ had a
> couple of merge windows where I really asked for people to have
> everything ready when the merge window opened seems to have set a
> pattern: the bulk of everything really did come in early.
>=20

Not so for me watching updates to ext4 merging hell...

In this merge window, Ted only submitted the first part of ext4 updates
[1] as noted in the resolution message [2]. The second part didn't make
through the merge window (PR not sent). As such, the data=3Dwritepage
cleanups have to wait for 6.4 merge window, and it is IMO inconvenient
for linux-next to contain ext4 tree from next-20230217 for about
seven weeks, as any enhancements and fixes applied to the tree are
holding back from testing in linux-next until this hell can be sorted
out.

In the long term, I'd like to see a co-maintainer step in to help
maintaining the tree in case Ted is busy. Of couse I'm not eligible
for that role (I played as documentation janitor instead), but
any developer with deep knowledge and experience for the fs and its
internals should fit the role.

Thanks.

[1]: https://lore.kernel.org/lkml/Y%2F2CN+FpmGsfzgdE@mit.edu/
[2]: https://lore.kernel.org/linux-next/Y%2Fk4Jvph15ugcY54@mit.edu/

--=20
An old man doll... just what I always wanted! - Clara

--K1nqM47Qf7ezryjK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZAVbXgAKCRD2uYlJVVFO
o5LTAQC1Pe5CNLI2h3bQQD3C3AnoAuWiOqaghCSbN7fG88PBmQD/cb6Ux3PAGrRU
rG3n9SP4sB3l7TfyphAyo+hwFoJOeg0=
=29nc
-----END PGP SIGNATURE-----

--K1nqM47Qf7ezryjK--
