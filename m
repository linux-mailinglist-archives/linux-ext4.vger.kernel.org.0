Return-Path: <linux-ext4+bounces-6752-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE75FA596D7
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 14:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CAE16A1AE
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B722AE76;
	Mon, 10 Mar 2025 13:58:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2A122B8AA
	for <linux-ext4@vger.kernel.org>; Mon, 10 Mar 2025 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615121; cv=none; b=gecsXrl91xC5rZL6ymM/A8sdyuZm2tWbh51RZbzNxvqWlImY04BXB+7tIj716i0vAeocg7xdxxA2lrDHJAD/y/aMfYyBlUAIaOixtN8o77KdjF5SgYEIYmsq4v29dpTH4L3xmSnkh+wwjYa83VsQIRCikzoyyHy5Eek9OiSE2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615121; c=relaxed/simple;
	bh=IRZ909ZOQaifWp9oE/ioYqYVL8y3ap2vj5f4p5RduC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+qTACrRBXKGtLez5f2Flwt7zFBWNvLtKlCjqpCcOCFyGBporSdTDJwwK6sdCe7CWzPsrK1GmOMvl3wkkIB2dJVDz9/aP/8UgxkJDJXcjmPqpNH6QychKM9QJvS6X9VR4xmG63oR0KFy4kBqUVGKTd8nmemKoBZKjOHvGcLN+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52ADwSVL020780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 09:58:29 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id A0FD32E010B; Mon, 10 Mar 2025 09:58:28 -0400 (EDT)
Date: Mon, 10 Mar 2025 09:58:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A syscall for changing birth time
Message-ID: <20250310135828.GB8837@mit.edu>
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>

On Mon, Mar 10, 2025 at 07:26:00AM +0000, Artem S. Tashkinov wrote:
> 
> Why is it that the Linux kernel supports reading btime, but there's no
> syscall to change it? At least for ext4 there's the debugfs utility, but
> for other filesystems there's just nothing. And even debugfs is not a
> solution, since it requires root privileges and an unmounted/mounted RO
> filesystem.

POSIX and Single Unix Specification also doesn't provide a way to
allow userspace to set ctime (inode change time).  That's because the
definition of "change time" is defined to include the time to change
anything about the inode metadata --- including the inode timestamps.

Simply, the definition of "birth time" is about the time that the
inode was "birthed", and that's not something that you can change.
The problem is that DOS has a concept of "creation time", which seems
to mean "the time that the abstract concept of the file was created".
So if a file was created somewhere in a build farm in Redmond,
Washington, that's the time that the file should have, according to
Microsoft.  So Windows allows the "creation time" to be set to any
arbitrary file, since installers need to be able to set the "abstract
creation time".

You can debate whether "birth time" (which can't be set) or a
"abstract creation time" (which can set to any arbitrary value), is
"better" but that's why Linux doesn't support a way to set the "birth
time".

Whether you think we should bow to what Microsoft dictates probably
depends on how much you believe Windows is a legacy operating system
or not.  :-)  Personally, it's not something I really care about, and
if someone really wants to add a Windows-compatible "Creation Time",
my suggestion would be to define an extended attribute where this
could be stored.

We *could* allocate space in the on-disk inode to store this
timestamp, but since I would estimate 99.9% of deployed Linux systems
don't care about Windows compatibility, it's not a good use of
resources.  We could also add a mount option which changes the
semantics of birth time, but that adds extra complexity, and again, I
would estimate that 99.9% of Linux systems (where I include all of the
Linux deployments in Cloud VM's) don't care about Windows
compatibility in this way.

Cheers,

						- Ted

