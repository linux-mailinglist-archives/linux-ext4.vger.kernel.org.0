Return-Path: <linux-ext4+bounces-7111-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79825A7F4DB
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 08:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754FB188B336
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 06:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A6E215066;
	Tue,  8 Apr 2025 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="b9pcGPhc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569C198A08
	for <linux-ext4@vger.kernel.org>; Tue,  8 Apr 2025 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093059; cv=none; b=MR6hNZQEKJaJFz9XlShtDycQ4obV2P0N6JfqyR+u/Yvm/Y5P7GGjFV46nnI1BAt8OYHv6jWswP6B12jeTvdRInbMjqiVH/JW2eofjYFM3ryv9vHPfT3ma3s52Or9kh47mDXvxv2N5ODUlKLKp6YjERkP+w9b1svah1hbz6XsQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093059; c=relaxed/simple;
	bh=VW+RsJJRpNN89PxvKgUJK1GGasY5iK6flMlTkynIT2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxAmNlH3E1PjlC/e/Sw0fpDZndzYGPvzQqh16kOqDP4xFf9NzIhTQ4Z0cEwR1WMY6zMbNQt3SyEDntzcvw3OYXIPYe/0xLipvQKzEKb4vz3k61EhSxBKrbkJ1iYVuYXoFTYUIwYW1qO5IQUh6Ct5/HuB2xzeQrLx2jhpzEeH3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=b9pcGPhc; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47664364628so52042121cf.1
        for <linux-ext4@vger.kernel.org>; Mon, 07 Apr 2025 23:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744093056; x=1744697856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nS5SAKrFs9L3a7bg9Pf2lyrhub99zp14T9x9IO3i5/s=;
        b=b9pcGPhcGEOcqGDWMudRHPYphk1lVLBJqaQYr5QK9mEKrjiw9vWO/w49x1tUTB2hhm
         WZltNtxI54toK4cvK8lebAzM/m2L4s/KeWW7Iux1V42fdNeuzbcvIjq+y9zlnPXiB9Wo
         MX3WsGGopiMR9+d+ZtIiBGOITIIoSx70S3YfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744093056; x=1744697856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nS5SAKrFs9L3a7bg9Pf2lyrhub99zp14T9x9IO3i5/s=;
        b=Qjnf9dprl7Kiny53fbzWDs53IKDTLPxjq6cJ5lrQkrQTTHtBUWGvl+kqYBe/ypGvLY
         hWHl6JAtwZILka6CA4ocPIRKrbXFaDGpLSTmYpbWY2l/KhrQbbL0qVvk4Q1t2s7xohs1
         iMTJ2fweRsY2tP+rTlQ67FSeGrUe7JaxgVLA5UHCUzrVxIv6imiCpp3169Wik11XAM38
         0/nkbvw2Des7AG2kTCtMG7sxD7M5KTKxrg1bSjuOBRNTZxtcy8LYlfC2nKi0eVhY4nx+
         HJi32RW52ujXcjmaVqH8Tgq4N+aB/77njGOTi26IZvFnyt1JYofPAtWXK5KHgT4P8kSB
         gI2A==
X-Forwarded-Encrypted: i=1; AJvYcCU5xTI2GXD7P0GL/E9fa1iSJypFDtslcHCgesOvzqL7fS8n/4TC60GwhmEgKfF6RJNpK4TMRbpx8z/I@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13c0viT/UfAzyI2BJnz612LoChEEHlcUYKH8QzwgEwq2yG0bl
	CPH1fV5/aFzGb3DtFHNfGHpukqHkIRLADTttHokFtBNMBrHH6OjX35g7rRYE/HnqasYSvUVA55X
	YOgo3ePm/PRLuuACLYAsT9yq8FVgKXz3fdZvYSw==
X-Gm-Gg: ASbGnct8JmrD0FZ/udGsIJrUXM5LLjbOehN5rYIzHUgpvjtpMjerBf0gZqXCLD2B1td
	16pRnxYXg9vPv15eum7KWrmQfIFDLvuooIiEm8p03QUqQVlu3/WjVdYxuNExSd4ETan4AP5wCdE
	UjZOk0xMyu/xPiRZzeoBqeyr40PY0=
X-Google-Smtp-Source: AGHT+IGN08NztWSyO7oZY1PKzyq5lt8yT3Bg7u9DzpatY8aRQSviQxIWIRLmXD23CvcOoXDn1LuSBR6ZSex14gtyN48=
X-Received: by 2002:ac8:5a8a:0:b0:476:6df0:954f with SMTP id
 d75a77b69052e-47953ed2b21mr36161891cf.10.1744093056143; Mon, 07 Apr 2025
 23:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67f3dc05.050a0220.107db6.059d.GAE@google.com> <1465443.1744059739@warthog.procyon.org.uk>
In-Reply-To: <1465443.1744059739@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 8 Apr 2025 08:17:25 +0200
X-Gm-Features: ATxdqUHATzE8R7-GtRDaTuVwk64W_yazPWFWR845MefAQpWOnCnETGl6AzmpLJ8
Message-ID: <CAJfpeguEd49YhmbsZYPgKJ4=BYpgEEhF7gnH2Cp1yRouQUUMWQ@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] [overlayfs?] WARNING in file_seek_cur_needs_f_lock
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com>, 
	adilger.kernel@dilger.ca, amir73il@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 23:03, David Howells <dhowells@redhat.com> wrote:
>
> syzbot <syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com> wrote:
>
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > unregister_netdevice: waiting for DEV to become free
> >
> > unregister_netdevice: waiting for batadv0 to become free. Usage count = 3
>
> I've seen this in a bunch of different syzbot tests also where, as far as I
> can tell, the patch I've offered fixes the actual bug.

Which one is that?  I can't seem to find it.

Thanks,
Miklos

