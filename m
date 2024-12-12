Return-Path: <linux-ext4+bounces-5583-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E499EE4D7
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 12:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373C4282BBF
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 11:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544862116FE;
	Thu, 12 Dec 2024 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dfb9pVgp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72549211471
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001968; cv=none; b=XxzdCHjnTOWGTKvgxOj0iKrLAGV9dJjYXYKimvgPEHL/if9SSrma4m+mEq1hyUzUOpbnxOhqZx3AuSd11COOK4EEQrBuwOPnet+ftVLJeeHrIMwnJRiIqt10Ml2f5AvpefygY0U7vpBzlbpHzRgU3sYq/WmTAaiX8fCn2WBC5Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001968; c=relaxed/simple;
	bh=PV/cGJr+enmSKq1xWGYAXgzUqGzUnT2yszmMivb3QUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kxw1ydDkmf94r5OoV9bYzBtJ7oBbKB2Hfp/cAvfqqWcPeDjxbMfYRvlYmTCsPLZH+Z+hIrkMUzIvtj2CgX+5Fv5vS1GeQxcmEsasMWDRtAmkPekn1pqaoaov/1FRhkBQmVt7yaRzgoJaIcggkbNgd5A+//IPd4cNKtJc9eRkzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dfb9pVgp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734001965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9FENNGUBCFJ/l24CnwKVG/DRQRmDVPvP5daidTG5Q0=;
	b=Dfb9pVgpI7RS9I98XcHQiGv9BzZU4sjC6P6IVCeS1oK5N4Bbo2QdHJ+0KMHKnMn2XYGSkF
	fdWrsn7RVGDHJGExWUsNRSBpEYP8j+yxyQWO430xp9YuIAULmoOP8YOGO95lm3Lm7ohzB4
	ILJnivoLlthuq8sJsZ5bkxLXaLv73Mw=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-ljGBM7kwPCCSf7cOOWJycA-1; Thu, 12 Dec 2024 06:12:44 -0500
X-MC-Unique: ljGBM7kwPCCSf7cOOWJycA-1
X-Mimecast-MFC-AGG-ID: ljGBM7kwPCCSf7cOOWJycA
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4b115b28adbso33412137.3
        for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 03:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001963; x=1734606763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9FENNGUBCFJ/l24CnwKVG/DRQRmDVPvP5daidTG5Q0=;
        b=VA/kepTWWSl0D+Oh9v2Rlcm+cI4awAxmDl0BZHrDdv2k5ngA+MTMwuvBNDaNQk+3hV
         kC/wDQLQjMHoRHXJ8MTjYFBxHWy2kgjGWXjL47PFt263WQgvo6sCk9dwPG6DB3kxsyKr
         +hXqXGexVofypixu3ZOyyPVZO1p3FPERi5GW9H/+AJPR5Wt9D1j62TnOnAZvCG9otLlu
         ASV9WyFR0eywGiT1UxvCYypPFqK0HILrHkpaXTgKyH1c0lyPfAu6m2Nwrbc3fVeWqVxY
         +an3CdDOSTKuWkgkxYivhpdLe03Y0FMP/LLqRkCNegaYHcFW/y4u+emRLAYnfA7gb7tm
         VoxA==
X-Forwarded-Encrypted: i=1; AJvYcCV0dlhjMJoaHqFSjccY7xQwoTr96EVE+SeBXjEIfdujcG4pbMF0C7vZIZGMLubV0ZQ1yBpsXEK+4Bbg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/bLoBd5ZYKrEllmrZD1LshEAr9Rx/MbudIcdX+Ll/933PIXO
	REXmuq8GCjn5stNQCpYsEUQvBAdQ6Hb9jGSPTsq87VLHmtvdSZderO4QIR0Rm49XY8iJdlWkw3C
	e6749kKY/mfmZMIqEEHpxyDoGC8n6JYzMb9iERno0MQFw/mXMmcxNOFj7jLS1JCqzKXxPTkvcPL
	2um5UvSSjmPFcGAPYhkCTAVG67sbcq8U+uQA==
X-Gm-Gg: ASbGncvaPynPu2yd0jViEjOTsxmSaUCzX5Zc3kaZcSd4Ju0v4EPvBFpKaaaUmaHHrCi
	NVhQ2RJo3T2lsjrT8cVa7dqEYQ5T7Mqu6YpaxTIg=
X-Received: by 2002:a67:f859:0:b0:4b2:4836:cd82 with SMTP id ada2fe7eead31-4b24836cec0mr2164960137.22.1734001963691;
        Thu, 12 Dec 2024 03:12:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeS6cHs34LlOt5XaThX8i/UA9PauWXPrFd7gcQfKkgK+QOfOA+wdaboOIsT7vqH+OSbXpifWqzA6U3dUe9ZhM=
X-Received: by 2002:a67:f859:0:b0:4b2:4836:cd82 with SMTP id
 ada2fe7eead31-4b24836cec0mr2164949137.22.1734001963447; Thu, 12 Dec 2024
 03:12:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com> <20241211124240.GA310916@fedora>
In-Reply-To: <20241211124240.GA310916@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 12 Dec 2024 19:12:32 +0800
Message-ID: <CAFj5m9+XcbryvRQkfpWUcLO_Jcx0iQxbuW3ga1-t8bKX6ssBWg@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	"x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, 
	kexec <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, 
	Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 3:01=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Dec 10, 2024 at 09:56:43AM +0800, Jason Wang wrote:
> > Adding more virtio-blk people here.
>
> Please try Ming Lei's recent fix in Jens' tree:
>
>   virtio-blk: don't keep queue frozen during system suspend
>   commit: 7678abee0867e6b7fb89aa40f6e9f575f755fb37

This commit has been merged to v6.13-rc2.


