Return-Path: <linux-ext4+bounces-2313-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664AD8BCDF0
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 14:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F5D1C237A4
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1868143C47;
	Mon,  6 May 2024 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fisica.ufpr.br header.i=@fisica.ufpr.br header.b="lQ3yjiw1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from hoggar.fisica.ufpr.br (hoggar.fisica.ufpr.br [200.238.171.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2B1442FB;
	Mon,  6 May 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=200.238.171.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998553; cv=none; b=Kj11E9SY0ltliG3Wr/z4EPhBOODJY7l6r6MFeKEf6DRxWR1Gi38cfrcupHn3KZs9a1qwzT0SpFqiOgYJ21mkf6mE2Gmq+0h1CF/a/4YUbhjSkHZqBMD2VwctXTQ/6HSJfKqgPly/7ZyI2F0Ez9XA47XG/js9fJqegJAWTe6Xej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998553; c=relaxed/simple;
	bh=lxbVZdxtj+/9shnlD7a65467vu1QFnwevDKUl02DnTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2j5njziBQIsLhkx450Xv5zvo5g9yYxzr3dyjC6GxBbDiqDW63HfNzJZEcc7vMjFD8V4mKEe33OGaCUrfr9KJzGsE4XT0WXSP3P5zGKZIXBOKdWaZB5CrKdEZH6uzggm/mhuZnc2DjghktJ4/bvnLPZyTmr6vTaFr8JcHPwt/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fisica.ufpr.br; spf=pass smtp.mailfrom=fisica.ufpr.br; dkim=pass (2048-bit key) header.d=fisica.ufpr.br header.i=@fisica.ufpr.br header.b=lQ3yjiw1; arc=none smtp.client-ip=200.238.171.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fisica.ufpr.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fisica.ufpr.br
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
	s=201705; t=1714998212;
	bh=lxbVZdxtj+/9shnlD7a65467vu1QFnwevDKUl02DnTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQ3yjiw1N6NXGVvGLMQDSpwvUqT7Q1Djh42Aw7odiDO24VpZffDsm9wIfx/5t7lfE
	 XivB6rHohD2OjEhbYf8sqhzHKXa/vjVL9p5B6gvrcB3Nj5z8fnQWZaswCYgY22iTRC
	 f0khnUswb8zyQvspKW1Zssv9rb1rioijgyGusOOWL2pL48N3+6jYC4vK7gaN8rxtXX
	 DFqXwIlYexzSJVbVcyeY17EY3Ftli9DE9vuHFkN+dXlrcx4eMD/EePwVf9HRt9GAkU
	 oztNt47A+yxVEYKmHD3efeRs5yiUHj5AkgaONCX9pOptHkem7UIbbn4sn6KFBIdGIs
	 EH5NHYnkE6Nqg==
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
	id 85DA411A7C5A; Mon, 06 May 2024 09:23:32 -0300 (-03)
Date: Mon, 6 May 2024 09:23:32 -0300
From: Carlos Carvalho <carlos@fisica.ufpr.br>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-raid <linux-raid@vger.kernel.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Massive slowdown in kernels as of 6.x
Message-ID: <ZjjLxLk1E4dGLpLi@fisica.ufpr.br>
References: <1ebabc15-51a8-59f3-c813-4e65e897a373@diagnostix.dwd.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ebabc15-51a8-59f3-c813-4e65e897a373@diagnostix.dwd.de>

Using top do you see something consuming lots of cpu?

