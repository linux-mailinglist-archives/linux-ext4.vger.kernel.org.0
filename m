Return-Path: <linux-ext4+bounces-3170-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326F92CACE
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 08:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48821C22D81
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3605E093;
	Wed, 10 Jul 2024 06:16:09 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E180C15;
	Wed, 10 Jul 2024 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592169; cv=none; b=Ypg3Hhaa8bmp/sgjdj6jvk8J3wZivZpbGSpLJOD2pok12rMm8U+0GO30NbOspi6hkA4/UIxS02XcWGIyNwaO9LXuQU5lT9DC9BwkDSU6Vjgxy/YEa7noigcK2qhvWqCdH92IVyBz/rxsGTsBiTdsV5MTRTdr17yjKs7rnmyfXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592169; c=relaxed/simple;
	bh=kg5qljx+3ceZY/uPmHLdMGUstOz8bhHVy///TRR/hJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIt7jAWEvZk2KlPVpSpiNGTamc+q1YQhWajQtpNvtk2cAOypOhz45ITxYwD9oFToCETCs/o6ftmE9SFjuR5igEiPE3u1tlp0sPdFT4pud+C8ABxLq7aqwI3MjvZIKmRGbr2V/y8iaH2/J5dpBWM15TqRKL2vCjQxxgRNqA3xEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 98794227A87; Wed, 10 Jul 2024 08:16:04 +0200 (CEST)
Date: Wed, 10 Jul 2024 08:16:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: Re: mostly remove _supported_fs
Message-ID: <20240710061603.GA25790@lst.de>
References: <20240623121103.974270-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623121103.974270-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Zorro,

is there anything that blocks this series?

