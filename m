Return-Path: <linux-ext4+bounces-14212-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBA0G+rAoWkVwQQAu9opvQ
	(envelope-from <linux-ext4+bounces-14212-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 17:06:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB2A1BA846
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 17:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB28630117F5
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC3244B671;
	Fri, 27 Feb 2026 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LfmMR7yW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046F4418E4
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208356; cv=pass; b=Ij9w33pajsWx2WjqPe9od8WEgG48nkiz9e759CbVlScOgPFIputIAUbtvzrOYMOC0LUHsyrTiXTVR0wRKbTv4/7c7xEoNYJ5fynQfwo50pPAtQUGFznq6crzBaWUme0H92Njn4MnQSjQgVb0ShTqiaso7hcV5S+5GlogGMHm/3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208356; c=relaxed/simple;
	bh=XWRFmApZo3EeyDOBlJmpjRgegzMqTxAsMi4wp2Eo1BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvFF6/v4uNiUhGLa2CuJ9BRFaCA7qfxE9+s6c+vII+n5RsX1/8ccsWdv96bZswDC4vrWOK1rXVNDBVOFz4mZ6JsEqQ/jVIK2Vt3EVabE/YjrjsybUsSnKsX+A8BF2YR7HBO6ei9pw6L9JqKQsRP5kg3y3vpJ/AUYZoRhFARZH9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LfmMR7yW; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5033387c80aso42306981cf.0
        for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 08:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772208354; cv=none;
        d=google.com; s=arc-20240605;
        b=DrFROvq9mkl47K9ds19in7OG2afO55AXZ9WJ1AN+pgKCks/fRM319m05sTLMzLEZkj
         MNvVatAe7Ihm0QDSJFqSDn4+4uVwUjVwEYvkLzR9HIRnNhEl8CsHmwBJrt8GEd6AtyWv
         YxY+AddqTiMoPnNU69Mj2ikBi+MAJiXc+6FjY4Hq+tKBoZft4KJ1+qhlG+EGkSoUf0Ok
         AMjX0q04Zz4TeArOP0RoZRONYpb3ucS5MKr2REFRLxY8YFwusAVXjHr2+L4OcjTQjrhC
         T5Kjt7kHxAMYcgmY9M6WF3zXapl/2pkecmlWVF1+lRb7LO5wG/TC4jBU6U2iidaIrUJb
         EHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        fh=IVWo42n+6dxnNhjb5u/q/KB92ie+I+/fgdAhn1VoE/M=;
        b=U0J8AF2iqsUXq7+S6/OKCEy/eUC/cVnYI9/lu3bHzs5rejtxgeN7teKB0D2HiXOT8b
         ZcN7o+BBduXKUfsvsXxwYE3gO3uWtPt3GndG1gmJQjwoxSVDQgtycwECixdvCF2c3trA
         cLxL9ZawGY/O6OmW5zU6WI75tMpz5C6i3GgyoT03SSd1mX/zx/i+f6WZM8EXhIOLpN4i
         40mW+W+NksuusKSFkuhTFMCaH3MNGGmN2Spo/TlOZSbJvaGOl/mUUvUley6yIQ5klW4e
         2YrwQhgSOS/Q3cNxKZiiSNx3WMOEpFnwa0zZF/L5YPUewmr6hvq5FLNzAqYo2ZxUJF1Y
         C7vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772208354; x=1772813154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        b=LfmMR7yWSQDmoRuq8VMySSMb8MeEheV9tG0G8OqPmk/6sqF0avT6fPmX07OP7d6QPp
         R8LeZJN6zJ+aybdL6KzvIV4eRn/fXKAorfRYAC9Hg46GD7soHmbbqrWu9iCrPrF64Jjf
         /83il98BCG8P0YvthzYNAGxMDWz2f7wI/2dgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208354; x=1772813154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        b=RsaMSCvhZk/XLzYGGid7WsaSgZbEpLRG3eX2IRN6xHBsn7aermgHPE0zCXIniWDoet
         uO4xmOevdJEDwlGpGpyWnmZWvTffXjyHQs3Kw/BWSaIGaUTmiyfx5Nco7O2ggSPdnKry
         xXrCphQfys9FWB6Vq02BKw1mxdZUkc+01DOQg76myoKGE1HwXL6MOJ7plEVkofyaaW5I
         VAURyN3LNjRqdro0JCspEo/aV6LDFVPi6iSejfOU8gs9UOcgQwG+PmCmv63aoDE9JBq6
         gtppQJxSrOZxpu1Oz92xg4o53BKDrtdUdkopBRLIzyr5kNK2rV/mgsjhK0W7pinGqsOy
         +rIg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ27qO45Q9nrX25FokeGT8OjFbn3dwK3U2MeUuocbt4msVlnA+EUt2CM8JPwJTwNFpqxTQSUhKepUC@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9Bhr41itEykZLAfSoGNNOjHKR2aaqgTEYSQI0ru6hGJnbtJg
	19X0giW/HKNVnzUG58yWFJ2QqKrNK+9SkchbvT/PCpp65lis6MZLil2HJxFgbJCuLPUGZldTE4o
	sih62QGTv3isRiP/YJtf2bfrgN3hCr7RgM34CGC0B+w==
X-Gm-Gg: ATEYQzzh0vNF3FHqpKQ24SC2ML6QMOOrbTV2jmiRj0lcyK5eKNyRj5g2CyJKgE11cpK
	gyjVULTRZeZtW6GZtIIRgxU5TdrWZrb3skjo4hTe1ZrBs8Cc/v2wy9b06vw++PqzXHbZ9fjqjkf
	L5zMT3nwN5o0snEFTZWrX5tjt26MdN/FUx35Dm3ofgrKV0MC6ZyH76QM25H07Tan2iSn2DIwY3+
	X9sIj64BIpTlpxpuvN0FrH/fjy5qALiUdAyLyaGIv7maBjeNWIaCPkibo4Vpmr8OzMNISiVZ4KX
	6forfQ==
X-Received: by 2002:a05:622a:15c6:b0:506:a574:a98 with SMTP id
 d75a77b69052e-5075240cb43mr43969551cf.25.1772208352680; Fri, 27 Feb 2026
 08:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 17:05:41 +0100
X-Gm-Features: AaiRm522nNR8quw6-QPApM41f6VxVhfe4lhaNvG1qaOhqP6WFi_K60TlVjnXPqk
Message-ID: <CAJfpegubENC3LxtG8MbO4OxUgD_Pd1GR9pw6Xcob_JiG+2cOFg@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: quiet down complaints in fuse_conn_limit_write
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: stable@vger.kernel.org, joannelkoong@gmail.com, bpf@vger.kernel.org, 
	bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-14212-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 0CB2A1BA846
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 at 00:06, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> gcc 15 complains about an uninitialized variable val that is passed by
> reference into fuse_conn_limit_write:
>
>  control.c: In function =E2=80=98fuse_conn_congestion_threshold_write=E2=
=80=99:
>  include/asm-generic/rwonce.h:55:37: warning: =E2=80=98val=E2=80=99 may b=
e used uninitialized [-Wmaybe-uninitialized]
>     55 |         *(volatile typeof(x) *)&(x) =3D (val);                  =
          \
>        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>  include/asm-generic/rwonce.h:61:9: note: in expansion of macro =E2=80=98=
__WRITE_ONCE=E2=80=99
>     61 |         __WRITE_ONCE(x, val);                                   =
        \
>        |         ^~~~~~~~~~~~
>  control.c:178:9: note: in expansion of macro =E2=80=98WRITE_ONCE=E2=80=
=99
>    178 |         WRITE_ONCE(fc->congestion_threshold, val);
>        |         ^~~~~~~~~~
>  control.c:166:18: note: =E2=80=98val=E2=80=99 was declared here
>    166 |         unsigned val;
>        |                  ^~~
>
> Unfortunately there's enough macro spew involved in kstrtoul_from_user
> that I think gcc gives up on its analysis and sprays the above warning.
> AFAICT it's not actually a bug, but we could just zero-initialize the
> variable to enable using -Wmaybe-uninitialized to find real problems.
>
> Previously we would use some weird uninitialized_var annotation to quiet
> down the warnings, so clearly this code has been like this for quite
> some time.
>
> Cc: <stable@vger.kernel.org> # v5.9
> Fixes: 3f649ab728cda8 ("treewide: Remove uninitialized_var() usage")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Applied, thanks.

Miklos

