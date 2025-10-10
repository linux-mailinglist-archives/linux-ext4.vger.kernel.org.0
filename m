Return-Path: <linux-ext4+bounces-10732-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD53BCB7D1
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 05:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466E54072EC
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 03:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277D253F39;
	Fri, 10 Oct 2025 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPjRTN5O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7921A444
	for <linux-ext4@vger.kernel.org>; Fri, 10 Oct 2025 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760066302; cv=none; b=VinOHcMCTu8NBLzHsGk1+g5Jm8U4lepcaT8RTZLd0xjvaWlCAP/Y2tN22Z5scJ/uWFjpS+AAyiB+epPeFJknWLpsGUxkrO2ll1r8nc2yOHCQB3sLq74XMqbp2Yjm+HKeC5v08gVdkq73NXOmKDNoqjkuVG4JEKYNmMAH0jNomCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760066302; c=relaxed/simple;
	bh=Pa2OhCNI6n3Mf2P8BAMZLHp7akXwtALOTxVawJZtfK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESf+osgse2D/MPKdYACw/cm65ISOUVZ6va0Kn81/2hA/QQRC2YK6n22P9g1iAVl4PKlrs1W5U/K8CxBq62j7Z9wb75ORKbidznFeHAfC9sUu3KTEep8tVP0nStIK1dd8XOcuhgM14Q6817mZ0Bth6H/iBVvrQn2a+sVtRKk68HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPjRTN5O; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6352c8b683eso1884893d50.2
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760066297; x=1760671097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa2OhCNI6n3Mf2P8BAMZLHp7akXwtALOTxVawJZtfK8=;
        b=TPjRTN5OIdK/OXusT04ct2sgaYmzHo4t4RUcO6PdWBlDAfEWtPUI7uWv35B1xXRQxj
         nWDps35hFTHMxr6Vk6M3zzXh9jL55JqC/Vtbp/qJ6kt/g1GOp16G+Bg7LB6bG1r+b641
         2GZAocJ0Y9aAfXmNH7ZbdSlkaY3855X9zXdD9dkM95xNJUS9OJ0kOfTN+fQ/pIQRx9sx
         UeR9ve3br8pXzxG5ySPUb1OPrdiaO3ghhmi6NZfYRnFFgvD4Pi0E0XzWFozMQQbypHnK
         0gPBMHcY8gVSfhZZYOScFt4tOJz4MKXSPhlAeobvvXhPaauJ7QzUiKey4bQvJhfYcTAm
         mK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760066297; x=1760671097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa2OhCNI6n3Mf2P8BAMZLHp7akXwtALOTxVawJZtfK8=;
        b=Is4m+gHulqzHJgTYeOaPBgz7BwkKyDyhU4iXhec8mahpZHKgu/VM2XBYkO8NhKXJaZ
         lviYc2H8znQrKnTLyRWOakVr85UvwXeYnWiX7mLF8F05JArSASMz7ESmYazt7jmNNKgc
         oLymYQZr+EQdlgOMNq6E8LS0w13zMXk0rcIlzBxIzjR2SmPOON+xpOz/5XAr5VwMkDmu
         6T/yjrFxzpaOpjJngDd3D4pFbAfUo6YTUro8QIQiqFdNkEWlRp7DF8dMPomZxHgy7Ot6
         EpaGtyMWdNNFhzbdRCxHeDudaAZWEAIWtmNYE3idUKME3E1VHB1LMuCZo4MwRB8wmBic
         7J7A==
X-Forwarded-Encrypted: i=1; AJvYcCXgnNfChpq8qsg9j0dWJXsHiXJtdGLGkPdI69pjNupxc3HeCcLt8KLwsbbzD7NTpKrOmYF4Pk2NH4zR@vger.kernel.org
X-Gm-Message-State: AOJu0YwVI6GiA2Yyw4h8NwlpSecMy2PrbNuH57zW4DGeHoX2/xg0RU6c
	DSqv6kk2u5PAwhAKfF77SXMTnf2SYnIoq5aBusHakH5irXkBoqUThyP/pa68tlfBnKQ5AumWer2
	uWzjaMpblwPOcajR7eaXkzJAPzPuOU5o=
X-Gm-Gg: ASbGnct2nEeWzkyD7tA+EjCK2bvvl6ejII+xZv+JwR14+5EtRIG/Jfs3BTYeCezvnkR
	KGjD5S1VD977vbbWs0N6wpl5E4XNXDYTVEG41Mrq9JrYulagUM5OvDnI2eCal3Do368cZjzOcWy
	n0koY6mt5CeygE7SScu3y9SlpWaV7yIktTAeBWAs1K7VmODUkybqX6y/xExsx1KauW4euwneiem
	ZdUWvEu3ohiCBfVhqyDyq1TCw==
X-Google-Smtp-Source: AGHT+IFTQdXvlZxDoBIwCyChBgf2ijvKjPOXu3xyloDy3VewP6H31eXx2tdJ5Y2sZs04pWqa6kN09Zh4TAMeP3pYKTk=
X-Received: by 2002:a05:690e:1587:10b0:63c:e90c:a6d8 with SMTP id
 956f58d0204a3-63ce90cac96mr2654086d50.44.1760066297220; Thu, 09 Oct 2025
 20:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250913003842.41944-3-safinaskar@gmail.com>
 <053f39a9-06dc-4fbd-ad1b-325f9d3f3f66@csgroup.eu>
In-Reply-To: <053f39a9-06dc-4fbd-ad1b-325f9d3f3f66@csgroup.eu>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 06:17:41 +0300
X-Gm-Features: AS18NWCm5nh3vfq5EIpD-J_OKHQvi_8uVbgLjcXTz6TnQl9pdn9vqNDRLNkppRk
Message-ID: <CAPnZJGC9avy1s=xFS5Tg6obS+RB3zw4yWsUBw9g=Vt09S6j88w@mail.gmail.com>
Subject: Re: [PATCH RESEND 02/62] init: remove deprecated "prompt_ramdisk"
 command line parameter, which does nothing
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 2:16=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Squash patch 1 and patch 2 together and say this is cleanup of two
> options deprecated by commit c8376994c86c ("initrd: remove support for
> multiple floppies") with the documentation by commit 6b99e6e6aa62
> ("Documentation/admin-guide: blockdev/ramdisk: remove use of "rdev"")

Will do in v2.

--=20
Askar Safin

