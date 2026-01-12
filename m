Return-Path: <linux-ext4+bounces-12740-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF1CD157DB
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jan 2026 22:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE517300A524
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jan 2026 21:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147A93446AD;
	Mon, 12 Jan 2026 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZaj3bw2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9w/IMki"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545F83446A4
	for <linux-ext4@vger.kernel.org>; Mon, 12 Jan 2026 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254690; cv=none; b=AH59fnh2X1oZSkvCIhC5Z5pd3juGqqf9qUxoWApRTIxp4skGayTYQ6KJ/XS9uNWc7tlwQxn3xk2VlcifsERhaOJnPUU1WCXANGdXbGSx2z2uA2FxqUh2yfot2RvkIr2oGGQp5rAs3pSE6q9D1YohW2lXBe0X/5Ztyey7uLtQQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254690; c=relaxed/simple;
	bh=TXs7PPk1XpD3PbNMDGbvon5nP0IW/mjZS0LoOHcZP8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgnBjLjErfEPbl6gt146D1bsb/y+WKC+E8/YkxzCPNOxMoUlMOKQqekG+yx1ZrklnsTmz3VP1Ens6amTanqHy+lINSerOacY/2ZTxYhE2i/qQp5M9SC6sIr4BD4FS9kgughn+Fomphd1YFrhR6t6/3/+Awr0zRt8+hIrKgF5M5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZaj3bw2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z9w/IMki; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768254688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lG/xt+Zo6w++4JbumRD15X/stpwb03QCR9/DiPk31F0=;
	b=eZaj3bw24G7DvHQNXsm7JszImfrwQtUFcyxzzvz6kWhoeos5jKhpDhpJEQlUSwuEI4lU8X
	am/c2/O/+ZybafqUDdireL52krMZ9GHPho7zsab+M5TJLY+lnEmrASNXGInKE0yqd//Mw8
	RtssjvCr7Yw3Fb/q9PS3mv0G2odQV/o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-brWzDQDMP729gZ-EVN8rbw-1; Mon, 12 Jan 2026 16:51:27 -0500
X-MC-Unique: brWzDQDMP729gZ-EVN8rbw-1
X-Mimecast-MFC-AGG-ID: brWzDQDMP729gZ-EVN8rbw_1768254686
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2dbd36752so1774530285a.0
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jan 2026 13:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768254686; x=1768859486; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lG/xt+Zo6w++4JbumRD15X/stpwb03QCR9/DiPk31F0=;
        b=Z9w/IMki4n0AAkkjKcJxoanCsImqMeAEZFQEAsP7uvYzPJpS2pzMOBqWfzWydFKAR7
         V0PBjwMtXSliAyL7KmXzZelgE3hsJFmXtOqDcT2/I/I9D57+32kbLB++js5BLhdxT9fm
         MQcjG0o60VzQ+8CSX1p6K5y7BNOMZ7Tgay/sR5m2l6OQ18pMUU+UIgY62sOJT1b+yKtG
         Igfl7GxQNodkF8NNrcYFnBxxr7duElUnMjPMCSOI9F3mIPaBf0EfB8EEUs/aNt/uMrVZ
         5iBby+Oz8aXqybDXn5jdFGJbelYGTTmLu7sXx9DHcCLDd5oam9VgRJAYUy5DEtb1Tpxr
         Lbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768254686; x=1768859486;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG/xt+Zo6w++4JbumRD15X/stpwb03QCR9/DiPk31F0=;
        b=lKEat6frx/kjLJm7Z7JK+fWD+uaoEO9fpKm/0ITSHAMQw3sW9AxCq1jpgrle3/8K/j
         +DI9kyiNUhElCteoyWwQO2QroIUYmduDMStbQ9yMoyDv95HRRyH7ZP4e/f8URhdw/ghn
         AAGjqmaHBdZSkwLe8P03te/1VfTc10X58bg03YQ1H0Yr9eOMkJSQsyeejzpNmQ4/rFGN
         YM2ofHJJPQhTox3URc+tapc1YWGzSWvgKoEito5q3i1OPfUNIPd0W6SWWj+BQWGDKJLJ
         5plFqiyrZb4atHJP8UQ+Lez3YnVF6myLWoYbcdIAQosa9ANpxicCIkGZoRNezULUU5dE
         22EA==
X-Forwarded-Encrypted: i=1; AJvYcCXNoIFEslfbxf94dBx+r7JeZqykqcFyv/sQrQnJyYHJtrbPCPaWR1ucaLzhWFX57PbigGIQs9cWWet9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywym96VRuuFI1Y/S73y3tcAiIq9JAwkdaAQaDnuV3PxIY3S5mxt
	DXSnCg+Aj4L2//oxUOYPav76pcbkq2amqWga8Bl4P+JZaYdS9MIBbP6yUNGUobeH6XZbBwa7fGt
	owkOrBjtJo7WM7jN8hCl4RJRFrykbmTwGuYBu3IoeRHT9cVutD0CdEJ5EsjmB3mrh47aSL70=
