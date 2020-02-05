Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605C81536D2
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2020 18:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgBERiN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Feb 2020 12:38:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43414 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgBERiN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Feb 2020 12:38:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so1556050pfh.10
        for <linux-ext4@vger.kernel.org>; Wed, 05 Feb 2020 09:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=A5suYdctMomyeLdl1mNTU+2rvtDg/s3oaDCfNU2gyCA=;
        b=PZO2xcRJh8tGCGT4/eAFeNvW1GjMTX7ox9BZkp8ARymHYHEXLmMtkR/OhEV89V/q4R
         QfIvMNBJdZ0btE/6+Dq38xe4/ilOPpxUbZjA0VDz7VSfrfkVwxRWqDKWCbVr2DQKiTGs
         9z5ad86YmyQx7hrIkRnFZ1cqPFpV4Jrp3L2tUcdWmYlnOlYoMrWjT1qXpAsfXFYGNaz+
         QxGU9PfkKzgU6lbiBcO7wQM0KoJXSs5dpYx6EZmRS99OrlvZ+AFWzlDncxdyAD0qOOf1
         W7p/+gnbQHX4CmbND7owZO/jn1wgJjIBL8TfE1ZmWmhz5lQrMMSMUMChlAFAdiBfZ1Un
         syxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=A5suYdctMomyeLdl1mNTU+2rvtDg/s3oaDCfNU2gyCA=;
        b=bjlt+YMzBSdscN2xb94TZEhSwCo/x5VlpfJKeAslIeWgm6ib9Fs4BWe7Z2UM39dA29
         0KObfhZUAvSCV1HC0zaLjKF2obebcQ6HaC12iqlU7ZnGmrHQvraqnqKU9Gt/uN7rFN74
         Ih6jDjBc8awkODWbZQfEQNIMbBl8PoKM+SJ/p+kiKjLXUYL2Vf3KMEHel9EPan1bHlqC
         CFGFmogZwexkVbTtz1bEf4v7SUVihDUC9+srfeeIRHBZAsC83EbFi3/wrLh6UH4lfKSf
         b+fQJkQHRGA+RleLzpUtj8H9JtsdqRGY8KbCcgRls5F2hww4VrrNNTP/FYoCC0JqJp+R
         +LOw==
X-Gm-Message-State: APjAAAWMGHtOBf9w/C4/FLHwIQa5i4iyeYW6v0d1C8O5xEy3wDHkHNDa
        2pUc7Xehke7LMR3HtPuRctyKTp32wT0rSQ==
X-Google-Smtp-Source: APXvYqxOnJZW9nPbUom4sLw5UnOP4hv0HRX5sRZEQeqAMsMMHmpySa0fZHezQSNcvUOJ1tzjX5nFmA==
X-Received: by 2002:a63:5903:: with SMTP id n3mr18293424pgb.25.1580924292541;
        Wed, 05 Feb 2020 09:38:12 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id u11sm432015pjn.2.2020.02.05.09.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 09:38:11 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <23FB58CC-BE93-4602-8B1C-9DA06FAE0F1A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D8BCECBA-1455-41ED-8F96-0E41C787CC29";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/3] e2fsck: Clarify overflow link count error message
Date:   Wed, 5 Feb 2020 10:38:04 -0700
In-Reply-To: <20200205100138.30053-2-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20200205100138.30053-1-jack@suse.cz>
 <20200205100138.30053-2-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_D8BCECBA-1455-41ED-8F96-0E41C787CC29
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 5, 2020, at 3:01 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> When directory link count is set to overflow value (1) but during pass =
4
> we find out the exact link count would fit, we either silently fix =
this
> (which is not great because e2fsck then reports the fs was modified =
but
> output doesn't indicate why in any way), or we report that link count =
is
> wrong and ask whether we should fix it (in case -n option was
> specified). The second case is even more misleading because it =
suggests
> non-trivial fs corruption which then gets silently fixed on the next
> run. Similarly to how we fix up other non-problems, just create a new
> error message for the case directory link count is not overflown =
anymore
> and always report it to clarify what is going on.
>=20
>=20
> diff --git a/e2fsck/problem.c b/e2fsck/problem.c
> index c7c0ba986006..cde369d03034 100644
> --- a/e2fsck/problem.c
> +++ b/e2fsck/problem.c
> @@ -2035,6 +2035,11 @@ static struct e2fsck_problem problem_table[] =3D =
{
> 	  N_("@d exceeds max links, but no DIR_NLINK feature in @S.\n"),
> 	  PROMPT_FIX, 0, 0, 0, 0 },
>=20
> +	/* Directory ref count set to overflow but it doesn't have to be =
*/

> +	{ PR_4_DIR_OVERFLOW_REF_COUNT,
> +	  N_("@d @i %i ref count set to overflow value %Il but could be =
exact value %N.  "),

IMHO, you don't need to print "value %Il" since that will always be "1"?
That would shorten the message to fit on a single line.

Also, lease keep the comment and the actual error message identical.
Otherwise, it is harder to find the PR_* number and the related code in
e2fsck when trying to debug a problem.  So the comment should be:

	/* Directory inode ref count set to overflow but could be exact =
value */

To be honest, I don't see the benefit of the @d, @i, etc. abbreviations
in the messages anymore.  The few bytes of space savings is IMHO =
outweighed
by the added complexity in understanding and finding the messages in the
code, and added complexity in e2fsck itself when printing the messages.


Cheers, Andreas






--Apple-Mail=_D8BCECBA-1455-41ED-8F96-0E41C787CC29
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl46/XwACgkQcqXauRfM
H+B3zRAAp99Jh3pMX5cIl9IS1GUXlfILl50qB1FrvKYKBEzxN7w69ofik5GX84Mu
HXhg/mt9zEgB1Hq+hvmQUidy82XdsYYBWKSYeN6qjySKFMBrXSGwUZ8NyLH1AaC8
HXHOnhvHSjUFXBeHttjPCFjUO17eErEbMOo566xNQ8Rbfwt359FhtsBd8x79Lmvj
FS/3clCO4GlWWDUeazEAn6YTAAjKA/A5ge9eiScMiVejAgi3/ecfm15BLw93C1x0
APBicoWNxaV5jgucnO9PSJf3B3r8KrOcRudrI6nyPAVryvegpv4o6yJ44YYijyMt
kMFfB4bNW04nuPvdpn2DUlIIddEHNlrQPK4DtPgrgZvps3Ylb7BxV/LFoMoW9/s5
JOdAz+VjWpe9xi8LSjf6n5VfrlwioR+/WvartHOvAlEfmhQ38EpQgf2iuP4ajP7p
nBzTPSFch4WKOI7L6L5vvu3P/oyEyw2FhYvDO8NKZQb2ZjJKxu1iUcWRZBWi52DW
xxxbAqWyJLGOWc8DtXkKsTbL6MJR4wNXMEUBkJuZyAOU2SmTGHZ+WAXbTq+8ehyx
+pDTIRhah8yCdN82blSZb+QUurAnFJAFtFCBlxXomxhyAF6eZeB75OmE5jSU4Le7
PzKhHb5OWwq75Dzg+Adt2QIV0BbDOsvtEhn3ENmYvjzUdDfNsuQ=
=ICMJ
-----END PGP SIGNATURE-----

--Apple-Mail=_D8BCECBA-1455-41ED-8F96-0E41C787CC29--
