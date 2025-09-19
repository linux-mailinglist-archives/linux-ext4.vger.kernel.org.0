Return-Path: <linux-ext4+bounces-10296-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790E2B899C8
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 15:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A12177A8C
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CEC3081AC;
	Fri, 19 Sep 2025 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQIPISGy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EF2ECD1D
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287372; cv=none; b=WQ7J1iubHEwV9MRY66LEQyuDpa51MpHc/lGgdNnGo71x09opqrJTVIL1w1XZEcRQlcp1lfJw1xlWftOfMnP1sqP0VwT1TZtMbtBF6tr4WLHcNjXM+BJy8ULIsksptJ5QKAHWmHAXfrlFM9qykKCYwI0i9CyzyLOWEhWuIOcNVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287372; c=relaxed/simple;
	bh=H2nghK4bl/H+DNUfQhtZLwYHG07QNLlFwkEd9mrXbhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+m3G31YQTckIkNrMaD3O6FFEFlzy4ewvk74BPUHj3CZKWX/JOcM5nQer3cCvuEKUWh1/usBnhG1/KwMQZw9Khh+/cUbOhsZPdlZmq1bkDlPtu/T9CyHUZsHSzCey8/DkZNZn/o1pePFewSZ4zgQVoMikMNblj/Fv6msurV2c70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQIPISGy; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f2b27a751so3786189a12.3
        for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758287369; x=1758892169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2nghK4bl/H+DNUfQhtZLwYHG07QNLlFwkEd9mrXbhQ=;
        b=BQIPISGyaL9K2DiFORwYXbLp0t2u4Qq7Wi9F4RNLMuSVpyK66tSAoNsyEIYswqWV26
         iNyNMFsvPDMLcyCx5Brope1KQRqcyBHMz4yssiys1snjyeR3l1GIcRFDsIjglAi9HvWj
         IlBVLk4wEYQGTNNyUT7TeWjslzh1k5HuAp+0Qpsn5AsZ2NW8Y5UyHSzN70Zer329AMnZ
         n996bHOKl75/nauI8STW5nkufGGR6s1xIt3boi1DFvvYhV32fAvcCtgJqEW1NhPtORuX
         wm9IS6roqrijLmO1HE8RXHPiymNGhW+W2wOGR4/VZPeKOGA6ByVNxAJRMbvc1aw+r+Xm
         q8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287369; x=1758892169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2nghK4bl/H+DNUfQhtZLwYHG07QNLlFwkEd9mrXbhQ=;
        b=tq3LN1dKRSFEoVl3IgFTflAjkBF23YHRgkeSU26vdld2z6pk4nBsO1K+0qBZU9YmlI
         ZzXrTl0GHDwYvxaGGVe/+2mgwlWVeiL2DEmzkTNkN73qygAdqe0jbCIS4hyl32CNk5qb
         CLAzmGHCJhR6o9gUeijIuFFJMcfTqib2qWtPJi2O+6sBk1vtr4lywWPEESx2nu/XgAQz
         HfEwn+Carh6j/47ZVgmmzYxGrgkyHZZVmXcXl6nEb2u598XCFHw1YnZfSe4tVk2jGHTD
         nuLtsqKGSpFWSIUHZVVpqu6MUnAHls805zdDEG4zBtylz0SuYtP4bxjgM93sRPAJKRv5
         xB5A==
X-Forwarded-Encrypted: i=1; AJvYcCUnKn8X5zUrrXIZ/DoNay36GfLzwRcPr4/utnp3h3R2o+kzIVv4r788bgQ3k0GNgK+Bo2A91Y1DTygy@vger.kernel.org
X-Gm-Message-State: AOJu0YzkU9gZKwiPts9l6x+Xm71Cx8vtxNhfbUBokU2Z3yBMzVpcvU3A
	SBSr8HknEXmcFi9NeQSQJ/RXGU1connEVyTZ+A3yfCu+AOHUELLN9HPj/2QabUfzo4dJOGlcZBJ
	lr5+KBAXZVYObbXZ1F03AQ2OBGX78RQw=
X-Gm-Gg: ASbGncuw8tJDuewKFLDPbpTIKitLxdNayDuu+xst1v6+pCuZx3CgFohlSQGDysr57rT
	3WiIsEnl4OFcuIpjkBW//4qvdo4arpUGo19Nu4fSvQXb+Ujj8j2qQy2KOXnhijAVV7b111082M/
	Vl84PyIPgltALD83YjGzTNi5srEdRYdhtnV+7/mqIHMhn0XB48oq2TrdQAxTdtyVkNFTLDZ5yaV
	f0SglecI5KVWTylEpObwHNR6jhz7yaeHCQlrVM=
X-Google-Smtp-Source: AGHT+IFApfhAHEjMUI5U299k57YwKnPsMN/Ik0b5HX6lVlpdtHbeIxsd1Q0r+GQz5I22vbwNy4Ut9U4zuDgZ7sOE0qo=
X-Received: by 2002:a05:6402:5343:10b0:62b:2899:5b31 with SMTP id
 4fb4d7f45d1cf-62fc08d40ecmr2418056a12.5.1758287368510; Fri, 19 Sep 2025
 06:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916135900.2170346-1-mjguzik@gmail.com> <20250919-unmotiviert-dankt-40775a34d7a7@brauner>
In-Reply-To: <20250919-unmotiviert-dankt-40775a34d7a7@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 19 Sep 2025 15:09:16 +0200
X-Gm-Features: AS18NWD5Om8yGekTULVtEvApOLHSTiZijG74rmoXqBK7CgJeOnhoxL1KEl8c09g
Message-ID: <CAGudoHFgf3pCAOfp7cXc4Y6pmrVRjG9R79Ak16kcMUq+uQyUfw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] hide ->i_state behind accessors
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:19=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Sep 16, 2025 at 03:58:48PM +0200, Mateusz Guzik wrote:
> > This is generated against:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-6.18.inode.refcount.preliminaries
>
> Given how late in the cycle it is I'm going to push this into the v6.19
> merge window. You don't need to resend. We might get by with applying
> and rebasing given that it's fairly mechanincal overall. Objections
> Mateusz?

First a nit: if the prelim branch is going in, you may want to adjust
the dump_inode commit to use icount_read instead of
atomic_read(&inode->i_count));

Getting this in *now* is indeed not worth it, so I support the idea.

