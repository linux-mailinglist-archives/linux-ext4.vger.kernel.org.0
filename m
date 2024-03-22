Return-Path: <linux-ext4+bounces-1735-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A5886FAF
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 16:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C5C1C21DC4
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F724F897;
	Fri, 22 Mar 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jXFYqGMe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C24D134
	for <linux-ext4@vger.kernel.org>; Fri, 22 Mar 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120636; cv=none; b=Ih9Wdez2hzsVSx093xnXEKez/2Blgwo28eTfWcxk/jKAE9Db+G00mpV/HBchuCoHnPZhC+l5aAHZ+XlDV3vB1EeSSeZx4U+vNP0rLExQpbi8qirM4/5HoAKaOyDmF7BW0jxe1jR/UiESeZXDL4xVgTvrMqIUSOPW8gL4WtN2l1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120636; c=relaxed/simple;
	bh=eiVxLfEbT2fV2MypbifS2SQXxSiacXNMhFESsejWf7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ullMdebnidcnK1cgRXChZt6FLWfMhr0jnzZcNViJPk1dVVGM0+8UCfzsiqWUzpYKJ5ASt+aScRVChs3KDHrMTkVELzV0NBvDQdqEkQXNdX/7ERpn1ZdOAn9Ke7jeOnhyXCDjLKKWvffJ4BiO46khJ7igU7lG88QVV82gOXhkxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jXFYqGMe; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711120632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=frMCKDXPG6C6yySkxGYI1EQakMDsEGGuUgb/MT4GE4g=;
	b=jXFYqGMeJw+ipXCAEa15FYcqmaV0hwDuo0hCYglk2DX8jpk7tdLkYxPjFxCRBhyJpMjMUD
	ppxh/NHvM+jpSQ5BmLyRsvTtJf+tQNMfO++VK/RTcEWb61QetAFewltPYwQmK8xb2bVwy8
	QCaWJRP2I/jzW7FOWhFTC7AgQbzCSqs=
From: Luis Henriques <luis.henriques@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Jan Kara <jack@suse.cz>,  Theodore
 Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger.kernel@dilger.ca>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Amir Goldstein
 <amir73il@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-unionfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount
 parameters
In-Reply-To: <20240322-ortseinfahrt-gespeichert-9fc21a98aa39@brauner>
	(Christian Brauner's message of "Fri, 22 Mar 2024 15:22:41 +0100")
References: <20240307160225.23841-1-lhenriques@suse.de>
	<20240307160225.23841-4-lhenriques@suse.de>
	<CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
	<87le6p6oqe.fsf@suse.de>
	<CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
	<20240311-weltmeere-gesiegt-798c4201c3f8@brauner>
	<CAJfpegsn-jMY2J8Wd2Q9qmZFqxR6fAwZ4auoK+-uyxaK+F-0rw@mail.gmail.com>
	<20240312-orten-erbsen-2105c134762e@brauner>
	<87h6hbhhcj.fsf@brahms.olymp>
	<20240322-ortseinfahrt-gespeichert-9fc21a98aa39@brauner>
Date: Fri, 22 Mar 2024 15:17:09 +0000
Message-ID: <875xxe2t56.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Christian Brauner <brauner@kernel.org> writes:

> On Tue, Mar 12, 2024 at 10:31:08AM +0000, Luis Henriques wrote:
>> Christian Brauner <brauner@kernel.org> writes:
>> 
>> > On Mon, Mar 11, 2024 at 03:39:39PM +0100, Miklos Szeredi wrote:
>> >> On Mon, 11 Mar 2024 at 14:25, Christian Brauner <brauner@kernel.org> wrote:
>> >> 
>> >> > Yeah, so with that I do agree. But have you read my reply to the other
>> >> > thread? I'd like to hear your thoughs on that. The problem is that
>> >> > mount(8) currently does:
>> >> >
>> >> > fsconfig(3, FSCONFIG_SET_FLAG, "usrjquota", NULL, 0) = -1 EINVAL (Invalid argument)
>> >> >
>> >> > for both -o usrjquota and -o usrjquota=
>> >> 
>> >> For "-o usrjquota" this seems right.
>> >> 
>> >> For "-o usrjquota=" it doesn't.  Flags should never have that "=", so
>> >> this seems buggy in more than one ways.
>> >> 
>> >> > So we need a clear contract with userspace or the in-kernel solution
>> >> > proposed here. I see the following options:
>> >> >
>> >> > (1) Userspace must know that mount options such as "usrjquota" that can
>> >> >     have no value must be specified as "usrjquota=" when passed to
>> >> >     mount(8). This in turn means we need to tell Karel to update
>> >> >     mount(8) to recognize this and infer from "usrjquota=" that it must
>> >> >     be passed as FSCONFIG_SET_STRING.
>> >> 
>> >> Yes, this is what I'm thinking.  Of course this only works if there
>> >> are no backward compatibility issues, if "-o usrjquota" worked in the
>> >> past and some systems out there relied on this, then this is not
>> >> sufficient.
>> >
>> > Ok, I spoke to Karel and filed:
>> >
>> > https://github.com/util-linux/util-linux/issues/2837
>
> This is now merged as of today and backported to at least util-linux
> 2.40 which is the current release.
> https://github.com/util-linux/util-linux/pull/2849
>
> If your distros ship 2.39 and won't upgrade to 2.40 for a while it might
> be worth cherry-picking that fix.

That's awesome, thanks a lot for pushing this.  I just gave it a try and
it looks good -- ext4/053 isn't failing any more with the next version.

Cheers,
-- 
Luis

