Return-Path: <linux-ext4+bounces-10317-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB351B8CF09
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Sep 2025 20:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CD4460861
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Sep 2025 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A961D31352F;
	Sat, 20 Sep 2025 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="SvAyzx9R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FF2FA0F5
	for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758394444; cv=none; b=r12o75TpjF06AO8fdU17abHYII9ty5M9hYCJYQxSfGn2ddxcMkVB0HQW3roTFj7w+TF4RzuUGk+rSVmAs76GyG+c+YlWNKlaFKRwGLAwHgZifsXMDgoJZq/w5KZBSddQ0D30Rxt/8hujGcOUEnQmZInasMGaj/wLtDtNn09WI1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758394444; c=relaxed/simple;
	bh=+BeI7VtP9WAjxgpPEOAPRR66aTxHPYfIKYPIxQ4WHlY=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=AVJkQGLOrc7xTAmNIB2iOZNeeEh3jjbzIKzm4iNkSz5sSgkdsBeHe2Dz7cEvGe8nW9/ScNyiyyNjXZvTrwGlU0EKCZzlyAXhc5X6epQZEISEG6VyhuQetxkfw6ePIe3OC5IlmHpKzh90fJygs/lE1LxGwLF9hGHGnrojiFi20rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=SvAyzx9R; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-271067d66fbso6896155ad.3
        for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758394441; x=1758999241; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n76mQF7Qom6AzKPUqbjFeL15kW7eCaM7/A8whZY1Ui4=;
        b=SvAyzx9RYjMKXjZ+h18FSwjTDo09/EKRuod1dPysC1g4hLaGl9u0yFxld6C89/8XNb
         /EeKCkEl60ZW+6hn6ByAlfpeUK8/k450TYDbNyo4jw6GYcBIzdTjp2LTzRYieiMwZncB
         Sw0Ua/TfyFId5FrcdFAHcfFu6vWkb8Jy2aOfpf6vZmqtkvwk3uwXlNGdM4Yluxsy9WtC
         HJcUTHJvsAZwu/ikji4WrLJa/WuxNYOUP5Si71IS99VvEopdw3zySbD1lQTNbPqnOd7r
         9F1733R/NRUhGjVDJKb/3z8ie2w6UILBCmfCuJv0IHD93dAlArY76UCIEdRzmfGlJXiU
         3Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758394441; x=1758999241;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n76mQF7Qom6AzKPUqbjFeL15kW7eCaM7/A8whZY1Ui4=;
        b=fyIWj3GyNgCJkrHuJ53yvV7gtXh/D3eYsVo/+coYdq1AE31e0GUn+rUE5eZTNON/u/
         iaWuLXPDOuhB2kicmH4QIw5sPOpbEkCvq8N6pgEiXQM+XFe3VDB46CJUp8vucebyccDr
         0JWzn99ZVr+sZtyN/T6osC0ZruqyxxtnZAW/pYOphD0Vi385sJLshGK/FmmYqAPbHkd7
         tJguzVBuf79yAhCEh7F0qKKUUFeC0gNs8w9MVgbphkN1vTMY/oLt56iT9EyeJEkd3hsK
         ZXNkCURbMidOhqAfXACwV5CUAESZaaWi7Y3DZraHFGXG3fBEed3bF3kC91l3SKBBtxJv
         9XLg==
X-Gm-Message-State: AOJu0YyzGuSy+sBJo/d3RrqEK2TgjxZg/QTREwAEn5hGEdrjwHcQKvhE
	EQdArzj8eTA3/EWgtTVObCG1DHC3MlNrj08N/ifVFbWrV+oIGf2KdkzHhuvzAgr9co2Tbharyba
	0WidO
X-Gm-Gg: ASbGncuP+0OYYOGYubEHt4+LHp+2QQ1GdNf8TPt+KQU9j36HdInbOYMQ4SparYto0uY
	nLfa0Ps+YIoWqpDnUQWGZ9CfcRmzPv1u2H1BWPddYeWv3l9kObia2QcSjOBZNBxW5cmk0ceCiof
	zKccDpQbGnA3zT6sGT2eF56qEIq3Sx6+aFsbLgczfmN43Ba9jZv/3rVNOLXpErdMMw4+lp6L+Kc
	ENRlvNZ7OE3Q6/Ksv2o9f1T4rV+/lpih/rC+rqIMp2IKTxk+Q+EDYy2LnYR741MXM/yw7/9Iwnb
	HSXi0//ep/zJJV2c7JdUHGasyoBPDopglZVYkwBt7+ZjkZbsp1EtweQLdhcL2hD6H/W7guKLH7x
	/3dlZ5vWGKdaFBoD8GfBw6X4N0LU91sefGd3zNsGeX5tMdTaO5hrvW4AReuMwk3W514ygS94=
X-Google-Smtp-Source: AGHT+IELH8L0xGDBwAFwJ46dJEdFi+Amgrj4NIaYTWC6NoOKtfa8KBccUls2mYLDJ3xEZs1Aabu0Eg==
X-Received: by 2002:a17:902:e850:b0:246:bce2:e837 with SMTP id d9443c01a7336-269ba535600mr123896385ad.49.1758394441076;
        Sat, 20 Sep 2025 11:54:01 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26857a0sm11807678a91.2.2025.09.20.11.53.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Sep 2025 11:54:00 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <B480E3DD-32ED-444E-88A8-A4B18921A49A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_05F76CFC-163A-4DD2-B4D0-8C4BC9753A48";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 2/4] mke2fs: support multiple '-E' options
