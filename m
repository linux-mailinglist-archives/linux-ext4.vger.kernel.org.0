Return-Path: <linux-ext4+bounces-7585-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0321AA5256
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 19:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EFD1727C2
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB55218EB1;
	Wed, 30 Apr 2025 17:00:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B46264FAC
	for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746032414; cv=none; b=j7NvcpHpuXFD1q4r8a3daFyd2WQBzc+R6jsAr2nZ7kdPfie1C06XHGXvucq1VBPq40b3gSkXy9ZaHhrH1ULQ/xeFnFBmGB3Fl04pz/LD3JC1EcSDK5ryVqtJFBCliH1Dzl8Nnno9jgeOMx2NA3hCSRJ86GVoRcxixl2gpFQRFsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746032414; c=relaxed/simple;
	bh=Z87FKH5fiLnYVs6nKFZMzt6Ui7gQNYjiZSqwgqtXPWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXz4R6Vo7wjDUD01a7AtXE5+We5swPLBPjpvJoxrGRxhFecSVYutbxKN622rdV9dxMMpW43ZYzsz/zDmRmlNSSy6eLPPcZlLoUAktOyJMOxvUTFTxG3bEorebdOkYldI4F0LDY8SYZpewUAD84DDROQhVgfjDCZ/9uWqdJIJY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-201.bstnma.fios.verizon.net [173.48.112.201])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53UH03f8004398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 13:00:04 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B81E22E00E9; Wed, 30 Apr 2025 13:00:03 -0400 (EDT)
Date: Wed, 30 Apr 2025 13:00:03 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrea Biardi <Andrea.Biardi@viavisolutions.com>
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: ext4 filesystem corruption (resize2fs bug)
Message-ID: <20250430170003.GA29583@mit.edu>
References: <BN9PR18MB42196A214D588B1F60D1B03398832@BN9PR18MB4219.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR18MB42196A214D588B1F60D1B03398832@BN9PR18MB4219.namprd18.prod.outlook.com>

On Wed, Apr 30, 2025 at 03:21:30PM +0000, Andrea Biardi wrote:
> Hi,
> 
> Apologies for posting to the kernel mailing list, I'm trying to get
> the attention of the maintainer of e2fsprogs (tried emailing him
> directly a few times but never received a reply).

Hi,

I've checked my e-mail backlog and I don't seem to see any e-mails
from you.  What e-mail address did you use?

> Almost 2 years ago I filed a bug against resize2fs that causes massive filesystem corruption (https://github.com/tytso/e2fsprogs/issues/146).
> An e2image causing the bug was attached. Analysis and patch was also attached.

I saw the ping of the github issue #146 so it's been on my to do list.
I've noted the patch at https://github.com/viavi-ab/e2fsprogs and I'll
try to take look at it this week.

In general, though, the best place to send patches or bug reports is
to send them to linux-ext4@vger.kernel.org mailing list.  Other ext4
developers can review patches for both e2fsprogs and the ext4 kernel
code, and send suggestions to patch submitters when they are sent to
the linux-ext4 mailing list.

In contrast, I'm the only person who monitors the github project,
which happens only on a best-efforts basis, with patches sent to the
linux-ext4 mailing list are much higher priority, for which I have
tools like patchwork and b4 to track and apply outstanding patches.

Cheers,

						- Ted



