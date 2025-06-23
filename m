Return-Path: <linux-ext4+bounces-8608-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFE3AE4245
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 15:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59DD3A3569
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8A25229C;
	Mon, 23 Jun 2025 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KIlEPPjH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5065D24BBE4
	for <linux-ext4@vger.kernel.org>; Mon, 23 Jun 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684629; cv=none; b=Dbtcu2xtWN9DeMGdlHdOXf4WK3j/8UFSU5nKI8Ca0Kh9NgiZzUcPlwWyXE1FTK3JdDtXGzxaVsyuW4W5mAblqRzdby86KU6vcYbEO0JVXitL+uOGMkxf8Pv/TIY8/vT2zr5ALYRNyJhBP94GCoUpW8z0fCWP1KExyXNTXLPxP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684629; c=relaxed/simple;
	bh=FzfPRoIJprPonWn/8gkChXjed1Rl1pDWPUEKdIH9waU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf/jqHlJ53f0VnlQXbp2+Kgn1VtXni2sFPaTYTknbe65OUiP1Y4lg8bQhStzoORI8mASTS+L4Ty7GLRr8HHI/eTnt32hOiaOrJW6RrqdkNvePv1dHunL7Cj52ufUEVLOhHJA7kOFP1LeHt9tYPkFW05hPzCry4YhQXh/jfcdihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KIlEPPjH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a43afb04a7so28800611cf.0
        for <linux-ext4@vger.kernel.org>; Mon, 23 Jun 2025 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1750684625; x=1751289425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNrHQFMj/WblgGjRZ+Rwm5AzRS7ewU/kytkJbvIF3do=;
        b=KIlEPPjHD+tVnHFJrMjWugoThYOBzSGfn+MHNp1bp+45FPAD136BMVk7BORnLaJuNx
         ILTZaVqV8q74QGLjRWBWNkiyrxPznoXF+T8qcFDWnj6PDR//C7tSlFDZZvucGknVFRmo
         XZqCzXI4enIZjJPrOQQBc2CT9yW7PX8tI66HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750684625; x=1751289425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNrHQFMj/WblgGjRZ+Rwm5AzRS7ewU/kytkJbvIF3do=;
        b=PyBgN2VV7Y89SUj2ae/Fm4rErloIvPY55aQOiSIH7DjG4T4JCr/+oazZjLiPyhyFtS
         LgoiUspmENc3AK9wnL8dRiR1gV4U/7Kk9iDPJLEv8w2SGf+JnFzcr+o4mxhsrtP/ZvVf
         X+mB3KW30adrVFhrvHXWuLQP/PtW2zqiWHfjLU6AeBaOSraSjtFXQha6Qz81uL1soXDs
         5HEw3hKgc5I4N4uOPNxQ9sBlN5JCeH8P8hRloE3CBNhsZ9ubLa6oyfmPG9GjBdpoLY7K
         jG2uQEh1hbWOzk0v+gGhevXgXUbRDYmaYZMVkxKi+mXMxPSWLX0Nje3KyrWsgI1NEFV7
         fv0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYEGv6vdx4hl68JxuptjHy9vXLdyyVyyugx6PONCIC/MNXkryblCkwN32N0x4cxQlvzgigWXZIGucm@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2IONFsFf4GEiRb3n1atrOpyBlrkig3FQpHsQhfZ5vHjkKKfm
	kFmaJBtQkRUKT3IH05wwOpdUcsQ7+tAf8cPStrllxUcpCmgCbYGdVWO67KCVTEeP6MJ9mhZqHDF
	a5E0rvc9xQvwy/09paMaihiUIODVrHavFi80Z9Bf/MA==
X-Gm-Gg: ASbGncu8UubAkUPLE9OpTgZJxN3B+Rod1Nf1oSZmVMs4QSNelgOu0QgJ3MPz58JCXGf
	85CoggT0/LbZNqmOIjs5EfGmaYmX90vl2CpRCTqHdeeBW8DfHm5XIyMCAN3bzKH3cIkDSNTCByL
	6ivxL/29lJXVqH+j1b26G6MvNkn/+tWWvmaITcpXUAR1KsOWsvp4U/Dw==
X-Google-Smtp-Source: AGHT+IE4jWGaqz2lc0klPR5nD58waFDtLTocTV0febrAytRiNbweHyPyJLGUjtcLA/PyvQLquDAn03DOACqGp3J8b3U=
X-Received: by 2002:a05:622a:64b:b0:4a4:3913:c1a5 with SMTP id
 d75a77b69052e-4a77a207d55mr217248551cf.16.1750684624825; Mon, 23 Jun 2025
 06:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs> <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250613173710.GL6138@frogsfrogsfrogs>
In-Reply-To: <20250613173710.GL6138@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 Jun 2025 15:16:53 +0200
X-Gm-Features: AX0GCFuqRKww0FB4NtOXuEyq6cUWzb_e_wCOLGCtSuPqfMKkekhloiCMyjbILjE
Message-ID: <CAJfpegui8-_J3o1QKOxGqMKOSt5O6Xw979YnnmwTF3P0yh_j+Q@mail.gmail.com>
Subject: Re: [RFC[RAP] V2] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, 
	bernd@bsbernd.com, joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2025 at 19:37, Darrick J. Wong <djwong@kernel.org> wrote:

> Top of that list is timestamps and file attributes, because fuse no
> longer calls the fuse server for file writes.  As a result, the kernel
> inode always has the most uptodate versions of the some file attributes
> (i_size, timestamps, mode) and just want to send FUSE_SETATTR whenever
> the dirty inode gets flushed.

This is already the case for cached writes, no new code should be needed.

Thanks,
Miklos

