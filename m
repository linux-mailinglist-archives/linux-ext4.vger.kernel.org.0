Return-Path: <linux-ext4+bounces-8871-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB5AAFBE78
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 01:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7787422095
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jul 2025 23:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695AA2874E0;
	Mon,  7 Jul 2025 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MxCRig41"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB9202963
	for <linux-ext4@vger.kernel.org>; Mon,  7 Jul 2025 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751929378; cv=none; b=HqzIUs/WTR9CfZm7m446ro83LwUftpwrm++Hh+yATC6Q1Jz7Y/FBcYNxSVHehr6CNutOCJpDO0jAtVdjrLS1HFAVWEj6ujEQLCS55tVEowCbYeWmsQ9iFPNrBf4ixiqL149Rg3qwZ4P0zKg4DmjmM71aopOt1OfpbFOtT8UGIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751929378; c=relaxed/simple;
	bh=venDfP4EzG2xqmDXVnH3VRXG5eR6DtQAF3gSkZjRBT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKjlxSZwSRVh9yHu8IV751i/bcVwPnPol6SaAsprlbd+9DgvSMeInNM7noVwPUStDIG9mHAjBmT2Xo8hWfjfabvtnvIc7Jvsf1PnWFi3xoSVYDRkJ414fNpiRYpsaHtTRxMjTw50jO4LOHVsj8SLM4wnv3G1Zx8OqaZXgjiTorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MxCRig41; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23dc5bcf49eso20738895ad.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Jul 2025 16:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1751929376; x=1752534176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4pktmlF1vRQduNDQ1SA6N8TiSZQUsg3NAWNf5AHgsY=;
        b=MxCRig41TeJCa4KM/L6Xz2oFlIdtYCjD3OA6mnEuD5bDPv/IMBE3qkHV8dh3fNz2zk
         +8loAAi1XyTJh0utYOcYgRaPp6Lq9hHmdj1Ml2Iu1VWbIuVtW+rYgGEvQLUUH2zHU1Bc
         FZFzWHl0hOzYJ/Keixpf2MV4V2SL1nPOCuJnE6VhX9VZNqH3dwv7PIZHOv1xX1hyYwxH
         LuBdFhXco5s+r5zoeaU2mPc4AhjyZrrDkFwXmJlzQcwOSx61JiROY3+fI1WVGUXPWPXS
         m5rRjeSsQGE6irXyLOZyZvEteCvQepQG7+HADZUSi6OO6h2KgCkFfEmgY8SBNPNM7N8R
         3REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751929376; x=1752534176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4pktmlF1vRQduNDQ1SA6N8TiSZQUsg3NAWNf5AHgsY=;
        b=sffXsmPopGrTeTm65rNPj+93zaRkNRkzRtMyOIF+64typYPNr6+i17cpgf/IndUogX
         PPQsR6Q5nEwKmsrWFXlpNyiihoQtg6iRPD8IUaYB8D6KR06Cpm+3lFqp4+6DWwMKIldC
         Yr+JePrSKEBFrCVcayq5GMwWUQ9tLl8NiflQF+VVnmbKlPvGXfe56qo0XYZ8CSHChvgv
         d1xSrp3QxkVeXsIlfqmAOtJtpt1FEsEKBPj6bdHH7chZ3FXkeawlzxTsy0YaH/T0jm9O
         NXOkofxqYrEIZhHVZ4lqHdaL6RVIbNsQnPVCnn2E+cfseWzM2z0yotXMDt+3ouaHWkMx
         OMpg==
X-Forwarded-Encrypted: i=1; AJvYcCUX7akJ/78RX822WFjltM7Xv8iUllBxZY9jbP3kpmYn38SigQYc1xcJnOCMYhITpRVx7EG+CFmd6gIi@vger.kernel.org
X-Gm-Message-State: AOJu0YymwpqKdKSmxDrDgKgwIriYP90v5cVXdD59Dmzl0qFwtPL5PqNZ
	O57b31uBb3/GvmDwc8L4CWoO3+DY8p8PXAfiXwuL2ZGWIBrkPOsaD8YZzBO3XyvBRLs=
