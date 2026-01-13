Return-Path: <linux-ext4+bounces-12791-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8B3D1A6D7
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 17:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B70423073894
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F7134DB48;
	Tue, 13 Jan 2026 16:50:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874E34DB46
	for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323021; cv=none; b=Mot6YaX/22z4symgOna45NOw6Gs1ROhXIwH74pMXg06I581ekGeK1x+TisL7fSYmQlWsbL70MBOMTFfz0muU3DAcW0/IKUGTAZRCTd2/WW7Xe5uv7jaCwqIcj+ZStZfGp/5+sV9wif69hajJyNyQ9pn3u3fopYL7B6/tGzUbFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323021; c=relaxed/simple;
	bh=Hm+hFkCxE6lVbQx4eQObQxXAcvrq9lVQw90Wa4bRafg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqHDUM6lveemWACwvbVZW3CoXvw6pVW3u+kJWpUpLLlb54qq8HA1pNjbYsIbf/l4elqZIUH1dvl+0jBRzzHgqnSnKmO3L4b9obWBjW/uA1wvZ1YGxEqLEPLX2cMpFO/cmGhxQmpqYs3HHFW6gK3rr51KJYwZLZMzmoZpW1jdkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3e0f19a38d0so5430490fac.0
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 08:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323018; x=1768927818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gc7yqO7D0eseyKYDyefBFLldfXSHU35zlyHiXIvs8J4=;
        b=IRsSL97OpedDALhRjIe/rtIEAl5WiUj8exlPi57PKqpzQwKUKtcps07MLBVhZBhU+7
         xksK657aaSmU12MedaD6XuNNrjunjDLSC62Wfb8QW37ebpg2ILcfG6RGFjShSjPqKq5X
         LA6WylWpi+PFBHs/QiBVHxLbQn9ZUrKb7meLkFSctmR9aqORrxO+lV5K33bj5CYKhlsD
         YtMwe6ak/UP557WS0VQkBM6fiISI7yq8knvO0RPA5vpWQ+3P4UR9MFDl4AQf1wbbo337
         x7fPQhTdcqACaB0XrYSvsJbazICrq24fxBZL1330WjCm5HL64WbsR+kROU11ic/r6fFw
         tqmw==
X-Forwarded-Encrypted: i=1; AJvYcCUKc1jSV4BvLlZbx0X5O5/FLwAWg05TzBeIoTHB7NYjKSFm/6MDo+KmM9w632gknZfj0yd561bRm2tx@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKBLle3Jwhjjrdcbs8Y3pZytflHDRBlqx9UTbAw/ELkIeGP3O
	obvRmzfUvAmc7KpOG6qOdZS0UHwZAGLnBhwEM5Jd4+TBV0z/IlMhYxfIxwLEMQ==
X-Gm-Gg: AY/fxX4+7/Mid4uUcP2AI4zFlOJm9gJ1Lf77tvELnaon1IpuW8pALgL52Nmno/05HKd
	9PgJJ+WLUwXmeIWkAafoXMpaWqzB7D3pvVyLLwqqEBuVPVa9y9V1exgnIVi7NpY00ANguXlhEcT
	QMCmm0Al70AP3kAA8ofnLVMnYlyhbmcfGCgy+0vHFDRBnwoUZ4LDqpUTt7R9msypAuFt1aENMtC
	DDYnT8lMYHwOqKkU3Zf/8MS2wIxW03a2NVYUaozsfnvWWJ6uqaZeaN2pYrNz1R3kqjAqa9jjtop
	8pAtpCjBk7wBb65RXj06rh0Bi2s0OsU/LrGettxzOXiHgUqYgn884ZFN1vUVGZekhzofnLYX+kW
	gkEbYIDEwzKQ3fm/F7cStJfg00NyNj6ciu8qLNNu8kFUM6E1Mfj0j4R1ZI8F/6bWzrflPFL1tcc
	+IkyS4wNNC9kQAROSbIW2qst0YP3oeEtjZzmYCkkHK0kBM1S/3XuTzcrfPdlPLZ4uxts7ys9xUx
	k/n
X-Google-Smtp-Source: AGHT+IEWVZYQ8lk6IQf52JHiGPxrpr8Q284VWMHkb9uVCVKUcR2pu1tyaMveNJwRhVGLXdOooxZcAg==
X-Received: by 2002:a05:6870:1683:b0:3f5:4172:1f with SMTP id 586e51a60fabf-3ffc0c3ef05mr16045999fac.56.1768323018402;
        Tue, 13 Jan 2026 08:50:18 -0800 (PST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de539bsm14089689fac.4.2026.01.13.08.50.18
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 08:50:18 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-459ac2f1dc2so4483057b6e.3
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 08:50:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTFJQQNoNov+khXDwVJTZsiQJagvdnq9rqxb4zUHvrXJxat/pK+fTTDDs98PgWRsuWF8rvtBlAAZv6@vger.kernel.org
X-Received: by 2002:a05:6830:2e04:b0:7bb:7a28:51ba with SMTP id
 46e09a7af769-7ce50a6def5mr10521137a34.26.1768322616531; Tue, 13 Jan 2026
 08:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112174629.3729358-1-cel@kernel.org> <20260112174629.3729358-9-cel@kernel.org>
 <20260113160223.GA15522@frogsfrogsfrogs>
In-Reply-To: <20260113160223.GA15522@frogsfrogsfrogs>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 13 Jan 2026 11:43:00 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8LGZGGAQ3XLMQg8=XmJjvvJNShT3zkE-o2t2fv=VGeHw@mail.gmail.com>
X-Gm-Features: AZwV_QiAh8VN4kaDD2E2Q52MaqDS5cW88U1qWaL9kDfC-E_siYu-7adEi4A7eM4
Message-ID: <CAEg-Je8LGZGGAQ3XLMQg8=XmJjvvJNShT3zkE-o2t2fv=VGeHw@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] xfs: Report case sensitivity in fileattr_get
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, vira@web.codeaurora.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, 
	anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, 
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 11:02=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Jan 12, 2026 at 12:46:21PM -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > Upper layers such as NFSD need to query whether a filesystem is
> > case-sensitive. Populate the case_insensitive and case_preserving
> > fields in xfs_fileattr_get(). XFS always preserves case. XFS is
> > case-sensitive by default, but supports ASCII case-insensitive
> > lookups when formatted with the ASCIICI feature flag.
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>
> Well as a pure binary statement of xfs' capabilities, this is correct so:
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> [add ngompa]
>
> But the next obvious question I would have as a userspace programmer is
> "case insensitive how, exactly?", which was the topic of the previous
> revision.  Somewhere out there there's a program / emulation layer that
> will want to know the exact transformation when doing a non-memcmp
> lookup.  Probably Winderz casefolding has behaved differently every
> release since the start of NTFS, etc.
>

NTFS itself is case preserving and has a namespace for Win32k entries
(case-insensitive) and SFU/SUA/LXSS entries (case-sensitive). I'm not
entirely certain of the nature of *how* those entries are managed, but
I *believe* it's from the personalities themselves.

> I don't know how to solve that, other than the fs compiles its
> case-flattening code into a bpf program and exports that where someone
> can read() it and run/analyze/reverse engineer it.  But ugh, Linus is
> right that this area is a mess. :/
>

The biggie is that it has to be NLS aware. That's where it gets
complicated since there are different case rules for different
languages.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

