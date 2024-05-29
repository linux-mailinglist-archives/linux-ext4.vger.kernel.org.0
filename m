Return-Path: <linux-ext4+bounces-2681-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0E98D292F
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 02:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61092869B8
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 00:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB654A39;
	Wed, 29 May 2024 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwTK3Ubq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB517E8E6;
	Wed, 29 May 2024 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940894; cv=none; b=cv0cjg9F1opWEUuDjTktzZnneoXBran6ppFkJ+1uO5ouJqDEvP8juedAS06jehYeWEZ2dktMgSKJJ1n3GeWmxfJBgHCsNSii7Lu2Fkumd7eadd3SXlqVI52rd//HSJ+JkKKiF9JhLVgUUlABa/ZrKCRN4z6S6TmeFGuurSDxldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940894; c=relaxed/simple;
	bh=C63Ly9k5dKIFZWQs/wl1bGWVi8J3EJSDPbiFrxMa7xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHaZE96MxsGWiBYmQB7LaFm/D0k2eMP6KMD70eMzQtDcC4OPRgXEfc1Pdq6Ki7SauBuQ8wQ4SchRcw7t8kQr4gRcsSgXJyyIx6mMwTo0zwNHTbVSkAmUD4HoO5WSD5oc+X1/5oFsr2vAPq/Ae9SM5EIDokCNKGTRiOtJ86ailaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwTK3Ubq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a0849f5a8so14391967b3.2;
        Tue, 28 May 2024 17:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716940892; x=1717545692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIRHKX25G2rvrHd33/dtDE8fOCvBEp9EtBOCUmSmkH8=;
        b=AwTK3Ubq4MafPRoP1gJ16sOovMMdg4/xiQpmgufQI1HgZf2ojWBBUPUUFIF6zyrXM+
         4PS9+7UWV+Yxpf/EE5WdlsDIKSyE+t2QKx1ETv4Sy338/8Y+MMRnO/R8pA1/H6BiSxvy
         cq/KokAHROSiiSTL9+FCBIe8OsMiaPSxN57+TPtd+KYVUx5q8XrV6tM0F/z2Ha0eoBKe
         qsf9oclQL6TpJv2GXCjxM4sg0maTahgCTCPl+Rtl5lHEdleQS/WXTdtGh2caZoFggbiJ
         scLeRMqhcirWjiLOAskTlY1y7udkzRnZ8IL6ISv+LNwuHq7TGq6djZ18uzChgL3vWZpK
         TcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716940892; x=1717545692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIRHKX25G2rvrHd33/dtDE8fOCvBEp9EtBOCUmSmkH8=;
        b=VQ0ia0b1EQpxFqaha2RE3DWadRoH8IMTzZaWXQXnWfLRaa6bcC5v9OlmbQv2k1Un5g
         rXJWNBtAIOPjuRTsQCHh0mQ2FXjS1zhoEKbdU8Uk5GwAyXXkOGW9eBWwhUGI5Ab/kFVU
         Jt7zjDfZAjPWPy1cHqCmU6EoSa15Y4nH6jxbsqveTfEBG65z2aMschtEk8c5mAgIsyQ3
         Vhpu4V7DkL6cfozAZDy5DcPm1F84hILNPEIJ5edd7cWFr9m7xS6lnRy1cLrswlPLQTFM
         r3pkOjdcnOL+QL/U82ZkobwJF/LEnbHVI5oRuVwPD6bkdCa0rYyPHWs8nvA8SzWq0T7o
         V2rA==
X-Forwarded-Encrypted: i=1; AJvYcCUd6EBVy6WqeQPtldey8qKp2xgX9AEEqpWDNlLjqPaIAxtW845W+viXfVTjxHRHIGtdcJYOngk/f7DbvrzL/zWHSLWvHbBiD/v2oR0G0O9Qn1npzJdUApXGum0A2ytTZLT0BXWBILqfAw==
X-Gm-Message-State: AOJu0YxBoNRPQtuy8jZZQm1uhvXstR9ZeCXSH1bD9f5wHqDQyckGs0V7
	4SsMBW/8n9EUyCyPP5J1ATCID37WhsFtbimHg0rJTxsGHKlpEww1/u/yb8xf8RYCNSTrbIJd6ZF
	xsrIeebbB5yfLmq2g+74FJmhAFa9lZzUt6ig=
