Return-Path: <linux-ext4+bounces-6286-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D4A249FC
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2025 16:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8D63A2BA6
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2025 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86A41C330D;
	Sat,  1 Feb 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="beu6EYlE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9810E0
	for <linux-ext4@vger.kernel.org>; Sat,  1 Feb 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738424317; cv=none; b=myT9cso8jdIlNEi5c6F/H5Wdg0uwpR1w0dAy+8exxw4dbOwPhJ+TIars4LX5zpdEvB/YKvOnnjR4oVv64kUyeunfGhsLUM8DYNZpaNOMoLEwMPS6I29KkRp2Aco/0dWdg1qQWU2bx6GwnBLdmMuEKQDiuxoCxFevZy0Jng7MBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738424317; c=relaxed/simple;
	bh=nO6Fpd0/MQ2WEHvFuYcR1nx6CJcbKZiuprKnSa0xcao=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Jf7XQPn3OC59VjLUL8oin2zPUgO8izuyDksFgtABJhJ1czdYdcXl9W4FVNF414Jy6DMRjNp+vYtMlD+qcFKmsVe9IbbTni45xVutfm/dCodnWwMCUlY2e1W8cSjmc3cDlFRr0/axjr/rWggJtaFB3C8WWeYCjsJQ5cG2p2h2XbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=beu6EYlE; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e46ebe19368so2901700276.0
        for <linux-ext4@vger.kernel.org>; Sat, 01 Feb 2025 07:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1738424313; x=1739029113; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nO6Fpd0/MQ2WEHvFuYcR1nx6CJcbKZiuprKnSa0xcao=;
        b=beu6EYlEEiRT65Hvv7Ib5XdVJGuNxjsO2ko1XW9yaKXCj2lQbAO3o/k1lWYeMO39m8
         ktjR3eI4xEUlTXJDazpd/3RRRXrieAj5aF9owuYGvqufXDDp0iT1b/8b8trSV9mO4TN0
         RmPae5MYw+o7Spod+0Cq9FV40bELPF81+4kV4ZLf1EIemGLMQ7C6Qg2ZJnInXsBVI4p2
         70BZvBbS7KxQA88wdk2738d7sAwOsIILQp1tM4+XVngTJEbCSpiGd/tjPNMOjop50rMH
         gN/qL0j8YyUTEN0YyT02mnn+ipFHaeAllQk+2SA1TmH/UYaJYF3VMiZuc6Fbte+TWC3D
         pMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738424313; x=1739029113;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO6Fpd0/MQ2WEHvFuYcR1nx6CJcbKZiuprKnSa0xcao=;
        b=JH2Z8GtlOhEpZ/PIhmk7dTqKfE8kKhTruMhXbLC0Z7/xqNkDKQHaKU2yxcHiw4DYZl
         47cUzIzuj52E/EZmp6FIOffWKMsRx1JKaW0tgAz5ZGSzfduWy5PxLyGd42WiDlhPbEMH
         hJ3L7zAXEP+a4FwMBYNqJJ52nExUMDtYKg9SKqhO0HvkVX5klNQ4U3N95XoRgAl4/5Mn
         DrhFOTyoH1wQ3AKmd4wE6FnAGWWHJoq8CjSeUmuslIDa2hlY8aDXUBzafh49GHkWsxZU
         TTEl88fNda0soLiIGb3qwm3nRsD0hUtW1snBmNvDjQYnXdpYpbsN8U9V/nKOxT2xOTu5
         ve8A==
X-Gm-Message-State: AOJu0Ywdw8F+D8OAJ5XH/T2RPrsrM51IRMytVYWhoGyOIwt/TiZ+oIMe
	uVysmh4z4duOo9WwXxysyeR9MmWhfhrDlzGCcrXFuC6WWxmx48TQcqZREO1wSGR6PTds1EDxaEg
	TFAg=
X-Gm-Gg: ASbGncvgYxxCZqLI7zdFLCAy/I+Y0Wz8ZH+IsluWVy0myCHI9DpAHA3NQcvAf2tTifK
	GULN09vhRHU9Xgi3/20kqj5aFGuYZWMcd7h7PhN4ffmi9Cia0avqlmri4nmUlz595GIVCCad/Eb
	mUcyKFlhHYPU0vDUFG9SDCQXVXB/LJXBJ/xkKL4BBHViVBjcIarGAEl0jhn8W/Z6XJ6guoyHmDw
	zMkIoYMhhg73jO+CDqrRngMJQqhdSSqPYlheLgR8PGLTbzGH3o++1Ho08XsbPjmWDZ+xtVGtcMi
	ez1RHJsRRqhgiTdxYd5X1YvzhwE=
X-Google-Smtp-Source: AGHT+IHJFoKOkO0g+69z0XYsranwfPsKGcqbRQlTpfpD7dWDjMQWYmXm8zwsqUlMQxSzlXpZlkGUNA==
X-Received: by 2002:a05:6902:707:b0:e58:85c4:bd35 with SMTP id 3f1490d57ef6-e58a4ac37f8mr11720198276.13.1738424312804;
        Sat, 01 Feb 2025 07:38:32 -0800 (PST)
Received: from smtpclient.apple ([199.7.157.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5acb27ec7esm1275389276.16.2025.02.01.07.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 07:38:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andreas Dilger <adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: A possible way to reduce free space fragmentation?
Date: Sat, 1 Feb 2025 10:38:17 -0500
Message-Id: <8539EF46-5166-47EE-AB26-01ACA68D6DE3@dilger.ca>
References: <8dcf1b6e-633c-4415-9412-6876efc07b50@gmx.com>
Cc: linux-ext4@vger.kernel.org
In-Reply-To: <8dcf1b6e-633c-4415-9412-6876efc07b50@gmx.com>
To: "Artem S. Tashkinov" <aros@gmx.com>
X-Mailer: iPhone Mail (21G93)

It should be possible to run "find $DIR -type f -size -1M | xargs e4defrag" t=
o only defragment files below 1MB (or whatever you consider "small").

However, I don't recall if e4defrag will move a file if the new file has the=
 same number of fragments as the original (presumably both "1") or leave it i=
n place. That would be possible add an option to change.=20

Alternately, just run the "find" above to find small files and then "cp $F $=
F.tmp && mv $F.tmp $F" to rewrite those files into new blocks, and hope mbal=
loc will move them to a better location.

Cheers, Andreas

> On Jan 31, 2025, at 14:02, Artem S. Tashkinov <aros@gmx.com> wrote:
>=20
> =EF=BB=BFHello,
>=20
> ext4 has no free space defragmentation and at most you can use e4defrag
> to defragment individual files. I now have a 24GB ext4 filesystem that
> has only 7GB of space occupied however it has small files scattered all
> over it and now bigger files occupy more than one extent and I cannot
> reduce fragmentation to zero. One way to approach that would be to
> shrink the volume and then defragment it but that will involve a ton of
> disk writes and unnecessary tear and wear. Is it possible to modify the
> e4degrag utility to move small defragmented files, so that they were
> placed consecutively instead of being randomly spread all over the disk?
>=20
> Regards,
> Artem
>=20

