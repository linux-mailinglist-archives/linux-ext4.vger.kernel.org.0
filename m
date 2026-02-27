Return-Path: <linux-ext4+bounces-14189-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNMtEa3voGmOoAQAu9opvQ
	(envelope-from <linux-ext4+bounces-14189-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 02:13:17 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A71B16DD
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 02:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC3E8305C8DC
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 01:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486C527991A;
	Fri, 27 Feb 2026 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bqMH3Kp+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D67266576
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154756; cv=none; b=pi/jkcLbXnE488h4MxHBoSQVmMUMVKRuh7YXhi6MlQMlwvg/ynxR1Bzp+UF2v8ywqVz7Zim/v+jiIC3xASyufCMrSve7pY/FE/8tqekAMBpNwrMXDuxTXP1CI4ROZV0CT9X6URBe2ZJ0RTmzdQm+qZTRjPLpc819r90XMkG7Y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154756; c=relaxed/simple;
	bh=wh4v3IHBfAGzfuyhHvbdamOWJw+DRw+WO6KelYG3s2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UENvaI2XvpYqrKDZfsbtkqUMTTd7k3vetNU7bQ2pBKw7vnqMGjvkKmpPuF1KTB0Sto6GDw6otSGJpE20+b4S2+mNLxIafmAfDGEM+Ml0XeAfPkc8o7OUCFRp8rNloxRjYczJe8SBREUDGWAmF1dUUMGAyEi5vzoAJpv0NRfm7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bqMH3Kp+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-102-61.bstnma.fios.verizon.net [173.48.102.61])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61R1C15E023721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 20:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1772154724; bh=R2yazrm+uYXCsUHQxulDOl6b+SzQHvW4YF3cSW1XWsA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bqMH3Kp+jJ5gT6DPYFXyw1zHde5vRx4+4ZaOHGeGOvZvCcKEIsKEiN54oLnDZb8P2
	 7qMxDs1Ca1AzvpjjenmqzmhSXAQKG2PTa2+abJXJvcZZPH3M65VJa6hAyzQN3W0IY4
	 3u62Ee3BEGlEidiPO8NCyAxpMIGBKfHr91LduFANrFIwiipfDiPfa//USz3sRpJ1lK
	 fl8dwcZ162ij8OcX76F1Ij89Yxxq295i2ddOL4s0Cg4ruZSPBVdQF6fI5mQdNyur1N
	 CecPdFODqjc3oshenGxTei8DpZHi8tS1lnmsJLUK259wqzTugObvR1rcRSXcnFnU9E
	 5DHe7sf5JnHGg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id EBF105A187FC; Thu, 26 Feb 2026 20:12:00 -0500 (EST)
Date: Thu, 26 Feb 2026 20:12:00 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Mario Lohajner <mario_lohajner@rocketmail.com>
Cc: Andreas Dilger <adilger@dilger.ca>, libaokun1@huawei.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        libaokun9@gmail.com
Subject: Re: [PATCH] ext4: rralloc - (former rotalloc) improved round-robin
 allocation policy
Message-ID: <20260227011200.GA68551@macsyma-wired.lan>
References: <20260225201520.220071-1-mario_lohajner.ref@rocketmail.com>
 <20260225201520.220071-1-mario_lohajner@rocketmail.com>
 <D135BB30-388D-4B4F-9E09-211F6DA74FCA@dilger.ca>
 <20260226024819.GA39209@macsyma-wired.lan>
 <04dfeda0-8c13-4233-b631-d8912d4fe6f0@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04dfeda0-8c13-4233-b631-d8912d4fe6f0@rocketmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[dilger.ca,huawei.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14189-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[rocketmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,macsyma-wired.lan:mid]
X-Rspamd-Queue-Id: 980A71B16DD
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:50:29PM +0100, Mario Lohajner wrote:
> The primary purpose of rralloc is to improve allocation distribution
> and avoid hotspotting.   Performance improvements are not the goal here...

You haven't explained *why* allocation distribution and avoiding
hotspotting is something we should care about.

If it's not performance, then why?  How does reducing hotspotting
improve things for the user?  Why should we care about this goal that
apparently is so important to you?

					- Ted

