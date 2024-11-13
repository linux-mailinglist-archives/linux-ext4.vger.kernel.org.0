Return-Path: <linux-ext4+bounces-5125-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C2C9C6635
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 01:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C267EB2E67E
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 00:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62C1DF71;
	Wed, 13 Nov 2024 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EoE+xZvU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84807AD5A
	for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731458344; cv=none; b=gtbtqNElRpk5rX4z4BMDe/g5Se4Talt7XL/iKzreMaWTAE0b66DkrGXIX3plLJ1sZCxtw1twy4gCV/XHPiWmwhjJpILA636jnEbdCvqd95qBecNWxkSGkQhZDCK3r1ss4dZ9GrJveMzYxURuFk6ru/cMjRJMnHaow679PGz70Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731458344; c=relaxed/simple;
	bh=YpobwbtA2+vKxtJu8xZ2FUyLg/btakBlHfnLUEUx69o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5u00N6PUmVkoig6ZOHXBFPxi5TCViETnYeO3px/Mht8ocEhT6CyATK86a8Zkik0PjPMONkgH4gNU0zFE2suGoYCUIS38mAOfDdyPcOUuRy9NmX68QnsPyaKG6eDEy87gOkPPpX5a3VWedaTjLamKaOyyZZDxS4J3HyMWWlnvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EoE+xZvU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cec93719ccso8160625a12.2
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 16:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731458341; x=1732063141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HToIlSDY7cOn93fCLokqkKx9Z4UBbjM0FNxhpulJNm8=;
        b=EoE+xZvU6EDOKXSvsLLNaZJ9RmD6Fffex02A4Q4C3xXlUTc4oliTxpO+AKHeBUY130
         Od7ENT9349yuehtel68hjw6V06589TZmNnXGldpmdruBp02OUtC0GcAtx3KKQPc+XgOY
         w/yuR6jLbQux+QGscVnFDgk7Swp6D9d4z3ZL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731458341; x=1732063141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HToIlSDY7cOn93fCLokqkKx9Z4UBbjM0FNxhpulJNm8=;
        b=TwYo8WlFZiFncrW6U43MmiS7Ha1zuy1VcHsCr11VhW95yvcF4VfA5GyLLQhDjcYd8c
         RSP4gbxcw7nvuJCGIdNEYm6dZYMV3JgScEipPkuoWq3js7nUUS2JRVCRVLhbj/NhSxrT
         HTFsjC418IEk0lIUuw0KbX9SNpKTTtrMLWwkGjtMWzEQeWbTXqzaCWp+HUdc/8nD0mLg
         WY6ASRKxdKmd/QaKrQUshj0XRBsmpTL0a7Y9GzheWsx1maULujs0dphTkyu1+cocM6oX
         EHYR7pXReoUMm7MCuC4uYh6bplLITW2cTELiLfEJeRpoDrVeB8oy9CZk1xsBjfhq/vvm
         b3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCV/BxpBkm66udyGV+g57JSvtnMLtVmBM0tiA4JtTA37qL6Q+fShXA0jMzfK61B8kXpLwt8TTjRRBih0@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpAJZ91egtdMIJezEU8YUAyuoRqEhDuABbjh00KRNV8AMF46h
	a1lOyS5iLt+NsJtZdJPpfINLD3MQUlWSpCYYALo+2DpMG0bp5oriYuVUAJi/1VkoziLxCoj8Aqo
	06ER7XA==
X-Google-Smtp-Source: AGHT+IGO7bvche1xKoGTjQ1wv/TqBpHHvfFgw9Ufvlc167YcgJ+s1Od4dt8VP/uc8L7rHTjTAaXk+w==
X-Received: by 2002:a05:6402:50cf:b0:5ce:c9e0:aebc with SMTP id 4fb4d7f45d1cf-5cf4f33654bmr3595274a12.1.1731458340753;
        Tue, 12 Nov 2024 16:39:00 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7c90dsm6817502a12.80.2024.11.12.16.38.58
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 16:38:59 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99f646ff1bso938835866b.2
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 16:38:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWv0mUIetCW/an0RmKyCa4rOXNlNEpz3R6QpnEX0S0hjfdB9RVrnh9gWk9jbxJ+4z+fbZxX5gdMv5U0@vger.kernel.org
X-Received: by 2002:a17:907:1b0e:b0:a9a:1792:f05 with SMTP id
 a640c23a62f3a-aa1b10a45a5mr487896766b.31.1731458338247; Tue, 12 Nov 2024
 16:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
 <20241113001251.GF3387508@ZenIV> <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
In-Reply-To: <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 16:38:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVzOQDNASK8tU3JoZHUgp7BMTmuo2Njmqh4NvEMYTrCw@mail.gmail.com>
Message-ID: <CAHk-=wgVzOQDNASK8tU3JoZHUgp7BMTmuo2Njmqh4NvEMYTrCw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 16:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Nov 2024 at 16:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Ugh...  Actually, I would rather mask that on fcntl side (and possibly
> > moved FMODE_RANDOM/FMODE_NOREUSE over there as well).
> >
> > Would make for simpler rules for locking - ->f_mode would be never
> > changed past open, ->f_flags would have all changes under ->f_lock.
>
> Yeah, sounds sane.
>
> That said, just looking at which bits are used in f_flags is a major
> PITA. About half the definitions use octal, with the other half using
> hex. Lovely.
>
> So I'd rather not touch that mess until we have to.

Actually, maybe the locking and the octal/hex mess should be
considered a reason to clean this all up early rather than ignore it.

Looking at that locking code in fadvise() just for the f_mode use does
make me think this would be a really good cleanup.

I note that our fcntl code seems buggy as-is, because while it does
use f_lock for assignments (good), it clearly does *not* use them for
reading.

So it looks like you can actually read inconsistent values.

I get the feeling that f_flags would want WRITE_ONCE/READ_ONCE in
_addition_ to the f_lock use it has.

The f_mode thing with fadvise() smells like the same bug. Just because
the modifications are serialized wrt each other doesn't mean that
readers are then automatically ok.

           Linus