X-Gm-Gg: ASbGncvBxJBfnGTcHxav5tW7pUYutT2jnURDzHkmPgFLE6bEYPJyjLsmvdL7nIzJSob
	JpENPtnmGAPjymq7c8omJY0bRco5rzO74ixUflfqKinWfxNW1hKGYfWEV26fC9JYLzpIurSOthQ
	b/CkQPhERjRofxM7SsxLJ0WWQnBGYHgTrqAIT7+7Qv6PGC+HzdNx3q8Iiell9K7+wKvg/1wOu9U
	5QO97mX868tgLpU7zYqrRoLf/gE4atH34xVr75vDQ/TO3ezUhFMHcEJ44PPAOEeNauIHXyRds/V
	A4+DzCfUmC+NHH+ni4Ba+eRfX/qoNDramuLhlg80uRFLUfEFkUd4l2SXYvgbnnu4mNnjKbIkLvK
	hgRxzgpUWJAIqQEwz4d6N2m522I68FbxoqiOuqZr3izMDVpZR
X-Google-Smtp-Source: AGHT+IEmTi6zrkNyOcS4BN99ZoRqMQGa5CBIfG1MgDs1BPtD4rrI5GMD5dIJM6aSPlLP7bK+loeCfw==
X-Received: by 2002:a17:902:ce10:b0:234:8ec1:4ad3 with SMTP id d9443c01a7336-23dd1d5cc19mr6352555ad.40.1751929375710;
        Mon, 07 Jul 2025 16:02:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a1f0sm102785765ad.32.2025.07.07.16.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:02:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uYurM-00000008CeO-1qLV;
	Tue, 08 Jul 2025 09:02:52 +1000
Date: Tue, 8 Jul 2025 09:02:52 +1000
From: Dave Chinner <david@fromorbit.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <aGxSHKeyldrR1Q0T@dread.disaster.area>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>

On Fri, Jul 04, 2025 at 10:12:29AM +0930, Qu Wenruo wrote:
> Currently all the filesystems implementing the
> super_opearations::shutdown() callback can not afford losing a device.
> 
> Thus fs_bdev_mark_dead() will just call the shutdown() callback for the
> involved filesystem.
> 
> But it will no longer be the case, with multi-device filesystems like
> btrfs and bcachefs the filesystem can handle certain device loss without
> shutting down the whole filesystem.
> 
> To allow those multi-device filesystems to be integrated to use
> fs_holder_ops:
> 
> - Replace super_opearation::shutdown() with
>   super_opearations::remove_bdev()
>   To better describe when the callback is called.

This conflates cause with action.

The shutdown callout is an action that the filesystem must execute,
whilst "remove bdev" is a cause notification that might require an
action to be take.

Yes, the cause could be someone doing hot-unplug of the block
device, but it could also be something going wrong in software
layers below the filesystem. e.g. dm-thinp having an unrecoverable
corruption or ENOSPC errors.

We already have a "cause" notification: blk_holder_ops->mark_dead().

The generic fs action that is taken by this notification is
fs_bdev_mark_dead().  That action is to invalidate caches and shut
down the filesystem.

btrfs needs to do something different to a blk_holder_ops->mark_dead
notification. i.e. it needs an action that is different to
fs_bdev_mark_dead().

Indeed, this is how bcachefs already handles "single device
died" events for multi-device filesystems - see
bch2_fs_bdev_mark_dead().

Hence Btrfs should be doing the same thing as bcachefs. The
bdev_handle_ops structure exists precisly because it allows the
filesystem to handle block device events in the exact manner they
require....

> - Add a new @bdev parameter to remove_bdev() callback
>   To allow the fs to determine which device is missing, and do the
>   proper handling when needed.
> 
> For the existing shutdown callback users, the change is minimal.

Except for the change in API semantics. ->shutdown is an external
shutdown trigger for the filesystem, not a generic "block device
removed" notification.

Hooking blk_holder_ops->mark_dead means that btrfs can also provide
a ->shutdown implementation for when something external other than a
block device removal needs to shut down the filesystem....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

