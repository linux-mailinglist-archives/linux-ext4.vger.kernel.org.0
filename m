Return-Path: <linux-ext4+bounces-7633-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B01AA7C2A
	for <lists+linux-ext4@lfdr.de>; Sat,  3 May 2025 00:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8331747F1
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F62C215F6C;
	Fri,  2 May 2025 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/i2C2Xg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D51E32D5
	for <linux-ext4@vger.kernel.org>; Fri,  2 May 2025 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746224796; cv=none; b=hU/TOoyUW2Py0A4UdTiW6TYnu0szbAj/P3+fze36OB383qHXJupkW3xGyET2QN9WgQlkWNKyneS6zGK++3QRVgoaflkO6QGkB05kvODYMqkaNpsjxcQFJTWTyTZCGtF32T5/HpZzbxUVutF1s578d5PwqZkW0IA5inkF7ZPdRP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746224796; c=relaxed/simple;
	bh=CbaXCZ6zuC/6U11jWLzYXpjqcT8e3TLhJ47B5Oru3Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsBWrhBjmjOAZ2eZJa/13hbcdc5mfuAKZw6SOA9t+Jyd3GglINtu5jmqhajJHKcfYPVXcsTSNQsHw3NIhkPl+YSXe+UyWa0/I4e0lljgmdBaDRhXOBQPeJtfYEQQjfU7xznG1MmZK4Pz+eLdh36gCIuGoNGLZKiyKLpVdrXOlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/i2C2Xg; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2d54b936ad9so1236319fac.1
        for <linux-ext4@vger.kernel.org>; Fri, 02 May 2025 15:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746224794; x=1746829594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLd70+9D2vmBiF0PdpzaOpgsDiIXN+L7WedXVQd8iY8=;
        b=I/i2C2XgTCS4wuY20Bb5F8zxtTQjoklm1XV2TgvjWGu2YhMnvFgkPaoYw3NVmUts8k
         WJcl+vyD3G4BHb5GBbtvG75gV6JalaTSCUlJDS6B3Vz0s8RXkP8PNuWHzq1iMGTQNDph
         JpL929MI+CuoCTItb0vSLtTHlA7ibBZrS08b4Mx1+64DAUfDDmgCfwL7yr0uSZ7gNkZL
         /9T9y1bW6fjaRIGAtlG09bPG4PjIDJ8uIr4yoXmK/6ndAr3m6rB8nAvAd+o7/hh82w0T
         q8PZ1oyEXjRbZJVZyP4qSD2HcDm5EG2fS7Qvapw9wG6zuU6beRZSPdgmWCDw9Lw5Gtk/
         BmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746224794; x=1746829594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLd70+9D2vmBiF0PdpzaOpgsDiIXN+L7WedXVQd8iY8=;
        b=jaquc8abswgH1zZyVNcfwr7RpZNKK7yoeSDHkZ62g5POejPmyLKoy5G471Fywrtdd0
         LQEMsYeJQ8ZhlqFkrjjup0ks1nypsfyAGi1vdEKImVxrsK6bTfEloae0FMmkO3UBbQLi
         X6yh90jh+crtP4HphC2FNSkSlh4i7cdOs4wlGhi0KD0rBlalrxKXfwRiVrnX3Vkltvv8
         U8I3oxPLplpup2TayzmiBgWiAcwA6DMQB9v0hnS9l9+SW9C/MzZzAK4ywaDQFByxYk7z
         mc6HPe0jVMoc8I9PIAm0tBj6/vwYSaAGUyNzxGw/83rz2hJ4CSaQuxkZ3MiMSem6MsI4
         pkCw==
X-Gm-Message-State: AOJu0Yz9JFELtp+/QQY9WhVBj8qW2lZe7YqzuAtWpaGQWrtDVdeRZzGx
	K/Wp1bmQuLqei95W4SMPe43GrZm3Nhc1w/MmrKPVLhMl7UTRraA1nFyejhbjf80oKdX7Ht357p2
	mvXUIDnR903G8KTJtpEJ/gHOWbKo=
X-Gm-Gg: ASbGncvrPMabwIzfuCHud6sScGPuYw4YYaV0az6UwHsfGOqP1U2YRE3G0SUkbJxq3l0
	w2ZTksWT/xkeut3aU/BtutAET/7iBx3CPsnHyPzwr7oJSa0F40VpuvEJGU+KCE9QoQGXTS05iZ3
	dMhph3bz1NZ2bohJy7jLeAZg==
X-Google-Smtp-Source: AGHT+IFbot1rEV11jEsJO+4PZqXtHgifikzARcPShT2j3bziFa54/6igrbadAd/fAFza6EHPD6uUHybpENtzA+eWr9o=
X-Received: by 2002:a05:6870:c0c8:b0:2cf:bc73:7bb2 with SMTP id
 586e51a60fabf-2dad6938903mr527947fac.14.1746224794391; Fri, 02 May 2025
 15:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502174012.18597-1-bretznic@gmail.com> <20250502203742.GF25655@frogsfrogsfrogs>
In-Reply-To: <20250502203742.GF25655@frogsfrogsfrogs>
From: Nicolas Bretz <bretznic@gmail.com>
Date: Fri, 2 May 2025 15:26:22 -0700
X-Gm-Features: ATxdqUFJnbSm3_rzV0eLNrbBe1R4vZjkNARQVZ8a5tPElBQSv3povAoekeS6AKk
Message-ID: <CAPXz4EO8vbVxksgftCaSXb3UgWa_oxrsiYVCkOQTz+4gYZ5k_A@mail.gmail.com>
Subject: Re: [PATCH] ext4: added missing kfree
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz, 
	adilger.kernel@dilger.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 1:37=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Fri, May 02, 2025 at 10:40:12AM -0700, Nicolas Bretz wrote:
> > Added one missing kfree to fsmap.c
> >
> > Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
> > ---
> >  fs/ext4/fsmap.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> > index b232c2767534..d41210abea0c 100644
> > --- a/fs/ext4/fsmap.c
> > +++ b/fs/ext4/fsmap.c
> > @@ -304,6 +304,7 @@ static inline int ext4_getfsmap_fill(struct list_he=
ad *meta_list,
> >       fsm->fmr_length =3D len;
> >       list_add_tail(&fsm->fmr_list, meta_list);
> >
> > +     kfree(fsm);
>
> OI: UAF, NAK.
>
> --D

I apologize, it definitely wasn't my intention. I guess not really
putting my best foot forward...
I don't yet fully get the UAF in this instance, but I'm studying it.

>
> >       return 0;
> >  }
> >
> > --
> > 2.43.0
> >
> >

