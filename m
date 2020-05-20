Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD2C1DBDFA
	for <lists+linux-ext4@lfdr.de>; Wed, 20 May 2020 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgETT3F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 May 2020 15:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgETT3E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 May 2020 15:29:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A88C061A0E
        for <linux-ext4@vger.kernel.org>; Wed, 20 May 2020 12:29:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d3so1766111pln.1
        for <linux-ext4@vger.kernel.org>; Wed, 20 May 2020 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5RWAkTeKfUWU44/RNlRXNqtbi5hIBgu5BpxkshiVfMA=;
        b=O8Dwfx2YLjrGlj/PTXLdrVowIHgpNmyxP4HYx5gLVYerka9/yUN+NXV+NDqAXewUjv
         wcRUtjL3s701jGeFeOiBSx7QmM0FQTTkve3LPZK8Ew6ZhMFRNXncLmuc9BS4tbuItbqu
         tPx8wPY7n2l1AUuMjqoqfc6e7VOk5X1bMClBmwwEDq79OzVkCc2uu84FC6mwdXQH5Li2
         P25tgEgR9mWWXtDzqPNPY8iUpVF+c/GeobIom1I8toHHNkiPLvWfmq3mUeYZy+Gr6axM
         xRHKnffK8p5xA3M6ycn8OoOnS1FjCvMV3xVMEIvRD48U3hvf/hFz4H/xtQJzakZShH9P
         xbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5RWAkTeKfUWU44/RNlRXNqtbi5hIBgu5BpxkshiVfMA=;
        b=XR3xiCHU/JGXUTRUNmP825VSnTB2lB875BVFTfCcgRwy2YSQ1IiIx/Xf0KMqOPHXqe
         9gVsZ/ZXh8/peQjEXGY5he2JKpKdHVTOfXMmvat8eLasXsgu06PEsCLdijIfUoUkpkSs
         9r2/jvOwJfp44F5IoS/Zw5Cob7dxJUAzPBDOLU2uK/r5fcuR1LxUO5khhvDX33dkR7uw
         qvgk0GU/rEdtb2+zF1+qPYCWLwU8EDxe4NHsSejvGwHRTFZN+zOzi3iTbfMygJ9EVScm
         p7QNkv4Y1e/qTjbCk2PDL3p537JThtRd0Xd5Rwkd5ggGZhAHnGy7mfG7+34k9kIMHlJh
         m7lQ==
X-Gm-Message-State: AOAM531ShlcUC5Vp0ZQXMceuBMoqDhWXkuOdOTRztG5r3F1CTymSzLRx
        UfRYQExcuaFB4UuJMDvZbzJG1w==
X-Google-Smtp-Source: ABdhPJzWVIFutenCU/+5Exrwt9lzE9dfE+dwjvvfbLVP/KWcMaQTMIsFKAPa36tdAEqQml/FqwNnqw==
X-Received: by 2002:a17:902:714e:: with SMTP id u14mr6027547plm.175.1590002944122;
        Wed, 20 May 2020 12:29:04 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id w14sm2446356pgo.75.2020.05.20.12.29.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 12:29:03 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <880DF805-D78D-427A-A53F-FD8CFB00B5E3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C9DCCF20-6C9F-4E3D-A54B-D9E6073ADD87";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: Drop ext4_journal_free_reserved()
Date:   Wed, 20 May 2020 13:29:01 -0600
In-Reply-To: <20200520133119.1383-2-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20200520133119.1383-1-jack@suse.cz>
 <20200520133119.1383-2-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C9DCCF20-6C9F-4E3D-A54B-D9E6073ADD87
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 20, 2020, at 7:31 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Remove ext4_journal_free_reserved() function. It is never used.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4_jbd2.h | 6 ------
> 1 file changed, 6 deletions(-)
>=20
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 4b9002f0e84c..1c926f31d43e 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -335,12 +335,6 @@ static inline handle_t =
*__ext4_journal_start(struct inode *inode,
> handle_t *__ext4_journal_start_reserved(handle_t *handle, unsigned int =
line,
> 					int type);
>=20
> -static inline void ext4_journal_free_reserved(handle_t *handle)
> -{
> -	if (ext4_handle_valid(handle))
> -		jbd2_journal_free_reserved(handle);
> -}
> -
> static inline handle_t *ext4_journal_current_handle(void)
> {
> 	return journal_current_handle();
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_C9DCCF20-6C9F-4E3D-A54B-D9E6073ADD87
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7FhP0ACgkQcqXauRfM
H+BQPw/9GiXzmziKua8mbD0rwDXwf3pp63SYYaoLp6c+iPAxAns0uxTsUrMXS7Pj
WkewevZic6AgOCohzyD6VBy6zhtT3jl5uTXwK1Vd+Ts9F6XzWLpMxJcGcAsvfrgP
4hHNra3bvABTkGqHsCqyVrcFjuv70VWKfsF14W9BgMGVgC9wsxigIrwXqrmmdKsK
uOTkUaK3NEfKQhnAsvB+w2acqpyfW1AoyHEmmPIdYcqGs7RU1u5/cX3uPlLx9cHA
8eHoCBvEUV3R7b5SD8VYrgpDj7776h4TPZ66AEurIj0LU5cxQTAHW0UbrREzwCWF
erQsB1AJpb1gaXBI3cWrkrSyxy6Xf51QmVrJZn6qC+bhv0wSpyxEwSoT5QaC685v
HZ8UwzW0Usbj69N7W68Of5apoLCiu8ugk/V5KJX7604QOyCtkTAwQKSZOFgugPMX
9LkT44BIDPbQvlS1JKwM9fdS0hYoprYLKYepYUoQYePZ8iDZCqBrAmLMn7EGnPeP
FKQYfVQzUpl1ET39UV1p7Tjk/zQdurn+G0s+Bd9xxelDUT/o1pXm+qig6YKsDZZR
Q8ehXJ0TNFy+t1Rz4VxD2ypHIZpDq+gJNiqtkNKjPltFwsf1/usUkthKwEt8g7cu
JyJrOrM8aFgvQJTVyoiqIWRhI7QaFTZC+QCEKvk0WTbFdfd2/r4=
=ST9Q
-----END PGP SIGNATURE-----

--Apple-Mail=_C9DCCF20-6C9F-4E3D-A54B-D9E6073ADD87--
