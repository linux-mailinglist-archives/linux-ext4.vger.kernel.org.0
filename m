Return-Path: <linux-ext4+bounces-14026-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GqzH5G0n2l0dQQAu9opvQ
	(envelope-from <linux-ext4+bounces-14026-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 03:48:49 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8081A033B
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 03:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 681DB3044A7C
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 02:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF9325EFBB;
	Thu, 26 Feb 2026 02:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hFfCQqcF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7D8191F92
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 02:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772074126; cv=none; b=OiY5eFYlQZr3QKhdqrMIB7P79HZx4n12VUNM289b6TqLdjX4/8pEWnJzJKoWc6mCUUPTtGG/c6qDntrVLzuFwZRG4wezP918OdB8gBauNQ7ykFR3XAKp4jkBKuD5YZUUqCC3jpc6q+X80sJnLDHx0rfS8wyoSiVqfQDUnLfwUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772074126; c=relaxed/simple;
	bh=F0+o2UUVW9aNzSBdsj6/U9LiKGoL8Nd1mYuDq7TnJ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdjuM8wgzOe//SiLd2E3ecXFRLzTCTZUYPCVQtAvN8MbA4zIUVnwra1fGWiKRRg1oNZtX28adA2eSh/RS+80Ym9RQ+1nqzTZo8q0G4WkYIhfQqPNplpMByffDgXd825N7TZxTG9ZZOGd4jcEA54yjbxQ1VMkyjybg1hzWuTgQBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hFfCQqcF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-102-61.bstnma.fios.verizon.net [173.48.102.61])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61Q2mKoN026274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 21:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1772074103; bh=v1lW6HbOxzdVAYTNNOiCAsp5k2UZLgPEp7PYb+IMH9s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=hFfCQqcF+PlMucmYtSTPU7N8U6bSwnkrOukDG8rfmNV5YsGCFkU2oX7vZWzxQ70Iu
	 rvRABLWwwQAuSjPbO8KrDf+7hzWD3cw81HjNeZ1bUy4QZ+Wf5MQ40X7bFYMpBUWdI4
	 lbsB4QfMOYTUSJm8SFYCHDblNK+nnZ1hssvehVPiboRl6b8OBbwvkpLEQsRVhZRZIz
	 zVobnf/Q1JcZcRLyMDRkAfc4hlmlrJ3gOMHF9qc2iAzJCA/XxH7U34kVqrP98V38dB
	 EPi7hF7CZ1SfQhIkG4a6o/Gysv/F7aZYAm5gux5PNy0czOAaAUZUp8hT6TkcTkBIHA
	 jCCRqDHwh6+Bw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 00F0159EFFAF; Wed, 25 Feb 2026 21:48:19 -0500 (EST)
Date: Wed, 25 Feb 2026 21:48:19 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Mario Lohajner <mario_lohajner@rocketmail.com>, libaokun1@huawei.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        libaokun9@gmail.com
Subject: Re: [PATCH] ext4: rralloc - (former rotalloc) improved round-robin
 allocation policy
Message-ID: <20260226024819.GA39209@macsyma-wired.lan>
References: <20260225201520.220071-1-mario_lohajner.ref@rocketmail.com>
 <20260225201520.220071-1-mario_lohajner@rocketmail.com>
 <D135BB30-388D-4B4F-9E09-211F6DA74FCA@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D135BB30-388D-4B4F-9E09-211F6DA74FCA@dilger.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[rocketmail.com,huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	TAGGED_FROM(0.00)[bounces-14026-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB8081A033B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:49:30PM -0700, Andreas Dilger wrote:
> 
> Mario, can you please include a summary of the performance test
> results into the commit message so that the effectiveness of the
> patch can be evaluated.  This should include test(s) run and
> their arguments, along with table of before/after numbers.

The tests should also include an explanation of the hardware that you
ran the test on.  Some example of cover letters that include
perforance improvement results:

https://lore.kernel.org/all/20251025032221.2905818-1-libaokun@huaweicloud.com/
https://lore.kernel.org/all/20260105014522.1937690-1-yi.zhang@huaweicloud.com/

Cheers,

					- Ted

