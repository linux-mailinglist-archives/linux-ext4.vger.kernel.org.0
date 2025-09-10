Return-Path: <linux-ext4+bounces-9905-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86648B522EF
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 22:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F487583EE3
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DCF30149D;
	Wed, 10 Sep 2025 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Cfy8L6jZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A913301475
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537150; cv=none; b=EnlxL5RJxu5fNvmhG2w4OQ9MuiNrcMaW/DUsjwhLbxM3FqsFhzvES57iaJf3TJ2ZKotoDCH/sFhfBBlE+vDWdfDGaNHuA8+LjrI1oLIxTW4mdEX6tahJuaxMUjMYVo8CrNO6niaOh/oLyWe7JTCaxVpjv+DjcJmdseKC/9GeJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537150; c=relaxed/simple;
	bh=GlujbSpqz67S7goDIZiAvh3kCQN8c9J3fk+Viiv8Ub8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko0j2TxlEP1Ox5GT4IOCe/HYjg/8a3uGxsP0xTRQZShBQHUT1FSWymqjK+NB3vmAdAEBq90TXUqateJcOhChD+PSU1PYjv2jXxwZUdZetvs33+FW2zn/W6b2Tf9sdn9f9K+Qx04+WPbw3mDiuGtWclp3U6I3yNLcecrEcXavP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Cfy8L6jZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-2.bstnma.fios.verizon.net [173.48.111.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58AKjhqJ017818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 16:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1757537145; bh=JpOy2tIrua9p1Q5umq1tMDJ0HdX+EVOVXUorvMs6fp8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Cfy8L6jZjX0W5Va1tc2kDFRc6Exqw30r5k7Sf9/DuXoMfckx3Rnd4cXYuLC7SWGdq
	 JTm3IIyMVD0izn70QaXOO7XT7DfItHecPU5Mbo/3MP4F+evB6jJmXtCRtqvczrFqYZ
	 dP+HMi2i0tTNya9xFyznNptoSR1u3yM0vx3qofkd/hDeFOivjlm2ztOyMQoSlU8p2D
	 Khj00IainY9hcHGvdPuJqZ+6NmGA7/aNeysMQPrXrybD7BqInnPAdqP5LimP1NytnS
	 sHwAhMnBNZfaPO+7Mt2BFGhjdDmM7qaubaM7pF+Qi5O3UEUMrWzlIJUKHOivdliTc1
	 u3FKTqtFM0GZA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 6A4842E00D9; Wed, 10 Sep 2025 16:45:43 -0400 (EDT)
Date: Wed, 10 Sep 2025 16:45:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] mke2fs.c: fail on multiple '-E' options
Message-ID: <20250910204543.GA3659556@mit.edu>
References: <20250909-mke2fs-small-fixes-v1-2-c6ba28528af2@linaro.org>
 <17EED9B4-41D4-4D1C-9838-1ECF5B39C00D@dilger.ca>
 <CANp-EDZF3sVLQWdL4+a1aQLa5uqt5R_trzOp3Hh+Kw21hRn0ZQ@mail.gmail.com>
 <20250910145241.GA3662537@mit.edu>
 <CANp-EDZ-5_UC+p77d+ZPMMtbH3eXAPvoL4tR_EL3dcpBk-wKeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp-EDZ-5_UC+p77d+ZPMMtbH3eXAPvoL4tR_EL3dcpBk-wKeQ@mail.gmail.com>

On Wed, Sep 10, 2025 at 12:29:21PM -0400, Ralph Siemsen wrote:
> > That way we can call parse_extended_opts() multiple times.
> 
> Note this is already occurs in mke2fs: one call to process options
> from profile/config file, and another call for command-line args.

Sorry, I've had tune2fs on the brain.  Mke2fs is different from
tune2fs because there's only one path for configuring the newly create
file system --- and we have to process the command-line extended
options *after* processing the profile/config file options.

So in PRS, we need to save each of the -E arguments --- or concatenate
them together into a single set of extended options, and keep the call
site for parse_extended_options() them where it currently is located

						- Ted
						