X-Gm-Gg: AY/fxX7g18OzA2XdLs55ANwH0dYFuiTPOn+53E/ZkuspN6kCwUZwBkqWlMmLuz+Xi+6
	O8QMy6dTgxhdqCcMTsh55INl9nA3wYrxSoq097EG/QLnfQH5du9imsBb8ouFSUohwpFckG2r7Z+
	3HB73i/Jy/l9eIabXSaaKmda1XHDR3jrpO3QsmNN83on2BaN+REfGlLq5IV+JOUwdMreL92zyJZ
	mpS9qh0JuDwY/8h1gCax7SbNp2eYH3nXLz5JBrAOe0nGVQvdbOj48qA3FnVwsZfw/knF8G5CfMS
	0Sjb2ja5wLIosvAh702se6dEzk2fHXPkHKtHcThuaQ5zPKW+NwlPByJBmukfqGxdG4nzxoqiqE4
	ZqaNt52On
X-Received: by 2002:a05:620a:7101:b0:8b2:eb66:c64 with SMTP id af79cd13be357-8c38938daaemr2617949985a.29.1768254686484;
        Mon, 12 Jan 2026 13:51:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCkpe49S++VqEffSBOBVXTkUb2yNggyXQirptPBh8ES7ItwAnLFAB24ZEcsyfb77ysP4HDOw==
X-Received: by 2002:a05:620a:7101:b0:8b2:eb66:c64 with SMTP id af79cd13be357-8c38938daaemr2617947385a.29.1768254686087;
        Mon, 12 Jan 2026 13:51:26 -0800 (PST)
Received: from redhat.com ([2600:382:771e:5aa5:103f:e4ff:d734:7cd4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51ceb5sm1676840685a.35.2026.01.12.13.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:51:25 -0800 (PST)
Date: Mon, 12 Jan 2026 16:51:22 -0500
From: Brian Masney <bmasney@redhat.com>
To: david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 30/44] fs: use min() or umin() instead of min_t()
Message-ID: <aWVs2gVB418WiMVa@redhat.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-31-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119224140.8616-31-david.laight.linux@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi David,

On Wed, Nov 19, 2025 at 10:41:26PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> and so cannot discard significant bits.
> 
> A couple of places need umin() because of loops like:
> 	nfolios = DIV_ROUND_UP(ret + start, PAGE_SIZE);
> 
> 	for (i = 0; i < nfolios; i++) {
> 		struct folio *folio = page_folio(pages[i]);
> 		...
> 		unsigned int len = umin(ret, PAGE_SIZE - start);
> 		...
> 		ret -= len;
> 		...
> 	}
> where the compiler doesn't track things well enough to know that
> 'ret' is never negative.
> 
> The alternate loop:
>         for (i = 0; ret > 0; i++) {
>                 struct folio *folio = page_folio(pages[i]);
>                 ...
>                 unsigned int len = min(ret, PAGE_SIZE - start);
>                 ...
>                 ret -= len;
>                 ...
>         }
> would be equivalent and doesn't need 'nfolios'.
> 
> Most of the 'unsigned long' actually come from PAGE_SIZE.
> 
> Detected by an extra check added to min_t().
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

When doing a mips cross compile from an arm64 host
(via ARCH=mips CROSS_COMPILE=mips64-linux-gnu- make), the following
build error occurs in linux-next and goes away when I revert this
commit.

In file included from <command-line>:                                                                                               
In function ‘fuse_wr_pages’,                                                                                                        
    inlined from ‘fuse_perform_write’ at fs/fuse/file.c:1347:27:                                                                    
././include/linux/compiler_types.h:667:45: error: call to ‘__compiletime_assert_405’ declared with attribute error: min(((pos + len 
- 1) >> 12) - (pos >> 12) + 1, max_pages) signedness error                                                                          
  667 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)                                             
      |                                             ^                                                                               
././include/linux/compiler_types.h:648:25: note: in definition of macro ‘__compiletime_assert’                                      
  648 |                         prefix ## suffix();                             \                                                   
      |                         ^~~~~~                                                                                              
././include/linux/compiler_types.h:667:9: note: in expansion of macro ‘_compiletime_assert’                                         
  667 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)                                             
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:93:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
      |         ^~~~~~~~~~~~~~~~
./include/linux/minmax.h:98:9: note: in expansion of macro ‘__careful_cmp_once’
   98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:105:25: note: in expansion of macro ‘__careful_cmp’
  105 | #define min(x, y)       __careful_cmp(min, x, y)
      |                         ^~~~~~~~~~~~~
fs/fuse/file.c:1326:16: note: in expansion of macro ‘min’
 1326 |         return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) + 1,
      |                ^~~

This is on a cento-stream-10 host running
gcc version 14.3.1 20250617 (Red Hat 14.3.1-2) (GCC). I didn't look into
this in detail, and I'm not entirely sure what the correct fix here
should be.

Brian