Date: Sat, 20 Sep 2025 12:53:58 -0600
In-Reply-To: <20250910-mke2fs-small-fixes-v2-2-55c9842494e0@linaro.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
References: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
 <20250910-mke2fs-small-fixes-v2-2-55c9842494e0@linaro.org>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_05F76CFC-163A-4DD2-B4D0-8C4BC9753A48
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Sep 10, 2025, at 7:51 AM, Ralph Siemsen <ralph.siemsen@linaro.org> =
wrote:
>=20
> The '-E' option for specifying extended attributes can now be used
> multiple times. The existing support for multiple attributes encoded
> as comma-separated string is maintained for each '-E' option.
>=20
> Prior to this change, if multiple '-E' options were specified, then
> only the last one was used. Earlier ones were silently ignored.
>=20
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> misc/mke2fs.8.in |  4 +++-
> misc/mke2fs.c    | 16 ++++++++++++----
> 2 files changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index 14bae326..99ecc64b 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -268,7 +268,9 @@ Cause a kernel panic.
> .TP
> .BI \-E " extended-options"
> Set extended options for the file system.  Extended options are comma
> -separated, and may take an argument using the equals ('=3D') sign.  =
The
> +separated, and may take an argument using the equals ('=3D') sign.  =
Multiple
> +.B \-E
> +options may also be used. The
> .B \-E
> option used to be
> .B \-R
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index 3a8ff5b1..a54f83ad 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -1653,7 +1653,7 @@ static void PRS(int argc, char *argv[])
> 	int		default_csum_seed =3D 0;
> 	errcode_t	retval;
> 	char *		oldpath =3D getenv("PATH");
> -	char *		extended_opts =3D 0;
> +	struct str_list extended_opts;
> 	char *		fs_type =3D 0;
> 	char *		usage_types =3D 0;
> 	/*
> @@ -1751,6 +1751,13 @@ profile_error:
> 			journal_size =3D -1;
> 	}
>=20
> +	retval =3D init_list(&extended_opts);
> +	if (retval) {
> +		com_err(program_name, retval, "%s",
> +			_("in malloc for extended_opts"));
> +		exit(1);
> +	}
> +
> 	while ((c =3D getopt (argc, argv,
> 		    =
"b:cd:e:g:i:jl:m:no:qr:s:t:vC:DE:FG:I:J:KL:M:N:O:R:ST:U:Vz:")) !=3D EOF) =
{
> 		switch (c) {
> @@ -1796,7 +1803,7 @@ profile_error:
> 				_("'-R' is deprecated, use '-E' =
instead"));
> 			/* fallthrough */
> 		case 'E':
> -			extended_opts =3D optarg;
> +			push_string(&extended_opts, optarg);
> 			break;
> 		case 'e':
> 			if (strcmp(optarg, "continue") =3D=3D 0)
> @@ -2615,8 +2622,9 @@ profile_error:
> 			free(tmp);
> 	}
>=20
> -	if (extended_opts)
> -		parse_extended_opts(&fs_param, extended_opts);
> +	/* Get options from commandline */
> +	for (cpp =3D extended_opts.list; *cpp; cpp++)
> +		parse_extended_opts(&fs_param, *cpp);
>=20
> 	if (fs_param.s_rev_level =3D=3D EXT2_GOOD_OLD_REV) {
> 		if (fs_features) {
>=20
> --
> 2.45.2.121.gc2b3f2b3cd
>=20
>=20


Cheers, Andreas






--Apple-Mail=_05F76CFC-163A-4DD2-B4D0-8C4BC9753A48
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmjO+EYACgkQcqXauRfM
H+DujBAAjOQl/ZMz4bApAzZbA2gC/WeWO8xG0zYtEZYyMYN4JJ2+T4RWVq8L3JpF
fBjw0WcR01u+pnq0+S9FtPCKDaz8nlQdGWZbwMxs8q0PaEnQcoNGV02uFaYCJSPA
uK0Sn+Fx8P4uQe3TcIRiwL57n39JG+cVdvoEEbURM5iY4tk0OL7TCTDQi6BAS2Ha
2oHt9FiVyObCaVt5akVjwnRiu8USu+7mHk8ks3a0yehOEbdcyHMquYEdDQCDctGm
3C/j3M8c+6M1uztCUlqIGQ6dwI/2pyD8/1k8nRoA+Our13ueBLBHMy589FnN3CUg
xBmUFvXuGX9XUefzsjk/2NNqLQh8PFXQapbgZ9rrD+VwubDunGQDgqnQAh0xmrhs
WrfrRfxzmd72eOc8KjSEVJ/EnUhYStPvufi2gN2qh6eGhqLgG/R831imBXq+K6Ox
KU/DEKoP5GRz3o1PxS0T7B8GJFrmd8l50eDY7LuU6+f5cdjQZyJaU0I3dxy3GMsl
Qw6J3jtRnDK4i8w5aQlR1803ODBLw5z5pKxO7Rz3PSll4d1mv0ASno1+IL/FRA2o
viNdduw1O4RWu7yRlqgxsNHrd7A31XidfzHBlOK6OJ/iW/JSQ8ij71quQ98zeZN5
qDAAbhOA4JZFeTcWEnRJRJE2PvL/cyRegvBlHWzA6kBjahpVESc=
=a61V
-----END PGP SIGNATURE-----

--Apple-Mail=_05F76CFC-163A-4DD2-B4D0-8C4BC9753A48--

