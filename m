Return-Path: <linux-ext4+bounces-12105-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC28C983A6
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 17:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A253A3532
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A79933345E;
	Mon,  1 Dec 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="RCD5Esig"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F9B33343E
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606269; cv=none; b=X1tpyV15OQ0ZxKwBKPUNSsZvCvNJD7VXEjYYEwSG0/2DeAy0x5xnmYWXl9I/9iWkRpxzopicH16XjUHNlDFjooXRG9x6r2d1tU+8HH8z2PeOqV+NO+17xU40ML+zAZOVWadvCWjKseqt4YnhZWhZOHqfNxMvI4jNrDiAZb/4Q5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606269; c=relaxed/simple;
	bh=lN+ZCD7YN5daSgQPMDcH/f5fzllgVQmW/Lkh1NyXnic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHvy7KXqF9YvwyCdRr4KgCqMosKZ54vD0wz6uoIV2Yg/QoptMl35SQK/XKw/Qv5nBeyNmK677ZGTMJBd+ZnYEWSuxyBa+mpfV19wrd7P2vdr210E57AEqFp1FkZIurvmYtgZbtrvW6yC3Y/s2FPSfVEcNZLrHCf9EbmraIhjloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=RCD5Esig; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B1GNs5t008159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 11:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764606236; bh=Dcr+pf7z81l5mbJZ6g15wYFJJtxRb9I1xHhuv0xSw88=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=RCD5EsigaI0CXiPZ306SE37ss7MaWAQ0Et41pje1DRCu6973/3gcac6X2yOagXkrO
	 Cbg3VX5WSYIyF59rdS/YvFpD6O6eVkfhJ/HZpE/6M8YrIUV106I0tT8XmFm+qYesA7
	 21YlMFB19eV/u8vmtDX4CSI4UQ50/zROBZNkkiqEXJJox35/QktAoXI6Lshm2y+bLn
	 3S8IluzZL99Nv3JyAofUGWgizgrZU5ahqnMp0IBKhOsJwrBfANaOu7edfReVP5oUv7
	 baAYxHUfsw9REm+nPvnQ4nzcSaA98O9GY5wwW6ezkr2gk5bpZ4JyW7cVBjEB9lsxwB
	 //NL89nErjCgg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F21ED2E00DB; Mon, 01 Dec 2025 11:23:53 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH] ext4: align max orphan file size with e2fsprogs limit
Date: Mon,  1 Dec 2025 11:23:45 -0500
Message-ID: <176455640536.1349182.9500059559864469564.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120134233.2994147-1-libaokun@huaweicloud.com>
References: <20251120134233.2994147-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 20 Nov 2025 21:42:33 +0800, libaokun@huaweicloud.com wrote:
> Kernel commit 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
> limits the maximum supported orphan file size to 8 << 20.
> 
> However, in e2fsprogs, the orphan file size is set to 32–512 filesystem
> blocks when creating a filesystem.
> 
> With 64k block size, formatting an ext4 fs >32G gives an orphan file bigger
> than the kernel allows, so mount prints an error and fails:
> 
> [...]

Applied, thanks!

[1/1] ext4: align max orphan file size with e2fsprogs limit
      commit: 7c11c56eb32eae96893eebafdbe3decadefe88ad

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

