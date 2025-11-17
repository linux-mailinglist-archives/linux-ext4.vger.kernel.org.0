Return-Path: <linux-ext4+bounces-11876-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26359C65EA8
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 20:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D42E3644E0
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 19:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1581A336EDC;
	Mon, 17 Nov 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QvMzzhWx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5432E696
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406851; cv=none; b=l/5WWqO/JBg0DIB5wbEttxAamnbPTEYm9CGdTv0329LEAxurB9JtPiqA4MIHpgk/MtMApOXrsAK4aQ5T1INbjCiuViDsT1jE5tpfvYuPIJjLkwTs6IqjGOAIf/cZO6vClFCJ2OygAgSmLFI0jXz7a6zGCUWTCcp5ARyRGbb5Ca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406851; c=relaxed/simple;
	bh=B02B9ymLx19oRLrQT5kh3POoHu0l16laojhtdcTaFPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsRwuUz/3hh8ctgpSokHRtdivCjQ1fjJVrfzoiyMLcAO8RSjuZhG7Ay/cy/4bhUua5uuWl/2nC/YW1NfQIZbPDRnS+kQ6CYFVZsanwYqNEyQbdMrtgZkxJSfPbAshQt9YePCGHxNbXj3MdaC97hNwtRQKDfolBfVcHy3znCtltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QvMzzhWx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-69.bstnma.fios.verizon.net [173.48.114.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AHJDrTP020656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 14:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763406835; bh=FvF39uO27WST1oHMFcr7ExrW1V0RrEJlw/MA6ky4LtQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=QvMzzhWxn9Nfg+veCxgrC+/T/z8NtchxqMSrGZvrhDIKHqW30aVenoEKY/47pa/t6
	 QqGYYtR4IXLH2+SUSFMEz4XRA9RncpXAmctjheKJrhkyIm8mQ2Rd9hTabumpRTd8iG
	 Lzj0JVA0rIoJmX7YhyGqqr4UYfLkiUaoXOhOTXpla2bQikduaJj9EiDHNRJnoHb49P
	 Y47Qo8LaNjxYDk4AKwMBByxRw8fkM0glDm+72ErxMBoImULVP8vvd3WL36yAurPB1S
	 E/5mz9v0Rfw1o3Q9U8BYHtyXrGOWYD1gtt2HcRuI7bCDverIX0GCoLAmJsb6aYaOLm
	 MhA0XgwT5275A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 50D432E00E2; Mon, 17 Nov 2025 14:13:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz
Subject: Re: [PATCH v2] jbd2: fix the inconsistency between checksum and data in memory for journal sb
Date: Mon, 17 Nov 2025 14:13:39 -0500
Message-ID: <176340680645.138575.8673763881243527874.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103010123.3753631-1-yebin@huaweicloud.com>
References: <20251103010123.3753631-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 03 Nov 2025 09:01:23 +0800, Ye Bin wrote:
> Copying the file system while it is mounted as read-only results in
> a mount failure:
> [~]# mkfs.ext4 -F /dev/sdc
> [~]# mount /dev/sdc -o ro /mnt/test
> [~]# dd if=/dev/sdc of=/dev/sda bs=1M
> [~]# mount /dev/sda /mnt/test1
> [ 1094.849826] JBD2: journal checksum error
> [ 1094.850927] EXT4-fs (sda): Could not load journal inode
> mount: mount /dev/sda on /mnt/test1 failed: Bad message
> 
> [...]

Applied, thanks!

[1/1] jbd2: fix the inconsistency between checksum and data in memory for journal sb
      commit: 5884132428856bb49b60b70c72fb43515190ee7b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

