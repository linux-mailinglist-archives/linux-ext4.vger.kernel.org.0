Return-Path: <linux-ext4+bounces-5896-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77359A0245F
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 12:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06903A2358
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 11:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F771DDA1E;
	Mon,  6 Jan 2025 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yReKwwIl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF191DD877
	for <linux-ext4@vger.kernel.org>; Mon,  6 Jan 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163346; cv=none; b=Utjf4fWOsNjLLXXnrza3CZBqgo3oJLPKrd4Fg9Jb39FUDme7DnILyTRyjJBS7OVS04nnBWTkxgj4midblGrT0+NzuJPh5bfmuA61eIETRYfjjYVcQoUBVUvRwroc5F2Jsy8SeGXLBpJK1fFSMP1CqsBCzb2OgADwfK9PqUu5RBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163346; c=relaxed/simple;
	bh=h9x7fU3zMZ3O9SaobNmcIu72VxHRH47G5BsxrJmlDJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDF71h8fPt3DXh8B8xvsfoocVzBtKD3VsfagXcCw6wAkguxFjeJCHAPQjg+MxWc3kK/C5K/sfhuOPP1o+4tRBds9Ro1f6COr4qggC+Y0qy/zC/SytNc6FoLySKrxkmHRHCFI260l8UodSTaLiTyPEeq/TzoD0bmkmXh5E2O1dKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yReKwwIl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so162671185e9.0
        for <linux-ext4@vger.kernel.org>; Mon, 06 Jan 2025 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736163341; x=1736768141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxVlOv7MRs9GINJz5QT9QdIbM+9oFglvGClM+Y848Rs=;
        b=yReKwwIlTTKtclaM8Dxg9zx6LJLkPXbM8gtmgYZx3Yf41JwnRr8mI6AOTXnzFFhEOn
         +hBTFAmmRjbbWKcLKRGk7q30E7c0XQjKEH8J6B10dI6APZgjHIhUmVCSqZfPr9OWKPMk
         AQaW3r/Nmkzb2SmYG5jbFmX9KA+P9mzfHDQG1Ysc5/RfX+Mol4wd8NnY+DYboeu0HAO4
         VooCyzlKak5seO2l0tPk1nGljqv5MG0TNFdPib+z1miNsBQsmKfEjRaOM4l+D5MPaJfi
         FZVbqQZOu+WxvJEmrCDzMBPQGFZ25I1+cmxnZgc4UBoC70H83u3c40KrWIhmQvXjS1Y8
         QJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736163341; x=1736768141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxVlOv7MRs9GINJz5QT9QdIbM+9oFglvGClM+Y848Rs=;
        b=gxkcdP9rwelhQfsAVii2A9IMKHHdkfFjqNyZ7u/mqRU4T5CiYDgI6oVr63XYFeiSYr
         NNAbHMvXiMoPY2LuYNl4NpFcHVkYWLwShJ186zKGDWkl6soIQrcbqKPfm/xvHDySsHGR
         JdsGdgJ14HTi/vGJVsDdOdkbNljmRrYXmHDKgsfUR4W3i1iv2n9oGtIRtYhQGFRpKtDr
         Ow0W0w1a1v7r9xWwxFHBGDpOZJOzhPAr+WyXD49NccH6TizOzAhETe1RWA+NSmJZN3/Z
         K28s6a+BAQkJpFe4AUcjo5ZEOkb1eaGnBJQeaYNinXUuUtJ5zk7SJM5j93r6dqoD/0Ew
         oAZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV00xiI8+ffxDR2NJt/I7+lQQI6W9pDLURIFgTkLe9V9cv4ZXdi6ya5Rnrdl+gM7GkoHV9ggBWH97r7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2R2n2EsQiSHpLR5yB5TYFDRrcuUHMpRF3PKMs0RN0rejRk3pG
	vj9k6RGcMqT6ELNRYwFDu2uHgpTeceDRlD7b9u03mXjLxMYj/vYhauxMfuL24qE=
X-Gm-Gg: ASbGncuE31BJWkkTPTF61cj2lEGu8mZRm0Sd/AHF5TGWDcHcpmhY3MUU4zn/+K4EKbt
	cfb2G9CSdQIR8Bh1LkVynAtGlDZkM3uORq9nHFHq0GlFCfP8lcShC/dqdWfcFOmg/hSEs3W6nvy
	84spEMLe4FzYKJAy2d9YCMIl05JWytk66f32yrM6TmSELQkw3iwcJOrTGmiiLfw5n19IrlCx+RC
	EcckgqArWm1OfeDG4YVytM4z4zoF2pYyLxFHpkZIy81x9HrW6SA9ZsGqKZXxQ==
X-Google-Smtp-Source: AGHT+IE3U13MuikEBJhPkofq9DztLszvAkOREJWx5lHij9sjXdSLNKb8luysFS8kXjLfs0Q3ROwVhQ==
X-Received: by 2002:a5d:5f56:0:b0:386:1cd3:8a00 with SMTP id ffacd0b85a97d-38a223f5b41mr56111928f8f.40.1736163341471;
        Mon, 06 Jan 2025 03:35:41 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8474a9sm46997867f8f.52.2025.01.06.03.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 03:35:40 -0800 (PST)
Date: Mon, 6 Jan 2025 14:35:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Alex Tomas <alex@clusterfs.com>, Eric Sandeen <sandeen@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] ext4: Fix an error handling path in
 ext4_mb_init_cache()
Message-ID: <9383bdd6-ac04-4a14-aec1-bb65b67ace75@stanley.mountain>
References: <3921e725586edaca611fd3de388f917e959dc85d.1735912719.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3921e725586edaca611fd3de388f917e959dc85d.1735912719.git.christophe.jaillet@wanadoo.fr>

On Fri, Jan 03, 2025 at 02:59:16PM +0100, Christophe JAILLET wrote:
> 'bhs' is an un-initialized pointer.
> If 'groups_per_page' == 1, 'bh' is assigned its address.
> 
> Then, in the for loop below, if we early exit, either because
> "group >= ngroups" or if ext4_get_group_info() fails, then it is still left
> un-initialized.
> 
> It can then be used.
> NULL tests could fail and lead to unexpected behavior. Also, should the
> error handling path be called, brelse() would be passed a potentially
> invalid value.
> 
> Better safe than sorry, just make sure it is correctly initialized to NULL.
> 
> Fixes: c9de560ded61 ("ext4: Add multi block allocator for ext4")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> The scenario looks possible, but I don't know if it can really happen...

A pointer to the stack can't ever equal the address of the heap so this
can't happen and it should not have a Fixes tag.

Setting the pointer to NULL probably silences a static checker warning
and these days everyone automatically zeroes stack data so it doesn't
affect the compiled code.  However generally we generally say that we
should fix the checker instead.

I've thought about this in Smatch for a while, and I think what I would
do is say that kmalloc() returns memory that is unique.  Smatch tracks if
variables are equal to each other and unique variables wouldn't be equal
to anything that came earlier.  But I haven't actually tried to implement
this.

regards,
dan carpenter


