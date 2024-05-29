Return-Path: <linux-ext4+bounces-2694-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6C8D2A25
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9941C23A9E
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A9F15AAD6;
	Wed, 29 May 2024 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BLvYZ1mj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21426AF3;
	Wed, 29 May 2024 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947823; cv=none; b=fhuZMqImQvyr24XeXFzHkM9JivW/mbRfmtTSgahPs911lapsf1+Rek5/Pv8fn/OMhKplUE4qfkqhvh9aOKf/cAeJBzqMWi7wDbaZMAHWsf8QCLVLYP8Ubi4M3NgDrPMHVj1qdJWoOr7om/Cyvb30lc1xdENgEwvewdV/fypNm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947823; c=relaxed/simple;
	bh=SA3fTcT7iYSxePTtaFtUE4a8/MmXF+EmncSV/5Od3Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goVdEoDKIjdwrwiAiyh0/ooe4/PefOL6AVHujVtlY62iL9XSpsOnJskuu7zq0Vg2x+igPuaNydeW10nzeofROFm9u5A9l+7nAOG5XIg9F8tfiJ3LpNMk1AkvfSKscWqA2rnZqBI9Z8v+Z4SAl1/Gisvim9s0rgQ5Fpm6fi5UtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BLvYZ1mj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SA3fTcT7iYSxePTtaFtUE4a8/MmXF+EmncSV/5Od3Jk=; b=BLvYZ1mjobUUYuRlnEz1zzwo6I
	wTMeWeJ8ZnV37R/nkMZjMdSrPAak6erbriuu/UyxqMWrcqolyvVALqpotgKTBPtpSp1er/N/H59TH
	qZexIB5BYvpvs3IpS0KwWDxTPGVLrrZKZogaqyvobFpTul8JPc4Xp4z7y+DHw20jqyQ9j5AiTkGjL
	fRMqRIy6JugLL02+qMRsoa+PEn2z87az8SiFMzLNGQdt9nmFQAfTE0nKpoUUGeWpQ9H6DOeQ5ZsWP
	3pBAyhLBXtVBH/nzlfQUkF2I+fmZeTXyycoIeUUSWQPpoOr5QICvEg+TJC9I+RXrR4g/fBlOU3Ibj
	c7cOJjZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sC8Ye-001pRY-22;
	Wed, 29 May 2024 01:56:53 +0000
Date: Wed, 29 May 2024 02:56:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+fe42a669c87e4a980051@syzkaller.appspotmail.com,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [PATCH] fs/dcache: fix warning in ext4_xattr_inode_lookup_create
Message-ID: <20240529015652.GJ2118490@ZenIV>
References: <0000000000002b03350619853096@google.com>
 <tencent_72297DA3B4444FF762977666C65361437E05@qq.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_72297DA3B4444FF762977666C65361437E05@qq.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 29, 2024 at 09:15:02AM +0800, Edward Adam Davis wrote:
> ext4_xattr_inode_lookup_create() will use s_root, so set it to NULL
> after do_one_tree().

Why, in the name of everything unholy, would eviction of dentries need
to set any kind of xattrs?

