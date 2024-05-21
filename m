Return-Path: <linux-ext4+bounces-2618-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5B8CB160
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2024 17:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC39A28391F
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2024 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEF81448E6;
	Tue, 21 May 2024 15:29:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DAE4F8A1
	for <linux-ext4@vger.kernel.org>; Tue, 21 May 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305388; cv=none; b=qYjW8RSaQKReUUby0/6D+hF49mobMJUuyAh3kRqHQMTr4mmLkKcE4f+3jjxHqEviwFif5Q0yTYRTOFw4D0KzP25FxlmatiNCOmGOq1gdzywWvio8G6b/jYtAXlzlHYiP1sQNSUFcIGLuJ9dfumNnhO4tFNxQPg5XEaARwSTrntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305388; c=relaxed/simple;
	bh=UvH4ktnL1tc7jDTG/u5fqTldApC2eZfE4ZdoJUo2544=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5KU+pOu5PKejT6AnZ+szpbqhPHTONj/KW/mElbU6bUHBbP+d1hohq5XjmngUn1pI7GxIPVIPVP2/pdJ+b0w2zVaQbqyvE8GYmc8ymyDmL62t+G0BF2d9sX1t30oofcM9fw667+6sqnaJg3pJiLwDLqfhERFD0oHuFdDJIwwNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-792b8cd0825so19486685a.0
        for <linux-ext4@vger.kernel.org>; Tue, 21 May 2024 08:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305385; x=1716910185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+XPV7zuv4ms1R7vIYpXPZzY3GXErYi4LFqsxLAG47I=;
        b=vxMoxF8v53oBpE29mGQioTPgQvcnWDjfNHxIpW8bFlDnU0PU8JDSD7f6wpcVuiNOH6
         ZTmfiBRmP2C/YSBSt9/+cnHcL7BBCEfvhFkYaIAqVlurId/G7lUey+NnlsgvWRxn/PZ8
         LXK/rrq3CkEwtDdoJxDDuZTFpHlqWB59tVnMeWS7PS8migVZ09EmaBONXb5l8kuTBOVX
         vQEvMNGf0Nbco9u3bUs4QVFHkFFht77/t38iAUn05aM//3WdpGowYhIRu7+JhKfkG9oG
         zGB3kKUEJU2P90yirJBXIHRlg+DyJMeDNYrpPULOwU/6vb3zQiW5ExvxSpcVZzw21laI
         /AMQ==
X-Forwarded-Encrypted: i=1; AJvYcCURKCTi1EaFlpd1UkbBB3DcQk2dkkRBUYnAib2oGUFczoXfLPVMf/wZm5DXms+LCMmIhK+42XpDX3vz7Naq+Ge/s/6g2FwjQ23Uhg==
X-Gm-Message-State: AOJu0YwDMvF+ZTQarjvBrhBGpfoOeCApc3fn5PonKoRFLTwvDhVu4yq7
	OhujsDIHtKoT6A8Mv/+LiX0JV6U+e3V39kUxppOfcRG6Ouky+BTtlasfrCNwNejdDTB57m/XBqs
	Wa1A4YA==
X-Google-Smtp-Source: AGHT+IF8uzIllLEK1FILZCyeg/sSMiPh8GED2VV5AYcL1qdc3iolbJlLULo4eghby1CQfxaYqUkGog==
X-Received: by 2002:a05:620a:244a:b0:790:797d:2c4a with SMTP id af79cd13be357-792c75763e2mr3967911485a.14.1716305385299;
        Tue, 21 May 2024 08:29:45 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc789sm1291554285a.93.2024.05.21.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:29:44 -0700 (PDT)
