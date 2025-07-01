Return-Path: <linux-ext4+bounces-8758-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 606C9AF040C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 21:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E45C18998DF
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A027815E;
	Tue,  1 Jul 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="factv7t8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EF27D786;
	Tue,  1 Jul 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399136; cv=none; b=Bazc5hzKNVG9i/TcloADfQev2zoeK/Fgg9rhlM/+F0BlPQmnokMrsdWiCBGTeUrHHrQWUWt2iJxmcV1s719SCBBQVvxCcFpwx4n8hDiDuavMzLe/r+F37oofraV+N5JYWMzmLQBwRpfCioNxxog8GYIMPlvy3BODcYegfEpeoQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399136; c=relaxed/simple;
	bh=hS9q/vvxKhbfDyH23VL0mZ2urZFYa3ZD/pd84T65R6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPMbV7+MLCIGhChJwyFZHh0rXLAoOpUwNgRw+R1LKlKkeS+b2AUUYDzfyFa1c2bgUlspY7Snsr1v+mqmCNALWdLpc8Gl664q1XFx7EE3mDGBhz9dMCzVCAPaxI6i8wKW5TF3sOImzjSeI9qp2b89xOdzsb5puMcF9hEkm/OStgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=factv7t8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC3EC4CEEB;
	Tue,  1 Jul 2025 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751399136;
	bh=hS9q/vvxKhbfDyH23VL0mZ2urZFYa3ZD/pd84T65R6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=factv7t8ri+w+XVvUMpsVszs+crSDos/CJtMRdQ/rh45/ajvuayFBFk18PB/qdgCN
	 CLpuDzPSfLcE6sS0bI+0id5cjglJjLxO/8NUnGZyOWsG6YVItRqKN62DALt/W4HAsy
	 62I2dVjbWv5h1z6l1T+K/IPBYwIZ4i/OB52zKRPz1somXdXQxYVO+rLv4vLRAbEY//
	 eO7JMM//cLG+qzZd7XGemmAtzScGIUqZDlN0R2g2r4yXWAGybt6ugT9ipPHjPuvxWw
	 bkX+B5vPXkNjOFJGHJYTCnujNrhTjuvDczW6VL3lgmRLCfuMW6kORTpJiCX5y/YPhV
	 J1OM4DDfq4dzw==
Date: Tue, 1 Jul 2025 12:45:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH 0/5] ext4 docs toctree reorganization
Message-ID: <20250701194535.GI9987@frogsfrogsfrogs>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
 <87y0t7rajm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0t7rajm.fsf@trenco.lwn.net>

On Tue, Jul 01, 2025 at 01:11:25PM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > Hi Jon, hi Ted,
> >
> > While discussing on my previous ext4 docs reorganization attempt
> > by merging contents [1], Jon suggested that considering current docs
> > file structure, a proper toctree would be ideal [2]. So, here's
> > the patchset that does exactly that.
> >
> > Actual conversion to toctree structure is in [1/5], while the rest
> > is cleanups to make the resulting toctree nicer.
> >
> > This patchset is based on docs-next tree.
> 
> So to me this seems like an improvement.  I'm happy to take it, though
> would prefer an ack from ext4land if possible.

I did, yesterday:
https://lore.kernel.org/linux-ext4/87y0t7rajm.fsf@trenco.lwn.net/T/#mc3ea7f04fc1b0e4294bce6bd60f5f605017f6f7c

Though I'm also happy not to be thought of as part of 'ext4land' ;)

--D

> Thanks,
> 
> jon
> 

