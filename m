Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9511230B1AF
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 21:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBAUp4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 15:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhBAUpz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 15:45:55 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6744C06174A
        for <linux-ext4@vger.kernel.org>; Mon,  1 Feb 2021 12:45:15 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id j2so11248850pgl.0
        for <linux-ext4@vger.kernel.org>; Mon, 01 Feb 2021 12:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=qnOOdi752IilB/nHdj6qiwg2B11YaQtOWLHD+Ehtq08=;
        b=z4zH5PW46/y7xJNV+IbN5ZPKoyHiGJeORDtPV1JhQj6YZa/vO9o2oKgMcGKa6bQgAo
         9expqoE0isUMe2HiXxmjeBiix8HXR4d7s42Je1LersrhkIVjGboSwDIPQluS/4nuD73i
         KI2SyHNcJcjE4QGV/g3BEYPpaJeu0Jmx8IZ+r9mcqZYPxAUfBPLGdNvVDgHwpsBV+vPu
         txebXYo1hWn+O8HQxFpxV55XBPtffWG7f1+Am0ULPnN3+oC7Pwk/qoXEJsgbUHzFoF5X
         TYA7PSskVZYKkH09igQBclqq9GNhTH+a4DvGI/sF+VOM0xF6DTx81E72MKWW9CnYx9pt
         TGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=qnOOdi752IilB/nHdj6qiwg2B11YaQtOWLHD+Ehtq08=;
        b=s/NGPvbxYmNH1XAJsjiFSmphQ0H6krMTGCFMVG1zL7f6yxORwJpYpvf66uSkI1ZeEG
         oK7PjAeo2Ooqs515LrPswp2GRFCM0oJCMHqJX7z/FWdTtERmA92SunwmzlmY7uJWkgmd
         i5UTJmno14sIdG5YLDcvrHA61/rx1KVeNWDA362YfRQYLxG39bRm+OW2XifObZoqEgLI
         5M/+mqatfne/G/ejzhDQp9pjNogBkWyJAZDlFMd7bm43ldfXW0qUPNEMuhMxrn/P2rUf
         0gjb3VUADUIOKpoNuJwnBjrcbVTcY8pO2l4Jrm2gBkJTetEwbkEYOVtCuDZ5WHAULGsV
         oZhA==
X-Gm-Message-State: AOAM531ZPB8sIcdm2J0yKoDTwUuwLCL5guuXbe9lq+iooP6G1EN9wHMh
        xzQiXLXCo29VBE/30D3Cjyuusw==
X-Google-Smtp-Source: ABdhPJw4ST6EzePtsq/76N6uxKd0dBKhIcoq1Jqg3RtKBQ18XzcFz8fdVrFMsL60n41ByASrwxW5ZQ==
X-Received: by 2002:a65:6215:: with SMTP id d21mr18244920pgv.367.1612212315238;
        Mon, 01 Feb 2021 12:45:15 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id y1sm19063318pfn.125.2021.02.01.12.45.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 12:45:14 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9CA2BADA-9CD9-49DC-A5E2-063C8A593E57@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D6983B98-027E-4E50-A31C-08148A4552B0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
Date:   Mon, 1 Feb 2021 13:45:11 -0700
In-Reply-To: <CALD9WKzO53AXQW-qQ82VZ41H5=cGdLTUiEoz3X6BmPkb6XaTag@mail.gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
To:     Vinicius Tinti <viniciustinti@gmail.com>
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com>
 <20210201124924.GA3284018@infradead.org>
 <CALD9WKxc0kMPCHSoikko+qYk2+ZLUy73+ryKGW9qMSpyzAobLA@mail.gmail.com>
 <YBg20AuSC3/9w2zz@mit.edu>
 <CALD9WKzO53AXQW-qQ82VZ41H5=cGdLTUiEoz3X6BmPkb6XaTag@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_D6983B98-027E-4E50-A31C-08148A4552B0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 1, 2021, at 11:41 AM, Vinicius Tinti <viniciustinti@gmail.com> =
wrote:
>=20
> On Mon, Feb 1, 2021 at 2:13 PM Theodore Ts'o <tytso@mit.edu> wrote:
>>=20
>> On Mon, Feb 01, 2021 at 01:15:29PM -0300, Vinicius Tinti wrote:
>>> On Mon, Feb 1, 2021 at 9:49 AM Christoph Hellwig <hch@infradead.org> =
wrote:
>>>>=20
>>>> DX_DEBUG is completely dead code, so either kill it off or make it =
an
>>>> actual CONFIG_* symbol through Kconfig if it seems useful.
>>>=20
>>> About the unreachable code in "if (0)" I think it could be removed.
>>> It seems to be doing an extra check.
>>>=20
>>> About the DX_DEBUG I think I can do another patch adding it to =
Kconfig
>>> as you and Nathan suggested.
>>=20
>> Yes, it's doing another check which is useful in terms of early
>> detection of bugs when a developer has the code open for
>> modifications.  It slows down performance under normal circumstances,
>> and assuming the code is bug-free(tm), it's entirely unnecessary ---
>> which is why it's under an "if (0)".
>=20
> My goal is to avoid having a dead code. Three options come to mind.
>=20
> The first would be to add another #ifdef SOMETHING (suggest a name).
> But this doesn't remove the code and someone could enable it by =
accident.

