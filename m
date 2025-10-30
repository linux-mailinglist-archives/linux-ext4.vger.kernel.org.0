Return-Path: <linux-ext4+bounces-11368-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F558C20D4A
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 16:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE54F4EE9AE
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0984D2874FF;
	Thu, 30 Oct 2025 15:03:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14392E6CA4;
	Thu, 30 Oct 2025 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836612; cv=none; b=m3TdfRGOOucSipDqo06RZun/RU4LsGrj19tvjfC7qel6rVp3uUL+oFzgf7OJaSnQXLvkhPsaKhm79raRZBkslGy+S1DskW2zCloTRqdoVko/ZF8TIWaTO4TNzZweGMaKXRYtToFup2sBZlEFEd9XdlnBQRrNMDyRz/S2h9nAwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836612; c=relaxed/simple;
	bh=WG2goS3lJm3DG5KmeIcAcGkXQ6d1fhJvDfm40F9PqPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B85ecXlTZFcXuKD3GiBp3unEdRvuRFZGQrKuye8/10Rm1u+TKxytvN+Bl560OP4MzgjwwQ9Qp7ZIgCTbDL/q+JR6OuoRCe8t0mkIJ8odXm6ONTJtGWkReG27Fax8KDsE0SZ86CsJQmqI3FQNipB1i95eAX3Hct3yqDzYJJS8/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 78793227A88; Thu, 30 Oct 2025 16:03:26 +0100 (CET)
Date: Thu, 30 Oct 2025 16:03:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, miklos@szeredi.hu, brauner@kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20251030150326.GA32729@lst.de>
References: <176169809564.1424591.2699278742364464313.stgit@frogsfrogsfrogs> <176169809588.1424591.6275994842604794287.stgit@frogsfrogsfrogs> <20251029084048.GA32095@lst.de> <20251029143823.GL6174@frogsfrogsfrogs> <20251030060008.GB12727@lst.de> <20251030145402.GV4015566@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030145402.GV4015566@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 07:54:02AM -0700, Darrick J. Wong wrote:
> Swapfiles in general (including doing it via iomap)?  Or just the magic
> hooboo of "turn on this fugly bmapping call and bammo the kernel can
> take over your file at any time!!" ?

The latter and even more so when the mapping is farmed out to userspace.


