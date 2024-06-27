Return-Path: <linux-ext4+bounces-3001-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF6991AAB2
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 17:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B827B274D3
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 15:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263A19885B;
	Thu, 27 Jun 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tLiwRSPW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231DB1591F0
	for <linux-ext4@vger.kernel.org>; Thu, 27 Jun 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501057; cv=none; b=lFLQJZVBAvzYY+LGz6cOFZHnyiAFYGCgnI/ZfZZSj9trM91ly93WP1cgID1R3irfAz5bZt72JBsL+i+lyxNuUTNx9T6drmptS9inSUSFF31xFiCzJp4KcD9YaUBtgzg+XYEuuHN0N4hXZQbYjn42ngKxu4oUd4yD7viBTwNLE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501057; c=relaxed/simple;
	bh=27xZMW4OLaqCo5WWzj5gYLre9StpGphZ4TqAVIGKaN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QQ7dlfWsKIa6zmltuJnEYaUqaT+/08XjN42Us1Z2GLf6LS5l04q+a9zNc6jc4nDNn1ool5Tm6EtzxpIFUCAakTqTenlUYZlJQtI+FjQjHWy8vDbVSWLIsS8BGjjGxJ3pM1RR/yrGsvWVc28YPxM16NEOb3jkPaJaXAu1/r/VCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tLiwRSPW; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719501051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XNm3WawALojtYQ9z1+eU4F6+/xmdHrF/f+BTxtDjPwU=;
	b=tLiwRSPWfbepm7CVg0u1b/ItZvNyqzaHi22n2chnAxIlSib17q7agRmFxw/2Z85sdwOPbv
	WY9DEv2SqD+WPvqqyLmiBNvR9EqK6extEJMcSYOz7FtfHkUU0LEzBrt5uwmPWg981a4MEB
	uDXZa49DuW7P3SaUJqK/azkbkzvWssE=
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Luis Henriques <luis.henriques@linux.dev>,  Andreas Dilger
 <adilger@dilger.ca>,  Jan Kara <jack@suse.cz>,  Harshad Shirwadkar
 <harshadshirwadkar@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ext4: fix fast commit inode enqueueing during a
 full journal commit
In-Reply-To: <20240627145836.GA439391@mit.edu> (Theodore Ts'o's message of
	"Thu, 27 Jun 2024 10:58:36 -0400")
References: <20240529092030.9557-1-luis.henriques@linux.dev>
	<875xtu7aow.fsf@brahms.olymp> <20240627145836.GA439391@mit.edu>
Date: Thu, 27 Jun 2024 16:10:41 +0100
Message-ID: <871q4i7766.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 27 2024, Theodore Ts'o wrote:

> On Thu, Jun 27, 2024 at 02:54:39PM +0100, Luis Henriques wrote:
>> On Wed, May 29 2024, Luis Henriques (SUSE) wrote:
>>=20
>> > Hi!
>> >
>> > Here's v3 of this fix to the fast commit enqueuing bug triggered by fs=
test
>> > generic/047.  This version simplifies the previous patch version by re=
-using
>> > the i_sync_tid field in struct ext4_inode_info instead of adding a new=
 one.
>> >
>> > The extra patch includes a few extra fixes to the tid_t type handling.=
  Jan
>> > brought to my attention the fact that this sequence number may wrap, a=
nd I
>> > quickly found a few places in the code where the tid_geq() and tid_gt()
>> > helpers had to be used.
>> >
>> > Again, please note that this fix requires [1] to be applied too.
>> >
>> > [1] https://lore.kernel.org/all/20240515082857.32730-1-luis.henriques@=
linux.dev
>> >
>> > Luis Henriques (SUSE) (2):
>> >   ext4: fix fast commit inode enqueueing during a full journal commit
>> >   ext4: fix possible tid_t sequence overflows
>>=20
>> Gentle ping...  Has this fell through the cracks?
>
> Sorry, I'm still catching up after being on vacation.  There is a
> batch of commits which I've reviewed (up to May 17th) which is
> currently undergoing testing.  So that doesn't include this patch yet,
> but it's on the list of patches to be reviewed at
> patchworks.ozlabs.org/project/linux-ext4 so it won't fall through the
> cracks.

Awesome, thanks for the update.  And sorry for being impatient.
/me goes back under his rock.

Cheers,
--=20
Lu=C3=ADs