I don't see anything wrong with the original suggestion to use =
"DX_DEBUG".
If we want to get rid of "if (0)" in the code it could be changed like:

#define DX_DEBUG 0
#if DX_DEBUG
#define dxtrace(command) command
#else
#define dxtrace(command)
#endif

Then in the code check this directly (and fix the //-style comment =
also):

	if (DX_DEBUG) { /* linear search cross check */
		:
	}

That will hopefully avoid the "dead code" warning, while keeping the =
code
visible for syntax checking by the compiler (unlike if it was under =
#ifdef).

Alternately, if we want to keep the "#ifdef DX_DEBUG" check intact:

#ifdef DX_DEBUG
#define dxtrace(command) command
#define DX_DEBUG_CROSSCHECK true
#else
#define dxtrace(command)
#define DX_DEBUG_CROSSCHECK false
#endif

	if (DX_DEBUG_CROSSCHECK) { /* linear search cross check */
		:
	}

Cheers, Andreas

>=20
> The second would be to add the code in a block comment. Then document
> that it is for checking an invariant. This will make it harder to =
cause
> problems.
>=20
> The third would be to remove the code and explain the invariant in a =
block
> comment. Maybe add a pseudo code too in the comment.
>=20
> What do you think?
>=20
>> However, if there *is* a bug, having an early detection that the
>> representation invariant of the data structure has been violated can
>> be useful in root causing a bug.  This would probably be clearer if
>> the code was pulled out into a separate function with comments
>> explaining that this is a rep invariant check.
>=20
> Good idea. I will do that too.
>=20
>> The main thing about DX_DEBUG right now is that it is **super**
>> verbose.  Unwary users who enable it.... will be sorry.  If we want =
to
>> make it to be a first-class feature enabled via CONFIG_EXT4_DEBUG, we
>> should convert all of the dx_trace calls to use pr_debug so they are
>> enabled only if dynamic debug enables those pr_debug() statements.
>> And this should absolutely be a separate patch.
>=20
> Agreed. For now I only want to focus on the "if (0)".
>=20
> Regards,
> Vinicius
>=20
>> Cheers,
>>=20
>>                                                - Ted


Cheers, Andreas






--Apple-Mail=_D6983B98-027E-4E50-A31C-08148A4552B0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAYaFcACgkQcqXauRfM
H+DA5w/+NwuAaMctdbMXqQsHDMc+8lK3fpTgnvWNSPdfWXXowh1ubKGMfCPPAAIB
MJKNY8zp2dCTFYTX8fzJrCdzcjD45k2snHVfHZlKuI8kSsbxe9lUdVl/uKCVwgDn
LFSL7B8HN0yIAWW7gdg2EDTDuc+MNAliJQnDRX7/25dZBqV4Y7TA579NklClOO64
zoTCFYZGanXrtr0UYEQX5vGl6udy/YoftI1miH5mw73th7KxaIvgYHu0tiKTrggc
BnWS74x2JQHFmr+/6dsob/tBDsK0BE/CifcBBgY1Atqzzczjua8zQa3ew/hzLbiq
3g8xHJau+15rOIX+DwfZRWZGFOoGV4jNBtKrFULAUDEdypWxk58t7ZB7bHq/5y6k
baiMYVGBDebneGEvWU6JRSUYJ16cyLlXDtEw39iDlLk0Qz7vzGYCMXyi7wpebY6c
ZB0774XE2kWE1BlWtarIyUpXstwuysG4FwCCnp04HlYpeWGc7PdoFwykXQSTScWF
HGfbF/EYJzyxEeEKBB7Jn/UDzVU2dnUEgfVUJpTdiCZhesRMIluyKKlL75mFI4pP
2gjnnAy79AYMtHY2fiEUrjoJZvbLO6BWN+CS5TLUzcGqTmo5Qi09B5HKeH2BLV8H
EP0jf0us79YH2/pFwtxvZRnQJrDCML7cCN4VtSiIqY3iNlBpBbA=
=p4Ec
-----END PGP SIGNATURE-----

--Apple-Mail=_D6983B98-027E-4E50-A31C-08148A4552B0--
