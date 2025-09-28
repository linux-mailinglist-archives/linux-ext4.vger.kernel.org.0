Return-Path: <linux-ext4+bounces-10464-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF89BA697E
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 08:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE03E18955E1
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 06:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C53022FE02;
	Sun, 28 Sep 2025 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyAHAXUt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5422F16E
	for <linux-ext4@vger.kernel.org>; Sun, 28 Sep 2025 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759042285; cv=none; b=YUQGGsozDg3MkZ95gMTwlIu8uE8A7ALCZR9aSXsJ9hVDTi4eQuA8IC/8FVFAiZpkv5DvDCkOlh/IiA6hPxSaCBPuDfeGiF0uhXWLIBW7mdeIeXc0YNzIcMHShg631i/QhriLQ0x+qEp/Aos6DAYnCvCTTYzD4P1fJ/xStVK1z3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759042285; c=relaxed/simple;
	bh=ikq3aMxU4fFwcx5mxDMxpv2X2unAC6cia4zDH5pqQUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXhsU1sHofrkD9JQqUjViDVqTA7nI0JgnmzW+c47GcaRGmrxqiaU8z0l5yJ3ryVFlqM/WrNhDfmVw1y30weObruWjxvTBam4zWjNby8pk6jnosw64/LoSO/1e+X9Z5u+sNkT8jHwGGBbBpEkCVhq68L/lkUDEoux1h+DQTQY5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyAHAXUt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57992ba129eso4082137e87.3
        for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 23:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759042281; x=1759647081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxUT5+1g9O97zD3LPMY0UEbPeixGwlrA0LVO2JZpIns=;
        b=cyAHAXUtDi7PAUqCntz6SasviG8prnpxMaDMP494Yhq7s/uyroMbrebY3JWbPt1mvR
         tiVXkJeszXhtvcRKsNQg291qWzqrWn3d4WVMrQNLRHvi5zxqymVpgs80Vd2i+YpMzddr
         8IGvqIgGAO5tQF/yDaIrvjxy5YBW3b/rPqPKvQylIJRcBc+19FnefahLwjR1p9mfqJTm
         a1cUO+L5JEaLV8onpDFTNYFDUN8VqoQOgj+bMjtGNVOVsoCKQnmukjXMyOGHp7qTK9un
         rsuBw2MCC4OIJ+hY4t2+doBkqqNCkACxW8/cAWd4dVmrahAABz8Q9R6uelpu8PSNXUWc
         MFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759042281; x=1759647081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxUT5+1g9O97zD3LPMY0UEbPeixGwlrA0LVO2JZpIns=;
        b=g7zWVsKQ4KkHPHBxus3FqoLpR/6JLeTpiWtdYrGd/c65PsWlvy4hDnx1dQq79Er3Gn
         +YzwADOX38r/Esu0n5XFtF517hMJmyKxQIeIncn7HdfZ3whQfcoBtFvlUe4ADSCoOg4Z
         YI9HCLZpe8F6dIIrmpPU27yzZG6GXSZ5sWS2ZHCb7Ur9DnMrF//4A3S0YbjbTNPK0VBw
         ROjNvJGwhDcxPQpy/gZ/NhcfFpBRv/ATbj42uGLL4yAU2dfPBFzzf1Z+hZj4fRRq29p0
         puJVVtDzQKJ7YjW0ylvL+BuaE8otIGg5SffHpCauOVd/FR3DaAnJ7xb2v0C+QxVPZm6n
         tlGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXniBMjZx37nBjkyw5E07G6ymbebNAFIyAHBpE0CAjx/TB65iyV4kmJKR3qNEtTra+5e9q6wNYqJSpU@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHqNb0Mb0HKDcfABgJCfQ2raZCY/8RnZ2T/fXgqmPnPZHnOSJ
	OSBCFtYJp+VGPbvzRIaA3+Sq0/kY2Qg2kz9V0+mTfSbevm8bqGWnXVUNkFkheJ51dSJFbcP6g6w
	BujjBMuIG1yLFg71f5r6FFw0Af6sqXOc=
X-Gm-Gg: ASbGnctxpxx3fMbVixqmavEaRXbFAC+jxhWvFxW6swtoUBK7C80WtJ3STBM6KW6xaO8
	50Yx47sa+7LqKYyV05/w+TBNfpRuFSU6Oduy9n8z4RXmP1ICPHV6Tbvz+M+nL2oBU3kCLdoD/dv
	8b3MDyrpBD4F2KtsDeyTofUPBW3G9fVpbrGqaxbKfDc0GoiYgLEsMsVXMFo/wXHWXzfHCSHQCXQ
	Yl8XPSgVKqpUKYe+aqovQfyrd/OvNHUeOVhpzjVUw==
