Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F018F4C7EE0
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 00:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiB1X7R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Feb 2022 18:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiB1X7K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Feb 2022 18:59:10 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8FB5B88F
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 15:58:21 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s1so12050432plg.12
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 15:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=YyxDWmDN7sg056gSnE2Uv/JCnGhxSkXEZ0o6G25koMQ=;
        b=Y6lVCe4+uUIcgcOfuQV5YmlLYkKnzd/nPw90RyOW1kxEWAo0htJwq18JIkkrqd1Vge
         42tz7+e0ClfN2oNGrR+CT90jw0DYTXG6ymj90dA/Jm+nnOI0aMiAKWTYPlpv1NutVwLC
         wRq2atz4BW5u33lz9uUBQtV0mr5VyukA96doqrgBgNfOBSFdkc6pgM27g0YN/gONwBbC
         Vvsiul5owrz95ndyIt+8vtTx7PCudXSJFVcUi3xmFMT+zqPaWUgJNqup3RtLL1me+aM+
         TCySwxuskJUzjuCmuWPvR3QYvlZdIszJJjVUenr/ygTuGER4EQgPpbJKeiQbK6esq9Bc
         eqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=YyxDWmDN7sg056gSnE2Uv/JCnGhxSkXEZ0o6G25koMQ=;
        b=Kp7ecV4WYCz+5YUviLbv+ebGtiQY54lHgHxs4lcrs/b18E/u0zqjmjld0Ln1TJADUa
         8i5OmJHJIqC7FM0hd5+PyUlrqgK93EMoyLXU4nGZRLIWaklt9QXc1GL+brs2WhqG3mTN
         f6YRvxNN7jdfCTSZHuk1QJ5sQLb63B5K6Zt4FJQIRC4TZmY1pmI7GZJOVdl9m1kAnGh2
         JcV6l+sTwQ/d6BHq0zcphB+t+fEBE1kubFKn1GXjUyLR5QqdH3fKnJMJQEBA17P5keO7
         7SgIt2JaQxuZBw2xU9nTBfsPommsiP7WRjQPq0cCZg4yPaJ5NoQodsXftS0i1FQh5lbe
         +N7w==
X-Gm-Message-State: AOAM5322aFPFcjlzPK7+3RTyj7Gg/hEwyNdew14efGJyKa2t+amKAJnA
        lXVq8S+BsAY0CKe1B7/UU1JoxA==
X-Google-Smtp-Source: ABdhPJybUnuTa4R87jf/KkaoAJYqvV8W2d7Ve0XGK+ZUtGR4TUfCjYlOQ7FAz6UZtDK49jKVgZNC9A==
X-Received: by 2002:a17:902:f712:b0:149:d41a:baa8 with SMTP id h18-20020a170902f71200b00149d41abaa8mr22530563plo.115.1646092701179;
        Mon, 28 Feb 2022 15:58:21 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id g19-20020a056a00079300b004bca2737f34sm13709894pfu.187.2022.02.28.15.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 15:58:20 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <49C6329B-BF16-4819-98F8-AE98F985676E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_54BDB8F3-D8BD-4B9A-A11F-0F8E3C50916C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: map PROMPT_* values to prompt messages
Date:   Mon, 28 Feb 2022 16:58:19 -0700
In-Reply-To: <20211211005111.GC69182@magnolia>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
References: <20211208075112.85649-1-adilger@dilger.ca>
 <20211208164238.GA69182@magnolia>
 <07CD099E-959E-4F85-B7B6-72F025E64545@dilger.ca>
 <20211211005111.GC69182@magnolia>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_54BDB8F3-D8BD-4B9A-A11F-0F8E3C50916C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 10, 2021, at 5:51 PM, Darrick J. Wong <djwong@kernel.org> wrote:
