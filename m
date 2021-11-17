Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EDB454E86
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Nov 2021 21:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhKQU3R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Nov 2021 15:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhKQU3R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Nov 2021 15:29:17 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E12BC061570
        for <linux-ext4@vger.kernel.org>; Wed, 17 Nov 2021 12:26:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so6242104pja.1
        for <linux-ext4@vger.kernel.org>; Wed, 17 Nov 2021 12:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=s7G35Fqq4rBCcnJ9EJxEyyo1cjOUNa4BwbpcDJExHfk=;
        b=673cMad0GPYWw33I+4QPMx4ohGqZtOfUxdMwEIO/u1UKNEvOOEJ9Wl1S6Utnt6RT6g
         rW9j9gwAfEoAwmqsY+9oGXgg5+RcVTjvZLPcvIi3vFBIqFqdnLGDzuKdKffgHogBQL15
         RRJa/pN5SJVj3LhxtT2IAbb75tvAXvkDAyY9ZnaRNaQHSTUhT/CFNLk0e6yv+7NpVjBF
         OX+++KGT2gzehaN/DPdRvRd5RfxAUvUQPkMT7NvoWGwBhG4kD+wGmufEF0yadT4OPZBm
         vIiYU09+7gNDuRFZXDGgwbc0oxxO8c9RrcpOvsiJUF92v2zB6t2AwTLxhiTTkqZh+JWO
         dqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=s7G35Fqq4rBCcnJ9EJxEyyo1cjOUNa4BwbpcDJExHfk=;
        b=a2tPzci8T4scWKpsJyffXtud7S5wDgVA3Ctvh/Fjj7ktB6RGUFw4Q+7N+Z2VSKdk1C
         f3WPeij5bEW/B+AdN8zaXtOp9gn24BmtHEscIgm9vEXT92v0BZAB26Q1Fjy2JwzlpNXy
         NqiI65RtwMEoW4HI072tMCRScuak4WR13MHYBndaAwYy8NoS53PvqYL+r1MOflejPrk4
         mKlhENHwR3HT/avFpvJRltIUcWwUZTV9AJUbtNEiUHGYszD9r14hYy6FQ1R6WWvZNJ4L
         sJp8dd/FMjcmvwbkDBNwWAKx+MBI3Xk1rJ0W8MiqYM1AkA0ZUs1T328lTep1E+ijz0wQ
         6LOQ==
X-Gm-Message-State: AOAM530pLI2DH6sSmLIS1U/7NW9hbM2tJvG7u4xVeVRID4SEvHbS9T0k
        ZU597wz+IW2QqOGgQvnHEFicZA==
X-Google-Smtp-Source: ABdhPJwGHX9zxA7hcNx6nnKshjSLxtHvx84AtqCw2nlWe8YRFrZ9Qk0uIvLzz1MWa3eIUxHQ/Sk2MA==
X-Received: by 2002:a17:903:1d2:b0:142:24f1:1213 with SMTP id e18-20020a17090301d200b0014224f11213mr59602423plh.81.1637180777449;
        Wed, 17 Nov 2021 12:26:17 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id j7sm6301574pjf.41.2021.11.17.12.26.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Nov 2021 12:26:16 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4423B081-F635-45FB-BFE3-0A75D8F5B0E0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0FC7EBE0-F731-4844-8F5D-978C5EF625F7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: drop an always true check
Date:   Wed, 17 Nov 2021 13:26:13 -0700
In-Reply-To: <20211115172020.57853-1-kilobyte@angband.pl>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
To:     Adam Borowski <kilobyte@angband.pl>
References: <20211115172020.57853-1-kilobyte@angband.pl>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0FC7EBE0-F731-4844-8F5D-978C5EF625F7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Nov 15, 2021, at 10:20 AM, Adam Borowski <kilobyte@angband.pl> wrote:
> 
> EXT_FIRST_INDEX(ptr) is ptr+12, which can't possibly be null; gcc-12
> warns about this.
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>

I was wondering if this was intending to check if path[depth].p_hdr was NULL,
but it is clear from the rest of the code that this could not be true, since
it is already being accessed earlier in the code, so this looks fine.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/extents.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0ecf819bf189..5aa279742da9 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1496,8 +1496,7 @@ static int ext4_ext_search_left(struct inode *inode,
> 				EXT4_ERROR_INODE(inode,
> 				  "ix (%d) != EXT_FIRST_INDEX (%d) (depth %d)!",
> 				  ix != NULL ? le32_to_cpu(ix->ei_block) : 0,
> -				  EXT_FIRST_INDEX(path[depth].p_hdr) != NULL ?
> -		le32_to_cpu(EXT_FIRST_INDEX(path[depth].p_hdr)->ei_block) : 0,
> +				  le32_to_cpu(EXT_FIRST_INDEX(path[depth].p_hdr)->ei_block),
> 				  depth);
> 				return -EFSCORRUPTED;
> 			}
> --
> 2.33.1
> 


Cheers, Andreas






--Apple-Mail=_0FC7EBE0-F731-4844-8F5D-978C5EF625F7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmGVZWUACgkQcqXauRfM
H+BKbhAAttH4Wyyq5qGSZ/0G1W0NtRt3nFPYWDRn9WT6aONbb6t74CxUQeM+Vdk5
noLYwUXKTUIkhHI3Ase87ITNSSCjQJ6DkCAOZUkP+kxlDLqK3XQ9lu98Y25qNT2v
DTNds3YqxtCMLu0uXFJA3+vb5FpreGbU2n+eCKRTe4X16Kl+W5iYQIbXj4uSoV4m
b0ma5DWxoEGKKx6nXX6M3Jg3PSNVdjFMgMQv6uFqEhNDQjdsHrCxF/siedeNUqlq
nZPYijh41/Wo9shKovunQpW244SsXga3wbywrAwoLZkFItvcC65fxpyXxS8HziH1
eh9kVbW3Y+P++zgly4cgxyQ3o9re598dotZICed3AM/OmkchhrYnGxjDSNqph8oU
pvqL8nYvo519H07+3uDUP1o4GS4w/NLi/L9SVdg7N4Ik7W4x9HE7A/YgWIuGWq5S
oQ/gurG1dhzYfrMPCRQ0E3qqy5hdg3noE9OXt1ChxHaBa4kedidkB/5wh7mSmfln
5aL+tnjsfbNSWVcX7Vrsnf3hQ4J1IUsPsWgEXJj+LnmmN3g0XAfUAb3ndzybc4/J
kE/65XPxyNd1p7yO4ZqEGnZQ3yg+u5BtJq31II9sDONs4+/HJwjURQaWeaH1SJkp
ah+KWa1p+N/MLzPgsulGpcDLaJj/5nbR5KtHgpPivJDwRCDPfmo=
=pTax
-----END PGP SIGNATURE-----

--Apple-Mail=_0FC7EBE0-F731-4844-8F5D-978C5EF625F7--
