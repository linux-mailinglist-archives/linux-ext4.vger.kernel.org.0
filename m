Return-Path: <linux-ext4+bounces-6766-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA3AA5CD6C
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 19:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946CA3A62F9
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27E263884;
	Tue, 11 Mar 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z42sSnEd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F5262D05;
	Tue, 11 Mar 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716719; cv=none; b=lmXPnx42AxghMLILty5jVFA5xPEVcozXZTtRUqNuQarpCSLS6FrpYiCK8e0x331mTYRbE5a1FP9AYsfl2J+73TjzCLAAdKnfFpYLx4rKE8CK8oDebgrrhuizZCOG5/JwAaDul1gdhTvseeUeEldQmAZ0D7v98aORSXtG4a624jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716719; c=relaxed/simple;
	bh=A0lKCEzfWH9kCFf/wj7kV531/pTBe1q/i9u4N8HthcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYyMKN9lnuZOnR5TlFyd78/i7QmcmGwEr05S/EQ+sgXxp5I++VTX0Zrx95hUX4Kmq+6hJWpFutjKfwyY675tEndhHfk2g4IroZ6wOfgNBCbHJUnO0GZccLMjD5qDl1s/NPHeUco9Fq7MQ8wcOCzjWOQrbIL2m9DwZK9/G+rMqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z42sSnEd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hnT0L+J4zEF871Kt9HBqiCqO17hCFASX7y/dw5Vk4zY=; b=Z42sSnEdM0x3+VxoRpQw+IyjqS
	d1tyEmHTM+CASlfhAip5OR2h4hRpkDfBU/k7cwMZITOj0dE/W+Ug/nlwhwNNf7LVs5XHJR2uWTCvT
	3tRm6EH01233c69pRv1BHVig6ujGiFLgVUs5FPQU/NjOTR0Xauwv3wMlwB8hvRxrOZO2IVwQ671MO
	CL5CB1aWPS7HTkXM0HtQr2bPCmvcYqxn/QYPrzfct5za8OQ80TJ+tIMdiEz5MTsVZMm1Ajt1XLCY+
	KozuubXLk/AgIR97UmGKiqpyMpJKHSGhRlLVu42LeFBBubUOTrQXiEDPQlGtj3RghpxiaLFrc4rL4
	6hzwhM1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ts454-0000000523K-1pth;
	Tue, 11 Mar 2025 18:11:54 +0000
Date: Tue, 11 Mar 2025 18:11:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Theodore Ts'o <tytso@mit.edu>
Cc: David Laight <david.laight.linux@gmail.com>,
	"Artem S. Tashkinov" <aros@gmx.com>, linux-ext4@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A syscall for changing birth time
Message-ID: <20250311181154.GS2023217@ZenIV>
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
 <20250310135828.GB8837@mit.edu>
 <20250310221243.0d5db7b3@pumpkin>
 <20250311044935.GD69932@mit.edu>
 <20250311045635.GP2023217@ZenIV>
 <20250311170725.GE8837@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311170725.GE8837@mit.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 11, 2025 at 01:07:25PM -0400, Theodore Ts'o wrote:

> I actually pulled down the V7 sources and there was a comment in
> /usr/sys/h/ino.h which has a comment around the on-disk inode stating
> "creation time" (see below).  These comments are also there up to
> 3BSD, and changed to "inode change time" in the BSD 4.2 sources,
> probably coincident with the BSD Fast File System implementation.

Ken Thompson is at google these days - might be interesting to ask if
there was a point between v6 and v7 where it was used as 'creation
time'.

https://www.tuhs.org/Archive/Documentation/Papers/BSTJ/bstj57-6-1905.pdf
looks like a reference to 'creation time' in Apr 78, and man/man5/filsys.5
is Jan 79 (already matching actual behaviour of released v7).

I wonder if anything of Interdata 8/32 port survives...

