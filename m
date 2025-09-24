Return-Path: <linux-ext4+bounces-10384-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E19C6B9BBB0
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Sep 2025 21:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E277B241A
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Sep 2025 19:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247126D4C6;
	Wed, 24 Sep 2025 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KoxlmmMy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601B502BE
	for <linux-ext4@vger.kernel.org>; Wed, 24 Sep 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742653; cv=none; b=Zqvq74aZlI4DOgZ8EY0QijeNTK2A3MVZUyJea+tqZRVgRfjxC1DvIYAEvvHJUKNOteB6q4Ak2rS2UsyyVeZQKErAL8/DHZWKBtu/jK24KLmacrOwHO8caqwEcm/DaoCi24zjo4Br2AAROMbR8mhQfnHWaCA87VRzDvkXWZdyq8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742653; c=relaxed/simple;
	bh=CTtir07BLFVpeVOHSOTyi5pXsD+HUI7wIpKFh5BZD7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iicbN8NcP0+DC/RVdnnbq9LnZwKO1nI/gh/++n5oxrYxu2vsdVYeJkSKcb41ccRmcP60aodFQApQ/HYg85/TpOoqim2Xq0iEmBgk7Pi68XxcGkpyNSe6Vd4utOY3jqDN1jVZCLNy72didCLlqy577GQrqGRENttIdspsbpM6uR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KoxlmmMy; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-125.bstnma.fios.verizon.net [173.48.102.125])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58OJbCnq007306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 15:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758742634; bh=lt5y5fH1MBdynUS3VJrpA/WyUC8uzUvfZLwgSUT/YeM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KoxlmmMyKtUoNWIiM99qh+teaNJmaOeTvD56124jCJdvSMYinsSFVS84Z9I4bDV50
	 mK6J9vngZRXOzB9jk8bhqWogOY6qZLXppl/1LxVUWVA2OGonPCIeQxCfyFnFagx+TO
	 arkUR9w+vYCrf9NKEu1bGWEjrVIRFCW1hvTfPwWcUxBjrxn+IWUcA3VskluASCHscH
	 NNjWE6gMl/ayHUt82BUxggBhSmaq3cypT+uaziIoqPh04coZR2MK22nbWMIq2agUyG
	 A7soBZVyWtTlwJRLV6AinYJ+DQIG+6iBsCLRALoS6hJifsKEDCmJ53RevKKhh+7DJ0
	 W+eQKuDynEtOw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 71D172E00D9; Wed, 24 Sep 2025 15:37:12 -0400 (EDT)
Date: Wed, 24 Sep 2025 15:37:12 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zeno Endemann <zeno.endemann@mailbox.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: ext4: Question about directory entry minor hash usage
 (documentation error?)
Message-ID: <20250924193712.GD19231@mit.edu>
References: <51a89ced-228d-4fd0-9613-3b4d027d9162@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a89ced-228d-4fd0-9613-3b4d027d9162@mailbox.org>

On Wed, Sep 24, 2025 at 06:04:08PM +0200, Zeno Endemann wrote:
> 
> The documentation of hash tree directories claims that interior nodes are
> "indexed by a minor hash".

Yes, that's incorrect.

> However from my current understanding of the code, it seems to me the node
> splitting works somewhat like regular B-trees, and there is no re-sorting
> with a minor hash going on. The minor hash doesn't influence at all the
> on-disk data structure, and is only used for sorting in a kernel internal
> rb-tree. Is this correct? If so, I could offer to write up a patch for the
> documentation.

The hash is used as the directory cookie for the puroses of telldir(2)
and seekdir(2) on 32-bit systems.  On 64-bit systems, we use the hash
plus the minor_hash to form a 64-bit cookie, or "directory offset".
This is also used for nfsv2 (which suports a 32-bit directory cookie),
ad nfsv3 (which supports a 64-bit directory cookie).

> As a side question, I was wondering a bit why the kernel differentiates
> between htree-indexed dirs and others when simply iterating over it (as in
> e.g. ext4_readdir), and what the point of that rb-tree there is, i.e. why one
> would want to iterate over the entries in hash tree order.

The reason for this is POSIX requirements for how readdir(), telldir()
and seekdir works.  When your use readdir() it must return each
directory entry once and only once.  And if while you are calling
readdir() a directory entry gets deleted or added, the added or
removed directory entry must be returned zero or one times, and all
other directory entries exactly once.  If you use telldir() to save a
position in the readdirt() stream, and then go back to it using
seekdir(), the rules of "exactly once unless entry is added/removed in
which case it is returned zero or one times" apply.

If you are using a linear directory structure, like the old V7 Unix,
this works fine.  But if you are usig a b-tree, where an interior node
might get split, with half of the directory entries getting moved to a
newly allocated block, the POSIX readdir() semantics are extremely
difficult to implement *unless* you interate over the directory in
hash tree order.

(There are other solutions, but they are much more complicated.)

      	  		       	    	- Ted

