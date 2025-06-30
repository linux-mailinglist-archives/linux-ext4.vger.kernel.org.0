Return-Path: <linux-ext4+bounces-8713-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0047BAEE237
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 17:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D6316B1BA
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198A028C2A8;
	Mon, 30 Jun 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScWFLjaz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11E743AA1
	for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296785; cv=none; b=QqPlhEDXK3ydEQmuOVO7zZ7d+3QgKWwO7H05nq0amINZrJDAHSHylqMQ7qXqjYS9Lz4q8+JVZuGgL+c7VmUdGlA6PrDdDraA8xDHL2yjAhLiimMM4v5rpRIg6zlYcdwYcvS7sENkMt2bqd9Gdew3vDTVdUlEQTkqDufobv+T0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296785; c=relaxed/simple;
	bh=lQPMtynk6201CXIB2JN9QLMs3oz1vN4zj7SAuTBGsIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvxkaRhMr0Khi9Kv6bXiXseKEmSbz8JPxtK4DHhrKSYaesh7aH05fA7/dnjLnaVwBBD5vNEx3iZkC2MiLABiyFwQzuGjs1AHUcx6Xw3IbtOSyCN8b8mKimARY09y8Ycp2PFxIZI2tBH5M4gQ1tbt8YnXCR5aUJL5shdMZHiA9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScWFLjaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858A1C4CEE3;
	Mon, 30 Jun 2025 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751296785;
	bh=lQPMtynk6201CXIB2JN9QLMs3oz1vN4zj7SAuTBGsIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScWFLjazpcZ+gTgmHmEYSqshgQ9hLzdB6VSlKjkaSPgjBxIi4yNifxTdmoZTp10ON
	 Ci+VEKOhdUQqH4IHPxMkw8Hf9dyJjLMQ/6nH1xClh/kOEDZxscDx5bgIBptrPPE0eK
	 Aca0A0dN84XLFIpBKe2BeYSoTy0r4rlKliW+XPzzLXyvdzyr3OPErhPXujbysG68oN
	 Y5+9j53ED2dif9vbSw/ojh7LDWRpeinLaEkTARJZcocWZfUy55kQ8e3KpiEMNXCRM+
	 zXtnDvJjmEAqJED81ae3v4AODdGNv2EPMh80jJF3XJLm2qOxnKSFtGpgZs7KyNdAmF
	 7UN2GdIyCXboQ==
Date: Mon, 30 Jun 2025 08:19:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Samuel Smith <satlug@net153.net>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2scrub: honor fstrim setting in e2scrub.conf
Message-ID: <20250630151945.GC9987@frogsfrogsfrogs>
References: <20250628051415.3015410-1-satlug@net153.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628051415.3015410-1-satlug@net153.net>

On Sat, Jun 28, 2025 at 12:14:15AM -0500, Samuel Smith wrote:
> The systemd service unconditionally passes -t to e2scrub, forcing
> fstrim to run after every scrub regardless of the fstrim setting
> in /etc/e2scrub.conf. Removing the hardcoded flag will allow users to
> control the behavior via the configuration file.
> 
> Signed-off-by: Samuel Smith <satlug@net153.net>

Now that there's a config file, we can indeed drop the explicit -t.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  scrub/e2scrub@.service.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scrub/e2scrub@.service.in b/scrub/e2scrub@.service.in
> index 6425263c..3c9893c5 100644
> --- a/scrub/e2scrub@.service.in
> +++ b/scrub/e2scrub@.service.in
> @@ -16,5 +16,5 @@ User=root
>  IOSchedulingClass=idle
>  CPUSchedulingPolicy=idle
>  Environment=SERVICE_MODE=1
> -ExecStart=@root_sbindir@/e2scrub -t %f
> +ExecStart=@root_sbindir@/e2scrub %f
>  SyslogIdentifier=%N
> -- 
> 2.39.5
> 
> 

