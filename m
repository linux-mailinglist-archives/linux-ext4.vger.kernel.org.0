Return-Path: <linux-ext4+bounces-13987-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPN0AgzDnWmsRwQAu9opvQ
	(envelope-from <linux-ext4+bounces-13987-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 16:26:04 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEFF188F8A
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 16:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD1DF3033D1C
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B62E3A1E90;
	Tue, 24 Feb 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="U997oiXo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86823A1E80
	for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946719; cv=none; b=oK4K+PTJMpt8FLtxCST7UlOIVGzbJtkz5ee/0RAxSOnC9OhhWm4Z37lC1r0vXrKR6Njwk89L/mqq+LoFDdBHaWCy8mpzc+epvedUgq8+zGEHvxVDTkW1Hw6Ii4RbA8+msQ1oRY5lFzO+sbWdDK/DYBoDgUA1DqT+Y3mqWdwQI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946719; c=relaxed/simple;
	bh=y1Td8ktXwoJSPrRKZ0fP2h6lcagQl30y0VXis8wxycM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve+jW/LBB1gd9MBnMc/RTe+nVSDCgp3mB5chOuTp7M5R6ANw+jUENgaJ7X3xEN/5CwmEcONrcSVftlzX8T/0UKZ9ObLDhlDlzXELa1/dYDa2fV+kAEkacWlqBAhoCA3joZr1oOMVtbNLGo2NrPgSfoBXcvcKwx8IlD4GoA91sGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=U997oiXo; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-111-182.bstnma.fios.verizon.net [173.48.111.182])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61OFOqSx010759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 10:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771946694; bh=xDSAnXoB9ejN/bLi5BfMqVBcp3Wg5UbG7Pg4difgCEo=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=U997oiXoilh/FS+HP/sc9+AhvTSPm0sBVkyHybp7gSa3iwBR/F0vHIr9gMl1tvktL
	 geUmnMAjAkBOiWEs0omBnR23bwxfTcKdEFoorNTnzCi2IANakgSzfbDF1IZtx1UAXD
	 F463L33LgFV/nTPaE90lpwOv4t5pO1N3CMCqURjK5IyTc0SZGaQocu9PBIirS2jT2B
	 38WkzQSpSshgvUurqCVerpzXVYQ7WTTmiaoofZbkU+I979He89eQrXvo8HWtaqBM7X
	 9A7bqjC2LHLFwYamCJdTBTMqvXLae972b2/zlSPQXb+TTvh45vFdLkHokDvoOLYd8n
	 XbqE2fwiJvdUw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id EDB4759B421E; Tue, 24 Feb 2026 10:24:51 -0500 (EST)
Date: Tue, 24 Feb 2026 10:24:51 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fsverity: add dependency on 64K or smaller pages
Message-ID: <20260224152451.GB16846@macsyma-wired.lan>
References: <20260221204525.30426-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221204525.30426-1-ebiggers@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mit.edu:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13987-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 6EEFF188F8A
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 12:45:25PM -0800, Eric Biggers wrote:
> Currently, all filesystems that support fsverity (ext4, f2fs, and btrfs)
> cache the Merkle tree in the pagecache at a 64K aligned offset after the
> end of the file data.  This offset needs to be a multiple of the page
> size, which is guaranteed only when the page size is 64K or smaller.
> 
> 64K was chosen to be the "largest reasonable page size".  But it isn't
> the largest *possible* page size: the hexagon and powerpc ports of Linux
> support 256K pages, though that configuration is rarely used.
> 
> For now, just disable support for FS_VERITY in these odd configurations
> to ensure it isn't used in cases where it would have incorrect behavior.
> 
> Fixes: 671e67b47e9f ("fs-verity: add Kconfig and the helper functions for hashing")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Closes: https://lore.kernel.org/r/20260119063349.GA643@lst.de
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

