Return-Path: <linux-ext4+bounces-981-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B1583EB96
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 08:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2066B237E4
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 07:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEBE1D55F;
	Sat, 27 Jan 2024 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sf1vNO5u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B431429C;
	Sat, 27 Jan 2024 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706339326; cv=none; b=s2GA0iColj0Mm2EGDgjUKzwcLhc/5BV07/KRPV0N50S9hcB/+OEFo0g2yjyQPTh/f3As+r+l87DD0FfwwJgHBIVMPfaVPvYaguZ/JHrrcb7r0GKkwmlO6Zf96y1k6ZJNjr+DUpv7XKyCcTW8KIPLv0YwZ53IKdh6C9ZOfhSurYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706339326; c=relaxed/simple;
	bh=7w5fa3Ag9H7/c8fy6jHzWzQkyjGpS52jN7UOyJSIxRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+47YmE4RrT6DhQiIp/D3SRgIYyk+DClX3Pg2ovnGbUzezQX7NT5YblI0kLTliSmbR4dBSqTIx8cgU9/ApxerF20KWaBvAediVf50xwJxCqmyD12vdazV82beQZ1oEabKEBuwWjnm1QexX4Py4QYxB/RPmqBD3dBjl8EDoW+Jzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sf1vNO5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B2AC433C7;
	Sat, 27 Jan 2024 07:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706339325;
	bh=7w5fa3Ag9H7/c8fy6jHzWzQkyjGpS52jN7UOyJSIxRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sf1vNO5uSOggOozanoCjLkMiKUovChZbxbH0iC0oeTc+3QqAjutuLasBVOJ0YGeh9
	 vb5siXyYrhtUTnDUB4eXp5n4TdA9QONkQdGJq+/qj+uaI1M5tgpnOOlCr1Zr81Dxww
	 25zRp8sUPgXF35JFynTfLm8TRnz+yAIHvM8n/tdO/YfLapqkwp9YTgBAOAYaIdFP0U
	 tFzacM7clceCwWN/WGX6i1Kd4qmIcDbEo5gtDQoqbLdnMX2sch83BO4/cgUinwdiAC
	 3ZyW3TS75P6dySuTuchoKTLj+s6i3CSwVGCGyIlu51mQNXhjuytmCAcxs35HQbgv/8
	 NoGKhpCntAtHA==
Date: Fri, 26 Jan 2024 23:08:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com
Subject: Re: [PATCH v3 01/10] ovl: Reject mounting case-insensitive
 filesystems
Message-ID: <20240127070843.GD11935@sol.localdomain>
References: <20240119184742.31088-1-krisman@suse.de>
 <20240119184742.31088-2-krisman@suse.de>
 <20240125025115.GA52073@sol.localdomain>
 <87jznxs68r.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jznxs68r.fsf@mailhost.krisman.be>

On Thu, Jan 25, 2024 at 01:55:00PM -0300, Gabriel Krisman Bertazi wrote:
> I'm not sure how to change and still make it readable by users.  How about:
> 
>   return invalfc(fc, "case-insensitive capable filesystem on %s not supported", name);
> 
> what do you think?

"case-insensitive capable" sounds good.

- Eric

