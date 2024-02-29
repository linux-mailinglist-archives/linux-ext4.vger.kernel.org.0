Return-Path: <linux-ext4+bounces-1441-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0A286D411
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 21:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A717B243D6
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 20:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A987D142901;
	Thu, 29 Feb 2024 20:19:58 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07501428FF
	for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237998; cv=none; b=ksfNdpo8f3bGK3zYJrzg25AHGlR731v8SkSeQyqw7OS7NegZ6fkrUTw0DFVZz/Yr8wncoicHrZM1dqDalnudGPiMFOfPTmLRbfDhCHr4c6axz0h5dtlIxEnuqWHkn7mzGh3ViJcoYjaBw2TNhIsg4jlb/EVVZBsxtzp+KH2naTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237998; c=relaxed/simple;
	bh=Ux9QLQigRWms1+9i0AkO8FM8qxG7ISIsp6Gke5erutk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b8Ds40VV23G6vi9JLtitCcV+NIijX+WvFv0FdhxBW8DV2zgzN9QlAe6ihEz26KuIrx5bISpnERn2n2KdeZqHhVlcsOukVOX4GKf2ucC2VvdPnTBJQV2pwTdExT1e70seriMB70mHw9jLcvWzuTi6iJOOnVVcJ1Mk3Pwm8X/bcjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id A00482792E; Thu, 29 Feb 2024 15:19:50 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] [RFC] Fix jbd2 to stop waking up sleeping disks on sync
In-Reply-To: <20240229145858.GE272762@mit.edu>
References: <20240227212546.110340-1-phill@thesusis.net>
 <20240229080759.GB57093@macsyma.local> <87edcv1h94.fsf@vps.thesusis.net>
 <20240229145858.GE272762@mit.edu>
Date: Thu, 29 Feb 2024 15:19:50 -0500
Message-ID: <877cin58gp.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Theodore Ts'o" <tytso@mit.edu> writes:

> Because no metadata changed, jbd2 will not even *start* a (jbd2)
> transaction as a result of that write (overwrite) to an already
> allocated data block..  Since it didn't start a jbd2 transaction for
> this file system operation, there's no reason to force a jbd2
> transaction to close.
>
> (Note: this could because there *is* no currently existing open
> transaction, or there might be a currently open transaction, but it's
> not relevent to the activity associated with the file descriptor being
> fsync'ed.)
>
> This is a critical performance optimization, because for many database
> workloads, which are overwriting existing blocks and using
> fdatasync(2), there is no reason to force a jbd2 transaction commit
> for every single fdatasync(2) issued by the database.  However, we
> still need to send a cache flush operation so that the data block is
> safely persistend onto stable storage.

So maybe what ext4's sync_fs needs to know is whether ANY writes have
been done since the last transaction committed?  Is there a way to know
that?  As long as NOTHING has been written since the last commit, then
there is no need to issue a flush.


