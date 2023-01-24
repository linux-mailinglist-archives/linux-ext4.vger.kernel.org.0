Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFBA67A112
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Jan 2023 19:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjAXSVc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Jan 2023 13:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAXSVc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Jan 2023 13:21:32 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220A02728
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 10:21:30 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m11so4057011pji.0
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 10:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWXvPikYMQUs6nuOyJEvWH12tcwqLaSqv/qziUhIxQk=;
        b=T+VjdAFwmWNB/3j45X5TdCxYLyVq0HfLIxtNrK9eL853bLh1Kre7OqTLIs9h/LV4Oe
         DanFNLDm+gFfjLAHt6Q8YLHSiF3Widlp+5M79nNT6Rjq/FKMELFGrmI7AVxAvJ3uvHep
         LD/0SNJvY0dQfiB3KO4UdmipVIK+wev5vq+qbjnvx02/wjmGeIrhIaVISQsvL9ac17MO
         BSR/qd87oixhws/oGek2r+krJuAUY6Y5sntJfOV/L3QazWm3z5HUutxRP9cVU6PPnfs4
         PYurs03j3QzVHxT1e91+MUzgmytiGWF3tJ/EU2UUCHCFKzjvUR4VJAr7yIVp8QPQ/6zV
         Jd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWXvPikYMQUs6nuOyJEvWH12tcwqLaSqv/qziUhIxQk=;
        b=SXsrECHeyD3TbWdLN2r2KgSz+yncpTe3Vbvfz9YsBvPlhNR5h8Z+RfY7giL/w+OHK3
         E3R670pZTelnt/3X19D6+Jbdp/cBxwmylaW6wKnby5mQVQzi9jUgbGzykVm5/Tk3ttTt
         aaGolamkmL9ikAkC+BBj+IpKT+b6Aiwkg7yJG0AV5cucrhcbNDnvSxd0RArEPtra5+po
         D0Pdimpyhvs+YXGReKTyzqdUP4BHl7e4oNkbwz8hK33sYRY5L7LeaQLHuue6uT8G2/xW
         nL2IKlvcY6K+K01GAer14Q7KUwnl0RrJbtoYKeIOx3IoGfgFAOCUUQPYcDg5zvYfHHxU
         QFJQ==
X-Gm-Message-State: AFqh2kpHi3sdevrkNVp6pejepQRHp0AhbC78xOkIfhCPbFsOVPZSkvc1
        yHl55k7KTztfX+UiYi/gbSPTAw==
X-Google-Smtp-Source: AMrXdXvpi/TqH+DDigJpAh4C3FSYJJpDYk86ruA6AsGIgjAv3DkZdgUpwk9fS+vYWWZSxuGhQlaf3g==
X-Received: by 2002:a17:902:9a81:b0:194:4b98:42c8 with SMTP id w1-20020a1709029a8100b001944b9842c8mr26025383plp.28.1674584489366;
        Tue, 24 Jan 2023 10:21:29 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090274c300b00196191b6b29sm1405013plt.140.2023.01.24.10.21.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jan 2023 10:21:28 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <AE27C93A-528E-49F6-85B5-ACF80413FD04@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2D885FE3-7A54-4BE1-A4C8-F9DE1284985C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 07/38] lib/blkid: remove 32-bit x86 byteswap assembly
Date:   Tue, 24 Jan 2023 11:21:26 -0700
In-Reply-To: <20230121203230.27624-8-ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
To:     Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>
References: <20230121203230.27624-1-ebiggers@kernel.org>
 <20230121203230.27624-8-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_2D885FE3-7A54-4BE1-A4C8-F9DE1284985C
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jan 21, 2023, at 1:31 PM, Eric Biggers <ebiggers@kernel.org> wrote:
> 
> From: Eric Biggers <ebiggers@google.com>
> 
> libblkid contains 32-bit x86 assembly language implementations of 16-bit
> and 32-bit byteswaps.  However, modern compilers can easily generate the
> bswap instruction automatically from the corresponding C expression.
> And no one ever bothered to add assembly for x86_64 or other
> architectures, anyway.  So let's just remove this outdated code, which
> was maybe useful in the 90s, but is no longer useful.

I'm not sure what Ted thinks about this, but it might be time to remove
the libblkid implementation in e2fsprogs, and instead depend on the
newer version in util-linux?  However, removing it from e2fsprogs
would add an external dependency on util-linux for non-linux platforms,
though AFAIK it should still be possible to build e2fsprogs without it.

That said, I think the current patch looks fine, and you can add:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Cheers, Andreas

> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> lib/blkid/probe.h | 43 -------------------------------------------
> 1 file changed, 43 deletions(-)
> 
> diff --git a/lib/blkid/probe.h b/lib/blkid/probe.h
> index dea4081d0..063a5b5c0 100644
> --- a/lib/blkid/probe.h
> +++ b/lib/blkid/probe.h
> @@ -814,46 +814,6 @@ struct exfat_entry_label {
> #define _INLINE_ static inline
> #endif
> 
> -static __u16 blkid_swab16(__u16 val);
> -static __u32 blkid_swab32(__u32 val);
> -static __u64 blkid_swab64(__u64 val);
> -
> -#if ((defined __GNUC__) && \
> -     (defined(__i386__) || defined(__i486__) || defined(__i586__)))
> -
> -#define _BLKID_HAVE_ASM_BITOPS_
> -
> -_INLINE_ __u32 blkid_swab32(__u32 val)
> -{
> -#ifdef EXT2FS_REQUIRE_486
> -	__asm__("bswap %0" : "=r" (val) : "0" (val));
> -#else
> -	__asm__("xchgb %b0,%h0\n\t"	/* swap lower bytes	*/
> -		"rorl $16,%0\n\t"	/* swap words		*/
> -		"xchgb %b0,%h0"		/* swap higher bytes	*/
> -		:"=q" (val)
> -		: "0" (val));
> -#endif
> -	return val;
> -}
> -
> -_INLINE_ __u16 blkid_swab16(__u16 val)
> -{
> -	__asm__("xchgb %b0,%h0"		/* swap bytes		*/ \
> -		: "=q" (val) \
> -		:  "0" (val)); \
> -		return val;
> -}
> -
> -_INLINE_ __u64 blkid_swab64(__u64 val)
> -{
> -	return (blkid_swab32(val >> 32) |
> -		(((__u64) blkid_swab32(val & 0xFFFFFFFFUL)) << 32));
> -}
> -#endif
> -
> -#if !defined(_BLKID_HAVE_ASM_BITOPS_)
> -
> _INLINE_  __u16 blkid_swab16(__u16 val)
> {
> 	return (val >> 8) | (val << 8);
> @@ -870,9 +830,6 @@ _INLINE_ __u64 blkid_swab64(__u64 val)
> 	return (blkid_swab32(val >> 32) |
> 		(((__u64) blkid_swab32(val & 0xFFFFFFFFUL)) << 32));
> }
> -#endif
> -
> -
> 
> #ifdef WORDS_BIGENDIAN
> #define blkid_le16(x) blkid_swab16(x)
> --
> 2.39.0
> 


Cheers, Andreas






--Apple-Mail=_2D885FE3-7A54-4BE1-A4C8-F9DE1284985C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmPQIacACgkQcqXauRfM
H+BOQQ//dRd42T2H40dIWysnzk++iHYIbit4aq6A2nki5vhVRAb+y6PUv/pMuij4
F+Vz58+1RsOQV7KE2RTrF0Kk/6Mr8TAXw3ZPeZ8+hcRI4+6luCIhFJa3geWpieyF
BKRpfo9SU3nr9DEy1iZfqYZekH9PwIt3LTrwVhVk0WMVouVKAGfJsOSPaTsb/hsm
YKvJw3taRWPrx1IOpRtUSZdc48VwEu41GGAERow46Q9kYYy51On7Wm+apYQB1xD3
jV8R5KNNWm3Yv/0GpSzhfk3Bro4EGdfw8CUUFxhmhfmTlygpBzBHDi6MD67cnaPw
m7qQRhww6FMYAxK+tUm72T2yBoWslEe1MId2U9+En9RNExiGABoSll+/MwaCe4Jv
nNRBBOqnlrvPv6q8Yl/K0rq+/NeKrjF35YaJhzHnBfIMzYQKBsNyrM1Fb/c3Iddb
JU8rX9oT83zAGc05vuhPNurZCSBhyswx72JyVgc63nikwgjtnny6tKnRt/slSa44
W5xZrjbZfm/xsLk/xsMCQhLJ9v1gRUg7bUjipGj/5P4EAJvou87tNUIJR3nn7EVI
85jnCUAboTYnDVq1K1gno/oaSbrpHKeydWK7a+0Z5ID15BEmyGaRBj6vo60tMbXP
KmuDmwl7nPMWubZ5NIAfRz70HjGXGfLE58ElfkCtkjBp4DhQKCg=
=89Ux
-----END PGP SIGNATURE-----

--Apple-Mail=_2D885FE3-7A54-4BE1-A4C8-F9DE1284985C--
