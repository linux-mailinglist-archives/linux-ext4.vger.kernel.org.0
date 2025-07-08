Return-Path: <linux-ext4+bounces-8877-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A25AFC0D4
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 04:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4941AA44FD
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 02:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB71F0E58;
	Tue,  8 Jul 2025 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="NFM3FZkZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2121FF5F
	for <linux-ext4@vger.kernel.org>; Tue,  8 Jul 2025 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941721; cv=none; b=YnJtl4mRsWWBApGcPIAIKZqD1zzkcbpYZ/BjGXVWi/SWsQWj7e7tV6+aL3yHbx0pNkiVeEyuTM5RKIfJjsga0StvYS47MkCoKd/yOqxIYzZvUX07Zz/8kAwtWoZ/3RT07Apd1sntz/CPwTDdCJZ7/FBOSAHfz9CrJO/aqZrPudo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941721; c=relaxed/simple;
	bh=3GyprSow3qAcCb8N0tiXSPXrfzwpKm5e/wQnFqQvVlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUOitxn51ok5FCLtritNwfJF+a+zPE7Hj7lfYt1KiWQHEBzRMWR4PHvB4FxnE92Mr55DCrSRRoNRrmIWr00g4t0+6QsR7Wnr/c2mrecQBfjePkDI++TyHf6838IWif4CeWJ9/IngRVt/EUSy7dBgif772l+FzgXpNweckWwRD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=NFM3FZkZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (99-196-129-211.cust.exede.net [99.196.129.211] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5682OxxB003551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Jul 2025 22:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1751941514; bh=3uCx93Iv+v3s8K0GDB0GAMbR0St+3evdPm0IH3wN5V0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=NFM3FZkZQz6ukcpE/p21w8mCplytjOD3wh88kAH8JWpUCBfLKOKuaecswB2Adtmzn
	 txbtWtYL5DfIbcL4zYYiFVtP25Zgh2wXFNZ6toEVMazhkEARFbHXjFlmZ4A7whLtyY
	 Iy70zo3KZRS4vtIJ37DsZ7n/VnZ9CslHiwYzI7MLRqysDSh989RyF56WIMRlGTE3E2
	 4opT4jwI77hjL80lKlz6HtQHa7BoMQ6mf6AM4oTrkmESYKKTG86c4q0HdMM9FbTf5n
	 /TmWG9ghHbigLYvwJIfC9kxZ/zUcTVKc+xqcHp1jc6E6xvLep3+9P7XpV0ZXJEBOdL
	 RmVlKmf/5/C1g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7701B3405F0; Mon, 07 Jul 2025 22:24:53 -0400 (EDT)
Date: Mon, 7 Jul 2025 22:24:53 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] ext4: Refactor breaking condition for xattr_find_entry()
Message-ID: <20250708022453.GB1845251@mit.edu>
References: <20250708020013.175728-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708020013.175728-1-richard120310@gmail.com>

On Tue, Jul 08, 2025 at 10:00:13AM +0800, I Hsin Cheng wrote:
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 8d15acbacc20..1993622e3c74 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -338,7 +338,7 @@ xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
>  			cmp = name_len - entry->e_name_len;
>  		if (!cmp)
>  			cmp = memcmp(name, entry->e_name, name_len);
> -		if (cmp <= 0 && (sorted || cmp == 0))
> +		if (!cmp || (cmp < 0 && sorted))

This is *not* identical.  Suppose memcmp returns a positive value
(say, 1).  Previously, the conditional would be false.  With your
change, !cmp would be true, so the overall conditional would be true.

So this does not appear to be a valid transformation.

(Note that valid transformations will be done by the compiler
automatically, without needing to make code changes.)

   	     	 	      - Ted

