Return-Path: <linux-ext4+bounces-12151-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C737CCA31D5
	for <lists+linux-ext4@lfdr.de>; Thu, 04 Dec 2025 10:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC9593087D5E
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Dec 2025 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCF932FA3F;
	Thu,  4 Dec 2025 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csHlZcFQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA85029E109
	for <linux-ext4@vger.kernel.org>; Thu,  4 Dec 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842105; cv=none; b=RFnTq8tC4//65IAhtKU+1lFI4xm4fYW7e9WosGVssa7PV4zYyRfAJrV1FvDZySVpDwftLeN+TFcY484VNoH3/QYspeXZvtiQYROA3Na1J77Wg4oVQO6IevsL24zKFKSCsMOs3hJVmTN+8M0S/pdNEyjgFr5GYlypbBWII5ARC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842105; c=relaxed/simple;
	bh=NKXfTvPSC5Jul9Vz6ttEG2Ka0O2fQQwhtd1usyJ9AOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLXmINQ23M/evERAMt4wHNq0qh5z4yD33kcHA1ITnPKIEmhFe8v9aQYCtcSgeiToi1m7jtIDj5Xs7H7/EHtdlTBy1j11zKzFCws5Ebi38E2vW735XnZWGQ2VnohwLuHN5Se0Q6sgPxKPzqLcw3a+nstoj8WEBRl+XmhP/aRcCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csHlZcFQ; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64308342458so610774d50.0
        for <linux-ext4@vger.kernel.org>; Thu, 04 Dec 2025 01:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764842102; x=1765446902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhUpNmHF/HUY2fSI5rMmPZKIo2hVHDCrZlh2jXPNUoE=;
        b=csHlZcFQcg+Yx19s5dowgRHeERQXCMp2RhjJsqAwotk762qcKZZYeXRj6i7naxT4M6
         qmifI1wRduzhAXgVwvftkEf+dljZ9HaWGF7HE16npKCoU04cMV9oKlOVL4nytDTRncQ1
         kYwF7xj0pHkdq64wmAEvxvy279Ecd2eHmIOntUzrsKk16OcZu3MWFCCPXWtU4Tmm4umT
         L5k0pk/7wOgs6tnO3ygn5QvJCckgC3kiYjgEjXE6khSrcy5U1rzTONM7nXluMg9KSa0g
         qYXrPe5X+9HhfFc7BYnvtpbZG50tJVcCb0lB2jO6c8lAYGGYk/OhFv6q7TsPD6YG9zWb
         vcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764842102; x=1765446902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bhUpNmHF/HUY2fSI5rMmPZKIo2hVHDCrZlh2jXPNUoE=;
        b=HdY/y9mjW2/p66YGpUfN7JGBsk27CHgzRkrEo4cX8gBeFPgRKBQ7/grFcN1IfQcE9G
         f1SUntiwtm8g8hz+9MqtOd0HCDgHrd/ZzaBkCsB3wvfOQOrslkxE/2il51Fx/RDdJrgh
         y32dONdXNpeXzO9JawdYnqkhmJFrD9bqX5i4gxIKX9P6v6XbokXMsG/7kdFO3Im/Vhu9
         B/E2Mf8Gwwx4u8bHmwcZtbemF+Gt2cpii7CI9LxUHsRX/RnCPA3rXpdFn5u/UNu3TZ5z
         15HD9UJtIapu9QfJdWPuFDKjYCChe18TlJZJx03bBQDh4regDpCB4U6z9BXvLvd7Jgi+
         OQRA==
X-Forwarded-Encrypted: i=1; AJvYcCVgN5Hfhvl0IaPzPAl/CbJMoKCUtXt6fhjUj1XsF1XAi1RUWeDS8QlKf4vJuWTgqyL5BpIstl1tomRI@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGNJ55j6jMdRaHlhe32CImW/Kul7iEPe/y1KHtRETWUWK+FBe
	Jstmc/uz+7tSpwA1k6A5sVcr9HyHm7jBeAg1yGCwpsa0dxta/JlTj1vfaX3/Y7dE2tvEPZVmFQ1
	v/GvzTogu8oGg3L4RuMprweA56o8sKy0=