X-Google-Smtp-Source: AGHT+IHkepdLGGCvhShmw9AgXRAFbF/852DMYd83GHTIPJzgx5rI1bd891kYbdVIBaWiAsoUQsFwKzxQTwIWRXnMBgw=
X-Received: by 2002:a05:6512:1095:b0:579:ff89:6b0a with SMTP id
 2adb3069b0e04-582d2f277d6mr4352690e87.43.1759042280985; Sat, 27 Sep 2025
 23:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200407064616.221459-3-harshadshirwadkar@gmail.com>
 <c7a41ba13a3551fca25d7498b9d4542a104fac74.camel@gmail.com>
 <CAHB1NagYz+BLXdEtUa7C_6-A6DDCT9Q+A7Vg6PXSwm9D7ZyAkQ@mail.gmail.com> <20250928034638.GC200463@mit.edu>
In-Reply-To: <20250928034638.GC200463@mit.edu>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Sun, 28 Sep 2025 14:51:09 +0800
X-Gm-Features: AS18NWDd6tqFdS8Fi-ip_BibRF2_gGxB-rDWHXvbS82bkV336Z4Oa6tvTeqTN2U
Message-ID: <CAHB1NaifpACESRtCMsbF3f8EACD__gnM0bsXyyi4sQ0HYcJs=A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ext4: reimplement ext4_empty_dir() using is_dirent_block_empty
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>, adilger@dilger.ca, jack@suse.cz, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 28, 2025 at 11:46=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrot=
e:
>
> On Sat, Sep 27, 2025 at 04:11:54PM +0800, Julian Sun wrote:
> > >
> > > I=E2=80=99ve recently been looking into the ext4 directory shrinking =
problem
> > > and was considering trying to add this feature myself. To my surprise=
,
> > > I found that this patch set had already implemented it and even
> > > received Reviewed-by. I=E2=80=99m curious whether it was never merged=
, or if it
> > > was merged and later reverted?
> > >
> > > If possible, is there anything I could do to contribute to moving thi=
s
> > > patch set forward toward being merged?
>
> I *think* there was one or two test regressions that Harshad was
> wrking on, but real problem was the original business imperative for
> the project became no longer as compelling, and we moved to focus on
> other priorities.
>
> So if you'd like tocontribute to moving this forward, what we'd need
> to do is to forward port the patch set to the latest kernel.  I've
> taken a quick look at the patches, and predates the addition of the
> support of 3-level htrees (the incompat_largedir feature).

Emm. I checked the code and found that support for 3-level htrees was
added in 2017 via commit e08ac99fa2a2 ("ext4: add largedir feature"),
but this patch was submitted in 2020. Did I make a mistake somewhere?
> There are
> also some hardening against maliciously fuzzed file systems that will
> prevent the patches from applying cleanly.

Is this included in the xfstests test suite?

> Then we'd need to run regression tests on a variety of different ext4
> configurations to see if there are any regressions, and if so, they
> would need to be fixed.

Is testing with xfstests sufficient? Or are there any other test
suites that can be used to test this patch set?
>
> Also, please note that this first set of changes doesn't really make a
> big difference for real-world use casses, since a directory block
> won't get dropped when it is completely empty.  For example, if we
> assume an average directory entry size of 32, there can be up to 128
> entries in a 4k block.  If we assume that the average leaf block is
> 75% filled, there will be 96 directory entries.  All 96 directory
> entries have to be deleted before that block can be removed.  If the
> directory is 4MB, there will be roughly 100,000 directory entries and
> 1024 blocks.  If we assume a random distribution and random deletion
> (which is a fair assumption given that we're using a hash of the file
> name).  I will leave it as an exercise to the reader what percentage
> of directory entries need to be deleted before the probability that at
> least one 4k directory block is emptied is at least, say, 80%.  But in
> practice, you have to delete most of the files in the directory before
> the directory starts shrinking.

Yes, I think the biggest beneficiary is rm -rf-type workloads.
>
> So this this is why we really need to implement the next step (which
> is not in this patch series), and that is to merging two adjacent leaf
> blocks once they fall below to some threshold --- say, 25%.  We will
> also need to merge two adjacent index nodes if they are mostly empty.

Sounds great. Thanks for your kind and detailed explanation, Ted.
>
> Cheers,
>
>                                                 - Ted


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

