Return-Path: <linux-ext4+bounces-10318-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3FB8D1FA
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 00:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124E47A5646
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Sep 2025 22:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955851E491B;
	Sat, 20 Sep 2025 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="saSm42NB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB01B423C
	for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758408001; cv=none; b=SlHMJWhY38ZM2mBn+22oga237zgb5g+wTlEoeFGP87dNRINWOmte/dMUKu019lTWv6fIQUR5tuLh5XrzbxpsU9i0hxA3P3Zv3PDlKTeNVShNBM4kf5KhQ2+v3rhLpDUto/l5oOEnt5yqDA9uvK9NfPDsO9a4v/MU1QTT0iiZ2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758408001; c=relaxed/simple;
	bh=7T/CdjZJrZoO9QWU7NqUQ0V37136vusXpHLPPdYI1jg=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=FFEzGxVPT445lE3ULzE0tziq7MzKdaVS1+zHvWkpK64Wi8pHkg5gK32IwlHs6TBFtFxq7+sEk+HYO7bWEWg2nkghc50PoK6nhm9YRNEPrsvFiJm4+Vx3tuSvubuHlfvCTITisdgbG1u7Ro10NiCyuw/TUH/EUyEPwErzKOvuDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=saSm42NB; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54c86f3fdfso3180419a12.1
        for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 15:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758407998; x=1759012798; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAc2vQm6dW3or/RAghR86rWbzlBx6oSeNHm9olhrKTA=;
        b=saSm42NBGhof2h28wv7Nf1Cu57RJVpdMkONInquS+vH1/zuCSbYm2w+c/B+n3gCjzZ
         kYHxL6fVVYdGv/BYCYljkJrYUOeme1MrjJx6rGgu3RcYTRNP4/UXFNEN7TcvJjCdG5cH
         n8/ut/W8w1Iqv3QWQpD0Ar27H1RK5vUo008skw76Em4ss/eh9L5/7Z4fds3DElhOnfpm
         x5F51k9V3TGrcoAVRpmP7Gn8ADefJpiS57TXRUfkv6uYSAl9OMAE/WCYhHzirjUaFqWX
         ISTP+/HJOJomx+5XkGGuvIlvUyMxk0MWrW+hpzKxEjdhbL+oa5rHsKxueK+7jgo1FSbq
         s6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758407998; x=1759012798;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAc2vQm6dW3or/RAghR86rWbzlBx6oSeNHm9olhrKTA=;
        b=IhOKBM2lMKT/LsNd5HS5JPK5SNQmoPOi01pmloTCIh0G4WXZCR8+JzRxHmPE2olgsb
         SItDs4PLbNUWoZYG406O/zEFYwq/n6f+0LpQOK2C30kJcBJqs+e9chHPBw5eLyubOT/r
         1RdjYST+VXFcYiCls/HDubrHj3QJLvx7JMKNjcXQUvdBFpjz9JxN+hiVAlj2sNYsWKa4
         Oz5feULCSqcg+tR13CL0S9O1PHx1JwmXQFWIj595jolU1IYQJp0UjmXg4jOX74nH/P/H
         fM79l+gZZMdtgnLh75yJSmV9LoKoNKh/KpSgT7FcL0bYrEPwQ/vUZY9Rc1NpbdLS2gBd
         hwpQ==
X-Gm-Message-State: AOJu0YwGb3SljXGyFrTOisf1UqrrJnK6NhiQephOfqqHs9MiEaXK9Ft7
	+fKzt1gUDlXBCy2nJ46zzrDryQU6ffXmQURve4X28kpoKaLDPwfSLMBjg/yk+iwIyxo7WxX3gQR
	GENJ4
X-Gm-Gg: ASbGnctCkvWyXxgDFA8uX7b9Exaz7QHJ8u0nE+Y5myeKFxJF3nuV+DiOPUee5FbBpUd
	JLas9/mGUV6C0R2IFWDtp8p+mlDP2tV1JyTCGkwVVyoCPecHWNlDg+H85duhHcm7DpSLoKQdPyM
	kaf+lYVY4LwUimRLBSdRlM/AjLXU4MZR0yb0BBB2xidRFfPT+1kzaD8PiVtGPBHT1bejkHdBLZp
	DTFcRjFR1cCehrFQlLwMI6LIdXAPtLzGg2WYiDgYX0Bz9Kn84mU9zihgu8jJcI7+i3FiBkyfPwQ
	ZeXMfbSerNv4evhjgSyJvcdkAMNLbGa+uD/dfZBg+RodnPfr6m6q2BYvNLY68nGc3AKCzkHf5iV
	3SdaWCHYvi6Bgspv1VgB7bs+WBV6qYguPswPdLNsbbdGYMxSmZzy1AuvYJs6Y2H/eQKB/Uvg=
