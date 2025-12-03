Return-Path: <linux-ext4+bounces-12142-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97670C9FA61
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13BB030026A8
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293A322C83;
	Wed,  3 Dec 2025 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Uvt661/y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9931ED7C
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776908; cv=none; b=q1mna5McaT4nlSGXerS0JFxystPRmcfLPTCAI9+XQLBlf+M0TB+jgahpKD8oBp+NutBgJTbsGvM9IMIYSWyuML9kGH0bEZ0qvC0jD85EBcHYyjhX2ynOwVB5H7IRXclf4FJ/mAgyGssrKEHyF4Eg0I9uycx/s7/T7RV1hLluDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776908; c=relaxed/simple;
	bh=zCwP4XXCy6XxZx9P4QPv4P+HWaweJHypEQImObxj06Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXNBvReElitGOh4KGk7+pbL+r6gtdXuVr/VqMU8p3u+NVES9vaS67ELDlgJwKiw4Dp1noFCPTTl0WtBNAm68Yfvp3tXR62WE3h24gVYp01OLs7YmYD1dapgWe+TXkiAYAlI8DCLgeEa+f0LqBbGdArJl8LXNog408JDa1M/Ea64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Uvt661/y; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-102-187.bstnma.fios.verizon.net [173.48.102.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B3Flv5P020621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Dec 2025 10:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764776881; bh=oeGpzinUO/gbdajuvDYn7ZxEreR2Jiq4u87p4qfhUTo=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Uvt661/yfY2OC7w25ej6lDdyHZ/euPu6C5UBIrvOzCw5JfdaDVw4iA+HPWXXWm5CV
	 z/Hm89N9ioeQ0baKKTc9loMEGBvGJTGbMb/vc3CTd1Y0QZpfq7IYltAjQMWK1x6gJh
	 WbStbPpqwd6/Y4AY6XxUWFqGxznsXsl727aAAKbFNDGcD0qamjsTS77Y7hkD6jtkDP
	 aeKFCiNMaETt2ng9qP7t89/6H8Jbf2aYJNCj1AteHLq3Gs4Zd48MK0cmExb3BpoWxc
	 InJjfT7OQRxWCnp7d4NL9xAA2tZERml3wlNmRNw+9+TSyi8vnszcWi4kHwkE/ralSg
	 iUQzx+lQSSRFg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 2FFDF4E17D5A; Wed,  3 Dec 2025 10:46:57 -0500 (EST)
Date: Wed, 3 Dec 2025 10:46:57 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] ext4: check folio uptodate state in
 ext4_page_mkwrite()
Message-ID: <20251203154657.GC93777@macsyma.lan>
References: <20251122015742.362444-1-kartikey406@gmail.com>
 <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
 <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
 <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com>
 <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>

My main concern with your patch is folio_lock() is *incredibly*
heavyweight and is going to be a real scalability concern if we need
to take it every single time we need to make a page writeable.

So could we perhaps do something like this?  So the first question is
do we need to take the lock at all?  I'm not sure we need to worry
about the case where the page is not uptodate because we're racing
with the page being brought into memory; if we that could happen under
normal circumstances we would be triggering the warning even without
these situations such as a delayed allocaiton write failing due to a
corrupted file system image.   So can we just do this?

	if (!folio_test_uptodate(folio)) {
		ret = VM_FAULT_SIGBUS;
		goto out;
	}

If it is legitmate that ext4_page_mkwrite() could be called while the
page is still being read in (and again, I don't think it is), then we
could do something like this:

	if (!folio_test_uptodate(folio)) {
		folio_lock(folio);
		if (!folio_test_uptodate(folio)) {
			folio_unlock(folio);
			ret = VM_FAULT_SIGBUS;
			goto out;
		}
		folio_unlock(folio);
	}

Matthew, as the page cache maintainer, do we actually need this extra
rigamarole.  Or can we just skip taking the lock before checking to
see if the folio is uptodate in ext4_page_mkwrite()?

							- Ted

