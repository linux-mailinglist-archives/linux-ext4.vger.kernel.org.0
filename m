Return-Path: <linux-ext4+bounces-4617-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 243269A31C8
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 02:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86141F2269E
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF05F34545;
	Fri, 18 Oct 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="matGzpu8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1442820E30B
	for <linux-ext4@vger.kernel.org>; Fri, 18 Oct 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729212638; cv=none; b=PfNu7a+T0tUuWGpStSlBSYBXGnMiLaZgyP7v+4soXDpzl3MMNUtD3cOsPxaXDNTs6rxcsha7s66Q8zAbejXibjvUqM62WokSPx/WDYa9l2aGv0K9SliLKAVWgdHL+QKMdLXpDtrXmdTDJIVhhLmUJ+sQKNRrCaNLZRaqetqEcWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729212638; c=relaxed/simple;
	bh=rX6hTDPC/K0ykPQR2mXZw/jwh21cbi1cjZcJirkOwj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBjejHz1SlsRgkYwRV1tv/U76DKGcraGjtaR6NEY1/XySYhp8aMauxNmGsO2+OPsBYaw0LdNyZRqaPr2xrW09pkdkRdoai301mdVhguwTbUa6hWp5+zpW1e4617IQmNPqZ2COPWA6ewnKh3sLwvh2+QKdbx/iDEYDPA08kaQlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=matGzpu8; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-288a990b0abso732754fac.2
        for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2024 17:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729212636; x=1729817436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG68H8REXwWr6ynovLFXlWaKRv4Wqv1fHEzK9lVYEe8=;
        b=matGzpu8JDDI0VUTXPodlrsCaGq1y0vc/rRUTtvmsKrQLSeqw4iUCRuZYpyr9FF5RL
         gSRyAyY6NA4KFh1OtFinbYByn92Y/CNlmDs3GdLmhS/DogP1mGoWerDHY5oH8lNbfBJ/
         ieI3KEImJaBjju3LTRKSCo94vYh5KkdE9cIVNg2siw2iBVgRyloL+C4iiDN0sBlwElRo
         I4SqM0d5zJmiEuIhRaO66yyxNUMaPPswY4tiCa1A+br1iHOgIHPAqe4gAKI59mzSJYEd
         gauMySNT+LEi2DdkatpbbUGxAWRybdiICn32Ve45aIdcp5K5uUC3yKIfOcfL5UYvQTxm
         dH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729212636; x=1729817436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tG68H8REXwWr6ynovLFXlWaKRv4Wqv1fHEzK9lVYEe8=;
        b=BmuRzfaSj5sD65diu42Bae1WUAmJGJ14ZmkWmkOSSXLKGZeIivqBKgv4Yss5kDNLUU
         aKVBfMr/2AYCsSLMP8hT3MAnho3W9outhr51wodilmF8byTKv50poQP0hvEdua9Ca8Wz
         JeaZaLdFFLx8tFRz5j95t1ZGJT2Bsu2klsXeZGyvkU1JTm4sr8W7bUjJk/7qLUCBOo5i
         EUC5lkHjE8tF4NIBZp0PmjWWULXmkhvULHT9waY9WD7KS1DV4E4GFEiH23q6L+ypCKRt
         q5enrhG7DgItbLvz6KygMGm1eS5ESey+n630120nqKdYKzVIyqj/GuEvrtU4LQf2iKW2
         tCGg==
X-Gm-Message-State: AOJu0YxnApE85Ha7y8zoFD/uA4vcqDYfimo3SrdkZuu3XDgjjPpBxgtP
	sAFiQvybubIz0VV3sgOrrQaf4Dr4VuWa7+CAfVUiFOE/Tyrasc1BiLbnIYFO0jFoZArgwCBgb7T
	o9Y3iJSma4ZsKADuvYpZ1I+wLG1w=
X-Google-Smtp-Source: AGHT+IGbkJwI7r7WkxjiIj83yY19UEneDUBYkp4johkAugziRhWvEG/rhtGW5AfArC0cwTjxoXNEAwFe85f1k5IJ59I=
X-Received: by 2002:a05:6870:9689:b0:277:bf1c:da4a with SMTP id
 586e51a60fabf-2892c546dbfmr477802fac.45.1729212636117; Thu, 17 Oct 2024
 17:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014140654.69613-1-bretznic@gmail.com> <20241018001953.GB3204734@mit.edu>
In-Reply-To: <20241018001953.GB3204734@mit.edu>
From: Nicolas Bretz <bretznic@gmail.com>
Date: Thu, 17 Oct 2024 17:50:25 -0700
Message-ID: <CAPXz4EPuy6ozucoWtFtdC3j_DCeCZ-gWm1zE+tKLVzAmskyR7w@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: inode: Delete braces for single statements
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 5:19=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Mon, Oct 14, 2024 at 07:06:54AM -0700, Nicolas Bretz wrote:
> > checkpatch.pl warnings - braces are not necessary
> >
> > Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
>
> The checkpatch.pl script is meant to check *patches*, and in general,
> in the ext4 subsystem (as with many other subststems) patches which
> only fix checkpatch.pl file are discouraged, since it can introduce
> potential patch conflicts when cherrypicking fixes, or in the course
> of other people doing other development.
>
> Granted, dealing with the patch conflicts aren't that hard, but the
> cost/benefit ratio isn't worth it.  For kernel newbies who are looking
> for practice submitting patches, cleaning up checkpatch warnings in
> the staging subsystem are fine, but in general, it's best to not send
> cleanup-only patches to other parts of the system.
>
> Of course, if you're modifying that part of the code in question,
> that's a perfect time to clean it up while you're at it.
>
> > Removed trailing whitespaces introduced in v1
>
> In the future, please put changes between the v1 and v2 patches after
> the three hyphens (by where the summary of how many lines were added
> or removed in each file).  That way the description of changes between
> earlier versions aren't preserved forever in the git commit
> description, since they aren't really useful once they've landed in
> the git.
>
> Thanks,
>
>                                         - Ted

Noted, I appreciate the input.

