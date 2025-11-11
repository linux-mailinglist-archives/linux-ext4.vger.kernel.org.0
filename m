Return-Path: <linux-ext4+bounces-11763-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEE4C4D41A
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 12:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F37E18951F5
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 10:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8838B358D0F;
	Tue, 11 Nov 2025 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpaERnuM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3643E355035
	for <linux-ext4@vger.kernel.org>; Tue, 11 Nov 2025 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858294; cv=none; b=dLZ08k3ptu5D0GuXHaX/N1NTnZTKPk796k1A+nwvhW47P5Z6tmHDqyi0My9IGRGIc29fxsi8pFKKl9/eUfmXF/jlhV+8ZctLwfbMHUxIq0qXA+N4SAuJd5muBE0ZE9NyAbWj+KZPQD2wE3F9f/2f3+52iFuI6zXyQb2Nb+56Qdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858294; c=relaxed/simple;
	bh=vPr1scoxGtbmI1TsSsArbT+P8jwt6C9MLoZFTdOfUEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ravna8fg6U+Jnl4vKrFm1cEBReFiHqhaeslhvQhId5grnVhrUy4FBWsFYzLMKErpfiV8eGae1yjpZsNDprHxl16wC2fW9EeLRt4w5YJy4c/7WlH+WeXhwHKTXuvUfk9f+aq0tWdrbtXG8/EzyUAebBk73mVanQd3/GCj/aPI3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpaERnuM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso4178150a12.3
        for <linux-ext4@vger.kernel.org>; Tue, 11 Nov 2025 02:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762858290; x=1763463090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyRA6gYtZbT9Mw3sUgTpl2KwYTBM16vhFluIQHKp75o=;
        b=QpaERnuMTABIskdkD5nmVq7dv34QFBIgaFwvrvRl9fVlr1DbCtHz5B1oHoz4bL2ieE
         JoQvn992ASDqXAknpRQOKOICUcW63r/nsl5ThTnTVhDFsvudLTejokGkmtXn7O4uc8gc
         QuyCVll6QY+hPt61DjQBFSBbBpPdXEI9AJZs82IdRe0q7cs9Ygz8xhOY+UkWJYE+hAx7
         NofMT2tHNoEj1l0Bygb7UMR97Hn4dc076EInKbbJ5qY+GbzsQZLofHEMa/MejlsuPA34
         yiddEybSXJN7Gnm/Ar+UljD9gkYOjb79ECQi8q8RqxRmSvUx1/mZvD2JU/WypfTPC8zO
         0tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858290; x=1763463090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JyRA6gYtZbT9Mw3sUgTpl2KwYTBM16vhFluIQHKp75o=;
        b=VesenYRBlMhb8KrJuxUt/u4gTg0cJlRIiBZ1xbzX0LRajNkuB4YNmbO5TdK0TA7qUK
         pvBTdQ0Ki6w7CNlZi0Xrmz1GiX0g77tART09bfy4h7uLKbkLz9Mm+6HHLAgPO0fo+XiQ
         xZUOsrrU8Uh1VT/ChkLErr9FF2B9J56i4CoSKpIYs9LENwE3cj3PwmNfbHXOBm+6PcTi
         kFh9ZOfOOR0OzSpqJGwo0bliqT7JhkN1BdpYLfl+aS0S9+cptRnUA4QXQJt24s5Aw8Z6
         wj2k/Vfc7nRJd4Y3u1HJfjWkRipUVNyJ0SDHM0xCkaAkfPN4+n9tr9ZuvBPR2KNOVb8o
         hGvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNABTud2AAGlA+oW7Zce0oZT1m7+DDv5HC0c4Ehw8WZkCPc2jmdHIf1Vyll/OoE6f1AtanIUI5ejGj@vger.kernel.org
X-Gm-Message-State: AOJu0YyuO1phUPJxgDb5vabP98Q4gIEgZ5gSbTfJTeBrO/ZOdXfMlmDM
	Kk88eTpyDFl776lOJ/QXlKV/Yg23lF3ZanDDd3Xf+JdP4J3lKCNi8RZxDlipkpEazX6LxlqEjN+
	vljW8BfLF5D24w+Od5DEz8lmvPqWaZjk=
X-Gm-Gg: ASbGnctFaeo0lJfV4HTE6glhCqSUyynDf6rmXQpJHurBsXtiXtz2EtC49jnOUovwGuO
	uh5mzGkyuOqT8Z+cj0tkI5Ypqtea+ipZyusxlDKD5vyQUJLEw51AFGPTnb6eAa76lIwKcJ+ayHX
	YSKonbn035nsae6Tq2gR/TEP/ykZJ5dIAkYEzhqgGqrU8HGa5EB4y2bpSxvvS6e+m3BW9Rpvt/Z
	3bQmEwtb0tECF/z8EQ4KFORJfUINrUE4Y9+plX3mmPD/KA9eXY2mfaZU51eoGGJ9vM27ZxruTlx
	GYGej9sUbOzqtVr7wihexO/x8w==
X-Google-Smtp-Source: AGHT+IFP90bpnxcRJbh5J12wLzHjlkCHBBywRDplR18eZEpmH4Rt7zS3FsYlYjWxsSba+YDC3P23rVwO6aIRX36AZeo=
X-Received: by 2002:a17:907:a0c8:b0:b3f:9b9c:d49e with SMTP id
 a640c23a62f3a-b72e053f2b5mr1192133066b.57.1762858290266; Tue, 11 Nov 2025
 02:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107142149.989998-1-mjguzik@gmail.com> <20251107142149.989998-2-mjguzik@gmail.com>
 <20251111-zeitablauf-plagen-8b0406abbdc6@brauner>
In-Reply-To: <20251111-zeitablauf-plagen-8b0406abbdc6@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Nov 2025 11:51:17 +0100
X-Gm-Features: AWmQ_bnCfFeVSWAwyetntRCBd7NVaEKInyv2_DDSmZq9FVu_iIxSbOqFI30GDbo
Message-ID: <CAGudoHEXQb0yYG8K10HfLdwKF4s7jKpdYHJxsASDAvkrTjd0bw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: speed up path lookup with cheaper handling of MAY_EXEC
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	torvalds@linux-foundation.org, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 10:41=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Fri, Nov 07, 2025 at 03:21:47PM +0100, Mateusz Guzik wrote:
> > +     if (unlikely(((inode->i_mode & 0111) !=3D 0111) || !no_acl_inode(=
inode)))
>
> Can you send a follow-up where 0111 is a constant with some descriptive
> name, please? Can be local to the file. I hate these raw-coded
> permission masks with a passion.
>

#define UNIX_PERM_ALL_X 0111?

I have no opinion about hardcoding this vs using a macro, but don't
have a good name for that one either.

