Return-Path: <linux-ext4+bounces-11642-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A799BC3F28D
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 10:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50E614EC753
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5042F5A3F;
	Fri,  7 Nov 2025 09:29:59 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575B42E229C;
	Fri,  7 Nov 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507799; cv=none; b=gUprO3tGPdylzQhhFrCW0nOIYEnQq+iv2qo28LHAEXzxAgDzFkWAVMQFjRhHngDmeFbRcsqo2pKA6rv/gvPOkH/4/AhcBjn/fvFOhULA0c3LskkfhhduHAntW9RXQMFSMK/4vAiHjszCo2wrw+9qL33kVzdkLMyNyFa8IvTOYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507799; c=relaxed/simple;
	bh=/2s4g//BU/6Uee5HYgUTnvXGGsATrkIlRh9rRdiR4OQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TYQY/T5Dsboge6UxAOiejVV5scTK9nuq6O/JpXJzYSLjhTaO2EByoVCbKbuk1fBsQWMEDVSZlbfefOWHu6YMFdmkpuTNvrr7Y3pgwPQN60GLyAkUtE1f7mejERbs2+j5mOai/AteULR8O9+hQ3xOjD24UbQG8UivW2n/ikpbrgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 769BA1003C4DEB; Fri,  7 Nov 2025 10:23:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 748FF11009ACB3;
	Fri,  7 Nov 2025 10:23:23 +0100 (CET)
Date: Fri, 7 Nov 2025 10:23:23 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: Christoph Hellwig <hch@lst.de>
cc: "Darrick J. Wong" <djwong@kernel.org>, miklos@szeredi.hu, 
    brauner@kernel.org, linux-ext4@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: allow NULL swap info bdev when activating
 swapfile
In-Reply-To: <20251030060008.GB12727@lst.de>
Message-ID: <q43nr1rs-3o58-96pq-111s-r58s9q5nnq21@vanv.qr>
References: <176169809564.1424591.2699278742364464313.stgit@frogsfrogsfrogs> <176169809588.1424591.6275994842604794287.stgit@frogsfrogsfrogs> <20251029084048.GA32095@lst.de> <20251029143823.GL6174@frogsfrogsfrogs> <20251030060008.GB12727@lst.de>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Thursday 2025-10-30 07:00, Christoph Hellwig wrote:
>
>> "Already does" in the sense that fuse already supports swapfiles(!) if
>> your filesystem implements FUSE_BMAP and attaches via fuseblk (aka
>> ntfs3g).
>
>Yikes.  This is just such an amazingly bad idea.

And even if a fuse does not support swapfiles, "problems in computer
science can be solved by another level of indirection". Not that they
should - but this sequence succeeds already:

mount -t sshfs root@localhost:/ /mnt
losetup /dev/loop7 /mnt/swapfile
swapon /dev/loop7

