Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7073415F6D6
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2020 20:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbgBNT1X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Feb 2020 14:27:23 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41392 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbgBNT1W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Feb 2020 14:27:22 -0500
Received: by mail-yw1-f68.google.com with SMTP id l22so4728525ywc.8
        for <linux-ext4@vger.kernel.org>; Fri, 14 Feb 2020 11:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ieIMOxjEgy3g45y7ITXTX6m34I+6IrsdKCk51XjGiD4=;
        b=SBLT+q5lnNm0f7mbc6dH6X0O+tvgIDIAC+tPZ5ZNsAe1BWlo6bLOFtBd4RRM7s+Fki
         kaI6/wQsQ+ZGfmUIk+XtXtUwOls4y3Hh2C4gZiQvafQWUNAhbCXowehdMnfZE8o/S0yD
         K1zHHAOz/mA7UN10ym0ZB8VRYtHJf4amrJsWLlPmMSRJpmlw92NTK1F8wMhgtCukT0Tt
         sxOKo3uXFiAq1yAw527GE2zRcA9hKVkwei/vveIlSeWTM8S0K8KIwWA7XLmHwOFbIfCD
         CVlHWgv+KemP+jFEPTudl1AQmpCWVg0KJdz6USYSsWsLGG/UtgYQkCe0BsmRm8UpXWw/
         4v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ieIMOxjEgy3g45y7ITXTX6m34I+6IrsdKCk51XjGiD4=;
        b=mtdBM1wufXS/c2PfIZpzXEKlSkKgS4fOd4j+tPjFl4dJCAx+HvQwplg7ol0f0FtLU1
         j7GHbflzRRiBDFeJSwfhxL7Mr41BpOca0OWAzXGlXeMPVj7JYd22/BwLP+dbdsLHzNgb
         WL8qBZ+hl67SgBdCKdGhLL0+v6F/j2xeXSFKcBuCRj5QVogktohTamYoU1AEwv507jHy
         taAJRspJI3IbYAvHtjGLhGhcPjNHa1Z+6QhvoG8kQqDQeGn68yGy5CKNycyhNwhU+gKG
         5c7cizBaNbKhk3Ib9rQg/UmgT1D5YM96thRswzQYGj819xcgjR7r0w8oNdR/NN4qW+3G
         H1QA==
X-Gm-Message-State: APjAAAXKWAphISSYbCtoCyAVekyLEgsqo+UeNVEFUk7YzrPXjQ8AYC5m
        KYp7fGIDyIJLkQll0FPaSpb3ZOvF47BEFw==
X-Google-Smtp-Source: APXvYqxM3WnRWGLa8Fvqh0bWJG3Lh4fMuSyqZKIqL4xGW45CB8/KdsTlLuRi7s9pbBswx015P074jw==
X-Received: by 2002:a81:9bc4:: with SMTP id s187mr3785034ywg.285.1581708440317;
        Fri, 14 Feb 2020 11:27:20 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id p2sm2563171ywd.58.2020.02.14.11.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 11:27:19 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BDFA8757-6862-4A11-A76B-A049741E3420@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_877E5F3C-FF4E-47DE-ACFE-E97E133A3CEF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/7] e2fsck: Clarify overflow link count error message
