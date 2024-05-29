Return-Path: <linux-ext4+bounces-2695-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE23E8D2A4D
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 04:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15ABEB26DDF
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 02:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6EF15B11D;
	Wed, 29 May 2024 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QPRIznJ4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD715A856;
	Wed, 29 May 2024 02:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948096; cv=none; b=MD7eYoUq6JKOpL3k7E5MzsrGDLrhkoZHICk7WvfE6hM6PY7kakoObIljnPvLEimV9cP9aKSVUVKQNQcXOFNNvGhENuobiHM9JkMWrjKLd/hvZyy1avK7rtvAuRfEe9HDhUQkPChwpzKSlOwzi2fQxjtCCa8bX4IXTr5j1u+Y7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948096; c=relaxed/simple;
	bh=cjm0d7iJq0ZZy8NXDanN6QOQ8yyu7l9oVdu/MkVpRNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDdjpKuv8o+K6onjgpSc+cEMx2ghOMctnXIo7N2f0B/0sQKw2nk1l7t/mDqSKSKis+kNwf7Smuiz0WIS0ELs/WpBr9jEiMMKIuTHq7oWSYS9rRxI1mwUgkYXp4VWw055/lMn5qwDNSkHXCytJNmJQB6f+o9BEiUcAEGIqI2V7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QPRIznJ4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W7VynibdGQv1JFv2RbWXbyZjg4WNXsABmpDa7JG50io=; b=QPRIznJ4SQbjdTZHwCXUdxD3wi
	iguHnEQ10cLXK9n/V6VJZhgX2zIqnZfMPHSXksRjo2pwj/EI6Gr2ohFokkT9uVfDKXI/4opg/e+ff
	L89UVW0ZOu/7ryKAyEOv4+McyGolM1uCZP+a8PmBKup3+qq+HOiFeFvJ7/jVLB6ANTsUpgMOg+bcG
	mJYr014oSDEnektFQWy3cpt2WploE0IkkcJgSY4UmzrGrLJhGeGjVuiZ3dlAqQYjWKMldPejk0SaF
	oJSyXY1v8bKlSJ/eCTHoJEqI0Fdg/D/rgLROJ10rBi9ka7KI/2GcrIewzP48CA+9wXbxyJ8p0IJOW
	JsA82X1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sC8d8-001pva-22;
	Wed, 29 May 2024 02:01:30 +0000
Date: Wed, 29 May 2024 03:01:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+fe42a669c87e4a980051@syzkaller.appspotmail.com,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [PATCH] fs/dcache: fix warning in ext4_xattr_inode_lookup_create
Message-ID: <20240529020130.GK2118490@ZenIV>
References: <0000000000002b03350619853096@google.com>
 <tencent_72297DA3B4444FF762977666C65361437E05@qq.com>
 <20240529015652.GJ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529015652.GJ2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 29, 2024 at 02:56:52AM +0100, Al Viro wrote:
> On Wed, May 29, 2024 at 09:15:02AM +0800, Edward Adam Davis wrote:
> > ext4_xattr_inode_lookup_create() will use s_root, so set it to NULL
> > after do_one_tree().
> 
> Why, in the name of everything unholy, would eviction of dentries need
> to set any kind of xattrs?

IOW, that might make the testcase STFU, but something odd is happening
there and I would really like to understand the details before we go
that way.

