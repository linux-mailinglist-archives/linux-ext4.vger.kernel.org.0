Return-Path: <linux-ext4+bounces-14023-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIIuLp6Kn2nYcgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14023-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 00:49:50 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 184F019F1A3
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 00:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11B49303A24F
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 23:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB13859C9;
	Wed, 25 Feb 2026 23:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="ioG3R2Pi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581A3859C2
	for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063384; cv=none; b=lfBnxpvUJNYQbQFwTsasc6nzEuJivqqOwuu9GpqP/L3dw4qtYWH3WQGTL3nMacJ+1qCacVt+S/JWCyzKrjFAJL+vDchMe2f0VtxDrK2X/E9AaCMmYyTwwfKa0BSzXsVELObtGbaxEfKfYsCrUllPB6PEu4WAFUxZ23GLJGXprFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063384; c=relaxed/simple;
	bh=oKDTdopXW/G8JMAvwyzy5khwffd/XKWnaux8IiRlSsQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fA5EYGQbNn9I+/w0XR9eY4PqLHne41Z/70+5nnBBTmNlO//L8My2L6C0m//V8rM56tH4xBFMb3oBJ5GdSqerVirVjFti6CkVG1B0qYSebqPxJHXR+eg068kNJs5rlfgARfjiWaaOcLx2IzCVhFUiCXrFOe0DSx5Ty4OW/v278ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=ioG3R2Pi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a871daa98fso1658775ad.1
        for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 15:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1772063382; x=1772668182; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TbEZcfygynnHMxOGcY4eUkxqu9lSXE/MwGuWXjsPM8=;
        b=ioG3R2Pi2U9IpasyKkAKt1vF4iI9QIKhWIlqaC/llSWgUtw/hcWdcQQK1bE+fRor7D
         qLqR9+VtLUV5Tcdr91zU30OlEWQqoW+lr96ifXIAGPIL9hLxjcM1pNGh4uHA/bJvoQtO
         JVzV+4gJRqiQiz6GhPEMt89ISNYApc7iLEOxf5v0gIswaN5EWPhTsM2a9ifSy69Xt2fp
         uR8PooHxwi3BMcoxw4WmM7kP4CpfAvZA4dXUf0Yph6Jca8MdONVseKkXGDbVcAdZ4Aqy
         +wyL2zsk1Nr9EBtQZf6fMTCfSJsZKuwNdc4NnO5q05Kwvmi3IGuCmN0CDDp0sDD8LICq
         rLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063382; x=1772668182;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TbEZcfygynnHMxOGcY4eUkxqu9lSXE/MwGuWXjsPM8=;
        b=NwuWpaXRyF/jhAGVotpC7UBX421Juu4pfwbeFEn25osrvYpZh3GfJgGtx9+gYT9Ia0
         C2THxu5qvBJZfXtjCzl84ntN0bVuAqnKTCdSoYUMElL7ZkU9Z9N5SoMCuZZJIx+sVgMT
         BUuyUY4mGKomu1xmC0rmCxUkRxRtzWXvydR2dro3mP4kOjHz/ryhgGOCIGI82OXzc610
         z+/zRhl5NMsKtMC6a0kHYjezJYkWiB5XCU4BH6kHPhL4ETTYYZNvrWh9HowZdmMnyP11
         zhQ4J2DF7/bzDPO+stVNNPRRpHKDny4ToM7vdt+ryhG25AqZyf+/ia7GsyO+73jtCSh5
         YMjw==
X-Forwarded-Encrypted: i=1; AJvYcCWdci0ESghczkiTdD3H/U0nY/aPnAqgOkkppaUdgwNFafVLVcsZMuwx305fZsyJJIbU4lKqr3EDzwtj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3/97z6PsNYNN+cUwbRGKJh7EPSFUsAbjom3eHq0k/H2/DsUv
	12K0Ci32Jps4WiMuSBCsjezRdbtDS1E3OCyxEtkE3mLQlZBVs1BD/UGfwp8zQDdcEvA=
X-Gm-Gg: ATEYQzwxXfAdtUTL1TXUX347yFoYr/3EtL4C0xojq+O1MKCeZUwMNx+MmEY0D61eRjt
	04i2GGTZ7/3/+FMmZ4Nsd/BRbCsch6lccCaeBi6kZBzpF3xqlKe/tzJXEWaHz7zpVTzubC5SS0w
	OWZnx0zmKsL7+fl6pPG2z07cVnM+jQbc0NEIv7gcZ33QFMJLjGWZ6uVsdcCu7JUVR6DS9YVMdkF
	LCWUZHaGVy7sdQUtsJhN7UxyQqTShH3cObPM4CAlGrlfWprGgKMtY+yEyY4EhGMsVXHVUXvQ+WC
	F3jofAzrEOCLFqL/ZzidCjVJS+2q15pjMNuSUety1JWSNg7snCjUAGHOUHLEy8w4/1qlYYIQAid
	+oa23yAvUv+Fop4Eg7w/aUwH3XiTgEXk6+xCL8X1FUSq46NMqwox1PTnhUfkzc39sFdX0b8169c
	K//R7WoMTHhTAeyA0Po/2EbB0GyEbRxOAnwHIrxyJuP96uVpcvj1aCe/hCUWsE8cgyUN6RqU8b2
	xoEjA==
X-Received: by 2002:a17:903:3d0d:b0:2a0:e5cd:80a1 with SMTP id d9443c01a7336-2ade9a51dd5mr19510415ad.41.1772063382050;
        Wed, 25 Feb 2026 15:49:42 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c1af1sm4980345ad.27.2026.02.25.15.49.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 15:49:41 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] ext4: rralloc - (former rotalloc) improved round-robin
 allocation policy
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260225201520.220071-1-mario_lohajner@rocketmail.com>
Date: Wed, 25 Feb 2026 16:49:30 -0700
Cc: tytso@mit.edu,
 libaokun1@huawei.com,
 adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 yangerkun@huawei.com,
 libaokun9@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D135BB30-388D-4B4F-9E09-211F6DA74FCA@dilger.ca>
References: <20260225201520.220071-1-mario_lohajner.ref@rocketmail.com>
 <20260225201520.220071-1-mario_lohajner@rocketmail.com>
To: Mario Lohajner <mario_lohajner@rocketmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14023-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[rocketmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dilger.ca:mid,dilger-ca.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 184F019F1A3
X-Rspamd-Action: no action

On Feb 25, 2026, at 13:15, Mario Lohajner =
<mario_lohajner@rocketmail.com> wrote:
>=20
> V2 patch incorporating feedback from previous discussion:
>=20
> - per-inode atomic cursors to enforce stream sequentiality
> - per-CPU starting points to reduce contention
> - allocator isolation maintained; regular allocator untouched
> - name changed to rralloc to avoid confusion with "rotational"
> - preliminary tests confirm expected performance

Mario, can you please include a summary of the performance test
results into the commit message so that the effectiveness of the
patch can be evaluated.  This should include test(s) run and
their arguments, along with table of before/after numbers.

Cheers, Andreas

> Files modified:
> - fs/ext4/ext4.h
> rralloc policy declared, per-CPU cursors & allocator vector
>=20
> - fs/ext4/ialloc.c
> initialize (zero) per-inode cursor
>=20
> - fs/ext4/mballoc.h
> expose allocator functions for vectoring in super.c
>=20
> - fs/ext4/super.c
> parse rralloc option, init per-CPU cursors and allocator vector
>=20
> - fs/ext4/mballoc.c
> add rotating allocator, vectored allocator
>=20
> Signed-off-by: Mario Lohajner <mario_lohajner@rocketmail.com>


