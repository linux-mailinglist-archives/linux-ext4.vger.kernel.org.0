Return-Path: <linux-ext4+bounces-9217-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE5BB14F7C
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 16:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EDF4E455B
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 14:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83B81E633C;
	Tue, 29 Jul 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwk+hC9D"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE91E492;
	Tue, 29 Jul 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800327; cv=none; b=IW2O1wbFxrbZZcOCKfF6DMYcsysESh5jDMyH59TzrKFiVGS+JoyVoJmn+BQfwmD7vCXvpPwrYEhbGOu2ETubdq/iRnWtMJIbV6jjln001QWfs2dlL13q9FtkJM4cLffdxV1Q8nsNQ7RzBA1AkZYNHecLgXWJC7FAKwDlB3OwYgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800327; c=relaxed/simple;
	bh=F/Bh+Ko7ppvbg/wnZKDwtyoTD+8mKkxRf3M7eQV81Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQSGH4AyDtqHklkl0tGiPe8BorZLbQBQHa1hXdGNKECaezXc34huLYOpbhtsLHQQqLCtv/s9rVmpo+NlcpkvFyp8Zm+rW0Up5pMboMIaVemGKfpNaYHJTcjfqoYklNzdsG07NNo4jpV6HCBrNKHQoy5Sfz40WjGld4AVYzgrgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwk+hC9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0354FC4CEF4;
	Tue, 29 Jul 2025 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753800327;
	bh=F/Bh+Ko7ppvbg/wnZKDwtyoTD+8mKkxRf3M7eQV81Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwk+hC9DrAJEjata9Hgdy5oewaZG9KXV8YmIkeUonkXlDl9Mo/ZaRNNAAFHmLlXIm
	 KLHSpkAK72Q0nnZKayxuc8nOidM4LctrisYowwCVXZ0GcqvgP6CwEc2BrW49MlMhII
	 QffzsvQNO4ow09OKUf8X1rnNUinMUPXjz63ccvCaoZRxTXxjy2neZm4rMNokYZhfSW
	 2bPa/99E7L7WnnOlI1tOfD+ALfreLAq4WKutVmwVgktgg7u+4/vPIHsWJL/PYiNt9i
	 c0OmBB5PYJXqf/iRUoposDzCl13gxxlfMU5R744HRzpyscXfbxBADBajxAfGIKc1j3
	 NtG88owBSUi/A==
Date: Tue, 29 Jul 2025 07:45:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: John Garry <john.g.garry@oracle.com>, Zorro Lang <zlang@redhat.com>,
	fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <20250729144526.GB2672049@frogsfrogsfrogs>
References: <7fc0f04e-dcec-47a4-b522-eb5a8b90637c@oracle.com>
 <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
 <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
 <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
 <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <3a4854ac-75ad-4783-acbd-048fe7c7fdb0@oracle.com>
 <aIhmG-l4nWOAzz2I@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIhmG-l4nWOAzz2I@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Tue, Jul 29, 2025 at 11:41:39AM +0530, Ojaswin Mujoo wrote:
> On Mon, Jul 28, 2025 at 03:00:40PM +0100, John Garry wrote:
> > On 28/07/2025 14:35, Ojaswin Mujoo wrote:
> > > > We guarantee that the write is committed all-or-nothing, but do rely on
> > > > userspace not issuing racing atomic writes or racing regular writes.
> > > > 
> > > > I can easily change this, as I mentioned, but I am not convinced that it is
> > > > a must.
> > > Purely from a design point of view, I feel we are breaking atomicity and
> > > hence we should serialize or just stop userspace from doing this (which
> > > is a bit extreme).
> > 
> > If you check the man page description of RWF_ATOMIC, it does not mention
> > serialization. The user should conclude that usual direct IO rules apply,
> > i.e. userspace is responsible for serializing.
> 
> My mental model of serialization in context of atomic writes is that if
> user does 64k atomic write A followed by a parallel overlapping 64kb
> atomic write B then the user might see complete A or complete B (we
> don't guarantee) but not a mix of A and B.

Heh, here comes that feature naming confusing again.  This is my
definition:

RWF_ATOMIC means the system won't introduce new tearing when persisting
file writes.  The application is allowed to introduce tearing by writing
to overlapping ranges at the same time.  The system does not isolate
overlapping reads from writes.

--D

> > 
> > > 
> > > I know userspace should ideally not do overwriting atomic writes but if
> > > it is something we are allowing (which we do) then it is
> > > kernel's responsibility to ensure atomicity. Sure we can penalize them
> > > by serializing the writes but not by tearing it.
> > > 
> > > With that reasoning, I don't think the test should accomodate for this
> > > particular scenario.
> > 
> > I can send a patch to the community for xfs (to provide serialization), like
> > I showed earlier, to get opinion.
> 
> Thanks, that would be great.
> 
> Regards,
> John
> > 
> > Thanks,
> > John
> > 
> 

