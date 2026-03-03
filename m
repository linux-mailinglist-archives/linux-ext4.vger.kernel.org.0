Return-Path: <linux-ext4+bounces-14470-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGchFnQ6pmnQMgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14470-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 02:33:40 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F23A71E7B6B
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 02:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 530903016AD4
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 01:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41D2367F58;
	Tue,  3 Mar 2026 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="T1b5uIjX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C726BFCE
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501615; cv=none; b=qKIB3UtptSK1WrdEPB41bjfsrlUpcYrkcLTO7IqBb21bPlF0ZUnq0QSZcqkDR4s+OoIDTLIxSz8gWHH5WHptfDMFPvfrqB7T9eEmuT7pRtuYZDFSkg4o3d+LYP0FPCBslc9t0y3wo/1p/XpiR1f0b1TNxBTJL3E8gLzjGl5imVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501615; c=relaxed/simple;
	bh=1x/z4lsjvRVrm8u90IJ/ogmuf2BMAxXWCertaRUyDi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPyuxqyuTQDR+QyduOQ/jgzdTrkgavu5o+8pFJmsqbXZahLhieNOkfQgCfYGklfCRGsOo+Hod+9KUPGJXFTrOtf6m44NALUf/TLuvCSo8cEDKQ/Fn2h39lA65itzSa1JztTJg9miRmiSrlw76lZ1fXLDjIB00r8GEnDFw5u7AI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=T1b5uIjX; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-102-84.bstnma.fios.verizon.net [173.48.102.84])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6231XAkA029560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Mar 2026 20:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1772501592; bh=LjvMyfV6wGhEgTswJWDP+qMkqBgbdWSVw/aER82y5jk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=T1b5uIjXQ9U1se7/MT8v5M89PAihrlaKLwADFXPiIdJUkTNIHlKZLANTt7xF4eMAd
	 TieofBFVLNBalBIi+CXhZfP01cC0g6qN0bT9puMWwIHJKCYmViW0ggsU8DokadfB02
	 JOmw7YAnDTZoAcEy8PzLzqO2V+VZqEWjgmY0wbyjuoMf+Sf4uAN4CG56KugtyISYYQ
	 Kf13KmJUUA0V0Ar1XOqTY+MYHzwvWc2l+ZxlLgDlgyHyiSXt9BN1YnY7nRCt6iqFNf
	 eF82UoOZYXLLeAFKsNi8UAThkglYW9D2U10JVZYNaWR3zW5JtaRr+iSazPH/2pEzqP
	 BXTPhrO5w1ZXw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id CCB9B5AC5D2D; Mon,  2 Mar 2026 20:33:09 -0500 (EST)
Date: Mon, 2 Mar 2026 20:33:09 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Mario Lohajner <mario_lohajner@rocketmail.com>
Cc: Andreas Dilger <adilger@dilger.ca>, libaokun1@huawei.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        libaokun9@gmail.com
Subject: Re: [PATCH] ext4: rralloc - (former rotalloc) improved round-robin
 allocation policy
Message-ID: <20260303013309.GB6520@macsyma-wired.lan>
References: <20260225201520.220071-1-mario_lohajner.ref@rocketmail.com>
 <20260225201520.220071-1-mario_lohajner@rocketmail.com>
 <D135BB30-388D-4B4F-9E09-211F6DA74FCA@dilger.ca>
 <20260226024819.GA39209@macsyma-wired.lan>
 <04dfeda0-8c13-4233-b631-d8912d4fe6f0@rocketmail.com>
 <20260227011200.GA68551@macsyma-wired.lan>
 <2af6328d-5a72-476d-9768-9398a9417ea6@rocketmail.com>
 <20260227164319.GB93969@macsyma-wired.lan>
 <c156caec-e2c8-4b85-a135-0adecb56a859@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c156caec-e2c8-4b85-a135-0adecb56a859@rocketmail.com>
X-Rspamd-Queue-Id: F23A71E7B6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[dilger.ca,huawei.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14470-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[rocketmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,macsyma-wired.lan:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 09:04:44PM +0100, Mario Lohajner wrote:
> RRALLOC spreads allocation starting points across block groups to avoid
> repeated concentration under parallel load.

There are already other ways in which we spread allocations across
block groups.  You need to tell explain a specific workload where this
actually makes a difference.

Also note that in most use cases, files are written once, and read
multiple times.  So spreading blocks across different block groups is
can often be actively harmful.

> In high-concurrency testing, performance is consistently comparable to
> or occasionally better than the regular allocator. No regressions have
> been observed across tested configurations.

No regressions, and only "occasionally better" not enough of a justifiation.

What is your real life workload which is motivating your efforts?

     	     	       		      	 - Ted

