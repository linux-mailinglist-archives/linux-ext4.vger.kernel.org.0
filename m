Return-Path: <linux-ext4+bounces-8018-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5CDABC182
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 17:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CFC7AC8CA
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A428467E;
	Mon, 19 May 2025 14:59:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601261C7005
	for <linux-ext4@vger.kernel.org>; Mon, 19 May 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666797; cv=none; b=qUUbOL3cRElaMMVdk7WuK9G2zs0RLy+y8+E2fIlOLMSNNQjb6K9BEYXoWMSEEMWj+ueV6Kywf3hiiJFSQszpFIHyXT1NfL1fE0lwL3k9ggVNEN89zsinRGaO1NU0ftWMdp3N88J43DnO79A5z+UUgGOkgVIsoAeF5JknFRhWPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666797; c=relaxed/simple;
	bh=W2vxPFvtMSGFDX01i+sEwTDfFarvJeP/3Ri9KeQvVsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpA1PDgMZoeiY9njgRPAQnekoB1/cZYxkAJlyW5gUUwhtLvgb5ejoCG+rCS6zEqE4JeutqggxEuTyNU9wEWrOaFINI8hpqP2MFlsbFjBMMFYK3DApdzzv92l1hwiiyYsRu0xhBhz0EVjF3ZV8lMjISpVsfBFbuxHrBWxnR+iBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54JExUl7002060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 10:59:31 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 74B8E2E00DD; Mon, 19 May 2025 10:59:30 -0400 (EDT)
Date: Mon, 19 May 2025 10:59:30 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kees Cook <kees@kernel.org>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: replace strcpy() with '.' assignment
Message-ID: <20250519145930.GB38098@mit.edu>
References: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>
 <202505190651.943F729@keescook>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505190651.943F729@keescook>

On Mon, May 19, 2025 at 06:52:13AM -0700, Kees Cook wrote:
> > --- a/fs/ext4/inline.c
> > +++ b/fs/ext4/inline.c
> > @@ -1314,7 +1314,7 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
> >  		if (pos == 0) {
> >  			fake.inode = cpu_to_le32(inode->i_ino);
> >  			fake.name_len = 1;
> > -			strcpy(fake.name, ".");
> > +			fake.name[0] = ".";
> 
> This means the trailing NUL byte isn't being copied any more? That seems
> like a big change, even if name_len is being used for length tracking.

Yeah, and so that's something that needs to be tested (and not just
build tested to catch the obvious FTBFS bug).  However, note how we
handle normal filenames, as opposed to "." and "..".  From
ext4_insert_dentry():

	de->inode = cpu_to_le32(inode->i_ino);
	ext4_set_de_type(inode->i_sb, de, inode->i_mode);
	de->name_len = fname_len(fname);
	memcpy(de->name, fname_name(fname), fname_len(fname));

Or were you commenting on the "no functional changes intended" line in
the commit description?  I agree that this is probably no longer
accurate.  :-)

					- Ted