X-Gm-Gg: ASbGncvZgSQGf06Ctm5LEgjyDkZtGLNUVZLho5mOW999+Sf0Vdbim7hPnCREWurT4mu
	8Y7kyUbrkLw107NHkRDFRK9nZcF0vs9LCpNj/ilfMia8pbchroSphMOb4mrFO3Brqm5f/wgyjaO
	+rMeg9gQwwcSUflKEzvlp2z1cvj8X/Q0uJGu3jM72dybPpNO3zdwS94/giTdPNmN7xpmn06bROQ
	/bxfPLLd2uxo9Edfk6Rq6Us693yOthar1YZdnViafQUBh6Rr0+PdFx2B9Lq3DOQcyu7Kjn6USFh
	94eipQnLLDGTqvErB6bAQ20iIu8/0MaPJ5iqcjET1xSRRbQoparsMFMdCWO0
X-Google-Smtp-Source: AGHT+IHAqOs/hXpIRBEs/f/rCUZyB7bqJoWZKZbng2VGQoM3dR9Ibi19yEJjVl6crNiPiM+pyvCz3TDn8wq94as11rg=
X-Received: by 2002:a05:690e:d8e:b0:641:f5bc:6960 with SMTP id
 956f58d0204a3-6443708c2f2mr4222726d50.76.1764842102555; Thu, 04 Dec 2025
 01:55:02 -0800 (PST)
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
 <20251203154657.GC93777@macsyma.lan> <aTCtITpW9yLNm2hz@casper.infradead.org> <20251203223300.GB71988@macsyma.lan>
In-Reply-To: <20251203223300.GB71988@macsyma.lan>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 4 Dec 2025 15:24:50 +0530
X-Gm-Features: AWmQ_bleqscabdFIzJHaCr5EHx7Q9GzF52i2AIG5rUXSp_pwV-NEBNgODiIp_f4
Message-ID: <CADhLXY4_yYdGQCYxq3=gQ6ZTJ7y_=dGsEBqdJ4g7JizX+ocVYA@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: check folio uptodate state in ext4_page_mkwrite()
To: Theodore Tso <tytso@mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, Zhang Yi <yi.zhang@huaweicloud.com>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com, 
	adilger.kernel@dilger.ca, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 4:04=E2=80=AFAM Theodore Tso <tytso@mit.edu> wrote:
>
> On Wed, Dec 03, 2025 at 09:35:29PM +0000, Matthew Wilcox wrote:
> > You snipped out all the context when adding me to the cc, and I'm on
> > holiday until after Plumbers, so I'm disinclined to go looking for
> > context.
>
> Sorry about that.  A quick summary.  Deepanshu was attempting to
> address a Syzbot complaint[1].
>
> [1] https://syzkaller.appspot.com/bug?extid=3Db0a0670332b6b3230a0a
>
> The TL;DR summary is that the syzbot complaint involved a maliciously
> corrupted file system which resulted file system getting detected when
> delayed allocation writeback attempts to do a block allocation.  Error
> handling calls mpage_release_unused_pages(invalidate=3Dtrue), which
> clears the uptodate flag via folio_clear_uptodate().
>
> Because syzbot mounts the file system using errors=3Dcontinue (which is
> the worst case; we're not panic'ing the kernel or forcing the file
> system to be read-only), we now have a situation where we have a folio
> which can be mapped, but !uptodate, but the file system can still be
> subject to changes.
>
> In the syzkaller reproducer, the potential malware might call
> ftruncate on the file, and this results ext4_truncate() calling
> ext4_block_truncate_page() which thentries to zero the page tail,
> which triggers a write fault, resulting in ext4_page_mkwrite() on a
> page/folio which is not uptodate.  It then tries to mark the folio
> dirty, mapped but !uptdate, and then __folio_mark_dirty() triggers:
> WARN_ON_ONCE(!folio_test_uptodate()).
>
> Since in Syzkaller assumes users are stupid enough to panic on warn,
> this is an urgent security issue because it's a denial of service
> attack which is CVE worthy --- where the system admiinstrator is
> stupid enough to allow an untrusted user to mount an untrusted,
> maliciously crafted file system, instead of using fuse2fs.  The
> security people thinkt his is super-duper important.  Personally, I
> don't think it's all that urgent, so by all means, don't feel obliged
> to think about this while on vacation.  :-)
>
> Anyway, that's the context.  Deepanshu has a proposed fix here[2]
> which puts a folio_lock() into every single write page fault for ext4:
>
> +       folio_lock(folio);
> +       if (!folio_test_uptodate(folio)) {
> +               folio_unlock(folio);
> +               ret =3D VM_FAULT_SIGBUS;
> +               goto out;
> +       }
> +       folio_unlock(folio);
>
> [2] https://lore.kernel.org/r/20251122015742.362444-1-kartikey406@gmail.c=
om
>
> This seems.... unfortunate to me, so the first question is, "is
> locking the folio really necessary"?  (I suspect the answer is no),
> and two, should this check be done in the mm layer calling
> page_mkwrite(), or in ext4_page_mkwrite()?
>
> Presumably, this might happen for other file systems, with either
> syzkaller coming up with this rather implausible scenario of really
> stupid, unfortunately system adminsitrator choices --- or in real
> life, if we do have some system adminisrtators making really stupid,
> unfortunate life choices.  So maybe we should this check should be
> done above the file system layer?
>
>                                                 - Ted
>
>
>
>
>
>
>
> >
> > On Wed, Dec 03, 2025 at 10:46:57AM -0500, Theodore Tso wrote:
> > > My main concern with your patch is folio_lock() is *incredibly*
> > > heavyweight and is going to be a real scalability concern if we need
> > > to take it every single time we need to make a page writeable.
> > >
> > > So could we perhaps do something like this?  So the first question is
> > > do we need to take the lock at all?  I'm not sure we need to worry
> > > about the case where the page is not uptodate because we're racing
> > > with the page being brought into memory; if we that could happen unde=
r
> > > normal circumstances we would be triggering the warning even without
> > > these situations such as a delayed allocaiton write failing due to a
> > > corrupted file system image.   So can we just do this?
> > >
> > >     if (!folio_test_uptodate(folio)) {
> > >             ret =3D VM_FAULT_SIGBUS;
> > >             goto out;
> > >     }
> > >
> > > If it is legitmate that ext4_page_mkwrite() could be called while the
> > > page is still being read in (and again, I don't think it is), then we
> > > could do something like this:
> > >
> > >     if (!folio_test_uptodate(folio)) {
> > >             folio_lock(folio);
> > >             if (!folio_test_uptodate(folio)) {
> > >                     folio_unlock(folio);
> > >                     ret =3D VM_FAULT_SIGBUS;
> > >                     goto out;
> > >             }
> > >             folio_unlock(folio);
> > >     }
> > >
> > > Matthew, as the page cache maintainer, do we actually need this extra
> > > rigamarole.  Or can we just skip taking the lock before checking to
> > > see if the folio is uptodate in ext4_page_mkwrite()?
> > >
> > >                                                     - Ted


Hi Ted,

Thank you for the detailed summary and context.

Based on Matthew's earlier feedback that we need to "prevent !uptodate
folios from being referenced by the page tables," I believe the
correct fix is not in ext4_page_mkwrite() at all, but rather in
mpage_release_unused_pages().

When we invalidate folios due to writeback failure, we should also
unmap them from page tables:

  static void mpage_release_unused_pages(..., bool invalidate)
  {
      // ... existing code ...

      if (invalidate) {
          if (folio_mapped(folio))
              folio_clear_dirty_for_io(folio);

          // Unmap from page tables before invalidating
          if (folio_mapped(folio))
              unmap_mapping_folio(folio);

          block_invalidate_folio(folio, 0, folio_size(folio));
          folio_clear_uptodate(folio);
      }
  }

This way:
1. No performance impact on normal operations (only in error path)
2. No folio_lock() needed in ext4_page_mkwrite()
3. Prevents stale PTEs from referencing invalidated folios
4. Any subsequent access triggers a new page fault instead

To address your question about whether this should be in MM layer:
other filesystems could hit this same issue if they use delayed
allocation and invalidate folios on writeback failure. However,
since the invalidation is happening in ext4-specific code
(mpage_release_unused_pages), fixing it there seems appropriate.
If this pattern appears in other filesystems, perhaps the fix
could be moved to a common helper.

I'll send v3 with this approach. Does this look correct?

Best regards,
Deepanshu