Date:   Fri, 14 Feb 2020 12:27:17 -0700
In-Reply-To: <20200213101602.29096-2-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-2-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_877E5F3C-FF4E-47DE-ACFE-E97E133A3CEF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 13, 2020, at 3:15 AM, Jan Kara <jack@suse.cz> wrote:
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
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> e2fsck/pass4.c   | 20 ++++++++++++++++----
> e2fsck/problem.c |  5 +++++
> e2fsck/problem.h |  3 +++
> 3 files changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/e2fsck/pass4.c b/e2fsck/pass4.c
> index 10be7f87180d..8c2d2f1fca12 100644
> --- a/e2fsck/pass4.c
> +++ b/e2fsck/pass4.c
> @@ -237,6 +237,8 @@ void e2fsck_pass4(e2fsck_t ctx)
> 			link_counted =3D 1;
> 		}
> 		if (link_counted !=3D link_count) {
> +			int fix_nlink =3D 0;
> +
> 			e2fsck_read_inode_full(ctx, i, =
EXT2_INODE(inode),
> 					       inode_size, "pass4");
> 			pctx.ino =3D i;
> @@ -250,10 +252,20 @@ void e2fsck_pass4(e2fsck_t ctx)
> 			pctx.num =3D link_counted;
> 			/* i_link_count was previously exceeded, but no =
longer
> 			 * is, fix this but don't consider it an error =
*/
> -			if ((isdir && link_counted > 1 &&
> -			     (inode->i_flags & EXT2_INDEX_FL) &&
> -			     link_count =3D=3D 1 && !(ctx->options & =
E2F_OPT_NO)) ||
> -			    fix_problem(ctx, PR_4_BAD_REF_COUNT, &pctx)) =
{
> +			if (isdir && link_counted > 1 &&
> +			    (inode->i_flags & EXT2_INDEX_FL) &&
> +			    link_count =3D=3D 1) {
> +				if ((ctx->options & E2F_OPT_READONLY) =3D=3D=
 0) {
> +					fix_nlink =3D
> +						fix_problem(ctx,
> +							=
PR_4_DIR_OVERFLOW_REF_COUNT,
> +							&pctx);
> +				}
> +			} else {
> +				fix_nlink =3D fix_problem(ctx, =
PR_4_BAD_REF_COUNT,
> +						&pctx);
> +			}
> +			if (fix_nlink) {
> 				inode->i_links_count =3D link_counted;
> 				e2fsck_write_inode_full(ctx, i,
> 							=
EXT2_INODE(inode),
> diff --git a/e2fsck/problem.c b/e2fsck/problem.c
> index c7c0ba986006..e79c853b2096 100644
> --- a/e2fsck/problem.c
> +++ b/e2fsck/problem.c
> @@ -2035,6 +2035,11 @@ static struct e2fsck_problem problem_table[] =3D =
{
> 	  N_("@d exceeds max links, but no DIR_NLINK feature in @S.\n"),
> 	  PROMPT_FIX, 0, 0, 0, 0 },
>=20
> +	/* Directory inode ref count set to overflow but could be exact =
value */
> +	{ PR_4_DIR_OVERFLOW_REF_COUNT,
> +	  N_("@d @i %i ref count set to overflow but could be exact =
value %N.  "),
> +	  PROMPT_FIX, PR_PREEN_OK, 0, 0, 0 },
> +
> 	/* Pass 5 errors */
>=20
> 	/* Pass 5: Checking group summary information */
> diff --git a/e2fsck/problem.h b/e2fsck/problem.h
> index c7f65f6dee0f..4185e5175cab 100644
> --- a/e2fsck/problem.h
> +++ b/e2fsck/problem.h
> @@ -1164,6 +1164,9 @@ struct problem_context {
> /* directory exceeds max links, but no DIR_NLINK feature in superblock =
*/
> #define PR_4_DIR_NLINK_FEATURE		0x040006
>=20
> +/* Directory ref count set to overflow but it doesn't have to be */
> +#define PR_4_DIR_OVERFLOW_REF_COUNT	0x040007
> +
> /*
>  * Pass 5 errors
>  */
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_877E5F3C-FF4E-47DE-ACFE-E97E133A3CEF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5G9JUACgkQcqXauRfM
H+A0hg/8Dfmr2wWPNDxP1e0czgFIbd7JUAsgOx4Il+LPOZAOKrz4+3F3J48rOsjw
aBqGkDLZMnDVuPLRx7pDZBmaCYPtM2nv2Jhl3LrcG0t8zmO39x/o5dvwzknmGJNX
lemwsFMkElqzjmqYzZ6O16TwABp9Q2doV/rqqTvKeMIK4499SbQaFGQ77cCzZ57X
FtUbggGEggYWyrA9JSsgbMCngbgHyNMQaCFJyix8pkvz53MOjhp0DRaFB6AS7VfT
01CgD3CC25nXSIoHFiQ9pORHqiHf2bey2WMQ8zGI9OtC0brJzVDr7dhB0XMBjxzn
JovA8tbba0Fof7qgmkywoXFKwEBG/CJ5VO67G5jYyRLxl2mTyGXkQFeMC7+Rt+D5
CX1EuhwMkr3ZN1sycuSuruTevFZepDhGZ31/MPCURuOB12SVC2F+HggEdAE1EhXr
vhYFzumJaih5YwYC1nt03bvkCqupLo0Bj88BmuqmCO2AfLmqAGw7fz1mrjv/0ZtF
bkeTahkiwyy1zNKoJ2A2iwcRTt7Xb8RtmQa2UAsSpxd570spg5JtJxoLSnJpj7zS
j89e1jgxnCPuG4h3CRDXc6wB4IeEBJAte2eajjJWRltEuSugbK1kPQghVdNSqcw0
EsSwTmy5ClAcAtP7GBj4q/SeqrCLgPOs5j+A7tClLYt8v841saU=
=8rf7
-----END PGP SIGNATURE-----

--Apple-Mail=_877E5F3C-FF4E-47DE-ACFE-E97E133A3CEF--
