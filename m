Return-Path: <linux-ext4+bounces-9902-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CB1B51AE2
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 17:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BF13A1B44
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED613329F27;
	Wed, 10 Sep 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HU+bqsED"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C8C329F20
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515976; cv=none; b=oUf2mrXSAftSyFb3DL8si8MhLEWAk2ijiMqs9fS8c40A59S72rHNObllTmakecZhh2uUBmmLp3nMTU9dJDDJCbTREjSmb3uums9t14nzNC8OIAipaQPdXFTyFY1ZILLZMuAsMmH9GnES0IRy/pPINOXsTfEgHgVXyrmH/9bfvuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515976; c=relaxed/simple;
	bh=laI1Alrh0i4ipNyxn05jMCA9Y0Hn4BmcEBRC5XqJIc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugUa1tPCbyI3lxlV75jrG+0mwGz98Q0yqtigPC1kEaLqy1NFjcHvI+uFdbbgG4eiLp0RF9RvEThOo3DYQ3yBZIHYnejNzw+PREyEP+mk1J17yMFqjGEP9Sl6eEuctqpNXN+4MdVzdpgMpfrExaT/JHC7hKtxlkqxAXUCOi2MKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HU+bqsED; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-2.bstnma.fios.verizon.net [173.48.111.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58AEqfLQ015499
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 10:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1757515963; bh=lSctto0XaUC/OYCNJ4CV0U/GaOHq64EELBdW/kOK1EM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=HU+bqsEDn8FKkHJkJJQt7QrfmkX7WAE9DHXU9R+XLkAFZYQAVQDmkJMSl19m83ebc
	 BIjo9rCezj5tH/xlsZWJGBgUvH+FFouv4+IGOI6E+S1xDHt26fzXqcDqrSuw7Zfr2F
	 aWALBEJenGjqqjB960vGETmldsgYEGAX2frUILMWVnvIS0kSYi0zPrpLNlxJio7H5w
	 UeHb7BZvgQQDJdl4Y4plYNMD9RP7OZuPAoZIEh2F5r9kSKjTBNdPWjrmGVAU1TLJwu
	 R1r8BetaBpkxJ3R+LKQixM79H6g8Il6JIGkFoJz7gkcePAIucfjkAUCNJBi4WstBwt
	 rI6mPo9tiDPMQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B876D2E00D9; Wed, 10 Sep 2025 10:52:41 -0400 (EDT)
Date: Wed, 10 Sep 2025 10:52:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] mke2fs.c: fail on multiple '-E' options
Message-ID: <20250910145241.GA3662537@mit.edu>
References: <20250909-mke2fs-small-fixes-v1-2-c6ba28528af2@linaro.org>
 <17EED9B4-41D4-4D1C-9838-1ECF5B39C00D@dilger.ca>
 <CANp-EDZF3sVLQWdL4+a1aQLa5uqt5R_trzOp3Hh+Kw21hRn0ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp-EDZF3sVLQWdL4+a1aQLa5uqt5R_trzOp3Hh+Kw21hRn0ZQ@mail.gmail.com>

On Tue, Sep 09, 2025 at 08:49:37PM -0400, Ralph Siemsen wrote:
> Hi Andreas,
> 
> On Tue, Sep 9, 2025 at 8:32 PM Andreas Dilger <adilger@dilger.ca> wrote:
> >
> > I think it would be much better to allow and merge multiple "-E" options.
> 
> Agreed. I'll work on it and post a v2 patch.

What I would suggest that you do is to move code which mutates the
file system from parse_extended_opts() so it is only interpreting the
options, and move that code to tuine2fs_main().

That way we can call parse_extended_opts() multiple times.  In fact,
that had been on my todo list, since I need to do this to support
changing the superblock using ioctl's while it is mounted, so we can
deny read/write access to the block device while the file system is
mounted.  See [1].

[1] https://lore.kernel.org/all/20250908-tune2fs-v1-0-e3a6929f3355@mit.edu/

Cheers,

						- Ted

