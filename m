Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9AB29797C
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Oct 2020 01:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758457AbgJWXHh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 19:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753460AbgJWXHh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Oct 2020 19:07:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89CAC0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 16:07:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so2661729pfa.10
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 16:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=DaqIhbBKCqgth5kQdU0KWLwxos26i7oxwU7LEhEOStU=;
        b=T0cx4OtGwYfQENtMDgeFazH97sMqECzEw83x4Uf2PMWEQuBlJ/RyqF2PgqK+8N4v3y
         T2nkYQ3ksUPWTdj4nPIVzgn6WlF0fS9qvceGrCnZhIXRw+OZVUII1hX1xMXizqHu90Um
         8u2eFz7ENqDKlHkJPO9OofT+ECy/6oSDhxJpNsxBDGv8Q4pA7/fubZ17TXmrXZLMx8rl
         XcIF8IoyZGC6i4DUZFtpvzGHvd7FqZ73OyNZSDPoKT/cIJSWTbj9N2USHUZvbe0ieEWO
         Pp4QHTSbbgj7Ugsd6RVzjIbNkDdEhowWszCkSvIJd5+p9kNgMGMEeQb2YWsreF0rDl7Y
         hv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=DaqIhbBKCqgth5kQdU0KWLwxos26i7oxwU7LEhEOStU=;
        b=bfT71mYgtlNHkjXUzY2XApGlk4CFY+b47iu4Mjv1uiTQyBaRo+EY1ir8C3oB89nU5u
         /+QOq4XUe+fT4XNPZNHHpWjH38XVMozgiMZByg9uXA7ItmM7v/mWg/SaJ4S0akheE6zp
         Slvlk1Y9AxZ3Ypg9ULk1mCpN9mKwQmVypTLYBJ7HxZFFuzExm7elH/tQ4WHH8Ud+CT0Q
         5E7xk6pIu4KrreqUrwuFZFI1/IKcEKUiO5Pwn3/fLYCerclbK47kDAFKKyPDcSvIwfgQ
         fxsuRJkCiDGczJPVqyFQvLr+/IzlYFxvYmQirA26q9fhtEWUZfHQ+ePnxmc0S0LKC2DT
         oCJg==
X-Gm-Message-State: AOAM531ENgvPMTISbB5IDfYGEBA7ZB4wuZQSgNsYNkgMjLGrcX54fB2S
        TgxwnbUVkDZ3XmICbvpe61ESDQMPgftBZ6Yl
X-Google-Smtp-Source: ABdhPJzS68mWt3NWLr9v4/L28tQ9EB0nUUZk8Hi7JqpfSY20r9uqWOIUQk4LkTg3HqboKyBJNdkXqQ==
X-Received: by 2002:a63:44e:: with SMTP id 75mr3542867pge.401.1603494456515;
        Fri, 23 Oct 2020 16:07:36 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x26sm3252497pfn.178.2020.10.23.16.07.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 16:07:35 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4FEF7BA2-4A6D-41AA-882A-5F33549E6441@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_ED6BB263-4CBE-4456-8A7D-C56270593485";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/8] ext4: simplify the code of mb_find_order_for_block
Date:   Fri, 23 Oct 2020 17:07:33 -0600
In-Reply-To: <1603271728-7198-3-git-send-email-brookxu@tencent.com>
Cc:     Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Chunguang Xu <brookxu.cn@gmail.com>
References: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
 <1603271728-7198-3-git-send-email-brookxu@tencent.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_ED6BB263-4CBE-4456-8A7D-C56270593485
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 21, 2020, at 3:15 AM, Chunguang Xu <brookxu.cn@gmail.com> wrote:
> 
> From: Chunguang Xu <brookxu@tencent.com>
> 
> The code of mb_find_order_for_block is a bit obscure, but we can
> simplify it with mb_find_buddy(), make the code more concise.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Removing lines is always good.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mballoc.c | 10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)
> 
> static int mb_find_order_for_block(struct ext4_buddy *e4b, int block)
> {
> -	int order = 1;
> -	int bb_incr = 1 << (e4b->bd_blkbits - 1);
> +	int order = 1, max;
> 	void *bb;
> 
> 	BUG_ON(e4b->bd_bitmap == e4b->bd_buddy);
> 	BUG_ON(block >= (1 << (e4b->bd_blkbits + 3)));
> 
> -	bb = e4b->bd_buddy;
> 	while (order <= e4b->bd_blkbits + 1) {
> -		block = block >> 1;
> -		if (!mb_test_bit(block, bb)) {
> +		bb = mb_find_buddy(e4b, order, &max);
> +		if (!mb_test_bit(block >> order, bb)) {
> 			/* this block is part of buddy of order 'order' */
> 			return order;
> 		}
> -		bb += bb_incr;
> -		bb_incr >>= 1;
> 		order++;
> 	}

(style) this while loop is actually a for loop:

	for (order = 1; order <= e4b->bd_blkbits + 1; order++) {

Cheers, Andreas






--Apple-Mail=_ED6BB263-4CBE-4456-8A7D-C56270593485
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+TYjUACgkQcqXauRfM
H+C6jw//bim9bvKBYM4OFPEsfH3rRBhZJL+KJRI7Q6rWhmgCj0Zza7wzK9cR5AkK
Rr7nbETFKNxkNMhBkj8Z1eFwvlxqqlJXjmQdQsL/FUyW7EnGtrQf3LQEK1+js2dy
ndA0/9vUkznMEVey9XCXnzodRdJNgwPbnCGzhQwUSqOYPNpHJYSdKsfTWHlcJLgE
B0+qXUNPIfN9R7VNBgSQAEd/m7se/IJWGyENfxqs4mug9zoOFih2uOF2Ydk6tcVJ
HdDJcMlZTOX9hiW/bsKCTCI9YIAr2VhbH1uEE3BUmifhxk0/EoPfV9D8W8/ZEWb+
mhcWYRzKF4M63DtmJJbf3h5/ooZrtTelAJTtj1653BYoywT9RAEyW04CWPe+Uc0i
PwKuJqdTA1Vz9H24GKP52ZYxwjiWw1xzzXFyesLCJ1E72WeAYS77lqqvKccKMoDp
IRwa6aBci9kBJTMebmmQOAm8R4ybfnqGqerZQ8SLE/jlr/ivy5TGzSXDTBFce953
3DqBbnqFsGYS3B4NwNm3i1RC9zGfLKEm+LAnuY+Mdt1UYAEodR9jPbX5KJFavhHt
w3qhuPNAsZv4CDxTFu9Uhp3LqTwQzNkXHvCR5XesdG3NgUTJHiN8fJu5gLEewOSZ
OXvCKjBFKrNXGDTbfZoIorKCpEGVh3M1Ff2ftNGvhN5aUuCpDXo=
=ZoWn
-----END PGP SIGNATURE-----

--Apple-Mail=_ED6BB263-4CBE-4456-8A7D-C56270593485--
