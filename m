Return-Path: <linux-ext4+bounces-10970-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA03BEE04C
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 10:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5AA189CC3F
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 08:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F71C22F14D;
	Sun, 19 Oct 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccTdEhIo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F738DE1
	for <linux-ext4@vger.kernel.org>; Sun, 19 Oct 2025 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760861463; cv=none; b=amv1/gGFtxKyaJvmR3neQ4rVsI0kf03mq+tpZyKI0A8JtvyiY8J5nHZu2GwbIHrhDiJE5OjEMlztLplgutsaY4LpKC6lNipHAelNzPbR/zCn6ERMzFSicxWA5pxRM3xrvYdL4K58CNGD8vd5iwAHerNhNlVk/Q3KmQ2AbUJliVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760861463; c=relaxed/simple;
	bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=py6fZnQnZovV641eJ2c8G/EtrhiB+ouKQSvAJUG34mHP6nTVKbb6P7vkVxWaLEhfCNZlRQZQ5KvM2fqRtDmHdL7DhV8NPsezLNswalbi09mVysBxFwHL+bpIVkoPndfBlDJe54EOZiDgXcXP/dZPgPL5nRBUUTo1ZCAm5i4KgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccTdEhIo; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7815092cd0bso33323507b3.2
        for <linux-ext4@vger.kernel.org>; Sun, 19 Oct 2025 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760861461; x=1761466261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=;
        b=ccTdEhIopdhypwI8L3JBil5M4STne8SmRaQFfCBM02l9LkTDCeY07VksMZS734XIYW
         fSr9E0vMaFgWvM5hpUfvHCdQwXqN1rLdg7uGpCmcE1a8p73wsSFiGM9KgaCUVorU2bB4
         QXlk0k/rKjfCpslj0HWJBncYE9y9o12Mjtf9KUBJxsuzUFBzDISvTP/UdlOzuowk2O9I
         i6m0bPW8oTEyUXCgLGFGHisuLGD8VhQ1MKnYlEu61P8OxgXOJsE/nO9c7FNSYyLg97yE
         4ySn5cXO9k6TDK22f8AGkED3Ks52VuOYFicnSfjIjvJlszMjZfsukHxg61ULY8iC4TUN
         9kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760861461; x=1761466261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=;
        b=PZjHuxFBQSpJbi6ka1oM0WYrOe5hOmG30usBZUGF7eUa10nj4lAer9ox66tI+9vQcm
         omWzAg5AeWIdCn1hH0O8XwrBstmn21hNg+nXeGfFz5E6ml1Uk1TrpVs3e/ZZ/vpKbwQK
         nVvnGUbgaGDy7Dl+naBKugSHP7vP+fU8Hy+O+p6EiSv1l9owjbohqQBMN8M/PlGLzDtp
         r94f1hrw8pFe6XCjVbnWDLQa0gkfDMcXxi28uz++f58ylCutF4TE3FNJ68HBH9KPQIMX
         4MH3UTXe4KYeVqwE48V+Zbalr3IPVJI8R0IQ+pUta6RcDM0zYX9Q+t45Bc+53XAURFBO
         EwoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXydu1bDrfvnwtel4cHif7xnwo15xonibz5ok6EIMRP+k+O+9IDoHIb0hvREcHbgoZec4Dl2Vna/sel@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXNUeWKvsrvYFeI+4am8zv/uZm3Z6/3NxA8mO9RW7EfAzI8q1
	aXDeWp6mAYCwvcTxdFwl30Y8dWOKrnvPMPlG2zdMpkW6qM/28Qu/kVCp3ahwGMJQ9yybP/ZxTRj
	KNHG11OSa6fSBmu+TP8kPMzcijSfrfHw=
X-Gm-Gg: ASbGncsbPKrfzN4TSH11y9+7z4hTwJydWgQG2f3rOpDdK5mgaqkk/Uhc18vJUOC/2dv
	xJfSFiNkKeBFT623BYeZZyBBmLW9oXaBTcCMFsSidp69EDlwdCchblIYi8Kd56jjuHbsGkOEbWn
	0zfJCHb6hwLa1bb7bBCo+7d4uVmyG746jlwul/y5C9v9krPVjBJRgl09tjHxBGk0a0rm9sxumTR
	y9AQQb4NKUtXkVGgy+rQdKDpMHFyyJT5QkvlhCgODmIT1IUUNGuonWM7go0ABUye36g8BFsNDU=
X-Google-Smtp-Source: AGHT+IEDp/usYEtVSaz10lwwm2/rh8YYcBuxag2F0nuBjSfSMoio/EijPl9t2f1PGKCDHr/mRoxnx6oC2CKJ7h3r2Ic=
X-Received: by 2002:a05:690c:31e:b0:782:9037:1491 with SMTP id
 00721157ae682-7837780ba2dmr109813007b3.42.1760861461100; Sun, 19 Oct 2025
 01:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202010844.144356-16-ebiggers@kernel.org> <20251019060845.553414-1-safinaskar@gmail.com>
In-Reply-To: <20251019060845.553414-1-safinaskar@gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Sun, 19 Oct 2025 11:10:25 +0300
X-Gm-Features: AS18NWAhDVf2aU8hB0qWERPwO9zi-ils_dPukaoQchmqqRauvEb3B93Zz-69KFg
Message-ID: <CAPnZJGAb7AM4p=HdsDhYcANCzD8=gpGjuP4wYfr2utLp3WMSNQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] lib/crc32: make crc32c() go directly to lib
To: ebiggers@kernel.org
Cc: ardb@kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 9:09=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Eric Biggers <ebiggers@kernel.org>:
> > Now that the lower level __crc32c_le() library function is optimized fo=
r
>
> This patch (i. e. 38a9a5121c3b ("lib/crc32: make crc32c() go directly to =
lib"))
> solves actual bug I found in practice. So, please, backport it
> to stable kernels.

Oops. I just noticed that this patch removes module "libcrc32c".
And this breaks build for Debian kernel v6.12.48.
Previously I tested minimal build using "make localmodconfig".
Now I tried full build of Debian kernel using "dpkg-buildpackage".
And it failed, because some of Debian files reference "libcrc32c",
which is not available.

So, please, don't backport this patch to stable kernels.
I'm sorry.



--=20
Askar Safin

