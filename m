Return-Path: <linux-ext4+bounces-8882-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89633AFC1DD
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 07:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD81716F1C4
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 05:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1459B218851;
	Tue,  8 Jul 2025 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Lq6t9EsG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCEF1E571B
	for <linux-ext4@vger.kernel.org>; Tue,  8 Jul 2025 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951142; cv=none; b=OizIbQTZG01dfYzDRcasZVAKiEDnLz5i/1nuwFcAxdaPmIhr96WPY3DSitGy9Qj0wPTbtMrXT0pUeqkVWrR7eOqFxdi23EjtoLOP3aAKxLVFDJ8hmx6i9uWi/VekGRdOfzqZbrIClq2yMrxJzEIRgMKr4thIYU9d5yEZYu3eP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951142; c=relaxed/simple;
	bh=XbHthtLjeMxvpEsokUL5L6zTC/GYu6YVUUjUxh0xdYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8lXvbAkXVYzQbykAEVrB25aVNR3QrsH0mYNffAXOS+94+hPzIdBXJh1HY37JmCqVSrbJzyMAWfG+7OsBk0v0cCO+xNpHG/eMKukYr8GxrP3fXoDWNxbAYULSSjkoEyNRb4RvR6EjPx4588JlPy8e52egiKa6NUI4Slabv7QJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Lq6t9EsG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so3442318b3a.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Jul 2025 22:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1751951140; x=1752555940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Omo6LLgJyVULzloJLyFZcLDr3jdzW0nRsKBFp8OqSOU=;
        b=Lq6t9EsGFnlp7AnwjgoAF3psgg0rrSjSLK7LyHRXhAxOBYNaAIntRKD8jPp4XOQXS5
         8hXMO7sLneKiwGG57HZ6eI2g0rtvC3cOAlA1UtBRweFciexCAcIzEXTnechd+iR/OyHh
         pfN7qLp4E80a4s1dFdbf/qAIBrNnlmzIR9SL/a4UTxAJK09ydotWicn/HQM4yCit0Mab
         1Ip/Ke5PdtbfBpjz1zCYaCpD6pea0hE662Cad5H/bIix2hmub1j+vsnnzGs8DMYN9WCe
         xLmWAHan0TVzxQUuIhaOG1P8zLeUt+RErKmJ6aICAoZZuz+IanwtDnxgqfobbdAZBNI5
         v/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751951140; x=1752555940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Omo6LLgJyVULzloJLyFZcLDr3jdzW0nRsKBFp8OqSOU=;
        b=wSaLId+zNppst2KgsjvIf2BXIVvf+8b1la+NMrQJaHSyvkSA9+FeXLQqYvs7avjC3g
         6ZbcjHk2gR3CSltAvyx14m/lPkpSwG9yEFURvg8x/K/hs2blMd/SZ99e2CxShsjTRcWm
         32V2EMoAW6OVNCrOmHmsVKlnN+8vSb1m+yUxrrGGWjrGNJcJEb6VPK0HbqO24LZb0g57
         K2eFCYtPs9rTOiLzf283tgAIfYqhk8IRvJ45cyVQ2Lj/nl4L3L27XhGwicl2wbV0TwdJ
         HZ/0ucX6R/PVHYPFsRfr7VmILY7HL+lg8ThV4T5zWh06ql8DvPAEUmLOKrm822JO7PKq
         8P1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2+7bvAF3U8Q3Jq4dlMx37qLvSKRs9z9IU+sl4rIwXPMGlm8k5gBIlHbT30BSyTsFvYWjhw8PchogW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5dS/lB8srHL3vxz1glrM9H2id/nRRA4G36amUPuF9LBPY/xRS
	ahvpVCj+Pe5dxqRb5Ju4zNUuKzskP1wUgEgUFNA6zyPYQ3bFTv3swYs3bUkAAVocyB0=
