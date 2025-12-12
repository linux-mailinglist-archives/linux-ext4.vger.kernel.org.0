Return-Path: <linux-ext4+bounces-12336-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE13CB9B8A
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 21:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 882863085EC5
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 20:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F692F5468;
	Fri, 12 Dec 2025 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkKgporn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6127B34D;
	Fri, 12 Dec 2025 20:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765569706; cv=none; b=jkK9VZ3JOOLzRM6XYCpixiYNkOXNfeIPlIEmQ2DCAu2Tn0H7E6CxrFj5oDXP+w0x7ogq9lLNrEw3byXVmeQ3ju9pBSvlvtDeXiX6c8JPji4OXv7DdKe9LI6DqCvMazv8l7zrU2mmGYeFsfsIYSwBC8Bz6IjWWll4wRCy8TNoc+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765569706; c=relaxed/simple;
	bh=VdzjKyh0fRSXTomXXGhUZJX0uItN5iTTBPYYaL3PclA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw9xMIpO+csLhs/gA08Eu59M4Ud1jbhyQCJ1gwhrEdfTrdX3MEqYboD1Dph2IAlEFj0zDnEm+kehqoQpkmacxBQaEPZ2HZOTq5xEq261BYSKP7fwDrdwLiH+OmLISzZfhAlC4ydxHEPBst/qTPYO1k44CZD+dSbTYqKDOUXpMpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkKgporn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2AEC4CEF1;
	Fri, 12 Dec 2025 20:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765569705;
	bh=VdzjKyh0fRSXTomXXGhUZJX0uItN5iTTBPYYaL3PclA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkKgpornmJS1nzrsy5tLDS8g5YwCuV9IqzMcQWzyczoxf0rvF17kI0WCj0ufa81xk
	 3JAuaIK1KiYoOqNRrZnQva0rNq03zhnzPZKuijNGU9AbcIsVHgzv1YKp0jLg6jU7T0
	 sroVzqPCAJdgAP7G5DHjfyFJaBxGbbb9n2WiagprO/C+mENoR+r5OUjRe4ZhE/MbY2
	 dVi/NRNSS3wkNORtH8fBFNW2t20ueoYOnBtVrFB4uX+r6XhINWdeuMRhvU0Gg1TDJV
	 +Og99n7wdo/QKNas9C6JBaAz5oUv/OsdwrUVOmNYXnlDGLxhgyvXbOdQfojkmIArJH
	 85gjvqAhfsc5A==
Date: Fri, 12 Dec 2025 12:01:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 10/13] xfs/521: call _require_scratch_size
Message-ID: <20251212200145.GD7716@frogsfrogsfrogs>
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212082210.23401-11-hch@lst.de>

On Fri, Dec 12, 2025 at 09:21:58AM +0100, Christoph Hellwig wrote:
> This tests expects to have at least 400M on the scratch device.
> Ensure that, even if test runs with small devices will probably
> break in all kinds of other funny ways.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

That is a funny thing indeed ;)

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/xfs/521 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/521 b/tests/xfs/521
> index 5cd6649c50c7..4d359d641716 100755
> --- a/tests/xfs/521
> +++ b/tests/xfs/521
> @@ -20,6 +20,7 @@ _begin_fstest auto quick realtime growfs
>  
>  _require_realtime
>  _require_scratch
> +_require_scratch_size $((400 * 1024))
>  
>  echo "Format and mount 100m rt volume"
>  _scratch_mkfs -r size=100m > $seqres.full
> -- 
> 2.47.3
> 
> 

