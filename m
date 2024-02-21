Return-Path: <linux-ext4+bounces-1353-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C1A85E9A3
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 22:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7300B23877
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B041272DE;
	Wed, 21 Feb 2024 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="jZB4DMWP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F2126F37
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549906; cv=none; b=P4/hisnKZhWO1W2VimcHgfGVuCeszJGS4zJUFFGmJEGSwQotKzE8pZwjq4qevONODlhmWC2pmyk/KenaKXVBy1SsvzwNU4KqaNIaDuT08Nsvgyj8r5Gfkjvj5p3443YPo5gdNI+X+fkmTlM19EuIsLmCMKCl+RMjrs0qa23BhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549906; c=relaxed/simple;
	bh=rAu5hXr+IvzK37PAMawmi9KH/zsDUxlgco15ekjwJT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ircfz+WGWYz8OZc3PFeH+JUbRQJDEgXnPu3SDTW52j9UEtYVvHrqNCK6FdBSX7rspcRx0t4ZbW9OGicM3KDpFb5nLKezIzTqDjFRWFwVxn8Trxy3pl0KzCGrR3iHRQCqoxDSGy6H/MWHdCx5AQQM4J86A6yjcm0ezUTqcxWJOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=jZB4DMWP; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41LLBaOf020463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 16:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708549898; bh=4IF/TDEtjz8qAqYX7SwNgWqDwz8pWojSp1bTx/j4EbU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=jZB4DMWP69jlCM/e4U4e7+qKnmkgA2EEM3Oa4BDGQLneJA1CdPBxHPIxA9nNELB8p
	 g1Hae55HBsj2v0/ckDnBLI0BYrPN2kD6wk+8x9IX3ol8QdTrv5gHfM5YXNVee5x7eg
	 y3LdPlEmBpjyx8rYqokHVfOmnqjGO6ZYsWihBRppN+5Fkoz2O0iawxmCFQKybb267i
	 XAFAeyPrAc4D6ZjD9txeE5ZUngBf3JFrCjdNTJSnu/82uAT36SXXjg76S6CaWQLCD0
	 z3ppkcppVm/8GOuMO71XQVxpRPz4VV60lgT8Cq+FhqByakMeqE1zURrPQHli4bfnUO
	 ebuU0QXoqYICQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4F59215C0336; Wed, 21 Feb 2024 16:11:36 -0500 (EST)
Date: Wed, 21 Feb 2024 16:11:36 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
        linux-ext4@vger.kernel.org
Subject: Re: Why isn't ext2 deprecated over ext4?
Message-ID: <20240221211136.GA633176@mit.edu>
References: <bcaf9066-bb4a-4db3-b423-c9871b6b5a2f@bootlin.com>
 <20240221110043.mj4v25a2mtmo54bw@quack3>
 <192cb320-2ded-4761-b0c9-3e273931f6f6@bootlin.com>
 <20240221165805.plnkvymjzqts2l6r@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221165805.plnkvymjzqts2l6r@quack3>

On Wed, Feb 21, 2024 at 05:58:05PM +0100, Jan Kara wrote:
> Hum, so I didn't quite think through my comment about on disk format :).
> When you create filesystem with larger inodes, mke2fs will indeed create
> inodes with extra timestamp fields etc. ext4 driver will recognize them
> and use them, however ext2 driver happily ignores them (I thought we refuse
> to mount such filesystem but we don't because of the way how large inodes
> were defined in the ondisk format).

Well, if we *cared* we could backport the support for the expanded
timestamps to ext2.  I'm not sure it's worth the effort, but it's not
that hard....

					- Ted