X-Google-Smtp-Source: AGHT+IFTzRkenDTDt3wESNB4ZaRKpKcLVxz2To6inH8tHhmRceliC0fS45+10Kk5SPl2fMZu0N83xDR7R+Y3WMrVcOc=
X-Received: by 2002:a25:bc3:0:b0:df7:92ee:bb1a with SMTP id
 3f1490d57ef6-df792eebc0dmr9317375276.52.1716940891845; Tue, 28 May 2024
 17:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523111618.17012-1-luis.henriques@linux.dev>
 <20240524162231.l5r4niz7awjgfju6@quack3> <87h6ej64jv.fsf@brahms.olymp>
 <87msob45o7.fsf@brahms.olymp> <20240528103602.akx2gui5ownj25l3@quack3>
 <20240528105203.2q4gxqz6amgvud4l@quack3> <87h6eirl49.fsf@brahms.olymp>
In-Reply-To: <87h6eirl49.fsf@brahms.olymp>
From: harshad shirwadkar <harshadshirwadkar@gmail.com>
Date: Tue, 28 May 2024 17:01:19 -0700
Message-ID: <CAD+ocbwjeRVS3PL3AL+HKQ=VYm=MRZa1JOesZvERije4KFn7Vw@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: fix fast commit inode enqueueing during a full
 journal commit
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for getting back late on your patchset - I was on vacation and
checked your patch just now. This is a good catch! My patchset does
not fix this issue. Looking forward to your V3 fix.

Also, using i_sync_tid as Jan suggested sounds like a good way to handle th=
is.

- Harshad


On Tue, May 28, 2024 at 8:50=E2=80=AFAM Luis Henriques <luis.henriques@linu=
x.dev> wrote:
>
> On Tue 28 May 2024 12:52:03 PM +02, Jan Kara wrote;
>
> > On Tue 28-05-24 12:36:02, Jan Kara wrote:
> >> On Mon 27-05-24 16:48:24, Luis Henriques wrote:
> >> > On Mon 27 May 2024 09:29:40 AM +01, Luis Henriques wrote;
> >> > >>> +      /*
> >> > >>> +       * Used to flag an inode as part of the next fast commit;=
 will be
> >> > >>> +       * reset during fast commit clean-up
> >> > >>> +       */
> >> > >>> +      tid_t i_fc_next;
> >> > >>> +
> >> > >>
> >> > >> Do we really need new tid in the inode? I'd be kind of hoping we =
could use
> >> > >> EXT4_I(inode)->i_sync_tid for this - I can see we even already se=
t it in
> >> > >> ext4_fc_track_template() and used for similar comparisons in fast=
 commit
> >> > >> code.
> >> > >
> >> > > Ah, true.  It looks like it could be used indeed.  We'll still nee=
d a flag
> >> > > here, but a simple bool should be enough for that.
> >> >
> >> > After looking again at the code, I'm not 100% sure that this is actu=
ally
> >> > doable.  For example, if I replace the above by
> >> >
> >> >    bool i_fc_next;
> >> >
> >> > and set to to 'true' below:
> >
> > Forgot to comment on this one: I don't think you even need 'bool i_fc_n=
ext'
> > - simply whenever i_sync_tid is greater than committing transaction's t=
id,
> > you move the inode to FC_Q_STAGING list in ext4_fc_cleanup().
>
> Yeah, I got that from your other comment in the previous email.  And that
> means the actual fix will be a pretty small patch (almost a one-liner).
>
> I'm running some more tests on v3, I'll probably send it later today or
> tomorrow.  Thanks a lot for your review (and patience), Jan.
>
> Cheers,
> --
> Lu=C3=ADs

