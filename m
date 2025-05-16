Return-Path: <linux-ext4+bounces-7935-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25063AB95FF
	for <lists+linux-ext4@lfdr.de>; Fri, 16 May 2025 08:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51245025DB
	for <lists+linux-ext4@lfdr.de>; Fri, 16 May 2025 06:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72BD2222D7;
	Fri, 16 May 2025 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilLN8OAY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECD21FF2E;
	Fri, 16 May 2025 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747377136; cv=none; b=kI1zAk9Vxp2rYyNrpR//7YT5VbDaSzG4B3HtewG5Lu0gXfkvVdvsFc3DaF1hDDiCDzoXr6qvMs30KO+bFCCD+9zn7YnTdgfVn5QTo8tjz74NMr7XRzqRO2EQqrEQykwtlRVvhuTmQW/M88j4f1dp25/+61YDIyRLEPRvR2kSMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747377136; c=relaxed/simple;
	bh=WYB4PC4/QumY6RXKi4PlhSQ9Xaobg1iGGK4yZ9AeIBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQ4XlyFueZsn1/F5gPczWFHwe/5rulT8UNkpGSeEjfdLrXJ1dk9d3MF0QOVAwQfS4PDMH9vBtAQtEvaItf16OZ/U6Spui8EqLUTVrFmG2VEM+dS88ep8Xt2/UDEpaw2hjk21mY1H6UQR/mEvbhs1raGKbfYslhczdHy53ztteK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilLN8OAY; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e7904da218aso1327833276.2;
        Thu, 15 May 2025 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747377134; x=1747981934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGXKAGF1/FsCyJWkLL4R/6PrQ05F+0Yz4eEuU1kLWsU=;
        b=ilLN8OAYf67E72OyApYO9KjHMyGsVuhI7NRnxQfqDqj3zGF7YhwsPiirSXPEvcAxUk
         HRubqd5flNAsGTbnlGbn++lzNYk+cQ0sFivPp5OGhVSy4wR02fj/jfWqAzcNdykZGYNX
         t6XAZ/ojpNDutpJMNrPdjW/8JDW2z0bERi28uA68jaI4dc39GYXcCEDFGSv74zVxy4Su
         1KlgxXu+1NUR1Zy3JxDJQiPO817HRKrE/5ZTRLTdIjX41UqJWSKTbe+rFJhIuC1IdeLx
         qWmb9+0ijN2a936Vzlta12mMIWu2APBzcuGEeuitZJy+q0ZC+WYpABC4WjSHtS7Mqy4U
         SrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747377134; x=1747981934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGXKAGF1/FsCyJWkLL4R/6PrQ05F+0Yz4eEuU1kLWsU=;
        b=pKp5rOHrfyFSoqUe9rxv7TYDiTSE/5iZV/WKPvcwIUmcKyKeoAopJmdrZSJJD/K8aA
         01e/bKKVyyktkFYAxndRlSrrG3sEnp1EdS3Xchcnu5CLvbSnBMlzFq3TpSOLICPygmwo
         rvwucyfAcw84BAJmT9wL6q98C4ZFsT+ZWxpGLwesdukg+rj/v6UkW0rRnZ5dyYqShF/D
         Aa4OVKHeRL/E4iwBt5+UUq3m/enu90nDJW8GnNrtoRfG8hSNkfdDhE4Ihs8B/Dw9aAP9
         msUreoskgmwmZ8DTo1p9MCSVoNh/coK6PbAcryZ403XW/w5TXsLqhOMATx0qleTbMKGn
         +DWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRI+5+U1UEms9g/TxiT1OHmGRzB5BylWj91zJLGaPvcpvb0w5H5FakPxfQi+1D22qE5KTnafI08SkmyV8w@vger.kernel.org, AJvYcCWzfEnAThXR0fFtunb81vSySE+NtDhY/M9YmCL/rccT3kHDtcuLpmjR8g7nhgPstllGihgYW3GcIS7p@vger.kernel.org
