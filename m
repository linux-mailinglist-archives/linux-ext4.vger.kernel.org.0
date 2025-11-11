Return-Path: <linux-ext4+bounces-11794-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB4FC4FD06
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 22:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD75E4F5A91
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 21:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26CE2E091D;
	Tue, 11 Nov 2025 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ESomTYF5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7935CBD1
	for <linux-ext4@vger.kernel.org>; Tue, 11 Nov 2025 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895576; cv=none; b=GoVw2Ikz1MekLjf4e7BO/dkFIwN/OpMkQw6uevY5r+l8Eh7F2IOHA3CECB+mbHXDBiMoAuhiWJO2F7PBfjhKtDa+ern4jzmq4UNEmqJrVexmWdQBhCvwIEAwlr56C470gDj4tHgCiqrLt8tUxhXUxhcvbOTTSZpJicPLHC8ZP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895576; c=relaxed/simple;
	bh=r0mhWiTfGOpqSQIirHKg23awhk5TbmMpNPTtCFBniZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUH2NqWcvJOVH3Y2yE5y5fWzOl7gYQoJ6Pkkw83QUmu08g+COYQBXkg1/nVpGcgK6H9froTzNvB5a9w/+tr2kuNa5SVMKq2l8vZNgjg1Xsp5dDQhU98rle8uv/o/kFXnN3/jF3zlPwO2870DjuaW3kleqwCUVr5vkELhZECSIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ESomTYF5; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5ABLBmJ4004198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 16:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762895511; bh=ArBI5cxQ9YKazNXvvrPNw3dqhQ/NNN1pp3U+5xpb5tE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ESomTYF5Re+/mJGYwQ/NIcSAdOLgABopwPWfID286k6s4sxn90PGxOrRl/kmsdNtx
	 n9OivsAWywD8C+sA3qanRUA+/8xFiANGidiK0cafJeu947gbxaO4Jojyktbb6sBV4+
	 NRAZvzl0xP6aNwZfi31W3XnPVBeOfsZvbAjGgzAUMOn3FFP7EBSa5H2scA450ziEL2
	 Clr4V4pd4/MksqIVT0siWc0BbXsRzeSgoNION3IJUSm3Jhgjh66yUXzt9Ol4ZU5cmn
	 jjCbzIHvxsp2yOv4uZYhiVwTpv4RDHq3pJgIQRD354lu7wzgmiC2Epuidpn/QPIFS0
	 ZYLf5ledyN7jQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0B8F92E00D9; Tue, 11 Nov 2025 16:11:48 -0500 (EST)
Date: Tue, 11 Nov 2025 16:11:48 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH v3 24/24] ext4: enable block size larger than page size
Message-ID: <20251111211148.GL2988753@mit.edu>
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
 <20251111142634.3301616-25-libaokun@huaweicloud.com>
 <880280be-1cd0-41b6-bc89-9168f374a9b9@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <880280be-1cd0-41b6-bc89-9168f374a9b9@pankajraghav.com>

On Tue, Nov 11, 2025 at 07:01:20PM +0100, Pankaj Raghav wrote:
> 
> If you are planning to send another revision, then it would be nice to include
> the corresponding patch to mke2fs as well? I don't know how ext4 process works but
> just a suggestion.

It's actually more convenient for me not to mix userspace and kernel
patches, because b4 doesn't know the difference.  For that matter
replying with an unrelated patch can also confuse b4, so it's a bit
easier for people using b4 to send unrelated patches as a separate
mail thread, using git format-patch / git send-email.

In this case, the corresponding patch to mke2fs is pretty simple, and
I've already pushed it to the e2fsprogs git repo:

   https://github.com/tytso/e2fsprogs/commit/6d9033ff854eb346746176f43aa063137275d4b1

:-)

Cheers,

					- Ted

