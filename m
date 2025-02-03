Return-Path: <linux-ext4+bounces-6295-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D699BA25296
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Feb 2025 07:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF003A3857
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Feb 2025 06:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3358078F5D;
	Mon,  3 Feb 2025 06:48:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A021A31;
	Mon,  3 Feb 2025 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738565303; cv=none; b=NqU0BnLf4pkY7vL3BH1wx7wJt9a2gnOx44+rCrnYXf3sBTLFFWpRr3bfomUtVQUBip4bFb3gNVYRIW3ivgMYzrrLcBOMdv/HTP7DHs0t+2yQTrnIs2eecmWxa5FQYemozOMP+04uAraQ1bHBy7AsvpUK+ENJsZOH762+6bqlgWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738565303; c=relaxed/simple;
	bh=U9PIZyhcRSkv6gA7iBY9dX8xB49xi1s77L3qQi3hulI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiHc1JxOLgp0Gd8qNdqUIJKokzV/GRzHA13Uv0u5xHWyyMhXDv8RCOBHYJDItTbXnM4uyRy4uV9/nJQQ6I6xlH/OiqCizzjpJNPxL+JP55IoYVxqC2fhmsxsttGXEvqEkmQjpD0qsY9G4xSuqoxbs/u7aUuECXWUaiCDCaBXGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DAED68D05; Mon,  3 Feb 2025 07:40:29 +0100 (CET)
Date: Mon, 3 Feb 2025 07:40:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] replace _supported_fs with _exclude_fs
Message-ID: <20250203064029.GA16864@lst.de>
References: <20250128071315.676272-1-hch@lst.de> <20250128071315.676272-4-hch@lst.de> <20250202133101.bpst6rzhjn7g4zvw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202133101.bpst6rzhjn7g4zvw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Feb 02, 2025 at 09:31:01PM +0800, Zorro Lang wrote:
> generic/730 is missed:
> 
>   /var/lib/xfstests/tests/generic/370: line 31: _supported_fs: command not found
> 
> Anyway, I'll help to change g/370 when I merge this patch.

generic/730 didn't exist when I submitted this series, you applied
it in the same batch of patches.

But it really should not skip xfs to start with.  Either the test
is correct and XFS should fail it (and get fixed) or the test is
incorrect and it should not be added.  I suspect it is the former
and I'll look into fixing it.

As added in the comments in this series we should never add a
_exclude_fs without a very good reason and comment explaining it.

