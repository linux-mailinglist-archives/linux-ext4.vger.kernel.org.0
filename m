Return-Path: <linux-ext4+bounces-7945-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE11AAB9EE7
	for <lists+linux-ext4@lfdr.de>; Fri, 16 May 2025 16:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39C73B486C
	for <lists+linux-ext4@lfdr.de>; Fri, 16 May 2025 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B2192B84;
	Fri, 16 May 2025 14:49:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629FB190072
	for <linux-ext4@vger.kernel.org>; Fri, 16 May 2025 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406942; cv=none; b=XWz77u/6qvSPnXt23Ahh8d38kcDu39OcaZjS8RRkU+rTnb7bXC0JHKw5VEJSgiPbX10MUqZA0qnHvZrC2Ors3ijDffDK+LXBMHb8Bb4jkQS4y8HFqHSyzFQhEyd1JTXTXsiLZc+m7qZ1wbDJdA2pNmp12RAdt96k34IH7tL1mVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406942; c=relaxed/simple;
	bh=+VH8Gbs2kjNZ9IN29v2lrqtramjIwWZ+QcvvFd3l0N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXCXKZ/Lwx9DlCgLtuyCgnpiVDbSwCbDmlPEnI8Y4GnDVh+UptfhuZNGHiyqz/i/WeBgk0uWGjKWXr1HTSaZ5fawseeIfQIZIuCaa4qA0NggAgvzXka9AZKhQzHGgwXbQbPr40jHsP2q2Mkqikb6o+A2lpA8SxT9firdnYe9iPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-151.bstnma.fios.verizon.net [173.48.112.151])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54GEmHXU017261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 10:48:17 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 311C92E00DD; Fri, 16 May 2025 10:48:17 -0400 (EDT)
Date: Fri, 16 May 2025 10:48:17 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Carlos Maiolino <cem@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, djwong@kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] ext4: Add atomic block write documentation
Message-ID: <20250516144817.GB21503@mit.edu>
References: <cover.1747337952.git.ritesh.list@gmail.com>
 <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com>
 <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>
 <20250516121938.GA7158@mit.edu>
 <6zGxoHeq5U6Wkycb78Lf1YqD2UZ_6HbHKjIylyTu1s2iRplyxIkQL9FOimJbx_qlfo2fer1wwGQ-5r8i9M91ng==@protonmail.internalid>
 <920cd126-7cee-4fe5-a4ab-b2c826eb8b8c@oracle.com>
 <cuyujo64iykwa2axim2jj5fisqnc4xhphasxm5n6nsim5qxvkg@rvtkxg6fj6ni>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cuyujo64iykwa2axim2jj5fisqnc4xhphasxm5n6nsim5qxvkg@rvtkxg6fj6ni>

On Fri, May 16, 2025 at 03:31:17PM +0200, Carlos Maiolino wrote:
> 
> This is likely the final state for XFS merge-window and I hope to
> send it to Linus as soon as the merge window opens.

Very cool!

I've taken a quick peek, and it looks like the only XFS-specific
atomic writes is an XFS mount option.  Am I missing anything?

I want to keep merging the ext4 and xfs atomic write patchsets simple,
so I'd prefer not to have any git-level dependencies on the branches.
If we're confident that the xfs changes are going to land at the next
merge window, given that the ext4 patch set is pretty much ready to
land in the ext4 tree, how about updating the documentation in a
follow-up patch.

I can either append the commit which generalizes the documentation to
the ext4 tree, or if it turns out that there is a v6 needed of the
ext4 atomic write patchset, we can fold the documentation update into
the "ext4: add atomic block write documentation" commit and rename it
to "Documentation: add atomic write block documentation."

Does that seem reasonable?

Cheers,

					- Ted

