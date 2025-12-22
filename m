Return-Path: <linux-ext4+bounces-12481-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 758ADCD7727
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Dec 2025 00:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 457C5301BEAB
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Dec 2025 23:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579F2750ED;
	Mon, 22 Dec 2025 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iV4833y/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE712E1E9
	for <linux-ext4@vger.kernel.org>; Mon, 22 Dec 2025 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766445342; cv=none; b=vGe2OCJSSJ2SSf4gQmfOdyoJvg6dq7JEVek04nbFlvl2GYmqtooelTWc/lacnHJ0lt0kmHQU+zgmdZdWeeAjWvoZ7POje0gw3ZuBK0qj1BeaFgEIJxB/Yo8BwuK8fNe0oQ1YW4e6PunSzQjLKzAbgRCpKv/QgEioNyA4ao0zzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766445342; c=relaxed/simple;
	bh=WOwVotv14cAbo1UNweZk5yr6XIl+EtA0DTtMBP2vZr0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgHrcAI0tb878UXJGhGdtftsOHlD7hqQMkp1bWSKqFU9vP34ZmY45RBpSjEYHch5j2uCReXHYHHgYilDgmT01ek/ycQIZZqroYe+ARGMifJ2xqwwZ3a/EoztTiYvNILJ6H1Fe6xGQetXb4g3hq2N2rm0b+QKiyPcuGr68tDMJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=fail smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iV4833y/; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1766445324; x=1766704524;
	bh=WOwVotv14cAbo1UNweZk5yr6XIl+EtA0DTtMBP2vZr0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iV4833y/5eBkOp+ZbfNtMg+k+UtbyomV5sSwiKbdkaR1L5SQIRpXct2Xl/IqMDcPU
	 f5xdi2jR8LNGVUy4pByIQ9JGXnDxUaGM8OBuL0Qd4AqdwD3s81/Y3ZIp1sHhJXhqpy
	 TrYL3TFx3eXY64jn70AzDnfyR8fqJrUYdkOVWOCcJlBlzgGOsNiFDR+m8l/3YHmx41
	 HhgJco8nK810CZh7YM8baCgHSmLukKRH1e6Jj0drssYvwRhzsc3UXcRlA2qPQssXbg
	 OxAaO0QtEKiCnxilvXrGc+ZuehogrTf7acUj0htyDMiUjqYgmpmu6nmvnCd8YUvNSj
	 Kjv5T7nydki1Q==
Date: Mon, 22 Dec 2025 23:15:20 +0000
To: Andreas Dilger <adilger@dilger.ca>, "tytso@mit.edu" <tytso@mit.edu>
From: Daniel Mazon <daniel.mazon@proton.me>
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: ext4: a tool to modify the inode count
Message-ID: <woSqjqMgjW_pNb2fMhKZ20_RP4BrbYKrX6NHMhGu-n3Mt0VVdP0UiEEopdqeo63OehhHmTs2zJoF8UVU96_IaPiQRvrNyyo-FMCuoPAtKXQ=@proton.me>
In-Reply-To: <EB431D42-1CDA-4522-B365-8411801B684E@dilger.ca>
References: <PAsXqba23hYRwwgFsaneY7Hmxe8-AmdAhSAUH2CW_vtTAi0Y8wVch4QrmW-gU2KahqhsxpxHesEDBZSXlM70jazF0yC-DaPfWgFckG6uzXo=@proton.me> <EB431D42-1CDA-4522-B365-8411801B684E@dilger.ca>
Feedback-ID: 172137602:user:proton
X-Pm-Message-ID: 3fc1df88a5356771e4962d97c19dbb28396d5b14
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, December 18th, 2025 at 09:09, Andreas Dilger <adilger@dilger.c=
a> wrote:

>
>
> On Dec 17, 2025, at 11:04, Daniel Mazon daniel.mazon@proton.me wrote:
>
> > I wrote a small tool to modify the inode count of an existing ext4
> > filesystem. It is largely based on the resize2fs tool from e2fsprogs.
> > Previously, the inode count was selected at filesystem creation and
> > could not be modified afterwards.
> >
> > It provides a way to increase or reduce the inode count. I developed
> > it because I had a 3.5 TiB ext4 partition created with a default
> > 16384 bytes-per-inode ratio. This created over 200 million inodes,
> > allocating over 50GiB to inode tables. However, I was using less than
> > 0.1% of inodes, so I wanted to reallocate those unused GiB from inode
> > tables to free space.
> >
> > To test the program, I created testcases trying to cover all possible
> > ext4 options that could be impacted by a change on the inode count.
> > After some time, I think it works well: no fsck errors after the
> > change, and all data is still there. Please bear in mind that this
> > has only been tested by one person.
> >
> > I think this tool could be useful to someone else, as it adds
> > flexibility on a parameter which was previouly unmodifiable. The code
> > can be found here: https://github.com/danim7/inode_count_modifier
> >
> > Please don't hesitate to let me know if you give it a try. I hope this =
mailing list is the right place to communicate this, if not,
> > please excuse me for the noise.
>
>
> Hi Daniel,
> thank you for your contribution. Changing the inode count of an
> existing filesystem independently of the block count is definitely
> something that I've wanted to do at various times in the past,
> and I'm sure lots of other ext4 users have wanted to do the same.
>
>
> IMHO, your development efforts would be far more utilized if this
> functionality was included directly into the resize2fs utility
> (which your README.md mentions was the foundation for your code).
>
> This will not only ensure that this capability continues to be
> maintained as e2fsprogs is updated (e.g. if new features are added
> to ext4 and/or e2fsprogs), but it also allows a much larger number
> of users to have access to it when they need it. Otherwise, it
> seems likely that most users will not know "inode_count_modifier"
> exists, and they will not be able to change the inode count.
> Even worse, someone else might spend a lot of time to re-implement
> this due to a similar requirement as yours.
>
> It makes sense to get an Ack from Ted before spending time to do
> that work, but I think it would be best for all ext4 users... and
> you'd have your code installed on millions of computers worldwide.
>

Hi Andreas,

Thanks for your reply.
I agree, this tool would be much more useful if it were integrated
in the e2fsprogs suite. I can spend some time to prepare a patch
if I get the pertinent ack.
IMHO, maybe the best approach would be to keep it in its own binary,
and compile with the object files containing the functions from resize2fs
which are used to also modify the inode count. This shall benefit from
reusing code, and not overload resize2fs with functionality (which
already does resizing and switching between 32/64 bits). But I will let
the experts decide on what is the best course of action.

Regards,
Daniel




