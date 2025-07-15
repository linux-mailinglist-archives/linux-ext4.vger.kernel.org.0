Return-Path: <linux-ext4+bounces-9004-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B64B04F40
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 05:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6B23B88B7
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 03:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B6F2D0C81;
	Tue, 15 Jul 2025 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lonv20cY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4D218827
	for <linux-ext4@vger.kernel.org>; Tue, 15 Jul 2025 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550961; cv=none; b=ST5vaeh8Q/ms0whXlXIiiYa0/eNbKohXBGUYf0/MKmN0RBoUzpjbEVYkaqhMDfFigLUWd6n9uQ6kUi/VZverGvXZYW3pQnW+o7NbT7uo03YIR0+6qH/0daSVnA6/yBurdyagjnWlVrYzh8ryhG2KDRhbYJUEUU1KzKkINce/oGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550961; c=relaxed/simple;
	bh=u+mlZQExcRMItsKnSkEqpccOS0uFJMtlkke0irurtkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym68IY1tBgqRaF+WvN/Z8JFdKy4U+a3p1ucOHmMtS8x2HKKAmnXIDE/vdrAn3XDbPiTbe+YTochNeXkM33MbiaJSnTrILMEUBMMPhtp7r/ZAB8qB90ry6wLekBGkjCutZfpE+qXRqFJha0dSxYVgDiE7/F20s2xcPgwWeUZApUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lonv20cY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-88.bstnma.fios.verizon.net [108.26.156.88])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56F3g47e027598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 23:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752550927; bh=UbC5XqbUuDYvUapkndbSlyKNWPJ06LZ10S/ex1fui6g=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lonv20cYMsk5WCaP6unuCyKbeRbtvUJz7+ZLIdS/dzIAxIrmO8z/+mVaQmq0XVY9L
	 OhCR++y4KsY3jLZSonLj0UvW5qzXLcxiUt6Ngr7e8gbDA2mNfd+CA7GD22GQ71gJp9
	 gt0V8z9sGfWQQhy3ukdUzVrkwo+zi5yQOm5ouhf/JbwCu9xo6gNqogcHorh17yOTLe
	 +8CGShh89wb0PdgypQc6Cz7RpW7Aw+0HPI46clRooJ1ZqQtFuv7/dTQP4ScTQhaoBr
	 eoqwAyLIuoLATf88yaP9e0gBbq4bf6ro8zlRJM1ieBXachOov/CS9YMeXOcNjsUhnz
	 wWvrn0hlR4Oxw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id CBB332E00D5; Mon, 14 Jul 2025 23:42:04 -0400 (EDT)
Date: Mon, 14 Jul 2025 23:42:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jiany Wu <wujianyue000@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, yi.zhang@huawei.com, jack@suse.cz,
        linux-ext4@vger.kernel.org
Subject: Re: Issue with ext4 filesystem corruption when writing to a file
 after disk exhaustion
Message-ID: <20250715034204.GD23343@mit.edu>
References: <CAJxJ_jhEbHJiP-OzSpp2xqai-n=t2CGKXqkmvqf7T3i37Eki0A@mail.gmail.com>
 <20250711052905.GC2026761@mit.edu>
 <CAJxJ_jhYUqYhNcsLnjPv+2-n83G77zeQ1jppC6YGfo6bHv+vaA@mail.gmail.com>
 <20250711154012.GB4040@mit.edu>
 <20250712042714.GG2672022@frogsfrogsfrogs>
 <20250712143432.GE4040@mit.edu>
 <CAJxJ_jh=4q81OnSXk=yAU3u_7CCHZLGhb31eALF0cSyNv34E1g@mail.gmail.com>
 <20250714130951.GB41071@mit.edu>
 <CAJxJ_jgg0H=+JLSjc6SNwa5tiDhWjTunNPE2V1SP-v9_O8oCqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJxJ_jgg0H=+JLSjc6SNwa5tiDhWjTunNPE2V1SP-v9_O8oCqw@mail.gmail.com>

On Tue, Jul 15, 2025 at 09:27:01AM +0800, Jiany Wu wrote:
> 
> Thanks indeed for the clarification, it is clear now.
> OK, if using a loopback mounted image on a disk, underlying file
> system full then the block device will have I/O error.
> This loopback mount belongs to a third party common config. I'll
> fallocate lower disk space to not exhaust disk as a work around
> firstly.

The question I'd ask is *why* someone set up that loopback mount in
the first place.  As a guess, perhaps the goal was to restrict the
mount of disk space could be used for log files in /var/log, so that
if there is runaway logging, that all of the free space on the root
partition won't be consumed.

But if that's the case, there are much better ways of achieving the
same goal.  For example, in addition to using log rotation programs,
you could back that up with using project quotas , which restricts how
much space can get used in a subdirectory.

Cheers,

					- Ted

