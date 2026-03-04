Return-Path: <linux-ext4+bounces-14624-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFMRIyRFqGlOrwAAu9opvQ
	(envelope-from <linux-ext4+bounces-14624-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 15:43:48 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA69A201D27
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 15:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21E663116562
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2026 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FAE3B584B;
	Wed,  4 Mar 2026 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JG6hF2YF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343171A2392
	for <linux-ext4@vger.kernel.org>; Wed,  4 Mar 2026 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633667; cv=none; b=GzEo+Hg2ymf5RRdIm5N0kmS0qRS+CVrMewxgLvmM1EUJsl2GLMd80XNnhMA9cgnvUZLmRKaa8KjtsjQWbvUrT+xY5w2lQe00V/yZpcayWmJdnphCWgWK5xs3TIQwFIUWDK8B7wbckmvGQ1ri9zi4K1kJI4gGR877n67uUE5xFJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633667; c=relaxed/simple;
	bh=FuKc6t7DcwG+mQu4eBxw6G18XWXXQKWW4YuhYjUsnZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVdXYUbAr40DApLvux++3ahdHu9fiZNt7ZIIWMeRyPc/31/Ps3I6ArvuHlltlD9zHhGinv1LdroJACk2v3SjjrqB6mx/b5v78UyrfmHCexVjemW77FZwJgKRDVEAG3ern7q8bhPMu+L1oYSp3n8s/tkIaiHAMncdJHHojJ6qyPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JG6hF2YF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (99-196-129-228.cust.exede.net [99.196.129.228] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 624EE650004187
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Mar 2026 09:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1772633656; bh=EnzvVGkZDTGoQ8+nlJHlNyl/6W2tmjA5E+T0mfIpQ6Y=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=JG6hF2YFD0ggUJ8L2zFSiCU1u/dv7gInQhdB4AWmScNHF+abeaHTwOx4mF92btQYe
	 pjKK0RQCKLNdVOD+sjYVoTVtXaHKOsSPsohrjHJ2nke8krkMaJQNDpd9YZyq+99Kri
	 d99/dMqaQ6u5UF2/XCOQO/7JnelMECUOHYz7Gt9k6UVt+so9vwrZT1YgH8jwvb8Sfm
	 kH612ne2xzV1jcHS6dSr9W60XlVZj/CPwOAFDTnHbYR6w+o3nBoN1y0krMppeLwlL9
	 vxKNzSCMi7Wn3EC4tOwxNQA/lb3CmzBzSpuS/yG1huRWaSBsKXixPW5SSQWQewcCGI
	 ldGtAQIJmMi5w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 5F8605B86333; Wed,  4 Mar 2026 09:14:04 -0500 (EST)
Date: Wed, 4 Mar 2026 09:14:04 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH 05/32] ext4: Sync and invalidate metadata buffers from
 ext4_evict_inode()
Message-ID: <20260304141404.GA8243@macsyma-wired.lan>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-37-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303103406.4355-37-jack@suse.cz>
X-Rspamd-Queue-Id: DA69A201D27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14624-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:33:54AM +0100, Jan Kara wrote:
> There are only very few filesystems using generic metadata buffer head
> tracking and everybody is paying the overhead. When we remove this
> tracking for inode reclaim code .evict will start to see inodes with
> metadata buffers attached so write them out and prune them.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Theodore Ts'o <tytso@mit.edu>

