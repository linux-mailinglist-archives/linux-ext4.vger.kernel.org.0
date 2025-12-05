Return-Path: <linux-ext4+bounces-12159-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42907CA6032
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 04:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA00319AB36
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 03:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DA6233707;
	Fri,  5 Dec 2025 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcwMuPKl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E11A2EB10
	for <linux-ext4@vger.kernel.org>; Fri,  5 Dec 2025 03:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764905481; cv=none; b=UI3vHcNH/WnoNGIgbZTuQsJNIplc00aGLgk6q76NZGHhJC4uZiJabXCM/jNjJi/vcUTNVU5scMgFSzjRuod0a/Avf/DgcDpIDzN6b8QF3jJyOMJiRukwLFB4fVGI4cx5JFL4UEi6b46sDA88pBET5dgu4qBAVf4CgvT9FVfe6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764905481; c=relaxed/simple;
	bh=3oywxBCJ5dV2/G3mmK+FHrltBPLLJYNzxLDfkDt2jmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2mUEicksxId2/U6VdJs53pxhkq0MySD9I6amtKl1uqlovYq2uCdB/0N/MimhZizNxa56y4wuId6/C4XsGxcbaLS1+on43HpzRzvr7ZwxPSgg6CeQN224IwFxaNBjTd8j682HdeAPJAWF7x/IMsJSJIDDgSl3rgO+0KlWZCAg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcwMuPKl; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78ab03c30ceso15815067b3.2
        for <linux-ext4@vger.kernel.org>; Thu, 04 Dec 2025 19:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764905479; x=1765510279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmirmDSmTdLnhFtilGhufp1Glf35pWJroSch58apqNk=;
        b=bcwMuPKl2D8RYrZggaH2jY6viqk23f2k5j4vtSWqVPPNFDr7hNIrhonRdnzhGtTwue
         EnKSwKWKKkQcnJvWzaEdGkdNqL67RpKVMwYLC5l54hyiiRHnvr39RnhbuhpzL5LE98nq
         rq8M8uC5JraU9edS0VQHJOgY741Q5nzrH57kpitW567wQeUspUeiMsIuaBSOIZE4G9Q7
         Y15r3qDTYUEn6M5bw0aQBGvVjPyWUZLMa+wPWe9C2YXN+d36vAJMBTzCJQtwy+zafpop
         LE/L8c2PHRvYGR2F6LwTw+EQXIE1bQ1q+XF93uORPuMszkSowMA3aatE1WcOFyLEJIzD
         3HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764905479; x=1765510279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmirmDSmTdLnhFtilGhufp1Glf35pWJroSch58apqNk=;
        b=qLbYcsd4vpi3WEwj2CiMPdNpEHfdQYsVFLgj9bXEb85j2LlIU8rymSqV6YA9jD8IAt
         6HawjkxI4I47jImFjEw75fOyclrI24YrDYf1hFNN65pArQMxn/0Fy5+ZrcEDxN6C03Nk
         BuJaUpmH1+ejxFjXkMwkqtKGvytz2oyUPiUTvfFGoyWk0ncRa+rzbJpNLqFIx+jbYmNI
         GV+BrIViwMLhrseu7AdNlS2WAAxjM4S+hN+vIVOPzOxcl3kX/R6Z+sEgSUREs1jTJy4x
         f0FdbZ2CMUjiIchUCKeUn8M4CL5pLoMo91P2Qvic6QXNuHNsR0NDbevED2WFCbSAFrCz
         CQfw==
X-Forwarded-Encrypted: i=1; AJvYcCUPLjtL+HAuqM2DHHEHSnGtPbqOo6X0cxDZKpeRRAso1cuLU/Z6yT8af6igKFD8ZhNmeqBXJgOvxZjU@vger.kernel.org
X-Gm-Message-State: AOJu0YxuIiSk39+m9hc4owSrnEm0OjXoprxsPNG/RCzNbCm+tgiTED8J
	8ucA05hnMawzyToig5gkxCRonZ2+8iHjDZq5+0zLU/qvs54JLUX1xbXeIUzv8NGgNeMKWi75p7d
	oiY5NDDRalmXQss3UCkxGtQt4BRGUIPI=
