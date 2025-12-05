Return-Path: <linux-ext4+bounces-12211-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FFDCA8134
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 16:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D1FB31861C3
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25D232E735;
	Fri,  5 Dec 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQTYUbe7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7F32142A
	for <linux-ext4@vger.kernel.org>; Fri,  5 Dec 2025 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764944930; cv=none; b=FC+i2GheB+PqwDQQ2bvEtk4iEWEVPbThg1YP6gHuvbn0voSZhdQi2oN1u//n4+mwu01dcZAceA7wRPEDNuFHWR3/Xzcon1dLll0s4FBW37B1he8GCwtoxOIZ1CaDqEgTv7yFUS6PTddcC1ePUo3MfdYdi7pNSi7XViJaIL9WfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764944930; c=relaxed/simple;
	bh=0w49YD5p4IAfOte/jhiN9utnEq29Oe7fSSlKD5/IY2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHC1hqP0HBGHNrt+y8QMVQv7hxQBR2YCsNaeJn6sqnTFLTcFC4DiN4Ng70y85ARD+EIME7xyoTI+SXwAJhPXk+xdgfQrL8a0wsac3ngfi8ZPYDnt9Tfv1oLDQpc7xok4op8XGMFgbpovrIM4i3jU7E1QniAYztSLXfxjW263TZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQTYUbe7; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64107188baeso1916017d50.3
        for <linux-ext4@vger.kernel.org>; Fri, 05 Dec 2025 06:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764944924; x=1765549724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ib3BYGdPU9esaljRdCO1OKAvsNdIiEmKFGmAi/+DGGk=;
        b=YQTYUbe7DYXvuSNQCCA//3CNqWrtqxawnKnDMebggOfki/zSp2xJRadXFrAbfTfV6Z
         cTJiNIOcoWnth0FLyZtoEJCZsoOkwEP4wh/HWG18Iq8XeytRpTk8I/AIFHoITPFBD9gN
         4qLT4NI5+LLbpbOOHF9kricL1hK9YufO62XDXRKZM6G1yrwU+EAw2Pm5gYn5OL4jqZei
         0R6RbaZVkL1BZVqXZTfWiqj/iFGG0fn7weotlTDDOo9/JubLDmXZGr/0rRw0jE7CpinP
         UzDWrY8dXPAagdpcKodMJKStwSE/v+NDLHoqYTrTFpjoqr9BxaDqECPg72wc3V4JKW7u
         cwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764944924; x=1765549724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ib3BYGdPU9esaljRdCO1OKAvsNdIiEmKFGmAi/+DGGk=;
        b=SBhawCw8U9xgDlkLy4Zz/jam4K3WzKmfWy1EjQq+vaNtvyCu+o5oimgz3h0vW8JzCD
         1PKMCYo9Cllksf7KkqKJF+AU0dLbzdIAgBaYPahUCHxOWhm3OR0yxvREkPHt8FDpNRIs
         XUKECiOFNZ1jGW0dsiAOCN0lAvJVGZDqTDlYburWkDUsZ+scKSjVIfg0ovht7TcWptfL
         EpMppXlH0iaYjvx8qNyQRkU6CoEU2oyAKcNER6bDo1YaInHK/76rlw1GCKsfd7+2seEY
         Fzpy/SDwAvNUi/e3gY2z8QGKR8Wfawqs/KStJTAOvaYF2ptYpb1E1cfUNSzaMvdEwJnK
         VoBw==
X-Forwarded-Encrypted: i=1; AJvYcCXu+iijjsGiJZ2nzlMwwWBztM1au7LSxHqC0OwZm+svVHwB1d3ZyRSdq5aKNTsnnbt8yem5lHVkntoz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4eZZC2FNSjiS1oHCnPuP33dSQZ1YyjTbkwrp8LoBd1vV5Ro/
	VR8YkAO6JgMsVKr0sfivm5RrCZCbNe4/GIYAFlqsmqrQo+2BNlXw91WKJ/GryFSU3x1BNQ8aOVg
	EPyf/E9inUL8r+mxmGitB9w8Fkt1raTE=
X-Gm-Gg: ASbGnctChEdPdG+ve04cMVnb2dxt7Y4ljwhWEuzMjgUWb0LgMH3DYbHX/LBpUiBiRMk
	ukFtZ2ux0bM7EMJ5BxoWrIb8SKOKQlCYtzRjPz+9AzgkemzvstctackccyT12igfZXUqrZ77sTx
	jBlq17fO47Bqgs+e5owdBVYslbpawG1EM8HOxX96mobuF/Y0gssYJYnsfHdnd0CjQ3DhvDU/H1e
	IgndLvOmCTGGyKceApwIHnKMSNRZdHewgj9ToK162w70+i1YNtll1ETaFmrDUCR60soqjLGjN41
	QxTXGgUSk7pfccsLdxwRh2AzsoQ4HhSVb9LhqY2M0/zEBf6P1AbT87TuaXQI
