Return-Path: <linux-ext4+bounces-8191-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AD8AC2855
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 19:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DADD16A47E
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5100E2980B0;
	Fri, 23 May 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9eMlINF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F129710F;
	Fri, 23 May 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020450; cv=none; b=ZXcGsgxIavoL3vC8CBcOInnpOirUh84byXO9c4e5qju1Q8xEKCVDEKlzDSOgvq1TIF5PS/xO3qfW4KRnRSMscLvftce9sInUatEAOwMgPalKZCt/xMfBD4bom++eFjcZMmI+RuaoF6V+yB2rHGESrULrpuaMwmEiAGd8hvzqQRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020450; c=relaxed/simple;
	bh=AzgF5BgUJ7lQrMRuuYu4dNdTY7bbknsYrXVYOMg9kTY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JMOH0jf083B+yYKCodEhMhE4Ube32/uDV013dMNjrigDkOQdrnbvJ3r1MtFqCweMg9a3GZ7MmAfPQZjzgVGoLcRNsrk4lL2BPT6yi5uGmB3dZxgYfV3yb3v3dKIxS+DcqDFK9juRaIybvjCNM7hhaaeV8LmV1+Nu2lswTcnY76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9eMlINF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B76C4CEE9;
	Fri, 23 May 2025 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748020449;
	bh=AzgF5BgUJ7lQrMRuuYu4dNdTY7bbknsYrXVYOMg9kTY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=a9eMlINFytFCp4WBBx8lfP3cnrulZV3v9boZOzeTSO2YFDV/vigpSjyCNuTwe/J5c
	 u4hAx+g8zr8YTKqYyZeo0GlsiJAobHQ3H9KRB7K+xXZrZ2TADPfKo/r3z8I0Ganlv+
	 BFw9XSq3F/cj9wJCMOHXgfFwXjlCuLSDWg6YcmQNF9JPd1RK7scmTRC5uD0AoCWv26
	 KAOq3zUpgDtQYv+8wdXlZJ21evvR7ogUvi+h11lcAY7Z8o+3tAoRUF8HWysriC5fxf
	 kXTqTEk3uexCSnsilgcMWagr5Z7N6Hcptw4Wdsw48y3Fio4SpucVvhdp9gXnKFIV8O
	 gAkMhEIRQRvkQ==
Date: Fri, 23 May 2025 10:14:04 -0700
From: Kees Cook <kees@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>, David Laight <david.laight.linux@gmail.com>
CC: Ethan Carter Edwards <ethan@ethancedwards.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: replace strcpy() with '.' assignment
User-Agent: K-9 Mail for Android
In-Reply-To: <20250523142449.GB1414791@mit.edu>
References: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com> <202505190651.943F729@keescook> <20250519145930.GB38098@mit.edu> <20250523133100.1b023a6e@pumpkin> <20250523142449.GB1414791@mit.edu>
Message-ID: <85A9A687-D5E0-4EE4-8FFE-ED70C8CCE863@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 23, 2025 7:24:49 AM PDT, Theodore Ts'o <tytso@mit=2Eedu> wrote:
>On Fri, May 23, 2025 at 01:31:00PM +0100, David Laight wrote:
>>=20
>> The compiler (or headers files) can also allow strcpy() of constant
>> length strings into arrays (known size)=2E Erroring requests that are t=
oo long=2E
>> The strcpy() is then converted to a memcpy() which can then be optimise=
d
>> into writes of constants=2E
>>=20
>> So using strcpy() under those conditions 'isn't all bad' and can genera=
te
>> better (and less bug prone) code than trying to hand-optimise it=2E
>>=20
>> So even through strcpy() is usually a bad idea, there is not need to
>> remove the calls that the compiler can validate as safe=2E
>
>I assume that what the hardening folks want to do is to assert that
>strcpy is always evil(tm) so they can detect potential security bugs
>by doing "git grep strcpy"=2E

FWIW, what I'd like is a lack of ambiguity for both humans and compilers=
=2E "Get rid of strcpy" is the Big Hammer solution for strcpy=2E The more p=
recise version is "disallow strcpy of a src or dst where either lack a comp=
ile-time buffer size"=2E

-Kees


--=20
Kees Cook

