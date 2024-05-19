Return-Path: <linux-ext4+bounces-2577-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D3C8C9375
	for <lists+linux-ext4@lfdr.de>; Sun, 19 May 2024 07:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95568B20F50
	for <lists+linux-ext4@lfdr.de>; Sun, 19 May 2024 05:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9E5101DB;
	Sun, 19 May 2024 05:05:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56085CA64
	for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716095144; cv=none; b=YWdeoYT0HnPQZE2Qf0Kdx8Ycth3XwCIkP2z5JH2rSY7Qgeld2JwrtNYSQg5G7+2GscycXSP6mZC2CIhM5GgmsNHBcamDNT8Cm1RvrWM9NqVCAun7r9ZH96/TNB/VQDJokcSmN4U93LxtUqkEzX/58Yoi/NWd3jGs8coQDxn4XD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716095144; c=relaxed/simple;
	bh=luobphtaggRTIHX34O6jyVWEXnFxOjMsxGKaQRu+p7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWHedUEOML9j1UiDFCtUTcOT1yN7PR3WVYrN5fteim9RXokFuLV/BbIIbXw6JqDzmiWJO56/cGDvumeb0Ic25GOS4h/pPerFZOr2UmmC5IKnofkCxVWayX74plVZesgdq2h2NPQMAcDcZZZQrdtIE4WzDxj5biZRo1iyoNnSR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43e09dab877so13307781cf.1
        for <linux-ext4@vger.kernel.org>; Sat, 18 May 2024 22:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716095142; x=1716699942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0vRva3h81x8N2Kbd4V8azo7Ww7WsqKpR54YqM9Pj9o=;
        b=qO51HQ+zVykKkYx9p17ls0o8YKa1oaDsyggYlF7WQew3o9ui9e/1ghv7BOE2GE/c/v
         OaVLF7aP+J9BPAO256g9FNIVT9jsxX9phXNLeTk02J4dl3IXU7VNZ6IL40ZN+1j7pgO/
         bTFOutFDtoH9iAsEWjAUrDMLUbnLujaOr0TUbzj6CjWsVVvlaUy3zWC4dE++l28DmKw6
         Il28q63KEn3ejCUxzL/x8MAImbs3X9nTeO1qbQ1sTvnpJAOfGuB9WiXq4S7+FxZjORIF
         e2I66seddOHdk7wJYsimzBLDiEWkkigNYK7I2oGMnBuOP4LSofPZ7YVmr5bYlUPElCo6
         Uszg==
X-Forwarded-Encrypted: i=1; AJvYcCUTCYLuJ0eiJM3Efg9jAhHCL8++ZC3kfiGHqDsZDuwYpLwwPPo5ocbSe49b6OFFRi5TNMWHnfNcAlhOLvBejm7yw4qI50Yv6IJnkA==
X-Gm-Message-State: AOJu0YyEgf2IdrFgQHJGXZxVboKN3HBYOIXamm3g+qguivbRoXzeKHEn
	68NUJHxrWQg/kg4336a3hTMNhlfW28xm5IdzzI2EZ5qiiR7KhMESOtC4s5je6jY=
X-Google-Smtp-Source: AGHT+IH4+X4dYat+1w6SQ8pKv9TOYZD2hGahJqFKm/DkjBIlpUwIF256nHrcgELwcfTSVg9kuxO9dQ==
X-Received: by 2002:ac8:5954:0:b0:43a:c483:9fc3 with SMTP id d75a77b69052e-43dfdb299c0mr303159331cf.26.1716095142237;
        Sat, 18 May 2024 22:05:42 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e217a6fd9sm80501131cf.42.2024.05.18.22.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 22:05:41 -0700 (PDT)
Date: Sun, 19 May 2024 01:05:40 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: dm-devel@lists.linux.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, regressions@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <ZkmIpCRaZE0237OH@kernel.org>
References: <20240518022646.GA450709@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518022646.GA450709@mit.edu>

Hi Ted,

On Fri, May 17, 2024 at 10:26:46PM -0400, Theodore Ts'o wrote:
> #regzbot introduced: 1c0e720228ad
> 
> While doing final regression testing before sending a pull request for
> the ext4 tree, I found a regression which was triggered by generic/347
> and generic/405 on on multiple fstests configurations, including
> both ext4/4k and xfs/4k.
> 
> It bisects cleanly to commit 1c0e720228ad ("dm: use
> queue_limits_set"), and the resulting WARNING is attached below.  This
> stack trace can be seen for both generic/347 and generic/405.  And if
> I revert this commit on top of linux-next, the failure goes away, so
> it pretty clearly root causes to 1c0e720228ad.
> 
> For now, I'll add generic/347 and generic/405 to my global exclude
> file, but maybe we should consider reverting the commit if it can't be
> fixed quickly?

Commit 1c0e720228ad is a red herring, it switches DM over to using
queue_limits_set() which I now see is clearly disregarding DM's desire
to disable discards (in blk_validate_limits).

It looks like the combo of commit d690cb8ae14bd ("block: add an API to
atomically update queue limits") and 4f563a64732da ("block: add a
max_user_discard_sectors queue limit") needs fixing.

This being one potential fix from code inspection I've done to this
point, please see if it resolves your fstests failures (but I haven't
actually looked at those fstests yet _and_ I still need to review
commits d690cb8ae14bd and 4f563a64732da further -- will do on Monday,
sorry for the trouble):

diff --git a/block/blk-settings.c b/block/blk-settings.c
index cdbaef159c4b..c442f7ec3a6b 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -165,11 +165,13 @@ static int blk_validate_limits(struct queue_limits *lim)
 	lim->max_discard_sectors =
 		min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors);
 
-	if (!lim->max_discard_segments)
-		lim->max_discard_segments = 1;
+	if (lim->max_discard_sectors) {
+		if (!lim->max_discard_segments)
+			lim->max_discard_segments = 1;
 
-	if (lim->discard_granularity < lim->physical_block_size)
-		lim->discard_granularity = lim->physical_block_size;
+		if (lim->discard_granularity < lim->physical_block_size)
+			lim->discard_granularity = lim->physical_block_size;
+	}
 
 	/*
 	 * By default there is no limit on the segment boundary alignment,
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 88114719fe18..e647e1bcd50c 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1969,6 +1969,7 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		blk_queue_flag_clear(QUEUE_FLAG_NOWAIT, q);
 
 	if (!dm_table_supports_discards(t)) {
+		limits->max_user_discard_sectors = 0;
 		limits->max_hw_discard_sectors = 0;
 		limits->discard_granularity = 0;
 		limits->discard_alignment = 0;

