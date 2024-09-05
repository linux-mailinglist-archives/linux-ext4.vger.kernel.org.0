Return-Path: <linux-ext4+bounces-4061-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6296D9F6
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 15:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE15CB241F4
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087819CCF3;
	Thu,  5 Sep 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IflxzLXI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1B189518
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542162; cv=none; b=EjE7rVjziejG20OXRGQ4syByvAHqVA7JknLGCdassvbdGkFJAH/2T2t+0egyibTcrft05GUch24lO/RDP2P4U2CxD8JsoCF22MpIHA0nAvAaxw+1QtqO2txS6GYH4FSBagZ55f0gkPY1r6ngsr30+MgdbXtdhnLbLZq0Ru4lAFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542162; c=relaxed/simple;
	bh=afHqgtw86MJ+FBgkfRvINSiZszn6M9ndau3tFH8IFzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOkmlV39axKpf+w11I2r9yjyJBJ50nLoH8II+XJFXJLORtpi/dKQeQW+ZAY/AgE06FxbSE1rBrPvm52Px5xEtZJ+qFvpDLRy9hlGQ/1xWTiKNCQ9S7y7uNH0ihH166J1pOY/8S7MzmiSIxcdbLn4zEcc5ghbXHS77S9YctBaKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IflxzLXI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485DFhge007641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 09:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725542144; bh=fCpMnYbCMJxjggQ6WNCqfhLremBs4B8YsJHj50qaa1w=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=IflxzLXIwjxflZaCqzr5qBMuX3eBLLjEZueB/sEUEuCxV4iWZHFMWLwIQ5nm7MhTy
	 tefBTyWvf8Nz/xbnedXkwtNLEtnColmZcKQMQQEdcQVYzQGv7DyjyeyO3OoEZkT38h
	 UsKTMrzkH8RR0bmTESMEpw9iHBwns34Ih49ikIj9Gt6HWksjU+r0+Zdi0SQXe2LjMl
	 yUuiyLMmfjST9fsSB99YrRBfTY16XX8lfiN/q6C16D38p1HH8IYYpwcy2vzNC0WWVl
	 PAx4aiRgFNzBlG+4NB6sp9VW0w4fWqHr4N8E2Z7vO4Z9j/Y0nZLzNp5rCt53gx7w2q
	 0nFQ0hpAzaWXQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 036D715C02C6; Thu, 05 Sep 2024 09:15:43 -0400 (EDT)
Date: Thu, 5 Sep 2024 09:15:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: BUG: 6.10: ext4 mpage_process_page_bufs() BUG_ON triggers
Message-ID: <20240905131542.GS9627@mit.edu>
References: <ZtirReiX7J+MDhuh@shell.armlinux.org.uk>
 <Zti1Y5fthhgiL5Xb@shell.armlinux.org.uk>
 <Zti6G4Wq3pQHcs++@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zti6G4Wq3pQHcs++@shell.armlinux.org.uk>

Hmm, so you can reliably reproduce this when you boot the VM into
6.10, but not when using 6.7?  And this is on an arm64 system,
correct?  What is the VM doing?  Does this show up when you boot it,
or when you kick off some kind of appliance?  What sort of devices are
you using with the VM, and what is the VMM that you are using (e.g.,
qemu, Oracle's Cloud, etc.)?

Is the VM image something you can share?  Or can you share the
metadata-only image using the e2image -Q command?

						- Ted

