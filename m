Return-Path: <linux-ext4+bounces-10638-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179CDBBE27C
	for <lists+linux-ext4@lfdr.de>; Mon, 06 Oct 2025 15:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C56F3BB8B3
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Oct 2025 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6062C2AA2;
	Mon,  6 Oct 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WADEXV5y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B512C21F7
	for <linux-ext4@vger.kernel.org>; Mon,  6 Oct 2025 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756602; cv=none; b=Ie7PsQ0hevJEGa3ogJhwacPDpxkuFOl12XZXf6IfRwyzt8oPU0FxLQEAZhxxlhcxoGHQBMo3x2TsN4TYqkBt5JkKx+pEXT1N///HreLaCl/pXpLl1BcQF/T8+5ubolmkvc7qEvBngIfZciEiUeOUCP76fBxm/46zI2fQKtLREj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756602; c=relaxed/simple;
	bh=9RiibcQ8hYvWrHwNJrsOBQZBaxnayLS0Ew1MmhtqWo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aggZ8D7zL0/5zKXaBUJE9Gu8PJcR5E0LwQGLGkKMNIXvXjwaGEiocq6PVc/Z64HkLSZP7FWsbtR6uPFAB1NpV+5KOj00qxs0GvTn4eBIYNNfcgxWVbrlI4zkVS3zuOzCZlZNtBE1H0xqMvOw5sHFWSIcjqeJ0gXhU0o9aJ6XhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WADEXV5y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3e9d633b78so649743366b.1
        for <linux-ext4@vger.kernel.org>; Mon, 06 Oct 2025 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759756599; x=1760361399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yONkX6le0asFqe/FiMMLWvsxiXDZUAvFOOTqPAZxMYs=;
        b=WADEXV5yL2pC5NDHItmncaXGE0hSdlv5UmaUabVz4OMowbUupEA2eTTd1Uk3iqDpiF
         FEcLPKLKFnOS5py3TFC9kWn3ztjBCuztlFmOEfacKAQttpJJQxc/xbeAn65EotLasYzM
         sj8ai6VFZM947QQLp/mb+TyctQSb5Hchyz6+CiRLDsghMTeL5f/FpjefA3x2Ppw3oBZw
         Dp9PngFT4H8gkJp7Aa+ZXu0H2UAovDLOJlmufZsREgxIA7sA6pPxcgNTwUgwQxyKXSvn
         YJr02dz1QtQaS7yolIBlYpluGlBpvbkCcVAxyhuHgXGCdi9jTWs+D6PmvrU/3U3IxJ1b
         oqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759756599; x=1760361399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yONkX6le0asFqe/FiMMLWvsxiXDZUAvFOOTqPAZxMYs=;
        b=sZAJ9iizbI+OxLZUD1dOEJuhCq4cnHfYqCti11z60BhdC2/lUhQimYEkfuW9YgRFu0
         9F05iLVWfZG7kt1u5k8rdMjJ7ygmKOWBXT1152s7plzh9G0bZRVynnEjBtWw6q90GdQn
         trx8v/x+LFptjX6ySN1yU0DBwWn0ffB1kcgtgQCfNrD5o8EjEnfVWESIl2dtE51sQyE3
         VXmgCRNqBosVZiP3u7mGk6giMEKeA5uDOUyv7UWgkxEwf+8GlDGLUt74sitkIJ0HpYC7
         BLcecmtSr5g7fD1ZTItxa8knXdlxgi5w9s1iM6ZzAy2xuf5eFJ57qVBIxTLVvSfZnDxZ
         PupQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKmtgoh1P+WSL/ei2MOkC4biESvNCzeKteveBNVpQZTq+epRnJCTBn8C5YvCfoo47Yl04cnPxzEsEx@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJqOdEKy53Rdgi0zSiQ/EWLLF379cOs1wvM2cGBkbmU3ro6yX
	JZICsKe4ZYnt8A8r+EuHFCYGH9aUPtjl3xKR+qlLIfhj8ATi0oGMgFaADbdvLM+HSPivu7nYZo/
	E2Eenih7Y2/tLxQY+EwvQ+fs5BWsfWCA=
X-Gm-Gg: ASbGncsHpfQcmtP72KZuVofjAZ3NnRuBzKuqaaXhWyWefpCU2ySBGHoZTCxZOEAyNd7
	dVSQx0zxmH0cv547nhCchW6p5fMqnoQIuq8mfiL/P4cUNxlJ3oandfNDUzteZzoPRvONd7ufsRo
	1fKTLQVrFyynZgOJjxZRKtE33+6PpwXe3E1nmKGDGofks0FSy56wdKxAi2ATHk1MI/rKqeRXjs6
	tm6/VSKqEcaQ1dogJYJ3Px45VGEjhL1Yi6rTyaUkAVUqiMEZPkjJI8iAwXnssaGq77wVd+Nqw==
X-Google-Smtp-Source: AGHT+IGgfaKILwiIYhOJauD31uynKvUTNQB8TM3B4u9+8sn3XNc0LxMTwvmUPPVqZHvJq+WHY2tARoUrXupUK50gMkY=
X-Received: by 2002:a17:906:37c5:b0:b4a:e7c9:84c1 with SMTP id
 a640c23a62f3a-b4ae7c98631mr906398266b.7.1759756598374; Mon, 06 Oct 2025
 06:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923104710.2973493-1-mjguzik@gmail.com> <20250929-samstag-unkenntlich-623abeff6085@brauner>
 <CAGudoHFm9_-AuRh52-KRCADQ8suqUMmYUUsg126kmA+N8Ah+6g@mail.gmail.com> <20251006-kernlos-etablieren-25b07b5ea9b3@brauner>
In-Reply-To: <20251006-kernlos-etablieren-25b07b5ea9b3@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 6 Oct 2025 15:16:26 +0200
X-Gm-Features: AS18NWCEM0fjjZM6zlyL8ddYZ6bYQjBB781Tu0JzfRDs6qIJETdk0ZVa55ZRAIQ
Message-ID: <CAGudoHGZreXKHGBvkEPOkf=tL69rJD0sTYAV0NJRVS2aA+B5_g@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] hide ->i_state behind accessors
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:38=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Mon, Sep 29, 2025 at 02:56:23PM +0200, Mateusz Guzik wrote:
> > This was a stripped down version (no lockdep) in hopes of getting into
> > 6.18. It also happens to come with some renames.
>
> That was not obvious at all and I didn't read that anywhere in the
> commit messages?
>

Well I thought I made it clear in the updated cover letter, we can
chalk it up to miscommunication. Shit happens.

> Anyway, please resend on top of vfs-6.19.inode where I applied your
> other patches! Thank you!

I rebased the patchset on top of vfs-6.19.inode and got a build failure:

fs/ocfs2/super.c:132:27: error: =E2=80=98inode_just_drop=E2=80=99 undeclare=
d here (not
in a function)
  132 |         .drop_inode     =3D inode_just_drop,
      |                           ^~~~~~~~~~~~~~~

and sure enough the commit renaming that helper is missing. Can you
please rebase the branch?

