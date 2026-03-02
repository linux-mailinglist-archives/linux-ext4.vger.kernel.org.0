Return-Path: <linux-ext4+bounces-14335-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMzNEnXopWlLHwAAu9opvQ
	(envelope-from <linux-ext4+bounces-14335-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 20:43:49 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6AE1DEEB2
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 20:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00CAC3037F01
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 19:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF5047DD69;
	Mon,  2 Mar 2026 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="mDmPsOJV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044E47DD6E
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480612; cv=none; b=au3Cm37fNDtD5xBFJ4NPJCkM7WuX4ESr2//JpaaKYsqncWAW9rLx7Iule25bOdTpYlbRmx/99MV82tDCBUgRkKdA2rATMR5pTXIB5KMiP8+TCRPfnNbRei+JbAJfIJ/VfRVleNeOhThP2HRFeEXK91IEYfKwjeQ5ndA9WchFdEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480612; c=relaxed/simple;
	bh=8lJx5NBB0VtnAYy0nI1F9Sj8cT6itdzZV+8/NzG6K/s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iFs402WC9Is1KG2v+QVCrp68cBvkXo54wHFaLm9p8xvFuMonlrtGgkDYHJFt5dkGgEVU029uRpQqdMUcd+ElnM5zjz0rf9jngKBbHKbyrl9zA+yIFvXVDX0ORaG1GhAup77YulryOoffbpQGyGt1O3/9ebrD6zDaxGyyZ4uTBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=mDmPsOJV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a8fba3f769so22613895ad.2
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 11:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1772480608; x=1773085408; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRhwhivd/YnYyBfDs59U5DDbjc6jpKsipX86BtgVaVI=;
        b=mDmPsOJViGHU7xTlmB/RVi64RNoXL5Kx7GaaqlrlWiJvEpEDlBDQrNQnzgP0U0aS1P
         +z+3KOBeIXq5H68JMAkGgP7od+ncQWZhP0XEbEPUDQgf6EMiPORtZ92HXODdbAvTWxe5
         J+gAKEXPE7Oaiho6NMeC6xH7mtqhprZQzaN7hsCnoZorzAXyZ5Uxik9srbDxpNYAYdlp
         g9hMwJO7vCcCzdaNkLMok0+/pwA/flgNBRTQdVsGxFyeMfttfkVzqLnY5Me7Ng5ux3Sv
         FQh+pDfkaF9ujZPL6BRDKnyH4TMSeDhBfMnNGZn11B0A/7civ/nuYapxSxhI9RIf1Jjc
         UNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772480608; x=1773085408;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRhwhivd/YnYyBfDs59U5DDbjc6jpKsipX86BtgVaVI=;
        b=SZgt8YTJTkAYXz+rjD+eak+6EAQcum2bTNuLkCdQUwMLRy4Oq/TwIsTIlJuVyFcApm
         LY9LdA/oO9ULb/2W5RP7DqHeTZbirr1/T4btegqlFzQOzfYLThphi/QakopB9atDVNYi
         VCfgDp/TJEHNyVKbLfuuUKgrXeo0KbiS9kgM6BRygL0wp0S31FsCO5dbyXxjzYEksiSC
         5aJOeP4wqimNxx7iSxQSK9s2g5sO+IDNmgzpEkUvEUybgY2cNkyIdaXL9vyf4jHDnI0d
         H6cwhKQm/CHmRwLu0PrZ3KsfdVKX5zCnoet99bgov2AEZCHzOyp00cMhWY8EuKB3OLZq
         m2vA==
X-Gm-Message-State: AOJu0YxnH7RXPlFoRzisbEZ7D3D8psqGiJIBMqK6qpVY1luEsnp90UWy
	p5APxNTWQ6UfPnq1Z6W1YFIZfbRGPmzbCyERSAQWm7rH6zsL/s37r36kRzQ04i6IDqU=
X-Gm-Gg: ATEYQzxUnpeHe83mLPh9a407gJDFUSXf5Fyfsfu9jeybyL62Xx45SZd0F9MqyTgMQST
	1mRxE5LThoLhg3nO6OY4ECbLo/erO5HSrmNvgqgkjgMZfp6LJjauum9qncx6ZGdj+ARvi4A8VEP
	mrludw/+OIrzb5cpB82XcBlM0K5oltljx4b70wxCurAvwy4vYjC9EHzHLqiB6vO+270q2dcacBw
	RXtVTCJ0+3NiOv/htlfIS1Lt8qD98+uBhSvQzYOGWsn41CuExejzvN1BikW1nPCypLdezFAaOpT
	NeohGZ0Yx+iy35dpOn2QTWwEStKSMJrO4VPGioF64tlGozld6H59LMrzDe7yc8LRARjz8qg1ALH
	kq4GpOJVUWFXzhMuJzs4dqnBSIyPSsVau+R4mhS/WcugJMX87ekG0BGR6tLXGSegTrh00BU+BFX
	l3ibqfz3l/XKpiu2hwC8ug7M5c3uGE39CY35GPJeUUqNCNbTrfMka8DPaWMdnOn0oUNiAlag3rW
	jjyQQ==
X-Received: by 2002:a17:903:4405:b0:2ae:3b9b:db34 with SMTP id d9443c01a7336-2ae3b9bdcebmr94693435ad.42.1772480608193;
        Mon, 02 Mar 2026 11:43:28 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b53f4sm143125915ad.18.2026.03.02.11.43.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 11:43:27 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v2] ext4: Minor fix for ext4_split_extent_zeroout()
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260302143811.605174-1-ojaswin@linux.ibm.com>
Date: Mon, 2 Mar 2026 12:43:16 -0700
Cc: linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8FD2F152-AB17-4F07-87BD-953937A0B466@dilger.ca>
References: <20260302143811.605174-1-ojaswin@linux.ibm.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Queue-Id: 8C6AE1DEEB2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14335-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,linaro.org,gmail.com];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dilger-ca.20230601.gappssmtp.com:dkim,dilger.ca:mid,dilger.ca:email]
X-Rspamd-Action: no action

On Mar 2, 2026, at 07:38, Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:
>=20
> We missed storing the error which triggerd smatch warning:
>=20
> fs/ext4/extents.c:3369 ext4_split_extent_zeroout()
> warn: duplicate zero check 'err' (previous on line 3363)
>=20
> fs/ext4/extents.c
>    3361
>    3362         err =3D ext4_ext_get_access(handle, inode, path + =
depth);
>    3363         if (err)
>    3364                 return err;
>    3365
>    3366         ext4_ext_mark_initialized(ex);
>    3367
>    3368         ext4_ext_dirty(handle, inode, path + depth);
> --> 3369         if (err)
>    3370                 return err;
>    3371
>    3372         return 0;
>    3373 }
>=20
> Fix it by correctly storing the err value from ext4_ext_dirty().
>=20
> Link: https://lore.kernel.org/all/aYXvVgPnKltX79KE@stanley.mountain/
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: a985e07c26455 ("ext4: refactor zeroout path and handle all =
cases")
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca =
<mailto:adilger@dilger.ca>>

> ---
> fs/ext4/extents.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3630b27e4fd7..5579e0e68c0f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3365,7 +3365,7 @@ static int ext4_split_extent_zeroout(handle_t =
*handle, struct inode *inode,
>=20
> ext4_ext_mark_initialized(ex);
>=20
> - ext4_ext_dirty(handle, inode, path + depth);
> + err =3D ext4_ext_dirty(handle, inode, path + depth);
> if (err)
> return err;
>=20
> --=20
> 2.52.0
>=20
>=20


