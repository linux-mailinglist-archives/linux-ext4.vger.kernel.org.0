Return-Path: <linux-ext4+bounces-14293-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJU8OlrJpGmMrQUAu9opvQ
	(envelope-from <linux-ext4+bounces-14293-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 00:18:50 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7231D1ED8
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 00:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E2A83004D95
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 23:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F33B239E88;
	Sun,  1 Mar 2026 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="CIT9/zFL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674227442
	for <linux-ext4@vger.kernel.org>; Sun,  1 Mar 2026 23:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772407123; cv=none; b=oIM/Xf0CE/60FG0+8Gkkzm3X4YOFJiRoCsMd5nqhgdKBnDo+TcTXicpP17zlXr9LLEG/cHH99IyemVw1dehHL5yWGqEcy48KaGvhAmhOQXarWSlkJ30YIlt6Urw9cuZ8d5SzkPcgYGaIFKFUvsnlWC9Qd29vLEJ+n0AcN3iiYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772407123; c=relaxed/simple;
	bh=qsW/b4NcIZ2IdLaUvA5gDxHEvwnzRCf/hJAp3man0W4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=QT74/degvCrdj64QagDlATltcZMVVRuOsfkByHBNTs8bk1/r9aZVWZpO6rx8r9DvU9BfK5JIPtmn4m7hu+ktcLO9ieIggYAD5Jgx2EAB/KrrN/iwo8bMTuB309kHJse0XErpZqMyLS2lErzSwGsrEgfAJaXRNvyLPGtxurpS+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=CIT9/zFL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso1674815ad.3
        for <linux-ext4@vger.kernel.org>; Sun, 01 Mar 2026 15:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1772407121; x=1773011921; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsW/b4NcIZ2IdLaUvA5gDxHEvwnzRCf/hJAp3man0W4=;
        b=CIT9/zFLD1lwHQnFBqJuqEiK8nf1kboS98V1zXP0mDF/Y6nZI+5pxbfVtSCkl0Ca65
         ryYihyu64DX7RkBUzjqL9g9oY1RwrGh4fZP4g0JYoyvfzsVt0V4kGcYyMKrMB/gmIPOq
         9xwREs1WLMnQwL5U4mRhpTd6UYGHHo/LaRY2uRWVhwgNufmwhs9IDl+q4U7rgG8X764w
         C6kSn3K7OOnwWsCroSWXzryGd42VO2GPxKfzBdCjM23wqGatI8EUqEZl7XReqkE+bNBX
         q7FCY7oiS0u3V2D7kpIg69huQXlyMi3/sXxUIueyOaJ8muNHvxaqhiH1SnWkQnva3L+E
         ZD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772407121; x=1773011921;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qsW/b4NcIZ2IdLaUvA5gDxHEvwnzRCf/hJAp3man0W4=;
        b=bAgUUKm56qNc+WTAZUiDYSPJ7JTqm6lizki6NV+r48XcMo1Sz5aTISi29JjoNxIM3n
         Z6iNR69hxQu/NhWo/etXonutgV4tgkui8wlpX1zAhBBocbH3RDcYYvuwR10JiU4pm56M
         7rZz2TC4/XkNsXY81sZJVL6gxYTmYPAYTaW3FbFNQUvkBTJ9ttDDump0SudGSMuOH4s6
         IHMYOZ32JH+QnTPYsonwua8HR4P7sY1wybyTZbxMsFXZBZ9QRuPTF/wIdx+1/gdx7UsS
         PfY1z44LxApNwLrGbdAsJHIiIlEh9o6T3dvbHB8aIAvbRqVurmKInAaMyANEEL2htJ0K
         kI1w==
X-Forwarded-Encrypted: i=1; AJvYcCXyZpDTb97N05X4z3i/bX6pn2I9DptFaRRdPhzTvudpNawaFRc6OAcDdorfo4PPidPLqkZQSs4XNisj@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpuNiTp+ByMnbsFSBEPb3NSFS8HwmJuK5r52EOgKYjZdTNi/5
	txV+yQLaQXN9CA04zpfe5hsw3nCKlyJuOSpTeFd9M+1ARoGqSHV5oQxOgBKXl29rteY=
X-Gm-Gg: ATEYQzz8Hb/eZtpcyVxKnDKx78jNKSDOVRdmSmmqZm0zdzzP+edS/XdCt1IIwHR+XfH
	K8a3hu+BlwB8Y6ONiH9fIL24oydJ7get7kHm63U74CY2GslWduSeSCTLq1fxMCxEtYQX2QBsuBc
	PRo5R4m2ZWpOsnhSeV71LnwG4bAljbCvkGFwEcYxZUpVpEyNJmm/EnbGcwlfRJ5Y/l+fHiCZ5N0
	v1pT2C0+tKrl4UuFJOFyA4RHG9iPPj48EMUD5zBtWUSLhGy5ahXeEvLwVlg6I3SsHA2i4lImed9
	4VvM3VsJIn/mBTCrSn2lPC1xQ41QDNNemhRgHCcluOULryFrhJWx8XfG0x80qaDKbQ/f0WCZWMn
	Y6XgcuLZn2Zzn3arQzmSBTdpn+445ynXKgRdeFvAdOPMMxZn8Ba0scm7mSuoNM7LNRheFtjWIGP
	U2fgSPjvB3YyRPaxMtEqlSBM4iEiBsnN68txVfC/C15CIBkMqqHJD5qM5Gr5dRaQgyZjQggiiIA
	dUMKQ==
X-Received: by 2002:a17:903:32cb:b0:2ad:e99a:8169 with SMTP id d9443c01a7336-2ae2e3d12a1mr96958065ad.33.1772407120893;
        Sun, 01 Mar 2026 15:18:40 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4b782c53sm23509195ad.41.2026.03.01.15.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 15:18:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andreas Dilger <adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] ext4: simplify mballoc preallocation size rounding for small files
Date: Sun, 1 Mar 2026 16:18:29 -0700
Message-Id: <DA3BC35A-78D8-4D47-925E-820E94ADC912@dilger.ca>
References: <tencent_7F28D03F5012FE947083C5B3B2D613D93007@qq.com>
Cc: cuiweixie@gmail.com, dilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, 523516579@qq.com
In-Reply-To: <tencent_7F28D03F5012FE947083C5B3B2D613D93007@qq.com>
To: Weixie Cui <523516579@qq.com>
X-Mailer: iPhone Mail (23D127)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14293-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	FREEMAIL_CC(0.00)[gmail.com,dilger.ca,vger.kernel.org,qq.com];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	APPLE_IOS_MAILER_COMMON(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dilger.ca:mid]
X-Rspamd-Queue-Id: AE7231D1ED8
X-Rspamd-Action: no action

On Feb 28, 2026, at 18:38, Weixie Cui <523516579@qq.com> wrote:
>=20
> =EF=BB=BF@adilger I think you do not review this new patch because it's se=
nd from my other email. =20
> my previously patch is send from cuiweixie@gmail.com. But 523516579@qq.com=
 is my other email.
> So can you help to review it?

It isn't necessary to re-review each version of a patch if there are not sig=
nificant changes between versions.=20

Cheers, Andreas=

