Return-Path: <linux-ext4+bounces-5569-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB579EDE0D
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 04:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CEB282C09
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 03:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131C2156653;
	Thu, 12 Dec 2024 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GIHOvg4U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6078214D719
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733975913; cv=none; b=F74JOZ9l5UdcZNOYirvNqF306E6C9FCUbwKVWsi3IvGz18YhGB/LTax0BRnpna4JHInhoTH9DT87F6V224TAVjbKszHkWFl3pIx+4B1vvBjiAjoeVWyfeIAC0UNVa9pTB9jZS0FdMXzNQ3wkFzmp9G9dKLR6uLTUHf19H1c3v/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733975913; c=relaxed/simple;
	bh=F36O0Dgg1mhlcRno/fBPjRyjEsASJc7EpOfe35xMwec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ygw+NXnx9nNvyl7IoJsexdM4aXEPE3Ws6sFMh2ki2MFywBlqmOqLv4HLQe15hx+e9AAW801quK2LZoaop/aOcNInO8RFhy1xawXWBeOsKuL0UlpEhgXcqVQzWkZIp1nDvmbS1TUHShgnMiYJp29KVRPIgwF3t5cb0d05k3JZ0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GIHOvg4U; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea9739647bso136148a12.0
        for <linux-ext4@vger.kernel.org>; Wed, 11 Dec 2024 19:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733975911; x=1734580711; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgpWYN8QlsUV56/RVatR17L4XIXA6XIYGaqKFNGgJR8=;
        b=GIHOvg4UbiVaM9uJK6lQZFuZiHZSvykDeyOlu3rgwhXtP6D+dr37wy+QXu/W5zv+vB
         o4+ODtk4V/0FJZFwHC2d9UtjHmDpDyoXn4mCwJkMYXw9dw0A4MDCzhFdnEtE7qhoeCcd
         FkrAjSio9mns5VLH1IHWv8giyxJN5OIfO3NXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733975911; x=1734580711;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgpWYN8QlsUV56/RVatR17L4XIXA6XIYGaqKFNGgJR8=;
        b=Evh0OocK8GneOLucz9Bt7cNFlg/mdOYh8oSk/+shIXJl1Q9C1PpC2IYmkb+CMfAimK
         QQsRh032vOLkuxZl4W82wVWVfUP1AmUJKIXygCYhX3MezUWhVrKCKKR80kFBfcbUHlZA
         AcOgHHlT++3SVwpMWsZEBpMey+i8ulDoSBpo5HQUs9JOtiTepUsbJXKWQDp7YD9mnutO
         MXuFeJDadzn4f9jK+4A+WHe36xAjQKPk+DPrYb8VAwvarBNrBRt7duDWVThabgMq/wWW
         Y50j0Bivgr4DIxT75w5RcH32gjKiI2jFfQXyU1N1vTXTfU7omna7axT18qEYqaeSB1/S
         pLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx04clyplTcJXgy+AMOoy2jfZ3Isc68PpwnTeKrDZ7yoHh6R4fTGfRN6y5VowCxIuJN3DM1oHyE8SF@vger.kernel.org
X-Gm-Message-State: AOJu0YzeS6OIn2ky5sngPpi6LjqPZKbQBUe6bar9sduy6oadRDXZ6S3f
	f8CZJfTI93urUqmOtdWf2sEZi6Xbf08vRfy+Azr8btZYLIldSDGKuPKy2u/N4Q==
X-Gm-Gg: ASbGncvSoxbE3s+kV3Waol9jIfXj413nGyzTYZ5AIngRgqKcJ3tZXTkOKk5w2jVO61/
	dfbjOXzR/CXl9Q1NfpA480PfoqClZEXeMjzaDZY3VgBUZjZ0lBblEQMvk4Az114GCkUM3c17FgR
	CR4OGX+bdoDIuZ7dgX96BewBsPq1Ec/lwF6RIxRk5DYX5ICDTo0jFNFo6jwpgArPATMi5AabdNv
	cULjspPw1zILR62caFO7+m5E4L+I1qlnWuTrzrd0Z1zvc7XFU7cASUVeKo1
X-Google-Smtp-Source: AGHT+IHKkfFoUJmuviCWJxeHOxw/i7OyuK3tNEwkKuGLCgFdomsJz63utqGvLX0dQV2QgpKkzX7kug==
X-Received: by 2002:a17:90b:3ec6:b0:2ee:8031:cdbc with SMTP id 98e67ed59e1d1-2f13930b92amr3181455a91.23.1733975911667;
        Wed, 11 Dec 2024 19:58:31 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d3asm218413a91.7.2024.12.11.19.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 19:58:31 -0800 (PST)
Date: Thu, 12 Dec 2024 12:58:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	caiqingfu <baicaiaichibaicai@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <20241212035826.GH2091455@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We've got two reports [1] [2] (could be the same person) which
suggest that ext4 may change page content while the page is under
write().  The particular problem here the case when ext4 is on
the zram device.  zram compresses every page written to it, so if
the page content can be modified concurrently with zram's compression
then we can't really use zram with ext4.

Can you take a look please?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219548
[2] https://lore.kernel.org/linux-kernel/20241129115735.136033-1-baicaiaichibaicai@gmail.com

