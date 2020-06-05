Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8337B1F010A
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 22:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgFEUgV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 16:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgFEUgV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Jun 2020 16:36:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B77C08C5C2
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 13:36:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so5505481pfc.5
        for <linux-ext4@vger.kernel.org>; Fri, 05 Jun 2020 13:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=msUtggEq7pJms5Yk506+/U1xbBcyY8aiwqUWvN+lgDs=;
        b=e/xglHGsmYzsmiPD6xuRXrkV8tWOi9y0UdiMtfPH/y8TrQhPBMSpww8ZMPw0XbA/+T
         od5diZQR+UpwHxf7TGFKJpsRulH1Qlmd0v2xDN0W+iCaDAZMeXyGEL4e7/tExl4y9i46
         rIcefDslRJPD0RqzsJVRNUsnnTx0M8uJLwrCjxoUsCuFax1om1r5EQ/0GTplIn5BadQz
         nl5QThw6z/qaCFSRsUdv9i6amgy2AVRSY0eYo4vV4ZkMJkGItZ4z8P6xRChE21E6b9F7
         fYIN2Z2YoVbw+iYV0uELrvWLyfFxBLq9a6pcGc10XP4EMNqlrquTCcH+jMlGVJYzYlkS
         O2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=msUtggEq7pJms5Yk506+/U1xbBcyY8aiwqUWvN+lgDs=;
        b=JXgd8oB0cipvOHGdWAIbHTPiKW7QdRzBLBaM4Z5fWrzVXf7OGBcFO+CO2DbUX08vOy
         IK6Svlu8uI+n2e/WmeVGIVDWYScrmkz2329nVtwfjqdWGoHjNxzb+vx3FJEmy9VlW9ap
         mI7lPMSKNGZIYemmUZZvJeeis58PVgvyjxIE6P26pVvDcN6F2arksDR8XWGmQaN/ZTtN
         w2TOhojXMe6ThkDglFIhVvutkCk4yEUyAjFZplgHUY2U1P6Cix9gwYLf3DKckaOyf98q
         7upgF0QlSUnZP7HKvwJsCqfGEXC7fJo2Wk6/XmxFoVnbRSEtJXshnDTBsw6c/Db825Gv
         U3wQ==
X-Gm-Message-State: AOAM530MJRYm1eOWmvjEBg98VGBuHeeIqXuXw6/aP1IMJPhtqzfaQv5A
        +oyuRLC1apyQPZOloz7LQ0lOtjoKEoY=
X-Google-Smtp-Source: ABdhPJy1gVdFQimhFjmtq1caniDKNnV2L5mcQbO4z75cQ7eTGtlPDn7PsqSHL+XgnJR2yhGapMliAg==
X-Received: by 2002:a62:5fc4:: with SMTP id t187mr10840294pfb.131.1591389380505;
        Fri, 05 Jun 2020 13:36:20 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id f11sm430230pfa.32.2020.06.05.13.36.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2020 13:36:19 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3FF44ED7-EAB8-4DB0-87EB-D3A673B571C8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_BA0B398C-8B99-4F5C-9BFF-52F96E4DB96B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/4] e2fsck: remove unused variable 'new_array'
Date:   Fri, 5 Jun 2020 14:36:14 -0600
In-Reply-To: <20200605081442.13428-1-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
To:     Lukas Czerner <lczerner@redhat.com>
References: <20200605081442.13428-1-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_BA0B398C-8B99-4F5C-9BFF-52F96E4DB96B
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On Jun 5, 2020, at 2:14 AM, Lukas Czerner <lczerner@redhat.com> wrote:
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> e2fsck/rehash.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
> index 1616d07a..b356b92d 100644
> --- a/e2fsck/rehash.c
> +++ b/e2fsck/rehash.c
> @@ -109,7 +109,7 @@ static int fill_dir_block(ext2_filsys fs,
> 			  void *priv_data)
> {
> 	struct fill_dir_struct	*fd = (struct fill_dir_struct *) priv_data;
> -	struct hash_entry 	*new_array, *ent;
> +	struct hash_entry 	*ent;
> 	struct ext2_dir_entry 	*dirent;
> 	char			*dir;
> 	unsigned int		offset, dir_offset, rec_len, name_len;
> --
> 2.21.3
> 


Cheers, Andreas






--Apple-Mail=_BA0B398C-8B99-4F5C-9BFF-52F96E4DB96B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7arL8ACgkQcqXauRfM
H+CDdA/+N3YJw4PIldpF8BmCgdDTJRS7X0MOzvRbDbcdjCl5WMZag+ZUm1c7YVVj
z5njG+h549jPW4AItFUrw+metQp6SvKfM3A2On+6BrbQPLlRk4a4naDSsuufR9u/
hcJEmiwesPe/1K7AqSe+a53FyfYH0F5h4Q23HnlgXjEB0I6tBlXXIokkUz02AJr1
lHjfmMnAwY07LCr9iO8JFKfxSoU5ZMfuEFdCRVKu5zKEZop0vCF5mwXxVOGS8n3Z
RaBgsRPB+JdKeI3cxbWz+bIUViQEefjV6klykyfupRZjYGFFShn1VsflZeW7bLV5
psKeSaASf6FSHrfs4akc1m/hLZE+/AVe7WCbkCpsp5ZK1L8HaBMmDwBRI4yxt2qk
JGHzYletAx4XlsxUFeM7ybW3PI0T4z8DdL+2t6l+4tEvh0GATDjK/iIhLrkthPxy
K9pnKFe/LDRjWtUmW/QMBB46ZeQIzX/ZGGrja6OlFo42DHkBUjitISPZ7KUWbGwR
i8x2WAw6WN8iWz7V+RxnAcrGkBIbUpL08cq4Upl3KmNZtT+NtRmSv4wJjr7dHU4t
u1TJ3nYOco4UB6fj/lCr+jdI5umkwKacZUXPn3oSvreOk5XkEV2BLsXj5vcm35GN
fKvUulLfcRfTb+yre2BRwEngj6Wr+rT3K6xeb5RE0f0GK6S3ovc=
=JIJ9
-----END PGP SIGNATURE-----

--Apple-Mail=_BA0B398C-8B99-4F5C-9BFF-52F96E4DB96B--
