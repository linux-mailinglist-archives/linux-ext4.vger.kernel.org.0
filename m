Return-Path: <linux-ext4+bounces-13509-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBWTJKT1gWljNAMAu9opvQ
	(envelope-from <linux-ext4+bounces-13509-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Feb 2026 14:18:28 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF55D9D40
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Feb 2026 14:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9292C3065408
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Feb 2026 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4838736D;
	Tue,  3 Feb 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZdEl5Qkf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A392D387357
	for <linux-ext4@vger.kernel.org>; Tue,  3 Feb 2026 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124569; cv=none; b=ppSDOxlBNlWDyoGrWQc3HlY4qdpIdQdewkNchrYh1OUCVNXPx/fib5WM1zz3o9hWv4I9WmgzC1liXYA4UuuMNyLHxaJ2OjI4EoxCarWM6u9QO6/k4TlkoSnghZ9BQrssy4UxTQ5NAJDYICo7ZRQiF2Y9Fk2IniIG0HaqLh4TvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124569; c=relaxed/simple;
	bh=sMfQEJguCKAnQk5xSfZ0yIfIDUjHlxjGVqyJGAOf3a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5uzk4LNisn3u7doMo967RBBehzAXSDnfcsbMMZgYqSO+FTH2F3US61EJkgYifEG8LqLdwMvfRQZfytGJLG1Cc3t0mR1F3HOqQme4u0dbtxjSKUW67F04UjLV76JmwZjgZuFV0fw0H5hf6r+P2AI8jV7aUMcNCs6VF0J7PH+la8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZdEl5Qkf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-121-136.bstnma.fios.verizon.net [173.48.121.136])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 613DF8Lw027441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Feb 2026 08:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1770124511; bh=uZsbPnN7nI84z4y52TbLS2xHivw1HLOsagcDwg+Jtus=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ZdEl5QkfmlBk9CIALn3PkoYKSeJkGXSgJtyI+oS1UcVGOF7Qtzj3BftZztnpTEJES
	 xNB0XfAUEUqEkmD4EsC2tvTEzUSa68Sv9mzQQsUIMTioxx3cLXdqn8w3yUnqzboW9O
	 FW2LQo2lGY/A2fUcdV8v3EZCjiul4M+ho53CI3Ib2Ms/SqsxjZ1kzrLDlieaO9EUoA
	 P6beDo3RqSwyluUtW9/I2bvkV0LNbwWeznDSF15RKtPUAySch67nkdsdVj4OxZ8snv
	 wI2P9aY+XQeDn86ekhf22+og7hyNfQmMU8dvyTjLXEAxfazQgPVLelyqYwYkqxBBBs
	 9/37IlG5ZjoZg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7561D5716867; Tue,  3 Feb 2026 08:14:07 -0500 (EST)
Date: Tue, 3 Feb 2026 08:14:07 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, djwong@kernel.org,
        Zhang Yi <yi.zhang@huawei.com>, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com,
        yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com
Subject: Re: [PATCH -next v2 00/22] ext4: use iomap for regular file's
 buffered I/O path
Message-ID: <20260203131407.GA27241@macsyma.lan>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <aYGZB_hugPRXCiSI@infradead.org>
 <77c14b3e-33f9-4a00-83a4-0467f73a7625@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c14b3e-33f9-4a00-83a4-0467f73a7625@huaweicloud.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13509-lists,linux-ext4=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,dilger.ca,suse.cz,linux.ibm.com,gmail.com,kernel.org,huawei.com,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[mit.edu:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FF55D9D40
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 05:18:10PM +0800, Zhang Yi wrote:
> This means that the ordered journal mode is no longer in ext4 used
> under the iomap infrastructure.  The main reason is that iomap
> processes each folio one by one during writeback. It first holds the
> folio lock and then starts a transaction to create the block mapping.
> If we still use the ordered mode, we need to perform writeback in
> the logging process, which may require initiating a new transaction,
> potentially leading to deadlock issues. In addition, ordered journal
> mode indeed has many synchronization dependencies, which increase
> the risk of deadlocks, and I believe this is one of the reasons why
> ext4_do_writepages() is implemented in such a complicated manner.
> Therefore, I think we need to give up using the ordered data mode.
> 
> Currently, there are three scenarios where the ordered mode is used:
> 1) append write,
> 2) partial block truncate down, and
> 3) online defragmentation.
> 
> For append write, we can always allocate unwritten blocks to avoid
> using the ordered journal mode.

This is going to be a pretty severe performance regression, since it
means that we will be doubling the journal load for append writes.
What we really need to do here is to first write out the data blocks,
and then only start the transaction handle to modify the data blocks
*after* the data blocks have been written (to heretofore, unused
blocks that were just allocated).  It means inverting the order in
which we write data blocks for the append write case, and in fact it
will improve fsync() performance since we won't be gating writing the
commit block on the date blocks getting written out in the append
write case.

Cheers,

					- Ted

