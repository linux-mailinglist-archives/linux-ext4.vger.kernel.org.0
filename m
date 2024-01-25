Return-Path: <linux-ext4+bounces-914-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C3483C2E4
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jan 2024 13:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5D71F25801
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jan 2024 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F371A4F203;
	Thu, 25 Jan 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AXNMOdEC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87140168D2
	for <linux-ext4@vger.kernel.org>; Thu, 25 Jan 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187378; cv=none; b=tv8TJv+rftHJSOZnG9h/mXCGnZr/oIVFFsZcDrLywFHhua8GycxMLVBPRsInr3rmnRykvcyXXmHcsqR05JgLNUeStWuzTx2j8YQj+ZHLE1bChkwluMxAWmKdvNsKIZ6HBBO40VKKAp8MGcnpSQwuHe7wDHhFcH9Lvw6xd9Oap+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187378; c=relaxed/simple;
	bh=Hz949nb4lJNuFe+Z12rgcbk9PTaVMBCB/44QDUQ+PUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n43CXhOSNzMf1zECaOyMRieq6PZTl5KWsFFuA4g9yckclBFk9wqmBzaOkvEdrPybAOeSqvkQNNuUi+jVVZli0Zi0GUcsSaa/PeP6UeqwStMZ2w36oL+y4NUwJ8DphWkF/Cu7TVSznZYXV3fiJ3Ke6Au++lFa+PbSdrvtVoycI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=AXNMOdEC; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-13.bstnma.fios.verizon.net [173.48.116.13])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40PCtcvB025504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 07:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706187343; bh=bvFlhgLlZ8Qq5mF+gcNynEDGbVLG6HAWaNnn+mQ+qCY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=AXNMOdECpb9zLwnSBgQ+xCDDBQEVc2C/TUNlqZMluQ0U+JO06HP2xSgTNnDwLUchP
	 Pdux56229Wz8MZrBsnFGB6unKKj2QySSA7lejgYXHwaNGCnsN/7MjXw3DxB+Eb0rRp
	 VzqEHr21zp6wjtlKtM1K63B4HhwFCDZQTFmU2fWvasdUt9949PolBpFWfMAEfrevWo
	 KIkk5NwqOBNFF63mhX7E9n2F1nM1vhkb4CxouG0dd4Hqf/9qPZEvp323/9OVKAMX1L
	 SlukiI2xUdSZCmauyqevrwMxQa59YWjHZcvsH9KWExGKnzAhjvbrUmDxwS9LM/LZbj
	 IrfcSvwFzNrcA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B617E15C04DD; Thu, 25 Jan 2024 07:55:38 -0500 (EST)
Date: Thu, 25 Jan 2024 07:55:38 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: syzbot <syzbot+0f4d9f68fb6632330c6c@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yebin10@huawei.com
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_split_extent_at (2)
Message-ID: <20240125125538.GB2125008@mit.edu>
References: <00000000000099887f05fdfc6e10@google.com>
 <000000000000d7ed43060fb5f676@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d7ed43060fb5f676@google.com>

On Wed, Jan 24, 2024 at 11:21:05AM -0800, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices

#syz fix: fs: Block writes to mounted block devices

