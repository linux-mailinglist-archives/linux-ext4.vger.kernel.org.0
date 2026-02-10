Return-Path: <linux-ext4+bounces-13662-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP0tANVbi2mQUAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13662-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 17:24:53 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AF911D18E
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 17:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A9453035D77
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 16:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DCC389E0B;
	Tue, 10 Feb 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXoHp7nY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33773876B6
	for <linux-ext4@vger.kernel.org>; Tue, 10 Feb 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740676; cv=pass; b=XIHl1K6fQ68+oZ8Apuz6ydyeecRk4jZmNeIcrGLhMIjaX1PbdABm4NriYH5lJcw+hnCjgiSac3qep21eBoX8Pfvz2NHYLya03eU/PdaeUFRKSupiQKLupsfRaw9dunqeYr3k8Bx70NB97Qt8ujmdHHLtVi5EmnLUW98oJ6cEDxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740676; c=relaxed/simple;
	bh=BkWtyYpqejlmByRC727LdbfV/RYqAERDreFY/UP2Aa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdW0Zkh9Mmu9A5zL7j8RpdPnclpVJO+mI431ukNSYvJLOdBhAlNP5coLdPl4hVLoGhikn3e6YwKRM8TtoK1rinvAjhq4w2b9kNdmAXg2qLUDHe4g7aLQeJ0BtsG8cNXkoYWQm7tLNxgjXoUuRKIgiMwFhTG7ZnE6C3E5iw/s6ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXoHp7nY; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45f0c1f1b54so3483927b6e.1
        for <linux-ext4@vger.kernel.org>; Tue, 10 Feb 2026 08:24:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770740674; cv=none;
        d=google.com; s=arc-20240605;
        b=ki9aN8FPA8MqPLB6KQqVDE2Md+bW1q+Vat5KSyXiBOSsXD/zQfiMgnnh2nTKDhE7KE
         0g51KAFmup2P523Mb00BUVW8uAv+kC0zHv342DCReIZMqlKFtk6I8Wi1lF6fAaaH/x9b
         1CoLyc5bEvxonH3aeQP/erBP91mftNFiOo9YmvsiBI1+bkTurl0waTc6PQ/+h/aqiTPI
         Ad1rA8VWtV9EInEiwMPHq7ChFIvMJxm2Q8Wn6ZMCrd64BlDyL1KoKyFj1WYEH7sN54eB
         qZODPMaUQZKXYvg1QL5r0FAhUifZoO+TomNt2NVrDnmvlLqgvwdhMKWwFkGNpVHBxz98
         QCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e87k8iFish9q2Uq3v9Uy7Fjw166hMufB5O7qErb387U=;
        fh=RRtR5E60KhqXOPueCg4J3dqz1EARP+5nIwaJ1qhRH8g=;
        b=cSqyC+PB1LyW8T6ZXhLKO/Sp7kchuGTbL26zl1O+t88eyUnm+BdPv9wYndvY4dycoF
         Q7VxyPC0gt1EJX2Q4VfHoqrwk/5XnqSIdziEHN+AVH+2Td6TCH2EYbH52tms0Z42KcGd
         LNBE8WU6/phTjqyZAe769vwUaMPe92MWzhct9k2sPrD1U5THXA+9LlPtO6uU74/zEswM
         07B7iWW+aYPwPICASzo/nQBzM3aun/gqfxfalkAcrD+AsL5OtM4ZltAb5VOJC5wcF51Y
         8nHoN72M9ph3slKNrNZ9m9jPzqSH6c5aVA/kgEPOPTJtwCJPeIsyTxJ2qtSrfdByhmrh
         7i2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770740674; x=1771345474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e87k8iFish9q2Uq3v9Uy7Fjw166hMufB5O7qErb387U=;
        b=jXoHp7nY23Kq85huTPiHL1JsEK6nChfn2n6ItO9mJhQQLQMLKOQUwAVBSk5naFxJhY
         R/CAa71VMkrHO+oF8K/OeGmgfjlswwdenQw7JEPsknyqg9LfdHHw0qjAjeMFHb7LmAQ0
         sJGdIejhGm1kpLSexdcYBGDFglcXyj/uHKnuemJHLlww8nLSGLHYaDtZaLpyytNS4u7q
         5lZFsffLsIby593IrGgzTQKuGXwsc2GUrRsA2zUNcdHq2LR4zmXIHCTuBkFVCbD5V0Zm
         maODHoWpBu+PpgywObJIsMVDxwDufhdioUxtB/jrMD9+mMy1p548uzR+djRpr1ECBXDU
         x+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770740674; x=1771345474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e87k8iFish9q2Uq3v9Uy7Fjw166hMufB5O7qErb387U=;
        b=pVQ1NiqEiLDz0wcvRWc/4WmE1f/GxM7jqJYdViiGS6aNuWhyFoco/tGf+lMRaSJRmy
         AahjuuLh88B9NRTIIAKf5Si8q8R9BUjLq6aS35BiiJ6T3tO/VEC7qNK5MYEeVQyA8uIM
         4Y8n3OyrA9Gq3saHmofXXMq1kKRXNrdsJVrKIB1WpzVVGqzjauX5FWBOXg0/LPtWstJR
         gWMvLrGWQzAkcMAy30vaOmNkeF+QbtD7xkQO9SMeoZQPyhBoqza3k0pQ2YAhbJqOrZQI
         tdW8r4wBpjrM/4TDgBsrFYBttnREt+VGskIeYYJ7TNEugUrcBWDj9E+gbjY8OV1xJ1AZ
         msnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMNOE4lnuju7cZPsbaqypL5+JOq8Szn1Sxsarc2hCLuraf2oXq8eqwFyBJ/Ub6xnoHZBnee6ecbOBC@vger.kernel.org