X-Gm-Message-State: AOJu0YyncuLerw6WWCHPZwZxY9Q/vTznXmnqFSRTvzn9t0ms2JAm1Faq
	e5TxiUdpYaxgm5OdKGflYCSTEZAn84UafmoWHCfprmicl5DLfunAFQLHy8eY3v9E2jWhpLx4/5s
	4/BqMaxB48pwl2Y3lKo7eft0BgCtTXqRADah+aazL2w==
X-Gm-Gg: ASbGnctd8iwjnJsWCrZGh6qaymDH0Nfi5U2+yJ27zLQ+qWKPkQwz5f1534Wblagsh03
	sOy+BOu8r1NgEZ0fUqszpODLUhFDPdHCf7zcTXZMvadV+xTz3iyK8yjn37QIVl2VNFoOgroiGZ1
	iAdPnjkhhAYL8I7WS0xUyPLOXknzXKKUL2Big=
X-Google-Smtp-Source: AGHT+IH/IofeAd6vy3/ZeDlDO6zFMGpzZNjxG9N9X1Ud4Y/RDhC/XNh3fz4lMxUc1E0QO+Br5Hebqoh+UwZCRwoxLks=
X-Received: by 2002:a05:6902:1707:b0:e7b:3cf1:5741 with SMTP id
 3f1490d57ef6-e7b6a52f211mr3347352276.39.1747377133782; Thu, 15 May 2025
 23:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNGr6t6cpo3zjANpYObZaWOSeGKdGW4B4+k1Bh2ZWQZBbJrBg@mail.gmail.com>
 <20250515141643.GB325737@mit.edu>
In-Reply-To: <20250515141643.GB325737@mit.edu>
From: Guoyu Yin <y04609127@gmail.com>
Date: Fri, 16 May 2025 14:32:03 +0800
X-Gm-Features: AX0GCFuv2R6km5Dmoa9S8zI1wx3oPrIDtvbzPG6i3XXVPiNQMEYLn9l-CnqZ45A
Message-ID: <CAJNGr6uopyD6dYr2sFT-5k_3=Po-Cc43BKTnwDtaQuk8=Yh+BQ@mail.gmail.com>
Subject: Re: [BUG] kernel BUG in ext4_mb_release_inode_pa
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for your response and suggestions.I have implemented the
reproduction program based on your suggestions. With these changes, I
have successfully reproduced the kernel BUG in
ext4_mb_release_inode_pa, but the crash triggers after 5-8 runs on
average, please try a few more times.

The new C reproducer: https://pastebin.com/raw/jWYWQHPP

Best regards,
Guoyu

Theodore Ts'o <tytso@mit.edu> =E4=BA=8E2025=E5=B9=B45=E6=9C=8815=E6=97=A5=
=E5=91=A8=E5=9B=9B 22:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, May 15, 2025 at 05:58:40PM +0800, Guoyu Yin wrote:
> >
> > I discovered a kernel crash described as "kernel BUG in
> > ext4_mb_release_inode_pa." This issue occurs in the EXT4 filesystem's
> > ext4_mb_release_inode_pa function (fs/ext4/mballoc.c:5339), where a
> > BUG() assertion fails due to a mismatch between the calculated free
> > block count free and the expected value pa->pa_free during
> > preallocated block release.
>
> I can't reproduce the BUG using qemu,with the kernel config, kernel
> commit, and C reproducer that you have provided.  This is why I
> strongly suggest that if people really feel the need to set up their
> own syzkaller instances, perhaps because they are maing changes to
> syzkaller, that they replicate the full syzkaler setup, including the
> web dashboard and e-mail responder so that people can request that the
> reproducer be run on your setup so we can figure out how easily
> reproducible the report might be, and whether it has been fixed in a
> more recent kernel version, or via a proposed bug fix.
>
> You are most likely correct that it is caused by a corrupted file
> system, and this is why I strongly recommend that users run fsck -y on
> any file system image of uncertain provenance before trying to mount
> said file system.  In addition, note that if the file system had been
> mounted with errors=3Dremount-ro, the problem wouldn't have resulted in
> a BUG.  For this reason, especially when the C reprducer doesn't
> reproduce the reported issue, this sorts of issues are a very low
> priority to investigate.
>
> Best regards,
>
>                                         - Ted

