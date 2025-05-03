Return-Path: <linux-ext4+bounces-7635-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF22AA81BF
	for <lists+linux-ext4@lfdr.de>; Sat,  3 May 2025 18:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0433BE78F
	for <lists+linux-ext4@lfdr.de>; Sat,  3 May 2025 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47165158DD4;
	Sat,  3 May 2025 16:45:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B623B666
	for <linux-ext4@vger.kernel.org>; Sat,  3 May 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746290740; cv=none; b=eRlQpk4KG2gBWvPxWo9g3vCEjWDYTPx3t0YwHTKsMORxaEcA6d9RR61osLrI4MkQuB7qSLXTglcm97XUr7OzjTJIGx+tEvwxlCZW1h2L8cL3LaIiQCpIyK/vcnBXoEIPlJoZN1phk41BGXCgE3iHyeIKzWHWd7QRq9KDyX5QdEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746290740; c=relaxed/simple;
	bh=li07l0IeyaozfdcOT/7oaehDEBduR2nAQqo99s16UxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u45RYhZUh/kFq3H2HqJdzZdoY80ZfLwkwiBdmIzYvhIJ0NwcydJdBoQHfBGo8TGZQUmqiFIm11d3F6d6MJFzD48cCCLtXV4RcDZMgbNbBStvRPnwokK/RY5sRRGuEtYwiKfv4ZI/i+Xug6m5g9HfOIHUKJuVz05S62DC7kWZTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-148.bstnma.fios.verizon.net [173.48.82.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 543GjQeV019714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 May 2025 12:45:27 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 8CB8E2E00E9; Sat, 03 May 2025 12:45:26 -0400 (EDT)
Date: Sat, 3 May 2025 12:45:26 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nicolas Bretz <bretznic@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
        jack@suse.cz, adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: added missing kfree
Message-ID: <20250503164526.GE205188@mit.edu>
References: <20250502174012.18597-1-bretznic@gmail.com>
 <20250502203742.GF25655@frogsfrogsfrogs>
 <CAPXz4EO8vbVxksgftCaSXb3UgWa_oxrsiYVCkOQTz+4gYZ5k_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPXz4EO8vbVxksgftCaSXb3UgWa_oxrsiYVCkOQTz+4gYZ5k_A@mail.gmail.com>

On Fri, May 02, 2025 at 03:26:22PM -0700, Nicolas Bretz wrote:
> On Fri, May 2, 2025 at 1:37 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, May 02, 2025 at 10:40:12AM -0700, Nicolas Bretz wrote:
> > > Added one missing kfree to fsmap.c
> > >
> > > Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
> > > ---
> > >  fs/ext4/fsmap.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> > > index b232c2767534..d41210abea0c 100644
> > > --- a/fs/ext4/fsmap.c
> > > +++ b/fs/ext4/fsmap.c
> > > @@ -304,6 +304,7 @@ static inline int ext4_getfsmap_fill(struct list_head *meta_list,
> > >       fsm->fmr_length = len;
> > >       list_add_tail(&fsm->fmr_list, meta_list);
> > >
> > > +     kfree(fsm);
> >
> > OI: UAF, NAK.
> >
> > --D
> 
> I apologize, it definitely wasn't my intention. I guess not really
> putting my best foot forward...
> I don't yet fully get the UAF in this instance, but I'm studying it.

UAF == "Use After Free"

What this function does is to allocate a data struture, and then add
it to a linked list.  This is what list_add_tail() does.

By adding the kfree(), this will result in the callers of
ext4_getfsap_fill() trying to dereference a pointer to memory that has
been freed.  So your patch very cleary introduces a bug, and makes it
clear you (a) don't understand what lst_add_tail() does, and (b)
dont't understand what the ext4_getfsap_fill()function does, and (c)
almost certainkly didn't understand how to test a particular code path
and/or didn't bother to adequately test the code that you were trying
to modify.

For future reference, the commit description for this patch is also
not adequate.  Don't replicate in English what the change in the C
code is.  Explain *why* the change was made; what bug were you trying
to fix?  Or what performance optimization were you going for?  And
it's often a good idea to explain how you tested your change.

Cheers,

					- Ted

