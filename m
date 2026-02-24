Return-Path: <linux-ext4+bounces-13997-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDLlJ9MVnmmgTQQAu9opvQ
	(envelope-from <linux-ext4+bounces-13997-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 22:19:15 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0320D18CA92
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 22:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5548304EF41
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7E933CEA2;
	Tue, 24 Feb 2026 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cS43nh27"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51E33D4E1
	for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967932; cv=none; b=VtC4JhHofbS3b+jyhuWwhx/zviYwbr0CNaYTcVnrfEnD64DG+cJ6v2bmy3mVjt2NwYPHWZpFVFhh3aatqKQ17rVnHbAjLkr8ASk+K3kOFmhHvbZH9bP9i23H/d1e1Qb5f67h3nwub8Go3/0M6JMet2SuC8ZCxm92UBjUa6KjVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967932; c=relaxed/simple;
	bh=AYDplU6K49/SVuAPo9/ReGyIIV5abEzbKrqhW6D4Kzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBC3sgxTCq3A2tJ7zeetvbY0X5iSXOlN/Hd6Svqwu8+ZEwJXDwHmU8oEu+C4T28pb2jxFcdG102HjHZvNvAWbpoqCNGjEsh2eA1CLWgJNJymcPxN1MwGZXJLOtBK0qVPd4MxwN5gdFCaguAIwZ5wOd2s6zPvnJwxlSeRgR/SKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cS43nh27; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Feb 2026 21:18:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771967918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e6wTWaWNIxwLv+18TjX9PEFxPO2yrUFIKp0jYJONcPI=;
	b=cS43nh27ThYnwu5hAnSeohAUUzQPZsv0vZvXypJ7CVo3us7EeHEKOs80WX6w838O4zhKsN
	f7mAgSFfimuw+wTziUoQv/r5bS01t2Upxgivuq4M3pVvPT8q1mOmVvwfSCvI2FRfdeDb2/
	V54OmBvyQQ5ZJWDOEmUGfTRw0nzoQ9g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bpf@vger.kernel.org, 
	bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 29/33] fuse: support atomic writes with iomap
Message-ID: <jabujke2yepqsgipfip3juvizdgkdgnuzzrluuex6yc3pjxch3@pldpsltux43n>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
 <177188734865.3935739.5549380606123677673.stgit@frogsfrogsfrogs>
 <ej24ajmh6ltfe37yiy6qzqko5p6y5eecixzybexgxs5oo45iuu@ufvfjxvppc3o>
 <20260224193005.GD13829@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224193005.GD13829@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13997-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.raghav@linux.dev,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim]
X-Rspamd-Queue-Id: 0320D18CA92
X-Rspamd-Action: no action

> > 
> > I still haven't gone through the whole patch blizzard but I had a
> > general question here: we don't give ATOMIC guarantees to buffered IO,
> > so I am wondering how we give that here.
> 
> Oh, we don't.  generic_atomic_write_valid rejects !IOCB_DIRECT iocbs.

Ah, that is true. I was secretly hoping you added support for buffered
IO atomics ;)

> 
> > For example, we might mix
> > atomic and non atomic buffered IO during writeback. Am I missing some
> > implementation detail that makes it possible here? I don't think we
> > should enable this for buffered IO.
> 
> <nod> Now that y'all have an lsf thread on this, I agree that not
> supporting buffered writes in fuse-iomap should be more explicit.
> 
> 	if (iocb->ki_flags & IOCB_ATOMIC)
> 		return -EOPNOTSUPP;
> 

Yeah. This looks more explicit. Of course this change does not warrant a
new series as it is not changing anything functionally. If you plan to
send a new series anyway, then this could be folded in.

-- 
Pankaj

