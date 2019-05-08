Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9ED1724F
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2019 09:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEHHKC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 May 2019 03:10:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46118 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfEHHKB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 May 2019 03:10:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id j11so9992762pff.13
        for <linux-ext4@vger.kernel.org>; Wed, 08 May 2019 00:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=T+Y5n/1kItNj/Wraq5boFXyk+YaoMnIUa2Kq93ASx4s=;
        b=nTPUhnxIkq/ys1Q49IT3TTaqpxV6Cy7X1FsCVQlkwaeTTKRhvWAC9V0+F5CtlUWZrV
         wkt08Nw8tYk8tyqU+Ool3Phi3VT9gZHbwFrLMwp9bjJ1xGq7h9oVOCn3u+uZvEFYjKSO
         KE8IsIetL2rxKjq+7BoprqKAgh+L7jWzUUIqL/zPLXUbr/f+Oi6ytBX/okSMtc7fQDSQ
         e9I9DT/mvIIZTcXpIjJ0zoSNxo5K+xL6/vFa2DbQoWGcxAb9ABY2iM9FmHCjPlQkF3/E
         4TIa6NZgbm9Hrs7TlVchQ2MvP4UXrgYJf85a3F+tDuljGBSQKLugnki36H77jQjwVEdC
         17Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=T+Y5n/1kItNj/Wraq5boFXyk+YaoMnIUa2Kq93ASx4s=;
        b=XfqCVAhOwKSWpyrTERXG2G/ixrZItOMeIuBL+FovDkMoXYQj0qLeYkVRFIbDTaeTix
         dRPFF1dOEg9veUU54xyEKKFk5HIFjbdIvz0t5/AmvZJf3sznzcklIDO0HxSEL9TMVvnL
         GcbOV9SkEUFAWHqRJ3OQSJ0V1QyCS3yUAfRKXyuOES6gLjpf3fjNmZ1+fON20MGZKzu6
         RPx1NA2gxIENyrGNrwhaKBgB4PfpY2SA3HJiDz1eSowaN/sjKkTvfTiWVKvGtSZS5cHv
         D0clw2Py2FMhn7HG89LLHaZw9CyEuEYc10ewIRjDkdYh9rq+x+KF7iqyDrYk8J69xfFM
         JMYA==
X-Gm-Message-State: APjAAAVn8SPNqy39G8N0p9Fi25jY1Cmca1G+3Iny2Ih2xsV2c/PF9ZeD
        x8Y0BxElnf/EZgNR6Z76W6nlOQ==
X-Google-Smtp-Source: APXvYqxk2m3K74J6O/mVHUf27bwYFe69Rho+Z44IcRmVS8rlYpfrnTYd8NvSok89A0IYfAwdG2vUAg==
X-Received: by 2002:a65:628b:: with SMTP id f11mr43263248pgv.95.1557299400795;
        Wed, 08 May 2019 00:10:00 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id w12sm9228247pfj.41.2019.05.08.00.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 00:09:59 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9EA5FF19-6602-46AC-AD1A-A2E5B7209040@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1BA7894E-B92C-4A98-910C-D0E24D6557DD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: fix use-after-free in dx_release()
Date:   Wed, 8 May 2019 01:09:47 -0600
In-Reply-To: <1557295997-13377-1-git-send-email-stummala@codeaurora.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Sahitya Tummala <stummala@codeaurora.org>
References: <1557295997-13377-1-git-send-email-stummala@codeaurora.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_1BA7894E-B92C-4A98-910C-D0E24D6557DD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 8, 2019, at 12:13 AM, Sahitya Tummala <stummala@codeaurora.org> =
wrote:
>=20
> The buffer_head (frames[0].bh) and it's corresping page can be
> potentially free'd once brelse() is done inside the for loop
> but before the for loop exits in dx_release(). It can be free'd
> in another context, when the page cache is flushed via
> drop_caches_sysctl_handler(). This results into below data abort
> when accessing info->indirect_levels in dx_release().
>=20
> Unable to handle kernel paging request at virtual address =
ffffffc17ac3e01e
> Call trace:
> dx_release+0x70/0x90
> ext4_htree_fill_tree+0x2d4/0x300
> ext4_readdir+0x244/0x6f8
> iterate_dir+0xbc/0x160
> SyS_getdents64+0x94/0x174
>=20
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

The patch looks reasonable, but there is a danger that it may be
"optimized" back to the pre-patch form again.  It probably makes
sense to include a comment like:

	/* save local copy, "info" may be freed after brelse() */

Looks fine otherwise.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/namei.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 4181c9c..7e6c298 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -871,12 +871,14 @@ static void dx_release(struct dx_frame *frames)
> {
> 	struct dx_root_info *info;
> 	int i;
> +	unsigned int indirect_levels;
>=20
> 	if (frames[0].bh =3D=3D NULL)
> 		return;
>=20
> 	info =3D &((struct dx_root *)frames[0].bh->b_data)->info;
> -	for (i =3D 0; i <=3D info->indirect_levels; i++) {
> +	indirect_levels =3D info->indirect_levels;
> +	for (i =3D 0; i <=3D indirect_levels; i++) {
> 		if (frames[i].bh =3D=3D NULL)
> 			break;
> 		brelse(frames[i].bh);
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation =
Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a =
Linux Foundation Collaborative Project.
>=20


Cheers, Andreas






--Apple-Mail=_1BA7894E-B92C-4A98-910C-D0E24D6557DD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlzSgLwACgkQcqXauRfM
H+BqDw/+OW1zyHI2woUUl4G4qodJ05Tws6F67FakYSQrsTt0Nq23FxQh/jH1N6Ge
3SP71KoSaVQrc+9sG9NJXhKY+ev1suTmGKdB214pyuVwyX8KlwDwzdR8LVbQH5PP
CKDiK9RfbwoF1lcjltH+h+BpW6Qb/dwafAzBHkPJI+S8n+1PjYNjMeRonGh/OO8s
5hXgumoc0+HIE4Rl9+A430HqYdZodZTPpzZBWBh+tXuiyxlOc8wRyxrs/2egp3vq
18NFZ/Zj9SDwbUfYfZVP/81/p5KDIbrBg6BqDXmuS6Yx40nOfQtX0BnHWBEFiGQN
eH+naiEt/cu1z0ASNJmQlX3D1TTOFCR1M8p+IYwh2uS3EBmDAjKG7ayAokmh/wjH
HmjG5vr5QmeUXwB/GFmdqlBNoht6vb/i7DnsgCEYKXKOvkYy7a+gS5VubhWqBHsy
omxlmH74xGZHGOe1WR/+ut16jCLWbY+NJSgTBidBWasOLbosWgMYe7PgGPHAxP03
rEgBvusfEvuD3R7FbUAKAQZn76QHroNFb0kN6yD/OAQ0rXFqcOX586UmVbh1/8oZ
svzQpqfJqBEsngbPxjnqD6TaDEYRbY5RgiPAWhkCzvpj+F9rUgdmsMtN+6keFptt
lCcRmrTi8WaKZfz+8ih2vQB2ZBr0LoQhHiVgglIAac4sRmv+qo0=
=EYlx
-----END PGP SIGNATURE-----

--Apple-Mail=_1BA7894E-B92C-4A98-910C-D0E24D6557DD--