X-Gm-Gg: ASbGnctg2zdV4+YRKSU/qVE/BhIqs6OzzuLTnIWF2JOmaCvYfotuEAufSiyaod/oHTr
	Z+L/vvIRT8nDCjk2lRmlcTh44nWyuLKcCYD0Ppw9AphGctM4KX6nvOyelO1qf5HlWiNexx5+ZR6
	vKp7joXuTKwqwIBCBlTJJEbl5CzoZTbO/rriWSeetVWMyyYtwkKrumrMdW+A2LYSyrmdUiV/SS9
	Wvb3A/QGN40yRDSRqWvcQoRjsstb86GvV92wI2kGl2UUywzEkgGNEUoAOQZzprS6egXjBquN4Rw
	7VwfsbqoD/dhKQ6Q4T025U8qMsQcNBH22Yl7YSj2cCzJDYmHW43d6uMrPtyRq/5Z9j/lbGNK4lp
	JhIgyA7/CVpXX0NzDlzsjgrzevpPsAAWSdS4VXw==
X-Google-Smtp-Source: AGHT+IGsHUT6Bi+76saZTNBr04hdGSYcx5107pQyHdDmPfUk8q23TTXe1KfcBJmRM20GAyE10VbqJw==
X-Received: by 2002:a05:6a20:728b:b0:1f5:8c05:e8f8 with SMTP id adf61e73a8af0-22b4449d668mr3073800637.25.1751951140491;
        Mon, 07 Jul 2025 22:05:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3918d81a3fsm4275006a12.15.2025.07.07.22.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 22:05:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uZ0WP-00000008J2c-0q8k;
	Tue, 08 Jul 2025 15:05:37 +1000
Date: Tue, 8 Jul 2025 15:05:37 +1000
From: Dave Chinner <david@fromorbit.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <aGynIewLL-05fuoJ@dread.disaster.area>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <02584a40-a2c0-4565-ab46-50c1a4100b21@gmx.com>
 <bdce1e62-c6dd-4f40-b207-cfaf4c5e25e4@gmx.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdce1e62-c6dd-4f40-b207-cfaf4c5e25e4@gmx.com>

On Tue, Jul 08, 2025 at 12:36:48PM +0930, Qu Wenruo wrote:
> 在 2025/7/8 11:39, Qu Wenruo 写道:
> > 在 2025/7/8 10:15, Darrick J. Wong 写道:
> > > > Yes, the naming is not perfect and mixing cause and action, but the end
> > > > result is still a more generic and less duplicated code base.
> > > 
> > > I think dchinner makes a good point that if your filesystem can do
> > > something clever on device removal, it should provide its own block
> > > device holder ops instead of using fs_holder_ops.
> > 
> > Then re-implement a lot of things like bdev_super_lock()?

IDGI. Simply add:

EXPORT_SYMBOL_GPL(get_bdev_super);

And the problem is solved.

> > I'd prefer not.
> > 
> > 
> > fs_holder_ops solves a lot of things like handling mounting/inactive
> > fses, and pushing it back again to the fs code is just causing more
> > duplication.

This is all encapsulated in get_bdev_super(), so btrfs doesn't need
to implement any of this. get_bdev_super/deactivate_super is the API
you should be using with the blk_holder_ops methods.

> > Not really worthy if we only want a single different behavior.

This is the *3rd* different behaviour for ->mark_dead. We
have the generic behaviour, the bcachefs behaviour, and now the
btrfs behaviour (whatever that may be).

> > Thus I strongly prefer to do with the existing fs_holder_ops, no matter
> > if it's using/renaming the shutdown() callback, or a new callback.
> 
> Previously Christoph is against a new ->remove_bdev() callback, as it is
> conflicting with the existing ->shutdown().
> 
> So what about a new ->handle_bdev_remove() callback, that we do something
> like this inside fs_bdev_mark_dead():
> 
> {
> 	bdev_super_lock();
> 	if (!surprise)
> 		sync_filesystem();
> 
> 	if (s_op->handle_bdev_remove) {
> 		ret = s_op->handle_bdev_remove();
> 		if (!ret) {
> 			super_unlock_shared();
> 			return;
> 		}
> 	}
> 	shrink_dcache_sb();
> 	evict_inodes();
> 	if (s_op->shutdown)
> 		s_op->shutdown();
> }
> 
> So that the new ->handle_bdev_remove() is not conflicting with
> ->shutdown() but an optional one.
> 
> And if the fs can not handle the removal, just let
> ->handle_bdev_remove() return an error so that we fallback to the existing
> shutdown routine.
> 
> Would this be more acceptable?

No.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

