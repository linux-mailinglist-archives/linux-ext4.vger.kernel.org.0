Return-Path: <linux-ext4+bounces-7227-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33CDA872FF
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 19:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F8017196F
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBCE1EEA34;
	Sun, 13 Apr 2025 17:29:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D81386B4
	for <linux-ext4@vger.kernel.org>; Sun, 13 Apr 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565370; cv=none; b=dLXC/4LCAJu+VWnFUuOvfmIm8BuoCVIPKCSvfCw/ZN6+i8MwfAjJ3Dd00rt+Vc4WNcn83WY1ObvEv99JgLo3v+Lp+TRea7/cUevVtV2qghTJ2Jm6AurD7JNNamAiInGHZeLrd/OtzRodPx3lvvNKo9yslPibzheRVcek6VXyF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565370; c=relaxed/simple;
	bh=6m4AO4SXWJoic9wXT6AedSzOH1FGcYKu9178+RFlFLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gz2UFNhasaZHLq1fvkYWWWhBhEAVKC/0sQV7DZSUqs/zDayYidmzeRMXZ7lBlEUM3ZDf+aCtdAX4lblseoZsJZ31ULLFPmt08sYUTbzba3GSENvCea7PufdPvCwlMhGqtEpw4nvL57E/tWZqUnTHD1yexkj4G3kKYFK64u9J5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-137.bstnma.fios.verizon.net [173.48.82.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53DHTGP9007002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 13:29:16 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BC4382E00E9; Sun, 13 Apr 2025 13:29:15 -0400 (EDT)
Date: Sun, 13 Apr 2025 13:29:15 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <20250413172915.GI13132@mit.edu>
References: <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
 <20250412215257.GF13132@mit.edu>
 <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
 <20250412235535.GH13132@mit.edu>
 <CAGudoHEJZ32rDUt4+n2-L-RU=bpGgkYMroxtdMF6MQjKRsW24w@mail.gmail.com>
 <20250413124054.GA1116327@mit.edu>
 <CAGudoHEFFMz3Jm-N2QBJthH_5inWkz278YVfjQO4H0qk2p98HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEFFMz3Jm-N2QBJthH_5inWkz278YVfjQO4H0qk2p98HQ@mail.gmail.com>

On Sun, Apr 13, 2025 at 02:52:32PM +0200, Mateusz Guzik wrote:
> On Sun, Apr 13, 2025 at 2:40 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Sun, Apr 13, 2025 at 11:41:47AM +0200, Mateusz Guzik wrote:
> > > This is the rootfs of the thing, so I tried it out with merely
> > > printing it. I got 70 entries at boot time. I don't think figuring out
> > > what this is specifically is warranted (it is on debian though).
> >
> > Well, can you run:
> >
> > debugfs -R "stat <INO>" /dev/ROOT_DEV
> >
> 
> attached full list after boot

So it looks like the test is working corretly.  Most of the inodes
either (a) have a Posix ACL defined, so we were definitely doing the
right thing, or (b) had a user.crtime_usec xattr.  My personal opinion
is that crtime is fairly pointless, and having microsecond accuracy on
the creation time is *completely* pointless, but we can't stop
programs from doing that.  (Therre was also a single xattr field that
contained the xattr user.random-seed-creditable.)

So it will ultimately come down to how much user think performance
compares to microsecond-level accuracy on crtime, which as far as I
know, no Linux programs other than samba / CIFS servers who want
Microsoft feature-for-feature compatibility care about.

(Or SELinux when it sets security ID's, but if you are using SELinux a
few extra branch instructions are the *least* of your performace
headaches....)

						- Ted

