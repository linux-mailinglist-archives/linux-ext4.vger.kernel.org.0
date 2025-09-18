Return-Path: <linux-ext4+bounces-10246-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D66B86CE9
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 21:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6049A1CC410A
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1939314B6F;
	Thu, 18 Sep 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNlT1dRM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF13081D4
	for <linux-ext4@vger.kernel.org>; Thu, 18 Sep 2025 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225501; cv=none; b=n5VhOla7/f+4Ceo8axWoUEFMqNIdcCbzJIFYl0eWDhIv3XAAdvnf/4w2xmx/ru9kC49XvkZtDHh2M+x2jyJNUsJEpfjhJfrzOZnBsp2Nzuw1binrU01op6HpLLEVGAgPFdE0j+XrxxGH/ceaXQ+fs3F+/jb1rfnCJ3Qc45rQP8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225501; c=relaxed/simple;
	bh=hrTKVKMuOKbLilzSA+VEl+XSSF0VIocT2KvCzkuRjcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOuqnDzSzpuJaC2/tq+y/FVG5rKb8WjzIN7s8k88xlpScA+wM1je5TtdYOY4AuOLC3ckdBwc2YsTrIZzjCCzDtgBCrLnz9bA4sWYvwoCUfPxAVZx+VBynuY8+SXJO83FCAmd7tB8gxpxztlxZvROovMR53HusW/fkMh9wId1MPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNlT1dRM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62f4a8dfadcso1604117a12.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Sep 2025 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758225496; x=1758830296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9McvDjxp1cOQ8m8DQ7zr8KAOkClRv+R613f7KwPZqLk=;
        b=hNlT1dRMFhV3nNEO8OCPXfEiZjy7HadMXu4vRgp3Ipj8QW/pTjkxFRxYZEa69pe80J
         R5WZR6uBlmeIbF+VQhBUi3wnRJuDxh3ZSYPm2HtEzHdmYgYFzaLOTkBNZpxqwUsXFCi5
         xh48TC/I8mOWxP2I4D6qthvi1wAkVJadHw9+Q6aETqCdcS+tzshGNcO1qODnTVXpUxR3
         DzGuLf7FRf7YNLECrqzb9ayMBLdTqRvBk0ivmzKueGmRkmu1GRq1Uqn5Uc0kg8EqXgPJ
         5wCj9Urjk2M3jfgX+oYXsBuDx3I+zNM2GW5fMn6rB/kk6qlx/ZV55XBxceRxo80pIEfP
         n68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225496; x=1758830296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9McvDjxp1cOQ8m8DQ7zr8KAOkClRv+R613f7KwPZqLk=;
        b=sPA1nlIbrLsnNpLkHfuTj5fxYG8xamhXvc+hFTj2SZpF6aLe7R8UU29gOf2RI+Y5f8
         tGciH5THC/4pSpckoQ+TfifT49MSxmUPMccJPcsqiTzH8WPvTcmMe81qIuIfqp4nSS7b
         0CSlM8yQ3czViaEYd1nZHgmZgOl4mXEEAEBbybezjbNtI0UGkB0Bq2leNQntsxTfDDNZ
         tTgyEiG9mSxSjKYkWfLmQpj+/oPlKzjDq2gDXBuF4oze4K0QzEe5PQRnjY3luN0rCkEX
         0NLraXda8/45vQISokvClwlZ+M0fYZQQ5n/nWnptWl7PJFdvbQIMe+L1BjRH+CwZr6Ee
         qS0g==
X-Forwarded-Encrypted: i=1; AJvYcCVG5xY8t91AjuBEQ1cP6oHO5Sk+w27xQ8f5HitORnPPfhYEgWg3CwBuHqhF3cWnt8ct20c2OPmOx292@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Wzt8b3TAES7xhhfq6OeTz0Oyu/njbVbaKIIelcYXn6o3uYhA
	9zswkrMXNRi0Qx7Pi3pVPeWQhI9ehJNfv9+QmoZ4+ILFDSO7BfkrojTV
X-Gm-Gg: ASbGncs+ckZElgKGp/551XqrF8EdG3Xa3DUMRgpE2uDe1qFkDn4BDc+kdyMoQKFYdE/
	BrIa85dOFz3qUW8HjRZtUZimZBuh8IB+J5+CvxOSqZqxw52CmZiJwUX3CQ1WhwoYeGF69VOyMkD
	VSAQbWkJOCOvMKGJUdTkcyu2URN1DuCN4AImr3S0qnlX84sKECOea6EN3dfH9gYRlIEYODCr6Ci
	896Lv77sG+l095C9XkpR+ZfsX3Zu2EP16KMOAf+31OiDILbvEGGx+Bnl3onACcM7O6P1IspeOfA
	5dulxSe+IiiRdu325ttggbeZzIJbuF3FArFf66egS2Kl3PVmY/MqOcmUHZMROcj484D0zGJLJ+M
	zjAk9NAg1xNJoBSWGuU5J0HRptx07SmVKcud9/A==
X-Google-Smtp-Source: AGHT+IH2NBu6L+bASXNqg9sJUcZ42MFCB2aqzEFiqoDEW6um54A4CtHcJnO37auTgFbi6nwycKDm8A==
X-Received: by 2002:a17:907:a089:b0:b19:969a:86 with SMTP id a640c23a62f3a-b24f35aa177mr45885966b.37.1758225496090;
        Thu, 18 Sep 2025 12:58:16 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd1101c44sm264530466b.82.2025.09.18.12.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:58:15 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: nschichan@freebox.fr
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	devicetree@vger.kernel.org,
	ecurtin@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	mcgrof@kernel.org,
	mingo@redhat.com,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	patches@lists.linux.dev,
	rob@landley.net,
	safinaskar@gmail.com,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Date: Thu, 18 Sep 2025 22:58:06 +0300
Message-ID: <20250918195806.6337-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250918152830.438554-1-nschichan@freebox.fr>
References: <20250918152830.438554-1-nschichan@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When booting with root=/dev/ram0 in the kernel commandline,
> handle_initrd() where the deprecation message resides is never called,
> which is rather unfortunate (init/do_mounts_initrd.c):

Yes, this is unfortunate.

I personally still think that initrd should be removed.

I suggest using workaround I described in cover letter.

Also, for unknown reasons I didn't get your letter in my inbox.
(Not even in spam folder.) I ocasionally found it on lore.kernel.org .

-- 
Askar Safin