Date: Tue, 21 May 2024 11:29:43 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
Cc: dm-devel@lists.linux.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, regressions@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <Zky951XVqcqI48P3@kernel.org>
References: <ZkmIpCRaZE0237OH@kernel.org>
 <ZkmRKPfPeX3c138f@kernel.org>
 <20240520150653.GA32461@lst.de>
 <ZktuojMrQWH9MQJO@kernel.org>
 <20240520154425.GB1104@lst.de>
 <ZktyTYKySaauFcQT@kernel.org>
 <ZkuFuqo3dNw8bOA2@kernel.org>
 <20240520201237.GA6235@lst.de>
 <ZkvIn73jAqz94LjI@kernel.org>
 <ZkvuqNXaNOMe6Gfj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkvuqNXaNOMe6Gfj@kernel.org>

On Mon, May 20, 2024 at 08:45:28PM -0400, Mike Snitzer wrote:
> On Mon, May 20, 2024 at 06:03:11PM -0400, Mike Snitzer wrote:
> > On Mon, May 20, 2024 at 10:12:37PM +0200, Christoph Hellwig wrote:
> > > On Mon, May 20, 2024 at 01:17:46PM -0400, Mike Snitzer wrote:
> > > > Doubt there was anything in fstests setting max discard user limit
> > > > (max_user_discard_sectors) in Ted's case. blk_set_stacking_limits()
> > > > sets max_user_discard_sectors to UINT_MAX, so given the use of
> > > > min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors) I
> > > > suspect blk_stack_limits() stacks up max_discard_sectors to match the
> > > > underlying storage's max_hw_discard_sectors.
> > > > 
> > > > And max_hw_discard_sectors exceeds BIO_PRISON_MAX_RANGE, resulting in
> > > > dm_cell_key_has_valid_range() triggering on:
> > > > WARN_ON_ONCE(key->block_end - key->block_begin > BIO_PRISON_MAX_RANGE)
> > > 
> > > Oh, that makes more sense.
> > > 
> > > I think you just want to set the max_hw_discard_sectors limit before
> > > stacking in the lower device limits so that they can only lower it.
> > > 
> > > (and in the long run we should just stop stacking the limits except
> > > for request based dm which really needs it)
> > 
> > This is what I staged, I cannot send a patch out right now.. 
> > 
> > Ted if you need the patch in email (rather than from linux-dm.git) I
> > can send it later tonight.  Please see:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.10&id=825d8bbd2f32cb229c3b6653bd454832c3c20acb
> 
> From: Mike Snitzer <snitzer@kernel.org>
> Date: Mon, 20 May 2024 13:34:06 -0400
> Subject: [PATCH] dm: always manage discard support in terms of max_hw_discard_sectors
> 
> Commit 4f563a64732d ("block: add a max_user_discard_sectors queue
> limit") changed block core to set max_discard_sectors to:
>  min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors)
> 
> Since commit 1c0e720228ad ("dm: use queue_limits_set") it was reported
> dm-thinp was failing in a few fstests (generic/347 and generic/405)
> with the first WARN_ON_ONCE in dm_cell_key_has_valid_range() being
> reported, e.g.:
> WARNING: CPU: 1 PID: 30 at drivers/md/dm-bio-prison-v1.c:128 dm_cell_key_has_valid_range+0x3d/0x50
> 
> blk_set_stacking_limits() sets max_user_discard_sectors to UINT_MAX,
> so given how block core now sets max_discard_sectors (detailed above)
> it follows that blk_stack_limits() stacks up the underlying device's
> max_hw_discard_sectors and max_discard_sectors is set to match it. If
> max_hw_discard_sectors exceeds dm's BIO_PRISON_MAX_RANGE, then
> dm_cell_key_has_valid_range() will trigger the warning with:
> WARN_ON_ONCE(key->block_end - key->block_begin > BIO_PRISON_MAX_RANGE)
> 
> Aside from this warning, the discard will fail.  Fix this and other DM
> issues by governing discard support in terms of max_hw_discard_sectors
> instead of max_discard_sectors.
> 
> Reported-by: Theodore Ts'o <tytso@mit.edu>
> Fixes: 1c0e720228ad ("dm: use queue_limits_set")
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>

With this patch applied, I verified xfstests generic/347 and
generic/405 no longer trigger the dm_cell_key_has_valid_range
WARN_ON_ONCE.  I'm sending the fix to Linus now.