X-Gm-Gg: ASbGncvQ6nT8tU3WeycQIY+SjQ4bsQYIDJKzNnOBBeGiuMQNKWseUJMoc+d7QVsUQ4m
	vVNzNXKS/Pg8kMVpQxfiPC0AkQljJeQvPLnwhh/gTTP6/ASN9OqtWJs3VL13J1rcYHDtKbv3wfW
	XcfVKnnhGU5uUqN3gh/H/jDY7Kxwsq4CY0RVj5mAhK9zr+xeAmbU2UA29zRbROy/lMUANt7zDnQ
	40MnjCvJqnux6PHNRbvsydZ3mrTdbTQhHfkIBEqnWFHSEZQbgoDXTumLkxVRa5PPQmnoYIPXnCM
	NzJkfujeymgNGXL+tgWIky4G5OvdHFLg3RC12mqJBUNAFKlp34mMytLntgdy
X-Google-Smtp-Source: AGHT+IGP/hZf7bb4Fpwwtu/NAKaBhcfkqhek8JyQSL6nBfqf7YaZxnmZB88HFMX41ziETsszfKE0KAAbm2UrgncRG7I=
X-Received: by 2002:a05:690c:690a:b0:784:8153:c61a with SMTP id
 00721157ae682-78c0bffa64dmr71264617b3.34.1764905479058; Thu, 04 Dec 2025
 19:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122015742.362444-1-kartikey406@gmail.com>
 <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
 <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com> <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com> <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
 <20251203154657.GC93777@macsyma.lan> <aTCtITpW9yLNm2hz@casper.infradead.org>
 <20251203223300.GB71988@macsyma.lan> <CADhLXY4_yYdGQCYxq3=gQ6ZTJ7y_=dGsEBqdJ4g7JizX+ocVYA@mail.gmail.com>
 <20251205021818.GF71988@macsyma.lan>
In-Reply-To: <20251205021818.GF71988@macsyma.lan>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 5 Dec 2025 09:01:04 +0530
X-Gm-Features: AWmQ_bkRMAhMCQZMIuU0DkOS5tLvkTTkzlPlpSs2zv4_eYvzgxtbk4DgJ9-ahUQ
Message-ID: <CADhLXY6vhwQRUwEnVqR9=CP2ZJaCr59Ym0x+Q0mWSzK4aCY0XA@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: check folio uptodate state in ext4_page_mkwrite()
To: Theodore Tso <tytso@mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, Zhang Yi <yi.zhang@huaweicloud.com>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com, 
	adilger.kernel@dilger.ca, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 7:49=E2=80=AFAM Theodore Tso <tytso@mit.edu> wrote:
>
> Hmm.... if the page is mmap'ed into the user process, on a writeback
> failure, the page contents will suddenly and without any warning,
> *disappear*.
>
> So the other option is we could simply *not* invalidate the folio, but
> instead leave the folio dirty.  In some cases, where a particular
> block group is corrupted, if we retry the block allocation, the
> corrupted block group will be busied out, and so when the write back
> is retried, it's possible that the data will be actually be persisted.
>
> We do need to make sure the right thing we unmount the filesystem,
> since at that point, we have no choice but the invalidate the page and
> the data will get lost when the file system is unmounted.  So it's a
> more complicated approach.  But if this is happening when the file
> system is corrupted, especially if it was maliciously corrupted, all
> bets are off anyway, so maybe it's not worth the complexity.
>
>                                        - Ted

Hi Ted,

I understand your concern about data loss. You're right that unmapping
causes user data to disappear from memory.

However, as you noted, when the filesystem is corrupted:
1. The error message already says "Data will be lost"
2. All bets are off anyway
3. The simpler fix prevents the WARNING/crash

The more complex approach (keep dirty + retry) would be nice, but given
that corruption is already detected, I agree it's not worth the complexity.

I'll proceed with v3 using the unmap approach.

Best regards,
Deepanshu

