Return-Path: <linux-ext4+bounces-6164-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCA6A17A64
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 10:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B783A3FC0
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FED1C1735;
	Tue, 21 Jan 2025 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z50hP9bS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8A1BB6BC
	for <linux-ext4@vger.kernel.org>; Tue, 21 Jan 2025 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452547; cv=none; b=Nf8b1RVfrUI7xsyoU1zLygq2yAXkV8xb28aaN41JjLTHO7J258hFZPeTXyocxZbYKlLPyjXJEqeLFl/qNEdyRloEfuqHTNE1+XL78c8nDp2iRJqfCT90SmZwKFWUVTFWI8O1QIirTSOyTN4UK5P47rwxZhT0kvzFBORfrM8L/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452547; c=relaxed/simple;
	bh=+hogXr4voc0KQQO5N+fyx27f2KRwEQPOaUwqHJJck3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ejkiqf7GY0cqsWBckfZPcgHc3wAHlOl8CQoIozuybRtFAGxShn92GGcqnT/3IOiOhIFLXEzA6+Srv6hJIGbnh8OcWylB7954RoJC4jZJHYtYsQT2gsvmW8BW3QJvpVfS0fsQGbM+ZwNQ5JTbT6UMAby2yz5Ki/5BIm+bjLJwLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z50hP9bS; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e3cbd0583so1345890a34.1
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jan 2025 01:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737452545; x=1738057345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pLNPN3ni6Zdmsk2aheSAletIg6IwRY2toiothpvNsY=;
        b=Z50hP9bSGKksKzPASGQkZeBhCGi6M4hfc1puGC8o1aoJ2BIJdp89mUnpcKBZ1+a5oD
         P2ltPR46cw6bLl5t194y2WaTfxC4biJoZR2ZEwux+4WlDjSwjhuFzlaVGVBRmuh1o0zG
         gY1jWIy8HMbdy/4SV0aght6++PhdbZnf8rlZkXkENSbHrEJCBiMtsXdr6VklI1L78kVO
         QzmKZBjf7d8zhuyIpCpQCImoY9zAQC8tcgP5wcliqWkoJ1nmxaYarfdBpqv2/tpOkRf5
         DdJ/kV6ze6Mo0ira78Ilq5mbp4Fl/v//UoV0EwK+HpGN1IygprfMfahZ+Cd/yE4EKCP0
         JAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737452545; x=1738057345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pLNPN3ni6Zdmsk2aheSAletIg6IwRY2toiothpvNsY=;
        b=aW1PYJxTjFhZq/FnDB1bgFQRaitBBOGibLkKc6QGMkrJPMY+R8HTUi/UKgmEnSZ7hH
         BKtuNJjI/38SxIvXw4zpIGFS2svrO2rVHu88SviiH1qWnznXZ4KxreVOPmON9JXazK/M
         5wajo763HZU5jcStDNAgoyAighDFJu3/v3iRd5wHdU1IAQ/C3+cfxNes7Y4Ex+w3d1/y
         6M8v1WWW7xMrIm+tyG6FpCgrPZs7+HExY/hkrqhc9ajQdKcK0kTobfCSmcje0Ljmav8u
         osXgeRiU1mdhdvFOAPmuHfh3s6KvfrOJ/FvyWjaramvreDrMjFWclZ5pYAeAWs6pJJYI
         X/PA==
X-Forwarded-Encrypted: i=1; AJvYcCWr8kY8kuirmmnepUUXPOx6HLQiMMVbAuVNzVZUO0KyhJWeMJB+KLXtxBfAoUdSYzS9tFW89FyUCnHX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9PVVSWzLjFCmQOtfQ/5iZL0ACvx38K0LUIJrVF0Q/KzihBxtw
	oyvkYyJn8cdFT8y/hJh9VTrY3OaNZ1aJZlyV38t9yhk1I5seq8yzY9fDeaLNNbVrYCoKTMyhsmc
	kkO0VbeICFRrD1UyhQ8ixcftC79w=
X-Gm-Gg: ASbGncuJD5zjbbgs7Yy3TojEr955dch3y9VPIy12exgrTfo/6PysfbvN7JRM4FFNCUy
	lYWasd41L+P40COFaHMZ/uDxIr02bVL6HhIf7rXGq4MPQyNvbCB5AKWW04aetIXgxE7HdetXfEm
	Oojwo1uVfzWw==
X-Google-Smtp-Source: AGHT+IFST/Bxn3Rtx81QUTKjaZnb8IsZ5Y3MHTW60QC80/RkvUH22LuKZe2e5KvwLN2KB6jQIM2Mw3igujM7uByN5Xs=
X-Received: by 2002:a05:6830:6e17:b0:71d:e89e:9af5 with SMTP id
 46e09a7af769-7249da90fb0mr11126971a34.16.1737452545505; Tue, 21 Jan 2025
 01:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com> <20250121040125.GC3761769@mit.edu>
In-Reply-To: <20250121040125.GC3761769@mit.edu>
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
Date: Tue, 21 Jan 2025 09:42:14 +0000
X-Gm-Features: AbW1kvZghcmGS1mTAqENoTjQ24sh7R0DelDTm895TkKEN1yrN72WSZ_QqVcgIwY
Message-ID: <CA+rD4x-hh1bzN3YWiGY-EdSpjDxiA-6HzRO14d0pfdb789mS6Q@mail.gmail.com>
Subject: Re: Transparent compression with ext4 - especially with zstd
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Gerhard Wiesinger <lists@wiesinger.com>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gerhard, Theodore,

>even for a hyperscaler cloud company
>(and even there, it's unclear that transparent compression is really
>needed).

Regarding exascale storages. Lustre FS (which uses EXT4 (LDISKFS) as a
backend) has a =E2=80=9CClient-side data compression=E2=80=9D project (LU-1=
0026) which
adds transparent compression with an extendable set of algorithms. The
initial release includes gzip, lz4, lz4hc, lzo, zstd, zstdfast
algorithms with levels.
More details are in the LUG and LAD 2023-2024 years presentations.

Best regards,
Artem Blagodarenko

From: Theodore Ts'o <tytso@mit.edu>
Date: Tuesday, 21 January 2025 at 04:01
To: Gerhard Wiesinger <lists@wiesinger.com>
Cc: linux-ext4@vger.kernel.org <linux-ext4@vger.kernel.org>
Subject: Re: Transparent compression with ext4 - especially with zstd

On Sun, Jan 19, 2025 at 03:37:27PM +0100, Gerhard Wiesinger wrote:
>
> Are there any plans to include transparent compression with ext4 (especia=
lly
> with zstd)?

I'm not aware of anyone in the ext4 deveopment commuity working on
something like this.  Fully transparent compression is challenging,
since supporting random writes into a compressed file is tricky.
There are solutions (for example, the Stac patent which resulted in
Microsoft to pay $120 million dollars), but even ignoring the
intellectual property issues, they tend to compromise the efficiency
of the compression.

More to the point, given how cheap byte storage tends to be (dollars
per IOPS tend to be far more of a constraint than dollars per GB),
it's unclear what the business case would be for any company to fund
development work in this area, when the cost of a slightly large HDD
or SSD is going to be far cheaper than the necessary software
engineering investrment needed, even for a hyperscaler cloud company
(and even there, it's unclear that transparent compression is really
needed).

What is the business and/or technical problem which you are trying to
solve?

Cheers,

                                        - Ted

