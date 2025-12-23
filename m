Return-Path: <linux-ext4+bounces-12495-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B3CD8468
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Dec 2025 07:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F5CD30019F1
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Dec 2025 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8752A3009C7;
	Tue, 23 Dec 2025 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OA/F4PYc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7F168BD
	for <linux-ext4@vger.kernel.org>; Tue, 23 Dec 2025 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766472134; cv=none; b=dqqAipSdgVz2SeflauJk+c5vrB2flWggUGJlTR4jQWil+3MeWT1r0o+gz9nbvInfs3z40qYppUTlGjsw7dVnAhlIWCDHiBr9MfQG4zYs1BKY/9/nrpI8sAQ4TRKM68lXO8gNSmzjze5lxSgKYmFz3H8DpUGY/9nFuGC6f9K+Ebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766472134; c=relaxed/simple;
	bh=cUlzRAfYZQYNeJ8h5BNuI6yuJROtc/1co3oPGjI65II=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MqyZgcwpdmrJEeuoNwtaHT0qkC/9Kod0jH4Y/bhunQOQHTHDAlRyeM07k0GJ6D/f4S0N3IoaeJTtxEm/te9Iyymn7kXmKEqSAopGjfCKKrS7D8J2mdvXP41MNUZLbOPyR2i6Kt3R2xdOKzEFXYeAD/ar40tY6i3DYdoHBdqtwH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OA/F4PYc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477aa218f20so28706955e9.0
        for <linux-ext4@vger.kernel.org>; Mon, 22 Dec 2025 22:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766472129; x=1767076929; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Zd/JJtKzVXpshTVbxkS/5umCfND3C0j7tos4M+FZ2c=;
        b=OA/F4PYcvcF168jKP1wfUWl/ZuG+g/uzzIRQvb8e9r/CZEdPOOUy47aFcK8mrtGgBE
         p6bb5mbetxma5NMjkF/i/lmmxw/Kb3cbzB+xa62CH6ejo7HlusFUcVgex5FpgN+/dzkc
         ZQiTAPSwuOx0yjGOGRtaW26/9waUrmzvu1OsQ2H85kTestC34QslIYvpYT3/YUk2Ptuq
         v2LPdOJ1YLfa4gdKyNzDIB6jhHppXhrh9l36REFvaN99dRuUBDwhZ8bsxyyVGQY7sBZx
         wYMxIZLr79K87rocR4UbRA+4yVRkLM0Z4LDE2mqTwGbOe4e77qWUE77pJW6ArSbWql4a
         130g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766472129; x=1767076929;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Zd/JJtKzVXpshTVbxkS/5umCfND3C0j7tos4M+FZ2c=;
        b=B73e0FzYMVEK8mFoZoYx7fhPzF5PJGCAdmVs4+H+CX5q4biO3GtYaJnNKc9cpjB0bs
         ThsQTKdknBgeaTzISrde3XfGvhLSERrAH+vgqlb414B2dqym/KavSbGkcn8umCYMdoaO
         RY8liXDvPpVOuz5VsIj2quXrlLnoUxVPd1MYjIWAnOkclIAXL9lVAFDhbn2NrGYlKeKK
         GLKWlAFsI19oxb9E3FvZsUa1ic+o5cVaxI+g5iOrxNrYjuUedRI8xxUcpvbhs9QUr4v2
         0zcfQiYGTgNcA2sKx7C9md4M0Luif9bO5NYtt8TjC+q7Huzje22lXCjwgsrZc/KcG4Ip
         FCTw==
X-Forwarded-Encrypted: i=1; AJvYcCUwJZ1EbZ0dA5cvwFx0dhPdK3h6cR2ojciQ9wLE577dQbUBJYjGAU16bTXeAjmIc3wUEuGqozPv2Zm5@vger.kernel.org
X-Gm-Message-State: AOJu0YyqTVwRbX65kqSUmlsZCJJZZFmDhIjl4hmF4IFsdA3FXKEq0baN
	vOwQBvifWm8XHrZHiZjgFXxhcv9dz0ueqwJbKlCDNKI3bDiR5SSfKXDlG3HtXXq7vgQ=
