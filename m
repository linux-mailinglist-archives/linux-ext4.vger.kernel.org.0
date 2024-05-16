Return-Path: <linux-ext4+bounces-2541-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890658C7B76
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 19:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DCE1F21857
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49532156871;
	Thu, 16 May 2024 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltehudAH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109E1E880;
	Thu, 16 May 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881334; cv=none; b=sFrIXMer3Him+oz3F+JAw627Z0rA7mcvRr/PKVdRZ5hxIwSXUDPA8U9kcuO1LIUApvoiyZrevd0Oh/6WtiKC9nO0Db1/O1qur80PyQH72Y/FGOH5qSa5IBbxhPv/ZzCkOMm7YEBr0dEyZam3y7Y9/ebAgvWuhmYteiiaENI6Fpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881334; c=relaxed/simple;
	bh=7Yn7F5L68sDLIdlskeOzBHsQHVfBVBbjMZHq3csBVI0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WbHEeiNKIj2x79y26QebBqxfdhwCHV3coCxXIXtp9RT2EdwPSOHrEwBElY23SrasOi8ozg8OdavWvjSLuHaIB+sAdoIS+G9kz3yFGq9cv7fp+VAwKhs+2rsPpcOSrJ0fHKWqNLtwYjmPjf70TOZEbM3VpGkDRpWg3/JYV8NRH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltehudAH; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-6a0c8fb3540so56571846d6.1;
        Thu, 16 May 2024 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881332; x=1716486132; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2IWn5x9QtjyRy8l6pMXslqytYKJTjqGvZ/CNJ1mSN8=;
        b=ltehudAHhGhxGIZZG1sKZj12JysUE6Av9arkbI099M70Hjnkk58OL90ddfl+9eTvsD
         5YATAebC9uCHmjz0FNVime8a2+GFF6m+yJIJZ0PCutlRbGMa1G+jnwSw/vY/fPisXXo8
         TnY2yQHVR1YOptKCH+R5jJIGAPdH0OYK6lOfPynZT5imvGWOj87kfrGUq8+S59KTKHJK
         uigovILjSswJahjeCRyptVEE2kyVA35Pq8RPxmSoRJ8NHRXi9G9fUrbT5h3Cr6HjMaaO
         krlFL80uO1hx0k0iIY5ccafu+fSDMi7bnXFn7CkyGv7WhfYpawlQWLl+zB2nBY/hMcvw
         i0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881332; x=1716486132;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2IWn5x9QtjyRy8l6pMXslqytYKJTjqGvZ/CNJ1mSN8=;
        b=sw+FwWx3z31k5MFoSJ57/HR5K4qRO6FEiu+DPymdr+SrZDfG8R0jElcOqUUzUoP8Fj
         tV6f4kq60rvk/4oweljzUS23bugNBj5nQLBFHm76UdNkI3/LJk1mI+Wo2MI4RDjiPvqJ
         ZLt2RqMK2+57ZJ4QfLu96CVY2MaacyAu8JWXxN6W+3GQ21PdmFQpeROdi3Dc5gQ04vTm
         5X5DY/cd7BA5XMisuyed1mP1cyJjNTnghhZ2zFd7OPtCNmYa50tSXjiG7nw4g2SdEw3y
         CF6/NphCsumyZv36O/SE9uX01XNXyY54zcE6TQ55CPf3+3UAItkawqFdB1aR7EwEjMLp
         aZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCWtvITNw5D212G0MC7qr7oILNYOlMjl3edkF62miIwE+qKNG1LAAeNyAju2wK1fAkDVCGWyf1eubBHSYyrJng9MTNrbUI7xYQPHP15C
X-Gm-Message-State: AOJu0YxLXLzqn15EBz9ULXMBA1tYlSZ/O1TOewiIb1yUpeeUZgQASwWs
	htKV5cchnLtnLUkZx3QF6b1bhJgL8peOL/0KDrYtXdF07/yMe8dl
X-Google-Smtp-Source: AGHT+IGcqsLo3pmIpQ6GlROvCQMJ8rUY5hll4YJVFpsQGsGlbCYTe44xLZw+yW3FSNmgEesh2jBQVQ==
X-Received: by 2002:a0c:f6c4:0:b0:6a3:58a1:1e24 with SMTP id 6a1803df08f44-6a358a129b7mr78572886d6.25.1715881332192;
        Thu, 16 May 2024 10:42:12 -0700 (PDT)
Received: from smtpclient.apple ([2601:98a:4102:7e80:ac34:7fcf:f3a5:4fd8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd17bsm77554206d6.96.2024.05.16.10.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2024 10:42:11 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: KASAN: use-after-free in ext4_find_extent in v6.9
From: Shuangpeng Bai <shuangpengbai@gmail.com>
In-Reply-To: <CACT4Y+a3Tvh5eQuuCcrFuBfzAPQMVwEh0o5jLtASB_xVnKt_cg@mail.gmail.com>
Date: Thu, 16 May 2024 13:42:00 -0400
Cc: linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <77DB8D1D-4650-4A4C-BAE0-B04C29A06E20@gmail.com>
References: <5B9F0C1F-C804-4A9C-8597-4E1A7D16B983@gmail.com>
 <20240515224932.GA202157@mit.edu>
 <2184C9DB-DDC2-484B-A1B2-A1E312B62D54@gmail.com>
 <20240516135821.GA272071@mit.edu>
 <CACT4Y+a3Tvh5eQuuCcrFuBfzAPQMVwEh0o5jLtASB_xVnKt_cg@mail.gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>,
 Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

I will follow the suggestions. Thank you!=20

> On May 16, 2024, at 10:44, Dmitry Vyukov <dvyukov@google.com> wrote:
>=20
> On Thu, 16 May 2024 at 15:58, Theodore Ts'o <tytso@mit.edu> wrote:
>>=20
>> On Wed, May 15, 2024 at 08:33:33PM -0400, Shuangpeng Bai wrote:
>>>=20
>>> You are right. I disabled CONFIG_BLK_DEV_WRITE_MOUNTED and found
>>> this bug can not be triggered anymore.
>>>=20
>>> I am wondering if there is any suggested way for me to check whether
>>> a bug is reproduced under a reasonable environment (such as
>>> compiling config) or not? If so, that would be very helpful.
>>=20
>> As I mentioned, the upstream syzkaller always forces the
>> CONFIG_BLK_DEV_WRITE_MOUNTED to be disabled.  That's the best way to
>> check whether the bug is reproducible under a reasonable environment,
>> and to do it in an automated way.
>=20
> FWIW we provide configs used by syzbot here (upstream-*):
> https://github.com/google/syzkaller/tree/master/dashboard/config/linux
>=20
> + a bunch of configs fragments with explanations why things are
> enabled/disabled:
> =
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bit=
s/maintained.yml
> =
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bit=
s/base.yml
> =
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bit=
s/debug.yml


