Return-Path: <linux-ext4+bounces-7217-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E71A87003
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 00:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC83E7B10FD
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Apr 2025 22:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC761C84C0;
	Sat, 12 Apr 2025 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IVyWo3eo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2333DB
	for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744497384; cv=none; b=d+XBpT5hKepHq/rVm8XAIDkhxAfYMQJDOh0nO1fMarWJr48BS17KNsLUDo7CwLKkJ2DJDAF1+Otcj/L9pomz4ILctWhzwTiFQ1kh63Kmqr7bK9oS7XXVsFK1lddsia8P30a4YaISL9zQLWouAfS7dqg4BxMBW2/IVeVbvkrrM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744497384; c=relaxed/simple;
	bh=WCcnEaGnErt22gwtTCSLCZCag0tD0wwfK8GeevMTpco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9xZLuSg0pwROcqcPCAefFmdfEXtVn2ZyZ3NWuS54gLl6iGnj3dA/ksgfsT60SPw97bdM2X/8F/NbcrBIKxpSE+VCirN9OQtG5SQnjkx+8FLaJufl0Xeo9Qs8b5K8Yhz2PWEgCi46XKGyimOOLQZpgS19a/ud9hGAGK1G0mDXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IVyWo3eo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so618264066b.3
        for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 15:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744497379; x=1745102179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jX1PlPChRu+hkU1daePKyzTiusOmrXQ67aQ/gDwc+Ng=;
        b=IVyWo3eo/074EP5MhKk17k7FP3pFaYbMhXGIwqcRPzzkBliz0apUxYEzAkg5FlYSSo
         SMtJdCXmoSWhsAHxl1IqEmvha2M2YqhFfgbBn25Mf4c+wPWss42q5DncK0f05jFXDtyO
         upzgnqfIG4WvnLu6ndUInxxDzDH0CD/hecOA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744497379; x=1745102179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jX1PlPChRu+hkU1daePKyzTiusOmrXQ67aQ/gDwc+Ng=;
        b=GU7YE6/Kz8da83PWYUzTm3lO0BzWnJtNZzB+a4/pk9JHa4+/6/GOLz80UNlPBXjB9E
         0AhlkYAqG/gUVig4Ws2hLy/odWcvupPR17kI2YCkj+wnz0RZ4Hzl3i0CaxslgfRTYgZ+
         KPw31bnKzhUjjCq5aSE+uE7bj4pIortsoJZWXqidKcw2sAKVKx24M1FNvEigYkBCrvwU
         J0bMy6/m9PM5zmBlw7mKEHQxwlz11N2yDLS6O1a4ZkDIURWm6HnHW/z8puVL5HlpSVFk
         nRXLpW1buWZtnUcQO33kBffhXVOup1WNMXdORvxXgmmOG5a5a2bMZtdRZ60p9fbRSSfm
         HLgA==
X-Forwarded-Encrypted: i=1; AJvYcCXgOP98m7RuW+cPkk6XPMMgDCh1fqbVpGY5YL2ir29AaJOtyc4PvtybVOUu/zXXvKzH8fl11EV3FN9e@vger.kernel.org
X-Gm-Message-State: AOJu0YyerKcxReblJBQLrkc0uKCMr+qt9cXdTUsdBlVWVqLsqrhYR22q
	u7zx59WA/B3//vk+sTfcPuylHdMtTp929rS77Ex38H5WOPmthu4MdK9yWvb1g0AilXn40C7llQg
	fRME=
X-Gm-Gg: ASbGncvmbarewx1fjnsl+Q6eB+/eilHIPW0wZBmBe5IdV8ZkzdrhHThogH5O4vHMlNr
	mW/L41iy/H+M4d3Rk26j2CLy8uaHxZozkLnUlfDVUcoqLYv1B0GgVK5c7eOKLeGBwcfd1Q98uOA
	GtDsojQN4ZR8uLkpJGOMorVmDUQmht8Rjy3z/eHekCmMje/12JT0M3xEuIqEM9kaFplmmMmGb+P
	p5S6RpKUiTQ28XcuV5FmItmprzyZ8gcJN99JdWyib9mmpHiYmcIVkg14ua5Igk+ENIwfwpxYlHr
	wfxNXkU3ek2WG6fP6u21yWFp8VRRgAQ6uBKq1JuA6Ca15XvKON23Kf6/4c89h8pz4TGGeG74MQV
	B/prC8SjvRDHqOxw=
X-Google-Smtp-Source: AGHT+IFhLvf9Q8J4qdCT9pro5LHDVDax0hJ4og+hRStbR2mwHeOTeDUwvwvQSIrs3JhJaerXTXhdJA==
X-Received: by 2002:a17:907:3cc3:b0:ac2:d1bd:3293 with SMTP id a640c23a62f3a-acad34a1858mr664235366b.19.1744497378716;
        Sat, 12 Apr 2025 15:36:18 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce7042sm639898166b.165.2025.04.12.15.36.17
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Apr 2025 15:36:17 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so618261466b.3
        for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 15:36:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjlxuWdIKtkgIHTYfUvr34Eiq+yNelG/sCpA1gEHCfMZdPsgtiHj+PteYl5RSXRBPdLTTeefojTFs/@vger.kernel.org
X-Received: by 2002:a17:906:6a07:b0:ac6:da00:83f4 with SMTP id
 a640c23a62f3a-acad36c1cbfmr628750966b.53.1744497377143; Sat, 12 Apr 2025
 15:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner> <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com> <20250412215257.GF13132@mit.edu>
In-Reply-To: <20250412215257.GF13132@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 12 Apr 2025 15:36:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
X-Gm-Features: ATxdqUEK5hSoCq0fceztzyq2OA_Su-uY2GQRpxFeTK4CRtjiK3zYuE7qtEBD8PU
Message-ID: <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Apr 2025 at 14:53, Theodore Ts'o <tytso@mit.edu> wrote:
>
> Linus, what problems did you run into?

So this is a resurrected thread from November last year, and I have
long since paged out the exact details...

But when I did basically the exact patch that Mateusz posted, it
didn't actually change any behavior for me, and I still had roughly
half the lookups done the slow way (I also had a really hacky patch
that literally just counted "has cached ACL vs has not").

It is also entirely possible that I messed something up. My
*assumption* at the time was that I was hitting something like this:

> tests if the inode does not have an extended attribute.  Posix ACL's
> are stored as xattr's --- but if there are any extended attributes (or
> in some cases, inline data), in order to authoratatively determine
> whether there is an ACL or not will require iterating over all of the
> extended attributes.

Indeed. I sent a query to the ext4 list (and I think you) about
whether my test was even the right one.

Also, while I did a "getfattr -dR" to see if there are any *existing*
attributes (and couldn't find any), I also assume that if a file has
ever *had* any attributes, the filesystem may have the attribute block
allocated even if it's now empty.

And I have this memory that some gnome GUI tools used to use extended
attributes for things like file icon caching purposes. I didn't even
know how to sanely check for that.

I assume there's some trivial e2fstools thing to show things like
that, but it needs more ext4 specific knowledge than I have.

                 Linus

