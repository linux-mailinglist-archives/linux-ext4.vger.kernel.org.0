Return-Path: <linux-ext4+bounces-4534-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC39957C2
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 21:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47826B21814
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BC7213ECA;
	Tue,  8 Oct 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nuiF3fuB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAD1E04A0
	for <linux-ext4@vger.kernel.org>; Tue,  8 Oct 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416453; cv=none; b=WHZKvFYHWsMW13ljJk5oiBbI30dAktSx14M5QJm/o/kfNtLLh4OqKSxfjby0P694RMdRhRJ35e24iauF0n24nPrWMnpgUyp97bc5ps3nhJV9ullFJdBzbDmlg/Sy5GjWOacmyuuKLmYrGgt6VRyzO89Nntn0jVwGbi4oKkUMeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416453; c=relaxed/simple;
	bh=3ZiJ1osdCl4PY4SEDmKaRmQhtvL2xKX5rPv87erxH98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEyBeV3NsFOCY5Ouj2N2qCLefPx8801ux/SFYgSAAp5ew+SLRiimwPc6BiM5qHflMa/MDWysTeGqpJZOz3XbvrgDdafudvztIEj5knpHccZJKWbiBqtO7w5q/eKqG049sZGso+ezU8Ju/i2yMvVA+zWx2fOg3NSFAh33aeNYJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nuiF3fuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FCEC4CEC7;
	Tue,  8 Oct 2024 19:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728416453;
	bh=3ZiJ1osdCl4PY4SEDmKaRmQhtvL2xKX5rPv87erxH98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nuiF3fuB4Vbr6s9ZVtqZPhhhKB6FtjeQ3UrNDWZxSMwqDuZ2tLgemvXQWy7Z5P5L3
	 /QnFS0hLqc7NelYas+LlsM1KkaLSpHVZfdrcEkrUjDSvvE+YR0LOS/LDxebhk2Ry0D
	 V26KLnGiRzb5mKuKleDNQKdv1Fna1eoV8LjiG8i8=
Date: Tue, 8 Oct 2024 15:40:44 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Sunsetting ext4.wiki.kernel.org (unmaintained)
Message-ID: <20241008-therapeutic-impossible-cat-a21b7d@lemur>
References: <20241008-strange-hospitable-buzzard-b0e64c@lemur>
 <20241008161330.GA21832@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008161330.GA21832@frogsfrogsfrogs>

On Tue, Oct 08, 2024 at 09:13:30AM GMT, Darrick J. Wong wrote:
> > The ext4 wiki appears to be mostly unmaintained and contains pretty obsolete
> > data going back decades. I suggest we do the following:
> > 
> > - Archive the current contents as a static site on archive.kernel.org/oldwiki/
> > - Add an admonition on every page that:
> > 
> >   - the viewer is looking at obsolete contents
> >   - all up-to-date information is on https://docs.kernel.org/filesystems/ext4/
> > 
> > I.e. this is exactly we did for the unmaintained git wiki a while back.
> > 
> >     https://archive.kernel.org/oldwiki/git.wiki.kernel.org/
> > 
> > Please follow up if you have any objections, otherwise I will go ahead with
> > the plan.
> 
> I lost my account on the ext4 wiki when the login system got changed
> and never figured out how to get it back, so I migrated the one piece I
> cared about (the ondisk format docs) to the kernel and disowned the
> whole thing.  So I'm perfectly happy to have it archived before it gets
> taken over by adverse bots. :)

Great, this is now done.

Best regards,
-K

