Return-Path: <linux-ext4+bounces-11908-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6D4C6CF02
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 07:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6B1CF2D998
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 06:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673C321F54;
	Wed, 19 Nov 2025 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyCLMKbn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17332143C
	for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763533577; cv=none; b=gnqjNF4z6uzIlKsSgiupeU9Mry5TNHOUcNqCETmLRRDhkTkhmOyheOqMMS2cdqZi+ZXNiePikIk8OgYky7j9tUigNzL2j4n1eqD2qvUKVn43BBrxk7/+yZMtdK8IqJq+Su10XlqYxqpxqw72UIyJ4Buxxei/XhI8yogFhCpZve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763533577; c=relaxed/simple;
	bh=XBCWhQN773LNzMuP0e0Vp6enz9obPreKLmnaYNLbiKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DafwBcOoGtn32N9wBNTCvj1BwLJUlDqRhvjp+gfCEKc2RN27Wfgk+r4QwzcPXNxE9Mbv/bcLopXQ07CszJUrXpxJO8grvJNV4gkgNzrqntiTkbARJPESSxr60oxUGUH8/7J2zhaa6xcFgv0GtOmbHb+prs6Yj6Ixk8N+P2UfqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyCLMKbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D0BC2BC87;
	Wed, 19 Nov 2025 06:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763533576;
	bh=XBCWhQN773LNzMuP0e0Vp6enz9obPreKLmnaYNLbiKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LyCLMKbnWi5VLJ8Hms/mlHV9xm9VOrePz9arrA481b/kICzRmmsRwK2azXmE7TBx8
	 h0QoFYDLpvIcFBAAOACXooO1Q11aDOD6cV8GUMVLFy0qB71UPeCBb1UjQfd0V4ElFm
	 6FAf5MjVC3IO+XzA4NhDI+WRc3o3IZEWQDER+lwjUV8kcWgb1LEbGxSO11wTN4t8C1
	 rJsMtv1O3sLO0QuZi1R822JykHT54XZZ83Ok1hf3WE13Im2peAQJPCGQb8U1wKZ+L3
	 nMULB/7Inut1W5NFwzd3ewJo0HfBlFCcxEtTp0gnG+E013yJRkG6A0ZlWDFFkCpjOT
	 RTa3V7K5wOnOg==
Date: Tue, 18 Nov 2025 22:26:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wu Guanghao <wuguanghao3@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	yangyun50@huawei.com
Subject: Re: [PATCH 2/2] resize: fix memory leak when exiting normally
Message-ID: <20251119062614.GB196391@frogsfrogsfrogs>
References: <20251118132601.2756185-1-wuguanghao3@huawei.com>
 <20251118132601.2756185-3-wuguanghao3@huawei.com>
 <20251118182919.GP196358@frogsfrogsfrogs>
 <b77146eb-f2cf-f2eb-b0c2-561879c23475@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b77146eb-f2cf-f2eb-b0c2-561879c23475@huawei.com>

On Wed, Nov 19, 2025 at 09:52:19AM +0800, Wu Guanghao wrote:
> 
> 
> 在 2025/11/19 2:29, Darrick J. Wong 写道:
> > On Tue, Nov 18, 2025 at 09:26:01PM +0800, Wu Guanghao wrote:
> >> The main() function only releases fs when it exits through the errout or
> >> success_exit labels. When completes normally, it does not release fs.
> >>
> >> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> >> ---
> >>  resize/main.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/resize/main.c b/resize/main.c
> >> index 08a4bbaf..71711229 100644
> >> --- a/resize/main.c
> >> +++ b/resize/main.c
> >> @@ -702,6 +702,8 @@ int main (int argc, char ** argv)
> >>  	}
> >>  	if (fd > 0)
> >>  		close(fd);
> >> +
> >> +	(void) ext2fs_close_free(&fs);
> > 
> > You might want to capture and print an error if one is returned, because
> > ext2fs_close_free will also flush the new metadata to disk.
> > 
> > --D
> > 
> This is not an error, but a normal process exit. If there is an error,
> it will follow the errout tag.

I can see that, but I'm talking about capturing errors returned by
the new ext2fs_close_free call itself.

--D

> >>  	remove_error_table(&et_ext2_error_table);
> >>  	return 0;
> >>  errout:
> >> -- 
> >> 2.27.0
> >>
> >>
> > 
> > 
> > .