X-Gm-Message-State: AOJu0YzBz4FVuDD4J1ocvorcIG0qZ2tbZAaL6RELlFOv0g+tMZqtApj2
	RHMAZVpZSsy/FNAUb316j/arJeGDRL/DE9/Rag3iL0z2XAhL/PPt/MkMPIfCdAmo8/1YFwqckRC
	QFBYpi0Xb0sxEFrdSMCxtwAyyiMe2Oyo=
X-Gm-Gg: AZuq6aLEknUGvzwMsGptzLWLcnAt4q2zYE0/AgE91AeWFAV8RGSOqjtH1qNhj+nBZBa
	Znxk1Eb7i94qsSzbAq+A1B41aj5vTp+uDrLDLfyaGKZeso6dNZ5ag/5LSg0oXWa23TvKuLwQtMp
	ktgCo372Wc1nQ4gW8cXqxLLLYEZ1Uv8yAoITKhV7Jl3LMIiVhaTcLvMQIGyyrKu+npnHq1BVOL+
	eEyziS7mtXXtoxEQq0a51HajraBdoZzZhduX3IiSponsBVHIlLj5V0VGBh46wtPn2Ef7eiEsYfi
	NDtFgQI=
X-Received: by 2002:a05:6808:4f23:b0:45f:42d6:2ffb with SMTP id
 5614622812f47-462fd051fdamr6992569b6e.41.1770740673692; Tue, 10 Feb 2026
 08:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120142439.1821554-1-cel@kernel.org> <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
 <41b1274b-0720-451d-80db-210697cdb6ac@app.fastmail.com> <20260124-gezollt-vorbild-4f65079ab1f1@brauner>
 <a1692040-58d0-412d-b0fc-c7b7a62585c4@app.fastmail.com>
In-Reply-To: <a1692040-58d0-412d-b0fc-c7b7a62585c4@app.fastmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 10 Feb 2026 17:23:57 +0100
X-Gm-Features: AZwV_Qjy3M0uZY-NRx3otdHnq6x-9RSVjw1ETeNOu6B1p4FZNE0JCUf2MFslsk8
Message-ID: <CALXu0UcJf+R3HuzwUrUTjsuYWdFrLZOwAsEtSyto2T9Rtg4rsw@mail.gmail.com>
Subject: Re: [PATCH v6 00/16] Exposing case folding behavior
To: linux-nfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13662-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63AF911D18E
X-Rspamd-Action: no action

On Sun, 25 Jan 2026 at 23:05, Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Sat, Jan 24, 2026, at 7:52 AM, Christian Brauner wrote:
> > On Fri, Jan 23, 2026 at 10:39:55AM -0500, Chuck Lever wrote:
> >>
> >>
> >> On Fri, Jan 23, 2026, at 7:12 AM, Christian Brauner wrote:
> >> >> Series based on v6.19-rc5.
> >> >
> >> > We're starting to cut it close even with the announced -rc8.
> >> > So my current preference would be to wait for the 7.1 merge window.
> >>
> >> Hi Christian -
> >>
> >> Do you have a preference about continuing to post this series
> >> during the merge window? I ask because netdev generally likes
> >> a quiet period during the merge window.
> >
> > It's usually most helpful if people resend after -rc1 is out because
> > then I can just pull it without having to worry about merge conflicts.
> > But fwiw, I have you series in vfs-7.1.casefolding already. Let me push
> > it out so you can see it.
>
> There will be at least one more revision of this series (and it can
> happen in a few weeks) to split 1/16 as Darrick requested, and
> address the nit that Jan noted.

Are you targeting LInux 7.0 or Linux 7.1?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