X-Google-Smtp-Source: AGHT+IH5zthPNNQb2+zZ0CiGfTgkQXzRD3Iiz4YNh7B8gJ1hJ22r1svcZPUfm3/LW88TDbHA5uvACOJJ3HrCf4BSjMM=
X-Received: by 2002:a05:690e:4104:b0:641:f5bc:695a with SMTP id
 956f58d0204a3-64437050894mr6846325d50.70.1764944924032; Fri, 05 Dec 2025
 06:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
 <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com> <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
 <20251203154657.GC93777@macsyma.lan> <aTCtITpW9yLNm2hz@casper.infradead.org>
 <20251203223300.GB71988@macsyma.lan> <CADhLXY4_yYdGQCYxq3=gQ6ZTJ7y_=dGsEBqdJ4g7JizX+ocVYA@mail.gmail.com>
 <20251205021818.GF71988@macsyma.lan> <aTJSglQznqeph5lM@casper.infradead.org> <20251205133739.GA19558@macsyma.lan>
In-Reply-To: <20251205133739.GA19558@macsyma.lan>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 5 Dec 2025 19:58:31 +0530
X-Gm-Features: AWmQ_bmwsf1Nobc1D1Ulj7VX8mQpaR9_neeIMmtYesdVS3UoeIIAqx8LYKo4o6o
Message-ID: <CADhLXY6bvnv9eipp1Uo5N3s9dKFoqEL+qom+ni3_4D_==+wJAg@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: check folio uptodate state in ext4_page_mkwrite()
To: Theodore Tso <tytso@mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, Zhang Yi <yi.zhang@huaweicloud.com>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com, 
	adilger.kernel@dilger.ca, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 7:08=E2=80=AFPM Theodore Tso <tytso@mit.edu> wrote:
>
> On Fri, Dec 05, 2025 at 03:33:22AM +0000, Matthew Wilcox wrote:
> > It sounds like I was confused -- I thought the folios being
> > invalidated in mpage_release_unused_pages() belonged to the block
> > device, but from what you're saying, they belong to a user-visible
> > file?
>
> Yes, correct.  I'm guessing that we were marking the page !uptodate
> back when that was the only way to indicate that there had been any
> kind of I/O error (either on the read or write side).  Obviously we
> have much better ways of doing it in the 21st century.  :-)
>
> > Now, is the folio necessarily dirty at this point?  I guess so if
> > we're in the writeback path.  Darrick got rid of similar code in
> > iomap a few years ago; see commit e9c3a8e820ed.  So it'd probably be
> > good to have ext4 behave the same way.
>
> Hmm, yes.   Agreed.
>
>     commit e9c3a8e820ed0eeb2be05072f29f80d1b79f053b
>     Author: Darrick J. Wong <djwong@kernel.org>
>     Date:   Mon May 16 15:27:38 2022 -0700
>
>     iomap: don't invalidate folios after writeback errors
>
>     XFS has the unique behavior (as compared to the other Linux
>     filesystems) that on writeback errors it will completely
>     invalidate the affected folio and force the page cache to reread
>     the contents from disk.  All other filesystems leave the page
>     mapped and up to date.
>
>     This is a rude awakening for user programs, since (in the case
>     where write fails but reread doesn't) file contents will appear to
>     revert old disk contents with no notification other than an EIO on
>     fsync.  This might have been annoying back in the days when iomap
>     dealt with one page at a time, but with multipage folios, we can
>     now throw away *megabytes* worth of data for a single write error...
>
> As Darrick pointed out we could potentially append a *single* byte to
> a file, and if there was some kind of writeback error, we could
> potentially throw away *vast* amounts of data for no good reason.
>
>                                      - Ted


Hi Ted and Matthew,

Thank you for pointing out the iomap commit. I now understand that
invalidating folios on writeback errors is the wrong approach.

Looking at Darrick's commit e9c3a8e820ed, iomap removed both
folio_clear_uptodate() and the invalidation call, keeping folios in
memory with their data intact even after writeback errors.

For ext4, should I apply the same approach to mpage_release_unused_pages()?
Specifically, remove the invalidation entirely:

  if (invalidate) {
      /*
       * On writeback errors, do not invalidate the folio or
       * clear the uptodate flag. This follows the behavior
       * established by iomap (commit e9c3a8e820ed "iomap:
       * don't invalidate folios after writeback errors").
       */
      if (folio_mapped(folio))
          folio_clear_dirty_for_io(folio);
-     block_invalidate_folio(folio, 0, folio_size(folio));
-     folio_clear_uptodate(folio);
  }

This would:
- Keep user data in memory instead of discarding it
- Prevent the WARNING since folio remains uptodate
- Match the behavior of modern filesystems
- Prevent data loss from discarding potentially megabytes of data

Is this the correct approach? If so, I'll send v4 with this fix.

Best regards,
Deepanshu

