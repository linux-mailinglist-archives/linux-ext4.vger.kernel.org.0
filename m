Return-Path: <linux-ext4+bounces-2613-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B88CA453
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2024 00:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0206E1C20CDC
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 22:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC6B139D00;
	Mon, 20 May 2024 22:03:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D11CD3B
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716242596; cv=none; b=fUskCLUJPGVaYhjr76vgUKFnu3Rcq+Lhuk5GMI1MoZ7oSiLcSLq6GWlzRWLqf9uCsIhjmG0s1zpqM3l9g+qNVYFejXi2A61bR14O4iducYsFHqquGf8REV6wogKOhEM03tmtfb1nfPsChoE/YEYsyFEfCpHFdpGa46JoN6ILV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716242596; c=relaxed/simple;
	bh=UVljutfoWopCdRjUsE3nyQBe0vyYLt1LjMCS4mpMGr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQEnIzXfdlTCq72h+UgjmVPn5L8rGn4d692q8Uwiz+DrLZPMrXK1DhfSxlaC2rtf1rwTmqyNekWlTyUNSjf02at5YuETW5Iw/phQsBBKCNnIts7qq1e9zY56+3OeE1A196mt5m5ihdT6/fWRLL5B3l24B7HSNO/0PoaRbRy4SAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43df23e034cso29149521cf.0
        for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 15:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716242594; x=1716847394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuxhBJ4qisQVuZrq+vvIeMKpTLFAeiOz1b8+2ahYk6E=;
        b=FNwVL8GERx48+rXisP9afzKrni2NoMajN+fOulbyFKwIQ5NNq8awUixmxm1WZVXSTx
         gXs1JC+3n1MFggGu9bQujGPLhiD1Ki3bAi3dhM9frlFE7rj5cDp+QlSbM0ajXRNG88z2
         ynCA6yjHHeFUp8xmKpFWUJsmEjaUvz2ZhqB9m0JXvcj/b3CtW+41tANS4L8yoNW920fO
         K7d6YjxfFQ8dZ8d5/fv+rrxaXtoeJAjNOUHO0xN3XNWpgAUZl2mgbAH3zDu0MZ18fd3t
         0C0wKqw42MtNgzWdzIUwgiqBUysJmV5nx2sb9/TcKvD4t4wrK/o9Xpd4q1OIDom0a6TT
         C+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWa8Q2TWlLQ0SQEx4eJtNBRAIBN/I6/dv270jepHWZqCT9Z/d++B/6DukVo2Mnh/0D2SV5NE1bbyRI4qCvCLcigfF0i5AuhU3qivg==
X-Gm-Message-State: AOJu0YypFeJSEYO2RHRkrmYIXxVBZkVX/fhHxobAHfWp546LPmrEbLKb
	bh34wkrgtLSmMzTG+AKGs9XhaPg41jtnBtI5p4AnYUU6JgS6GNOEibqjgi2hdPI=
X-Google-Smtp-Source: AGHT+IHkgbqiVU0lW4qUTrQXwo9y7zvN2ZZUxBT9G8J+CnypXz8b/pWVZjl3dkIURNrt2XouM39MlQ==
X-Received: by 2002:a05:622a:60f:b0:43a:357c:322a with SMTP id d75a77b69052e-43f7a303ce0mr149884241cf.34.1716242594272;
        Mon, 20 May 2024 15:03:14 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43f7a8dae94sm37851681cf.33.2024.05.20.15.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 15:03:13 -0700 (PDT)
Date: Mon, 20 May 2024 18:03:11 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
Cc: dm-devel@lists.linux.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, regressions@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <ZkvIn73jAqz94LjI@kernel.org>
References: <20240518022646.GA450709@mit.edu>
 <ZkmIpCRaZE0237OH@kernel.org>
 <ZkmRKPfPeX3c138f@kernel.org>
 <20240520150653.GA32461@lst.de>
 <ZktuojMrQWH9MQJO@kernel.org>
 <20240520154425.GB1104@lst.de>
 <ZktyTYKySaauFcQT@kernel.org>
 <ZkuFuqo3dNw8bOA2@kernel.org>
 <20240520201237.GA6235@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520201237.GA6235@lst.de>

On Mon, May 20, 2024 at 10:12:37PM +0200, Christoph Hellwig wrote:
> On Mon, May 20, 2024 at 01:17:46PM -0400, Mike Snitzer wrote:
> > Doubt there was anything in fstests setting max discard user limit
> > (max_user_discard_sectors) in Ted's case. blk_set_stacking_limits()
> > sets max_user_discard_sectors to UINT_MAX, so given the use of
> > min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors) I
> > suspect blk_stack_limits() stacks up max_discard_sectors to match the
> > underlying storage's max_hw_discard_sectors.
> > 
> > And max_hw_discard_sectors exceeds BIO_PRISON_MAX_RANGE, resulting in
> > dm_cell_key_has_valid_range() triggering on:
> > WARN_ON_ONCE(key->block_end - key->block_begin > BIO_PRISON_MAX_RANGE)
> 
> Oh, that makes more sense.
> 
> I think you just want to set the max_hw_discard_sectors limit before
> stacking in the lower device limits so that they can only lower it.
> 
> (and in the long run we should just stop stacking the limits except
> for request based dm which really needs it)

This is what I staged, I cannot send a patch out right now.. 

Ted if you need the patch in email (rather than from linux-dm.git) I
can send it later tonight.  Please see:

https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.10&id=825d8bbd2f32cb229c3b6653bd454832c3c20acb

