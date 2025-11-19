Return-Path: <linux-ext4+bounces-11909-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1216DC6CF47
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 07:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4824E34ADE1
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 06:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B79314A6F;
	Wed, 19 Nov 2025 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9ej131t"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA72EC097
	for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763533943; cv=none; b=UD56tWNk4CmR8wVY+2UvFyc6ftGQ6iDt3Kp3p9lq97NlGa6I6kQYdgxmq6/2iLZYpqTfGNvXTi+WkVlqdGDM6vutcOt/+gjKwVAg2uLRhRpe0PdzozirTtxzSYEf7Ja4WYb49LJws4wveO8lC4lPxzOFPVDKkEDTgWacH6eGHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763533943; c=relaxed/simple;
	bh=e6+5sMg3EpUvdhI2tPJ3dzEll1PR6UYkIFUM8L3g8BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDic8XgG3KweUGpgwDY4wdkG1gCYAsRxgkpkzgK8hSy4Hwf+e0zFCh4jbUusCaKHqRAaUGleEShmV9dbOHnK4oteT8wHebB5Jq6U/zPCggXTfa3g+09Ak64hHU1oxw1JJGbmsZiftd+p0pn+jjjyawaVSJQQqVXo6ZGNXk3Lyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9ej131t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A926C19424;
	Wed, 19 Nov 2025 06:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763533943;
	bh=e6+5sMg3EpUvdhI2tPJ3dzEll1PR6UYkIFUM8L3g8BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9ej131tLOlnFk+17Y8lZYEEP3011Yje0DD1lRxNdE5SMPis2EyjNfQIxEeM01c+v
	 Bm52UrqW7v3fqbJGH271pPr6cZo2Epp6TefO4SYBqkTVLKv89/JIKe3tRQZ2KpM83+
	 n7fueArf4PzuxuesvP1vwXZ/bXJSHySqxnalHmHSy8X8kA/2DjWjpYln62OIYwhBPm
	 3MAMZQoFGA7Mcyr+a0kZwBP2m1uuJLnoqRz4RXXvT/k5T8pZ9WUVq54KrmppZt5QAL
	 aBFc8pcUvXDjZGfLoM00qVY7+3ZWajHi95xpcoRme0tPpYFMikOfGsHqgknY/aGFay
	 EmqLxUmwoj4hg==
Date: Tue, 18 Nov 2025 22:32:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wu Guanghao <wuguanghao3@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	yangyun50@huawei.com
Subject: Re: [PATCH 1/2] fsck: fix memory leak of inst->type
Message-ID: <20251119063222.GR196358@frogsfrogsfrogs>
References: <20251118132601.2756185-1-wuguanghao3@huawei.com>
 <20251118132601.2756185-2-wuguanghao3@huawei.com>
 <20251118183021.GQ196358@frogsfrogsfrogs>
 <3a3e1417-3f59-5bb9-337c-518ae2f43f49@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a3e1417-3f59-5bb9-337c-518ae2f43f49@huawei.com>

On Wed, Nov 19, 2025 at 09:25:00AM +0800, Wu Guanghao wrote:
> 
> 
> 在 2025/11/19 2:30, Darrick J. Wong 写道:
> > On Tue, Nov 18, 2025 at 09:26:00PM +0800, Wu Guanghao wrote:
> >> The function free_instance() does not release i->type, resulting in a
> >> memory leak.
> > 
> > Does anyone still use this wrapper?  I thought everyone used the
> > /sbin/fsck from util-linux...
> > 
> > --D
> 
> The issue was discovered while running the ext4 test cases in xfstests.
> I cannot confirm whether other users are encountering the same problem,
> but the issue definitely exists.
> 
> I also pushed a patch to fix a memory leak caused by duplicate memory
> allocation in xfsprogs. If you have the time, could you please review it?
> Thank you.

Someone else already sent a fix patch last month.

--D

> > 
> >> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> >> ---
> >>  misc/fsck.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/misc/fsck.c b/misc/fsck.c
> >> index 64d0e7c0..a06f2668 100644
> >> --- a/misc/fsck.c
> >> +++ b/misc/fsck.c
> >> @@ -235,6 +235,7 @@ static void parse_escape(char *word)
> >>  static void free_instance(struct fsck_instance *i)
> >>  {
> >>  	free(i->prog);
> >> +	free(i->type);
> >>  	free(i->device);
> >>  	free(i->base_device);
> >>  	free(i);
> >> -- 
> >> 2.27.0
> >>
> >>
> > 
> > .
> 

