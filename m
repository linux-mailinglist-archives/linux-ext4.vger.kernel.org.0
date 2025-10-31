Return-Path: <linux-ext4+bounces-11378-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3CAC22E1A
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Oct 2025 02:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE4214E22D6
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Oct 2025 01:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D57B245010;
	Fri, 31 Oct 2025 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Y6LtKCIQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610323FC54
	for <linux-ext4@vger.kernel.org>; Fri, 31 Oct 2025 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874436; cv=none; b=kpDb/wpPJ6+b3MM2E8Y/G4/+zwnJ71BMsN5efZc42cW5YfpRpldeDfFfV1Bm6jLQd5IyPVvXGefGNF5zR82/J3HjQRuvV8DA+mbZdWzPVql5Vjc+wxdQjYpY4zq+X3hJtb6HiaGhZmcVMqbhjfytXB19p7Esn957ObbwPVnGyr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874436; c=relaxed/simple;
	bh=WlF7VMa1y5OUxpqnvA9leqytX5erYzN0ryYse+m+1+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPS6CrVf/8MV3dPKDaFnfBJoJNMJ5ZeObmrSpvovWlZbniTTPL7ickgAtf6f8/fLvMlmwz9rpOmuyBfRdzFlrDza8mNUr0etJAfJ36WcwUG/5j4duUnQpyzi4UkqO5h2GyESXQmAKr3DuNR5eiC0CVHe1ipZydzzH7OERXkfJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Y6LtKCIQ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([104.135.220.250])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59V1Xaj5027349
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 21:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1761874420; bh=P3I8cNYLZMmveAjSeJGwTBzKs1G7OdEm7OMhibpVomU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Y6LtKCIQDi/6z8+qmoyY2BEIOGve4MmpP1VdPBPjckBw19DhcLVxjkFQAOvuQ7zbr
	 i91ds7wNw7zDZEXrP7qpXE5TjfN6EScpwF4AzW2BEve3yQytVwzO8p9N+k7/CUzhE0
	 X1iKFoO8n3J9HKtXw1WAdUzRyPmYgUsI36fwh2moo5MZ/FMUJK6y7rt5fQrYoPVoa9
	 Bc1IPVZahjlASLCBClO4VcpL4b9xuEVBDplL8qGsZ0By5l2QV/ip8TF9uCsC1W0Kcj
	 v/rWz4Mm7iSsEITV3ePjU7fgJqJBM8TGuJTJfdeuC4oDvOmNS93YLOioiOdaOkRu2L
	 jh5MhM2fJNXug==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id BCA5C48AB9B3; Thu, 30 Oct 2025 18:33:35 -0700 (PDT)
Date: Thu, 30 Oct 2025 18:33:35 -0700
From: "Theodore Tso" <tytso@mit.edu>
To: Bough Chen <haibo.chen@nxp.com>
Cc: "jack@suse.cz" <jack@suse.cz>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: ext4 issue on  linux-next(next-20251030)
Message-ID: <20251031013335.GA10593@macsyma-3.local>
References: <20251023-qm_dts-v1-0-9830d6a45939@nxp.com>
 <20251023-qm_dts-v1-2-9830d6a45939@nxp.com>
 <DU0PR04MB9496D99F17904D1B2EFB9E5090FBA@DU0PR04MB9496.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9496D99F17904D1B2EFB9E5090FBA@DU0PR04MB9496.eurprd04.prod.outlook.com>

On Thu, Oct 30, 2025 at 11:11:51AM +0000, Bough Chen wrote:
> Hi Jack,
> 
> On the latest linux-next, I find your patch acf943e9768e ("ext4: fix checks for orphan inodes") trigger the following issue on our imx7d-sdb board.
> I do not have enough background knowledge of ext4, so don't know why there are orphan inodes on the partition with ext4. Not sure whether this 
> is a real issue or we need some special operation on current ext4 partition.

If you are willing to let me to see your file
names, you could send me just the metadata blocks so I can examine file
system image.  The details are in the REPORTING BUGS section of the
e2fsck man page and as well as the RAW IMAGE FILE and QCOW2 IMAGE FILE
sections of the e2image man page, but the short version is:


            e2image -Q /dev/mmcblkp2p2 fs.qcow2
            bzip2 -z fs.qcow2

... and then send me the fs.qcow2.bz file.

If you aren't please try running "dumpe2fs -h /dev/mmcblk2p2" and send
me the output.

Thanks,

						- Ted