X-Gm-Gg: AY/fxX4Htys+CMMGLd/ksnaQxxzF4YZfOLo1iaazRvu1SZiJXc8mlPCLGLeNbgXOEHl
	0kBZgBp3LX1esOFN9sBgrem5psqQyaCc7k9aYKiME8b8czubjY7soW6d+U+HlqW9cTMtgdpQar5
	iVpl97Ho0WJ86UIBiO912epBVb+kGP2FSclWs/cD67WQc6ps4GqEijYfCsQ14G5IZvBIKluf50+
	4jUcwRLNqY/MMrnHHkvKYpwIpyZ/cv4IXs3ChtSkTgvJlrueRbL1cIeSXwDKAwxzWuz+fx/FK5K
	QcrDzuFpzPzKzYegEDEdy0sWNesWmF8IykJugKXMTLzOkWWemTBP06dWmzPvQ+4CptB++PXPKGZ
	yosHp+Sor0UwzPCtOrBMaIuNKyOFSY7nj/muWqhaRZpIuMSQzFrLIHNENNpRBwzoprdpCoozLWu
	Q1naYn+/1nEJPFgPM3r1Oi6h1GrI98kg==
X-Google-Smtp-Source: AGHT+IE8Lzr6MfrGfuT7x/GB5nqvffTSYB6WHrsc0b/3ee8aiymvejBghqiiNUean6S2BBYSk97aJQ==
X-Received: by 2002:a05:600c:154e:b0:477:76cb:4812 with SMTP id 5b1f17b1804b1-47d194bbcf0mr130567335e9.0.1766472129241;
        Mon, 22 Dec 2025 22:42:09 -0800 (PST)
Received: from smtpclient.apple ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm39997801c88.10.2025.12.22.22.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 22:42:08 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH v2] generic: use _qmount_option and _qmount
From: Glass Su <glass.su@suse.com>
In-Reply-To: <20251208065829.35613-1-glass.su@suse.com>
Date: Tue, 23 Dec 2025 14:41:50 +0800
Cc: Su Yue <l@damenly.org>,
 linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org,
 djwong@kernel.org,
 zlang@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1D7CB58-C22E-436C-B8C9-26A3F83CA018@suse.com>
References: <20251208065829.35613-1-glass.su@suse.com>
To: fstests@vger.kernel.org
X-Mailer: Apple Mail (2.3864.200.81.1.6)



> On Dec 8, 2025, at 14:58, Su Yue <glass.su@suse.com> wrote:
>=20
> This commit touches generic tests call `_scratch_mount -o usrquota`
> then chmod 777, quotacheck and quotaon. They can be simpilfied
> to _qmount_option and _qmount. _qmount already calls quotacheck,
> quota and chmod ugo+rwx. The conversions can save a few lines.
>=20
> Signed-off-by: Su Yue <glass.su@suse.com>

Gentle ping.

=E2=80=94=20
Su
> ---
> Changelog:
> v2:
>  Only convert the tests calling chmod 777.
> ---
> tests/generic/231 | 6 ++----
> tests/generic/232 | 6 ++----
> tests/generic/233 | 6 ++----
> tests/generic/270 | 6 ++----
> 4 files changed, 8 insertions(+), 16 deletions(-)
>=20
> diff --git a/tests/generic/231 b/tests/generic/231
> index ce7e62ea1886..02910523d0b5 100755
> --- a/tests/generic/231
> +++ b/tests/generic/231
> @@ -47,10 +47,8 @@ _require_quota
> _require_user
>=20
> _scratch_mkfs >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>=20
> if ! _fsx 1; then
> _scratch_unmount 2>/dev/null
> diff --git a/tests/generic/232 b/tests/generic/232
> index c903a5619045..21375809d299 100755
> --- a/tests/generic/232
> +++ b/tests/generic/232
> @@ -44,10 +44,8 @@ _require_scratch
> _require_quota
>=20
> _scratch_mkfs > $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>=20
> _fsstress
> _check_quota_usage
> diff --git a/tests/generic/233 b/tests/generic/233
> index 3fc1b63abb24..4606f3bde2ab 100755
> --- a/tests/generic/233
> +++ b/tests/generic/233
> @@ -59,10 +59,8 @@ _require_quota
> _require_user
>=20
> _scratch_mkfs > $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
> setquota -u $qa_user 32000 32000 1000 1000 $SCRATCH_MNT 2>/dev/null
>=20
> _fsstress
> diff --git a/tests/generic/270 b/tests/generic/270
> index c3d5127a0b51..9ac829a7379f 100755
> --- a/tests/generic/270
> +++ b/tests/generic/270
> @@ -62,10 +62,8 @@ _require_command "$SETCAP_PROG" setcap
> _require_attrs security
>=20
> _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>=20
> if ! _workout; then
> _scratch_unmount 2>/dev/null
> --=20
> 2.50.1 (Apple Git-155)
>=20