X-Google-Smtp-Source: AGHT+IFPcE3H7kXRQyd/FbQ/78hulc2MwhlugGrmu+umk2re3+uv/HkrtCDaTp0tO5xO4BaMmn8teg==
X-Received: by 2002:a17:90b:2250:b0:32e:7ff6:6dbd with SMTP id 98e67ed59e1d1-33090a1034bmr11209193a91.0.1758407997591;
        Sat, 20 Sep 2025 15:39:57 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607b1fc1sm8983134a91.13.2025.09.20.15.39.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Sep 2025 15:39:56 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <881BF477-8E3C-4CAD-975A-6656D99BAC03@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_BFE3E423-4D2A-4900-90B7-6DEB6CA9924D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 3/4] mke2fs: add root_selinux option for root inode
 label
Date: Sat, 20 Sep 2025 16:39:53 -0600
In-Reply-To: <20250910-mke2fs-small-fixes-v2-3-55c9842494e0@linaro.org>
Cc: linux-ext4@vger.kernel.org
To: Ralph Siemsen <ralph.siemsen@linaro.org>
References: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
 <20250910-mke2fs-small-fixes-v2-3-55c9842494e0@linaro.org>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_BFE3E423-4D2A-4900-90B7-6DEB6CA9924D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 10, 2025, at 7:51 AM, Ralph Siemsen <ralph.siemsen@linaro.org> =
wrote:
>=20
> This option allows setting the SELinux security context (label) for =
the
> root directory. A common value would be system_u:object_r:root_t
> possibly with a level/range such as :s0 suffix (for MCS/MLS policy).
>=20
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Looks fine.  It took a bit to figure out what the ".nh" macro was doing
(I kept finding ".NH" =3D Numbered Header), but I found "no-hyphenate"
tha acually makes sense.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index 99ecc64b..ffe02eb0 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -428,6 +428,16 @@ Specify the root directory permissions in octal =
format. If no permissions
> are specified then the root directory permissions would be set in =
accordance with
> the default filesystem umask.
> .TP
> +.BI root_selinux=3D label
> +Specify the root directory SELinux security context as
> +.IR label ,
> +typically
> +.nh

> +.B system_u:object_r:root_t
> +with an optional level/range suffix such as
> +.B :s0
> +for MCS/MLS policy types.
> +.TP


Cheers, Andreas






--Apple-Mail=_BFE3E423-4D2A-4900-90B7-6DEB6CA9924D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmjPLToACgkQcqXauRfM
H+DOPg/9Ej/ANQ2lU7dXhyNisHx56efgYYcfYgF8WT8pYqyoESBQP1u9Q2KMpEQX
jvGJRfSr1EzOfT1CbwYhhYaP8nAS2HLkcE16leqaFIRsbgYXjyXhLSvEzg9bLniI
gkg0UNGMlzg9VVMi1pimziuswNTrFMuLhZIWUUwUWiyZPT8L1L74znpqYeMu6+PW
QygnJAxd6hlELlaKyQECcy+hd0IhdgGG0PCt5DeXsStt1yltHQ2bfMLJ2CXESANk
MENklfD13gciCnjEq4yrzPT0i5ALiobpVwDaFNFPgwO0RPvVnxKDXF2ZNSTPATyl
EOQVE8QDxnshgUY3+9RhMB7O2QTf+ZtsIlXOmK5LEFwCnborPr099kX4hQrhxoBv
gsdgB6PsC4+z3sMPQyfu5DOY5V2MpkzkPrRy6tRD3SOPZKVCy0JhojcAEpZ26oTP
c6Ef91GEEStJk4k86H0AgDXbdIq2arOaDbAtT/FMElnBL2/k1REN0rToACKfD+uA
NGxj2EaFrukOhaxL9p3qUtfeP+sPGxdjgeOuo/faNommAeAZh1pXHhw79JTh7Yrt
qprTUck/qsqEW9pFrXSMqtHp6cODottneJj7u/kvVInSZAJZBce8IgW8kFKFFLNJ
CZ41BoiC+PoHy/aJ5/nT5eJ7/2O3ASehpMXeketL9KAd26x/XiI=
=+dNU
-----END PGP SIGNATURE-----

--Apple-Mail=_BFE3E423-4D2A-4900-90B7-6DEB6CA9924D--

