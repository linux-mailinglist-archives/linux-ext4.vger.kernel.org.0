Return-Path: <linux-ext4+bounces-11999-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B30FFC7AF43
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 17:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 356FC4F1FE0
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A05C2F0696;
	Fri, 21 Nov 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEjt9dKi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6661ACEDF
	for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743763; cv=none; b=snhgGPFjBFTdVSgYzfAp597oLyNOQ9nkURk9233s/P0IyOwM+Gmumw0WXKVd8KjZATnoQI5lJkq0qJClwG0yZufbgFbFDBZbe9fO09SlVHsZ8pjWqHaAsF5ZaH4EUgxR/DkgAaP17cCP8gom++b+g7cfpGt850FuvtVbVokDwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743763; c=relaxed/simple;
	bh=AYFMulsYhJKIMAJ/slwZ/XGHv8I0FZkaffgEOns95T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdCKl5XfQQa6cF7LtWhWpA6+hPDbUBaMu8wcucdGvPeq+NBI6rn8fZ4C/8NoZk7/TeQCk1/asfFm1z5Ha+Jt1kdE6eahCpyg2z3PnYep8wpcQKWuSl5ulLFijoMm9/2IT8SMcyxeEiqE5+Xio1f2pp44jw/9SBm8ENYXw1FXtRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEjt9dKi; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-786635a8ce4so18987717b3.2
        for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 08:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763743761; x=1764348561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcoJ8yuTGg/KrnSVD2pTkyWBD3IkrYs48EOILusAwmM=;
        b=MEjt9dKiCxuLIIprfxdXe/XSjQ7Pvd/ZAvPwmt8zS7Skc9b0dudNLE6HnBiAtld+TW
         g3r88GiTG5QGoGrstkJTPQzAZHk046jE3w8rUyLFfmlwIIrVgR+n1ERq9A8pJ5SGXhJu
         zhLZh4xPBmmCsI7/9htVPy3fA29MrRGehn4Tfxw2H8X9FM3fa/qTn+m5Zgvs+Dkv04zY
         awUIA4mENtQT0ixr3bLwpdvu9dwl91+vuqchpJBV6QOrDIETLpSV75K2X/HVI/Gb+LTL
         1KaUF2/5Fp7Tu01DsM6AasAHVXyestlcUjaDVipt8LLjV0mE3rDfT7I/V/QsndGUAC2s
         fuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743761; x=1764348561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcoJ8yuTGg/KrnSVD2pTkyWBD3IkrYs48EOILusAwmM=;
        b=Ut63zYWI8KwYAXqgWDCENA8TyXnxmVAzA0EQi0uUEA/uDKIT9u10jpDXmfMRfCIwpu
         zSs/G4bWT9Eyh9dfqNGqtxhcL+kAAhcpYwK6iabsRJ1eWvSnOaRbHsWD4saSGUXjTQQM
         zbcuJiayqzpxg9Q6mfihNXDgK5XrUA55wocqDEunnrSRtpMBCpEeo4Shsndv8B7Xs46+
         s2ouVSwwBrcGERsVDq6rKa9CB4tZXG1mMQ7xUx/nxXZP5wBK7I+V/VKsqM6YIappwe87
         BwtXmlsWpR00Td0QjIYinO+GdbJe0qvVqaK+mQnOlx/BymmveP0ps5m2xsnBeMBPbwjS
         7PUw==
X-Forwarded-Encrypted: i=1; AJvYcCUbYyQ6zMxmNIsJrMEdt3S9rI8JFE0q6VGjH9Xz+mhvV19tODzR+e/tSIB+ZHNG+x9aGsWeSlRLRZR9@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpAE8+Gm6UPgF0rB8MgP0IIm8NUgh5xPvQgGXrWYBRRZ8+rJ7
	Onp3DonNOc7zALeZqDqBcyl4nJIUofFGkjdwzVPa6YQEO75qMxiC6HUsHiC4bpHNfSh9P0oMMQy
	baUa9Dehdmx5AJdfmQ5SjIXtaOePmMjcaAZS9
