Return-Path: <linux-ext4+bounces-11943-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A23C753C3
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 17:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC814344461
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07EF35F8B5;
	Thu, 20 Nov 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Xlan4Dlh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE93590AF
	for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654307; cv=none; b=nUDYo85DjOnw0bDXM+lYdduo9RWze2K2iWCGnQGEwxelsGNwt2nGQFSytnasNcXg+g1IYiMdD8mgbJhICUuo8H4kAqEtDwJ0DByKdiuvuWo6aScY7ozVCPYIb57KSoqjeL5rgjFpuk0CnO8Rm93sEVIL7ioBTuYKjOj73DFLFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654307; c=relaxed/simple;
	bh=DL1ZApjtnhpVIg+CSxnfnNVn0CMcpHP++G+hxwQecD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYboetn4SNGsLJBQNke+sx4GX9tZsCrtUZys4pudZ4abIDs5QZGh/vborkDApDpGczeszhnZHlRtWNnhjfxYi6Exeoy/lTvdfcOQ5VF+1/3js7BqdlGMFGeqJynEDeDEbir8MqWcdoqIe5FgZ93Ru6z+aLE23op08+3G1qr0BKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Xlan4Dlh; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([104.135.218.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AKFwGIm029651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 10:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763654299; bh=oIU66B9iMRkWNMUF+f2mehc6v8DzCqpOLXxk1DkUQRM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Xlan4DlhMHyXfDJvRrBMoswEQBJCNpo2qwPCd9fUUBLoqk9nVu+wB6211yXVVNrMB
	 buqBydk71LF4axApa4FfUemJSxIuq34+C9FxU1naD9yc/Sk7owABVHz5RbYQTXnXrh
	 u9nXwZXQm8meqZiH1vedHE03RU1ccwX8xVeQnlQJME0Zk11Kug6XYAyMLZz/rXgZWL
	 DI8AW9asoXnuTYY4sE6cXtr4mAh4/4M+cYKZ5Y3nGJekly3Ql7mKx/XsHL88pv4hbA
	 SZ15vDw+MCK6TdkWgwKDYEEgR/Ao9YafUJ524i6HW3hULSu2FXzpR9hKMPPYgH6FXo
	 JKjtkn3vw2llg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0FBAF4C0B544; Thu, 20 Nov 2025 10:58:16 -0500 (EST)
Date: Thu, 20 Nov 2025 10:58:16 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: David Laight <david.laight.linux@gmail.com>
Cc: Guan-Chun Wu <409411716@gms.tku.edu.tw>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, visitorckw@gmail.com
Subject: Re: [PATCH] ext4: improve str2hashbuf by processing 4-byte chunks
Message-ID: <20251120155816.GB13687@macsyma-3.local>
References: <20251116130105.1988020-1-409411716@gms.tku.edu.tw>
 <20251116193513.0f90712a@pumpkin>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116193513.0f90712a@pumpkin>

On Sun, Nov 16, 2025 at 07:35:13PM +0000, David Laight wrote:
> 
> The (int) casts are unnecessary (throughout), 'char' is always promoted to
> 'signed int' before any arithmetic.

nit: in this case the casts aren't necessary, but your comment is not
correct in general, so I just wanted to make sure it's corrected in
case someone later looks at the mail archive.

"char" is not always signed.  It can be signed or unsigned; the C
specification allows either.  In this particular case, scp is a
"signed char", not "char".

Secondly, it's not that a promotion happens before "any" arithmetic.
If we add two 8-bit values together, promotion doesn't happen.  In
this case, we are adding a signed char to an int, so the promotion
will happen.

Cheers,

							- Ted