> On Thu, Dec 09, 2021 at 02:55:26PM -0700, Andreas Dilger wrote:
>> On Dec 8, 2021, at 9:42 AM, Darrick J. Wong <djwong@kernel.org> =
wrote:
>>>=20
>>> On Wed, Dec 08, 2021 at 12:51:12AM -0700, Andreas Dilger wrote:
>>>> It isn't totally clear when searching the code for PROMPT_*
>>>> constants from problem codes where these messages come from.
>>>> Similarly, there isn't a direct mapping from the prompt string
>>>> to the constant.
>>>>=20
>>>> Add comments that make this mapping more clear.
>>>>=20
>>>> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
>>>> ---
>>>> e2fsck/problem.c | 46 =
+++++++++++++++++++++++-----------------------
>>>> 1 file changed, 23 insertions(+), 23 deletions(-)
>>>>=20
>>>> diff --git a/e2fsck/problem.c b/e2fsck/problem.c
>>>> index 757b5d56..2d02468c 100644
>>>> --- a/e2fsck/problem.c
>>>> +++ b/e2fsck/problem.c
>>>> @@ -50,29 +50,29 @@
>>>> * to fix a problem.
>>>> */
>>>> static const char *prompt[] =3D {
>>>> -	N_("(no prompt)"),	/* 0 */
>>>> -	N_("Fix"),		/* 1 */
>>>> -	N_("Clear"),		/* 2 */
>>>> -	N_("Relocate"),		/* 3 */
>>>> -	N_("Allocate"),		/* 4 */
>>>> -	N_("Expand"),		/* 5 */
>>>> -	N_("Connect to /lost+found"), /* 6 */
>>>> -	N_("Create"),		/* 7 */
>>>> -	N_("Salvage"),		/* 8 */
>>>> -	N_("Truncate"),		/* 9 */
>>>> -	N_("Clear inode"),	/* 10 */
>>>> -	N_("Abort"),		/* 11 */
>>>> -	N_("Split"),		/* 12 */
>>>> -	N_("Continue"),		/* 13 */
>>>> -	N_("Clone multiply-claimed blocks"), /* 14 */
>>>> -	N_("Delete file"),	/* 15 */
>>>> -	N_("Suppress messages"),/* 16 */
>>>> -	N_("Unlink"),		/* 17 */
>>>> -	N_("Clear HTree index"),/* 18 */
>>>> -	N_("Recreate"),		/* 19 */
>>>> -	N_("Optimize"),		/* 20 */
>>>> -	N_("Clear flag"),	/* 21 */
>>>> -	"",			/* 22 */
>>>> +	N_("(no prompt)"),			/* PROMPT_NONE		=
=3D  0 */
>>>=20
>>> Why not make it even clearer and mismerge proof:
>>>=20
>>> static const char *prompt[] =3D {
>>> 	[0]		=3D N_("(no prompt")),	/* null value test */
>>> 	[PROMPT_FIX]	=3D N_("Fix"),		/* 1 */
>>> 	[PROMPT_CLEAR]	=3D N_("Clear"),		/* 2 */
>>> 	...
>>> };
>>=20
>> I thought about that too, but then I thought the "[index] =3D foo" =
designated
>> initializer is GNU or at least C99-specific, and I wondered if that =
was
>> going to cause portability problems for some ancient system that =
e2fsprogs
>> is building on...  I figured adding comments is relatively safe, and =
these
>> values change so rarely that more complexity in the patch was not a =
win.
>=20
> <shrug> Yeah, I thought it was safe enough to use -std=3Dgnu90 =
features,
> but I guess it's really up to Ted to decide if he'd prefer a =
structural
> fix or not.  Evidently this syntax is /still/ being argued in the C++
> committees, which ... yay. :(

Ted, thoughts on this?

Cheers, Andreas






--Apple-Mail=_54BDB8F3-D8BD-4B9A-A11F-0F8E3C50916C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmIdYZsACgkQcqXauRfM
H+B//w//TfztlhtYLIuXsfUHOgeL2KIwtEsWFSnTEoHy6FtlKHDy7TidPsRdMIOc
oY98D3Up/EZiceMe0ykMQLb13DVHWfyXeNmn7Vuyglbx00poholsi9+oe9XXfTIR
SHoFggSbIq2rqTGKaIOLY7XuMSuBEBnL3u0ika/aC9W+Csj2IEC7UjM9Yg43SRQh
pZA/QxC2ENtQcJT6Po4575zZopJMiK5VzihMj8CpIiRtFG90LbZQ+lpoon8NpmxU
ubVRXxZC0En6LewBKJOTlB/8hVnU6vm/V1HS0GH6BQaZB5tHNnWokHEZk9oSSPM4
FhLe7+dkmoZ9gQ3WmUWwt7KOLei7bVYFXSqqCfZ+4CNXmxTj4wCwuQd+tK+TcHsY
4TeOwpKa5ffBwv4LaNWqkPURYUwtjZbqRmSI+vIyE1F+OykhRtGpEgl8gIGKgEks
+TC6uQMlNlwz5bTxiMgx40PGqpC+NP3gm5Fh7CyjHtZ4DM05y+wL0Hgbg1GqG1om
al3eNiH6qFDe/ZBVd9G4O1Xqv3MzreMIKdTxyiwxIyOGfaUORuY2knZsLn5FEm8Q
kMjKflGHUaL0HoKIfKDT7zUSPMWwaGMAZB0QFNw8x3UKx0KcjcAMp4BVPZVg4bra
9ELYS/f8D/JXJh9+AGLtrMKPX1B94tQNCplrBMHpTaOO+o7tD88=
=i92A
-----END PGP SIGNATURE-----

--Apple-Mail=_54BDB8F3-D8BD-4B9A-A11F-0F8E3C50916C--
