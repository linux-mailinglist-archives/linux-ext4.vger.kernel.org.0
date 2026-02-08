Return-Path: <linux-ext4+bounces-13622-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 91UbMxvriGkiywQAu9opvQ
	(envelope-from <linux-ext4+bounces-13622-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Feb 2026 20:59:23 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8C10A0EA
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Feb 2026 20:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 112FB300B065
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Feb 2026 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BE6324B20;
	Sun,  8 Feb 2026 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EMp4Yd4k"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97119CC14
	for <linux-ext4@vger.kernel.org>; Sun,  8 Feb 2026 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770580759; cv=none; b=rXFa6cDFiPQt8mO4zLk1RybdYxXWmIJZSn7itniQcPFZ9wLSKuLxW/EbFalASfFg5QCovye10WVXBxF1Pa7vhZC4FAfTfKGxPqQgBx7ONY2vMb4GyTLGBgxSxViIiTDQDawjDdP84bDzPp+4hB/5L9Y1g1MhRNpYnjfY2XFWqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770580759; c=relaxed/simple;
	bh=98+bWtJVpl1ohcj08ocgvm79XtuSYhsAiSnSzhA//EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2D6u0E1a0yBFdthoGc9mVdA0/sYE1ETrwqSB/MTdxN9EbIr+/k3YKzBLsv2Qy2kXIts1hV7bmdxS6Vpncj6SF1ww9UNXkjuwqE7aSiq88t+Uo0RtfAVLT6kmIxFuuEvlTyxrMBgUhYRyKwUU8x8q/H6Sr//nB20wmzT0vMGUTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=EMp4Yd4k; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-115-57.bstnma.fios.verizon.net [173.48.115.57])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 618Jwn3N026873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 8 Feb 2026 14:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1770580733; bh=kRCaWck9DgSgt+tXcGLV/8HWvO+8pEZNhvFeV9pf43U=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=EMp4Yd4k6Q/m9rdkWNxjf6oMJmNImFoU1av73rYMXU5S0KOsyuvstDIGoHiXeUVkP
	 Kh+iudqVH6vetdQCNe8FAzKK23TbzXjILXdmkWgRc9ZGZr9GSAkV+q2/PstzNNRI5N
	 6wzcxhv6JR6oYRB6wOvGgpAdMF6fieBMi7LU+t8DjobvKqRdndIE6RuQrnB36Hub1g
	 d9WNaWQTKlywIRX3sYkXLfMh+EOWQTo0/xKpKo8Pny2jFWLdMaMleVqtipNqSq7Mtr
	 l4pnVUEUchlocspD8i97aPb3TsMy8iXR+Zw9FpIYw8Cf/S47SwjMYjlPEVl4Eh0sMd
	 st1kulLnMiqgw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id AA96657BE389; Sun,  8 Feb 2026 14:58:49 -0500 (EST)
Date: Sun, 8 Feb 2026 14:58:49 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Mario Lohajner <mario_lohajner@rocketmail.com>
Cc: Baokun Li <libaokun1@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Erkun <yangerkun@huawei.com>, libaokun9@gmail.com
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
Message-ID: <20260208195849.GA74984@macsyma.lan>
References: <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
 <069704a4-2417-470a-bf32-0ee3afd1be6a@rocketmail.com>
 <9fc3443b-0eea-4917-909b-709113f5e706@huawei.com>
 <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
 <20260206014249.GH31420@macsyma.lan>
 <26d60068-d149-4c53-a432-8b9db6b7e6a5@rocketmail.com>
 <20260207053106.GA87551@macsyma.lan>
 <16f17918-9186-4416-bbde-b93482933d8b@rocketmail.com>
 <20260207175522.GB87551@macsyma.lan>
 <9e520492-9b26-487f-9d60-7e0625c987c9@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e520492-9b26-487f-9d60-7e0625c987c9@rocketmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13622-lists,linux-ext4=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FA8C10A0EA
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 12:47:12PM +0100, Mario Lohajner wrote:
> 
> Someone comes forward with a fork, saying:
> “Here is 'my fork'. I believe it may work well for 'some dishes'.”

Give me *proof* that it works on 'some dishes' in terms of actual
perfomance, specifiying real-world workloads, and real-world devices,
and we can talk.  "I believe" is not enough for code that upstream has
to test and maintain indefinitely.  If it works for you, it's open
source.  You can run with an out-of-tree on your systems.  But if you
want us to accept it upstream, you need to provide something more than
"I believe".

Cheers,

					- Ted