X-Gm-Gg: ASbGncvhMg5GquJOZtbOF6OEgxEGO5IJq5p4VTy/q9u0b4T4noNJpfMGeAkj6MkbuNX
	8NDSoP++lb16Djk4Ah666Asf9NXnp9fXZm5PCJ4PfookMxtcyflxfte/TZYacWj3WvJyYU8H4cw
	eDkm+xBghOYBXDiK0cbIG53cj9R5pN3sgMqgt8Vzv0jzgsO/aYUxD+9JmRnxSCfV95NoN6gVE6H
	Xm70+iOZKYNpTdm/CSxovxv6N6rC8mgQxrmdOk/Li6ggsQQZolofmcz0ed9mEjDGIfM3bl+2Wei
	+fkroIaR3CxoehptpTaG4gdaHfzQ
X-Google-Smtp-Source: AGHT+IFLgYj7eIYH6edinK9v6gYGRJPxMERa1CllZWiMpKj3np5PqtMDHUjJDbRUXeiod7C5u1iJUTltojORTv8h/N4=
X-Received: by 2002:a05:690c:4c04:b0:77f:92f7:d9c8 with SMTP id
 00721157ae682-78a8b54d73bmr22978557b3.48.1763743760964; Fri, 21 Nov 2025
 08:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121131305.332698-1-kartikey406@gmail.com> <20251121162732.GU196358@frogsfrogsfrogs>
In-Reply-To: <20251121162732.GU196358@frogsfrogsfrogs>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 21 Nov 2025 22:19:08 +0530
X-Gm-Features: AWmQ_bmA310usr2AoANdHDTxLpcVul1WXpNZ8P18feoiTKGntW1X3CQpEdMSQHQ
Message-ID: <CADhLXY7ZUmCFd07_DwwXhiQ3v4chjT7Zwv2=F9YKZiEqSTWCUg@mail.gmail.com>
Subject: Re: [PATCH] ext4: check folio uptodate state in ext4_page_mkwrite()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 9:57=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Nov 21, 2025 at 06:43:05PM +0530, Deepanshu Kartikey wrote:
> > When a write fault occurs on a memory-mapped ext4 file, ext4_page_mkwri=
te()
> > is called to prepare the folio for writing. However, if the folio could
> > not be read successfully due to filesystem corruption or I/O errors, it
> > will not be marked uptodate.
> >
> > Attempting to write to a non-uptodate folio is problematic because:
> > 1. We don't have valid data from the backing store to preserve
> > 2. A subsequent writeback could write uninitialized data to disk
> > 3. It triggers a warning in __folio_mark_dirty():
> >    WARN_ON_ONCE(warn && !folio_test_uptodate(folio))
> > This issue can be reproduced by:
> > 1. Creating a corrupted ext4 filesystem with invalid extent entries
> > 2. Memory-mapping a file on that filesystem
> > 3. Attempting to write to the mapped region
> >
> > The sequence of events is:
> > - User accesses mmap region -> page fault
> > - ext4_filemap_fault() -> ext4_map_blocks() detects corruption
>
>     ^^^^^^^^^^^^^^^^^^ what function is this?
>
> $ grep ext4_filemap_fault fs/ext4/
> $
>
> > - Returns error, folio allocated but NOT marked uptodate
> > - User writes to same region -> ext4_page_mkwrite() called
> > - Without check: folio marked dirty -> WARNING
> > - With check: return VM_FAULT_SIGBUS immediately
>
> Doesn't filemap_fault bring the contents into the folio and return
> VM_FAULT_SIGBUS if that fails?
>

Thank you for the review and for catching these issues!

You're absolutely right - ext4_filemap_fault() doesn't exist, and I
apologize for the confusion in my commit message. I need to do a more
thorough investigation of the actual code paths and understand precisely
when and how a non-uptodate folio can reach ext4_page_mkwrite().

I'll trace through the code more carefully, verify the exact reproduction
scenario with the syzbot reproducer, and ensure my analysis is accurate
before sending a v2. I want to make sure I fully understand:

1. The actual function call path (filemap_fault() and its error handling)
2. Under what conditions a non-uptodate folio can exist at mkwrite time
3. Whether filemap_fault() already handles all error cases appropriately

I'll get back to you once I have a clearer understanding of the issue.

Thank you again for your patience and guidance!

Best regards,
Deepanshu

