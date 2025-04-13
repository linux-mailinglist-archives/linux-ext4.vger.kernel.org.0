Return-Path: <linux-ext4+bounces-7223-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DBFA871F4
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 14:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D993B0C8D
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 12:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0603E1ACEDA;
	Sun, 13 Apr 2025 12:41:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4D1A724C
	for <linux-ext4@vger.kernel.org>; Sun, 13 Apr 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744548074; cv=none; b=HFO40GdtkqcRtngPzFv6NYbr89LodfCZq0n7PbzO5pqyYJMqxiiSjvyVMtjSLSnfzjV7dUetZmZIAiqYvbhHN+agG55pA2WMBPSEPUWB8oCmr+k/dqgmuO8exCOP9mK4TErvqt3H+csu3YeZw35rEzwx8fgjtjahgcHhWW039oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744548074; c=relaxed/simple;
	bh=Rq01d9ejvzex4376qmBcvzLJCfJ+SQ4pFJwanQ75ps0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8GmuIAHGxVUvMSy25G1ZZMItiOjTh3fTCoi2BugpvBdWZhdxZKCMa7RX89phdpVi+UBY6osa5aoa9W47/gvJFZwU11r6X2Vm642nioTsQVAvUsd+aSj262de5GOfHVuTDY9op788JImsWzrX/Iyda27+bs+dRlsoVKUYftPQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-137.bstnma.fios.verizon.net [173.48.82.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53DCetGL009051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 08:40:55 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E3B112E00E9; Sun, 13 Apr 2025 08:40:54 -0400 (EDT)
Date: Sun, 13 Apr 2025 08:40:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <20250413124054.GA1116327@mit.edu>
References: <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
 <20250412215257.GF13132@mit.edu>
 <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
 <20250412235535.GH13132@mit.edu>
 <CAGudoHEJZ32rDUt4+n2-L-RU=bpGgkYMroxtdMF6MQjKRsW24w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHEJZ32rDUt4+n2-L-RU=bpGgkYMroxtdMF6MQjKRsW24w@mail.gmail.com>

On Sun, Apr 13, 2025 at 11:41:47AM +0200, Mateusz Guzik wrote:
> This is the rootfs of the thing, so I tried it out with merely
> printing it. I got 70 entries at boot time. I don't think figuring out
> what this is specifically is warranted (it is on debian though).

Well, can you run:

debugfs -R "stat <INO>" /dev/ROOT_DEV

on say, two or three of the inodes (replace INO with a number, and
ROOT_DEV with the root file system device) and send me the result?
That would be really helpful in understanding what might be going on.

> So... I think this is good enough to commit? I had no part in writing
> the patch and I'm not an ext4 person, so I'm not submitting it myself.
> 
> Ted, you seem fine with the patch, so perhaps you could do the needful(tm)?

Sure, I'll put together a more formal patch and do full QA run and
checking of the code paths, as a supposed a fairly superficial review
and hack.

					- Ted

