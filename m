Return-Path: <linux-ext4+bounces-2850-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8491A903D48
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jun 2024 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0984A288B08
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jun 2024 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD4B17E47B;
	Tue, 11 Jun 2024 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hka7UTfH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3A17E471
	for <linux-ext4@vger.kernel.org>; Tue, 11 Jun 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112410; cv=none; b=d9XMWPaeNYi6COB7jqGCg4VagQGtrGPMY31xcHXNfp8ofLImtEGPLLxkPsksjbgEe8FagbV2jSSHysDyW7mPR/2Ch5UifqbXnZUBKaUcL930T9QirIJsXtcGo8717BDl7u2KHIUj3LYSIj6eN59+ccrY+nb6c9lld1fijPcQGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112410; c=relaxed/simple;
	bh=ya3DUumLA5HM8nptXy6EmfmgVdjHG8U+S2pLoaFSey4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ripquuJeLPpZg03k4TklpIhhstLlCpF1G4ysiAczOKeDuZ4gPo53Z4P3ppmLeDcWXVzj7NPvCZMrpmgKbDPEu3UOkdpl0pYxZc4FS2A+thAvklKaFdvZu2aVoZBaaL9JZZwoIzsIX/tc2gQQxk600T0T4NDE1mCzNlhqA2btwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hka7UTfH; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfa4876a5bbso5288895276.2
        for <linux-ext4@vger.kernel.org>; Tue, 11 Jun 2024 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718112408; x=1718717208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQkBaVxVvgQ9GlnsgTh3GEcjCbkcN6rG7fXFBcivzhI=;
        b=Hka7UTfHuvthUb6n1DbZlEDM5oskQTxXv1RSb0ybX+UQEhY6ncGjDXvUJTTeP94XrU
         l3JkVBT2XGBUIYEml1V3iOJ16eIvyDnKdf+Y/PTV1GbVEJz0WlZ8illxDduxa/qbRMxH
         hgSUIs3msGo80j5KlkQsklggdh29oW7adNghogm/u/icszAiApVaQ4EjjT7GyuzQOWhs
         Ld3okXdpHjfoVeszw7zzcIWNoMEnsGpdSNRLGbFqL3Bynsc3JawBgi+wQccuDeqXiR66
         HXz0riYJeQsifuYPJYEXPwbo3j5tfbtvDoitdYGimwt9/ITnmEpelYzlqjEpDr2i1HSg
         Vbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718112408; x=1718717208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQkBaVxVvgQ9GlnsgTh3GEcjCbkcN6rG7fXFBcivzhI=;
        b=ajdTRzF2CadkDTzmiccUoHBOqh4Xxc4b323G4D1o86IYKsaNcIsn/mTaK+4gbnnII7
         FJzT/S6WvnuwCRZPwxfNxEJbTLvwScVyf1tF0gK4aux1RX0yDEDD7SyR/Bew+fFLPZ4k
         nzlhQ8ACAwhLWjyzZDPj6y2HS8LDmA0se8T7hXJwdHaBx4LYUrcO0IWJryn8cRQM5O8H
         vvnQHjW7qtrgDttc36EC4XAoEJ79ieR8+3z9yWCapbYav9+T6MFaNHmlcLzYt/PXmWGS
         8/gMFbnNPlHGV8aD6AvHkeLC/jRv2GPmMPnaWah6YVnU3TwqfcOoZBm/6eoqZdmLWmty
         1+Zw==
X-Gm-Message-State: AOJu0YzVx7Q1r2k6EmsBYwkPJyHxrmM+kzMhEl8FueftoZwIQjbdgzf8
	SIV4J5AZRfJE/GrewFs7bFtKW7UDGp+tVP++xreI/cLQ8Ref/8CU63fzlP12ee2Qctj5M2J4VtZ
	rq1YolyOZ3jpVTNsFI4Dlg4faT+UoQQ==
X-Google-Smtp-Source: AGHT+IEBIjUblxobEQSjaCPP7lqUhFonbW08FjPkTMVOTylIiijg3g4D7C+MlkwxmbQy8q0F2g0JC9CZeufYi9g1sxw=
X-Received: by 2002:a25:f626:0:b0:de5:cd02:8317 with SMTP id
 3f1490d57ef6-dfaf664592amr11449502276.40.1718112408079; Tue, 11 Jun 2024
 06:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPXz4EPz+JVCBJ8AF3u9JKzQZk1JWZvf4oW9VVJxVTry8rJz6A@mail.gmail.com>
 <A87288AE-DEE1-4D3F-9947-FB5A82F2643B@dilger.ca>
In-Reply-To: <A87288AE-DEE1-4D3F-9947-FB5A82F2643B@dilger.ca>
From: Nic Bretz <bretznic@gmail.com>
Date: Tue, 11 Jun 2024 06:26:36 -0700
Message-ID: <CAPXz4EN8Tty5bdwrkbj79eVSZNWh5J-QWs-vfGhNXHec4yEbXw@mail.gmail.com>
Subject: Re: stat Size and Blocks numbers don't decrease after deletion
To: Andreas Dilger <adilger@dilger.ca>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 1:55=E2=80=AFPM Andreas Dilger <adilger@dilger.ca> =
wrote:
>
> On Jun 7, 2024, at 10:25 AM, Nic Bretz <bretznic@gmail.com> wrote:
> >
> > When I create a new directory and new files in it, I see its size and
> > blocks increase when running stat. After deleting all files, the size
> > and blocks of the directory don't decrease in stat.
>
> Correct, ext4 does not shrink directories after they have been populated.
> There was a patch series at https://patchwork.ozlabs.org/project/linux-ex=
t4/patch/20190821182740.97127-1-harshadshirwadkar@gmail.com/ that fell
> into a crack and was never landed.  However, I think that patch would
> still be interesting to revive.
>
> > I was thinking that ext4 runs defragmentation in the background and
> > eventually those two numbers will decrease. It looks like they don't.
>
> No, ext4 does not do any kind of automatic background scanning or
> filesystem changes.  You can run (offline) "e2fsck -fD" if there is
> a big problem with large empty directories.
>
> Cheers, Andreas
>

Thank you for taking the time to explain this. I was thinking to
possibly start looking into this, but if there is already a patch,
I'll study that.
Nic

