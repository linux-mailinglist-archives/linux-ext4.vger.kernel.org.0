Return-Path: <linux-ext4+bounces-8280-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC43ACBDF0
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 02:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6886B1696D4
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 00:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2003C47B;
	Tue,  3 Jun 2025 00:29:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A74173
	for <linux-ext4@vger.kernel.org>; Tue,  3 Jun 2025 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748910563; cv=none; b=p9bLqa/JmbrWwD3Ousk/STzopEiyuJ3ogA2M4jkv2OYLyOYH97SrpSNh8f3mTVv3Jfelbatls0x8ztLvkF0zGwRmuI61X8Mr4nVcimelKgPg1VVmbQmJ2XiZ+dXposInGHHA/WK6XA8qqHBjeoi2u06sLxQ721N8mgqAJk5iTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748910563; c=relaxed/simple;
	bh=7kBULcNOQLgFwYsrPTxrcXzgnppHs8v6yluSvg7bHnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYkFR/NAA6+RAaUmVVUiXC+zFyyzkIlBqONONFxIoWXZDWlNZ1hXmj6sauzy25Pmywb1FreBPfRA9hbkZLyVxibODJ5sawjVhTSFGUb8dqVUmockSF5M154W5B0qfUpDOv0eMKLZlewmCOjz82h4sq4WwVHqPSDNmb4FS4vhuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([193.243.188.32])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5530T5r3002826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Jun 2025 20:29:06 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id E3415340513; Mon, 02 Jun 2025 20:29:04 -0400 (EDT)
Date: Tue, 3 Jun 2025 00:29:04 +0000
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mitta Sai Chaithanya <mittas@microsoft.com>
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Nilesh Awate <Nilesh.Awate@microsoft.com>,
        Ganesan Kalyanasundaram <ganesanka@microsoft.com>,
        Pawan Sharma <sharmapawan@microsoft.com>
Subject: Re: [EXTERNAL] Re: EXT4/JBD2 Not Fully Released device after unmount
 of NVMe-oF Block Device
Message-ID: <20250603002904.GE179983@mit.edu>
References: <TYZP153MB06279836B028CF36EB7ED260D761A@TYZP153MB0627.APCP153.PROD.OUTLOOK.COM>
 <20250601220418.GC179983@mit.edu>
 <TYZP153MB0627DED95B9B9B2E86D66EFED762A@TYZP153MB0627.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZP153MB0627DED95B9B9B2E86D66EFED762A@TYZP153MB0627.APCP153.PROD.OUTLOOK.COM>

On Mon, Jun 02, 2025 at 09:32:18PM +0000, Mitta Sai Chaithanya wrote:

> However, after the connection is re-established and the device is
> unmounted from all namespaces, I still observe errors from both ext4
> and jb2 when the device is especially disconnected.

How do you *know* that you've unmounted the device in all namespaces.
I seem to recall that some process (I think one of the systemd
daemons, but I could be wrong) was creating a namespace that users
were not expecting, resulting in the device staying mounted when the
users were not so expecting it.

The fact that /proc/fs/ext4/<device_name> still exists means that the
kernel (specifically, the VFS layer) doesn't think that the file
system can be shut down.  As a result, the VFS layer has not called
ext4's put_super() and kill_sb() methods.  And so yes, I/O activity
can still happen, because the file system has not been shutdown.

If you still see /proc/fs/ext4/<device_name>, my suggestion would be
grep /proc/*/mounts looking to see which processes has a namespace
which still has the device mounted.  I suspect that you will see that
there is some namespace that you weren't aware of that is keeping the
ext4 struct super object pinned and alive.

> Another point I would like to mention, I am observing JBD2 errors especially after NVMe-oF device has been disconnected and below are the logs.

Sure, but that's the effect, not the cause, of the NVME-of device
getting ripped down while the file system is still active.  Which I am
99.997% sure is because it is still mounted in some namespace.  The
other 0.003% chance is that there is some refcount problem in the VFS
subsytem, and I would suggest that you ask Microsoft's VFS experts,
(such as Christain Brauner, who is one of the VFS maintainers) to take
a look.  I very much doubt it is a kernel bug, though.

  	   	     	      	   	       - Ted

