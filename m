Return-Path: <linux-ext4+bounces-8714-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0BCAEE243
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841D27A6EE2
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BF228DB67;
	Mon, 30 Jun 2025 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CijP8g/Z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466C17A30B;
	Mon, 30 Jun 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296979; cv=none; b=oTJr0qKhDb5//uG9wQaLtBUmHZXSO3AbFSXG+NCDx0RRpTqIjJudhmWDly+46h59lBAYzcUhims9UV+i1OR2TOPj9bjMMbh/URVGtgeiWOq9Hk+Wbzkb76Ns+GUoAkZTGtLUe75E4aEZHETx2WcMpKJW0ogov3q/IwlHppYv/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296979; c=relaxed/simple;
	bh=hQ3Hy3MdVNdKkbdCtx32GYhhwvEtrA6ITeCeS4b35EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/MCyca0/qB4UEesTx0vXtvAwpbNxcThTK2CR6bvdtCok5cG7V7o9X5n9NkXIS22Y4aBasiTfQjr+tr8i3XgxZnkXaUFnTQq9a7rCwx3BC01v7vZXfszyU7Skh2bTqCzB9YEyAk13ghsi3NgstfAP1VxtoNjwjfTmyCElt9OcIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CijP8g/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3257FC4CEE3;
	Mon, 30 Jun 2025 15:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751296979;
	bh=hQ3Hy3MdVNdKkbdCtx32GYhhwvEtrA6ITeCeS4b35EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CijP8g/Ze30EpbF018f2U0mg2gE0bbijZqoi/Lgz43dzxdmVA5N4lpcq69y4dULTB
	 MpXwXw/oIIfTErPbPNyRy4XjLx0IVVaB3SczIIqfvQNLi0vwL26fQMi93ek333XluG
	 xzc9lHSc29eRK/XW5ukGJSKQ903b8MxZKh3po5slUgjfcsyJ2KQkJbpHQdF5MP7/5o
	 aYnZymKdwjCs1A5rE4ZDG1w9jJKmVi44IQtEdhOHz+IwWEaxzpItRtFiLQhfz2X0LA
	 N5s5A2+reyhrrLbyC7dhoDlHXVYqlyDunUVvVoMJgkCF3q+TRJLuvKnayu3/bjBwa9
	 CCFxwYI3OBFOA==
Date: Mon, 30 Jun 2025 08:22:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH 0/5] ext4 docs toctree reorganization
Message-ID: <20250630152258.GD9987@frogsfrogsfrogs>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
 <aGHgF0Aa8NlTw6Eh@archie.me>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGHgF0Aa8NlTw6Eh@archie.me>

On Mon, Jun 30, 2025 at 07:53:43AM +0700, Bagas Sanjaya wrote:
> On Fri, Jun 20, 2025 at 05:56:39PM +0700, Bagas Sanjaya wrote:
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
> 
> review ping

This sounds a lot better than dumping everything into a single huge rst
file. :)

The structural changes to the documents look ok to me, though I'm no rst
expert so I trust you built the documentation and it didn't spawn DOOM
II or anything... ;)

Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> -- 
> An old man doll... just what I always wanted! - Clara



