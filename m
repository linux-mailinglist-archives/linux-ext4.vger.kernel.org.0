Return-Path: <linux-ext4+bounces-6763-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9EDA5B81E
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 05:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91003B01B2
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 04:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5C41EB5E7;
	Tue, 11 Mar 2025 04:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Tm5a3prc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583151E9B0C;
	Tue, 11 Mar 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741668999; cv=none; b=BhPASklFWASeE7ctpGzOBD/oUrSO1FFmpIbO/st6APnuQHdOyFiELH346ziZL2SJ29luD3E2SaiHHLDJigUX80Dx3QsuvBHokhP0FQYxqZbMZelA0Pgyj7Z6+34V/do6ZKDnaUNy50HeZzHzKN4HLp3UpjhlsXFdffLGV+X1uOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741668999; c=relaxed/simple;
	bh=d/5MouCRr/qW0fG76vd4I3/tAMZvWoBcXC8VVi3OkhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRtgzngzYf4YRB+rbmMELbhVjpcgEX2CwcHY7ULDyNDrjeuRXZ+FbO79EqKqAuu4j6YLvGMdIZzarFdpEu+F6JxMEGzfSg3t+nMZbT1YVFLjEc/pdlHDmKI7Ja4NyKBbO7XNnxEZt55EcFsHhHBaGNJlGkTxNzPmz/iQcL8YKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Tm5a3prc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oG7gBUj5SmM7ezRaqRZGb2H5niz3NZIyO/1enjvp21U=; b=Tm5a3prcLUihWb4jW1Fxia+Aws
	PAWWstiS7eTrc0HLmC4CYlm1Imm7KKzy4hdSyDLAFHZ5i+M/eA+VlW6HqAWl4myYerpxE+z93M9FA
	THUx0i6+F5JgDYlAr5C4xkqBEhV1lbRjKLTMfIJsVQYCdhx6dOEZQrt4pj5FzFHCuTGpJOdiC4ZtV
	wKhDIs7Jo7MPPRCpCoShJYySHskaPi7HQ9YajEJACuTOJ+oh57L7x6zPZ5ayTRVbj/dqVg+h6Evl3
	6C7dXgQXqUIAQhtcUyMxcm71qpMJad03Q8rF4G+eGfDVgQF13Fy2XA8HHME9RYNPBtSptQsEQAN9d
	lyQ4+KFQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1trrfP-00000003aQS-1x5i;
	Tue, 11 Mar 2025 04:56:35 +0000
Date: Tue, 11 Mar 2025 04:56:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Theodore Ts'o <tytso@mit.edu>
Cc: David Laight <david.laight.linux@gmail.com>,
	"Artem S. Tashkinov" <aros@gmx.com>, linux-ext4@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A syscall for changing birth time
Message-ID: <20250311045635.GP2023217@ZenIV>
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
 <20250310135828.GB8837@mit.edu>
 <20250310221243.0d5db7b3@pumpkin>
 <20250311044935.GD69932@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311044935.GD69932@mit.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 11, 2025 at 12:49:35AM -0400, Theodore Ts'o wrote:

> This really goes to my question of exactly how useful the file
> creation time concept really is.  Perhaps that's why the developers at
> the UC Berkley made ctime be "inode change time", I suspect when they
> authored the BSD Fast File System 42 years ago.  Personally, while I
> don't find "change time" to be all that useful --- I find "creation
> time" an order of magnitude *more* useless.  :-)

The third timestamp had been introduced in v7 and it had been "change
time" from the very beginning, with incremental backups as stated
rationale in filesys(5).  "I'm sure that" from David means "I couldn't
be arsed to check my WAG"...

